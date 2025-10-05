package com.ruoyi.meeting.mapper;

import java.util.Date;
import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.ruoyi.meeting.domain.RoomReservation;
import com.ruoyi.meeting.domain.dto.ConflictDetailDTO;

/**
 * 会议室预约 Mapper接口
 */
public interface RoomReservationMapper 
{
    /** 按ID查询预约 */
    public RoomReservation selectRoomReservationByReserveId(Long reserveId);

    /** 查询预约列表 */
    public List<RoomReservation> selectRoomReservationList(RoomReservation roomReservation);

    /** 新增预约 */
    public int insertRoomReservation(RoomReservation roomReservation);

    /** 修改预约 */
    public int updateRoomReservation(RoomReservation roomReservation);

    /** 删除单个预约 */
    public int deleteRoomReservationByReserveId(Long reserveId);

    /** 批量删除预约 */
    public int deleteRoomReservationByReserveIds(Long[] reserveIds);

    /** 批量新增预约 */
    public int batchInsert(@Param("list") List<RoomReservation> list);

    /** 统计冲突记录数 */
    public int countConflicts(@Param("roomIds") List<String> roomIds, @Param("startTime") Date startTime, @Param("endTime") Date endTime, @Param("excludeId") Long excludeId);

    /** 冲突详情列表（预约） */
    List<ConflictDetailDTO> listConflictDetails(@Param("roomId") String roomId, @Param("startTime") Date startTime, @Param("endTime") Date endTime, @Param("excludeId") Long excludeId);
}
