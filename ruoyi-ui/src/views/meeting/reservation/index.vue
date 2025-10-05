<template>
  <div class="app-container">
    <!-- 查询条件 -->
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="70px">
      <el-form-item label="房间" prop="roomId">
        <el-input v-model="queryParams.roomId" placeholder="房间编号" clearable @keyup.enter.native="handleQuery" />
      </el-form-item>
      <el-form-item label="管理员" prop="adminId">
        <el-input v-model="queryParams.adminId" placeholder="管理员ID" clearable @keyup.enter.native="handleQuery" />
      </el-form-item>
      <el-form-item label="起止时间">
        <!-- 统一为秒级格式 -->
        <el-date-picker v-model="rangePicker" type="datetimerange" range-separator="至" start-placeholder="开始" end-placeholder="结束" value-format="yyyy-MM-dd HH:mm:ss" align="right" />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button type="primary" plain icon="el-icon-plus" size="mini" @click="openBatch">批量预留</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="danger" plain icon="el-icon-delete" size="mini" :disabled="multiple" @click="handleDelete">删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="warning" plain icon="el-icon-download" size="mini" @click="handleExport">导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList" />
    </el-row>

    <el-table v-loading="loading" :data="list" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="ID" prop="reserveId" align="center" width="90" />
      <el-table-column label="房间" prop="roomId" align="center" />
      <el-table-column label="开始时间" prop="startTime" align="center" width="160" />
      <el-table-column label="结束时间" prop="endTime" align="center" width="160" />
      <el-table-column label="管理员" align="center" width="120">
        <template slot-scope="scope">{{ displayUserName(scope.row.adminId) }}</template>
      </el-table-column>
      <el-table-column label="操作" align="center" width="120" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button size="mini" type="text" icon="el-icon-delete" @click="handleDelete(scope.row)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination v-show="total>0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList" />

    <!-- 批量预留弹窗 -->
    <el-dialog title="批量预留" :visible.sync="open" width="600px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="90px">
        <el-form-item label="房间列表" prop="roomIds">
          <el-select v-model="form.roomIds" multiple placeholder="选择房间" filterable style="width:100%">
            <el-option v-for="r in roomOptions" :key="r.roomId" :label="r.roomId + ' / ' + (r.location||'')" :value="r.roomId" />
          </el-select>
        </el-form-item>
        <el-form-item label="时间范围" required>
          <!-- 统一为秒级格式 -->
          <el-date-picker v-model="form.range" type="datetimerange" value-format="yyyy-MM-dd HH:mm:ss" start-placeholder="开始" end-placeholder="结束" style="width:100%" />
        </el-form-item>
        <!-- 冲突结果展示 -->
        <el-form-item v-if="reserveConflicts.length" label="冲突结果">
          <el-alert :title="'发现 '+reserveConflicts.length+' 条冲突'" type="error" :closable="false" />
          <el-table :data="reserveConflicts" size="mini" border style="margin-top:6px" max-height="220">
            <el-table-column prop="roomId" label="房间" width="120" />
            <el-table-column prop="startTime" label="开始" width="160" />
            <el-table-column prop="endTime" label="结束" width="160" />
            <el-table-column prop="sourceType" label="来源" width="100" />
          </el-table>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitReserve" :loading="reserveSubmitting" :disabled="reserveSubmitting">确 定</el-button>
        <el-button @click="cancel" :disabled="reserveSubmitting">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listReservation, delReservation, addReservation } from '@/api/meeting/reservation'
import { listRoom } from '@/api/meeting/room'
import { getUser } from '@/api/system/user'
// 新增：预留也做冲突校验，复用请求模块的 conflictCheck
import { conflictCheck } from '@/api/meeting/request'
export default {
  name: 'Reservation',
  data(){
    return {
      loading:false, showSearch:true, total:0, list:[], ids:[], single:true, multiple:true,
      rangePicker:[],
      queryParams:{ pageNum:1, pageSize:10, roomId:null, adminId:null },
      open:false, title:'',
      form:{ roomIds:[], range:[] },
      roomOptions:[],
      rules:{ roomIds:[{required:true,message:'请选择房间',trigger:'change'}], range:[{ validator:(r,v,cb)=>{ if(!v||v.length!==2) cb(new Error('请选择时间范围')); else cb(); }, trigger:'change'}] },
      // 用户名缓存
      adminNameMap:{}, _userReqPending:{},
      // 预留提交态与冲突结果
      reserveSubmitting:false,
      reserveConflicts:[]
    }
  },
  created(){ this.getList(); this.loadRooms() },
  methods:{
    loadRooms(){ listRoom({pageNum:1,pageSize:1000}).then(r=>{ this.roomOptions = r.rows||[] }) },
    getList(){
      this.loading=true
      const qp = {...this.queryParams}
      if(this.rangePicker && this.rangePicker.length===2){ qp.startTime = this.rangePicker[0]; qp.endTime = this.rangePicker[1]; }
      listReservation(qp).then(r=>{ this.list=r.rows; this.total=r.total; this.loading=false; this.prefetchUserNames(this.list) })
    },
    prefetchUserNames(rows){ const ids=[...new Set((rows||[]).map(x=>x.adminId).filter(Boolean))]; ids.forEach(id=> this.fetchUserName(id)) },
    fetchUserName(id){ if(!id) return; if(this.adminNameMap[id]||this._userReqPending[id]) return; this._userReqPending[id]=true; getUser(id).then(r=>{ const name=(r&&r.data&&(r.data.userName||r.data.nickName))||''; if(name) this.$set(this.adminNameMap,id,name) }).finally(()=>{ this.$delete(this._userReqPending,id) }) },
    displayUserName(id){ return this.adminNameMap[id] || (id==null?'-':id) },
    handleSelectionChange(sel){ this.ids=sel.map(i=>i.reserveId); this.single=sel.length!==1; this.multiple=!sel.length },
    handleQuery(){ this.queryParams.pageNum=1; this.getList() },
    resetQuery(){ this.resetForm('queryForm'); this.rangePicker=[]; this.handleQuery() },
    openBatch(){ this.reset(); this.open=true },
    reset(){ this.form={ roomIds:[], range:[] }; this.reserveConflicts=[]; this.reserveSubmitting=false; this.resetForm('form') },
    cancel(){ this.open=false; this.reset() },
    async submitReserve(){
      this.$refs['form'].validate(async v=>{
        if(!v) return
        const [s,e]=this.form.range
        const rooms=this.form.roomIds
        if(!rooms.length){ this.$modal.msgError('请选择房间'); return }
        this.reserveSubmitting=true
        this.reserveConflicts=[]
        try{
          // 提交前冲突检测
          const r = await conflictCheck({ roomIds: rooms, startTime: s, endTime: e })
          const conflicts = (r && r.data) ? r.data : []
          if(conflicts.length){
            this.reserveConflicts = conflicts
            this.$modal.msgError('存在冲突，请调整后再提交')
            return
          }
          // 无冲突，执行预留
          const reqs = rooms.map(rm=> addReservation({ roomId:rm, startTime:s, endTime:e }))
          await Promise.all(reqs)
          this.$modal.msgSuccess('预留成功')
          this.open=false
          this.getList()
        } catch(err){
          // 失败反馈
          console.error(err)
          this.$modal.msgError('预留失败，请稍后重试')
        } finally {
          this.reserveSubmitting=false
        }
      })
    },
    handleDelete(row){ const ids = row?row.reserveId:this.ids; if(!ids|| (Array.isArray(ids)&&!ids.length)) return; this.$modal.confirm('确认删除选中预约记录?').then(()=>delReservation(ids)).then(()=>{ this.$modal.msgSuccess('删除成功'); this.getList() }).catch(()=>{}) },
    handleExport(){
      // 导出时也合并日期范围参数，保证与列表一致
      const qp = { ...this.queryParams }
      if(this.rangePicker && this.rangePicker.length===2){ qp.startTime = this.rangePicker[0]; qp.endTime = this.rangePicker[1]; }
      this.download('meeting/reservation/export', qp, `reservation_${Date.now()}.xlsx`)
    }
  }
}
</script>
