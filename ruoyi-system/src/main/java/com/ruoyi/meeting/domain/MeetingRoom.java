package com.ruoyi.meeting.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 会议室实体 meeting_room
 *
 * @author wzx
 * @date 2025-09-11
 */
public class MeetingRoom extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 会议室编号，如X31524 */
    private String roomId;

    /** 容量 */
    @Excel(name = "容量")
    private Long capacity;

    /** 位置 */
    @Excel(name = "位置")
    private String location;

    public void setRoomId(String roomId) 
    {
        this.roomId = roomId;
    }

    public String getRoomId() 
    {
        return roomId;
    }

    public void setCapacity(Long capacity) 
    {
        this.capacity = capacity;
    }

    public Long getCapacity() 
    {
        return capacity;
    }

    public void setLocation(String location) 
    {
        this.location = location;
    }

    public String getLocation() 
    {
        return location;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("roomId", getRoomId())
            .append("capacity", getCapacity())
            .append("location", getLocation())
            .toString();
    }
}
