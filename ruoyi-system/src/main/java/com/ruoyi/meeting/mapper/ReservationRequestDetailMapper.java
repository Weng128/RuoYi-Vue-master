package com.ruoyi.meeting.mapper;

import java.util.Date;
import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.ruoyi.meeting.domain.ReservationRequestDetail;
import com.ruoyi.meeting.domain.dto.ConflictDetailDTO;

/**
 * 会议室申请明细 Mapper接口
 *
 * @author wzx
 * @date 2025-09-11
 */
public interface ReservationRequestDetailMapper 
{
    /** 按ID查询申请明细 */
    public ReservationRequestDetail selectReservationRequestDetailByDetailId(Long detailId);

    /** 查询申请明细列表 */
    public List<ReservationRequestDetail> selectReservationRequestDetailList(ReservationRequestDetail reservationRequestDetail);

    /** 新增申请明细 */
    public int insertReservationRequestDetail(ReservationRequestDetail reservationRequestDetail);

    /** 修改申请明细 */
    public int updateReservationRequestDetail(ReservationRequestDetail reservationRequestDetail);

    /** 删除单个申请明细 */
    public int deleteReservationRequestDetailByDetailId(Long detailId);

    /** 批量删除申请明细 */
    public int deleteReservationRequestDetailByDetailIds(Long[] detailIds);

    /** 批量新增申请明细 */
    public int batchInsert(@Param("list") List<ReservationRequestDetail> list);

    /** 根据申请ID查询申请明细 */
    public List<ReservationRequestDetail> selectByRequestId(@Param("requestId") Long requestId);

    /** 统计已审批申请冲突数量 */
    public int countApprovedConflicts(@Param("roomIds") List<String> roomIds, @Param("startTime") Date startTime, @Param("endTime") Date endTime, @Param("excludeRequestId") Long excludeRequestId);

    /** 查询已审批申请冲突详情 */
    public List<ConflictDetailDTO> listApprovedConflictDetails(@Param("roomId") String roomId, @Param("startTime") Date startTime, @Param("endTime") Date endTime, @Param("excludeRequestId") Long excludeRequestId);
}
