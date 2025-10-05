package com.ruoyi.meeting.domain.dto;

import java.util.Date;
import java.util.List;
import com.fasterxml.jackson.annotation.JsonFormat;

public class SubmitRequestDTO {
    private List<String> roomIds; // 旧：统一时间段
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm")
    private Date startTime;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm")
    private Date endTime;
    private String remark;
    // 新：每个房间独立时间段，若非空优先生效
    private List<RoomTimeSlotDTO> slots;

    public List<String> getRoomIds() { return roomIds; }
    public void setRoomIds(List<String> roomIds) { this.roomIds = roomIds; }
    public Date getStartTime() { return startTime; }
    public void setStartTime(Date startTime) { this.startTime = startTime; }
    public Date getEndTime() { return endTime; }
    public void setEndTime(Date endTime) { this.endTime = endTime; }
    public String getRemark() { return remark; }
    public void setRemark(String remark) { this.remark = remark; }
    public List<RoomTimeSlotDTO> getSlots() { return slots; }
    public void setSlots(List<RoomTimeSlotDTO> slots) { this.slots = slots; }
}
