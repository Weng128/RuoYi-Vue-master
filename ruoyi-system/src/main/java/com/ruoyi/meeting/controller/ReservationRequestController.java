package com.ruoyi.meeting.controller;

import java.util.List;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.meeting.domain.ReservationRequest;
import com.ruoyi.meeting.domain.ReservationRequestDetail;
import com.ruoyi.meeting.domain.dto.SubmitRequestDTO;
import com.ruoyi.meeting.domain.dto.ApproveRequestDTO;
import com.ruoyi.meeting.domain.dto.RejectRequestDTO;
import com.ruoyi.meeting.domain.dto.ConflictDetailDTO;
import com.ruoyi.meeting.service.IReservationRequestService;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.utils.SecurityUtils;

/**
 * 会议室申请 Controller
 */
@RestController
@RequestMapping("/meeting/request")
public class ReservationRequestController extends BaseController
{
    @Autowired
    private IReservationRequestService reservationRequestService;

    /**
     * 查询会议室申请列表
     */
    @PreAuthorize("@ss.hasPermi('meeting:request:list')")
    @GetMapping("/list")
    public TableDataInfo list(ReservationRequest reservationRequest)
    {
        startPage();
        List<ReservationRequest> list = reservationRequestService.selectReservationRequestList(reservationRequest);
        return getDataTable(list);
    }

    /**
     * 提交会议室申请（支持统一或独立时段）
     */
    @PreAuthorize("@ss.hasPermi('meeting:request:submit')")
    @Log(title = "会议室申请提交", businessType = BusinessType.INSERT)
    @PostMapping("/submit")
    public AjaxResult submit(@RequestBody SubmitRequestDTO dto) {
        Long id;
        if (dto.getSlots() != null && !dto.getSlots().isEmpty()) {
            id = reservationRequestService.submitRequestWithSlots(SecurityUtils.getUserId(), dto.getSlots(), dto.getRemark());
        } else {
            id = reservationRequestService.submitRequest(SecurityUtils.getUserId(), dto.getRoomIds(), dto.getStartTime(), dto.getEndTime(), dto.getRemark());
        }
        return success(id);
    }

    /**
     * 审批会议室申请（支持统一或独立时段）
     */
    @PreAuthorize("@ss.hasPermi('meeting:request:approve')")
    @Log(title = "会议室申请审批", businessType = BusinessType.UPDATE)
    @PostMapping("/approve")
    public AjaxResult approve(@RequestBody ApproveRequestDTO dto) {
        if (dto.getSlots() != null && !dto.getSlots().isEmpty()) {
            reservationRequestService.approveRequestWithSlots(dto.getRequestId(), SecurityUtils.getUserId(), dto.getSlots(), dto.getDecisionRemark());
        } else {
            reservationRequestService.approveRequest(dto.getRequestId(), SecurityUtils.getUserId(), dto.getRoomIds(), dto.getStartTime(), dto.getEndTime(), dto.getDecisionRemark());
        }
        return success();
    }

    /**
     * 拒绝会议室申请
     */
    @PreAuthorize("@ss.hasPermi('meeting:request:reject')")
    @Log(title = "会议室申请拒绝", businessType = BusinessType.UPDATE)
    @PostMapping("/reject")
    public AjaxResult reject(@RequestBody RejectRequestDTO dto) {
        reservationRequestService.rejectRequest(dto.getRequestId(), SecurityUtils.getUserId(), dto.getDecisionRemark());
        return success();
    }

    /**
     * 查询会议室申请明细
     */
    @PreAuthorize("@ss.hasPermi('meeting:request:query')")
    @GetMapping("/details/{requestId}")
    public AjaxResult details(@PathVariable Long requestId) {
        List<ReservationRequestDetail> list = reservationRequestService.listDetails(requestId);
        return success(list);
    }

    /**
     * 冲突检测（支持统一或独立时段）
     */
    @PreAuthorize("@ss.hasPermi('meeting:request:conflict')")
    @PostMapping("/conflicts")
    public AjaxResult conflicts(@RequestBody SubmitRequestDTO dto) {
        List<ConflictDetailDTO> list;
        if (dto.getSlots() != null && !dto.getSlots().isEmpty()) {
            list = reservationRequestService.detectConflictsSlots(dto.getSlots(), null);
        } else {
            list = reservationRequestService.detectConflicts(dto.getRoomIds(), dto.getStartTime(), dto.getEndTime(), null);
        }
        return success(list);
    }
}
