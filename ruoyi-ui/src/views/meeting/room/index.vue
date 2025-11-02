<template>
  <div class="app-container meeting-room-page">
    <el-form class="filter-form" :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="会议室" prop="roomId">
        <el-input v-model="queryParams.roomId" placeholder="会议室编号" clearable @keyup.enter.native="handleQuery" />
      </el-form-item>
      <el-form-item label="容量" prop="capacity">
        <el-input v-model="queryParams.capacity" placeholder="请输入容量" clearable @keyup.enter.native="handleQuery" />
      </el-form-item>
      <el-form-item label="位置" prop="location">
        <el-input v-model="queryParams.location" placeholder="请输入位置" clearable @keyup.enter.native="handleQuery" />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="16" class="room-layout">
      <el-col
        :xs="24"
        :sm="24"
        :md="8"
        :lg="8"
        :xl="8"
        class="room-left"
      >
        <el-row :gutter="10" class="mb8 action-bar">
          <el-col :span="12" class="left-actions">
            <el-button type="primary" icon="el-icon-plus" size="mini" @click="handleAdd" v-hasPermi="['meeting:room:add']">新增会议室</el-button>
          </el-col>
          <el-col :span="12" class="toolbar-col">
            <right-toolbar :showSearch.sync="showSearch" @queryTable="getList" />
          </el-col>
        </el-row>

        <el-table
          ref="roomTable"
          v-loading="loading"
          :data="roomList"
          highlight-current-row
          :row-class-name="rowClassName"
          @selection-change="handleSelectionChange"
          @row-click="handleRowClick"
        >
          <el-table-column label="会议室编号" align="center" prop="roomId" min-width="150"/>
          <el-table-column label="容量" align="center" prop="capacity" min-width="120" />
          <el-table-column label="操作" align="center" class-name="small-padding fixed-width" min-width="140">
            <template slot-scope="scope">
              <el-button size="mini" type="text" icon="el-icon-edit" @click="handleUpdate(scope.row)" v-hasPermi="['meeting:room:edit']">修改</el-button>
              <el-button size="mini" type="text" icon="el-icon-delete" @click="handleDelete(scope.row)" v-hasPermi="['meeting:room:remove']">删除</el-button>
            </template>
          </el-table-column>
        </el-table>
        <pagination v-show="total>0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList" />
      </el-col>
      <el-col
        :xs="24"
        :sm="24"
        :md="16"
        :lg="16"
        :xl="16"
        class="room-right"
      >
        <el-card shadow="never" class="schedule-card">
          <div slot="header" class="schedule-header">
            <div class="schedule-header-left">
              <span>未来{{ scheduleDayRange }}日会议室空闲情况</span>
              <span v-if="canSeeOccupy" class="schedule-context">{{ scheduleContextLabel }}</span>
            </div>
            <div v-if="canSeeOccupy" class="schedule-header-actions">
              <el-select v-model="scheduleDayRange" size="mini" class="schedule-day-select">
                <el-option v-for="opt in scheduleDayOptions" :key="opt" :label="`近${opt}天`" :value="opt" />
              </el-select>
              <el-button type="text" icon="el-icon-refresh" @click="refreshSchedule" :loading="scheduleLoading">刷新</el-button>
            </div>
          </div>
          <template v-if="!canSeeOccupy">
            <el-empty description="暂无权限查看占用信息" />
          </template>
          <template v-else>
            <el-skeleton v-if="scheduleLoading && !hasScheduleContent" rows="6" animated />
            <div v-else class="schedule-body">
              <div v-if="scheduleDays.length" class="schedule-days-wrap">
                <div v-for="day in scheduleDays" :key="day.date" class="schedule-day-box">
                  <div class="schedule-day-title">{{ day.label }}</div>
                  <div class="schedule-day-content">
                    <div v-for="(item, idx) in day.records" :key="idx" class="schedule-item">
                      <div class="schedule-item-time">{{ item.timeRange }}</div>
                      <div v-if="!selectedRoomId" class="schedule-item-room">会议室：{{ item.roomId }}</div>
                      <div class="schedule-item-remark">{{ item.remark || '已占用' }}</div>
                    </div>
                  </div>
                </div>
              </div>
              <el-empty v-else class="schedule-empty" :description="`近${scheduleDayRange}日暂无占用安排`" />
            </div>
          </template>
        </el-card>
      </el-col>
    </el-row>

    <!-- 会议室维护对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="90px">
        <el-form-item label="会议室编号" prop="roomId">
          <el-input v-model="form.roomId" :disabled="isEdit" placeholder="请输入会议室编号" maxlength="32" show-word-limit />
        </el-form-item>
        <el-form-item label="容量" prop="capacity">
          <el-input v-model="form.capacity" placeholder="请输入容量" />
        </el-form-item>
        <el-form-item label="位置" prop="location">
          <el-input v-model="form.location" placeholder="请输入位置" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>

    <!-- 申请弹窗 -->
    <el-dialog title="会议室申请" :visible.sync="applyOpen" width="620px" append-to-body>
      <el-form ref="applyFormRef" :model="applyForm" :rules="applyRules" label-width="90px">
        <el-form-item label="会议室" prop="roomIds">
          <el-select v-model="applyForm.roomIds" multiple filterable placeholder="请选择会议室" style="width:100%">
            <el-option v-for="r in roomList" :key="r.roomId" :label="r.roomId" :value="r.roomId" />
          </el-select>
        </el-form-item>
        <el-form-item label="时间范围" prop="range">
          <el-date-picker v-model="applyForm.range" type="datetimerange" value-format="yyyy-MM-dd HH:mm" start-placeholder="开始" end-placeholder="结束" style="width:100%" />
        </el-form-item>
        <el-form-item label="备注">
          <el-input type="textarea" v-model="applyForm.remark" :rows="3" placeholder="用途/备注" />
        </el-form-item>
        <el-form-item label="占用时段">
          <div v-loading="applyOccupyLoading">
            <el-table :data="applyOccupy" size="mini" border max-height="200" v-if="applyOccupy && applyOccupy.length">
              <el-table-column label="开始">
                <template slot-scope="scope">{{ formatDateTimeString(scope.row.startTime || scope.row.start_time) }}</template>
              </el-table-column>
              <el-table-column label="结束">
                <template slot-scope="scope">{{ formatDateTimeString(scope.row.endTime || scope.row.end_time) }}</template>
              </el-table-column>
            </el-table>
            <el-empty v-else description="暂无占用或未选择会议室" />
          </div>
        </el-form-item>
        <el-form-item v-if="applyConflicts.length" label="冲突结果">
          <el-table :data="applyConflicts" size="mini" border max-height="200">
            <el-table-column prop="roomId" label="会议室" width="120" />
            <el-table-column label="开始" width="160">
              <template slot-scope="scope">{{ formatDateTimeString(scope.row.startTime || scope.row.start_time) }}</template>
            </el-table-column>
            <el-table-column label="结束" width="160">
              <template slot-scope="scope">{{ formatDateTimeString(scope.row.endTime || scope.row.end_time) }}</template>
            </el-table-column>
          </el-table>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitApply" :loading="applySubmitting" :disabled="applySubmitting">提 交</el-button>
        <el-button @click="applyOpen=false" :disabled="applySubmitting">关 闭</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listRoom, getRoom, delRoom, addRoom, updateRoom as apiUpdateRoom } from '@/api/meeting/room'
import { conflictCheck, submitRequest, listRequestDetail } from '@/api/meeting/request'
import { listReservation } from '@/api/meeting/reservation'
import { checkPermi } from '@/utils/permission'
export default {
  name: 'Room',
  data() {
    return {
      loading: false,
      ids: [], single: true, multiple: true,
      showSearch: true,
    total: 0,
    roomList: [],
    selectedRoomId: null,
    title: '', open: false,
      queryParams: { pageNum: 1, pageSize: 10, roomId:null, capacity: null, location: null },
      form: { roomId: null, capacity: null, location: null },
      isEdit: false,
      // 展开占用数据缓存（也用于行内占用列）
      occupyMap: {},
      // 申请弹窗
      applyOpen:false,
      applyForm:{ roomIds:[], range:[], remark:'' },
      applyRules:{
        roomIds:[{ required:true, message:'请选择会议室', trigger:'change' }],
        range:[{ validator:(r,v,cb)=>{ if(!v||v.length!==2) cb(new Error('请选择时间范围')); else cb(); }, trigger:'change' }]
      },
  scheduleDayOptions:[1,2,3,7,14,30],
  scheduleDayRange:3,
  // 自动冲突与占用
      applyConflicts:[],
      applyOccupy:[],
      applyOccupyLoading:false,
      // 提交中状态
      applySubmitting:false,
      rules: {
        roomId: [{ required: true, message: '会议室编号不能为空', trigger: 'blur' }],
        capacity: [
          { required: true, message: '容量不能为空', trigger: 'blur' },
          { validator: (r,v,cb)=>{ if(v===null||v===''){ return cb(new Error('容量不能为空')); } if(!/^\d+$/.test(String(v))){ return cb(new Error('容量需为数字')); } cb(); }, trigger:'blur' }
        ],
        location: [{ required: true, message: '位置不能为空', trigger: 'blur' }]
      }
    }
  },
  computed:{
    hasResvListPerm(){ return checkPermi(['meeting:reservation:list']) },
    hasDetailListPerm(){ return checkPermi(['meeting:detail:list']) },
    // 只要具备任一权限即可展示占用
    canSeeOccupy(){ return this.hasResvListPerm || this.hasDetailListPerm },
    scheduleContextLabel(){
      if(!this.canSeeOccupy) return ''
      return this.selectedRoomId ? `当前查看：会议室 ${this.selectedRoomId}` : '当前查看：全部会议室'
    },
    scheduleDays(){
      if(!this.canSeeOccupy) return []
      const result = []
      const dayMs = 24 * 60 * 60 * 1000
      const baseDate = this.startOfDay(new Date())
      const baseTs = baseDate.getTime()
      const rooms = Array.isArray(this.roomList) ? this.roomList : []
      const orderMap = {}
      rooms.forEach((room, idx)=>{
        if(room && room.roomId != null) orderMap[room.roomId] = idx
      })
      const targetRooms = this.selectedRoomId
        ? [this.selectedRoomId]
        : rooms.map(room=>room && room.roomId).filter(id=>id)
      const fallbackRooms = Object.keys(this.occupyMap || {})
      const resolvedRooms = targetRooms.length ? targetRooms : fallbackRooms
      const range = Math.max(1, Number(this.scheduleDayRange) || 3)
      for(let offset=0; offset<range; offset++){
        const dayStart = baseTs + offset * dayMs
        const dayEnd = dayStart + dayMs
        const dayRecords = []
        resolvedRooms.forEach(roomId=>{
          if(!roomId) return
          const entry = this.occupyMap && this.occupyMap[roomId]
          const list = entry && Array.isArray(entry.list) ? entry.list : []
          list.forEach(item=>{
            if(item){
              if(item.roomId == null && item.room_id != null) item.roomId = item.room_id
              if(item.startTime == null && item.start_time != null) item.startTime = item.start_time
              if(item.endTime == null && item.end_time != null) item.endTime = item.end_time
            }
            const startTs = this.parseTs(item && item.startTime)
            const endTs = this.parseTs(item && item.endTime)
            if(!isFinite(startTs) || !isFinite(endTs)) return
            if(endTs <= dayStart || startTs >= dayEnd) return
            const roomKey = item && item.roomId != null ? item.roomId : roomId
            dayRecords.push({
              roomId: roomKey,
              rawStart: Math.max(startTs, dayStart),
              rawEnd: Math.min(endTs, dayEnd),
              originalStart: startTs,
              originalEnd: endTs,
              remark: this.resolveRemark(item)
            })
          })
        })
        if(!dayRecords.length) continue
        dayRecords.sort((a,b)=>{
          const orderA = Object.prototype.hasOwnProperty.call(orderMap, a.roomId) ? orderMap[a.roomId] : Number.MAX_SAFE_INTEGER
          const orderB = Object.prototype.hasOwnProperty.call(orderMap, b.roomId) ? orderMap[b.roomId] : Number.MAX_SAFE_INTEGER
          if(orderA !== orderB) return orderA - orderB
          if(a.originalStart !== b.originalStart) return a.originalStart - b.originalStart
          if(a.originalEnd !== b.originalEnd) return a.originalEnd - b.originalEnd
          if(a.rawStart !== b.rawStart) return a.rawStart - b.rawStart
          return a.rawEnd - b.rawEnd
        })
        result.push({
          date: this.formatDate(dayStart),
          label: this.formatScheduleLabel(new Date(dayStart), offset),
          records: dayRecords.map(rec=>(
            {
              roomId: rec.roomId,
              timeRange: `${this.formatTimeWithinDay(rec.rawStart, dayStart, dayEnd)} ~ ${this.formatTimeWithinDay(rec.rawEnd, dayStart, dayEnd)}`,
              remark: rec.remark
            }
          ))
        })
      }
      return result
    },
    scheduleLoading(){
      if(!this.canSeeOccupy) return false
      const rooms = Array.isArray(this.roomList) ? this.roomList : []
      const initialRooms = this.selectedRoomId
        ? [this.selectedRoomId]
        : rooms.map(room=>room && room.roomId).filter(id=>id)
      const fallbackRooms = Object.keys(this.occupyMap || {})
      const targetRooms = initialRooms.length ? initialRooms : fallbackRooms
      if(!targetRooms.length) return this.loading
      return targetRooms.some(roomId=>{
        const entry = this.occupyMap && this.occupyMap[roomId]
        return !entry || !!entry.loading
      })
    },
    hasScheduleContent(){
  if(!this.canSeeOccupy) return false
  return this.scheduleDays.some(day=> Array.isArray(day.records) && day.records.length)
    },
    currentOccupyInfos(){
      const result = Object.create(null)
      if(!this.canSeeOccupy) return result
      const map = this.occupyMap || {}
      const now = Date.now()
      Object.keys(map).forEach(roomId=>{
        const info = this.computeCurrentOccupyInfo(roomId, now)
        if(info) result[roomId] = info
      })
      return result
    }
  },
  // 移除与时段筛选相关的计算属性与监听
  created() { this.getList() },
  watch:{
    // 当会议室选择变化时，刷新占用信息
    'applyForm.roomIds': function(){ this.loadApplyOccupy() },
    selectedRoomId(val){
      if(val && this.canSeeOccupy){
        const entry = this.occupyMap && this.occupyMap[val]
        const shouldFetch = !entry || (!entry.fetched && !entry.loading)
        if(shouldFetch){
        this.fetchRoomOccupy(val)
        }
      }
      this.$nextTick(()=> this.syncCurrentRow())
    },
    canSeeOccupy(val){
      if(!val && this.selectedRoomId != null){
        this.selectedRoomId = null
      }
    },
    roomList(list){
      const exists = Array.isArray(list) && list.some(item=>item && item.roomId === this.selectedRoomId)
      if(!exists && this.selectedRoomId != null){
        this.selectedRoomId = null
      } else {
        this.$nextTick(()=> this.syncCurrentRow())
      }
    }
  },
  methods: {
    syncCurrentRow(){
      if(!this.$refs.roomTable) return
      const rows = Array.isArray(this.roomList) ? this.roomList : []
      const target = rows.find(item=>item && item.roomId === this.selectedRoomId) || null
      this.$refs.roomTable.setCurrentRow(target)
    },
    handleRowClick(row){
      if(!row || !row.roomId) return
      this.selectedRoomId = this.selectedRoomId === row.roomId ? null : row.roomId
    },
    rowClassName({ row }){
      return row && row.roomId === this.selectedRoomId ? 'is-selected-room' : ''
    },
    // 统一解析后端返回的时间字符串（如：yyyy-MM-dd HH:mm 或 yyyy-MM-dd HH:mm:ss）为时间戳
    parseTs(str){
      if(str == null) return NaN
      // 原样数字/数字字符串（毫秒或秒）
      if (typeof str === 'number') return str > 1e12 ? str : str * 1000
      const s = String(str).trim()
      if (/^\d{10}$/.test(s)) return parseInt(s,10) * 1000
      if (/^\d{13}$/.test(s)) return parseInt(s,10)
      // 兼容性处理：将空格替换为T，或将-替换为/
      const tryIso = Date.parse(s.replace(' ', 'T'))
      if(!isNaN(tryIso)) return tryIso
      const trySlash = Date.parse(s.replace(/-/g,'/'))
      return trySlash
    },
    getList() {
      this.loading = true
      listRoom(this.queryParams)
        .then(r=>{
          this.roomList = r && r.rows ? r.rows : [];
          this.total = r && r.total ? r.total : 0;
          this.prefetchOccupy();
          this.$nextTick(()=> this.syncCurrentRow())
        })
        .catch(e=>{ console.error(e); this.roomList=[]; this.total=0; this.$modal && this.$modal.msgError && this.$modal.msgError('加载失败') })
        .finally(()=>{ this.loading=false })
    },
    // 预取当前页所有会议室的占用列表
    prefetchOccupy(){
      if(!this.canSeeOccupy) return
      const ids = (this.roomList || []).map(i=>i.roomId).filter(Boolean)
      ids.forEach(id=> this.fetchRoomOccupy(id))
    },
    refreshSchedule(){
      if(!this.canSeeOccupy) return
      if(this.selectedRoomId){
        this.fetchRoomOccupy(this.selectedRoomId)
      } else {
        this.prefetchOccupy()
      }
    },
    fetchRoomOccupy(roomId){
      if(!roomId) return
      if(!this.canSeeOccupy){
        this.$set(this.occupyMap, roomId, { loading:false, list:[], fetched:true })
        return
      }
      if(!this.occupyMap[roomId]) this.$set(this.occupyMap, roomId, { loading:true, list:[], fetched:false })
      else {
        this.occupyMap[roomId].loading = true
        this.occupyMap[roomId].fetched = false
      }

      const tasks = []
      if(this.hasResvListPerm){
        tasks.push(listReservation({ pageNum:1, pageSize:50, roomId }))
      }
      if(this.hasDetailListPerm){
        // 仅取已审批通过的申请明细
        tasks.push(listRequestDetail({ pageNum:1, pageSize:50, roomId, status: 'APPROVED' }))
      }

      Promise.all(tasks).then(resArr=>{
        const merged = []
        resArr.forEach(r=>{ const rows = (r && (r.rows || r.data && r.data.rows)) ? (r.rows || r.data.rows) : []; if(Array.isArray(rows)) merged.push(...rows) })
        // 只保留已通过
        const approved = merged.filter(this.isApprovedRow)
        approved.sort((a,b)=> this.parseTs(a.startTime) - this.parseTs(b.startTime))
        this.$set(this.occupyMap, roomId, { loading:false, list: approved, fetched:true })
      }).catch(()=>{
        this.$set(this.occupyMap, roomId, { loading:false, list:[], fetched:true })
      })
    },
    // 仅返回“当前及未来”的占用，使用统一解析，多个时段全部展示
    getFutureOccupy(roomId){
      const all = (this.occupyMap[roomId] && this.occupyMap[roomId].list) || []
      if(!all.length) return []
      const now = Date.now()
      return all.filter(x=>{
        const end = this.parseTs(x.endTime)
        return isFinite(end) ? end >= now : true
      })
    },
    handleSelectionChange(sel){ this.ids = sel.map(i=>i.roomId); this.single = sel.length!==1; this.multiple = !sel.length },
    handleQuery(){ this.queryParams.pageNum=1; this.getList() },
    resetQuery(){ this.resetForm('queryForm'); this.handleQuery() },
    handleAdd(){ this.reset(); this.isEdit=false; this.open=true; this.title='新增会议室' },
    handleUpdate(row){ const id = (row && row.roomId) || this.ids[0]; if(!id){ this.$modal.msgWarning('请选择一条数据'); return } this.reset(); getRoom(id).then(r=>{ this.form = r.data || {}; this.isEdit=true; this.open=true; this.title='修改会议室' }) },
    submitForm(){ this.$refs['form'].validate(valid=>{ if(!valid) return; const payload={ ...this.form, roomId:(this.form.roomId||'').trim() }; if(!payload.roomId){ this.$modal.msgError('会议室编号不能为空'); return } (this.isEdit? apiUpdateRoom(payload): addRoom(payload)).then(()=>{ this.$modal.msgSuccess(this.isEdit?'修改成功':'新增成功'); this.open=false; this.getList() }) }) },
    handleDelete(row){ const ids = row && row.roomId ? row.roomId : this.ids; if(!ids || (Array.isArray(ids)&&!ids.length)){ this.$modal.msgWarning('请选择要删除的数据'); return } this.$modal.confirm('确认删除选中会议室吗？').then(()=>delRoom(ids)).then(()=>{ this.$modal.msgSuccess('删除成功'); this.getList() }).catch(()=>{}) },
    handleExport(){ this.download('meeting/room/export', { ...this.queryParams }, `room_${Date.now()}.xlsx`) },
    cancel(){ this.open=false; this.reset() },
    reset(){ this.form = { roomId:null, capacity:null, location:null }; this.resetForm && this.resetForm('form') },
    quickApply(row){ this.openApply([row.roomId], []) },
    applySelected(){ if(!this.ids.length){ this.$modal.msgWarning('请勾选会议室'); return } this.openApply(this.ids, []) },
    openApply(roomIds, range){
      this.applyForm={ roomIds:[...roomIds], range:[...(range||[])], remark:'' }
      this.applyConflicts=[]
      this.applyOpen=true
      this.$nextTick(()=> this.loadApplyOccupy())
    },
    // 加载所选会议室的占用时段
    loadApplyOccupy(){
      const ids = this.applyForm.roomIds || []
      this.applyOccupy=[]
      if(!ids.length){ return }
      this.applyOccupyLoading=true
      const perRoomTasks = ids.map(id=>{
        const tasks=[]
        if(this.hasResvListPerm){ tasks.push(listReservation({ pageNum:1, pageSize:50, roomId:id }).then(r=>{ const rows=(r && (r.rows || (r.data && r.data.rows))) ? (r.rows || r.data.rows) : []; rows.forEach(x=> x.roomId = id); return rows }).catch(()=>[])) }
        if(this.hasDetailListPerm){ tasks.push(listRequestDetail({ pageNum:1, pageSize:50, roomId:id, status:'APPROVED' }).then(r=>{ const rows=(r && (r.rows || (r.data && r.data.rows))) ? (r.rows || r.data.rows) : []; rows.forEach(x=>{ if(x && x.roomId==null) x.roomId = id }); return rows }).catch(()=>[])) }
        if(!tasks.length) return Promise.resolve([])
        return Promise.all(tasks).then(parts=>[].concat(...parts)).catch(()=>[])
      })
      Promise.all(perRoomTasks)
        .then(listSets=>{
          const merged = [].concat(...listSets).filter(this.isApprovedRow)
          // 标准化时间字段
          merged.forEach(it=>{ if(it && it.startTime == null && it.start_time != null) it.startTime = it.start_time; if(it && it.endTime == null && it.end_time != null) it.endTime = it.end_time })
          merged.sort((a,b)=>{
            if(a.roomId!==b.roomId) return String(a.roomId).localeCompare(String(b.roomId))
            return this.parseTs(a.startTime) - this.parseTs(b.startTime)
          })
          this.applyOccupy = merged
        })
        .finally(()=>{ this.applyOccupyLoading=false })
    },
    // 移除手动冲突检测按钮逻辑，提交时自动检测
    submitApply(){
      this.$refs['applyFormRef'].validate(valid=>{
        if(!valid) return
        const [s,e] = this.applyForm.range
        const roomIds = this.applyForm.roomIds
        this.applySubmitting = true
        this.applyConflicts = []
        // 提交前自动冲突检测
        conflictCheck({ roomIds, startTime:s, endTime:e })
          .then(r=>{
            const conflicts = (r && r.data) ? r.data : []
            if(conflicts.length){
              this.applyConflicts = conflicts
              this.$modal.msgError('存在冲突，请调整时间或会议室后再提交')
              this.applySubmitting = false
              return
            }
            // 无冲突，继续提交
            this.doSubmitApply()
          })
          .catch(()=>{ this.$modal.msgError('冲突检测失败，请稍后重试') })
          .finally(()=>{ if(!this.applyConflicts.length){ /* 正常提交时在 doSubmitApply 里关闭 */ } })
      })
    },
    doSubmitApply(){ const [s,e]=this.applyForm.range; submitRequest({ applicantId:this.$store.getters.id, roomIds:this.applyForm.roomIds, startTime:s, endTime:e, remark:this.applyForm.remark }).then(()=>{ this.$modal.msgSuccess('提交成功'); this.applyOpen=false }).finally(()=>{ this.applySubmitting=false }) },
    // 计算当前是否占用
    isOccupiedNow(roomId){
      const m = this.occupyMap[roomId]
      const list = (m && m.list) ? m.list : []
      if(!list.length) return false
      const now = Date.now()
      const toTs = (v)=>{
        // 复用 parseTs 若存在
        return typeof this.parseTs === 'function' ? this.parseTs(v) : Date.parse(String(v).replace(' ','T'))
      }
      return list.some(x=>{ const s=toTs(x.startTime); const e=toTs(x.endTime); return isFinite(s)&&isFinite(e) && s <= now && now < e })
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
    computeCurrentOccupyInfo(roomId, nowTs){
      if(!roomId || !this.occupyMap) return null
      const entry = this.occupyMap[roomId]
      const list = entry && Array.isArray(entry.list) ? entry.list : []
      if(!list.length) return null
      const now = typeof nowTs === 'number' ? nowTs : Date.now()
      let target = null
      for(const item of list){
        if(!item) continue
        const startTs = this.parseTs(item.startTime != null ? item.startTime : item.start_time)
        const endTs = this.parseTs(item.endTime != null ? item.endTime : item.end_time)
        if(!isFinite(startTs) || !isFinite(endTs)) continue
        if(startTs <= now && now < endTs){
          target = { item, startTs, endTs }
          break
        }
      }
      if(!target) return null
      const { item, startTs, endTs } = target
      const applicant = this.pickFirstNonEmpty(item, ['applicantName','applicant','applyUser','apply_user','userName','user_name'])
      const approver = this.pickFirstNonEmpty(item, ['adminName','approverName','approver','approveUser','approve_user','handlerName','handler_name'])
      const rawStart = item.startTime != null ? item.startTime : item.start_time
      const rawEnd = item.endTime != null ? item.endTime : item.end_time
      const startValue = rawStart != null && rawStart !== '' ? rawStart : startTs
      const endValue = rawEnd != null && rawEnd !== '' ? rawEnd : endTs
      return {
        applicant: applicant || '--',
        approver: approver || '--',
        start: this.formatDateTimeString(startValue),
        end: this.formatDateTimeString(endValue)
      }
    },
    pickFirstNonEmpty(obj, keys){
      if(!obj || !Array.isArray(keys)) return ''
      for(const key of keys){
        if(!key) continue
        const val = obj[key]
        if(val === undefined || val === null) continue
        const str = String(val).trim()
        if(str) return str
      }
      return ''
    },
    formatDateTimeString(value){
      if(value == null || value === '') return '--'
      const ts = this.parseTs(value)
      if(!isFinite(ts)) return String(value)
      const d = new Date(ts)
      if(isNaN(d.getTime())) return String(value)
      const y = d.getFullYear()
      const m = `${d.getMonth() + 1}`.padStart(2,'0')
      const day = `${d.getDate()}`.padStart(2,'0')
      const h = `${d.getHours()}`.padStart(2,'0')
      const min = `${d.getMinutes()}`.padStart(2,'0')
      return `${y}-${m}-${day} ${h}:${min}`
    },
    resolveRemark(item){
      if(!item) return ''
      const remark = item.remark || item.reason || item.purpose || item.applyReason || item.title || ''
      return remark ? String(remark) : ''
    },
    // 仅保留已审批通过（或无status的预约记录）
    isApprovedRow(x){ const s=(x&&x.status)||''; return !s || s==='APPROVED' }
  }
}
</script>

<style scoped>
.meeting-room-page {
  padding-bottom: 0;
}

.filter-form {
  margin-bottom: 16px;
}

.room-layout {
  display: flex;
  flex-wrap: wrap;
}

.room-left,
.room-right {
  display: flex;
  flex-direction: column;
  min-width: 260px;
}

.room-left {
  max-width: 420px;
}

.room-right {
  min-width: 520px;
}

.action-bar {
  align-items: center;
}

.left-actions .el-button + .el-button {
  margin-left: 8px;
}

.toolbar-col {
  text-align: right;
}

.occupy-list {
  display: flex;
  align-items: center;
  flex-wrap: wrap;
  gap: 4px;
}

.occupy-list .el-tag {
  margin-right: 4px;
  margin-bottom: 4px;
}

.schedule-card {
  height: 100%;
  display: flex;
  flex-direction: column;
}

.schedule-card ::v-deep .el-card__body {
  padding: 12px 16px;
}

.schedule-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  font-weight: 600;
}

.schedule-header-left {
  display: flex;
  align-items: center;
  gap: 8px;
}

.schedule-header-actions {
  display: flex;
  align-items: center;
  gap: 8px;
}

.schedule-day-select {
  width: 110px;
}

.schedule-context {
  font-size: 12px;
  color: #909399;
  font-weight: 400;
}

.schedule-body {
  flex: 1;
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.schedule-days-wrap {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
  gap: 8px;
  width: 100%;
  align-items: stretch;
}

.schedule-day-box {
  min-width: 0;
  background: #f9fafc;
  border: 1px solid #ebeef5;
  border-radius: 8px;
  padding: 8px;
  box-sizing: border-box;
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.schedule-day-content {
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.schedule-item {
  background: #fff;
  border: 1px solid #ebeef5;
  border-radius: 6px;
  padding: 6px 6px;
  box-shadow: 0 1px 2px rgba(31, 35, 41, 0.04);
}

.schedule-day-title {
  font-size: 13px;
}

.schedule-item-time {
  font-weight: 600;
  color: #303133;
}

.schedule-item-room {
  color: #606266;
  font-size: 12px;
  margin-top: 4px;
}

.schedule-item-remark {
  color: #909399;
  font-size: 12px;
  margin-top: 4px;
}

.schedule-empty {
  margin: 8px 0;
  padding: 8px 0;
}

.schedule-empty ::v-deep .el-empty {
  padding: 12px 0;
}

.schedule-empty ::v-deep .el-empty__image {
  width: 90px;
}

.schedule-empty ::v-deep .el-empty__description {
  font-size: 12px;
  margin-top: 4px;
}

.occupy-tooltip {
  min-width: 220px;
  line-height: 1.6;
  font-size: 12px;
}

::v-deep .is-selected-room > td {
  background-color: #f5f7fa !important;
}

@media (max-width: 1200px) {
  .room-right {
    margin-top: 16px;
    min-width: auto;
  }

  .schedule-body {
    max-height: none;
  }
}

@media (max-width: 1100px) {
  .schedule-days-wrap {
    grid-template-columns: repeat(2, minmax(0, 1fr));
  }
}

@media (max-width: 780px) {
  .schedule-days-wrap {
    grid-template-columns: repeat(1, minmax(0, 1fr));
  }
}
</style>
