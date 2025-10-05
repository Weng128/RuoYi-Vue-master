package com.ruoyi.meeting.service;

import java.util.Date;
import java.util.List;
import com.ruoyi.meeting.domain.RoomReservation;

/**
 * 会议室预约 Service接口
 *
 * @author wzx
 * @date 2025-09-11
 */
public interface IRoomReservationService 
{
    /** 按ID查询预约 */
    public RoomReservation selectRoomReservationByReserveId(Long reserveId);

    /** 查询预约列表 */
    public List<RoomReservation> selectRoomReservationList(RoomReservation roomReservation);

    /** 新增预约 */
    public int insertRoomReservation(RoomReservation roomReservation);

    /** 修改预约 */
    public int updateRoomReservation(RoomReservation roomReservation);

    /** 批量删除预约 */
    public int deleteRoomReservationByReserveIds(Long[] reserveIds);

    /** 删除单个预约 */
    public int deleteRoomReservationByReserveId(Long reserveId);

    /** 批量预留（管理员） */
    void batchReserve(Long adminId, List<String> roomIds, Date startTime, Date endTime);
}
