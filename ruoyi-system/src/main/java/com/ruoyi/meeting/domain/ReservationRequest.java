package com.ruoyi.meeting.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 会议室借用申请对象 reservation_request
 */
public class ReservationRequest extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 状态：待审批 */
    public static final String STATUS_PENDING = "PENDING";
    /** 状态：已通过 */
    public static final String STATUS_APPROVED = "APPROVED";
    /** 状态：已拒绝 */
    public static final String STATUS_REJECTED = "REJECTED";

    /** 申请ID */
    private Long requestId;
    /** 申请人ID */
    @Excel(name = "申请人")
    private Long applicantId;
    /** 状态 */
    @Excel(name = "状态")
    private String status;
    /** 审批人ID */
    @Excel(name = "审批人")
    private Long adminId;
    /** 审批时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm")
    @Excel(name = "审批时间", width = 30, dateFormat = "yyyy-MM-dd HH:mm")
    private Date decisionTime;
    /** 审批备注 */
    @Excel(name = "审批备注")
    private String decisionRemark;
    /** 申请人姓名 */
    private String applicantName;
    /** 审批人姓名 */
    private String adminName;

    @Override
    public String getRemark()
    {
        return super.getRemark();
    }

    @Override
    public void setRemark(String remark)
    {
        super.setRemark(remark);
    }

    public void setRequestId(Long requestId) 
    {
        this.requestId = requestId;
    }

    public Long getRequestId() 
    {
        return requestId;
    }

    public void setApplicantId(Long applicantId) 
    {
        this.applicantId = applicantId;
    }

    public Long getApplicantId() 
    {
        return applicantId;
    }

    public void setStatus(String status) 
    {
        this.status = status;
    }

    public String getStatus() 
    {
        return status;
    }

    public void setAdminId(Long adminId) 
    {
        this.adminId = adminId;
    }

    public Long getAdminId() 
    {
        return adminId;
    }

    public void setDecisionTime(Date decisionTime) 
    {
        this.decisionTime = decisionTime;
    }

    public Date getDecisionTime() 
    {
        return decisionTime;
    }

    public void setDecisionRemark(String decisionRemark)
    {
        this.decisionRemark = decisionRemark;
    }

    public String getDecisionRemark()
    {
        return decisionRemark;
    }

    public String getApplicantName(){ return applicantName; }
    public void setApplicantName(String applicantName){ this.applicantName = applicantName; }
    public String getAdminName(){ return adminName; }
    public void setAdminName(String adminName){ this.adminName = adminName; }

    @Override
    public String toString() {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
            .append("requestId", getRequestId())
            .append("applicantId", getApplicantId())
            .append("status", getStatus())
            .append("adminId", getAdminId())
            .append("decisionTime", getDecisionTime())
            .append("decisionRemark", getDecisionRemark())
            .append("remark", getRemark())
            .append("applicantName", getApplicantName())
            .append("adminName", getAdminName())
            .append("createTime", getCreateTime())
            .append("updateTime", getUpdateTime())
            .toString();
    }
}
