import request from '@/utils/request'

// 查询会议室申请明细列表
export function listDetail(query) {
  return request({
    url: '/meeting/detail/list',
    method: 'get',
    params: query
  })
}

// 查询当前用户的会议室申请明细列表
export function listMyDetail(query) {
  return request({
    url: '/meeting/detail/mine',
    method: 'get',
    params: query
  })
}

// 查询会议室申请明细详情
export function getDetail(detailId) {
  return request({
    url: '/meeting/detail/' + detailId,
    method: 'get'
  })
}

// 新增会议室申请明细
export function addDetail(data) {
  return request({
    url: '/meeting/detail',
    method: 'post',
    data: data
  })
}

// 修改会议室申请明细
export function updateDetail(data) {
  return request({
    url: '/meeting/detail',
    method: 'put',
    data: data
  })
}

// 删除会议室申请明细
export function delDetail(detailId) {
  return request({
    url: '/meeting/detail/' + detailId,
    method: 'delete'
  })
}
