<template>
  <div class="app-container">
    <!-- 查询条件 -->
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="70px">
      <el-form-item label="申请人" prop="applicantName">
        <el-input v-model="queryParams.applicantName" placeholder="请输入申请人名字" clearable @keyup.enter.native="handleQuery" />
      </el-form-item>
      <el-form-item label="会议室" prop="roomId">
        <el-input v-model="queryParams.roomId" placeholder="请输入会议室编号" clearable @keyup.enter.native="handleQuery" />
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select v-model="queryParams.status" clearable placeholder="状态">
          <el-option label="待审批" value="PENDING" />
          <el-option label="已通过" value="APPROVED" />
          <el-option label="已拒绝" value="REJECTED" />
        </el-select>
      </el-form-item>
      <el-form-item label="时间范围" prop="timeRange">
                <el-date-picker
                  v-model="queryParams.timeRange"
                  type="datetimerange"
                  range-separator="-"
                  start-placeholder="开始"
                  end-placeholder="结束"
                  value-format="yyyy-MM-dd HH:mm"
                  format="yyyy-MM-dd HH:mm"
                  :default-time="['00:00:00','23:59:00']"
                />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList" />
    </el-row>

    <el-table v-loading="loading" :data="list">
      <el-table-column label="申请人" width="70" align="center">
        <template slot-scope="scope">{{ scope.row.applicantName || scope.row.applicantId }}</template>
      </el-table-column>
      <el-table-column label="申请时间" width="140" align="center">
        <template slot-scope="scope">{{ formatDateTime(scope.row.createTime || scope.row.create_time) }}</template>
      </el-table-column>      
      <el-table-column label="会议室" width="70" align="center">
        <template slot-scope="scope">{{ getRoomsText(scope.row.requestId) }}</template>
      </el-table-column>      
      <el-table-column label="预约时段" width="260" align="center">
        <template slot-scope="scope">{{ getReservationRange(scope.row.requestId) }}</template>
      </el-table-column>
      <el-table-column label="用途" prop="remark" min-width="120" show-overflow-tooltip />
      <el-table-column label="审批人" align="center" width="70">
        <template slot-scope="scope">{{ scope.row.adminName || (scope.row.adminId || '-') }}</template>
      </el-table-column>
      <el-table-column label="审批时间" width="140" align="center">
        <template slot-scope="scope">{{ formatDateTime(scope.row.decisionTime || scope.row.decision_time) }}</template>
      </el-table-column>
      <el-table-column label="审批意见" min-width="100" align="center" show-overflow-tooltip>
        <template slot-scope="scope">{{ scope.row.decisionRemark || '-' }}</template>
      </el-table-column>
      <el-table-column label="状态" prop="status" width="100" align="center">
        <template slot-scope="scope">
          <el-tag v-if="(scope.row.status||'')==='PENDING'" type="warning">待审批</el-tag>
          <el-tag v-else-if="scope.row.status==='APPROVED'" type="success">已通过</el-tag>
          <el-tag v-else type="danger">已拒绝</el-tag>
        </template>
      </el-table-column>
  <el-table-column label="操作" width="150" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button size="mini" type="text" icon="el-icon-circle-check" @click="openApprove(scope.row)" :disabled="(scope.row.status||'')!=='PENDING'">审批</el-button>
          <el-button size="mini" type="text" icon="el-icon-delete" @click="handleDelete(scope.row)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination v-show="total>0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList" />

    <!-- 审批对话框（简化：仅统一时段） -->
    <el-dialog :title="approveForm.title" :visible.sync="approveOpen" width="820px" append-to-body>
      <el-form ref="approveFormRef" :model="approveForm" :rules="approveRules" label-width="90px">
        <el-form-item v-if="approveSummary.length" label="原申请">
          <el-table :data="approveSummary" size="mini" border style="width:100%" max-height="200">
            <el-table-column prop="applicantName" label="申请人" width="60" />
            <el-table-column label="申请时间" width="120">
              <template slot-scope="scope">{{ formatDateTime(scope.row.createTime) }}</template>
            </el-table-column>
            <el-table-column prop="rooms" label="会议室" width="70" />
            <el-table-column prop="reservationRange" label="预约时段" min-width="180" />
            <el-table-column prop="remark" label="用途" min-width="160" show-overflow-tooltip />
          </el-table>
        </el-form-item>
        <el-form-item label="会议室" prop="roomIds">
          <el-select v-model="approveForm.roomIds" multiple placeholder="选择房间" filterable style="width:100%">
            <el-option v-for="r in roomOptions" :key="r.roomId" :label="r.roomId" :value="String(r.roomId)" />
          </el-select>
        </el-form-item>
        <!-- 替换原“时间范围”一行，为“开始时间/结束时间���两行（年月日、时、分分列选择） -->
        <el-form-item label="开始时间" prop="range">
          <div class="approve-range-line">
            <el-date-picker v-model="approveForm.startDate" type="date" :picker-options="recentMonthOptions" value-format="yyyy-MM-dd" placeholder="开始日期" style="width: 140px" />
            <el-select v-model="approveForm.startHour" placeholder="小时" style="width:88px; margin-left:8px">
              <el-option v-for="h in hoursOptions" :key="'sh-'+h" :label="h" :value="h" />
            </el-select>
            <el-select v-model="approveForm.startMinute" placeholder="分钟" style="width:88px; margin-left:8px">
              <el-option v-for="m in minutes10Options" :key="'sm-'+m" :label="m" :value="m" />
            </el-select>
          </div>
        </el-form-item>
        <el-form-item label="结束时间" prop="range">
          <div class="approve-range-line">
            <el-date-picker v-model="approveForm.endDate" type="date" :picker-options="recentMonthOptions" value-format="yyyy-MM-dd" placeholder="结束日期" style="width: 140px" />
            <el-select v-model="approveForm.endHour" placeholder="小时" style="width:88px; margin-left:8px">
              <el-option v-for="h in hoursOptions" :key="'eh-'+h" :label="h" :value="h" />
            </el-select>
            <el-select v-model="approveForm.endMinute" placeholder="分钟" style="width:88px; margin-left:8px">
              <el-option v-for="m in minutes10Options" :key="'em-'+m" :label="m" :value="m" />
            </el-select>
          </div>
        </el-form-item>
        <el-form-item label="审批备注">
          <el-input type="textarea" v-model="approveForm.decisionRemark" :rows="3" placeholder="可填写说明" :disabled="approveSubmitting" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitApprove" :loading="approveSubmitting" :disabled="approveSubmitting || rejectSubmitting">通 过</el-button>
        <el-button type="danger" @click="submitReject" :loading="rejectSubmitting" :disabled="approveSubmitting || rejectSubmitting">拒 绝</el-button>
      </div>
    </el-dialog>
  </div>
</template>
<script>
import { listRequest, listDetails, approveRequest, rejectRequest, listRequestDetail, delRequest } from '@/api/meeting/request'
import { listRoom } from '@/api/meeting/room'
import { addDateRange } from '@/utils/ruoyi'

const getDefaultTimeRange = () => {
  const pad = n => (n < 10 ? '0' : '') + n
  const now = new Date()
  const start = new Date(now.getTime())
  start.setHours(0, 0, 0, 0)
  const end = new Date(start.getTime() + 6 * 24 * 60 * 60 * 1000)
  end.setHours(23, 59, 0, 0)
  const format = d => `${d.getFullYear()}-${pad(d.getMonth() + 1)}-${pad(d.getDate())} ${pad(d.getHours())}:${pad(d.getMinutes())}`
  return [format(start), format(end)]
}
export default {
  name:'RequestApprove',
  data(){
    return {
  loading:false, showSearch:true, list:[], total:0,
      queryParams:{ pageNum:1, pageSize:10, applicantName:null, status:null, roomId:null, timeRange:getDefaultTimeRange() },
      detailOpen:false, detailList:[],
      approveOpen:false,
      approveForm:{ requestId:null, roomIds:[], range:[], startDate:'', startHour:'', startMinute:'', endDate:'', endHour:'', endMinute:'', decisionRemark:'', title:'审批申请' },
      // 小时与分钟选项
      hoursOptions: Array.from({length:24}, (_,i)=> (i<10? '0'+i : ''+i)),
      minutes10Options: Array.from({ length:6 }, (_, i)=> { const v = i * 10; return v<10 ? '0'+v : ''+v }),
      // 近一月日期限制
      recentMonthOptions:{
        disabledDate:(time)=>{
          const now = new Date();
          const dayMs = 24*60*60*1000;
          const minTs = now.getTime() - 30*dayMs; // 过去30天
          const maxTs = now.getTime() + 30*dayMs; // 未来30天
          const t = time.getTime();
          return t < minTs || t > maxTs;
        }
      },
      approveRules:{
        roomIds:[{ required:true, message:'请选择房间', trigger:'change' }],
        range:[{ validator:(r,v,cb)=>{
          if(!v||v.length!==2) return cb(new Error('请选择时间范围'));
          const s=this.parseTs(v[0]); const e=this.parseTs(v[1]);
          if(!isFinite(s)||!isFinite(e)) return cb(new Error('时间格式不正确'));
          if(e<=s) return cb(new Error('结束时间必须晚于开始时间'));
          cb();
        }, trigger:'change'}]
      },
  roomOptions:[],
  originalDetails:[],
  approveSummary:[],
      approveSubmitting:false, rejectSubmitting:false,
      detailsMap: Object.create(null),
    }
  },
  created(){ this.getList(); this.loadRooms(); },
  watch:{
    // 替换原 watchers，监听开始/结束的年月日、时、分
    'approveForm.startDate': function(){ this.composeApproveRange() },
    'approveForm.startHour': function(){ this.composeApproveRange() },
    'approveForm.startMinute': function(){ this.composeApproveRange() },
    'approveForm.endDate': function(){ this.composeApproveRange() },
    'approveForm.endHour': function(){ this.composeApproveRange() },
    'approveForm.endMinute': function(){ this.composeApproveRange() }
  },
  methods:{
  // 解析 yyyy-MM-dd HH:mm(:ss) 或 10/13位时间戳
    parseTs(v){ if(v==null) return NaN; if(typeof v==='number') return v>1e12?v:v*1000; const s=String(v).trim(); if(/^\d{10}$/.test(s)) return parseInt(s,10)*1000; if(/^\d{13}$/.test(s)) return parseInt(s,10); const iso=Date.parse(s.replace(' ','T')); if(!isNaN(iso)) return iso; return Date.parse(s.replace(/-/g,'/')); },
    // 将分钟值按指定步进（默认10分钟）对齐，返回两位字符串
    roundMinuteStep(min, mode, stepMinutes = 10){
      const step = Math.max(1, Number(stepMinutes) || 10)
      const n = Number(min)
      if(!isFinite(n) || n < 0) return '00'
      let v
      if(mode === 'ceil') { v = Math.ceil(n / step) * step }
      else if(mode === 'floor') { v = Math.floor(n / step) * step }
      else { v = Math.round(n / step) * step }
      const max = 60 - step
      if(v > max) v = max
      if(v < 0) v = 0
      return v < 10 ? '0' + v : '' + v
    },
    loadRooms(){ listRoom({pageNum:1,pageSize:500}).then(r=>{ this.roomOptions=r.rows||[] }) },
    getList(){
      this.loading=true;
      // 基础查询参数（转换为按申请创建时间筛选）
      const baseParams = addDateRange({ ...this.queryParams }, this.queryParams.timeRange, 'CreateTime')
      delete baseParams.timeRange

      const base = listRequest(baseParams)
      const needDetailFilter = !!this.queryParams.roomId
      if (needDetailFilter) {
        const detailQ = { pageNum:1, pageSize:1000, roomId: this.queryParams.roomId }
        Promise.all([base, listRequestDetail(detailQ)])
          .then(([reqRes, detRes])=>{
            // 原始申请列表
            let rows = reqRes.rows || []
            // 兜底：前端按申请人姓名再过滤一遍（若后端未支持）
            if (this.queryParams.applicantName) {
              const kw = this.queryParams.applicantName.trim()
              rows = rows.filter(x=> String(x.applicantName||'').includes(kw))
            }
            let detRows = (detRes && (detRes.rows || detRes.data && detRes.data.rows)) ? (detRes.rows || detRes.data.rows) : []
            const idSet = new Set(detRows.map(d=> d.requestId))
            const filtered = rows.filter(x=> idSet.has(x.requestId))
            this.list = filtered
            this.total = filtered.length || 0
            this.prefetchDetails()
          })
          .catch(()=>{ this.list=[]; this.total=0 })
          .finally(()=>{ this.loading=false })
      } else {
        base.then(r=>{
          let rows = r.rows || []
          if (this.queryParams.applicantName) {
            const kw = this.queryParams.applicantName.trim()
            rows = rows.filter(x=> String(x.applicantName||'').includes(kw))
          }
          this.list = rows
          this.total = r.total || rows.length || 0
          this.prefetchDetails()
        }).catch(()=>{ this.list=[]; this.total=0 }).finally(()=>{ this.loading=false })
      }
    },
    prefetchDetails(){ (this.list||[]).forEach(row=> this.fetchDetails(row.requestId)) },
    fetchDetails(requestId){ if(!requestId||this.detailsMap[requestId]) return; listDetails(requestId).then(r=>{ this.$set(this.detailsMap, requestId, (r.data||r.rows||[])) }).catch(()=>{ this.$set(this.detailsMap, requestId, []) }) },
    getRoomsText(requestId){ const list = this.detailsMap[requestId]; if(!list) return '加载中...'; if(!list.length) return '-'; const set = Array.from(new Set(list.map(i=> i.roomId))).filter(Boolean); return set.join('、') },
    getReservationRange(requestId){
      const list = this.detailsMap[requestId]
      if(!list) return '加载中...'
      if(!list.length) return '-'
      let earliest = null
      let latest = null
      list.forEach(item=>{
        if(!item) return
        const startVal = item.startTime || item.start_time
        const endVal = item.endTime || item.end_time
        const startTs = this.parseTs(startVal)
        const endTs = this.parseTs(endVal)
        if(isFinite(startTs) && (!earliest || startTs < earliest.ts)){
          earliest = { ts: startTs, text: startVal }
        }
        if(isFinite(endTs) && (!latest || endTs > latest.ts)){
          latest = { ts: endTs, text: endVal }
        }
      })
      if(!earliest || !latest) return '-'
      return `${this.formatDateTime(earliest.text)} ~ ${this.formatDateTime(latest.text)}`
    },
    formatDateTime(value){
      if(!value) return '-'
      const ts = this.parseTs(value)
      if(!isFinite(ts)) return String(value)
      const d = new Date(ts)
      const pad = n=> (n<10?'0':'')+n
      return `${d.getFullYear()}-${pad(d.getMonth()+1)}-${pad(d.getDate())} ${pad(d.getHours())}:${pad(d.getMinutes())}`
    },

    formatRoomsFromDetails(details){
      if(!Array.isArray(details) || !details.length) return '-'
      const rooms = Array.from(new Set(details.map(item=> item && item.roomId).filter(Boolean)))
      return rooms.length ? rooms.join('、') : '-'
    },
    formatRangeFromDetails(details){
      if(!Array.isArray(details) || !details.length) return '-'
      let earliest = null
      let latest = null
      details.forEach(item=>{
        if(!item) return
        const startTs = this.parseTs(item.startTime || item.start_time)
        const endTs = this.parseTs(item.endTime || item.end_time)
        if(isFinite(startTs) && (!earliest || startTs < earliest.ts)){
          earliest = { ts:startTs, text:item.startTime || item.start_time }
        }
        if(isFinite(endTs) && (!latest || endTs > latest.ts)){
          latest = { ts:endTs, text:item.endTime || item.end_time }
        }
      })
      if(!earliest || !latest) return '-'
      return `${this.formatDateTime(earliest.text)} ~ ${this.formatDateTime(latest.text)}`
    },

    handleQuery(){ this.queryParams.pageNum=1; this.getList() },
    resetQuery(){
      this.resetForm('queryForm');
      this.queryParams.timeRange = getDefaultTimeRange();
      this.handleQuery();
    },

    openApprove(row){
      this.resetApprove();
      this.approveForm.requestId=row.requestId;
      this.approveOpen=true;
      listDetails(row.requestId).then(r=>{
        const d=r.data||r.rows||[]; this.originalDetails=d;
        this.approveSummary=[{
          applicantName: row.applicantName || row.applicantId || '-',
          createTime: row.createTime || row.create_time || '',
          rooms: this.formatRoomsFromDetails(d),
          reservationRange: this.formatRangeFromDetails(d),
          remark: row.remark || '-'
        }]
        if(d && d.length){
          // 取最早开始、最晚结束，拆分成日期、小时、分钟
          let minS=Infinity, maxE=-Infinity, minV=null, maxV=null
          d.forEach(i=>{ const s=this.parseTs(i.startTime); const e=this.parseTs(i.endTime); if(isFinite(s)&&s<minS){ minS=s; minV=i.startTime } if(isFinite(e)&&e>maxE){ maxE=e; maxV=i.endTime } })
          const pad=n=> (n<10?'0':'')+n
          const toParts=(v)=>{ const dt=new Date(this.parseTs(v)); return { d:`${dt.getFullYear()}-${pad(dt.getMonth()+1)}-${pad(dt.getDate())}`, h:pad(dt.getHours()), m:pad(dt.getMinutes()) } }
          if(minV && maxV){
            const s = toParts(minV), e = toParts(maxV)
            // 钳制日期到近一月窗口
            this.approveForm.startDate=this.clampToRecentMonth(s.d)
            this.approveForm.endDate=this.clampToRecentMonth(e.d)
            // 分钟按10分步进对齐：开始向下取整，结束向上取整
            this.approveForm.startHour=s.h; this.approveForm.startMinute=this.roundMinuteStep(s.m, 'floor', 10)
            this.approveForm.endHour=e.h; this.approveForm.endMinute=this.roundMinuteStep(e.m, 'ceil', 10)
          }
          // 房间默认选中为申请所含房间
          this.approveForm.roomIds=[...new Set(d.map(i=> i && i.roomId != null ? String(i.roomId) : '').filter(Boolean))]
          this.$nextTick(()=>{
            this.composeApproveRange()
            if(this.$refs && this.$refs.approveFormRef){
              this.$refs.approveFormRef.clearValidate(['range','roomIds'])
            }
          })
        }
      })
    },
    resetApprove(){
  this.approveSubmitting=false; this.rejectSubmitting=false; this.originalDetails=[];
  this.approveForm={ requestId:null, roomIds:[], range:[], startDate:'', startHour:'', startMinute:'', endDate:'', endHour:'', endMinute:'', decisionRemark:'', title:'审批申请' }
  this.approveSummary=[]
    },
    composeApproveRange(){
      const { startDate, startHour, startMinute, endDate, endHour, endMinute } = this.approveForm
      if(startDate && startHour && startMinute && endDate && endHour && endMinute){
        this.approveForm.range = [ `${startDate} ${startHour}:${startMinute}`, `${endDate} ${endHour}:${endMinute}` ]
      } else { this.approveForm.range = [] }
    },
    // 将给定日期字符串（yyyy-MM-dd）钳制到近一月窗口内（±30天）
    clampToRecentMonth(dStr){
      if(!dStr) return dStr
      const pad=n=> (n<10?'0':'')+n
      const now = new Date();
      const min = new Date(now.getTime() - 30*24*60*60*1000)
      const max = new Date(now.getTime() + 30*24*60*60*1000)
  const ts = this.parseTs(`${dStr} 00:00`)
      if(!isFinite(ts)) return dStr
      if(ts < min.getTime()) return `${min.getFullYear()}-${pad(min.getMonth()+1)}-${pad(min.getDate())}`
      if(ts > max.getTime()) return `${max.getFullYear()}-${pad(max.getMonth()+1)}-${pad(max.getDate())}`
      return dStr
    },

    submitApprove(){ this.$refs['approveFormRef'].validate(valid=>{ if(!valid) return; this.approveSubmitting=true; this.doApprove(); }) },
    doApprove(){ const [s,e]=this.approveForm.range; approveRequest({ requestId:this.approveForm.requestId, roomIds:this.approveForm.roomIds, startTime:s, endTime:e, decisionRemark:this.approveForm.decisionRemark }).then(()=>{ this.$modal.msgSuccess('审批成功'); this.approveOpen=false; this.getList() }).finally(()=>{ this.approveSubmitting=false }) },
    submitReject(){
      if(!this.approveForm.requestId){ return }
      this.$modal.confirm('确认拒绝该申请吗？').then(()=>{
        this.rejectSubmitting=true
        rejectRequest({ requestId:this.approveForm.requestId, decisionRemark:this.approveForm.decisionRemark }).then(()=>{
          this.$modal.msgSuccess('已拒绝')
          this.approveOpen=false
          this.getList()
        }).finally(()=>{ this.rejectSubmitting=false })
      }).catch(()=>{})
    },
    handleDelete(row){
      if(!row || !row.requestId){ return }
      this.$modal.confirm(`是否确认删除申请编号"${row.requestId}"的数据项？`).then(()=>{
        return delRequest(row.requestId)
      }).then(()=>{
        this.$modal.msgSuccess('删除成功')
        this.getList()
      }).catch(()=>{})
    }
  }
}
</script>
<style scoped>
.mt5{margin-top:5px}
.approve-range-line{ display:flex; align-items:center; flex-wrap:wrap }
</style>
