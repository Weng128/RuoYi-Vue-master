package com.ruoyi.meeting.service;

import java.util.List;
import com.ruoyi.meeting.domain.ReservationRequestDetail;

/**
 * 会议室申请明细 Service接口
 *
 * @author wzx
 * @date 2025-09-11
 */
public interface IReservationRequestDetailService 
{
    /** 按ID查询申请明细 */
    public ReservationRequestDetail selectReservationRequestDetailByDetailId(Long detailId);
    /** 查询申请明细列表 */
    public List<ReservationRequestDetail> selectReservationRequestDetailList(ReservationRequestDetail reservationRequestDetail);
    /** 新增申请明细 */
    public int insertReservationRequestDetail(ReservationRequestDetail reservationRequestDetail);
    /** 修改申请明细 */
    public int updateReservationRequestDetail(ReservationRequestDetail reservationRequestDetail);
    /** 批量删除申请明细 */
    public int deleteReservationRequestDetailByDetailIds(Long[] detailIds);
    /** 删除单个申请明细 */
    public int deleteReservationRequestDetailByDetailId(Long detailId);
}
