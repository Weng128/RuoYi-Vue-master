package com.ruoyi.meeting.domain.dto;

import java.util.Date;
import java.util.List;
import com.fasterxml.jackson.annotation.JsonFormat;

public class ApproveRequestDTO {
    private Long requestId;
    private List<String> roomIds; // 若提供统一时段
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm")
    private Date startTime;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm")
    private Date endTime;
    private String decisionRemark;
    private List<RoomTimeSlotDTO> slots; // 新增：独立时段
    public Long getRequestId() { return requestId; }
    public void setRequestId(Long requestId) { this.requestId = requestId; }
    public List<String> getRoomIds() { return roomIds; }
    public void setRoomIds(List<String> roomIds) { this.roomIds = roomIds; }
    public Date getStartTime() { return startTime; }
    public void setStartTime(Date startTime) { this.startTime = startTime; }
    public Date getEndTime() { return endTime; }
    public void setEndTime(Date endTime) { this.endTime = endTime; }
    public String getDecisionRemark() { return decisionRemark; }
    public void setDecisionRemark(String decisionRemark) { this.decisionRemark = decisionRemark; }
    public List<RoomTimeSlotDTO> getSlots() { return slots; }
    public void setSlots(List<RoomTimeSlotDTO> slots) { this.slots = slots; }
}
