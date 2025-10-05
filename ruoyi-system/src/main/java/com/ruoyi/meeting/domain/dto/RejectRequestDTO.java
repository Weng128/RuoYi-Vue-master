package com.ruoyi.meeting.domain.dto;

public class RejectRequestDTO {
    private Long requestId;
    private String decisionRemark;
    public Long getRequestId() { return requestId; }
    public void setRequestId(Long requestId) { this.requestId = requestId; }
    public String getDecisionRemark() { return decisionRemark; }
    public void setDecisionRemark(String decisionRemark) { this.decisionRemark = decisionRemark; }
}

