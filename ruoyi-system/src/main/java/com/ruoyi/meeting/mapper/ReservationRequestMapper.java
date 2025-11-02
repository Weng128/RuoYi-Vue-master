package com.ruoyi.meeting.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.ruoyi.meeting.domain.ReservationRequest;

/**
 * 会议室申请 Mapper接口
 *
 * @author wzx
 * @date 2025-09-11
 */
public interface ReservationRequestMapper 
{
    /** 按ID查询申请 */
    public ReservationRequest selectReservationRequestByRequestId(Long requestId);

    /** 查询申请列表 */
    public List<ReservationRequest> selectReservationRequestList(ReservationRequest reservationRequest);

    /** 新增申请 */
    public int insertReservationRequest(ReservationRequest reservationRequest);

    /** 修改申请 */
    public int updateReservationRequest(ReservationRequest reservationRequest);

    /** 删除单个申请 */
    public int deleteReservationRequestByRequestId(Long requestId);

    /** 批量删除申请 */
    public int deleteReservationRequestByRequestIds(Long[] requestIds);

    /** 审批更新 */
    int updateApproval(@Param("requestId") Long requestId, @Param("status") String status, @Param("adminId") Long adminId, @Param("decisionRemark") String decisionRemark);

    /** 更新状态 */
    int updateStatus(@Param("requestId") Long requestId, @Param("status") String status, @Param("adminId") Long adminId, @Param("decisionRemark") String decisionRemark);

    /** 撤回申请，重置审批字段 */
    int resetApprovalState(@Param("requestId") Long requestId, @Param("status") String status, @Param("remark") String remark);
}
