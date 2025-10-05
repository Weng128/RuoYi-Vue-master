package com.ruoyi.meeting.service;

import java.util.Date;
import java.util.List;
import com.ruoyi.meeting.domain.ReservationRequest;
import com.ruoyi.meeting.domain.ReservationRequestDetail;
import com.ruoyi.meeting.domain.dto.RoomTimeSlotDTO;
import com.ruoyi.meeting.domain.dto.ConflictDetailDTO;

/**
 * 会议室申请服务接口
 * 提供申请提交、审批、拒绝、冲突检测等能力。
 */
public interface IReservationRequestService 
{
    /** 按申请ID查询 */
    public ReservationRequest selectReservationRequestByRequestId(Long requestId);
    /** 查询申请列表 */
    public List<ReservationRequest> selectReservationRequestList(ReservationRequest reservationRequest);
    /** 新增申请（底层基础 CRUD，通常使用业务 submit 方法） */
    public int insertReservationRequest(ReservationRequest reservationRequest);
    /** 修改申请（基础 CRUD） */
    public int updateReservationRequest(ReservationRequest reservationRequest);
    /** 批量删除申请 */
    public int deleteReservationRequestByRequestIds(Long[] requestIds);
    /** 删除单个申请 */
    public int deleteReservationRequestByRequestId(Long requestId);
    /** 提交申请（统一时间段） */
    Long submitRequest(Long applicantId, List<String> roomIds, Date startTime, Date endTime, String remark);
    /** 提交申请（不同房间独立时段） */
    Long submitRequestWithSlots(Long applicantId, List<RoomTimeSlotDTO> slots, String remark);
    /** 审批通过（统一时间段，可调整） */
    void approveRequest(Long requestId, Long adminId, List<String> roomIds, Date startTime, Date endTime, String decisionRemark);
    /** 审批通过（独立时段） */
    void approveRequestWithSlots(Long requestId, Long adminId, List<RoomTimeSlotDTO> slots, String decisionRemark);
    /** 拒绝申请 */
    void rejectRequest(Long requestId, Long adminId, String decisionRemark);
    /** 查询申请明细列表 */
    List<ReservationRequestDetail> listDetails(Long requestId);
    /** 冲突检测（统一时间段） */
    List<ConflictDetailDTO> detectConflicts(List<String> roomIds, Date startTime, Date endTime, Long excludeRequestId);
    /** 冲突检测（独立时段） */
    List<ConflictDetailDTO> detectConflictsSlots(List<RoomTimeSlotDTO> slots, Long excludeRequestId);
}
