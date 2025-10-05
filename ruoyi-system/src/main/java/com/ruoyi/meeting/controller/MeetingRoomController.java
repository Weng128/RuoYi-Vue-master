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
import com.ruoyi.meeting.domain.MeetingRoom;
import com.ruoyi.meeting.service.IMeetingRoomService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 会议室管理Controller
 *
 * @author wzx
 * @date 2025-09-11
 */
@RestController
@RequestMapping("/meeting/room")
public class MeetingRoomController extends BaseController
{
    @Autowired
    private IMeetingRoomService meetingRoomService;

    /**
     * 查询会议室列表
     */
    @PreAuthorize("@ss.hasPermi('meeting:room:list')")
    @GetMapping("/list")
    public TableDataInfo list(MeetingRoom meetingRoom)
    {
        startPage();
        List<MeetingRoom> list = meetingRoomService.selectMeetingRoomList(meetingRoom);
        return getDataTable(list);
    }

    /**
     * 导出会议室列表
     */
    @PreAuthorize("@ss.hasPermi('meeting:room:export')")
    @Log(title = "会议室管理", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, MeetingRoom meetingRoom)
    {
        List<MeetingRoom> list = meetingRoomService.selectMeetingRoomList(meetingRoom);
        ExcelUtil<MeetingRoom> util = new ExcelUtil<MeetingRoom>(MeetingRoom.class);
        util.exportExcel(response, list, "会议室数据");
    }

    /**
     * 获取会议室详细信息
     */
    @PreAuthorize("@ss.hasPermi('meeting:room:query')")
    @GetMapping(value = "/{roomId}")
    public AjaxResult getInfo(@PathVariable("roomId") String roomId)
    {
        return success(meetingRoomService.selectMeetingRoomByRoomId(roomId));
    }

    /**
     * 新增会议室
     */
    @PreAuthorize("@ss.hasPermi('meeting:room:add')")
    @Log(title = "会议室管理", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody MeetingRoom meetingRoom)
    {
        return toAjax(meetingRoomService.insertMeetingRoom(meetingRoom));
    }

    /**
     * 修改会议室
     */
    @PreAuthorize("@ss.hasPermi('meeting:room:edit')")
    @Log(title = "会议室管理", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody MeetingRoom meetingRoom)
    {
        return toAjax(meetingRoomService.updateMeetingRoom(meetingRoom));
    }

    /**
     * 删除会议室
     */
    @PreAuthorize("@ss.hasPermi('meeting:room:remove')")
    @Log(title = "会议室管理", businessType = BusinessType.DELETE)
	@DeleteMapping("/{roomIds}")
    public AjaxResult remove(@PathVariable String[] roomIds)
    {
        return toAjax(meetingRoomService.deleteMeetingRoomByRoomIds(roomIds));
    }
}
