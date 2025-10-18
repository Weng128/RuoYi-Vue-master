package com.ruoyi.meeting.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 会议室借用申请明细对象 reservation_request_detail
 */
public class ReservationRequestDetail extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 明细ID */
    private Long detailId;
    /** 申请ID */
    @Excel(name = "申请ID")
    private Long requestId;
    /** 会议室编号 */
    @Excel(name = "会议室")
    private String roomId;
    /** 开始时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm")
    @Excel(name = "开始时间", width = 30, dateFormat = "yyyy-MM-dd HH:mm")
    private Date startTime;
    /** 结束时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm")
    @Excel(name = "结束时间", width = 30, dateFormat = "yyyy-MM-dd HH:mm")
    private Date endTime;
    /** 审批状态（来自 reservation_request.status） */
    @Excel(name = "审批状态")
    private String status;
    /** 申请人ID */
    private Long applicantId;
    /** 申请人姓名 */
    @Excel(name = "申请人")
    private String applicantName;
    /** 审批人姓名 */
    @Excel(name = "审批人")
    private String adminName;

    public void setDetailId(Long detailId) 
    {
        this.detailId = detailId;
    }

    public Long getDetailId() 
    {
        return detailId;
    }

    public void setRequestId(Long requestId) 
    {
        this.requestId = requestId;
    }

    public Long getRequestId() 
    {
        return requestId;
    }

    public void setRoomId(String roomId) 
    {
        this.roomId = roomId;
    }

    public String getRoomId() 
    {
        return roomId;
    }

    public void setStartTime(Date startTime) 
    {
        this.startTime = startTime;
    }

    public Date getStartTime() 
    {
        return startTime;
    }

    public void setEndTime(Date endTime) 
    {
        this.endTime = endTime;
    }

    public Date getEndTime() 
    {
        return endTime;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getApplicantName() {
        return applicantName;
    }

    public void setApplicantName(String applicantName) {
        this.applicantName = applicantName;
    }

    public Long getApplicantId() {
        return applicantId;
    }

    public void setApplicantId(Long applicantId) {
        this.applicantId = applicantId;
    }

    public String getAdminName() {
        return adminName;
    }

    public void setAdminName(String adminName) {
        this.adminName = adminName;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("detailId", getDetailId())
            .append("requestId", getRequestId())
            .append("roomId", getRoomId())
            .append("startTime", getStartTime())
            .append("endTime", getEndTime())
            .append("status", getStatus())
            .append("applicantId", getApplicantId())
            .append("applicantName", getApplicantName())
            .append("adminName", getAdminName())
            .toString();
    }
}
