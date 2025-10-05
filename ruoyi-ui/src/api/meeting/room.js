import request from '@/utils/request'

// 查询会议室列表
export function listRoom(query) {
  return request({
    url: '/meeting/room/list',
    method: 'get',
    params: query
  })
}

// 查询会议室详情
export function getRoom(roomId) {
  return request({
    url: '/meeting/room/' + roomId,
    method: 'get'
  })
}

// 新增会议室
export function addRoom(data) {
  return request({
    url: '/meeting/room',
    method: 'post',
    data: data
  })
}

// 修改会议室
export function updateRoom(data) {
  return request({
    url: '/meeting/room',
    method: 'put',
    data: data
  })
}

// 删除会议室
export function delRoom(roomId) {
  return request({
    url: '/meeting/room/' + roomId,
    method: 'delete'
  })
}
