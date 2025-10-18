<template>
  <div class="app-container">
    <!-- 查询条件 -->
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="80px">
      <el-form-item label="会议室" prop="roomId">
        <el-input v-model="queryParams.roomId" placeholder="请输入会议室编号" clearable @keyup.enter.native="handleQuery" />
      </el-form-item>
      <el-form-item label="开始时间" prop="startTime">
        <el-date-picker v-model="queryParams.startTime" type="datetime" value-format="yyyy-MM-dd HH:mm:ss" placeholder="请选择开始时间" clearable />
      </el-form-item>
      <el-form-item label="结束时间" prop="endTime">
        <el-date-picker v-model="queryParams.endTime" type="datetime" value-format="yyyy-MM-dd HH:mm:ss" placeholder="请选择结束时间" clearable />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="2.5">
        <el-button type="primary" plain icon="el-icon-s-promotion" size="mini" @click="openRoomInfo">预约会议室</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList" />
    </el-row>

  <el-table  v-loading="loading" :data="detailList" @selection-change="handleSelectionChange">
      <el-table-column label="申请ID" prop="requestId" width="70" align="center" />
      <el-table-column label="会议室" prop="roomId" width="70" align="center" />
      <el-table-column label="审批状态" width="80" align="center">
        <template slot-scope="scope">
          <el-tag v-if="scope.row.status==='PENDING'" type="warning">待审批</el-tag>
          <el-tag v-else-if="scope.row.status==='APPROVED'" type="success">已通过</el-tag>
          <el-tag v-else-if="scope.row.status==='REJECTED'" type="danger">已拒绝</el-tag>
          <span v-else>-</span>
        </template>
      </el-table-column>
      <el-table-column label="审批人" width="70" align="center">
        <template slot-scope="scope">{{ scope.row.adminName || '-' }}</template>
      </el-table-column>
      <el-table-column label="预约时间" width="300" align="center">
        <template slot-scope="scope">{{ displayTimeRange(scope.row) }}</template>
      </el-table-column>
      <el-table-column label="创建时间" width="160" align="center">
        <template slot-scope="scope">{{ displayCreate(scope.row) }}</template>
      </el-table-column>
      <el-table-column label="审批时间" prop="updateTime" width="160" align="center">
        <template slot-scope="scope">{{ displayUpdate(scope.row) }}</template>
      </el-table-column>
      <el-table-column label="审批意见" min-width="100" align="center" show-overflow-tooltip>
        <template slot-scope="scope">{{ displayDecisionRemark(scope.row) }}</template>
      </el-table-column>
      <el-table-column label="用途" min-width="100" align="center" show-overflow-tooltip>
        <template slot-scope="scope">{{ displayPurpose(scope.row) }}</template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width" width="100">
        <template slot-scope="scope">
          <el-button size="mini" type="text" icon="el-icon-edit" @click="handleUpdate(scope.row)" :disabled="scope.row.status==='APPROVED'" v-hasPermi="['meeting:detail:edit']">修改</el-button>
          <el-button size="mini" type="text" icon="el-icon-delete" @click="handleDelete(scope.row)" :disabled="scope.row.status==='APPROVED'" v-hasPermi="['meeting:detail:remove']">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination v-show="total>0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList" />

    <!-- 添加或修改明细对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="520px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="90px">
        <el-form-item label="会议室" prop="roomId">
          <el-input v-model="form.roomId" placeholder="请输入会议室ID" />
        </el-form-item>
        <el-form-item label="开始时间" prop="startTime">
          <!-- 确保为秒级格式 -->
          <el-date-picker v-model="form.startTime" type="datetime" value-format="yyyy-MM-dd HH:mm:ss" placeholder="请选择开始时间" clearable />
        </el-form-item>
        <el-form-item label="结束时间" prop="endTime">
          <!-- 确保为秒级格式 -->
          <el-date-picker v-model="form.endTime" type="datetime" value-format="yyyy-MM-dd HH:mm:ss" placeholder="请选择结束时间" clearable />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm" :loading="detailSubmitting" :disabled="detailSubmitting">确 定</el-button>
        <el-button @click="cancel" :disabled="detailSubmitting">取 消</el-button>
      </div>
    </el-dialog>

    <!-- 会议室空闲情况对话框 -->
    <el-dialog title="会议室占用情况" :visible.sync="roomInfoOpen" width="1140px" append-to-body>
      <div class="room-info-content">
        <el-row :gutter="20" type="flex" justify="space-between">
          <el-col :span="8" class="room-info-left">
            <el-table ref="roomTable" :data="roomList" v-loading="roomLoading" size="small" row-key="roomId" highlight-current-row :row-class-name="roomRowClassName" @row-click="handleRoomRowClick">
              <el-table-column label="会议室编号" prop="roomId" width="140" align="center" />
              <el-table-column label="容量" prop="capacity" width="90" align="center" />
              <el-table-column label="操作" width="120" align="center">
                <template slot-scope="scope">
                  <el-button size="mini" type="text" icon="el-icon-s-promotion" @click="quickApply(scope.row)">申请</el-button>
                </template>
              </el-table-column>
            </el-table>
          </el-col>
          <el-col :span="16" class="room-info-right">
            <el-card shadow="never" class="schedule-card">
              <div slot="header" class="schedule-header">
                <div class="schedule-header-left">
                  <span>未来会议室占用情况</span>
                  <span v-if="canSeeOccupy" class="schedule-context">{{ roomScheduleContextLabel }}</span>
                </div>
                <el-button v-if="canSeeOccupy" type="text" icon="el-icon-refresh" @click="refreshRoomSchedule" :loading="roomScheduleLoading">刷新</el-button>
              </div>
              <template v-if="!canSeeOccupy">
                <el-empty description="暂无权限查看占用信息" />
              </template>
              <template v-else>
                <el-skeleton v-if="roomScheduleLoading && !roomHasScheduleContent" rows="6" animated />
                <div v-else class="schedule-body room-schedule-body">
                  <div v-if="roomScheduleDays.length" class="room-schedule-days">
                    <div v-for="day in roomScheduleDays" :key="day.date" class="room-schedule-day">
                      <div class="schedule-day-title">{{ day.label }}</div>
                      <div v-if="day.records.length" class="room-schedule-day-content">
                        <div v-for="(item, idx) in day.records" :key="idx" class="room-schedule-item">
                          <div class="room-schedule-item-time">{{ item.timeRange }}</div>
                          <div class="room-schedule-item-room">会议室：{{ item.roomId }}</div>
                          
                        </div>
                      </div>
                      <el-empty v-else class="schedule-empty" description="暂无安排" />
                    </div>
                  </div>
                  <el-empty v-else class="schedule-empty" description="近三日暂无占用安排" />
                </div>
              </template>
            </el-card>
          </el-col>
        </el-row>
      </div>
      <div slot="footer" class="dialog-footer">
        <el-button @click="roomInfoOpen=false">关 闭</el-button>
      </div>
    </el-dialog>

    <!-- 申请弹窗（作为唯一的申请入口） -->
    <el-dialog title="会议室预约" :visible.sync="applyOpen" width="980px" append-to-body>
      <div class="apply-dialog-layout">
        <div class="apply-dialog-left">
          <el-form ref="applyFormRef" :model="applyForm" :rules="applyRules" label-width="90px">
            <el-form-item label="会议室" prop="roomIds">
              <el-select v-model="applyForm.roomIds" multiple disabled filterable collapse-tags style="width:100%">
                <el-option v-for="r in roomList" :key="r.roomId" :label="r.roomId" :value="r.roomId" />
              </el-select>
            </el-form-item>
            <!-- 开始时间：禁用过去的小时/分钟 -->
            <el-form-item label="开始时间" prop="range">
              <div class="apply-range-line">
                <el-date-picker v-model="applyForm.startDate" type="date" :picker-options="applyDateOptions" value-format="yyyy-MM-dd" placeholder="开始日期" style="width: 140px" />
                <el-select v-model="applyForm.startHour" placeholder="小时" style="width:75px; margin-left:6px">
                  <el-option v-for="h in hoursOptions" :key="'sh-'+h" :label="h" :value="h" :disabled="isStartHourDisabled(h)" />
                </el-select>
                <el-select v-model="applyForm.startMinute" placeholder="分钟" style="width:75px; margin-left:6px">
                  <el-option v-for="m in minutes10Options" :key="'sm-'+m" :label="m" :value="m" :disabled="isStartMinuteDisabled(m)" />
                </el-select>
              </div>
            </el-form-item>
            <!-- 结束时间：禁用过去的小时/分钟（以及早于开始时的组合会被逻辑自动纠正） -->
            <el-form-item label="结束时间" prop="range">
              <div class="apply-range-line">
                <el-date-picker v-model="applyForm.endDate" type="date" :picker-options="applyDateOptions" value-format="yyyy-MM-dd" placeholder="结束日期" style="width: 140px" />
                <el-select v-model="applyForm.endHour" placeholder="小时" style="width:75px; margin-left:6px">
                  <el-option v-for="h in hoursOptions" :key="'eh-'+h" :label="h" :value="h" :disabled="isEndHourDisabled(h)" />
                </el-select>
                <el-select v-model="applyForm.endMinute" placeholder="分钟" style="width:75px; margin-left:6px">
                  <el-option v-for="m in minutes10Options" :key="'em-'+m" :label="m" :value="m" :disabled="isEndMinuteDisabled(m)" />
                </el-select>
              </div>
            </el-form-item>
            <el-form-item label="用途">
              <el-input type="textarea" v-model="applyForm.remark" :rows="3" placeholder="请输入用途" />
            </el-form-item>
            <!-- 自动检测冲突：仅在存在冲突时显示结果表 -->
            <el-form-item v-if="applyConflicts.length" label="冲突结果">
              <el-table :data="applyConflicts" size="mini" border max-height="200">
                <el-table-column prop="roomId" label="房间" width="120" />
                <el-table-column prop="startTime" label="开始" width="160" />
                <el-table-column prop="endTime" label="结束" width="160" />
              </el-table>
            </el-form-item>
          </el-form>
          <div class="apply-dialog-actions">
            <el-button type="primary" @click="submitApply" :loading="applySubmitting" :disabled="applySubmitting">提 交</el-button>
            <el-button @click="applyOpen=false" :disabled="applySubmitting">关 闭</el-button>
          </div>
        </div>
        <div class="apply-dialog-right">
          <el-card shadow="never" class="schedule-card apply-side-schedule-card">
            <div slot="header" class="schedule-header">
              <div class="schedule-header-left">
                <span>未来会议室占用情况</span>
                <span v-if="applyScheduleContextLabel" class="schedule-context">{{ applyScheduleContextLabel }}</span>
              </div>
              <el-button v-if="canSeeOccupy" type="text" icon="el-icon-refresh" @click="refreshApplySchedule" :loading="applyScheduleLoading">刷新</el-button>
            </div>
            <template v-if="!canSeeOccupy">
              <el-empty description="暂无权限查看占用信息" />
            </template>
            <template v-else>
              <el-empty v-if="!applyForm.roomIds || !applyForm.roomIds.length" description="请选择会议室" />
              <template v-else>
                <el-skeleton v-if="applyScheduleLoading && !applyHasScheduleContent" rows="6" animated />
                <div v-else class="schedule-body room-schedule-body">
                  <div v-if="applyScheduleDays.length" class="room-schedule-days">
                    <div v-for="day in applyScheduleDays" :key="day.date" class="room-schedule-day">
                      <div class="schedule-day-title">{{ day.label }}</div>
                      <div v-if="day.records.length" class="room-schedule-day-content">
                        <div v-for="(item, idx) in day.records" :key="idx" class="room-schedule-item">
                          <div class="room-schedule-item-time">{{ item.timeRange }}</div>
                          <div class="room-schedule-item-room">会议室：{{ item.roomId }}</div>
                          <div v-if="item.remark" class="room-schedule-item-remark">{{ item.remark }}</div>
                        </div>
                      </div>
                      <el-empty v-else class="schedule-empty" description="暂无安排" />
                    </div>
                  </div>
                  <el-empty v-else class="schedule-empty" description="暂无占用安排" />
                </div>
              </template>
            </template>
          </el-card>
        </div>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listMyDetail, getDetail, addDetail, updateDetail, delDetail } from '@/api/meeting/detail'
import { listRoom } from '@/api/meeting/room'
import { submitRequest, conflictCheck, listRequestDetail, listRequest } from '@/api/meeting/request'
import { listReservation } from '@/api/meeting/reservation'
import { checkPermi } from '@/utils/permission'
import MeetingRequestSubmit from '@/views/meeting/request/submit.vue'

export default {
  name: 'MeetingDetail',
  components:{ MeetingRequestSubmit },
  data(){
    return {
      loading:false,
  detailList:[], total:0,
  queryParams:{ pageNum:1, pageSize:10, roomId:null, startTime:null, endTime:null },
      ids:[], single:true, multiple:true,
      form:{ detailId:null, requestId:null, roomId:null, startTime:null, endTime:null },
      open:false, title:'',
      rules:{
        requestId:[{ required:true, message:'申请ID不能为空', trigger:'blur' }],
        roomId:[{ required:true, message:'会议室不能为空', trigger:'blur' }],
        startTime:[{ required:true, message:'开始时间不能为空', trigger:'change' }],
        endTime:[{ required:true, message:'结束时间不能为空', trigger:'change' }]
      },
      showSearch:true,
      // 新增：提交中态
      detailSubmitting:false,
      // 新增：申请会议室弹窗所需
      applyOpen:false,
      // 新增：提交中状态（用于申请弹窗按钮禁用/loading）
      applySubmitting:false,
      applyForm:{ roomIds:[], range:[], remark:'', startDate:'', startHour:'', startMinute:'', endDate:'', endHour:'', endMinute:'' },
      // 仅未来日期（禁用今天之前的日期）
      applyDateOptions:{
        disabledDate:(time)=>{ const d=new Date(); d.setHours(0,0,0,0); return time.getTime() < d.getTime(); }
      },
      // 结束时间是否被用户手动修改过
      endTouched:false,
      // 内部同步结束时间时的静默标记，避免触发 endTouched
      updatingEndSilently:false,
      // 供时间选择的选项
      hoursOptions: Array.from({length:24}, (_,i)=> (i<10? '0'+i : ''+i)),
      minutes10Options: Array.from({ length:6 }, (_, i)=> { const v = i * 10; return v<10 ? '0'+v : ''+v }),
      recentMonthOptions:{
        disabledDate:(time)=>{
          const now = new Date();
          const dayMs = 24*60*60*1000;
          const minTs = now.getTime() - 30*dayMs;
          const maxTs = now.getTime() + 30*dayMs;
          const t = time.getTime();
          return t < minTs || t > maxTs;
        }
      },
      roomOptions:[],
      // 冲突结果
  applyConflicts:[],
      // 会议室信息弹窗
      roomInfoOpen:false,
      roomLoading:false,
      roomList:[],
      occupyMap:{},
  selectedRoomId:null,
      // 申请占用数据
      applyOccupy:[],
      applyOccupyLoading:false,
      requestInfoMap: Object.create(null),
    }
  },
  computed:{
    hasResvListPerm(){ return checkPermi(['meeting:reservation:list']) },
    hasDetailListPerm(){ return checkPermi(['meeting:detail:list']) },
    canSeeOccupy(){ return this.hasResvListPerm || this.hasDetailListPerm },
    roomScheduleContextLabel(){
      if(!this.canSeeOccupy) return ''
      return this.selectedRoomId ? `当前查看：会议室 ${this.selectedRoomId}` : '当前查看：全部会议室'
    },
    applyScheduleContextLabel(){
      if(!this.canSeeOccupy) return ''
      const ids = Array.isArray(this.applyForm.roomIds) ? this.applyForm.roomIds.filter(id=> id != null && id !== '') : []
      if(!ids.length) return ''
      const unique = Array.from(new Set(ids.map(id=> String(id))))
      if(unique.length === 1) return `当前查看：会议室 ${unique[0]}`
      if(unique.length <= 3) return `当前查看：会议室 ${unique.join('、')}`
      return `当前查看：${unique.length} 个会议室`
    },
    // 申请弹窗：仅展示“已通过且当前/未来”的时段
    applyFutureOccupy(){
      const now = Date.now()
      const toTs = (v)=> this.parseTs(v)
      return (this.applyOccupy||[])
        .filter(this.isApprovedRow)
        .filter(x=>{ const e = toTs(x && (x.endTime||x.end_time)); return isFinite(e) ? e >= now : false })
        .sort((a,b)=> this.parseTs(a.startTime) - this.parseTs(b.startTime))
    },
    roomScheduleDays(){
      if(!this.canSeeOccupy) return []
      const rooms = Array.isArray(this.roomList) ? this.roomList : []
      const orderedRooms = rooms.map(room=> room && room.roomId).filter(id=> id)
      const candidateRooms = this.selectedRoomId ? [this.selectedRoomId] : orderedRooms
      const fallbackRooms = Object.keys(this.occupyMap || {})
      const resolvedRooms = (candidateRooms.length ? candidateRooms : fallbackRooms).filter(Boolean)
      if(!resolvedRooms.length) return []
      const records = []
      resolvedRooms.forEach(roomId=>{
        const entry = this.occupyMap && this.occupyMap[roomId]
        const list = entry && Array.isArray(entry.list) ? entry.list : []
        list.forEach(item=>{
          if(!item) return
          if(!this.isApprovedRow(item)) return
          if(item.roomId == null && item.room_id != null) item.roomId = item.room_id
          if(item.startTime == null && item.start_time != null) item.startTime = item.start_time
          if(item.endTime == null && item.end_time != null) item.endTime = item.end_time
          if(!this.isFutureOrOngoing(item)) return
          const roomKey = item.roomId != null ? item.roomId : roomId
          records.push({
            roomId: roomKey,
            startTime: item.startTime,
            endTime: item.endTime,
            remark: this.resolveRemark(item)
          })
        })
      })
      const roomOrder = Array.from(new Set([...orderedRooms, ...resolvedRooms])).filter(Boolean)
      const days = this.buildScheduleDays(records, roomOrder, {
        includeUntilLast: true,
        includeTodayAlways: true,
        minDays: 3,
        trimEmptyFuture: true
      })
      return days.filter(day=> Array.isArray(day.records) && day.records.length)
    },
    roomScheduleLoading(){
      if(!this.canSeeOccupy) return false
      const rooms = Array.isArray(this.roomList) ? this.roomList : []
  const initialRooms = rooms.map(room=> room && room.roomId).filter(id=> id)
  const candidateRooms = this.selectedRoomId ? [this.selectedRoomId] : initialRooms
  const fallbackRooms = Object.keys(this.occupyMap || {})
  const targetRooms = candidateRooms.length ? candidateRooms : fallbackRooms
      if(!targetRooms.length) return this.roomLoading
      return targetRooms.some(roomId=>{
        const entry = this.occupyMap && this.occupyMap[roomId]
        return !entry || !!entry.loading
      })
    },
    roomHasScheduleContent(){
      return this.canSeeOccupy && this.roomScheduleDays.length > 0
    },
    applyScheduleDays(){
      if(!this.canSeeOccupy) return []
      const ids = Array.isArray(this.applyForm.roomIds) ? this.applyForm.roomIds : []
      if(!ids.length) return []
      const idSet = new Set(ids.map(id=> String(id)))
      const records = (this.applyFutureOccupy || []).filter(item=>{
        const roomId = item && (item.roomId != null ? item.roomId : item.room_id)
        return roomId != null && idSet.has(String(roomId))
      }).map(item=>({
        roomId: item && (item.roomId != null ? item.roomId : item.room_id),
        startTime: item && (item.startTime || item.start_time),
        endTime: item && (item.endTime || item.end_time),
        remark: this.resolveRemark(item)
      }))
      const days = this.buildScheduleDays(records, ids, { includeUntilLast: true, minDays: 1, includeTodayAlways: true, trimEmptyFuture: true })
      return days.filter(day=> Array.isArray(day.records) && day.records.length)
    },
    applyScheduleLoading(){
      return this.applyOccupyLoading
    },
    applyHasScheduleContent(){
      return this.applyScheduleDays.some(day=> Array.isArray(day.records) && day.records.length)
    }
  },
  created(){ this.getList(); this.loadRooms(); },
  watch:{
    // 房间选择变化时加载占用
    'applyForm.roomIds': function(){ this.loadApplyOccupy() },
    'applyForm.startDate': function(){ this.composeApplyRange() },
    'applyForm.startHour': function(){ this.composeApplyRange() },
    'applyForm.startMinute': function(){ this.composeApplyRange() },
    // 监听结束时间的任一部分，认为用户已手动修改
    'applyForm.endDate': function(){ if(!this.updatingEndSilently) this.endTouched=true; this.composeApplyRange() },
    'applyForm.endHour': function(){ if(!this.updatingEndSilently) this.endTouched=true; this.composeApplyRange() },
    'applyForm.endMinute': function(){ if(!this.updatingEndSilently) this.endTouched=true; this.composeApplyRange() },
    selectedRoomId(val){
      if(val && this.canSeeOccupy){
        const entry = this.occupyMap && this.occupyMap[val]
        const shouldFetch = !entry || ((!entry.list || !entry.list.length) && !entry.loading)
        if(shouldFetch) this.fetchRoomOccupy(val)
      }
      this.$nextTick(()=> this.syncRoomSelection())
    },
    canSeeOccupy(val){ if(!val) this.selectedRoomId = null },
    roomList(list){
      const exists = Array.isArray(list) && list.some(item=> item && item.roomId === this.selectedRoomId)
      if(!exists && this.selectedRoomId != null){
        this.selectedRoomId = null
      } else {
        this.$nextTick(()=> this.syncRoomSelection())
      }
    },
  },
  methods:{
    // 统一解析时间字符串为时间戳
    parseTs(str){
      if(str == null) return NaN
      if (typeof str === 'number') return str > 1e12 ? str : str * 1000
      const s = String(str).trim()
      if (/^\d{10}$/.test(s)) return parseInt(s,10) * 1000
      if (/^\d{13}$/.test(s)) return parseInt(s,10)
      const tryIso = Date.parse(s.replace(' ', 'T'))
      if(!isNaN(tryIso)) return tryIso
      return Date.parse(s.replace(/-/g,'/'))
    },
    // 选择第一个有效的时间字段（忽略 '-', '' 等，且必须可解析）
    pickValidTime(...cands){
      for(const v of cands){
        if(v==null) continue
        const s = String(v).trim()
        if(!s || s==='-' || s==='—') continue
        const ts = this.parseTs(s)
        if(isFinite(ts)) return s
      }
      return null
    },
    // 打开房间信息对话框
    openRoomInfo(){ this.roomInfoOpen=true; this.selectedRoomId=null; this.getRoomList() },
    getRoomList(){
      this.roomLoading=true
      listRoom({ pageNum:1, pageSize:20 }).then(r=>{
        this.roomList = (r && r.rows) ? r.rows : []
        this.prefetchOccupy()
        this.syncRoomSelection()
      }).finally(()=>{ this.roomLoading=false })
    },
    handleRoomRowClick(row){ if(!row || !row.roomId) return; this.selectedRoomId = this.selectedRoomId === row.roomId ? null : row.roomId },
    roomRowClassName({ row }){ return row && row.roomId === this.selectedRoomId ? 'is-selected-room' : '' },
    syncRoomSelection(){
      if(!this.$refs.roomTable) return
      const rows = Array.isArray(this.roomList) ? this.roomList : []
      const current = rows.find(item=> item && item.roomId === this.selectedRoomId) || null
      this.$refs.roomTable.setCurrentRow(current || null)
    },
    prefetchOccupy(){ if(!this.canSeeOccupy) return; (this.roomList||[]).map(r=>r.roomId).filter(Boolean).forEach(id=> this.fetchRoomOccupy(id)) },
    fetchRoomOccupy(roomId){
      if(!roomId) return
      if(!this.occupyMap[roomId]) this.$set(this.occupyMap, roomId, { loading:true, list:[] }); else this.occupyMap[roomId].loading=true
      const finalize = (rows)=>{
        const arr = (Array.isArray(rows) ? rows : []).filter(this.isApprovedRow)
        arr.forEach(it=>{
          if(!it) return
          if(it.startTime == null && it.start_time != null) it.startTime = it.start_time
          if(it.endTime == null && it.end_time != null) it.endTime = it.end_time
          if(it.roomId == null && it.room_id != null) it.roomId = it.room_id
          if(it.roomId == null) it.roomId = roomId
        })
        arr.sort((a,b)=> this.parseTs(a.startTime) - this.parseTs(b.startTime))
        this.$set(this.occupyMap, roomId, { loading:false, list:arr })
      }
      const onError = ()=> this.$set(this.occupyMap, roomId, { loading:false, list:[] })

      const tasks = []
      if(this.hasResvListPerm){ tasks.push(listReservation({ pageNum:1, pageSize:50, roomId }).catch(()=>({ rows:[] }))) }
      if(this.hasDetailListPerm){ tasks.push(listRequestDetail({ pageNum:1, pageSize:50, roomId, status:'APPROVED' }).catch(()=>({ rows:[] }))) }
      if(!tasks.length){ onError(); return }
      Promise.all(tasks)
        .then(resArr=>{
          const merged=[]
          resArr.forEach(r=>{
            const rows=(r && (r.rows || (r.data && r.data.rows))) ? (r.rows || r.data.rows) : []
            if(Array.isArray(rows)) merged.push(...rows)
          })
          finalize(merged)
        })
        .catch(onError)
    },
    getFutureOccupy(roomId){
      const all=(this.occupyMap[roomId] && this.occupyMap[roomId].list)||[];
      if(!all.length) return [];
      const now=Date.now();
      return all.filter(x=>{
        const e=this.parseTs(x && (x.endTime || x.end_time));
        return isFinite(e) ? e>=now : false;
      })
    },
    quickApply(row){ this.roomInfoOpen=false; if(!row||!row.roomId){ return } this.openApplyWithRoom(row.roomId) },
    openApplyWithRoom(roomId){
      // 确保房间列表可用
      if(!this.roomList || !this.roomList.length) this.getRoomList()
      this.applyForm={ roomIds:[roomId], range:[], remark:'', startDate:'', startHour:'', startMinute:'', endDate:'', endHour:'', endMinute:'' };
      this.endTouched=false; this.updatingEndSilently=false;
      this.applyConflicts=[];
      this.applyOpen=true;
      this.$nextTick(()=>{ this.loadApplyOccupy() })
    },
    async getList(){
      this.loading=true;
      try {
        const res = await listMyDetail(this.queryParams);
        const rows = res.rows||[];
        this.detailList = rows;
        this.total = res.total || rows.length || 0;
        // 预取父申请信息（用于更新时间等显示）
        this.prefetchRequestInfos(rows)
      } finally { this.loading=false; }
    },
    prefetchRequestInfos(rows){
      const ids = Array.from(new Set((rows||[]).map(r=> r && r.requestId != null ? String(r.requestId) : '').filter(Boolean)))
      if(!ids.length) return
      const params = { pageNum:1, pageSize:1000 }
      // 批量查询父申请列表（避免逐条 getRequest 导致 404）
      listRequest(params).then(res=>{
        const arr = (res && res.rows) ? res.rows : []
        if(!arr.length) return
        const map = Object.create(null)
        arr.forEach(item=>{ const k = item && item.requestId != null ? String(item.requestId) : null; if(k && ids.includes(k)) map[k]=item })
        // 写入缓存与表格行
        Object.keys(map).forEach(k=> this.$set(this.requestInfoMap, k, map[k]))
        this.detailList.forEach(row=>{
          const k = row && row.requestId != null ? String(row.requestId) : ''
          const info = map[k]
          if(info){
            const t = this.pickValidTime(info.updateTime, info.update_time, info.decisionTime, info.decision_time, info.modifyTime, info.modify_time, info.createTime, info.create_time, info.gmtModified, info.gmtCreate)
            if(t) this.$set(row, 'updateTime', t)
          }
        })
      }).catch(()=>{})
    },
    handleSelectionChange(sel){ this.ids=sel.map(i=>i.detailId); this.single=sel.length!==1; this.multiple=!sel.length },
    handleQuery(){ this.queryParams.pageNum=1; this.getList() },
    resetQuery(){ this.resetForm('queryForm'); this.handleQuery() },
    handleAdd(){ this.resetFormData(); this.open=true; this.title='添加会议室申请明细' },
    handleUpdate(row){
      this.resetFormData();
      const id = row.detailId || this.ids[0];
      if(!id) return;
      getDetail(id).then(r=>{
        this.form = r.data || {};
        this.open = true;
        this.title = '修改会议室申请明细';
      })
    },
    submitForm(){
      this.$refs['form'].validate(v=>{
        if(!v) return;
        this.detailSubmitting = true
        const api=this.form.detailId? updateDetail: addDetail;
        api(this.form)
          .then(()=>{ this.$modal.msgSuccess(this.form.detailId?'修改成功':'新增成功'); this.open=false; this.getList() })
          .finally(()=>{ this.detailSubmitting = false })
      })
    },
    handleDelete(row){ const ids=row? [row.detailId]: this.ids; if(!ids.length) return; this.$modal.confirm('是否确认删除编号为"'+ids.join(',')+'"的会议室申请明细？').then(()=> delDetail(ids.join(','))).then(()=>{ this.$modal.msgSuccess('删除成功'); this.getList() }).catch(()=>{}) },
    handleExport(){ this.download('meeting/detail/export', { ...this.queryParams }, `detail_${Date.now()}.xlsx`) },
    cancel(){ this.open=false },
    resetFormData(){ this.form={ detailId:null, requestId:null, roomId:null, startTime:null, endTime:null }; this.resetForm('form') },
    loadRooms(){ listRoom({ pageNum:1, pageSize:500 }).then(r=>{ this.roomOptions = r.rows || [] }) },
    submitApply(){
      this.$refs['applyFormRef'].validate(valid=>{
        if(!valid) return
        const [s,e] = this.applyForm.range
        const roomIds = this.applyForm.roomIds
        this.applySubmitting = true
        this.applyConflicts = []
        conflictCheck({ roomIds, startTime:s, endTime:e })
          .then(r=>{
            const conflicts = (r && r.data) ? r.data : []
            if(conflicts.length){
              this.applyConflicts = conflicts
              this.$modal.msgError('存在冲突，请调整时间或会议室后再提交')
              this.applySubmitting = false
              return
            }
            this.doSubmitApply()
          })
          .catch(()=>{ this.$modal.msgError('冲突检测失败，请稍后重试'); this.applySubmitting=false })
      })
    },
    doSubmitApply(){
      const [s,e] = this.applyForm.range
      submitRequest({ applicantId:this.$store.getters.id, roomIds:this.applyForm.roomIds, startTime:s, endTime:e, remark:this.applyForm.remark })
        .then(()=>{ this.$modal.msgSuccess('提交成功'); this.applyOpen=false; this.getList() })
        .finally(()=>{ this.applySubmitting=false })
    },
    formatDateTime(value){
      if(value == null) return null
      const s = String(value).trim()
      if(!s) return null
      const ts = this.parseTs(s)
      if(!isFinite(ts)) return s
      const d=new Date(ts); const p=n=>(n<10?'0':'')+n
      return `${d.getFullYear()}-${p(d.getMonth()+1)}-${p(d.getDate())} ${p(d.getHours())}:${p(d.getMinutes())}:${p(d.getSeconds())}`
    },
    displayTimeRange(row){
      const start = this.pickValidTime(row && row.startTime, row && row.start_time)
      const end = this.pickValidTime(row && row.endTime, row && row.end_time)
      if(!start && !end) return '-'
      const startStr = start ? this.formatDateTime(start) : '-'
      const endStr = end ? this.formatDateTime(end) : '-'
      return `${startStr || '-'} ~ ${endStr || '-'}`
    },
    getRequestInfo(row){
      if(!row || !row.requestId) return {}
      return this.requestInfoMap[row.requestId] || {}
    },
    displayCreate(row){
      const req = this.getRequestInfo(row)
      const cand = this.pickValidTime(
        row && row.createTime, row && row.create_time,
        req.createTime, req.create_time,
        row && row.gmtCreate, row && row.gmt_create,
        req.gmtCreate, req.gmt_create
      )
      const formatted = cand ? this.formatDateTime(cand) : null
      return formatted || '-'
    },
    displayUpdate(row){
      const req = this.getRequestInfo(row)
      const cand = this.pickValidTime(
        row && row.updateTime, row && row.update_time,
        row && row.decisionTime, row && row.decision_time,
        row && row.modifyTime, row && row.modify_time,
        row && row.createTime, row && row.create_time,
        row && row.gmtModified, row && row.gmt_modified,
        row && row.gmtCreate, row && row.gmt_create,
        req.updateTime, req.update_time,
        req.decisionTime, req.decision_time,
        req.modifyTime, req.modify_time,
        req.createTime, req.create_time,
        req.gmtModified, req.gmt_modified,
        req.gmtCreate, req.gmt_create
      )
      const formatted = cand ? this.formatDateTime(cand) : null
      return formatted || '-'
    },
    displayDecisionRemark(row){
      const req = this.getRequestInfo(row)
      const remark = row && (row.decisionRemark || row.decision_remark)
        || req.decisionRemark || req.decision_remark
        || req.approvalRemark || req.approval_remark
      const text = remark != null ? String(remark).trim() : ''
      return text || '-'
    },
    displayPurpose(row){
      const req = this.getRequestInfo(row)
      const remark = row && (row.remark || row.reason || row.purpose || row.applyReason || row.apply_reason)
      if(remark != null && String(remark).trim()){
        return String(remark).trim()
      }
      const reqRemark = req && (req.remark || req.reason || req.purpose || req.applyReason || req.apply_reason)
      const text = reqRemark != null ? String(reqRemark).trim() : ''
      return text || '-'
    },
    roundUpToMinuteStep(ts, stepMinutes = 10){
      const minutes = Math.max(1, Number(stepMinutes) || 10)
      const step = minutes * 60 * 1000
      return Math.ceil(ts / step) * step
    },
    toParts(ts){ const d=new Date(ts); const p=n=> (n<10?'0':'')+n; return { d:`${d.getFullYear()}-${p(d.getMonth()+1)}-${p(d.getDate())}`, h:p(d.getHours()), m:p(d.getMinutes()) } },
    composeApplyRange(){
      const { startDate, startHour, startMinute, endDate, endHour, endMinute } = this.applyForm
      // 若开始时间已齐，先组成并校正到未来
      let sStr=null, sTs=NaN
      if(startDate && startHour && startMinute){
        sStr = `${startDate} ${startHour}:${startMinute}:00`
        sTs = this.parseTs(sStr)
        const now = Date.now()
        if(isFinite(sTs) && sTs < now){
          // 上调到最近10分钟
          const adj = this.roundUpToMinuteStep(now, 10)
          const parts = this.toParts(adj)
          this.applyForm.startDate = parts.d
          this.applyForm.startHour = parts.h
          this.applyForm.startMinute = parts.m
          sStr = `${parts.d} ${parts.h}:${parts.m}:00`
          sTs = adj
        }
      }
      // 同步结束时间：当结束未手动修改 或 结束<=开始，自动补齐为开始+1小时
      if(sStr){
        const hasEnd = !!(endDate && endHour && endMinute)
        let eTs = NaN
        if(hasEnd){ eTs = this.parseTs(`${endDate} ${endHour}:${endMinute}:00`) }
        const shouldAutoFill = !this.endTouched || !isFinite(eTs) || (isFinite(sTs) && eTs <= sTs)
        if(shouldAutoFill && isFinite(sTs)){
          const autoEndTs = sTs + 60 * 60 * 1000
          const parts = this.toParts(autoEndTs)
          const same = this.applyForm.endDate === parts.d && this.applyForm.endHour === parts.h && this.applyForm.endMinute === parts.m
          if(!same){
            this.updatingEndSilently=true
            this.applyForm.endDate = parts.d
            this.applyForm.endHour = parts.h
            this.applyForm.endMinute = parts.m
            this.$nextTick(()=>{ this.updatingEndSilently=false })
          }
        }
      }
      // 设置 range
      if(this.applyForm.startDate && this.applyForm.startHour && this.applyForm.startMinute && this.applyForm.endDate && this.applyForm.endHour && this.applyForm.endMinute){
        this.applyForm.range = [ `${this.applyForm.startDate} ${this.applyForm.startHour}:${this.applyForm.startMinute}:00`, `${this.applyForm.endDate} ${this.applyForm.endHour}:${this.applyForm.endMinute}:00` ]
        if(this.$refs && this.$refs.applyFormRef){ this.$refs.applyFormRef.clearValidate(['range']) }
      } else {
        this.applyForm.range = []
      }
    },
    // 加载所选房间的占用时段（来自预约）
    loadApplyOccupy(){
      const ids = this.applyForm.roomIds || []
      this.applyOccupy = []
      if(!ids.length){ return }
      this.applyOccupyLoading = true
      const finalizeAll = (listSets)=>{
        const merged = ([]).concat(...listSets)
          .filter(this.isApprovedRow)
          .filter(this.isFutureOrOngoing)
        merged.forEach(it=>{ if(it && it.startTime == null && it.start_time != null) it.startTime = it.start_time; if(it && it.endTime == null && it.end_time != null) it.endTime = it.end_time })
        merged.sort((a,b)=> this.parseTs(a.startTime) - this.parseTs(b.startTime))
        this.applyOccupy = merged
        this.applyOccupyLoading=false
      }
      const allTasks = []
      ids.forEach(id=>{
        const tasks=[]
        if(this.hasResvListPerm){ tasks.push(listReservation({ pageNum:1, pageSize:50, roomId:id }).then(r=>{ const rows=(r && (r.rows || (r.data && r.data.rows))) ? (r.rows || r.data.rows) : []; rows.forEach(x=> x.roomId = id); return rows }).catch(()=>[])) }
        if(this.hasDetailListPerm){ tasks.push(listRequestDetail({ pageNum:1, pageSize:50, roomId:id, status:'APPROVED' }).then(r=>{ const rows=(r && (r.rows || (r.data && r.data.rows))) ? (r.rows || r.data.rows) : []; rows.forEach(x=>{ if(x && x.roomId==null) x.roomId = id }); return rows }).catch(()=>[])) }
        if(tasks.length){ allTasks.push(Promise.all(tasks).then(parts=>[].concat(...parts)).catch(()=>[])) }
      })
      if(!allTasks.length){ this.applyOccupyLoading=false; return }
      Promise.all(allTasks).then(finalizeAll).catch(()=>{ this.applyOccupyLoading=false })
    },
    // 仅保留已审批通过（或无status的预约记录）
    isApprovedRow(x){ const s=(x&&x.status)||''; return !s || s==='APPROVED' },
    // 仅保留当前及未来（endTime >= now）的时段
    isFutureOrOngoing(x){ const e=this.parseTs(x && (x.endTime||x.end_time)); return isFinite(e) ? e >= Date.now() : false },
    // 判断是否同一天
    isSameDay(d1,d2){ return !!d1 && !!d2 && String(d1)===String(d2) },
    // 当前时间拆分（向上取整到10分钟）
    nowParts(){ const adj=this.roundUpToMinuteStep(Date.now(), 10); const d=new Date(adj); const p=n=> (n<10?'0':'')+n; return { d:`${d.getFullYear()}-${p(d.getMonth()+1)}-${p(d.getDate())}`, h:p(d.getHours()), m:p(d.getMinutes()) } },
    // 开始时间选项禁用
    isStartHourDisabled(h){
      if(!this.applyForm.startDate) return false;
      const { d,h:nh } = this.nowParts();
      if(this.applyForm.startDate !== d) return false;
      return parseInt(h,10) < parseInt(nh,10)
    },
    isStartMinuteDisabled(m){
      if(!this.applyForm.startDate || !this.applyForm.startHour) return false;
      const { d,h:nh,m:nm } = this.nowParts();
      if(this.applyForm.startDate !== d) return false;
      if(parseInt(this.applyForm.startHour,10) > parseInt(nh,10)) return false;
      return parseInt(m,10) < parseInt(nm,10)
    },
    // 结束时间选项禁用（不得早于当前时刻；当与开始同日同小时，也一并限制分钟）
    isEndHourDisabled(h){
      if(!this.applyForm.endDate) return false;
      const now = this.nowParts();
      // 限制过去小时
      if(this.applyForm.endDate === now.d && parseInt(h,10) < parseInt(now.h,10)) return true;
      // 若与开始为同一天，限制早于开始的小时
      if(this.applyForm.startDate && this.applyForm.endDate === this.applyForm.startDate){
        const sh = parseInt(this.applyForm.startHour||'0',10)
        if(parseInt(h,10) < sh) return true;
      }
      return false
    },
    isEndMinuteDisabled(m){
      if(!this.applyForm.endDate || !this.applyForm.endHour) return false;
      const now = this.nowParts();
      // 与现在同日同小时，限制过去分钟
      if(this.applyForm.endDate === now.d && parseInt(this.applyForm.endHour,10) === parseInt(now.h,10)){
        if(parseInt(m,10) < parseInt(now.m,10)) return true;
      }
      // 与开始同日同小时，限制早于开始的分钟
      if(this.applyForm.startDate && this.applyForm.endDate === this.applyForm.startDate){
        const sh = parseInt(this.applyForm.startHour||'0',10)
        const sm = parseInt(this.applyForm.startMinute||'0',10)
        if(parseInt(this.applyForm.endHour,10) === sh && parseInt(m,10) < sm) return true;
      }
      return false
    },
    refreshRoomSchedule(){
      if(!this.canSeeOccupy) return
      this.prefetchOccupy()
    },
    refreshApplySchedule(){
      if(!this.canSeeOccupy) return
      this.loadApplyOccupy()
    },
    buildEmptySchedule(){
      const result = []
      const dayMs = 24 * 60 * 60 * 1000
      const baseTs = this.startOfDay(new Date()).getTime()
      for(let offset=0; offset<3; offset++){
        const dayStart = baseTs + offset * dayMs
        result.push({
          date: this.formatDate(dayStart),
          label: this.formatScheduleLabel(new Date(dayStart), offset),
          records: []
        })
      }
      return result
    },
    buildScheduleDays(records, roomOrder, options = {}){
      const normalizedRecords = Array.isArray(records) ? records : []
      const order = Array.isArray(roomOrder) ? roomOrder.filter(v=> v != null) : []
      const orderMap = {}
      order.forEach((id, idx)=>{ orderMap[String(id)] = idx })
      const { includeUntilLast = false, minDays = 3, includeTodayAlways = false, trimEmptyFuture = false } = options || {}
      const dayMs = 24 * 60 * 60 * 1000
      const baseStart = this.startOfDay(new Date()).getTime()
      let offsetsToIterate = null
      if(includeUntilLast){
        const offsetsSet = new Set()
        if(includeTodayAlways) offsetsSet.add(0)
        normalizedRecords.forEach(item=>{
          if(!item) return
          const startTs = this.parseTs(item.startTime != null ? item.startTime : item.start_time)
          const endTs = this.parseTs(item.endTime != null ? item.endTime : item.end_time)
          if(!isFinite(startTs) || !isFinite(endTs)) return
          const effectiveEnd = Math.max(endTs, startTs)
          if(effectiveEnd <= baseStart) return
          const effectiveStart = Math.max(startTs, baseStart)
          const offsetStart = Math.max(0, Math.floor((effectiveStart - baseStart) / dayMs))
          const offsetEnd = Math.max(0, Math.floor((Math.max(effectiveEnd - 1, baseStart) - baseStart) / dayMs))
          for(let offset = offsetStart; offset <= offsetEnd; offset++){
            offsetsSet.add(offset)
          }
        })
        if(offsetsSet.size){
          const sortedOffsets = Array.from(offsetsSet).sort((a,b)=> a - b)
          const minOffset = sortedOffsets[0]
          const maxOffset = sortedOffsets[sortedOffsets.length - 1]
          const span = maxOffset - minOffset + 1
          const total = Math.max(span, Math.max(1, minDays))
          offsetsToIterate = []
          for(let i=0; i<total; i++){
            offsetsToIterate.push(minOffset + i)
          }
        }
      }
      if(!offsetsToIterate || !offsetsToIterate.length){
        const total = Math.max(1, minDays)
        offsetsToIterate = Array.from({ length: total }, (_, idx)=> idx)
        if(includeTodayAlways && !offsetsToIterate.includes(0)){
          offsetsToIterate.push(0)
          offsetsToIterate = Array.from(new Set(offsetsToIterate)).sort((a,b)=> a - b)
        }
      }
      const daysList = offsetsToIterate.map(offset=>{
        const dayStart = baseStart + offset * dayMs
        const dayEnd = dayStart + dayMs
        const dayRecords = []
        normalizedRecords.forEach(item=>{
          if(!item) return
          const roomId = item.roomId != null ? item.roomId : item.room_id
          if(roomId == null) return
          const startTs = this.parseTs(item.startTime != null ? item.startTime : item.start_time)
          const endTs = this.parseTs(item.endTime != null ? item.endTime : item.end_time)
          if(!isFinite(startTs) || !isFinite(endTs)) return
          if(endTs <= dayStart || startTs >= dayEnd) return
          dayRecords.push({
            roomId,
            rawStart: Math.max(startTs, dayStart),
            rawEnd: Math.min(endTs, dayEnd),
            originalStart: startTs,
            originalEnd: endTs,
            remark: item.remark != null ? item.remark : this.resolveRemark(item)
          })
        })
        dayRecords.sort((a,b)=>{
          const orderA = Object.prototype.hasOwnProperty.call(orderMap, String(a.roomId)) ? orderMap[String(a.roomId)] : Number.MAX_SAFE_INTEGER
          const orderB = Object.prototype.hasOwnProperty.call(orderMap, String(b.roomId)) ? orderMap[String(b.roomId)] : Number.MAX_SAFE_INTEGER
          if(orderA !== orderB) return orderA - orderB
          if(a.originalStart !== b.originalStart) return a.originalStart - b.originalStart
          if(a.originalEnd !== b.originalEnd) return a.originalEnd - b.originalEnd
          return String(a.roomId).localeCompare(String(b.roomId))
        })
        return {
          offset,
          date: this.formatDate(dayStart),
          label: this.formatScheduleLabel(new Date(dayStart), offset),
          records: dayRecords.map(rec=>({
            roomId: rec.roomId,
            timeRange: `${this.formatTimeWithinDay(rec.rawStart, dayStart, dayEnd)} ~ ${this.formatTimeWithinDay(rec.rawEnd, dayStart, dayEnd)}`,
            remark: rec.remark
          }))
        }
      })
      if(trimEmptyFuture){
        return daysList.filter(day=> day.offset === 0 || (Array.isArray(day.records) && day.records.length))
      }
      return daysList
    },
    startOfDay(date){
      const d = date instanceof Date ? new Date(date.getTime()) : new Date(date)
      if(isNaN(d.getTime())) return new Date()
      d.setHours(0,0,0,0)
      return d
    },
    formatDate(value){
      const d = value instanceof Date ? value : new Date(value)
      if(isNaN(d.getTime())) return ''
      const y = d.getFullYear()
      const m = `${d.getMonth() + 1}`.padStart(2,'0')
      const day = `${d.getDate()}`.padStart(2,'0')
      return `${y}-${m}-${day}`
    },
    formatTime(ts){
      if(!isFinite(ts)) return '--:--'
      const d = new Date(ts)
      if(isNaN(d.getTime())) return '--:--'
      const h = `${d.getHours()}`.padStart(2,'0')
      const m = `${d.getMinutes()}`.padStart(2,'0')
      return `${h}:${m}`
    },
    formatTimeWithinDay(ts, dayStart, dayEnd){
      if(!isFinite(ts)) return '--:--'
      if(isFinite(dayStart) && ts <= dayStart) return '00:00'
      if(isFinite(dayEnd) && ts >= dayEnd) return '24:00'
      return this.formatTime(ts)
    },
    formatScheduleLabel(date, offset){
      const d = date instanceof Date ? date : new Date(date)
      if(isNaN(d.getTime())) return ''
      const weekMap = ['日','一','二','三','四','五','六']
      const base = this.formatDate(d)
      const week = weekMap[d.getDay()] || ''
      if(offset === 0) return `今天 ${base} (周${week})`
      if(offset === 1) return `明天 ${base} (周${week})`
      if(offset === 2) return `后天 ${base} (周${week})`
      return `${base} (周${week})`
    },
    resolveRemark(item){
      if(!item) return ''
      const remark = item.remark || item.reason || item.purpose || item.applyReason || item.title || ''
      return remark ? String(remark) : ''
    }
  }
}
</script>

<style scoped>
.detail-table{ width:100%; }
.detail-table ::v-deep .el-table__inner-wrapper{ width:100% !important; }
.detail-table ::v-deep colgroup col:nth-child(5),
.detail-table ::v-deep colgroup col:nth-child(6),
.detail-table ::v-deep colgroup col:nth-child(7),
.detail-table ::v-deep colgroup col:nth-child(8),
.detail-table ::v-deep colgroup col:nth-child(9){ width:auto !important; }
.detail-table ::v-deep th:nth-child(5),
.detail-table ::v-deep th:nth-child(6),
.detail-table ::v-deep th:nth-child(7),
.detail-table ::v-deep th:nth-child(8),
.detail-table ::v-deep th:nth-child(9),
.detail-table ::v-deep td:nth-child(5),
.detail-table ::v-deep td:nth-child(6),
.detail-table ::v-deep td:nth-child(7),
.detail-table ::v-deep td:nth-child(8),
.detail-table ::v-deep td:nth-child(9){ width:auto !important; }
.detail-table ::v-deep td:nth-child(5) .cell{ white-space:nowrap; line-height:1.4; }
.detail-table ::v-deep td:nth-child(6) .cell,
.detail-table ::v-deep td:nth-child(7) .cell,
.detail-table ::v-deep td:nth-child(8) .cell,
.detail-table ::v-deep td:nth-child(9) .cell{ white-space:nowrap; }
.detail-table ::v-deep .reservation-time-col .cell{ white-space:nowrap; line-height:1.4;}
.mb8{ margin-bottom:8px }
.apply-range-line{ display:flex; align-items:center; flex-wrap:wrap }
.apply-dialog-layout{ display:flex; gap:20px; align-items:stretch }
.apply-dialog-left{ flex:0 0 400px; min-width:280px; max-width:400px; display:flex; flex-direction:column }
.apply-dialog-right{ flex:1 1 auto; min-width:0; display:flex }
.apply-side-schedule-card{ width:100% }
.apply-side-schedule-card .room-schedule-days{ grid-template-columns:repeat(auto-fit, minmax(130px, 1fr)) }
.apply-dialog-actions{ margin-top:16px; display:flex; gap:12px; justify-content:flex-end }

.room-info-content{ display:flex; flex-direction:column; padding:0 6px }
.room-info-left,
.room-info-right{ display:flex; flex-direction:column }
.room-info-left{ min-width:0 }
.room-info-right{ min-width:0 }

.schedule-wrapper{ width:100% }
.schedule-card{ display:flex; flex-direction:column; height:100% }
.schedule-header{ display:flex; align-items:center; justify-content:space-between; font-weight:600 }
.schedule-header-left{ display:flex; align-items:center; gap:8px }
.schedule-context{ font-size:12px; color:#909399; font-weight:400 }
.schedule-body{ flex:1; overflow-y:auto; max-height:360px; padding-right:4px }
.room-schedule-body{ display:flex; flex-direction:column; gap:12px; overflow:visible; max-height:none; padding-right:0 }
.room-schedule-days{ display:grid; grid-template-columns:repeat(3, minmax(0, 1fr)); gap:16px; width:100%; align-items:stretch }
.room-schedule-day{ background:#f9fafc; border:1px solid #ebeef5; border-radius:8px; padding:12px; box-sizing:border-box; display:flex; flex-direction:column; gap:12px; min-width:0 }
.room-schedule-day-content{ display:flex; flex-direction:column; gap:8px }
.room-schedule-item{ background:#fff; border:1px solid #ebeef5; border-radius:6px; padding:8px 10px; box-shadow:0 1px 2px rgba(31,35,41,0.04) }
.room-schedule-item-time{ font-weight:600; color:#303133 }
.room-schedule-item-room{ color:#606266; font-size:12px; margin-top:4px }
.room-schedule-item-remark{ color:#909399; font-size:12px; margin-top:4px }
.schedule-day + .schedule-day{ margin-top:16px }
.schedule-day-title{ font-size:14px; font-weight:600; margin-bottom:8px; color:#303133 }
.schedule-item-room{ font-weight:600; margin-bottom:4px }
.schedule-item-remark{ color:#909399; font-size:12px }
.schedule-empty{ margin:8px 0; padding:8px 0 }
.schedule-empty ::v-deep .el-empty{ padding:12px 0 }
.schedule-empty ::v-deep .el-empty__image{ width:90px }
.schedule-empty ::v-deep .el-empty__description{ font-size:12px; margin-top:4px }
.apply-schedule-card{ margin-top:0 }
.room-info-left ::v-deep .is-selected-room > td{ background-color:#f5f7fa !important }
.room-info-left ::v-deep .el-table__row{ cursor:pointer }

@media (max-width: 1200px){
  .schedule-body{ max-height:none }
  .room-info-right{ margin-top:16px }
}

@media (max-width: 1100px){
  .room-schedule-days{ grid-template-columns:repeat(2, minmax(0, 1fr)) }
}

@media (max-width: 780px){
  .room-schedule-days{ grid-template-columns:repeat(1, minmax(0, 1fr)) }
}

@media (max-width: 992px){
  .apply-dialog-layout{ flex-direction:column }
  .apply-dialog-left{ flex:1 1 auto; min-width:0; max-width:none; width:100% }
  .apply-dialog-right{ width:100%; min-width:0 }
  .apply-dialog-actions{ justify-content:flex-start }
}
</style>
