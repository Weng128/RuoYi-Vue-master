<template>
  <div class="app-container">
    <el-page-header @back="goBack" content="提交会议室申请" class="mb15" />

    <el-form ref="formRef" :model="form" :rules="rules" label-width="100px">
      <el-form-item label="申请人">
        <el-input v-model="form.applicantId" disabled />
      </el-form-item>
      <el-form-item label="模式" prop="mode">
        <el-radio-group v-model="form.mode">
          <el-radio label="UNIFY">统一时段</el-radio>
          <el-radio label="SLOTS">独立时段</el-radio>
        </el-radio-group>
      </el-form-item>
      <!-- 统一时段模式 -->
      <template v-if="form.mode==='UNIFY'">
        <el-form-item label="选择会议室" prop="roomIds">
          <el-select v-model="form.roomIds" multiple filterable placeholder="请选择会议室" style="width:100%">
            <el-option v-for="r in roomOptions" :key="r.roomId" :label="r.roomId + (r.name?' - '+r.name:'')" :value="r.roomId" />
          </el-select>
        </el-form-item>
        <el-form-item label="时间范围" prop="range">
          <el-date-picker v-model="form.range" type="datetimerange" range-separator="至" start-placeholder="开始" end-placeholder="结束" value-format="yyyy-MM-dd HH:mm" style="width:100%" />
        </el-form-item>
      </template>
      <!-- 多时段模式 -->
      <template v-else>
        <el-form-item label="时段列表" required>
          <el-table :data="form.slots" size="mini" border style="width:100%">
            <el-table-column label="会议室" width="160">
              <template slot-scope="scope">
                <el-select v-model="scope.row.roomId" placeholder="会议室" filterable style="width:150px">
                  <el-option v-for="r in roomOptions" :key="r.roomId" :label="r.roomId + (r.name?' - '+r.name:'')" :value="r.roomId" />
                </el-select>
              </template>
            </el-table-column>
            <el-table-column label="开始时间" width="200">
              <template slot-scope="scope">
                <el-date-picker v-model="scope.row.startTime" type="datetime" placeholder="开始" value-format="yyyy-MM-dd HH:mm" style="width:190px" />
              </template>
            </el-table-column>
            <el-table-column label="结束时间" width="200">
              <template slot-scope="scope">
                <el-date-picker v-model="scope.row.endTime" type="datetime" placeholder="结束" value-format="yyyy-MM-dd HH:mm" style="width:190px" />
              </template>
            </el-table-column>
            <el-table-column label="操作" width="90">
              <template slot-scope="scope">
                <el-button type="text" size="mini" @click="removeSlot(scope.$index)" :disabled="submitting">移除</el-button>
              </template>
            </el-table-column>
          </el-table>
          <el-button class="mt5" type="primary" size="mini" icon="el-icon-plus" @click="addSlot" :disabled="submitting">添加时段</el-button>
        </el-form-item>
      </template>

      <el-form-item label="申请备注">
        <el-input type="textarea" v-model="form.remark" :rows="3" placeholder="可填写用途、参与人数等" />
      </el-form-item>

      <el-form-item label="冲突检测">
        <el-button type="warning" size="mini" icon="el-icon-warning" @click="doConflictCheck" :disabled="submitting">检测</el-button>
        <span v-if="conflicts.length===0 && conflictChecked" class="ok-text">无冲突</span>
      </el-form-item>
      <el-form-item v-if="conflicts.length" label="冲突结果">
        <el-alert :title="'发现 '+conflicts.length+' 条冲突'" type="error" :closable="false" />
        <el-table :data="conflicts" size="mini" border class="mt5" max-height="260">
          <el-table-column prop="sourceType" label="来源" width="100" />
            <el-table-column prop="roomId" label="会议室" width="120" />
            <el-table-column label="开始" width="170">
              <template slot-scope="scope">{{ formatDisplayTime(scope.row.startTime || scope.row.start_time) }}</template>
            </el-table-column>
            <el-table-column label="结束" width="170">
              <template slot-scope="scope">{{ formatDisplayTime(scope.row.endTime || scope.row.end_time) }}</template>
            </el-table-column>
        </el-table>
      </el-form-item>

      <el-form-item>
        <el-button type="primary" icon="el-icon-check" @click="submit" :loading="submitting" :disabled="submitting">提 交</el-button>
        <el-button icon="el-icon-back" @click="goBack" :disabled="submitting">返 回</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>
<script>
import { listRoom } from '@/api/meeting/room'
import { submitRequest, conflictCheck } from '@/api/meeting/request'
export default {
  name:'MeetingRequestSubmit',
  data(){
    return {
      roomOptions:[],
      conflictChecked:false,
      conflicts:[],
      form:{ applicantId:null, mode:'UNIFY', roomIds:[], range:[], slots:[], remark:'' },
      rules:{
        mode:[{ required:true }],
        roomIds:[{ validator:(r,v,cb)=>{ if(this.form.mode!=='UNIFY') return cb(); if(!v||!v.length) cb(new Error('请选择会议室')); else cb(); }, trigger:'change' }],
        range:[{ validator:(r,v,cb)=>{ if(this.form.mode!=='UNIFY') return cb(); if(!v||v.length!==2) cb(new Error('请选择时间范围')); else cb(); }, trigger:'change' }]
      },
      pendingQuery:null,
      submitting:false
    }
  },
  created(){
    this.form.applicantId=this.$store.getters.id
    this.pendingQuery={...this.$route.query}
    this.loadRooms()
  },
  methods:{
    prefillFromQuery(){
      if(!this.pendingQuery) return
      const q=this.pendingQuery
      if(q.mode && (q.mode==='UNIFY'||q.mode==='SLOTS')) this.form.mode=q.mode
      if(q.roomIds){
        const arr=String(q.roomIds).split(',').filter(Boolean)
        if(arr.length) this.form.roomIds=arr
      }
      if(q.start && q.end){ this.form.range=[q.start,q.end] }
      this.pendingQuery=null
    },
    goBack(){ this.$router.back() },
    loadRooms(){ listRoom({pageNum:1,pageSize:500}).then(r=>{ this.roomOptions=r.rows||[]; this.$nextTick(()=>this.prefillFromQuery()) }) },
    addSlot(){ this.form.slots.push({ roomId:null, startTime:null, endTime:null }) },
    removeSlot(i){ this.form.slots.splice(i,1) },
    validateSlots(){
      if(this.form.mode==='SLOTS'){
        if(!this.form.slots.length) { this.$modal.msgError('请添加至少一个时段'); return false }
        for(const s of this.form.slots){ if(!s.roomId||!s.startTime||!s.endTime){ this.$modal.msgError('时段信息不完整'); return false } }
      }
      return true
    },
    doConflictCheck(){
      this.conflictChecked=false
      if(this.form.mode==='UNIFY'){
        if(!this.form.roomIds.length || this.form.range.length!==2){ this.$modal.msgError('请先选择会议室与时间范围'); return }
        const [s,e]=this.form.range
        conflictCheck({ roomIds:this.form.roomIds, startTime:s, endTime:e }).then(r=>{ this.conflicts=r.data||[]; this.conflictChecked=true; if(!this.conflicts.length) this.$modal.msgSuccess('无冲突') })
      } else {
        if(!this.validateSlots()) return
        conflictCheck({ slots:this.form.slots }).then(r=>{ this.conflicts=r.data||[]; this.conflictChecked=true; if(!this.conflicts.length) this.$modal.msgSuccess('无冲突') })
      }
    },
    submit(){
      this.$refs['formRef'].validate(v=>{
        if(!v) return
        if(this.form.mode==='SLOTS' && !this.validateSlots()) return
        const confirmSubmit = ()=>{
          if(this.form.mode==='UNIFY'){
            const [s,e]=this.form.range
            submitRequest({ applicantId:this.form.applicantId, roomIds:this.form.roomIds, startTime:s, endTime:e, remark:this.form.remark }).then(()=>{ this.$modal.msgSuccess('提交成功'); this.goBack() }).finally(()=>{ this.submitting=false })
          } else {
            submitRequest({ applicantId:this.form.applicantId, slots:this.form.slots, remark:this.form.remark }).then(()=>{ this.$modal.msgSuccess('提交成功'); this.goBack() }).finally(()=>{ this.submitting=false })
          }
        }
        this.submitting = true
        if(this.conflicts.length){ this.$modal.confirm('存在冲突，仍然提交？').then(()=>confirmSubmit()).catch(()=>{ this.submitting=false }) } else { confirmSubmit() }
      })
    },
    formatDisplayTime(value){
      if(value == null) return '--'
      const s = String(value).trim()
      if(!s) return '--'
      const tryIso = Date.parse(s.replace(' ', 'T'))
      const ts = !isNaN(tryIso) ? tryIso : Date.parse(s.replace(/-/g,'/'))
      if(!isNaN(ts)){
        const d = new Date(ts)
        const pad = (n)=> (n<10? '0' : '') + n
        return `${d.getFullYear()}-${pad(d.getMonth()+1)}-${pad(d.getDate())} ${pad(d.getHours())}:${pad(d.getMinutes())}`
      }
      return s
    }
  }
}
</script>
<style scoped>
.mb15{margin-bottom:15px}
.mt5{margin-top:5px}
.ok-text{color:#67c23a;margin-left:10px;font-size:12px}
</style>
