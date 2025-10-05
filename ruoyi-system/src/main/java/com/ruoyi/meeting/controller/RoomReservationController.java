package com.ruoyi.meeting.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.meeting.domain.RoomReservation;
import com.ruoyi.meeting.service.IRoomReservationService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.utils.SecurityUtils;

/**
 * 会议室预留Controller
 */
@RestController
@RequestMapping("/meeting/reservation")
public class RoomReservationController extends BaseController
{
    @Autowired
    private IRoomReservationService roomReservationService;

    /**
     * 查询会议室预留列表
     */
    @PreAuthorize("@ss.hasPermi('meeting:reservation:list')")
    @GetMapping("/list")
    public TableDataInfo list(RoomReservation roomReservation)
    {
        startPage();
        List<RoomReservation> list = roomReservationService.selectRoomReservationList(roomReservation);
        return getDataTable(list);
    }

    /**
     * 导出会议室预留列表
     */
    @PreAuthorize("@ss.hasPermi('meeting:reservation:export')")
    @Log(title = "会议室预留", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, RoomReservation roomReservation)
    {
        List<RoomReservation> list = roomReservationService.selectRoomReservationList(roomReservation);
        ExcelUtil<RoomReservation> util = new ExcelUtil<RoomReservation>(RoomReservation.class);
        util.exportExcel(response, list, "会议室预留数据");
    }

    /**
     * 新增会议室预留
     */
    @PreAuthorize("@ss.hasPermi('meeting:reservation:add')")
    @Log(title = "会议室预留", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody RoomReservation roomReservation)
    {
        // 自动填充管理员ID，避免前端未传导致 admin_id 为空
        if (roomReservation.getAdminId() == null) {
            roomReservation.setAdminId(SecurityUtils.getUserId());
        }
        return toAjax(roomReservationService.insertRoomReservation(roomReservation));
    }

    /**
     * 删除会议室预留
     */
    @PreAuthorize("@ss.hasPermi('meeting:reservation:remove')")
    @Log(title = "会议室预留", businessType = BusinessType.DELETE)
	@DeleteMapping("/{reserveIds}")
    public AjaxResult remove(@PathVariable Long[] reserveIds)
    {
        return toAjax(roomReservationService.deleteRoomReservationByReserveIds(reserveIds));
    }
}
