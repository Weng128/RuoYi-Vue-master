package com.ruoyi.meeting.mapper;

import java.util.Date;
import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.ruoyi.meeting.domain.MeetingRoom;

/**
 * 会议室 Mapper接口
 *
 * @author wzx
 * @date 2025-09-11
 */
public interface MeetingRoomMapper 
{
    /**
     * 按ID查询会议室
     *
     * @param roomId 会议室主键
     * @return 会议室
     */
    public MeetingRoom selectMeetingRoomByRoomId(String roomId);

    /**
     * 查询会议室列表
     *
     * @param meetingRoom 会议室
     * @return 会议室集合
     */
    public List<MeetingRoom> selectMeetingRoomList(MeetingRoom meetingRoom);

    /**
     * 查询时间段内空闲会议室
     *
     * @param startTime 查询开始时间
     * @param endTime 查询结束时间
     * @return 空闲会议室列表
     */
    public List<MeetingRoom> selectFreeRooms(@Param("startTime") Date startTime, @Param("endTime") Date endTime);

    /**
     * 新增会议室
     *
     * @param meetingRoom 会议室
     * @return 结果
     */
    public int insertMeetingRoom(MeetingRoom meetingRoom);

    /**
     * 修改会议室
     *
     * @param meetingRoom 会议室
     * @return 结果
     */
    public int updateMeetingRoom(MeetingRoom meetingRoom);

    /**
     * 删除单个会议室
     *
     * @param roomId 会议室主键
     * @return 结果
     */
    public int deleteMeetingRoomByRoomId(String roomId);

    /**
     * 批量删除会议室
     *
     * @param roomIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteMeetingRoomByRoomIds(String[] roomIds);
}
