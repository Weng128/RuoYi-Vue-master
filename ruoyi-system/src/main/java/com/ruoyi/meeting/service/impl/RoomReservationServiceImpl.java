package com.ruoyi.meeting.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.meeting.mapper.RoomReservationMapper;
import com.ruoyi.meeting.mapper.ReservationRequestDetailMapper;
import com.ruoyi.meeting.domain.RoomReservation;
import com.ruoyi.meeting.service.IRoomReservationService;

/**
 * 【请填写功能名称】Service业务层处理
 * 
 * @author wzx
 * @date 2025-09-11
 */
@Service
public class RoomReservationServiceImpl implements IRoomReservationService 
{
    @Autowired
    private RoomReservationMapper roomReservationMapper;
    @Autowired
    private ReservationRequestDetailMapper reservationRequestDetailMapper;

    /**
     * 查询【请填写功能名称】
     * 
     * @param reserveId 【请填写功能名称】主键
     * @return 【请填写功能名称】
     */
    @Override
    public RoomReservation selectRoomReservationByReserveId(Long reserveId)
    {
        return roomReservationMapper.selectRoomReservationByReserveId(reserveId);
    }

    /**
     * 查询【请填写功能名称】列表
     * 
     * @param roomReservation 【请填写功能名称】
     * @return 【请填写功能名称】
     */
    @Override
    public List<RoomReservation> selectRoomReservationList(RoomReservation roomReservation)
    {
        return roomReservationMapper.selectRoomReservationList(roomReservation);
    }

    /**
     * 新增【请填写功能名称】
     * 
     * @param roomReservation 【请填写功能名称】
     * @return 结果
     */
    @Override
    public int insertRoomReservation(RoomReservation roomReservation)
    {
        return roomReservationMapper.insertRoomReservation(roomReservation);
    }

    /**
     * 修改【请填写功能名称】
     * 
     * @param roomReservation 【请填写功能名称】
     * @return 结果
     */
    @Override
    public int updateRoomReservation(RoomReservation roomReservation)
    {
        return roomReservationMapper.updateRoomReservation(roomReservation);
    }

    /**
     * 批量删除【请填写功能名称】
     * 
     * @param reserveIds 需要删除的【请填写功能名称】主键
     * @return 结果
     */
    @Override
    public int deleteRoomReservationByReserveIds(Long[] reserveIds)
    {
        return roomReservationMapper.deleteRoomReservationByReserveIds(reserveIds);
    }

    /**
     * 删除【请填写功能名称】信息
     * 
     * @param reserveId 【请填写功能名称】主键
     * @return 结果
     */
    @Override
    public int deleteRoomReservationByReserveId(Long reserveId)
    {
        return roomReservationMapper.deleteRoomReservationByReserveId(reserveId);
    }

    private void validate(Date startTime, Date endTime) {
        if (startTime == null || endTime == null) throw new ServiceException("时间不能为空");
        if (!endTime.after(startTime)) throw new ServiceException("结束时间必须晚于开始时间");
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void batchReserve(Long adminId, List<String> roomIds, Date startTime, Date endTime) {
        validate(startTime, endTime);
        if (roomIds == null || roomIds.isEmpty()) throw new ServiceException("会议室不能为空");
        int c1 = roomReservationMapper.countConflicts(roomIds, startTime, endTime, null);
        int c2 = reservationRequestDetailMapper.countApprovedConflicts(roomIds, startTime, endTime, null);
        if (c1 + c2 > 0) throw new ServiceException("存在冲突，预留失败");
        List<RoomReservation> list = new ArrayList<>();
        for (String rid : roomIds) {
            RoomReservation r = new RoomReservation();
            r.setAdminId(adminId);
            r.setRoomId(rid);
            r.setStartTime(startTime);
            r.setEndTime(endTime);
            list.add(r);
        }
        roomReservationMapper.batchInsert(list);
    }
}
