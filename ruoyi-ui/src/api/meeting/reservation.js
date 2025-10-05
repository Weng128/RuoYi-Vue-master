import request from '@/utils/request'

// 查询会议室预约列表
export function listReservation(query) {
  return request({
    url: '/meeting/reservation/list',
    method: 'get',
    params: query
  })
}

// 查询会议室预约详情
export function getReservation(reserveId) {
  return request({
    url: '/meeting/reservation/' + reserveId,
    method: 'get'
  })
}

// 新增会议室预约
export function addReservation(data) {
  return request({
    url: '/meeting/reservation',
    method: 'post',
    data: data
  })
}

// 修改会议室预约
export function updateReservation(data) {
  return request({
    url: '/meeting/reservation',
    method: 'put',
    data: data
  })
}

// 删除会议室预约
export function delReservation(reserveId) {
  return request({
    url: '/meeting/reservation/' + reserveId,
    method: 'delete'
  })
}
