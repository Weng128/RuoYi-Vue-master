package com.ruoyi.meeting.service.impl;

import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.meeting.mapper.MeetingRoomMapper;
import com.ruoyi.meeting.domain.MeetingRoom;
import com.ruoyi.meeting.service.IMeetingRoomService;

/**
 * 会议室信息 Service 业务层处理
 *
 * @author wzx
 * @date 2025-09-11
 */
@Service
public class MeetingRoomServiceImpl implements IMeetingRoomService 
{
    @Autowired
    private MeetingRoomMapper meetingRoomMapper;

    /** 按ID查询会议室 */
    @Override
    public MeetingRoom selectMeetingRoomByRoomId(String roomId)
    {
        return meetingRoomMapper.selectMeetingRoomByRoomId(roomId);
    }

    /** 查询会议室列表 */
    @Override
    public List<MeetingRoom> selectMeetingRoomList(MeetingRoom meetingRoom)
    {
        return meetingRoomMapper.selectMeetingRoomList(meetingRoom);
    }

    /** 新增会议室 */
    @Override
    public int insertMeetingRoom(MeetingRoom meetingRoom)
    {
        return meetingRoomMapper.insertMeetingRoom(meetingRoom);
    }

    /** 修改会议室 */
    @Override
    public int updateMeetingRoom(MeetingRoom meetingRoom)
    {
        return meetingRoomMapper.updateMeetingRoom(meetingRoom);
    }

    /** 批量删除会议室 */
    @Override
    public int deleteMeetingRoomByRoomIds(String[] roomIds)
    {
        return meetingRoomMapper.deleteMeetingRoomByRoomIds(roomIds);
    }

    /** 删除单个会议室 */
    @Override
    public int deleteMeetingRoomByRoomId(String roomId)
    {
        return meetingRoomMapper.deleteMeetingRoomByRoomId(roomId);
    }

    /** 查询指定时间段空闲会议室 */
    @Override
    public List<MeetingRoom> selectFreeRooms(Date startTime, Date endTime)
    {
        return meetingRoomMapper.selectFreeRooms(startTime, endTime);
    }
}
