package com.ruoyi.meeting.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.meeting.domain.ReservationRequestDetail;
import com.ruoyi.meeting.service.IReservationRequestDetailService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 会议室申请明细 Controller
 *
 * @author wzx
 * @date 2025-09-11
 */
@RestController
@RequestMapping("/meeting/detail")
public class ReservationRequestDetailController extends BaseController
{
    @Autowired
    private IReservationRequestDetailService reservationRequestDetailService;

    /**
     * 查询申请明细列表
     */
    @PreAuthorize("@ss.hasPermi('meeting:detail:list')")
    @GetMapping("/list")
    public TableDataInfo list(ReservationRequestDetail reservationRequestDetail)
    {
        startPage();
        List<ReservationRequestDetail> list = reservationRequestDetailService.selectReservationRequestDetailList(reservationRequestDetail);
        return getDataTable(list);
    }

    /**
     * 查询当前用户的申请明细列表
     */
    @PreAuthorize("@ss.hasPermi('meeting:detail:list')")
    @GetMapping("/mine")
    public TableDataInfo listMine(ReservationRequestDetail reservationRequestDetail)
    {
        Long userId = getUserId();
        if (userId == null)
        {
            return getDataTable(java.util.Collections.emptyList());
        }
        reservationRequestDetail.setApplicantId(userId);
        startPage();
        List<ReservationRequestDetail> list = reservationRequestDetailService.selectReservationRequestDetailList(reservationRequestDetail);
        return getDataTable(list);
    }

    /**
     * 导出申请明细列表
     */
    @PreAuthorize("@ss.hasPermi('meeting:detail:export')")
    @Log(title = "会议室申请明细", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, ReservationRequestDetail reservationRequestDetail)
    {
        List<ReservationRequestDetail> list = reservationRequestDetailService.selectReservationRequestDetailList(reservationRequestDetail);
        ExcelUtil<ReservationRequestDetail> util = new ExcelUtil<>(ReservationRequestDetail.class);
        util.exportExcel(response, list, "会议室申请明细数据");
    }

    /**
     * 获取申请明细详细信息
     */
    @PreAuthorize("@ss.hasAnyPermi('meeting:detail:query,meeting:request:edit')")
    @GetMapping(value = "/{detailId}")
    public AjaxResult getInfo(@PathVariable("detailId") Long detailId)
    {
        return success(reservationRequestDetailService.selectReservationRequestDetailByDetailId(detailId));
    }

//    /**
//     * 新增申请明细
//     */
//    @PreAuthorize("@ss.hasPermi('meeting:detail:add')")
//    @Log(title = "会议室申请明细", businessType = BusinessType.INSERT)
//    @PostMapping
//    public AjaxResult add(@RequestBody ReservationRequestDetail reservationRequestDetail)
//    {
//        return toAjax(reservationRequestDetailService.insertReservationRequestDetail(reservationRequestDetail));
//    }

    /**
     * 修改申请明细
     */
    @PreAuthorize("@ss.hasAnyPermi('meeting:detail:edit,meeting:request:edit')")
    @Log(title = "会议室申请明细", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody ReservationRequestDetail reservationRequestDetail)
    {
        return toAjax(reservationRequestDetailService.updateReservationRequestDetail(reservationRequestDetail));
    }

    /**
     * 删除申请明细
     */
    @PreAuthorize("@ss.hasAnyPermi('meeting:detail:remove,meeting:request:edit')")
    @Log(title = "会议室申请明细", businessType = BusinessType.DELETE)
	@DeleteMapping("/{detailIds}")
    public AjaxResult remove(@PathVariable Long[] detailIds)
    {
        return toAjax(reservationRequestDetailService.deleteReservationRequestDetailByDetailIds(detailIds));
    }
}
