package com.ruoyi.meeting.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.meeting.mapper.ReservationRequestDetailMapper;
import com.ruoyi.meeting.domain.ReservationRequestDetail;
import com.ruoyi.meeting.service.IReservationRequestDetailService;

/**
 * 会议室申请明细 Service 业务层处理
 *
 * @author wzx
 * @date 2025-09-11
 */
@Service
public class ReservationRequestDetailServiceImpl implements IReservationRequestDetailService 
{
    @Autowired
    private ReservationRequestDetailMapper reservationRequestDetailMapper;

    /** 按ID查询申请明细 */
    @Override
    public ReservationRequestDetail selectReservationRequestDetailByDetailId(Long detailId)
    {
        return reservationRequestDetailMapper.selectReservationRequestDetailByDetailId(detailId);
    }

    /** 查询申请明细列表 */
    @Override
    public List<ReservationRequestDetail> selectReservationRequestDetailList(ReservationRequestDetail reservationRequestDetail)
    {
        return reservationRequestDetailMapper.selectReservationRequestDetailList(reservationRequestDetail);
    }

    /** 新增申请明细 */
    @Override
    public int insertReservationRequestDetail(ReservationRequestDetail reservationRequestDetail)
    {
        return reservationRequestDetailMapper.insertReservationRequestDetail(reservationRequestDetail);
    }

    /** 修改申请明细 */
    @Override
    public int updateReservationRequestDetail(ReservationRequestDetail reservationRequestDetail)
    {
        return reservationRequestDetailMapper.updateReservationRequestDetail(reservationRequestDetail);
    }

    /** 批量删除申请明细 */
    @Override
    public int deleteReservationRequestDetailByDetailIds(Long[] detailIds)
    {
        return reservationRequestDetailMapper.deleteReservationRequestDetailByDetailIds(detailIds);
    }

    /** 删除单个申请明细 */
    @Override
    public int deleteReservationRequestDetailByDetailId(Long detailId)
    {
        return reservationRequestDetailMapper.deleteReservationRequestDetailByDetailId(detailId);
    }
}
