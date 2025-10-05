import request from '@/utils/request'

// 查询会议室申请列表
export function listRequest(query) {
  return request({
    url: '/meeting/request/list',
    method: 'get',
    params: query
  })
}

// 查询会议室申请详情
export function getRequest(requestId) {
  return request({
    url: '/meeting/request/' + requestId,
    method: 'get'
  })
}

// 新增会议室申请（基础表单）
export function addRequest(data) {
  return request({
    url: '/meeting/request',
    method: 'post',
    data: data
  })
}

// 修改会议室申请（基础表单）
export function updateRequest(data) {
  return request({
    url: '/meeting/request',
    method: 'put',
    data: data
  })
}

// 删除会议室申请
export function delRequest(requestId) {
  return request({
    url: '/meeting/request/' + requestId,
    method: 'delete'
  })
}

// 提交申请（支持统一时间段或独立 slots）
export function submitRequest(data) {
  return request({
    url: '/meeting/request/submit',
    method: 'post',
    data: data
  })
}

// 审批通过（支持统一或独立时段）
export function approveRequest(data) {
  return request({
    url: '/meeting/request/approve',
    method: 'post',
    data: data
  })
}

// 拒绝申请
export function rejectRequest(data) {
  return request({
    url: '/meeting/request/reject',
    method: 'post',
    data: data
  })
}

// 冲突检测（传统一段或 slots）
export function conflictCheck(data) {
  return request({
    url: '/meeting/request/conflicts',
    method: 'post',
    data: data
  })
}

// 查询申请明细列表（按申请ID）
export function listDetails(requestId) {
  return request({
    url: '/meeting/request/details/' + requestId,
    method: 'get'
  })
}

// 新增：查询申请明细列表（通用筛选，如按房间、状态等）
export function listRequestDetail(query) {
  return request({
    url: '/meeting/detail/list',
    method: 'get',
    params: query
  })
}
