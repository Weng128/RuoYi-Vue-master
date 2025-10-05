package com.ruoyi.meeting.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.meeting.domain.ReservationRequest;
import com.ruoyi.meeting.domain.ReservationRequestDetail;
import com.ruoyi.meeting.domain.dto.ConflictDetailDTO;
import com.ruoyi.meeting.domain.dto.RoomTimeSlotDTO;
import com.ruoyi.meeting.mapper.ReservationRequestDetailMapper;
import com.ruoyi.meeting.mapper.ReservationRequestMapper;
import com.ruoyi.meeting.mapper.RoomReservationMapper;
import com.ruoyi.meeting.service.IReservationRequestService;

/**
 * 会议室申请 Service 业务层处理
 */
@Service
public class ReservationRequestServiceImpl implements IReservationRequestService 
{
    @Autowired
    private ReservationRequestMapper reservationRequestMapper;
    @Autowired
    private ReservationRequestDetailMapper reservationRequestDetailMapper;
    @Autowired
    private RoomReservationMapper roomReservationMapper;

    /** 按ID查询申请 */
    @Override
    public ReservationRequest selectReservationRequestByRequestId(Long requestId)
    {
        return reservationRequestMapper.selectReservationRequestByRequestId(requestId);
    }

    /** 查询申请列表 */
    @Override
    public List<ReservationRequest> selectReservationRequestList(ReservationRequest reservationRequest)
    {
        return reservationRequestMapper.selectReservationRequestList(reservationRequest);
    }

    /** 新增申请（基础） */
    @Override
    public int insertReservationRequest(ReservationRequest reservationRequest)
    {
        return reservationRequestMapper.insertReservationRequest(reservationRequest);
    }

    /** 修改申请（基础） */
    @Override
    public int updateReservationRequest(ReservationRequest reservationRequest)
    {
        return reservationRequestMapper.updateReservationRequest(reservationRequest);
    }

    /** 批量删除申请 */
    @Override
    public int deleteReservationRequestByRequestIds(Long[] requestIds)
    {
        return reservationRequestMapper.deleteReservationRequestByRequestIds(requestIds);
    }

    /** 删除单个申请 */
    @Override
    public int deleteReservationRequestByRequestId(Long requestId)
    {
        return reservationRequestMapper.deleteReservationRequestByRequestId(requestId);
    }

    // ===================== 通用校验与冲突处理 =====================
    private void validateTime(Date startTime, Date endTime) {
        if (startTime == null || endTime == null) {
            throw new ServiceException("时间不能为空");
        }
        if (!endTime.after(startTime)) {
            throw new ServiceException("结束时间必须晚于开始时间");
        }
        // 跨度限制（可调整）
        if (endTime.getTime() - startTime.getTime() > 1000L * 60 * 60 * 24 * 7) {
            throw new ServiceException("时间跨度不能超过7天");
        }
    }

    private void validateSlots(List<RoomTimeSlotDTO> slots) {
        if (slots == null || slots.isEmpty()) {
            throw new ServiceException("时段列表不能为空");
        }
        // 基本校验 + 同一房间内部自相交检测
        Map<String, List<RoomTimeSlotDTO>> byRoom = new HashMap<>();
        for (RoomTimeSlotDTO s : slots) {
            if (s.getRoomId() == null || s.getRoomId().trim().isEmpty()) {
                throw new ServiceException("房间ID不能为空");
            }
            validateTime(s.getStartTime(), s.getEndTime());
            byRoom.computeIfAbsent(s.getRoomId(), k -> new java.util.ArrayList<>()).add(s);
        }
        for (Map.Entry<String, List<RoomTimeSlotDTO>> e : byRoom.entrySet()) {
            List<RoomTimeSlotDTO> list = e.getValue();
            list.sort((a,b)-> a.getStartTime().compareTo(b.getStartTime()));
            for (int i=1;i<list.size();i++) {
                RoomTimeSlotDTO prev = list.get(i-1);
                RoomTimeSlotDTO cur = list.get(i);
                if (prev.getEndTime().after(cur.getStartTime())) {
                    throw new ServiceException("房间"+ e.getKey()+" 的时段互相重叠");
                }
            }
        }
    }

    private List<ConflictDetailDTO> detectConflictsInternal(List<String> roomIds, Date startTime, Date endTime, Long excludeRequestId) {
        List<ConflictDetailDTO> result = new java.util.ArrayList<>();
        if (roomIds == null || roomIds.isEmpty()) return result;
        for (String rid : roomIds) {
            // 已审批申请冲突
            List<ConflictDetailDTO> a = reservationRequestDetailMapper.listApprovedConflictDetails(rid, startTime, endTime, excludeRequestId);
            if (a != null) result.addAll(a);
            // 固定预约冲突
            try {
                // 需要新增 mapper 方法 listConflictDetails
                List<ConflictDetailDTO> b = roomReservationMapper.listConflictDetails(rid, startTime, endTime, null);
                if (b != null) result.addAll(b);
            } catch (Throwable ignore) { /* 若方法尚未实现，保持兼容 */ }
        }
        return result;
    }

    private List<ConflictDetailDTO> detectConflictsSlotsInternal(List<RoomTimeSlotDTO> slots, Long excludeRequestId) {
        List<ConflictDetailDTO> result = new java.util.ArrayList<>();
        for (RoomTimeSlotDTO s : slots) {
            result.addAll(detectConflictsInternal(java.util.Collections.singletonList(s.getRoomId()), s.getStartTime(), s.getEndTime(), excludeRequestId));
        }
        return result;
    }

    private void raiseIfConflicts(List<ConflictDetailDTO> conflicts) {
        if (conflicts == null || conflicts.isEmpty()) return;
        String msg = buildConflictMessage(conflicts);
        throw new ServiceException(msg);
    }

    private String buildConflictMessage(List<ConflictDetailDTO> conflicts) {
        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
        String sample = conflicts.stream().limit(3).map(c -> {
            String idPart = c.getSourceType() != null && c.getSourceType().equals("REQUEST") ? (c.getRequestId()==null?"":"#"+c.getRequestId()) : (c.getReserveId()==null?"":"#"+c.getReserveId());
            return c.getRoomId()+"("+sdf.format(c.getStartTime())+"~"+sdf.format(c.getEndTime())+","+c.getSourceType()+idPart+")";
        }).collect(Collectors.joining("; "));
        return "存在冲突(共"+conflicts.size()+"条)："+sample;
    }

    // ===================== 原统一时段接口 =====================
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Long submitRequest(Long applicantId, List<String> roomIds, Date startTime, Date endTime, String remark) {
        validateTime(startTime, endTime);
        List<ConflictDetailDTO> conflicts = detectConflictsInternal(roomIds, startTime, endTime, null);
        raiseIfConflicts(conflicts);
        ReservationRequest request = new ReservationRequest();
        request.setApplicantId(applicantId);
        request.setStatus(ReservationRequest.STATUS_PENDING);
        request.setRemark(remark);
        reservationRequestMapper.insertReservationRequest(request);
        Long requestId = request.getRequestId();
        List<ReservationRequestDetail> details = new ArrayList<>();
        for (String rid : roomIds) {
            ReservationRequestDetail d = new ReservationRequestDetail();
            d.setRequestId(requestId);
            d.setRoomId(rid);
            d.setStartTime(startTime);
            d.setEndTime(endTime);
            details.add(d);
        }
        reservationRequestDetailMapper.batchInsert(details);
        return requestId;
    }

    // ===================== 新增：独立时段提交 =====================
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Long submitRequestWithSlots(Long applicantId, List<RoomTimeSlotDTO> slots, String remark) {
        validateSlots(slots);
        List<ConflictDetailDTO> conflicts = detectConflictsSlotsInternal(slots, null);
        raiseIfConflicts(conflicts);
        ReservationRequest request = new ReservationRequest();
        request.setApplicantId(applicantId);
        request.setStatus(ReservationRequest.STATUS_PENDING);
        request.setRemark(remark);
        reservationRequestMapper.insertReservationRequest(request);
        Long requestId = request.getRequestId();
        List<ReservationRequestDetail> details = new ArrayList<>();
        for (RoomTimeSlotDTO s : slots) {
            ReservationRequestDetail d = new ReservationRequestDetail();
            d.setRequestId(requestId);
            d.setRoomId(s.getRoomId());
            d.setStartTime(s.getStartTime());
            d.setEndTime(s.getEndTime());
            details.add(d);
        }
        reservationRequestDetailMapper.batchInsert(details);
        return requestId;
    }

    // ===================== 审批 =====================
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void approveRequest(Long requestId, Long adminId, List<String> roomIds, Date startTime, Date endTime, String decisionRemark) {
        ReservationRequest db = reservationRequestMapper.selectReservationRequestByRequestId(requestId);
        if (db == null) throw new ServiceException("申请不存在");
        if (!ReservationRequest.STATUS_PENDING.equals(db.getStatus())) {
            throw new ServiceException("仅待审批状态可操作");
        }
        validateTime(startTime, endTime);
        List<ConflictDetailDTO> conflicts = detectConflictsInternal(roomIds, startTime, endTime, requestId);
        raiseIfConflicts(conflicts);
        // 删除旧明细
        List<ReservationRequestDetail> old = reservationRequestDetailMapper.selectByRequestId(requestId);
        if (old != null && !old.isEmpty()) {
            Long[] ids = old.stream().map(ReservationRequestDetail::getDetailId).toArray(Long[]::new);
            reservationRequestDetailMapper.deleteReservationRequestDetailByDetailIds(ids);
        }
        List<ReservationRequestDetail> newDetails = new ArrayList<>();
        for (String rid : roomIds) {
            ReservationRequestDetail d = new ReservationRequestDetail();
            d.setRequestId(requestId);
            d.setRoomId(rid);
            d.setStartTime(startTime);
            d.setEndTime(endTime);
            newDetails.add(d);
        }
        reservationRequestDetailMapper.batchInsert(newDetails);
        reservationRequestMapper.updateApproval(requestId, ReservationRequest.STATUS_APPROVED, adminId, decisionRemark);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void approveRequestWithSlots(Long requestId, Long adminId, List<RoomTimeSlotDTO> slots, String decisionRemark) {
        ReservationRequest db = reservationRequestMapper.selectReservationRequestByRequestId(requestId);
        if (db == null) throw new ServiceException("申请不存在");
        if (!ReservationRequest.STATUS_PENDING.equals(db.getStatus())) {
            throw new ServiceException("仅待审批状态可操作");
        }
        validateSlots(slots);
        List<ConflictDetailDTO> conflicts = detectConflictsSlotsInternal(slots, requestId);
        raiseIfConflicts(conflicts);
        List<ReservationRequestDetail> old = reservationRequestDetailMapper.selectByRequestId(requestId);
        if (old != null && !old.isEmpty()) {
            Long[] ids = old.stream().map(ReservationRequestDetail::getDetailId).toArray(Long[]::new);
            reservationRequestDetailMapper.deleteReservationRequestDetailByDetailIds(ids);
        }
        List<ReservationRequestDetail> newDetails = new ArrayList<>();
        for (RoomTimeSlotDTO s : slots) {
            ReservationRequestDetail d = new ReservationRequestDetail();
            d.setRequestId(requestId);
            d.setRoomId(s.getRoomId());
            d.setStartTime(s.getStartTime());
            d.setEndTime(s.getEndTime());
            newDetails.add(d);
        }
        reservationRequestDetailMapper.batchInsert(newDetails);
        reservationRequestMapper.updateApproval(requestId, ReservationRequest.STATUS_APPROVED, adminId, decisionRemark);
    }

    // ===================== 拒绝 =====================
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void rejectRequest(Long requestId, Long adminId, String decisionRemark) {
        ReservationRequest db = reservationRequestMapper.selectReservationRequestByRequestId(requestId);
        if (db == null) throw new ServiceException("申请不存在");
        if (!ReservationRequest.STATUS_PENDING.equals(db.getStatus())) {
            throw new ServiceException("仅待审批状态可操作");
        }
        reservationRequestMapper.updateStatus(requestId, ReservationRequest.STATUS_REJECTED, adminId, decisionRemark);
    }

    // ===================== 查询明细 =====================
    @Override
    public List<ReservationRequestDetail> listDetails(Long requestId) {
        return reservationRequestDetailMapper.selectByRequestId(requestId);
    }

    // ===================== 冲突检测公开接口 =====================
    @Override
    public List<ConflictDetailDTO> detectConflicts(List<String> roomIds, Date startTime, Date endTime, Long excludeRequestId) {
        if (roomIds == null || roomIds.isEmpty()) return java.util.Collections.emptyList();
        validateTime(startTime, endTime);
        return detectConflictsInternal(roomIds, startTime, endTime, excludeRequestId);
    }

    @Override
    public List<ConflictDetailDTO> detectConflictsSlots(List<RoomTimeSlotDTO> slots, Long excludeRequestId) {
        if (slots == null || slots.isEmpty()) return java.util.Collections.emptyList();
        validateSlots(slots);
        return detectConflictsSlotsInternal(slots, excludeRequestId);
    }
}
