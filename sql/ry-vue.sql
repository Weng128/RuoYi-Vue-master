/*
 Navicat Premium Data Transfer

 Source Server         : testexam
 Source Server Type    : MySQL
 Source Server Version : 80028 (8.0.28)
 Source Host           : localhost:3306
 Source Schema         : ry-vue

 Target Server Type    : MySQL
 Target Server Version : 80028 (8.0.28)
 File Encoding         : 65001

 Date: 05/10/2025 22:09:40
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table`  (
  `table_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `tpl_web_type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '前端模板类型（element-ui模版 element-plus模版）',
  `package_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '代码生成业务表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table
-- ----------------------------
INSERT INTO `gen_table` VALUES (3, 'meeting_room', '', NULL, NULL, 'MeetingRoom', 'crud', '', 'com.ruoyi.meeting', 'meeting', 'room', NULL, 'wzx', '0', '/', NULL, 'admin', '2025-09-11 17:07:39', '', NULL, NULL);
INSERT INTO `gen_table` VALUES (4, 'reservation_request', '', NULL, NULL, 'ReservationRequest', 'crud', '', 'com.ruoyi.meeting', 'meeting', 'request', NULL, 'wzx', '0', '/', NULL, 'admin', '2025-09-11 17:07:39', '', NULL, NULL);
INSERT INTO `gen_table` VALUES (5, 'reservation_request_detail', '', NULL, NULL, 'ReservationRequestDetail', 'crud', '', 'com.ruoyi.meeting', 'meeting', 'detail', NULL, 'wzx', '0', '/', NULL, 'admin', '2025-09-11 17:07:39', '', NULL, NULL);
INSERT INTO `gen_table` VALUES (6, 'room_reservation', '', NULL, NULL, 'RoomReservation', 'crud', '', 'com.ruoyi.meeting', 'meeting', 'reservation', NULL, 'wzx', '0', '/', NULL, 'admin', '2025-09-11 17:07:39', '', NULL, NULL);

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column`  (
  `column_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` bigint NULL DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典类型',
  `sort` int NULL DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 37 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '代码生成业务表字段' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------
INSERT INTO `gen_table_column` VALUES (14, 3, 'room_id', '会议室编号，如X31524', 'varchar(20)', 'String', 'roomId', '1', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-09-11 17:07:39', '', '2025-09-11 17:08:52');
INSERT INTO `gen_table_column` VALUES (15, 3, 'capacity', '容量', 'int', 'Long', 'capacity', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2025-09-11 17:07:39', '', '2025-09-11 17:08:52');
INSERT INTO `gen_table_column` VALUES (16, 3, 'location', '位置', 'varchar(100)', 'String', 'location', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2025-09-11 17:07:39', '', '2025-09-11 17:08:52');
INSERT INTO `gen_table_column` VALUES (17, 4, 'request_id', NULL, 'int', 'Long', 'requestId', '1', '1', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-09-11 17:07:39', '', NULL);
INSERT INTO `gen_table_column` VALUES (18, 4, 'applicant_id', '申请人ID（逻辑外键，关联user.user_id）', 'int', 'Long', 'applicantId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2025-09-11 17:07:39', '', NULL);
INSERT INTO `gen_table_column` VALUES (19, 4, 'status', NULL, 'enum(\'pending\',\'approved\',\'rejected\')', 'String', 'status', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'radio', '', 3, 'admin', '2025-09-11 17:07:39', '', NULL);
INSERT INTO `gen_table_column` VALUES (20, 4, 'admin_id', '审批人ID（逻辑外键，关联user.user_id）', 'int', 'Long', 'adminId', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2025-09-11 17:07:39', '', NULL);
INSERT INTO `gen_table_column` VALUES (21, 4, 'decision_time', '审批时间', 'datetime', 'Date', 'decisionTime', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'datetime', '', 5, 'admin', '2025-09-11 17:07:39', '', NULL);
INSERT INTO `gen_table_column` VALUES (22, 4, 'created_at', NULL, 'datetime', 'Date', 'createdAt', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'datetime', '', 6, 'admin', '2025-09-11 17:07:39', '', NULL);
INSERT INTO `gen_table_column` VALUES (23, 5, 'detail_id', NULL, 'int', 'Long', 'detailId', '1', '1', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-09-11 17:07:39', '', NULL);
INSERT INTO `gen_table_column` VALUES (24, 5, 'request_id', '逻辑外键 reservation_request.request_id', 'int', 'Long', 'requestId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2025-09-11 17:07:39', '', NULL);
INSERT INTO `gen_table_column` VALUES (25, 5, 'room_id', '逻辑外键 meeting_room.room_id', 'varchar(20)', 'String', 'roomId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2025-09-11 17:07:39', '', NULL);
INSERT INTO `gen_table_column` VALUES (26, 5, 'start_time', NULL, 'datetime', 'Date', 'startTime', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'datetime', '', 4, 'admin', '2025-09-11 17:07:39', '', NULL);
INSERT INTO `gen_table_column` VALUES (27, 5, 'end_time', NULL, 'datetime', 'Date', 'endTime', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'datetime', '', 5, 'admin', '2025-09-11 17:07:39', '', NULL);
INSERT INTO `gen_table_column` VALUES (28, 6, 'reserve_id', NULL, 'int', 'Long', 'reserveId', '1', '1', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-09-11 17:07:39', '', NULL);
INSERT INTO `gen_table_column` VALUES (29, 6, 'admin_id', '逻辑外键 user.user_id', 'int', 'Long', 'adminId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2025-09-11 17:07:39', '', NULL);
INSERT INTO `gen_table_column` VALUES (30, 6, 'room_id', '逻辑外键 meeting_room.room_id', 'varchar(20)', 'String', 'roomId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2025-09-11 17:07:39', '', NULL);
INSERT INTO `gen_table_column` VALUES (31, 6, 'start_time', NULL, 'datetime', 'Date', 'startTime', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'datetime', '', 4, 'admin', '2025-09-11 17:07:39', '', NULL);
INSERT INTO `gen_table_column` VALUES (32, 6, 'end_time', NULL, 'datetime', 'Date', 'endTime', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'datetime', '', 5, 'admin', '2025-09-11 17:07:39', '', NULL);
INSERT INTO `gen_table_column` VALUES (33, 6, 'created_at', NULL, 'datetime', 'Date', 'createdAt', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'datetime', '', 6, 'admin', '2025-09-11 17:07:39', '', NULL);

-- ----------------------------
-- Table structure for meeting_room
-- ----------------------------
DROP TABLE IF EXISTS `meeting_room`;
CREATE TABLE `meeting_room`  (
  `room_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `capacity` int NULL DEFAULT NULL,
  `location` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`room_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of meeting_room
-- ----------------------------
INSERT INTO `meeting_room` VALUES ('X31524', 30, 'XXX', '2025-09-12 20:06:07', NULL);
INSERT INTO `meeting_room` VALUES ('X31525', 20, 'XXX', '2025-09-12 20:06:21', NULL);
INSERT INTO `meeting_room` VALUES ('X31526', 40, 'XXXX', '2025-09-12 20:06:55', NULL);
INSERT INTO `meeting_room` VALUES ('X31541', 50, 'XXXX', '2025-09-12 20:07:11', NULL);

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `blob_data` blob NULL COMMENT '存放持久化Trigger对象',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'Blob类型的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_blob_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `calendar_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '日历名称',
  `calendar` blob NOT NULL COMMENT '存放持久化calendar对象',
  PRIMARY KEY (`sched_name`, `calendar_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '日历信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_calendars
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `cron_expression` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'cron表达式',
  `time_zone_id` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '时区',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'Cron类型的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_cron_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `entry_id` varchar(95) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度器实例id',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `instance_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度器实例名',
  `fired_time` bigint NOT NULL COMMENT '触发的时间',
  `sched_time` bigint NOT NULL COMMENT '定时器制定的时间',
  `priority` int NOT NULL COMMENT '优先级',
  `state` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '状态',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '任务名称',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '任务组名',
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否并发',
  `requests_recovery` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否接受恢复执行',
  PRIMARY KEY (`sched_name`, `entry_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '已触发的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_fired_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务组名',
  `description` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '相关介绍',
  `job_class_name` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '执行任务类名称',
  `is_durable` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '是否持久化',
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '是否并发',
  `is_update_data` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '是否更新数据',
  `requests_recovery` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '是否接受恢复执行',
  `job_data` blob NULL COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '任务详细信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_job_details
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `lock_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '悲观锁名称',
  PRIMARY KEY (`sched_name`, `lock_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '存储的悲观锁信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_locks
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  PRIMARY KEY (`sched_name`, `trigger_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '暂停的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_paused_trigger_grps
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `instance_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '实例名称',
  `last_checkin_time` bigint NOT NULL COMMENT '上次检查时间',
  `checkin_interval` bigint NOT NULL COMMENT '检查间隔时间',
  PRIMARY KEY (`sched_name`, `instance_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '调度器状态表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `repeat_count` bigint NOT NULL COMMENT '重复的次数统计',
  `repeat_interval` bigint NOT NULL COMMENT '重复的间隔时间',
  `times_triggered` bigint NOT NULL COMMENT '已经触发的次数',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '简单触发器的信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_simple_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE `qrtz_simprop_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `str_prop_1` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第一个参数',
  `str_prop_2` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第二个参数',
  `str_prop_3` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第三个参数',
  `int_prop_1` int NULL DEFAULT NULL COMMENT 'int类型的trigger的第一个参数',
  `int_prop_2` int NULL DEFAULT NULL COMMENT 'int类型的trigger的第二个参数',
  `long_prop_1` bigint NULL DEFAULT NULL COMMENT 'long类型的trigger的第一个参数',
  `long_prop_2` bigint NULL DEFAULT NULL COMMENT 'long类型的trigger的第二个参数',
  `dec_prop_1` decimal(13, 4) NULL DEFAULT NULL COMMENT 'decimal类型的trigger的第一个参数',
  `dec_prop_2` decimal(13, 4) NULL DEFAULT NULL COMMENT 'decimal类型的trigger的第二个参数',
  `bool_prop_1` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'Boolean类型的trigger的第一个参数',
  `bool_prop_2` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'Boolean类型的trigger的第二个参数',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '同步机制的行锁表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_simprop_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '触发器的名字',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '触发器所属组的名字',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_job_details表job_name的外键',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_job_details表job_group的外键',
  `description` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '相关介绍',
  `next_fire_time` bigint NULL DEFAULT NULL COMMENT '上一次触发时间（毫秒）',
  `prev_fire_time` bigint NULL DEFAULT NULL COMMENT '下一次触发时间（默认为-1表示不触发）',
  `priority` int NULL DEFAULT NULL COMMENT '优先级',
  `trigger_state` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '触发器状态',
  `trigger_type` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '触发器的类型',
  `start_time` bigint NOT NULL COMMENT '开始时间',
  `end_time` bigint NULL DEFAULT NULL COMMENT '结束时间',
  `calendar_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '日程表名称',
  `misfire_instr` smallint NULL DEFAULT NULL COMMENT '补偿执行的策略',
  `job_data` blob NULL COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  INDEX `sched_name`(`sched_name` ASC, `job_name` ASC, `job_group` ASC) USING BTREE,
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `qrtz_job_details` (`sched_name`, `job_name`, `job_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '触发器详细信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for reservation_request
-- ----------------------------
DROP TABLE IF EXISTS `reservation_request`;
CREATE TABLE `reservation_request`  (
  `request_id` bigint NOT NULL AUTO_INCREMENT,
  `applicant_id` bigint NOT NULL,
  `status` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `admin_id` bigint NULL DEFAULT NULL,
  `decision_time` datetime NULL DEFAULT NULL,
  `decision_remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`request_id`) USING BTREE,
  INDEX `idx_req_applicant`(`applicant_id` ASC) USING BTREE,
  INDEX `idx_req_status`(`status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reservation_request
-- ----------------------------
INSERT INTO `reservation_request` VALUES (1, 1, 'APPROVED', 1, '2025-09-12 20:40:00', 'da', NULL, '2025-09-12 20:39:08', '2025-09-12 20:40:00');
INSERT INTO `reservation_request` VALUES (2, 1, 'APPROVED', 1, '2025-09-12 20:44:19', '', NULL, '2025-09-12 20:40:59', '2025-09-12 20:44:19');
INSERT INTO `reservation_request` VALUES (3, 1, 'APPROVED', 1, '2025-09-13 14:25:16', '', NULL, '2025-09-12 20:45:00', '2025-09-13 14:25:16');
INSERT INTO `reservation_request` VALUES (4, 2, 'APPROVED', 1, '2025-09-13 16:32:27', '', NULL, '2025-09-13 16:31:45', '2025-09-13 16:32:27');
INSERT INTO `reservation_request` VALUES (5, 2, 'APPROVED', 1, '2025-09-20 16:36:14', '', NULL, '2025-09-20 16:34:14', '2025-09-20 16:36:14');
INSERT INTO `reservation_request` VALUES (6, 2, 'APPROVED', 1, '2025-09-27 14:11:09', 'sfsd', NULL, '2025-09-23 15:52:57', '2025-09-27 14:11:09');
INSERT INTO `reservation_request` VALUES (7, 1, 'APPROVED', 1, '2025-09-27 14:32:53', 'sad', NULL, '2025-09-27 14:32:35', '2025-09-27 14:32:53');
INSERT INTO `reservation_request` VALUES (8, 1, 'REJECTED', 1, '2025-10-05 16:28:28', '', NULL, '2025-09-27 15:24:22', '2025-10-05 16:28:28');
INSERT INTO `reservation_request` VALUES (9, 1, 'APPROVED', 1, '2025-10-05 16:28:15', '', NULL, '2025-09-27 16:50:13', '2025-10-05 16:28:15');
INSERT INTO `reservation_request` VALUES (10, 1, 'REJECTED', 1, '2025-10-05 16:28:09', '', NULL, '2025-09-27 16:57:52', '2025-10-05 16:28:09');
INSERT INTO `reservation_request` VALUES (11, 2, 'APPROVED', 1, '2025-10-05 16:27:59', '', NULL, '2025-09-27 18:19:51', '2025-10-05 16:27:59');
INSERT INTO `reservation_request` VALUES (12, 2, 'APPROVED', 1, '2025-09-27 18:27:24', '', NULL, '2025-09-27 18:26:57', '2025-09-27 18:27:24');
INSERT INTO `reservation_request` VALUES (13, 2, 'APPROVED', 1, '2025-09-28 16:22:04', '', NULL, '2025-09-28 16:20:08', '2025-09-28 16:22:04');
INSERT INTO `reservation_request` VALUES (14, 1, 'APPROVED', 1, '2025-10-05 16:27:53', '', NULL, '2025-10-05 16:26:48', '2025-10-05 16:27:53');
INSERT INTO `reservation_request` VALUES (15, 1, 'APPROVED', 1, '2025-10-05 16:27:51', '', NULL, '2025-10-05 16:27:18', '2025-10-05 16:27:51');
INSERT INTO `reservation_request` VALUES (16, 1, 'APPROVED', 1, '2025-10-05 16:27:48', '', NULL, '2025-10-05 16:27:40', '2025-10-05 16:27:48');

-- ----------------------------
-- Table structure for reservation_request_detail
-- ----------------------------
DROP TABLE IF EXISTS `reservation_request_detail`;
CREATE TABLE `reservation_request_detail`  (
  `detail_id` bigint NOT NULL AUTO_INCREMENT,
  `request_id` bigint NOT NULL,
  `room_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  PRIMARY KEY (`detail_id`) USING BTREE,
  INDEX `idx_reqd_req`(`request_id` ASC) USING BTREE,
  INDEX `idx_reqd_room_time`(`room_id` ASC, `start_time` ASC, `end_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 31 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reservation_request_detail
-- ----------------------------
INSERT INTO `reservation_request_detail` VALUES (2, 1, 'X31525', '2025-09-12 00:00:00', '2025-09-13 00:00:00');
INSERT INTO `reservation_request_detail` VALUES (4, 2, 'X31524', '2025-09-12 00:00:00', '2025-09-13 00:00:00');
INSERT INTO `reservation_request_detail` VALUES (6, 3, 'X31525', '2025-09-14 00:00:00', '2025-09-15 00:00:00');
INSERT INTO `reservation_request_detail` VALUES (8, 4, 'X31524', '2025-09-15 00:00:00', '2025-09-16 00:00:00');
INSERT INTO `reservation_request_detail` VALUES (10, 5, 'X31524', '2025-09-25 00:00:00', '2025-09-26 00:00:00');
INSERT INTO `reservation_request_detail` VALUES (12, 6, 'X31524', '2025-09-27 00:00:00', '2025-09-28 00:00:00');
INSERT INTO `reservation_request_detail` VALUES (14, 7, 'X31524', '2025-09-29 00:00:00', '2025-09-30 00:00:00');
INSERT INTO `reservation_request_detail` VALUES (15, 8, 'X31524', '2025-10-19 00:00:00', '2025-10-20 00:00:00');
INSERT INTO `reservation_request_detail` VALUES (17, 10, 'X31524', '2025-10-06 00:00:00', '2025-10-07 00:00:00');
INSERT INTO `reservation_request_detail` VALUES (20, 12, 'X31526', '2025-10-22 00:10:00', '2025-10-24 01:00:00');
INSERT INTO `reservation_request_detail` VALUES (22, 13, 'X31524', '2025-09-28 16:25:00', '2025-09-28 17:25:00');
INSERT INTO `reservation_request_detail` VALUES (26, 16, 'X31541', '2025-10-06 05:10:00', '2025-10-06 12:00:00');
INSERT INTO `reservation_request_detail` VALUES (27, 15, 'X31525', '2025-10-06 00:00:00', '2025-10-06 04:10:00');
INSERT INTO `reservation_request_detail` VALUES (28, 14, 'X31524', '2025-10-06 02:00:00', '2025-10-07 02:00:00');
INSERT INTO `reservation_request_detail` VALUES (29, 11, 'X31525', '2025-10-14 04:25:00', '2025-10-15 01:10:00');
INSERT INTO `reservation_request_detail` VALUES (30, 9, 'X31524', '2025-10-19 00:00:00', '2025-10-20 00:00:00');

-- ----------------------------
-- Table structure for room_reservation
-- ----------------------------
DROP TABLE IF EXISTS `room_reservation`;
CREATE TABLE `room_reservation`  (
  `reserve_id` bigint NOT NULL AUTO_INCREMENT,
  `admin_id` bigint NOT NULL,
  `room_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`reserve_id`) USING BTREE,
  INDEX `idx_resv_room_time`(`room_id` ASC, `start_time` ASC, `end_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of room_reservation
-- ----------------------------
INSERT INTO `room_reservation` VALUES (1, 1, 'X31524', '2025-09-20 00:00:00', '2025-09-21 00:00:00', '2025-09-13 14:47:22', NULL);
INSERT INTO `room_reservation` VALUES (2, 1, 'X31525', '2025-09-20 00:00:00', '2025-09-21 00:00:00', '2025-09-13 14:47:22', NULL);

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `config_id` int NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '参数配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2025-09-10 15:45:27', '', NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES (2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2025-09-10 15:45:27', '', NULL, '初始化密码 123456');
INSERT INTO `sys_config` VALUES (3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2025-09-10 15:45:27', '', NULL, '深色主题theme-dark，浅色主题theme-light');
INSERT INTO `sys_config` VALUES (4, '账号自助-验证码开关', 'sys.account.captchaEnabled', 'true', 'Y', 'admin', '2025-09-10 15:45:27', '', NULL, '是否开启验证码功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (5, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'false', 'Y', 'admin', '2025-09-10 15:45:27', '', NULL, '是否开启注册用户功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (6, '用户登录-黑名单列表', 'sys.login.blackIPList', '', 'Y', 'admin', '2025-09-10 15:45:27', '', NULL, '设置登录IP黑名单限制，多个匹配项以;分隔，支持匹配（*通配、网段）');
INSERT INTO `sys_config` VALUES (7, '用户管理-初始密码修改策略', 'sys.account.initPasswordModify', '1', 'Y', 'admin', '2025-09-10 15:45:27', '', NULL, '0：初始密码修改策略关闭，没有任何提示，1：提醒用户，如果未修改初始密码，则在登录时就会提醒修改密码对话框');
INSERT INTO `sys_config` VALUES (8, '用户管理-账号密码更新周期', 'sys.account.passwordValidateDays', '0', 'Y', 'admin', '2025-09-10 15:45:27', '', NULL, '密码更新周期（填写数字，数据初始化值为0不限制，若修改必须为大于0小于365的正整数），如果超过这个周期登录系统时，则在登录时就会提醒修改密码对话框');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `dept_id` bigint NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父部门id',
  `ancestors` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '部门名称',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `leader` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 200 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '部门表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (100, 0, '0', 'xx大学', 0, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-09-10 15:45:27', 'admin', '2025-09-11 16:07:09');
INSERT INTO `sys_dept` VALUES (101, 100, '0,100', 'xx学院', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-09-10 15:45:27', 'admin', '2025-09-11 16:07:19');
INSERT INTO `sys_dept` VALUES (102, 100, '0,100', '长沙分公司', 2, '若依', '15888888888', 'ry@qq.com', '0', '2', 'admin', '2025-09-10 15:45:27', '', NULL);
INSERT INTO `sys_dept` VALUES (103, 101, '0,100,101', '行政', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-09-10 15:45:27', 'admin', '2025-09-11 16:07:32');
INSERT INTO `sys_dept` VALUES (104, 101, '0,100,101', '市场部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '2', 'admin', '2025-09-10 15:45:27', '', NULL);
INSERT INTO `sys_dept` VALUES (105, 101, '0,100,101', '职工', 3, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-09-10 15:45:27', 'admin', '2025-09-11 16:07:41');
INSERT INTO `sys_dept` VALUES (106, 101, '0,100,101', '财务部门', 4, '若依', '15888888888', 'ry@qq.com', '0', '2', 'admin', '2025-09-10 15:45:27', '', NULL);
INSERT INTO `sys_dept` VALUES (107, 101, '0,100,101', '运维部门', 5, '若依', '15888888888', 'ry@qq.com', '0', '2', 'admin', '2025-09-10 15:45:27', '', NULL);
INSERT INTO `sys_dept` VALUES (108, 102, '0,100,102', '市场部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '2', 'admin', '2025-09-10 15:45:27', '', NULL);
INSERT INTO `sys_dept` VALUES (109, 102, '0,100,102', '财务部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '2', 'admin', '2025-09-10 15:45:27', '', NULL);

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `dict_code` bigint NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int NULL DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '字典数据表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2025-09-10 15:45:27', '', NULL, '性别男');
INSERT INTO `sys_dict_data` VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2025-09-10 15:45:27', '', NULL, '性别女');
INSERT INTO `sys_dict_data` VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2025-09-10 15:45:27', '', NULL, '性别未知');
INSERT INTO `sys_dict_data` VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2025-09-10 15:45:27', '', NULL, '显示菜单');
INSERT INTO `sys_dict_data` VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2025-09-10 15:45:27', '', NULL, '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2025-09-10 15:45:27', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2025-09-10 15:45:27', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2025-09-10 15:45:27', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2025-09-10 15:45:27', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (10, 1, '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2025-09-10 15:45:27', '', NULL, '默认分组');
INSERT INTO `sys_dict_data` VALUES (11, 2, '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2025-09-10 15:45:27', '', NULL, '系统分组');
INSERT INTO `sys_dict_data` VALUES (12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2025-09-10 15:45:27', '', NULL, '系统默认是');
INSERT INTO `sys_dict_data` VALUES (13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2025-09-10 15:45:27', '', NULL, '系统默认否');
INSERT INTO `sys_dict_data` VALUES (14, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2025-09-10 15:45:27', '', NULL, '通知');
INSERT INTO `sys_dict_data` VALUES (15, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2025-09-10 15:45:27', '', NULL, '公告');
INSERT INTO `sys_dict_data` VALUES (16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2025-09-10 15:45:27', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2025-09-10 15:45:27', '', NULL, '关闭状态');
INSERT INTO `sys_dict_data` VALUES (18, 99, '其他', '0', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-09-10 15:45:27', '', NULL, '其他操作');
INSERT INTO `sys_dict_data` VALUES (19, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-09-10 15:45:27', '', NULL, '新增操作');
INSERT INTO `sys_dict_data` VALUES (20, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-09-10 15:45:27', '', NULL, '修改操作');
INSERT INTO `sys_dict_data` VALUES (21, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-09-10 15:45:27', '', NULL, '删除操作');
INSERT INTO `sys_dict_data` VALUES (22, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2025-09-10 15:45:27', '', NULL, '授权操作');
INSERT INTO `sys_dict_data` VALUES (23, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-09-10 15:45:27', '', NULL, '导出操作');
INSERT INTO `sys_dict_data` VALUES (24, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-09-10 15:45:27', '', NULL, '导入操作');
INSERT INTO `sys_dict_data` VALUES (25, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-09-10 15:45:27', '', NULL, '强退操作');
INSERT INTO `sys_dict_data` VALUES (26, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-09-10 15:45:27', '', NULL, '生成操作');
INSERT INTO `sys_dict_data` VALUES (27, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-09-10 15:45:27', '', NULL, '清空操作');
INSERT INTO `sys_dict_data` VALUES (28, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2025-09-10 15:45:27', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (29, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2025-09-10 15:45:27', '', NULL, '停用状态');

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `dict_id` bigint NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典类型',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `dict_type`(`dict_type` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '字典类型表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2025-09-10 15:45:27', '', NULL, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2025-09-10 15:45:27', '', NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2025-09-10 15:45:27', '', NULL, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES (4, '任务状态', 'sys_job_status', '0', 'admin', '2025-09-10 15:45:27', '', NULL, '任务状态列表');
INSERT INTO `sys_dict_type` VALUES (5, '任务分组', 'sys_job_group', '0', 'admin', '2025-09-10 15:45:27', '', NULL, '任务分组列表');
INSERT INTO `sys_dict_type` VALUES (6, '系统是否', 'sys_yes_no', '0', 'admin', '2025-09-10 15:45:27', '', NULL, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES (7, '通知类型', 'sys_notice_type', '0', 'admin', '2025-09-10 15:45:27', '', NULL, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES (8, '通知状态', 'sys_notice_status', '0', 'admin', '2025-09-10 15:45:27', '', NULL, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES (9, '操作类型', 'sys_oper_type', '0', 'admin', '2025-09-10 15:45:27', '', NULL, '操作类型列表');
INSERT INTO `sys_dict_type` VALUES (10, '系统状态', 'sys_common_status', '0', 'admin', '2025-09-10 15:45:27', '', NULL, '登录状态列表');

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job`  (
  `job_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '定时任务调度表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO `sys_job` VALUES (1, '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams', '0/10 * * * * ?', '3', '1', '1', 'admin', '2025-09-10 15:45:27', '', NULL, '');
INSERT INTO `sys_job` VALUES (2, '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(\'ry\')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2025-09-10 15:45:27', '', NULL, '');
INSERT INTO `sys_job` VALUES (3, '系统默认（多参）', 'DEFAULT', 'ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '1', 'admin', '2025-09-10 15:45:27', '', NULL, '');

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log`  (
  `job_log_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '日志信息',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '异常信息',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '定时任务调度日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor`  (
  `info_id` bigint NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '操作系统',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '提示消息',
  `login_time` datetime NULL DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`) USING BTREE,
  INDEX `idx_sys_logininfor_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_logininfor_lt`(`login_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 208 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统访问记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO `sys_logininfor` VALUES (100, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-11 14:50:25');
INSERT INTO `sys_logininfor` VALUES (101, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-11 15:07:23');
INSERT INTO `sys_logininfor` VALUES (102, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-11 16:06:14');
INSERT INTO `sys_logininfor` VALUES (103, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-11 16:39:20');
INSERT INTO `sys_logininfor` VALUES (104, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-09-11 17:51:41');
INSERT INTO `sys_logininfor` VALUES (105, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-11 17:51:55');
INSERT INTO `sys_logininfor` VALUES (106, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-12 15:53:57');
INSERT INTO `sys_logininfor` VALUES (107, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-12 16:42:34');
INSERT INTO `sys_logininfor` VALUES (108, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-09-12 18:50:36');
INSERT INTO `sys_logininfor` VALUES (109, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-12 18:50:39');
INSERT INTO `sys_logininfor` VALUES (110, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-12 19:24:29');
INSERT INTO `sys_logininfor` VALUES (111, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-13 14:24:56');
INSERT INTO `sys_logininfor` VALUES (112, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-09-13 14:48:59');
INSERT INTO `sys_logininfor` VALUES (113, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-13 14:49:11');
INSERT INTO `sys_logininfor` VALUES (114, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-09-13 14:49:32');
INSERT INTO `sys_logininfor` VALUES (115, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-09-13 14:49:41');
INSERT INTO `sys_logininfor` VALUES (116, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码已失效', '2025-09-13 14:53:17');
INSERT INTO `sys_logininfor` VALUES (117, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-13 14:53:20');
INSERT INTO `sys_logininfor` VALUES (118, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-09-13 14:53:38');
INSERT INTO `sys_logininfor` VALUES (119, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-13 14:53:47');
INSERT INTO `sys_logininfor` VALUES (120, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-09-13 14:55:24');
INSERT INTO `sys_logininfor` VALUES (121, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-13 14:55:31');
INSERT INTO `sys_logininfor` VALUES (122, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-09-13 15:04:28');
INSERT INTO `sys_logininfor` VALUES (123, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-09-13 15:04:36');
INSERT INTO `sys_logininfor` VALUES (124, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-13 15:04:40');
INSERT INTO `sys_logininfor` VALUES (125, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-09-13 15:07:51');
INSERT INTO `sys_logininfor` VALUES (126, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-13 15:07:56');
INSERT INTO `sys_logininfor` VALUES (127, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-09-13 15:12:38');
INSERT INTO `sys_logininfor` VALUES (128, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-13 15:12:42');
INSERT INTO `sys_logininfor` VALUES (129, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-09-13 15:30:20');
INSERT INTO `sys_logininfor` VALUES (130, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-13 15:30:24');
INSERT INTO `sys_logininfor` VALUES (131, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-09-13 15:34:12');
INSERT INTO `sys_logininfor` VALUES (132, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-13 15:34:15');
INSERT INTO `sys_logininfor` VALUES (133, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-09-13 15:35:11');
INSERT INTO `sys_logininfor` VALUES (134, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-13 15:35:18');
INSERT INTO `sys_logininfor` VALUES (135, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-09-13 15:35:59');
INSERT INTO `sys_logininfor` VALUES (136, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-13 15:36:02');
INSERT INTO `sys_logininfor` VALUES (137, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-09-13 15:38:57');
INSERT INTO `sys_logininfor` VALUES (138, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-13 15:39:01');
INSERT INTO `sys_logininfor` VALUES (139, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-09-13 15:42:13');
INSERT INTO `sys_logininfor` VALUES (140, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-13 15:42:17');
INSERT INTO `sys_logininfor` VALUES (141, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-09-13 15:45:51');
INSERT INTO `sys_logininfor` VALUES (142, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-13 15:45:57');
INSERT INTO `sys_logininfor` VALUES (143, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-09-13 16:31:55');
INSERT INTO `sys_logininfor` VALUES (144, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-13 16:31:58');
INSERT INTO `sys_logininfor` VALUES (145, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-09-13 16:32:34');
INSERT INTO `sys_logininfor` VALUES (146, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-13 16:32:40');
INSERT INTO `sys_logininfor` VALUES (147, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-09-16 15:43:25');
INSERT INTO `sys_logininfor` VALUES (148, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-16 15:43:29');
INSERT INTO `sys_logininfor` VALUES (149, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-20 14:21:44');
INSERT INTO `sys_logininfor` VALUES (150, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-09-20 14:45:28');
INSERT INTO `sys_logininfor` VALUES (151, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-20 14:45:32');
INSERT INTO `sys_logininfor` VALUES (152, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-09-20 14:46:31');
INSERT INTO `sys_logininfor` VALUES (153, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-20 14:46:36');
INSERT INTO `sys_logininfor` VALUES (154, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-09-20 15:00:14');
INSERT INTO `sys_logininfor` VALUES (155, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-20 15:00:19');
INSERT INTO `sys_logininfor` VALUES (156, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-09-20 15:43:28');
INSERT INTO `sys_logininfor` VALUES (157, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-20 15:43:33');
INSERT INTO `sys_logininfor` VALUES (158, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-09-20 15:44:11');
INSERT INTO `sys_logininfor` VALUES (159, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-20 15:44:19');
INSERT INTO `sys_logininfor` VALUES (160, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-09-20 15:49:37');
INSERT INTO `sys_logininfor` VALUES (161, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-20 15:49:45');
INSERT INTO `sys_logininfor` VALUES (162, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-09-20 16:00:14');
INSERT INTO `sys_logininfor` VALUES (163, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-20 16:00:18');
INSERT INTO `sys_logininfor` VALUES (164, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-09-20 16:01:56');
INSERT INTO `sys_logininfor` VALUES (165, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-20 16:02:01');
INSERT INTO `sys_logininfor` VALUES (166, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-09-20 16:24:20');
INSERT INTO `sys_logininfor` VALUES (167, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-20 16:24:24');
INSERT INTO `sys_logininfor` VALUES (168, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-09-20 16:25:54');
INSERT INTO `sys_logininfor` VALUES (169, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-09-20 16:26:00');
INSERT INTO `sys_logininfor` VALUES (170, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-20 16:26:04');
INSERT INTO `sys_logininfor` VALUES (171, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-09-20 16:34:21');
INSERT INTO `sys_logininfor` VALUES (172, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-20 16:34:25');
INSERT INTO `sys_logininfor` VALUES (173, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-23 15:49:49');
INSERT INTO `sys_logininfor` VALUES (174, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-09-23 16:02:51');
INSERT INTO `sys_logininfor` VALUES (175, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-23 16:02:57');
INSERT INTO `sys_logininfor` VALUES (176, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-27 13:58:02');
INSERT INTO `sys_logininfor` VALUES (177, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-09-27 17:47:56');
INSERT INTO `sys_logininfor` VALUES (178, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-27 17:48:01');
INSERT INTO `sys_logininfor` VALUES (179, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-09-27 17:48:25');
INSERT INTO `sys_logininfor` VALUES (180, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-09-27 17:48:31');
INSERT INTO `sys_logininfor` VALUES (181, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-27 17:48:34');
INSERT INTO `sys_logininfor` VALUES (182, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-09-27 17:51:43');
INSERT INTO `sys_logininfor` VALUES (183, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-27 17:51:49');
INSERT INTO `sys_logininfor` VALUES (184, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-09-27 17:52:18');
INSERT INTO `sys_logininfor` VALUES (185, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-27 17:52:21');
INSERT INTO `sys_logininfor` VALUES (186, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-09-27 17:53:40');
INSERT INTO `sys_logininfor` VALUES (187, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-27 17:53:45');
INSERT INTO `sys_logininfor` VALUES (188, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-09-27 17:54:08');
INSERT INTO `sys_logininfor` VALUES (189, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-27 17:54:14');
INSERT INTO `sys_logininfor` VALUES (190, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-09-27 18:19:23');
INSERT INTO `sys_logininfor` VALUES (191, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-27 18:19:28');
INSERT INTO `sys_logininfor` VALUES (192, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-09-27 18:19:57');
INSERT INTO `sys_logininfor` VALUES (193, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-27 18:20:00');
INSERT INTO `sys_logininfor` VALUES (194, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-09-27 18:25:57');
INSERT INTO `sys_logininfor` VALUES (195, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-27 18:26:04');
INSERT INTO `sys_logininfor` VALUES (196, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-09-27 18:27:03');
INSERT INTO `sys_logininfor` VALUES (197, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-27 18:27:09');
INSERT INTO `sys_logininfor` VALUES (198, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-28 16:19:26');
INSERT INTO `sys_logininfor` VALUES (199, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-09-28 16:20:21');
INSERT INTO `sys_logininfor` VALUES (200, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-28 16:20:26');
INSERT INTO `sys_logininfor` VALUES (201, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-05 15:57:45');
INSERT INTO `sys_logininfor` VALUES (202, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码已失效', '2025-10-05 16:21:56');
INSERT INTO `sys_logininfor` VALUES (203, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-05 16:21:59');
INSERT INTO `sys_logininfor` VALUES (204, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-10-05 20:17:03');
INSERT INTO `sys_logininfor` VALUES (205, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-05 20:17:06');
INSERT INTO `sys_logininfor` VALUES (206, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-05 21:15:42');
INSERT INTO `sys_logininfor` VALUES (207, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-05 21:48:19');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '路由参数',
  `route_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '路由名称',
  `is_frame` int NULL DEFAULT 1 COMMENT '是否为外链（0是 1否）',
  `is_cache` int NULL DEFAULT 0 COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2019 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '菜单权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 1, 'system', NULL, '', '', 1, 0, 'M', '0', '0', '', 'system', 'admin', '2025-09-10 15:45:27', '', NULL, '系统管理目录');
INSERT INTO `sys_menu` VALUES (2, '系统监控', 0, 2, 'monitor', NULL, '', '', 1, 0, 'M', '0', '0', '', 'monitor', 'admin', '2025-09-10 15:45:27', '', NULL, '系统监控目录');
INSERT INTO `sys_menu` VALUES (3, '系统工具', 0, 3, 'tool', NULL, '', '', 1, 0, 'M', '0', '0', '', 'tool', 'admin', '2025-09-10 15:45:27', '', NULL, '系统工具目录');
INSERT INTO `sys_menu` VALUES (100, '用户管理', 1, 1, 'user', 'system/user/index', '', '', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 'admin', '2025-09-10 15:45:27', '', NULL, '用户管理菜单');
INSERT INTO `sys_menu` VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', '', '', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2025-09-10 15:45:27', '', NULL, '角色管理菜单');
INSERT INTO `sys_menu` VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', '', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2025-09-10 15:45:27', '', NULL, '菜单管理菜单');
INSERT INTO `sys_menu` VALUES (103, '部门管理', 1, 4, 'dept', 'system/dept/index', '', '', 1, 0, 'C', '0', '0', 'system:dept:list', 'tree', 'admin', '2025-09-10 15:45:27', '', NULL, '部门管理菜单');
INSERT INTO `sys_menu` VALUES (104, '岗位管理', 1, 5, 'post', 'system/post/index', '', '', 1, 0, 'C', '0', '0', 'system:post:list', 'post', 'admin', '2025-09-10 15:45:27', '', NULL, '岗位管理菜单');
INSERT INTO `sys_menu` VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', '', 1, 0, 'C', '0', '0', 'system:dict:list', 'dict', 'admin', '2025-09-10 15:45:27', '', NULL, '字典管理菜单');
INSERT INTO `sys_menu` VALUES (106, '参数设置', 1, 7, 'config', 'system/config/index', '', '', 1, 0, 'C', '0', '0', 'system:config:list', 'edit', 'admin', '2025-09-10 15:45:27', '', NULL, '参数设置菜单');
INSERT INTO `sys_menu` VALUES (107, '通知公告', 1, 8, 'notice', 'system/notice/index', '', '', 1, 0, 'C', '0', '0', 'system:notice:list', 'message', 'admin', '2025-09-10 15:45:27', '', NULL, '通知公告菜单');
INSERT INTO `sys_menu` VALUES (108, '日志管理', 1, 9, 'log', '', '', '', 1, 0, 'M', '0', '0', '', 'log', 'admin', '2025-09-10 15:45:27', '', NULL, '日志管理菜单');
INSERT INTO `sys_menu` VALUES (109, '在线用户', 2, 1, 'online', 'monitor/online/index', '', '', 1, 0, 'C', '0', '0', 'monitor:online:list', 'online', 'admin', '2025-09-10 15:45:27', '', NULL, '在线用户菜单');
INSERT INTO `sys_menu` VALUES (110, '定时任务', 2, 2, 'job', 'monitor/job/index', '', '', 1, 0, 'C', '0', '0', 'monitor:job:list', 'job', 'admin', '2025-09-10 15:45:27', '', NULL, '定时任务菜单');
INSERT INTO `sys_menu` VALUES (111, '数据监控', 2, 3, 'druid', 'monitor/druid/index', '', '', 1, 0, 'C', '0', '0', 'monitor:druid:list', 'druid', 'admin', '2025-09-10 15:45:27', '', NULL, '数据监控菜单');
INSERT INTO `sys_menu` VALUES (112, '服务监控', 2, 4, 'server', 'monitor/server/index', '', '', 1, 0, 'C', '0', '0', 'monitor:server:list', 'server', 'admin', '2025-09-10 15:45:27', '', NULL, '服务监控菜单');
INSERT INTO `sys_menu` VALUES (113, '缓存监控', 2, 5, 'cache', 'monitor/cache/index', '', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis', 'admin', '2025-09-10 15:45:27', '', NULL, '缓存监控菜单');
INSERT INTO `sys_menu` VALUES (114, '缓存列表', 2, 6, 'cacheList', 'monitor/cache/list', '', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis-list', 'admin', '2025-09-10 15:45:27', '', NULL, '缓存列表菜单');
INSERT INTO `sys_menu` VALUES (115, '表单构建', 3, 1, 'build', 'tool/build/index', '', '', 1, 0, 'C', '0', '0', 'tool:build:list', 'build', 'admin', '2025-09-10 15:45:27', '', NULL, '表单构建菜单');
INSERT INTO `sys_menu` VALUES (116, '代码生成', 3, 2, 'gen', 'tool/gen/index', '', '', 1, 0, 'C', '0', '0', 'tool:gen:list', 'code', 'admin', '2025-09-10 15:45:27', '', NULL, '代码生成菜单');
INSERT INTO `sys_menu` VALUES (117, '系统接口', 3, 3, 'swagger', 'tool/swagger/index', '', '', 1, 0, 'C', '0', '0', 'tool:swagger:list', 'swagger', 'admin', '2025-09-10 15:45:27', '', NULL, '系统接口菜单');
INSERT INTO `sys_menu` VALUES (500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', '', '', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'form', 'admin', '2025-09-10 15:45:27', '', NULL, '操作日志菜单');
INSERT INTO `sys_menu` VALUES (501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', '', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 'admin', '2025-09-10 15:45:27', '', NULL, '登录日志菜单');
INSERT INTO `sys_menu` VALUES (1000, '用户查询', 100, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 'admin', '2025-09-10 15:45:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1001, '用户新增', 100, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 'admin', '2025-09-10 15:45:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1002, '用户修改', 100, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 'admin', '2025-09-10 15:45:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1003, '用户删除', 100, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 'admin', '2025-09-10 15:45:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1004, '用户导出', 100, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 'admin', '2025-09-10 15:45:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1005, '用户导入', 100, 6, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 'admin', '2025-09-10 15:45:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1006, '重置密码', 100, 7, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2025-09-10 15:45:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1007, '角色查询', 101, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 'admin', '2025-09-10 15:45:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1008, '角色新增', 101, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 'admin', '2025-09-10 15:45:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1009, '角色修改', 101, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 'admin', '2025-09-10 15:45:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1010, '角色删除', 101, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 'admin', '2025-09-10 15:45:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1011, '角色导出', 101, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 'admin', '2025-09-10 15:45:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1012, '菜单查询', 102, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 'admin', '2025-09-10 15:45:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1013, '菜单新增', 102, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 'admin', '2025-09-10 15:45:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1014, '菜单修改', 102, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2025-09-10 15:45:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1015, '菜单删除', 102, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2025-09-10 15:45:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1016, '部门查询', 103, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 'admin', '2025-09-10 15:45:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1017, '部门新增', 103, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 'admin', '2025-09-10 15:45:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1018, '部门修改', 103, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2025-09-10 15:45:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1019, '部门删除', 103, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2025-09-10 15:45:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1020, '岗位查询', 104, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 'admin', '2025-09-10 15:45:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1021, '岗位新增', 104, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 'admin', '2025-09-10 15:45:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1022, '岗位修改', 104, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 'admin', '2025-09-10 15:45:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1023, '岗位删除', 104, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 'admin', '2025-09-10 15:45:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1024, '岗位导出', 104, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 'admin', '2025-09-10 15:45:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1025, '字典查询', 105, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 'admin', '2025-09-10 15:45:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1026, '字典新增', 105, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 'admin', '2025-09-10 15:45:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1027, '字典修改', 105, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2025-09-10 15:45:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1028, '字典删除', 105, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2025-09-10 15:45:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1029, '字典导出', 105, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 'admin', '2025-09-10 15:45:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1030, '参数查询', 106, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 'admin', '2025-09-10 15:45:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1031, '参数新增', 106, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 'admin', '2025-09-10 15:45:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1032, '参数修改', 106, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 'admin', '2025-09-10 15:45:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1033, '参数删除', 106, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 'admin', '2025-09-10 15:45:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1034, '参数导出', 106, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 'admin', '2025-09-10 15:45:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1035, '公告查询', 107, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 'admin', '2025-09-10 15:45:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1036, '公告新增', 107, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', 'admin', '2025-09-10 15:45:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1037, '公告修改', 107, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 'admin', '2025-09-10 15:45:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1038, '公告删除', 107, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 'admin', '2025-09-10 15:45:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1039, '操作查询', 500, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '#', 'admin', '2025-09-10 15:45:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1040, '操作删除', 500, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '#', 'admin', '2025-09-10 15:45:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1041, '日志导出', 500, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export', '#', 'admin', '2025-09-10 15:45:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1042, '登录查询', 501, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '#', 'admin', '2025-09-10 15:45:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1043, '登录删除', 501, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '#', 'admin', '2025-09-10 15:45:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1044, '日志导出', 501, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export', '#', 'admin', '2025-09-10 15:45:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1045, '账户解锁', 501, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:unlock', '#', 'admin', '2025-09-10 15:45:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1046, '在线查询', 109, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:query', '#', 'admin', '2025-09-10 15:45:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1047, '批量强退', 109, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', '2025-09-10 15:45:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1048, '单条强退', 109, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', '2025-09-10 15:45:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1049, '任务查询', 110, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:query', '#', 'admin', '2025-09-10 15:45:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1050, '任务新增', 110, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:add', '#', 'admin', '2025-09-10 15:45:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1051, '任务修改', 110, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:edit', '#', 'admin', '2025-09-10 15:45:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1052, '任务删除', 110, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:remove', '#', 'admin', '2025-09-10 15:45:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1053, '状态修改', 110, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:changeStatus', '#', 'admin', '2025-09-10 15:45:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1054, '任务导出', 110, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:export', '#', 'admin', '2025-09-10 15:45:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1055, '生成查询', 116, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:query', '#', 'admin', '2025-09-10 15:45:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1056, '生成修改', 116, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:edit', '#', 'admin', '2025-09-10 15:45:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1057, '生成删除', 116, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:remove', '#', 'admin', '2025-09-10 15:45:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1058, '导入代码', 116, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:import', '#', 'admin', '2025-09-10 15:45:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1059, '预览代码', 116, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:preview', '#', 'admin', '2025-09-10 15:45:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1060, '生成代码', 116, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:code', '#', 'admin', '2025-09-10 15:45:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2000, '会议室管理', 0, 4, 'meeting', NULL, NULL, '', 1, 0, 'M', '0', '0', '', 'build', 'admin', '2025-09-11 17:25:02', 'admin', '2025-09-11 17:32:59', '');
INSERT INTO `sys_menu` VALUES (2001, '审批管理', 2000, 1, 'approve', 'meeting/request/index.vue', NULL, '', 1, 0, 'C', '0', '0', '', 'education', 'admin', '2025-09-11 17:29:33', 'admin', '2025-09-13 15:20:15', '');
INSERT INTO `sys_menu` VALUES (2002, '申请管理', 2000, 2, 'applicant', 'meeting/detail/index.vue', NULL, '', 1, 0, 'C', '0', '0', 'meeting:request:list', 'button', 'admin', '2025-09-11 17:30:20', 'admin', '2025-09-13 15:26:58', '');
INSERT INTO `sys_menu` VALUES (2003, '预留', 2000, 3, 'reserve', 'meeting/reservation/index.vue', NULL, '', 1, 0, 'C', '0', '1', '', 'checkbox', 'admin', '2025-09-11 17:35:07', 'admin', '2025-09-27 18:18:56', '');
INSERT INTO `sys_menu` VALUES (2004, '会议室', 2000, 4, 'room', 'meeting/room/index.vue', NULL, '', 1, 0, 'C', '0', '0', 'meeting:room:list', 'documentation', 'admin', '2025-09-12 15:55:44', 'admin', '2025-09-13 15:28:10', '');
INSERT INTO `sys_menu` VALUES (2005, '查询会议室申请列表', 2002, 1, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'meeting:detail:list', '#', 'admin', '2025-09-13 15:22:26', 'ry', '2025-09-13 15:32:39', '');
INSERT INTO `sys_menu` VALUES (2006, '获取会议室申请详细信息', 2002, 2, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'meeting:request:query', '#', 'admin', '2025-09-13 15:22:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2007, '新增会议室申请（基础）', 2002, 3, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'meeting:request:add', '#', 'admin', '2025-09-13 15:23:32', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2008, '修改会议室申请（基础）', 2002, 5, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'meeting:request:edit', '#', 'admin', '2025-09-13 15:24:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2009, '删除会议室申请', 2002, 6, 'meeting:request:remove', NULL, NULL, '', 1, 0, 'F', '0', '0', 'meeting:request:remove', '#', 'admin', '2025-09-13 15:24:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2010, '提交会议室申请（支持统一或独立时段）', 2002, 7, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'meeting:request:submit', '#', 'admin', '2025-09-13 15:25:22', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2011, '查询会议室申请明细', 2002, 8, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'meeting:request:query', '#', 'admin', '2025-09-13 15:25:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2012, '冲突检测', 2002, 9, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'meeting:request:conflict', '#', 'admin', '2025-09-13 15:26:21', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2013, '查询会议室列表', 2002, 1, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'meeting:room:list', '#', 'admin', '2025-09-13 15:28:36', 'admin', '2025-09-27 17:50:26', '');
INSERT INTO `sys_menu` VALUES (2014, '获取会议室详细信息', 2002, 2, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'meeting:room:query', '#', 'admin', '2025-09-13 15:29:04', 'admin', '2025-09-27 17:50:32', '');
INSERT INTO `sys_menu` VALUES (2015, '查询空闲会议室', 2002, 3, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'meeting:room:free', '#', 'admin', '2025-09-13 15:29:32', 'admin', '2025-09-27 17:51:07', '');
INSERT INTO `sys_menu` VALUES (2016, '查询空闲时段', 2015, 1, '', NULL, NULL, '', 1, 0, 'F', '0', '0', ' meeting:reservation:list', '#', 'ry', '2025-09-20 15:58:53', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2018, '占用时段查询', 2002, 4, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'meeting:reservation:list', '#', 'admin', '2025-09-20 16:25:36', 'admin', '2025-09-27 17:51:14', '');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
  `notice_id` int NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '公告标题',
  `notice_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob NULL COMMENT '公告内容',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '通知公告表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO `sys_notice` VALUES (1, '温馨提醒：2018-07-01 若依新版本发布啦', '2', 0xE696B0E78988E69CACE58685E5AEB9, '0', 'admin', '2025-09-10 15:45:27', '', NULL, '管理员');
INSERT INTO `sys_notice` VALUES (2, '维护通知：2018-07-01 若依系统凌晨维护', '1', 0xE7BBB4E68AA4E58685E5AEB9, '0', 'admin', '2025-09-10 15:45:27', '', NULL, '管理员');

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
  `oper_id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '模块标题',
  `business_type` int NULL DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '请求方式',
  `operator_type` int NULL DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '返回参数',
  `status` int NULL DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime NULL DEFAULT NULL COMMENT '操作时间',
  `cost_time` bigint NULL DEFAULT 0 COMMENT '消耗时间',
  PRIMARY KEY (`oper_id`) USING BTREE,
  INDEX `idx_sys_oper_log_bt`(`business_type` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_ot`(`oper_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 261 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '操作日志记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO `sys_oper_log` VALUES (100, '部门管理', 3, 'com.ruoyi.web.controller.system.SysDeptController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/dept/101', '127.0.0.1', '内网IP', '101', '{\"msg\":\"存在下级部门,不允许删除\",\"code\":601}', 0, NULL, '2025-09-11 14:51:26', 13);
INSERT INTO `sys_oper_log` VALUES (101, '部门管理', 3, 'com.ruoyi.web.controller.system.SysDeptController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/dept/107', '127.0.0.1', '内网IP', '107', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-11 14:51:31', 9);
INSERT INTO `sys_oper_log` VALUES (102, '部门管理', 3, 'com.ruoyi.web.controller.system.SysDeptController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/dept/106', '127.0.0.1', '内网IP', '106', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-11 14:51:35', 8);
INSERT INTO `sys_oper_log` VALUES (103, '部门管理', 3, 'com.ruoyi.web.controller.system.SysDeptController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/dept/105', '127.0.0.1', '内网IP', '105', '{\"msg\":\"部门存在用户,不允许删除\",\"code\":601}', 0, NULL, '2025-09-11 14:51:38', 4);
INSERT INTO `sys_oper_log` VALUES (104, '部门管理', 3, 'com.ruoyi.web.controller.system.SysDeptController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/dept/104', '127.0.0.1', '内网IP', '104', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-11 14:51:42', 7);
INSERT INTO `sys_oper_log` VALUES (105, '部门管理', 3, 'com.ruoyi.web.controller.system.SysDeptController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/dept/103', '127.0.0.1', '内网IP', '103', '{\"msg\":\"部门存在用户,不允许删除\",\"code\":601}', 0, NULL, '2025-09-11 14:51:45', 4);
INSERT INTO `sys_oper_log` VALUES (106, '部门管理', 3, 'com.ruoyi.web.controller.system.SysDeptController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/dept/102', '127.0.0.1', '内网IP', '102', '{\"msg\":\"存在下级部门,不允许删除\",\"code\":601}', 0, NULL, '2025-09-11 14:51:48', 2);
INSERT INTO `sys_oper_log` VALUES (107, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"sys_config\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-11 15:08:46', 62);
INSERT INTO `sys_oper_log` VALUES (108, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"sys_config\"}', NULL, 0, NULL, '2025-09-11 15:09:02', 281);
INSERT INTO `sys_oper_log` VALUES (109, '代码生成', 3, 'com.ruoyi.generator.controller.GenController.remove()', 'DELETE', 1, 'admin', '研发部门', '/tool/gen/1', '127.0.0.1', '内网IP', '[1]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-11 15:09:35', 8);
INSERT INTO `sys_oper_log` VALUES (110, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0\",\"children\":[],\"deptId\":100,\"deptName\":\"学院\",\"email\":\"ry@qq.com\",\"leader\":\"若依\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-11 16:06:30', 15);
INSERT INTO `sys_oper_log` VALUES (111, '部门管理', 3, 'com.ruoyi.web.controller.system.SysDeptController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/dept/103', '127.0.0.1', '内网IP', '103', '{\"msg\":\"部门存在用户,不允许删除\",\"code\":601}', 0, NULL, '2025-09-11 16:06:37', 6);
INSERT INTO `sys_oper_log` VALUES (112, '部门管理', 3, 'com.ruoyi.web.controller.system.SysDeptController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/dept/103', '127.0.0.1', '内网IP', '103', '{\"msg\":\"部门存在用户,不允许删除\",\"code\":601}', 0, NULL, '2025-09-11 16:06:40', 7);
INSERT INTO `sys_oper_log` VALUES (113, '部门管理', 3, 'com.ruoyi.web.controller.system.SysDeptController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/dept/108', '127.0.0.1', '内网IP', '108', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-11 16:06:55', 8);
INSERT INTO `sys_oper_log` VALUES (114, '部门管理', 3, 'com.ruoyi.web.controller.system.SysDeptController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/dept/109', '127.0.0.1', '内网IP', '109', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-11 16:06:57', 10);
INSERT INTO `sys_oper_log` VALUES (115, '部门管理', 3, 'com.ruoyi.web.controller.system.SysDeptController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/dept/102', '127.0.0.1', '内网IP', '102', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-11 16:07:00', 10);
INSERT INTO `sys_oper_log` VALUES (116, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0\",\"children\":[],\"deptId\":100,\"deptName\":\"xx大学\",\"email\":\"ry@qq.com\",\"leader\":\"若依\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-11 16:07:09', 12);
INSERT INTO `sys_oper_log` VALUES (117, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100\",\"children\":[],\"deptId\":101,\"deptName\":\"xx学院\",\"email\":\"ry@qq.com\",\"leader\":\"若依\",\"orderNum\":1,\"params\":{},\"parentId\":100,\"parentName\":\"xx大学\",\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-11 16:07:19', 18);
INSERT INTO `sys_oper_log` VALUES (118, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":103,\"deptName\":\"行政\",\"email\":\"ry@qq.com\",\"leader\":\"若依\",\"orderNum\":1,\"params\":{},\"parentId\":101,\"parentName\":\"xx学院\",\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-11 16:07:32', 18);
INSERT INTO `sys_oper_log` VALUES (119, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":105,\"deptName\":\"职工\",\"email\":\"ry@qq.com\",\"leader\":\"若依\",\"orderNum\":3,\"params\":{},\"parentId\":101,\"parentName\":\"xx学院\",\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-11 16:07:41', 12);
INSERT INTO `sys_oper_log` VALUES (120, '创建表', 0, 'com.ruoyi.generator.controller.GenController.createTableSave()', 'POST', 1, 'admin', '行政', '/tool/gen/createTable', '127.0.0.1', '内网IP', '{\"sql\":\"\\n\\nCREATE TABLE MeetingRoom (\\n    room_id VARCHAR(20) PRIMARY KEY COMMENT \'会议室编号，如X31524\',\\n    capacity INT DEFAULT NULL COMMENT \'可选：容量\',\\n    location VARCHAR(100) DEFAULT NULL COMMENT \'可选：位置\'\\n);\\n\\n\\nCREATE TABLE ReservationRequest (\\n    request_id INT AUTO_INCREMENT PRIMARY KEY,\\n    applicant_id INT NOT NULL,\\n    status ENUM(\'pending\', \'approved\', \'rejected\') DEFAULT \'pending\',\\n    admin_id INT DEFAULT NULL COMMENT \'审批人（仅审批后有值）\',\\n    decision_time DATETIME DEFAULT NULL COMMENT \'审批时间\',\\n    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,\\n    FOREIGN KEY (applicant_id) REFERENCES User(user_id),\\n    FOREIGN KEY (admin_id) REFERENCES User(user_id)\\n);\\n\\n\\nCREATE TABLE ReservationRequestDetail (\\n    detail_id INT AUTO_INCREMENT PRIMARY KEY,\\n    request_id INT NOT NULL,\\n    room_id VARCHAR(20) NOT NULL,\\n    start_time DATETIME NOT NULL,\\n    end_time DATETIME NOT NULL,\\n    FOREIGN KEY (request_id) REFERENCES ReservationRequest(request_id),\\n    FOREIGN KEY (room_id) REFERENCES MeetingRoom(room_id)\\n);\\n\\n\\nCREATE TABLE RoomReservation (\\n    reserve_id INT AUTO_INCREMENT PRIMARY KEY,\\n    admin_id INT NOT NULL,\\n    room_id VARCHAR(20) NOT NULL,\\n    start_time DATETIME NOT NULL,\\n    end_time DATETIME NOT NULL,\\n    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,\\n    FOREIGN KEY (admin_id) REFERENCES User(user_id),\\n    FOREIGN KEY (room_id) REFERENCES MeetingRoom(room_id)\\n);\\n\"}', '{\"msg\":\"创建表结构异常\",\"code\":500}', 0, NULL, '2025-09-11 16:40:41', 178);
INSERT INTO `sys_oper_log` VALUES (121, '创建表', 0, 'com.ruoyi.generator.controller.GenController.createTableSave()', 'POST', 1, 'admin', '行政', '/tool/gen/createTable', '127.0.0.1', '内网IP', '{\"sql\":\"CREATE TABLE MeetingRoom (\\n    room_id VARCHAR(20) PRIMARY KEY COMMENT \'会议室编号，如X31524\',\\n    capacity INT DEFAULT NULL COMMENT \'可选：容量\',\\n    location VARCHAR(100) DEFAULT NULL COMMENT \'可选：位置\'\\n);\\nCREATE TABLE ReservationRequest (\\n    request_id INT AUTO_INCREMENT PRIMARY KEY,\\n    applicant_id INT NOT NULL,\\n    status ENUM(\'pending\', \'approved\', \'rejected\') DEFAULT \'pending\',\\n    admin_id INT DEFAULT NULL COMMENT \'审批人（仅审批后有值）\',\\n    decision_time DATETIME DEFAULT NULL COMMENT \'审批时间\',\\n    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,\\n    FOREIGN KEY (applicant_id) REFERENCES User(user_id),\\n    FOREIGN KEY (admin_id) REFERENCES User(user_id)\\n);\\nCREATE TABLE ReservationRequestDetail (\\n    detail_id INT AUTO_INCREMENT PRIMARY KEY,\\n    request_id INT NOT NULL,\\n    room_id VARCHAR(20) NOT NULL,\\n    start_time DATETIME NOT NULL,\\n    end_time DATETIME NOT NULL,\\n    FOREIGN KEY (request_id) REFERENCES ReservationRequest(request_id),\\n    FOREIGN KEY (room_id) REFERENCES MeetingRoom(room_id)\\n);\\nCREATE TABLE RoomReservation (\\n    reserve_id INT AUTO_INCREMENT PRIMARY KEY,\\n    admin_id INT NOT NULL,\\n    room_id VARCHAR(20) NOT NULL,\\n    start_time DATETIME NOT NULL,\\n    end_time DATETIME NOT NULL,\\n    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,\\n    FOREIGN KEY (admin_id) REFERENCES User(user_id),\\n    FOREIGN KEY (room_id) REFERENCES MeetingRoom(room_id)\\n);\\n\"}', '{\"msg\":\"创建表结构异常\",\"code\":500}', 0, NULL, '2025-09-11 16:40:55', 9);
INSERT INTO `sys_oper_log` VALUES (122, '创建表', 0, 'com.ruoyi.generator.controller.GenController.createTableSave()', 'POST', 1, 'admin', '行政', '/tool/gen/createTable', '127.0.0.1', '内网IP', '{\"sql\":\"-- ----------------------------\\n-- 客户表\\n-- ----------------------------\\ndrop table if exists sys_customer;\\ncreate table sys_customer (\\n  customer_id           bigint(20)      not null auto_increment    comment \'客户id\',\\n  customer_name         varchar(30)     default \'\'                 comment \'客户姓名\',\\n  phonenumber           varchar(11)     default \'\'                 comment \'手机号码\',\\n  sex                   varchar(20)     default null               comment \'客户性别\',\\n  birthday              datetime                                   comment \'客户生日\',\\n  remark                varchar(500)    default null               comment \'客户描述\',\\n  primary key (customer_id)\\n) engine=innodb auto_increment=1 comment = \'客户表\';\\n\\n\\n-- ----------------------------\\n-- 商品表\\n-- ----------------------------\\ndrop table if exists sys_goods;\\ncreate table sys_goods (\\n  goods_id           bigint(20)      not null auto_increment    comment \'商品id\',\\n  customer_id        bigint(20)      not null                   comment \'客户id\',\\n  name               varchar(30)     default \'\'                 comment \'商品名称\',\\n  weight             int(5)          default null               comment \'商品重量\',\\n  price              decimal(6,2)    default null               comment \'商品价格\',\\n  date               datetime                                   comment \'商品时间\',\\n  type               char(1)         default null               comment \'商品种类\',\\n  primary key (goods_id)\\n) engine=innodb auto_increment=1 comment = \'商品表\';\"}', '{\"msg\":\"创建表结构异常\",\"code\":500}', 0, NULL, '2025-09-11 16:47:26', 16);
INSERT INTO `sys_oper_log` VALUES (123, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '行政', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"meetingroom\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-11 16:47:42', 32);
INSERT INTO `sys_oper_log` VALUES (124, '代码生成', 3, 'com.ruoyi.generator.controller.GenController.remove()', 'DELETE', 1, 'admin', '行政', '/tool/gen/2', '127.0.0.1', '内网IP', '[2]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-11 16:48:07', 8);
INSERT INTO `sys_oper_log` VALUES (125, '创建表', 0, 'com.ruoyi.generator.controller.GenController.createTableSave()', 'POST', 1, 'admin', '行政', '/tool/gen/createTable', '127.0.0.1', '内网IP', '{\"sql\":\"\\ndrop table if exists sys_customer;\\ncreate table sys_customer (\\n  customer_id           bigint(20)      not null auto_increment    comment \'客户id\',\\n  customer_name         varchar(30)     default \'\'                 comment \'客户姓名\',\\n  phonenumber           varchar(11)     default \'\'                 comment \'手机号码\',\\n  sex                   varchar(20)     default null               comment \'客户性别\',\\n  birthday              datetime                                   comment \'客户生日\',\\n  remark                varchar(500)    default null               comment \'客户描述\',\\n  primary key (customer_id)\\n) engine=innodb auto_increment=1 comment = \'客户表\';\\n\\n\\n\\ndrop table if exists sys_goods;\\ncreate table sys_goods (\\n  goods_id           bigint(20)      not null auto_increment    comment \'商品id\',\\n  customer_id        bigint(20)      not null                   comment \'客户id\',\\n  name               varchar(30)     default \'\'                 comment \'商品名称\',\\n  weight             int(5)          default null               comment \'商品重量\',\\n  price              decimal(6,2)    default null               comment \'商品价格\',\\n  date               datetime                                   comment \'商品时间\',\\n  type               char(1)         default null               comment \'商品种类\',\\n  primary key (goods_id)\\n) engine=innodb auto_increment=1 comment = \'商品表\';\"}', '{\"msg\":\"创建表结构异常\",\"code\":500}', 0, NULL, '2025-09-11 16:48:36', 1);
INSERT INTO `sys_oper_log` VALUES (126, '创建表', 0, 'com.ruoyi.generator.controller.GenController.createTableSave()', 'POST', 1, 'admin', '行政', '/tool/gen/createTable', '127.0.0.1', '内网IP', '{\"sql\":\"\\ndrop table if exists sys_customer;\\ncreate table sys_customer (\\n  customer_id           bigint(20)      not null auto_increment    comment \'客户id\',\\n  customer_name         varchar(30)     default \'\'                 comment \'客户姓名\',\\n  phonenumber           varchar(11)     default \'\'                 comment \'手机号码\',\\n  sex                   varchar(20)     default null               comment \'客户性别\',\\n  birthday              datetime                                   comment \'客户生日\',\\n  remark                varchar(500)    default null               comment \'客户描述\',\\n  primary key (customer_id)\\n) engine=innodb auto_increment=1 comment = \'客户表\';\\n\\n\\n\\ndrop table if exists sys_goods;\\ncreate table sys_goods (\\n  goods_id           bigint(20)      not null auto_increment    comment \'商品id\',\\n  customer_id        bigint(20)      not null                   comment \'客户id\',\\n  name               varchar(30)     default \'\'                 comment \'商品名称\',\\n  weight             int(5)          default null               comment \'商品重量\',\\n  price              decimal(6,2)    default null               comment \'商品价格\',\\n  date               datetime                                   comment \'商品时间\',\\n  type               char(1)         default null               comment \'商品种类\',\\n  primary key (goods_id)\\n) engine=innodb auto_increment=1 comment = \'商品表\';\"}', '{\"msg\":\"创建表结构异常\",\"code\":500}', 0, NULL, '2025-09-11 16:49:13', 2);
INSERT INTO `sys_oper_log` VALUES (127, '创建表', 0, 'com.ruoyi.generator.controller.GenController.createTableSave()', 'POST', 1, 'admin', '行政', '/tool/gen/createTable', '127.0.0.1', '内网IP', '{\"sql\":\"\\ndrop table if exists sys_customer;\\ncreate table sys_customer (\\n  customer_id           bigint(20)      not null auto_increment    comment \'客户id\',\\n  customer_name         varchar(30)     default \'\'                 comment \'客户姓名\',\\n  phonenumber           varchar(11)     default \'\'                 comment \'手机号码\',\\n  sex                   varchar(20)     default null               comment \'客户性别\',\\n  birthday              datetime                                   comment \'客户生日\',\\n  remark                varchar(500)    default null               comment \'客户描述\',\\n  primary key (customer_id)\\n) engine=innodb auto_increment=1 comment = \'客户表\';\\n\\n\\n\\ndrop table if exists sys_goods;\\ncreate table sys_goods (\\n  goods_id           bigint(20)      not null auto_increment    comment \'商品id\',\\n  customer_id        bigint(20)      not null                   comment \'客户id\',\\n  name               varchar(30)     default \'\'                 comment \'商品名称\',\\n  weight             int(5)          default null               comment \'商品重量\',\\n  price              decimal(6,2)    default null               comment \'商品价格\',\\n  date               datetime                                   comment \'商品时间\',\\n  type               char(1)         default null               comment \'商品种类\',\\n  primary key (goods_id)\\n) engine=innodb auto_increment=1 comment = \'商品表\';\"}', '{\"msg\":\"创建表结构异常\",\"code\":500}', 0, NULL, '2025-09-11 16:59:22', 73575);
INSERT INTO `sys_oper_log` VALUES (128, '创建表', 0, 'com.ruoyi.generator.controller.GenController.createTableSave()', 'POST', 1, 'admin', '行政', '/tool/gen/createTable', '127.0.0.1', '内网IP', '{\"sql\":\"CREATE TABLE MeetingRoom (\\n    room_id VARCHAR(20) PRIMARY KEY COMMENT \'会议室编号，如X31524\',\\n    capacity INT DEFAULT NULL COMMENT \'可选：容量\',\\n    location VARCHAR(100) DEFAULT NULL COMMENT \'可选：位置\'\\n);\\nCREATE TABLE ReservationRequest (\\n    request_id INT AUTO_INCREMENT PRIMARY KEY,\\n    applicant_id INT NOT NULL,\\n    status ENUM(\'pending\', \'approved\', \'rejected\') DEFAULT \'pending\',\\n    admin_id INT DEFAULT NULL COMMENT \'审批人（仅审批后有值）\',\\n    decision_time DATETIME DEFAULT NULL COMMENT \'审批时间\',\\n    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,\\n    FOREIGN KEY (applicant_id) REFERENCES User(user_id),\\n    FOREIGN KEY (admin_id) REFERENCES User(user_id)\\n);\\nCREATE TABLE ReservationRequestDetail (\\n    detail_id INT AUTO_INCREMENT PRIMARY KEY,\\n    request_id INT NOT NULL,\\n    room_id VARCHAR(20) NOT NULL,\\n    start_time DATETIME NOT NULL,\\n    end_time DATETIME NOT NULL,\\n    FOREIGN KEY (request_id) REFERENCES ReservationRequest(request_id),\\n    FOREIGN KEY (room_id) REFERENCES MeetingRoom(room_id)\\n);\\nCREATE TABLE RoomReservation (\\n    reserve_id INT AUTO_INCREMENT PRIMARY KEY,\\n    admin_id INT NOT NULL,\\n    room_id VARCHAR(20) NOT NULL,\\n    start_time DATETIME NOT NULL,\\n    end_time DATETIME NOT NULL,\\n    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,\\n    FOREIGN KEY (admin_id) REFERENCES User(user_id),\\n    FOREIGN KEY (room_id) REFERENCES MeetingRoom(room_id)\\n);\\n\"}', '{\"msg\":\"创建表结构异常\",\"code\":500}', 0, NULL, '2025-09-11 17:03:16', 151785);
INSERT INTO `sys_oper_log` VALUES (129, '创建表', 0, 'com.ruoyi.generator.controller.GenController.createTableSave()', 'POST', 1, 'admin', '行政', '/tool/gen/createTable', '127.0.0.1', '内网IP', '{\"sql\":\"CREATE TABLE user (\\n    user_id INT AUTO_INCREMENT PRIMARY KEY,\\n    name VARCHAR(50) NOT NULL,\\n    role ENUM(\'staff\', \'admin\') NOT NULL COMMENT \'staff=普通职工, admin=行政人员\'\\n);\\n\\nCREATE TABLE meeting_room (\\n    room_id VARCHAR(20) PRIMARY KEY COMMENT \'会议室编号，如X31524\',\\n    capacity INT DEFAULT NULL COMMENT \'容量\',\\n    location VARCHAR(100) DEFAULT NULL COMMENT \'位置\'\\n);\\n\\nCREATE TABLE reservation_request (\\n    request_id INT AUTO_INCREMENT PRIMARY KEY,\\n    applicant_id INT NOT NULL COMMENT \'申请人ID（逻辑外键，关联user.user_id）\',\\n    status ENUM(\'pending\', \'approved\', \'rejected\') DEFAULT \'pending\',\\n    admin_id INT DEFAULT NULL COMMENT \'审批人ID（逻辑外键，关联user.user_id）\',\\n    decision_time DATETIME DEFAULT NULL COMMENT \'审批时间\',\\n    created_at DATETIME DEFAULT CURRENT_TIMESTAMP\\n);\\n\\nCREATE TABLE reservation_request_detail (\\n    detail_id INT AUTO_INCREMENT PRIMARY KEY,\\n    request_id INT NOT NULL COMMENT \'逻辑外键 reservation_request.request_id\',\\n    room_id VARCHAR(20) NOT NULL COMMENT \'逻辑外键 meeting_room.room_id\',\\n    start_time DATETIME NOT NULL,\\n    end_time DATETIME NOT NULL\\n);\\n\\nCREATE TABLE room_reservation (\\n    reserve_id INT AUTO_INCREMENT PRIMARY KEY,\\n    admin_id INT NOT NULL COMMENT \'逻辑外键 user.user_id\',\\n    room_id VARCHAR(20) NOT NULL COMMENT \'逻辑外键 meeting_room.room_id\',\\n    start_time DATETIME NOT NULL,\\n    end_time DATETIME NOT NULL,\\n    created_at DATETIME DEFAULT CURRENT_TIMESTAMP\\n);\\n\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-11 17:07:40', 2886);
INSERT INTO `sys_oper_log` VALUES (130, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.synchDb()', 'GET', 1, 'admin', '行政', '/tool/gen/synchDb/meeting_room', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-11 17:08:52', 21);
INSERT INTO `sys_oper_log` VALUES (131, '代码生成', 3, 'com.ruoyi.generator.controller.GenController.remove()', 'DELETE', 1, 'admin', '行政', '/tool/gen/7', '127.0.0.1', '内网IP', '[7]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-11 17:09:20', 8);
INSERT INTO `sys_oper_log` VALUES (132, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '行政', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"meeting_room,reservation_request,reservation_request_detail,room_reservation\"}', NULL, 0, NULL, '2025-09-11 17:09:23', 347);
INSERT INTO `sys_oper_log` VALUES (133, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '行政', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"meeting_room,reservation_request,reservation_request_detail,room_reservation\"}', NULL, 0, NULL, '2025-09-11 17:20:37', 396);
INSERT INTO `sys_oper_log` VALUES (134, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '行政', '/system/menu/4', '127.0.0.1', '内网IP', '4', '{\"msg\":\"菜单已分配,不允许删除\",\"code\":601}', 0, NULL, '2025-09-11 17:22:35', 9);
INSERT INTO `sys_oper_log` VALUES (135, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '行政', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-09-10 15:45:27\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114,3,115,116,1055,1056,1057,1058,1059,1060,117],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-11 17:22:54', 25);
INSERT INTO `sys_oper_log` VALUES (136, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '行政', '/system/menu/4', '127.0.0.1', '内网IP', '4', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-11 17:23:13', 7);
INSERT INTO `sys_oper_log` VALUES (137, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '行政', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"build\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"会议室管理\",\"menuType\":\"C\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"meeting\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-11 17:25:02', 16);
INSERT INTO `sys_oper_log` VALUES (138, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '行政', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"education\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"审批管理\",\"menuType\":\"M\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"approve\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-11 17:29:33', 7);
INSERT INTO `sys_oper_log` VALUES (139, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '行政', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"button\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"提交申请\",\"menuType\":\"M\",\"orderNum\":2,\"params\":{},\"parentId\":2000,\"path\":\"applicant\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-11 17:30:20', 5);
INSERT INTO `sys_oper_log` VALUES (140, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '行政', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-09-10 15:45:27\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2000,1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114,3,115,116,1055,1056,1057,1058,1059,1060,117,2002],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-11 17:31:32', 16);
INSERT INTO `sys_oper_log` VALUES (141, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '行政', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-09-11 17:29:33\",\"icon\":\"education\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2001,\"menuName\":\"审批管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"approve\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-11 17:32:07', 6);
INSERT INTO `sys_oper_log` VALUES (142, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '行政', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-09-11 17:29:33\",\"icon\":\"education\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2001,\"menuName\":\"审批管理\",\"menuType\":\"M\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"approve\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-11 17:32:26', 6);
INSERT INTO `sys_oper_log` VALUES (143, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '行政', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-09-11 17:30:20\",\"icon\":\"button\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2002,\"menuName\":\"提交申请\",\"menuType\":\"M\",\"orderNum\":2,\"params\":{},\"parentId\":2000,\"path\":\"applicant\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-11 17:32:32', 5);
INSERT INTO `sys_oper_log` VALUES (144, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '行政', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-09-11 17:25:02\",\"icon\":\"build\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"会议室管理\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"meeting\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-11 17:32:59', 5);
INSERT INTO `sys_oper_log` VALUES (145, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '行政', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"预留\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2000,\"path\":\"reserve\",\"routeName\":\"\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-11 17:35:07', 7);
INSERT INTO `sys_oper_log` VALUES (146, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '行政', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-09-11 17:29:33\",\"icon\":\"education\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2001,\"menuName\":\"审批管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"approve\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-11 17:36:25', 5);
INSERT INTO `sys_oper_log` VALUES (147, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '行政', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-09-11 17:30:20\",\"icon\":\"button\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2002,\"menuName\":\"提交申请\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2000,\"path\":\"applicant\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-11 17:36:29', 5);
INSERT INTO `sys_oper_log` VALUES (148, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '行政', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-09-11 17:35:07\",\"icon\":\"checkbox\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2003,\"menuName\":\"预留\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2000,\"path\":\"reserve\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-11 17:36:41', 7);
INSERT INTO `sys_oper_log` VALUES (149, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '行政', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"meeting_room,reservation_request,reservation_request_detail,room_reservation\"}', NULL, 0, NULL, '2025-09-11 17:42:27', 368);
INSERT INTO `sys_oper_log` VALUES (150, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '行政', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"meeting/reservation\",\"createTime\":\"2025-09-11 17:29:33\",\"icon\":\"education\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2001,\"menuName\":\"审批管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"approve\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-11 17:53:39', 9);
INSERT INTO `sys_oper_log` VALUES (151, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '行政', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"meeting/request/index.vue\",\"createTime\":\"2025-09-11 17:29:33\",\"icon\":\"education\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2001,\"menuName\":\"审批管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"approve\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-11 17:54:50', 6);
INSERT INTO `sys_oper_log` VALUES (152, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '行政', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"meeting/reservation/index.vue\",\"createTime\":\"2025-09-11 17:35:07\",\"icon\":\"checkbox\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2003,\"menuName\":\"预留\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2000,\"path\":\"reserve\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-11 17:56:19', 6);
INSERT INTO `sys_oper_log` VALUES (153, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '行政', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"meeting/detail/index.vue\",\"createTime\":\"2025-09-11 17:30:20\",\"icon\":\"button\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2002,\"menuName\":\"提交申请\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2000,\"path\":\"applicant\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-11 17:56:50', 5);
INSERT INTO `sys_oper_log` VALUES (154, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '行政', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"documentation\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"会议室\",\"menuType\":\"C\",\"orderNum\":4,\"params\":{},\"parentId\":2000,\"path\":\"room\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-12 15:55:44', 27);
INSERT INTO `sys_oper_log` VALUES (155, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '行政', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-09-10 15:45:27\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2000,1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114,3,115,116,1055,1056,1057,1058,1059,1060,117,2002,2004],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-12 15:55:57', 46);
INSERT INTO `sys_oper_log` VALUES (156, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '行政', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"meeting/room/index.vue\",\"createTime\":\"2025-09-12 15:55:44\",\"icon\":\"documentation\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2004,\"menuName\":\"会议室\",\"menuType\":\"C\",\"orderNum\":4,\"params\":{},\"parentId\":2000,\"path\":\"room\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-12 19:55:04', 34);
INSERT INTO `sys_oper_log` VALUES (157, '会议室管理', 1, 'com.ruoyi.meeting.controller.MeetingRoomController.add()', 'POST', 1, 'admin', '行政', '/meeting/room', '127.0.0.1', '内网IP', '{\"capacity\":30,\"location\":\"X31524\",\"params\":{}}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'room_id\' cannot be null\r\n### The error may exist in file [D:\\JavaProgram\\RuoYi-Vue-master\\RuoYi-Vue-master\\ruoyi-system\\target\\classes\\mapper\\meeting\\MeetingRoomMapper.xml]\r\n### The error may involve com.ruoyi.meeting.mapper.MeetingRoomMapper.insertMeetingRoom-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into meeting_room (room_id, capacity, location, create_time)         values (?, ?, ?, now())\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'room_id\' cannot be null\n; Column \'room_id\' cannot be null; nested exception is java.sql.SQLIntegrityConstraintViolationException: Column \'room_id\' cannot be null', '2025-09-12 19:57:24', 131);
INSERT INTO `sys_oper_log` VALUES (158, '会议室管理', 1, 'com.ruoyi.meeting.controller.MeetingRoomController.add()', 'POST', 1, 'admin', '行政', '/meeting/room', '127.0.0.1', '内网IP', '{\"capacity\":30,\"location\":\"SDA\",\"params\":{}}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'room_id\' cannot be null\r\n### The error may exist in file [D:\\JavaProgram\\RuoYi-Vue-master\\RuoYi-Vue-master\\ruoyi-system\\target\\classes\\mapper\\meeting\\MeetingRoomMapper.xml]\r\n### The error may involve com.ruoyi.meeting.mapper.MeetingRoomMapper.insertMeetingRoom-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into meeting_room (room_id, capacity, location, create_time)         values (?, ?, ?, now())\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'room_id\' cannot be null\n; Column \'room_id\' cannot be null; nested exception is java.sql.SQLIntegrityConstraintViolationException: Column \'room_id\' cannot be null', '2025-09-12 19:58:00', 3);
INSERT INTO `sys_oper_log` VALUES (159, '会议室管理', 1, 'com.ruoyi.meeting.controller.MeetingRoomController.add()', 'POST', 1, 'admin', '行政', '/meeting/room', '127.0.0.1', '内网IP', '{\"capacity\":30,\"location\":\"XXX\",\"params\":{},\"roomId\":\"X31524\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-12 20:06:07', 4);
INSERT INTO `sys_oper_log` VALUES (160, '会议室管理', 1, 'com.ruoyi.meeting.controller.MeetingRoomController.add()', 'POST', 1, 'admin', '行政', '/meeting/room', '127.0.0.1', '内网IP', '{\"capacity\":20,\"location\":\"XXX\",\"params\":{},\"roomId\":\"X31525\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-12 20:06:21', 4);
INSERT INTO `sys_oper_log` VALUES (161, '会议室管理', 1, 'com.ruoyi.meeting.controller.MeetingRoomController.add()', 'POST', 1, 'admin', '行政', '/meeting/room', '127.0.0.1', '内网IP', '{\"capacity\":40,\"location\":\"XXXX\",\"params\":{},\"roomId\":\"X31526\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-12 20:06:55', 3);
INSERT INTO `sys_oper_log` VALUES (162, '会议室管理', 1, 'com.ruoyi.meeting.controller.MeetingRoomController.add()', 'POST', 1, 'admin', '行政', '/meeting/room', '127.0.0.1', '内网IP', '{\"capacity\":50,\"location\":\"XXXX\",\"params\":{},\"roomId\":\"X31541\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-12 20:07:11', 4);
INSERT INTO `sys_oper_log` VALUES (163, '会议室预留', 1, 'com.ruoyi.meeting.controller.RoomReservationController.add()', 'POST', 1, 'admin', '行政', '/meeting/reservation', '127.0.0.1', '内网IP', '{\"endTime\":\"2025-10-02 00:00\",\"params\":{},\"roomId\":\"X31524\",\"startTime\":\"2025-09-12 00:00\"}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'admin_id\' cannot be null\r\n### The error may exist in file [D:\\JavaProgram\\RuoYi-Vue-master\\RuoYi-Vue-master\\ruoyi-system\\target\\classes\\mapper\\meeting\\RoomReservationMapper.xml]\r\n### The error may involve com.ruoyi.meeting.mapper.RoomReservationMapper.insertRoomReservation-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into room_reservation(admin_id, room_id, start_time, end_time, create_time)         values(?, ?, ?, ?, now())\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'admin_id\' cannot be null\n; Column \'admin_id\' cannot be null; nested exception is java.sql.SQLIntegrityConstraintViolationException: Column \'admin_id\' cannot be null', '2025-09-12 20:08:02', 7);
INSERT INTO `sys_oper_log` VALUES (164, '会议室预留', 1, 'com.ruoyi.meeting.controller.RoomReservationController.add()', 'POST', 1, 'admin', '行政', '/meeting/reservation', '127.0.0.1', '内网IP', '{\"endTime\":\"2025-10-02 00:00\",\"params\":{},\"roomId\":\"X31524\",\"startTime\":\"2025-09-12 00:00\"}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'admin_id\' cannot be null\r\n### The error may exist in file [D:\\JavaProgram\\RuoYi-Vue-master\\RuoYi-Vue-master\\ruoyi-system\\target\\classes\\mapper\\meeting\\RoomReservationMapper.xml]\r\n### The error may involve com.ruoyi.meeting.mapper.RoomReservationMapper.insertRoomReservation-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into room_reservation(admin_id, room_id, start_time, end_time, create_time)         values(?, ?, ?, ?, now())\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'admin_id\' cannot be null\n; Column \'admin_id\' cannot be null; nested exception is java.sql.SQLIntegrityConstraintViolationException: Column \'admin_id\' cannot be null', '2025-09-12 20:08:07', 2);
INSERT INTO `sys_oper_log` VALUES (165, '会议室预留', 1, 'com.ruoyi.meeting.controller.RoomReservationController.add()', 'POST', 1, 'admin', '行政', '/meeting/reservation', '127.0.0.1', '内网IP', '{\"endTime\":\"2025-10-02 00:00\",\"params\":{},\"roomId\":\"X31524\",\"startTime\":\"2025-09-12 00:00\"}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'admin_id\' cannot be null\r\n### The error may exist in file [D:\\JavaProgram\\RuoYi-Vue-master\\RuoYi-Vue-master\\ruoyi-system\\target\\classes\\mapper\\meeting\\RoomReservationMapper.xml]\r\n### The error may involve com.ruoyi.meeting.mapper.RoomReservationMapper.insertRoomReservation-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into room_reservation(admin_id, room_id, start_time, end_time, create_time)         values(?, ?, ?, ?, now())\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'admin_id\' cannot be null\n; Column \'admin_id\' cannot be null; nested exception is java.sql.SQLIntegrityConstraintViolationException: Column \'admin_id\' cannot be null', '2025-09-12 20:08:11', 2);
INSERT INTO `sys_oper_log` VALUES (166, '会议室预留', 1, 'com.ruoyi.meeting.controller.RoomReservationController.add()', 'POST', 1, 'admin', '行政', '/meeting/reservation', '127.0.0.1', '内网IP', '{\"endTime\":\"2025-10-02 00:00\",\"params\":{},\"roomId\":\"X31524\",\"startTime\":\"2025-09-12 00:00\"}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'admin_id\' cannot be null\r\n### The error may exist in file [D:\\JavaProgram\\RuoYi-Vue-master\\RuoYi-Vue-master\\ruoyi-system\\target\\classes\\mapper\\meeting\\RoomReservationMapper.xml]\r\n### The error may involve com.ruoyi.meeting.mapper.RoomReservationMapper.insertRoomReservation-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into room_reservation(admin_id, room_id, start_time, end_time, create_time)         values(?, ?, ?, ?, now())\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'admin_id\' cannot be null\n; Column \'admin_id\' cannot be null; nested exception is java.sql.SQLIntegrityConstraintViolationException: Column \'admin_id\' cannot be null', '2025-09-12 20:08:15', 3);
INSERT INTO `sys_oper_log` VALUES (167, '会议室预留', 1, 'com.ruoyi.meeting.controller.RoomReservationController.add()', 'POST', 1, 'admin', '行政', '/meeting/reservation', '127.0.0.1', '内网IP', '{\"endTime\":\"2025-10-02 00:00\",\"params\":{},\"roomId\":\"X31524\",\"startTime\":\"2025-09-12 00:00\"}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'admin_id\' cannot be null\r\n### The error may exist in file [D:\\JavaProgram\\RuoYi-Vue-master\\RuoYi-Vue-master\\ruoyi-system\\target\\classes\\mapper\\meeting\\RoomReservationMapper.xml]\r\n### The error may involve com.ruoyi.meeting.mapper.RoomReservationMapper.insertRoomReservation-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into room_reservation(admin_id, room_id, start_time, end_time, create_time)         values(?, ?, ?, ?, now())\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'admin_id\' cannot be null\n; Column \'admin_id\' cannot be null; nested exception is java.sql.SQLIntegrityConstraintViolationException: Column \'admin_id\' cannot be null', '2025-09-12 20:08:18', 2);
INSERT INTO `sys_oper_log` VALUES (168, '会议室预留', 1, 'com.ruoyi.meeting.controller.RoomReservationController.add()', 'POST', 1, 'admin', '行政', '/meeting/reservation', '127.0.0.1', '内网IP', '{\"endTime\":\"2025-10-02 00:00\",\"params\":{},\"roomId\":\"X31524\",\"startTime\":\"2025-09-12 00:00\"}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'admin_id\' cannot be null\r\n### The error may exist in file [D:\\JavaProgram\\RuoYi-Vue-master\\RuoYi-Vue-master\\ruoyi-system\\target\\classes\\mapper\\meeting\\RoomReservationMapper.xml]\r\n### The error may involve com.ruoyi.meeting.mapper.RoomReservationMapper.insertRoomReservation-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into room_reservation(admin_id, room_id, start_time, end_time, create_time)         values(?, ?, ?, ?, now())\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'admin_id\' cannot be null\n; Column \'admin_id\' cannot be null; nested exception is java.sql.SQLIntegrityConstraintViolationException: Column \'admin_id\' cannot be null', '2025-09-12 20:08:22', 2);
INSERT INTO `sys_oper_log` VALUES (169, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '行政', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"meeting/detail/index.vue\",\"createTime\":\"2025-09-11 17:30:20\",\"icon\":\"button\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2002,\"menuName\":\"申请管理\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2000,\"path\":\"applicant\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-12 20:27:05', 9);
INSERT INTO `sys_oper_log` VALUES (170, '会议室预留', 1, 'com.ruoyi.meeting.controller.RoomReservationController.add()', 'POST', 1, 'admin', '行政', '/meeting/reservation', '127.0.0.1', '内网IP', '{\"endTime\":\"2025-09-13 00:00\",\"params\":{},\"roomId\":\"X31524\",\"startTime\":\"2025-09-12 00:00\"}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'admin_id\' cannot be null\r\n### The error may exist in file [D:\\JavaProgram\\RuoYi-Vue-master\\RuoYi-Vue-master\\ruoyi-system\\target\\classes\\mapper\\meeting\\RoomReservationMapper.xml]\r\n### The error may involve com.ruoyi.meeting.mapper.RoomReservationMapper.insertRoomReservation-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into room_reservation(admin_id, room_id, start_time, end_time, create_time)         values(?, ?, ?, ?, now())\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'admin_id\' cannot be null\n; Column \'admin_id\' cannot be null; nested exception is java.sql.SQLIntegrityConstraintViolationException: Column \'admin_id\' cannot be null', '2025-09-12 20:38:25', 3);
INSERT INTO `sys_oper_log` VALUES (171, '会议室申请提交', 1, 'com.ruoyi.meeting.controller.ReservationRequestController.submit()', 'POST', 1, 'admin', '行政', '/meeting/request/submit', '127.0.0.1', '内网IP', '{\"endTime\":\"2025-09-13 00:00\",\"remark\":\"\",\"roomIds\":[\"X31524\"],\"startTime\":\"2025-09-12 00:00\"}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":1}', 0, NULL, '2025-09-12 20:39:08', 44);
INSERT INTO `sys_oper_log` VALUES (172, '会议室申请审批', 2, 'com.ruoyi.meeting.controller.ReservationRequestController.approve()', 'POST', 1, 'admin', '行政', '/meeting/request/approve', '127.0.0.1', '内网IP', '{\"decisionRemark\":\"da\",\"endTime\":\"2025-09-13 00:00\",\"requestId\":1,\"roomIds\":[\"X31525\"],\"startTime\":\"2025-09-12 00:00\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-12 20:40:00', 19);
INSERT INTO `sys_oper_log` VALUES (173, '会议室申请提交', 1, 'com.ruoyi.meeting.controller.ReservationRequestController.submit()', 'POST', 1, 'admin', '行政', '/meeting/request/submit', '127.0.0.1', '内网IP', '{\"endTime\":\"2025-09-13 00:00\",\"remark\":\"eda\",\"roomIds\":[\"X31524\"],\"startTime\":\"2025-09-12 00:00\"}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":2}', 0, NULL, '2025-09-12 20:40:59', 10);
INSERT INTO `sys_oper_log` VALUES (174, '会议室申请审批', 2, 'com.ruoyi.meeting.controller.ReservationRequestController.approve()', 'POST', 1, 'admin', '行政', '/meeting/request/approve', '127.0.0.1', '内网IP', '{\"decisionRemark\":\"\",\"endTime\":\"2025-09-13 00:00\",\"requestId\":2,\"roomIds\":[\"X31524\"],\"startTime\":\"2025-09-12 00:00\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-12 20:44:19', 11);
INSERT INTO `sys_oper_log` VALUES (175, '会议室申请提交', 1, 'com.ruoyi.meeting.controller.ReservationRequestController.submit()', 'POST', 1, 'admin', '行政', '/meeting/request/submit', '127.0.0.1', '内网IP', '{\"endTime\":\"2025-09-13 00:00\",\"remark\":\"\",\"roomIds\":[\"X31525\"],\"startTime\":\"2025-09-12 00:00\"}', NULL, 1, '存在冲突(共1条)：X31525(2025-09-12 00:00~2025-09-13 00:00,REQUEST#1)', '2025-09-12 20:44:40', 10);
INSERT INTO `sys_oper_log` VALUES (176, '会议室申请提交', 1, 'com.ruoyi.meeting.controller.ReservationRequestController.submit()', 'POST', 1, 'admin', '行政', '/meeting/request/submit', '127.0.0.1', '内网IP', '{\"endTime\":\"2025-09-13 00:00\",\"remark\":\"\",\"roomIds\":[\"X31525\"],\"startTime\":\"2025-09-12 00:00\"}', NULL, 1, '存在冲突(共1条)：X31525(2025-09-12 00:00~2025-09-13 00:00,REQUEST#1)', '2025-09-12 20:44:44', 5);
INSERT INTO `sys_oper_log` VALUES (177, '会议室申请提交', 1, 'com.ruoyi.meeting.controller.ReservationRequestController.submit()', 'POST', 1, 'admin', '行政', '/meeting/request/submit', '127.0.0.1', '内网IP', '{\"endTime\":\"2025-09-15 00:00\",\"remark\":\"\",\"roomIds\":[\"X31525\"],\"startTime\":\"2025-09-14 00:00\"}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":3}', 0, NULL, '2025-09-12 20:45:00', 7);
INSERT INTO `sys_oper_log` VALUES (178, '会议室申请审批', 2, 'com.ruoyi.meeting.controller.ReservationRequestController.approve()', 'POST', 1, 'admin', '行政', '/meeting/request/approve', '127.0.0.1', '内网IP', '{\"decisionRemark\":\"\",\"requestId\":3,\"slots\":[{\"endTime\":\"2025-09-15 00:00\",\"roomId\":\"X31525\",\"startTime\":\"2025-09-14 00:00\"}]}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-13 14:25:16', 47);
INSERT INTO `sys_oper_log` VALUES (179, '会议室预留', 1, 'com.ruoyi.meeting.controller.RoomReservationController.add()', 'POST', 1, 'admin', '行政', '/meeting/reservation', '127.0.0.1', '内网IP', '{\"endTime\":\"2025-09-21 00:00\",\"params\":{},\"roomId\":\"X31524\",\"startTime\":\"2025-09-20 00:00\"}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'admin_id\' cannot be null\r\n### The error may exist in file [D:\\JavaProgram\\RuoYi-Vue-master\\RuoYi-Vue-master\\ruoyi-system\\target\\classes\\mapper\\meeting\\RoomReservationMapper.xml]\r\n### The error may involve com.ruoyi.meeting.mapper.RoomReservationMapper.insertRoomReservation-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into room_reservation(admin_id, room_id, start_time, end_time, create_time)         values(?, ?, ?, ?, now())\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'admin_id\' cannot be null\n; Column \'admin_id\' cannot be null; nested exception is java.sql.SQLIntegrityConstraintViolationException: Column \'admin_id\' cannot be null', '2025-09-13 14:43:11', 89);
INSERT INTO `sys_oper_log` VALUES (180, '会议室预留', 1, 'com.ruoyi.meeting.controller.RoomReservationController.add()', 'POST', 1, 'admin', '行政', '/meeting/reservation', '127.0.0.1', '内网IP', '{\"endTime\":\"2025-09-21 00:00\",\"params\":{},\"roomId\":\"X31525\",\"startTime\":\"2025-09-20 00:00\"}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'admin_id\' cannot be null\r\n### The error may exist in file [D:\\JavaProgram\\RuoYi-Vue-master\\RuoYi-Vue-master\\ruoyi-system\\target\\classes\\mapper\\meeting\\RoomReservationMapper.xml]\r\n### The error may involve com.ruoyi.meeting.mapper.RoomReservationMapper.insertRoomReservation-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into room_reservation(admin_id, room_id, start_time, end_time, create_time)         values(?, ?, ?, ?, now())\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'admin_id\' cannot be null\n; Column \'admin_id\' cannot be null; nested exception is java.sql.SQLIntegrityConstraintViolationException: Column \'admin_id\' cannot be null', '2025-09-13 14:43:11', 89);
INSERT INTO `sys_oper_log` VALUES (181, '会议室预留', 1, 'com.ruoyi.meeting.controller.RoomReservationController.add()', 'POST', 1, 'admin', '行政', '/meeting/reservation', '127.0.0.1', '内网IP', '{\"endTime\":\"2025-09-21 00:00\",\"params\":{},\"roomId\":\"X31524\",\"startTime\":\"2025-09-20 00:00\"}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'admin_id\' cannot be null\r\n### The error may exist in file [D:\\JavaProgram\\RuoYi-Vue-master\\RuoYi-Vue-master\\ruoyi-system\\target\\classes\\mapper\\meeting\\RoomReservationMapper.xml]\r\n### The error may involve com.ruoyi.meeting.mapper.RoomReservationMapper.insertRoomReservation-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into room_reservation(admin_id, room_id, start_time, end_time, create_time)         values(?, ?, ?, ?, now())\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'admin_id\' cannot be null\n; Column \'admin_id\' cannot be null; nested exception is java.sql.SQLIntegrityConstraintViolationException: Column \'admin_id\' cannot be null', '2025-09-13 14:43:23', 3);
INSERT INTO `sys_oper_log` VALUES (182, '会议室预留', 1, 'com.ruoyi.meeting.controller.RoomReservationController.add()', 'POST', 1, 'admin', '行政', '/meeting/reservation', '127.0.0.1', '内网IP', '{\"endTime\":\"2025-09-21 00:00\",\"params\":{},\"roomId\":\"X31525\",\"startTime\":\"2025-09-20 00:00\"}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'admin_id\' cannot be null\r\n### The error may exist in file [D:\\JavaProgram\\RuoYi-Vue-master\\RuoYi-Vue-master\\ruoyi-system\\target\\classes\\mapper\\meeting\\RoomReservationMapper.xml]\r\n### The error may involve com.ruoyi.meeting.mapper.RoomReservationMapper.insertRoomReservation-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into room_reservation(admin_id, room_id, start_time, end_time, create_time)         values(?, ?, ?, ?, now())\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'admin_id\' cannot be null\n; Column \'admin_id\' cannot be null; nested exception is java.sql.SQLIntegrityConstraintViolationException: Column \'admin_id\' cannot be null', '2025-09-13 14:43:23', 3);
INSERT INTO `sys_oper_log` VALUES (183, '会议室预留', 1, 'com.ruoyi.meeting.controller.RoomReservationController.add()', 'POST', 1, 'admin', '行政', '/meeting/reservation', '127.0.0.1', '内网IP', '{\"adminId\":1,\"endTime\":\"2025-09-21 00:00\",\"params\":{},\"reserveId\":2,\"roomId\":\"X31525\",\"startTime\":\"2025-09-20 00:00\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-13 14:47:22', 17);
INSERT INTO `sys_oper_log` VALUES (184, '会议室预留', 1, 'com.ruoyi.meeting.controller.RoomReservationController.add()', 'POST', 1, 'admin', '行政', '/meeting/reservation', '127.0.0.1', '内网IP', '{\"adminId\":1,\"endTime\":\"2025-09-21 00:00\",\"params\":{},\"reserveId\":1,\"roomId\":\"X31524\",\"startTime\":\"2025-09-20 00:00\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-13 14:47:22', 17);
INSERT INTO `sys_oper_log` VALUES (185, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.resetPwd()', 'PUT', 1, 'admin', '行政', '/system/user/resetPwd', '127.0.0.1', '内网IP', '{\"admin\":false,\"params\":{},\"updateBy\":\"admin\",\"userId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-13 14:53:34', 70);
INSERT INTO `sys_oper_log` VALUES (186, '用户管理', 1, 'com.ruoyi.web.controller.system.SysUserController.add()', 'POST', 1, 'ry', '职工', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"ry\",\"nickName\":\"1\",\"params\":{},\"postIds\":[],\"roleIds\":[],\"status\":\"0\",\"userId\":100,\"userName\":\"111\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-13 14:54:37', 76);
INSERT INTO `sys_oper_log` VALUES (187, '用户管理', 3, 'com.ruoyi.web.controller.system.SysUserController.remove()', 'DELETE', 1, 'admin', '行政', '/system/user/100', '127.0.0.1', '内网IP', '[100]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-13 14:55:37', 8);
INSERT INTO `sys_oper_log` VALUES (188, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '行政', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-09-10 15:45:27\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2000,1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114,3,115,116,1055,1056,1057,1058,1059,1060,117,2002,2004],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-13 14:55:50', 19);
INSERT INTO `sys_oper_log` VALUES (189, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '行政', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"meeting/request/index.vue\",\"createTime\":\"2025-09-11 17:29:33\",\"icon\":\"education\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2001,\"menuName\":\"审批管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"approve\",\"perms\":\"meeting:request:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-13 15:19:48', 12);
INSERT INTO `sys_oper_log` VALUES (190, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '行政', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"meeting/request/index.vue\",\"createTime\":\"2025-09-11 17:29:33\",\"icon\":\"education\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2001,\"menuName\":\"审批管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"approve\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-13 15:20:15', 5);
INSERT INTO `sys_oper_log` VALUES (191, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '行政', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"查询会议室申请列表\",\"menuType\":\"F\",\"orderNum\":1,\"params\":{},\"parentId\":2002,\"perms\":\"meeting:request:list\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-13 15:22:26', 5);
INSERT INTO `sys_oper_log` VALUES (192, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '行政', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"获取会议室申请详细信息\",\"menuType\":\"F\",\"orderNum\":2,\"params\":{},\"parentId\":2002,\"perms\":\"meeting:request:query\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-13 15:22:54', 5);
INSERT INTO `sys_oper_log` VALUES (193, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '行政', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"新增会议室申请（基础）\",\"menuType\":\"F\",\"orderNum\":3,\"params\":{},\"parentId\":2002,\"perms\":\"meeting:request:add\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-13 15:23:32', 6);
INSERT INTO `sys_oper_log` VALUES (194, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '行政', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"修改会议室申请（基础）\",\"menuType\":\"F\",\"orderNum\":5,\"params\":{},\"parentId\":2002,\"perms\":\"meeting:request:edit\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-13 15:24:01', 6);
INSERT INTO `sys_oper_log` VALUES (195, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '行政', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"删除会议室申请\",\"menuType\":\"F\",\"orderNum\":6,\"params\":{},\"parentId\":2002,\"path\":\"meeting:request:remove\",\"perms\":\"meeting:request:remove\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-13 15:24:54', 6);
INSERT INTO `sys_oper_log` VALUES (196, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '行政', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"提交会议室申请（支持统一或独立时段）\",\"menuType\":\"F\",\"orderNum\":7,\"params\":{},\"parentId\":2002,\"perms\":\"meeting:request:submit\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-13 15:25:22', 4);
INSERT INTO `sys_oper_log` VALUES (197, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '行政', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"查询会议室申请明细\",\"menuType\":\"F\",\"orderNum\":8,\"params\":{},\"parentId\":2002,\"perms\":\"meeting:request:query\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-13 15:25:55', 5);
INSERT INTO `sys_oper_log` VALUES (198, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '行政', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"冲突检测\",\"menuType\":\"F\",\"orderNum\":9,\"params\":{},\"parentId\":2002,\"perms\":\"meeting:request:conflict\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-13 15:26:21', 3);
INSERT INTO `sys_oper_log` VALUES (199, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '行政', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"meeting/detail/index.vue\",\"createTime\":\"2025-09-11 17:30:20\",\"icon\":\"button\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2002,\"menuName\":\"申请管理\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2000,\"path\":\"applicant\",\"perms\":\"meeting:request:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-13 15:26:58', 4);
INSERT INTO `sys_oper_log` VALUES (200, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '行政', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"meeting/room/index.vue\",\"createTime\":\"2025-09-12 15:55:44\",\"icon\":\"documentation\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2004,\"menuName\":\"会议室\",\"menuType\":\"C\",\"orderNum\":4,\"params\":{},\"parentId\":2000,\"path\":\"room\",\"perms\":\"meeting:room:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-13 15:28:10', 5);
INSERT INTO `sys_oper_log` VALUES (201, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '行政', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"查询会议室列表\",\"menuType\":\"F\",\"orderNum\":1,\"params\":{},\"parentId\":2004,\"perms\":\"meeting:room:list\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-13 15:28:36', 4);
INSERT INTO `sys_oper_log` VALUES (202, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '行政', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"获取会议室详细信息\",\"menuType\":\"F\",\"orderNum\":2,\"params\":{},\"parentId\":2004,\"perms\":\"meeting:room:query\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-13 15:29:04', 4);
INSERT INTO `sys_oper_log` VALUES (203, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '行政', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"查询空闲会议室\",\"menuType\":\"F\",\"orderNum\":3,\"params\":{},\"parentId\":2004,\"perms\":\"meeting:room:free\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-13 15:29:32', 5);
INSERT INTO `sys_oper_log` VALUES (204, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '行政', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-09-10 15:45:27\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2000,2002,1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114,3,115,116,1055,1056,1057,1058,1059,1060,117,2005,2006,2007,2008,2009,2010,2011,2004,2013,2014,2015],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-13 15:30:16', 13);
INSERT INTO `sys_oper_log` VALUES (205, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'ry', '职工', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-09-13 15:22:26\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2005,\"menuName\":\"查询会议室申请列表\",\"menuType\":\"F\",\"orderNum\":1,\"params\":{},\"parentId\":2002,\"path\":\"\",\"perms\":\"meeting:detail:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"ry\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-13 15:32:39', 4);
INSERT INTO `sys_oper_log` VALUES (206, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '行政', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-09-10 15:45:27\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,100,2000,2002,1000,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114,3,115,116,1055,1056,1057,1058,1059,1060,117,2005,2006,2007,2008,2009,2010,2011,2004,2013,2014,2015],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-13 15:45:14', 11);
INSERT INTO `sys_oper_log` VALUES (207, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '行政', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-09-10 15:45:27\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2000,2002,1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114,3,115,116,1055,1056,1057,1058,1059,1060,117,2005,2006,2007,2008,2009,2010,2011,2004,2013,2014,2015],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-13 15:45:33', 12);
INSERT INTO `sys_oper_log` VALUES (208, '会议室申请提交', 1, 'com.ruoyi.meeting.controller.ReservationRequestController.submit()', 'POST', 1, 'ry', '职工', '/meeting/request/submit', '127.0.0.1', '内网IP', '{\"endTime\":\"2025-09-16 00:00\",\"remark\":\"\",\"roomIds\":[\"X31524\"],\"startTime\":\"2025-09-15 00:00\"}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":4}', 0, NULL, '2025-09-13 16:31:45', 125);
INSERT INTO `sys_oper_log` VALUES (209, '会议室申请审批', 2, 'com.ruoyi.meeting.controller.ReservationRequestController.approve()', 'POST', 1, 'admin', '行政', '/meeting/request/approve', '127.0.0.1', '内网IP', '{\"decisionRemark\":\"\",\"endTime\":\"2025-09-16 00:00\",\"requestId\":4,\"roomIds\":[\"X31524\"],\"startTime\":\"2025-09-15 00:00\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-13 16:32:27', 16);
INSERT INTO `sys_oper_log` VALUES (210, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '行政', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-09-10 15:45:27\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2000,1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114,3,115,116,1055,1056,1057,1058,1059,1060,117,2002,2005,2006,2007,2008,2009,2010,2011,2012,2004,2013,2014,2015],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-20 15:43:25', 40);
INSERT INTO `sys_oper_log` VALUES (211, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'ry', '职工', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"ry\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"查询空闲时段\",\"menuType\":\"F\",\"orderNum\":1,\"params\":{},\"parentId\":2015,\"perms\":\" meeting:reservation:list\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-20 15:58:53', 15);
INSERT INTO `sys_oper_log` VALUES (212, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '行政', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"预约查询\",\"menuType\":\"F\",\"orderNum\":1,\"params\":{},\"parentId\":2003,\"perms\":\"meeting:reservation:list\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-20 16:00:59', 4);
INSERT INTO `sys_oper_log` VALUES (213, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '行政', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-09-10 15:45:27\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2000,1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114,3,115,116,1055,1056,1057,1058,1059,1060,117,2002,2005,2006,2007,2008,2009,2010,2011,2012,2003,2017,2004,2013,2014,2015],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-20 16:01:53', 14);
INSERT INTO `sys_oper_log` VALUES (214, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '行政', '/system/menu/2017', '127.0.0.1', '内网IP', '2017', '{\"msg\":\"菜单已分配,不允许删除\",\"code\":601}', 0, NULL, '2025-09-20 16:24:47', 8);
INSERT INTO `sys_oper_log` VALUES (215, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '行政', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-09-10 15:45:27\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2000,1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114,3,115,116,1055,1056,1057,1058,1059,1060,117,2002,2005,2006,2007,2008,2009,2010,2011,2012,2004,2013,2014,2015],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-20 16:24:56', 12);
INSERT INTO `sys_oper_log` VALUES (216, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '行政', '/system/menu/2017', '127.0.0.1', '内网IP', '2017', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-20 16:25:02', 5);
INSERT INTO `sys_oper_log` VALUES (217, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '行政', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"占用时段查询\",\"menuType\":\"F\",\"orderNum\":4,\"params\":{},\"parentId\":2004,\"perms\":\"meeting:reservation:list\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-20 16:25:36', 5);
INSERT INTO `sys_oper_log` VALUES (218, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '行政', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-09-10 15:45:27\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2000,1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114,3,115,116,1055,1056,1057,1058,1059,1060,117,2002,2005,2006,2007,2008,2009,2010,2011,2012,2004,2013,2014,2015,2018],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-20 16:25:50', 11);
INSERT INTO `sys_oper_log` VALUES (219, '会议室申请提交', 1, 'com.ruoyi.meeting.controller.ReservationRequestController.submit()', 'POST', 1, 'ry', '职工', '/meeting/request/submit', '127.0.0.1', '内网IP', '{\"endTime\":\"2025-09-26 00:00\",\"remark\":\"十大发射点\",\"roomIds\":[\"X31524\"],\"startTime\":\"2025-09-25 00:00\"}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":5}', 0, NULL, '2025-09-20 16:34:14', 114);
INSERT INTO `sys_oper_log` VALUES (220, '会议室申请审批', 2, 'com.ruoyi.meeting.controller.ReservationRequestController.approve()', 'POST', 1, 'admin', '行政', '/meeting/request/approve', '127.0.0.1', '内网IP', '{\"decisionRemark\":\"\",\"endTime\":\"2025-09-26 00:00\",\"requestId\":5,\"roomIds\":[\"X31524\"],\"startTime\":\"2025-09-25 00:00\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-20 16:36:14', 22);
INSERT INTO `sys_oper_log` VALUES (221, '会议室申请提交', 1, 'com.ruoyi.meeting.controller.ReservationRequestController.submit()', 'POST', 1, 'ry', '职工', '/meeting/request/submit', '127.0.0.1', '内网IP', '{\"endTime\":\"2025-09-24 00:00\",\"remark\":\"hyjdgjasdg\",\"roomIds\":[\"X31524\"],\"startTime\":\"2025-09-23 00:00\"}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":6}', 0, NULL, '2025-09-23 15:52:57', 44);
INSERT INTO `sys_oper_log` VALUES (222, '会议室申请审批', 2, 'com.ruoyi.meeting.controller.ReservationRequestController.approve()', 'POST', 1, 'admin', '行政', '/meeting/request/approve', '127.0.0.1', '内网IP', '{\"decisionRemark\":\"sfsd\",\"endTime\":\"2025-09-28 00:00\",\"requestId\":6,\"roomIds\":[\"X31524\"],\"startTime\":\"2025-09-27 00:00\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-27 14:11:10', 39);
INSERT INTO `sys_oper_log` VALUES (223, '会议室申请提交', 1, 'com.ruoyi.meeting.controller.ReservationRequestController.submit()', 'POST', 1, 'admin', '行政', '/meeting/request/submit', '127.0.0.1', '内网IP', '{\"endTime\":\"2025-09-30 00:00\",\"remark\":\"weq\",\"roomIds\":[\"X31524\"],\"startTime\":\"2025-09-29 00:00\"}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":7}', 0, NULL, '2025-09-27 14:32:35', 14);
INSERT INTO `sys_oper_log` VALUES (224, '会议室申请审批', 2, 'com.ruoyi.meeting.controller.ReservationRequestController.approve()', 'POST', 1, 'admin', '行政', '/meeting/request/approve', '127.0.0.1', '内网IP', '{\"decisionRemark\":\"sad\",\"endTime\":\"2025-09-30 00:00\",\"requestId\":7,\"roomIds\":[\"X31524\"],\"startTime\":\"2025-09-29 00:00\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-27 14:32:53', 13);
INSERT INTO `sys_oper_log` VALUES (225, '会议室申请提交', 1, 'com.ruoyi.meeting.controller.ReservationRequestController.submit()', 'POST', 1, 'admin', '行政', '/meeting/request/submit', '127.0.0.1', '内网IP', '{\"endTime\":\"2025-10-20 00:00\",\"remark\":\"4ew\",\"roomIds\":[\"X31524\"],\"startTime\":\"2025-10-19 00:00\"}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":8}', 0, NULL, '2025-09-27 15:24:22', 7);
INSERT INTO `sys_oper_log` VALUES (226, '会议室申请明细', 2, 'com.ruoyi.meeting.controller.ReservationRequestDetailController.edit()', 'PUT', 1, 'admin', '行政', '/meeting/detail', '127.0.0.1', '内网IP', '{\"detailId\":15,\"endTime\":\"2025-10-20 00:00\",\"params\":{},\"requestId\":8,\"roomId\":\"X31524\",\"startTime\":\"2025-10-19 00:00\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-27 16:33:50', 15);
INSERT INTO `sys_oper_log` VALUES (227, '会议室申请明细', 2, 'com.ruoyi.meeting.controller.ReservationRequestDetailController.edit()', 'PUT', 1, 'admin', '行政', '/meeting/detail', '127.0.0.1', '内网IP', '{\"detailId\":14,\"endTime\":\"2025-09-30 00:00\",\"params\":{},\"requestId\":7,\"roomId\":\"X31524\",\"startTime\":\"2025-09-29 00:00\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-27 16:33:54', 1);
INSERT INTO `sys_oper_log` VALUES (228, '会议室申请明细', 2, 'com.ruoyi.meeting.controller.ReservationRequestDetailController.edit()', 'PUT', 1, 'admin', '行政', '/meeting/detail', '127.0.0.1', '内网IP', '{\"detailId\":14,\"endTime\":\"2025-09-30 00:00\",\"params\":{},\"requestId\":9999,\"roomId\":\"X31524\",\"startTime\":\"2025-09-29 00:00\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-27 16:34:08', 2);
INSERT INTO `sys_oper_log` VALUES (229, '会议室申请明细', 2, 'com.ruoyi.meeting.controller.ReservationRequestDetailController.edit()', 'PUT', 1, 'admin', '行政', '/meeting/detail', '127.0.0.1', '内网IP', '{\"detailId\":14,\"endTime\":\"2025-09-30 00:00\",\"params\":{},\"requestId\":9999,\"roomId\":\"X31524\",\"startTime\":\"2025-09-29 00:00\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-27 16:34:21', 2);
INSERT INTO `sys_oper_log` VALUES (230, '会议室申请提交', 1, 'com.ruoyi.meeting.controller.ReservationRequestController.submit()', 'POST', 1, 'admin', '行政', '/meeting/request/submit', '127.0.0.1', '内网IP', '{\"endTime\":\"2025-10-20 00:00\",\"remark\":\"\",\"roomIds\":[\"X31524\"],\"startTime\":\"2025-10-19 00:00\"}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":9}', 0, NULL, '2025-09-27 16:50:13', 8);
INSERT INTO `sys_oper_log` VALUES (231, '会议室申请提交', 1, 'com.ruoyi.meeting.controller.ReservationRequestController.submit()', 'POST', 1, 'admin', '行政', '/meeting/request/submit', '127.0.0.1', '内网IP', '{\"endTime\":\"2025-10-07 00:00\",\"remark\":\"\",\"roomIds\":[\"X31524\"],\"startTime\":\"2025-10-06 00:00\"}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":10}', 0, NULL, '2025-09-27 16:57:52', 9);
INSERT INTO `sys_oper_log` VALUES (232, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '行政', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-09-10 15:45:27\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2000,1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114,3,115,116,1055,1056,1057,1058,1059,1060,117,2002,2005,2006,2007,2008,2009,2010,2011,2012],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-27 17:47:51', 22);
INSERT INTO `sys_oper_log` VALUES (233, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '行政', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-09-10 15:45:27\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2000,1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114,3,115,116,1055,1056,1057,1058,1059,1060,117,2002,2005,2006,2007,2008,2009,2010,2011,2012,2004,2013,2014,2015,2016,2018],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-27 17:49:40', 11);
INSERT INTO `sys_oper_log` VALUES (234, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '行政', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-09-13 15:28:36\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2013,\"menuName\":\"查询会议室列表\",\"menuType\":\"F\",\"orderNum\":1,\"params\":{},\"parentId\":2002,\"path\":\"\",\"perms\":\"meeting:room:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-27 17:50:26', 12);
INSERT INTO `sys_oper_log` VALUES (235, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '行政', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-09-13 15:29:04\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2014,\"menuName\":\"获取会议室详细信息\",\"menuType\":\"F\",\"orderNum\":2,\"params\":{},\"parentId\":2002,\"path\":\"\",\"perms\":\"meeting:room:query\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-27 17:50:32', 5);
INSERT INTO `sys_oper_log` VALUES (236, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '行政', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-09-13 15:29:32\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2015,\"menuName\":\"查询空闲会议室\",\"menuType\":\"F\",\"orderNum\":3,\"params\":{},\"parentId\":2002,\"path\":\"\",\"perms\":\"meeting:room:free\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-27 17:51:07', 4);
INSERT INTO `sys_oper_log` VALUES (237, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '行政', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-09-20 16:25:36\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2018,\"menuName\":\"占用时段查询\",\"menuType\":\"F\",\"orderNum\":4,\"params\":{},\"parentId\":2002,\"path\":\"\",\"perms\":\"meeting:reservation:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-27 17:51:14', 4);
INSERT INTO `sys_oper_log` VALUES (238, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '行政', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-09-10 15:45:27\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114,3,115,116,1055,1056,1057,1058,1059,1060,117],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-27 17:51:32', 11);
INSERT INTO `sys_oper_log` VALUES (239, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '行政', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-09-10 15:45:27\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2000,1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114,3,115,116,1055,1056,1057,1058,1059,1060,117,2002,2005,2013,2006,2014,2007,2015,2016,2018,2008,2009,2010,2011,2012],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-27 17:51:40', 12);
INSERT INTO `sys_oper_log` VALUES (240, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '行政', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-09-10 15:45:27\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2000,1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114,3,115,116,1055,1056,1057,1058,1059,1060,117,2002,2005,2013,2006,2014,2007,2015,2016,2018,2008,2009,2010,2011,2012],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-27 17:53:36', 11);
INSERT INTO `sys_oper_log` VALUES (241, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '行政', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"meeting/reservation/index.vue\",\"createTime\":\"2025-09-11 17:35:07\",\"icon\":\"checkbox\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2003,\"menuName\":\"预留\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2000,\"path\":\"reserve\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"1\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-27 18:18:56', 5);
INSERT INTO `sys_oper_log` VALUES (242, '会议室申请提交', 1, 'com.ruoyi.meeting.controller.ReservationRequestController.submit()', 'POST', 1, 'ry', '职工', '/meeting/request/submit', '127.0.0.1', '内网IP', '{\"endTime\":\"2025-10-15 01:10\",\"remark\":\"\",\"roomIds\":[\"X31525\"],\"startTime\":\"2025-10-14 04:25\"}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":11}', 0, NULL, '2025-09-27 18:19:51', 8);
INSERT INTO `sys_oper_log` VALUES (243, '会议室申请提交', 1, 'com.ruoyi.meeting.controller.ReservationRequestController.submit()', 'POST', 1, 'ry', '职工', '/meeting/request/submit', '127.0.0.1', '内网IP', '{\"endTime\":\"2025-10-24 01:00\",\"remark\":\"\",\"roomIds\":[\"X31526\"],\"startTime\":\"2025-10-22 00:10\"}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":12}', 0, NULL, '2025-09-27 18:26:57', 26);
INSERT INTO `sys_oper_log` VALUES (244, '会议室申请审批', 2, 'com.ruoyi.meeting.controller.ReservationRequestController.approve()', 'POST', 1, 'admin', '行政', '/meeting/request/approve', '127.0.0.1', '内网IP', '{\"decisionRemark\":\"\",\"endTime\":\"2025-10-24 01:00\",\"requestId\":12,\"roomIds\":[\"X31526\"],\"startTime\":\"2025-10-22 00:10\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-27 18:27:24', 20);
INSERT INTO `sys_oper_log` VALUES (245, '会议室申请提交', 1, 'com.ruoyi.meeting.controller.ReservationRequestController.submit()', 'POST', 1, 'ry', '职工', '/meeting/request/submit', '127.0.0.1', '内网IP', '{\"endTime\":\"2025-09-28 17:25\",\"remark\":\"\",\"roomIds\":[\"X31524\"],\"startTime\":\"2025-09-28 16:25\"}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":13}', 0, NULL, '2025-09-28 16:20:08', 44);
INSERT INTO `sys_oper_log` VALUES (246, '会议室申请审批', 2, 'com.ruoyi.meeting.controller.ReservationRequestController.approve()', 'POST', 1, 'admin', '行政', '/meeting/request/approve', '127.0.0.1', '内网IP', '{\"decisionRemark\":\"\",\"endTime\":\"2025-09-28 17:25\",\"requestId\":13,\"roomIds\":[\"X31524\"],\"startTime\":\"2025-09-28 16:25\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-28 16:22:04', 36);
INSERT INTO `sys_oper_log` VALUES (247, '会议室申请提交', 1, 'com.ruoyi.meeting.controller.ReservationRequestController.submit()', 'POST', 1, 'admin', '行政', '/meeting/request/submit', '127.0.0.1', '内网IP', '{\"endTime\":\"2025-10-07 02:00\",\"remark\":\"\",\"roomIds\":[\"X31524\"],\"startTime\":\"2025-10-06 02:00\"}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":14}', 0, NULL, '2025-10-05 16:26:48', 36);
INSERT INTO `sys_oper_log` VALUES (248, '会议室申请提交', 1, 'com.ruoyi.meeting.controller.ReservationRequestController.submit()', 'POST', 1, 'admin', '行政', '/meeting/request/submit', '127.0.0.1', '内网IP', '{\"endTime\":\"2025-10-06 04:10\",\"remark\":\"\",\"roomIds\":[\"X31525\"],\"startTime\":\"2025-10-06 00:00\"}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":15}', 0, NULL, '2025-10-05 16:27:18', 13);
INSERT INTO `sys_oper_log` VALUES (249, '会议室申请提交', 1, 'com.ruoyi.meeting.controller.ReservationRequestController.submit()', 'POST', 1, 'admin', '行政', '/meeting/request/submit', '127.0.0.1', '内网IP', '{\"endTime\":\"2025-10-06 12:00\",\"remark\":\"\",\"roomIds\":[\"X31541\"],\"startTime\":\"2025-10-06 05:10\"}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":16}', 0, NULL, '2025-10-05 16:27:40', 14);
INSERT INTO `sys_oper_log` VALUES (250, '会议室申请审批', 2, 'com.ruoyi.meeting.controller.ReservationRequestController.approve()', 'POST', 1, 'admin', '行政', '/meeting/request/approve', '127.0.0.1', '内网IP', '{\"decisionRemark\":\"\",\"endTime\":\"2025-10-06 12:00\",\"requestId\":16,\"roomIds\":[\"X31541\"],\"startTime\":\"2025-10-06 05:10\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-05 16:27:48', 26);
INSERT INTO `sys_oper_log` VALUES (251, '会议室申请审批', 2, 'com.ruoyi.meeting.controller.ReservationRequestController.approve()', 'POST', 1, 'admin', '行政', '/meeting/request/approve', '127.0.0.1', '内网IP', '{\"decisionRemark\":\"\",\"endTime\":\"2025-10-06 04:10\",\"requestId\":15,\"roomIds\":[\"X31525\"],\"startTime\":\"2025-10-06 00:00\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-05 16:27:51', 21);
INSERT INTO `sys_oper_log` VALUES (252, '会议室申请审批', 2, 'com.ruoyi.meeting.controller.ReservationRequestController.approve()', 'POST', 1, 'admin', '行政', '/meeting/request/approve', '127.0.0.1', '内网IP', '{\"decisionRemark\":\"\",\"endTime\":\"2025-10-07 02:00\",\"requestId\":14,\"roomIds\":[\"X31524\"],\"startTime\":\"2025-10-06 02:00\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-05 16:27:53', 31);
INSERT INTO `sys_oper_log` VALUES (253, '会议室申请审批', 2, 'com.ruoyi.meeting.controller.ReservationRequestController.approve()', 'POST', 1, 'admin', '行政', '/meeting/request/approve', '127.0.0.1', '内网IP', '{\"decisionRemark\":\"\",\"endTime\":\"2025-10-15 01:10\",\"requestId\":11,\"roomIds\":[\"X31525\"],\"startTime\":\"2025-10-14 04:25\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-05 16:27:59', 21);
INSERT INTO `sys_oper_log` VALUES (254, '会议室申请审批', 2, 'com.ruoyi.meeting.controller.ReservationRequestController.approve()', 'POST', 1, 'admin', '行政', '/meeting/request/approve', '127.0.0.1', '内网IP', '{\"decisionRemark\":\"\",\"endTime\":\"2025-10-07 00:00\",\"requestId\":10,\"roomIds\":[\"X31524\"],\"startTime\":\"2025-10-06 00:00\"}', NULL, 1, '存在冲突(共1条)：X31524(2025-10-06 02:00~2025-10-07 02:00,REQUEST#14)', '2025-10-05 16:28:02', 12);
INSERT INTO `sys_oper_log` VALUES (255, '会议室申请拒绝', 2, 'com.ruoyi.meeting.controller.ReservationRequestController.reject()', 'POST', 1, 'admin', '行政', '/meeting/request/reject', '127.0.0.1', '内网IP', '{\"decisionRemark\":\"\",\"requestId\":10}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-05 16:28:09', 8);
INSERT INTO `sys_oper_log` VALUES (256, '会议室申请审批', 2, 'com.ruoyi.meeting.controller.ReservationRequestController.approve()', 'POST', 1, 'admin', '行政', '/meeting/request/approve', '127.0.0.1', '内网IP', '{\"decisionRemark\":\"\",\"endTime\":\"2025-10-20 00:00\",\"requestId\":9,\"roomIds\":[\"X31524\"],\"startTime\":\"2025-10-19 00:00\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-05 16:28:15', 20);
INSERT INTO `sys_oper_log` VALUES (257, '会议室申请审批', 2, 'com.ruoyi.meeting.controller.ReservationRequestController.approve()', 'POST', 1, 'admin', '行政', '/meeting/request/approve', '127.0.0.1', '内网IP', '{\"decisionRemark\":\"\",\"endTime\":\"2025-10-20 00:00\",\"requestId\":8,\"roomIds\":[\"X31524\"],\"startTime\":\"2025-10-19 00:00\"}', NULL, 1, '存在冲突(共1条)：X31524(2025-10-19 00:00~2025-10-20 00:00,REQUEST#9)', '2025-10-05 16:28:17', 9);
INSERT INTO `sys_oper_log` VALUES (258, '会议室申请审批', 2, 'com.ruoyi.meeting.controller.ReservationRequestController.approve()', 'POST', 1, 'admin', '行政', '/meeting/request/approve', '127.0.0.1', '内网IP', '{\"decisionRemark\":\"\",\"endTime\":\"2025-10-20 00:00\",\"requestId\":8,\"roomIds\":[\"X31524\"],\"startTime\":\"2025-10-19 00:00\"}', NULL, 1, '存在冲突(共1条)：X31524(2025-10-19 00:00~2025-10-20 00:00,REQUEST#9)', '2025-10-05 16:28:20', 10);
INSERT INTO `sys_oper_log` VALUES (259, '会议室申请审批', 2, 'com.ruoyi.meeting.controller.ReservationRequestController.approve()', 'POST', 1, 'admin', '行政', '/meeting/request/approve', '127.0.0.1', '内网IP', '{\"decisionRemark\":\"\",\"endTime\":\"2025-10-20 00:00\",\"requestId\":8,\"roomIds\":[\"X31524\"],\"startTime\":\"2025-10-19 00:00\"}', NULL, 1, '存在冲突(共1条)：X31524(2025-10-19 00:00~2025-10-20 00:00,REQUEST#9)', '2025-10-05 16:28:22', 9);
INSERT INTO `sys_oper_log` VALUES (260, '会议室申请拒绝', 2, 'com.ruoyi.meeting.controller.ReservationRequestController.reject()', 'POST', 1, 'admin', '行政', '/meeting/request/reject', '127.0.0.1', '内网IP', '{\"decisionRemark\":\"\",\"requestId\":8}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-05 16:28:28', 8);

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post`  (
  `post_id` bigint NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '岗位名称',
  `post_sort` int NOT NULL COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '岗位信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES (1, 'ceo', '董事长', 1, '0', 'admin', '2025-09-10 15:45:27', '', NULL, '');
INSERT INTO `sys_post` VALUES (2, 'se', '项目经理', 2, '0', 'admin', '2025-09-10 15:45:27', '', NULL, '');
INSERT INTO `sys_post` VALUES (3, 'hr', '人力资源', 3, '0', 'admin', '2025-09-10 15:45:27', '', NULL, '');
INSERT INTO `sys_post` VALUES (4, 'user', '普通员工', 4, '0', 'admin', '2025-09-10 15:45:27', '', NULL, '');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '部门树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2025-09-10 15:45:27', '', NULL, '超级管理员');
INSERT INTO `sys_role` VALUES (2, '普通角色', 'common', 2, '2', 1, 1, '0', '0', 'admin', '2025-09-10 15:45:27', 'admin', '2025-09-27 17:53:36', '普通角色');

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `dept_id` bigint NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`, `dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色和部门关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
INSERT INTO `sys_role_dept` VALUES (2, 100);
INSERT INTO `sys_role_dept` VALUES (2, 101);
INSERT INTO `sys_role_dept` VALUES (2, 105);

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (2, 1);
INSERT INTO `sys_role_menu` VALUES (2, 2);
INSERT INTO `sys_role_menu` VALUES (2, 3);
INSERT INTO `sys_role_menu` VALUES (2, 100);
INSERT INTO `sys_role_menu` VALUES (2, 101);
INSERT INTO `sys_role_menu` VALUES (2, 102);
INSERT INTO `sys_role_menu` VALUES (2, 103);
INSERT INTO `sys_role_menu` VALUES (2, 104);
INSERT INTO `sys_role_menu` VALUES (2, 105);
INSERT INTO `sys_role_menu` VALUES (2, 106);
INSERT INTO `sys_role_menu` VALUES (2, 107);
INSERT INTO `sys_role_menu` VALUES (2, 108);
INSERT INTO `sys_role_menu` VALUES (2, 109);
INSERT INTO `sys_role_menu` VALUES (2, 110);
INSERT INTO `sys_role_menu` VALUES (2, 111);
INSERT INTO `sys_role_menu` VALUES (2, 112);
INSERT INTO `sys_role_menu` VALUES (2, 113);
INSERT INTO `sys_role_menu` VALUES (2, 114);
INSERT INTO `sys_role_menu` VALUES (2, 115);
INSERT INTO `sys_role_menu` VALUES (2, 116);
INSERT INTO `sys_role_menu` VALUES (2, 117);
INSERT INTO `sys_role_menu` VALUES (2, 500);
INSERT INTO `sys_role_menu` VALUES (2, 501);
INSERT INTO `sys_role_menu` VALUES (2, 1000);
INSERT INTO `sys_role_menu` VALUES (2, 1001);
INSERT INTO `sys_role_menu` VALUES (2, 1002);
INSERT INTO `sys_role_menu` VALUES (2, 1003);
INSERT INTO `sys_role_menu` VALUES (2, 1004);
INSERT INTO `sys_role_menu` VALUES (2, 1005);
INSERT INTO `sys_role_menu` VALUES (2, 1006);
INSERT INTO `sys_role_menu` VALUES (2, 1007);
INSERT INTO `sys_role_menu` VALUES (2, 1008);
INSERT INTO `sys_role_menu` VALUES (2, 1009);
INSERT INTO `sys_role_menu` VALUES (2, 1010);
INSERT INTO `sys_role_menu` VALUES (2, 1011);
INSERT INTO `sys_role_menu` VALUES (2, 1012);
INSERT INTO `sys_role_menu` VALUES (2, 1013);
INSERT INTO `sys_role_menu` VALUES (2, 1014);
INSERT INTO `sys_role_menu` VALUES (2, 1015);
INSERT INTO `sys_role_menu` VALUES (2, 1016);
INSERT INTO `sys_role_menu` VALUES (2, 1017);
INSERT INTO `sys_role_menu` VALUES (2, 1018);
INSERT INTO `sys_role_menu` VALUES (2, 1019);
INSERT INTO `sys_role_menu` VALUES (2, 1020);
INSERT INTO `sys_role_menu` VALUES (2, 1021);
INSERT INTO `sys_role_menu` VALUES (2, 1022);
INSERT INTO `sys_role_menu` VALUES (2, 1023);
INSERT INTO `sys_role_menu` VALUES (2, 1024);
INSERT INTO `sys_role_menu` VALUES (2, 1025);
INSERT INTO `sys_role_menu` VALUES (2, 1026);
INSERT INTO `sys_role_menu` VALUES (2, 1027);
INSERT INTO `sys_role_menu` VALUES (2, 1028);
INSERT INTO `sys_role_menu` VALUES (2, 1029);
INSERT INTO `sys_role_menu` VALUES (2, 1030);
INSERT INTO `sys_role_menu` VALUES (2, 1031);
INSERT INTO `sys_role_menu` VALUES (2, 1032);
INSERT INTO `sys_role_menu` VALUES (2, 1033);
INSERT INTO `sys_role_menu` VALUES (2, 1034);
INSERT INTO `sys_role_menu` VALUES (2, 1035);
INSERT INTO `sys_role_menu` VALUES (2, 1036);
INSERT INTO `sys_role_menu` VALUES (2, 1037);
INSERT INTO `sys_role_menu` VALUES (2, 1038);
INSERT INTO `sys_role_menu` VALUES (2, 1039);
INSERT INTO `sys_role_menu` VALUES (2, 1040);
INSERT INTO `sys_role_menu` VALUES (2, 1041);
INSERT INTO `sys_role_menu` VALUES (2, 1042);
INSERT INTO `sys_role_menu` VALUES (2, 1043);
INSERT INTO `sys_role_menu` VALUES (2, 1044);
INSERT INTO `sys_role_menu` VALUES (2, 1045);
INSERT INTO `sys_role_menu` VALUES (2, 1046);
INSERT INTO `sys_role_menu` VALUES (2, 1047);
INSERT INTO `sys_role_menu` VALUES (2, 1048);
INSERT INTO `sys_role_menu` VALUES (2, 1049);
INSERT INTO `sys_role_menu` VALUES (2, 1050);
INSERT INTO `sys_role_menu` VALUES (2, 1051);
INSERT INTO `sys_role_menu` VALUES (2, 1052);
INSERT INTO `sys_role_menu` VALUES (2, 1053);
INSERT INTO `sys_role_menu` VALUES (2, 1054);
INSERT INTO `sys_role_menu` VALUES (2, 1055);
INSERT INTO `sys_role_menu` VALUES (2, 1056);
INSERT INTO `sys_role_menu` VALUES (2, 1057);
INSERT INTO `sys_role_menu` VALUES (2, 1058);
INSERT INTO `sys_role_menu` VALUES (2, 1059);
INSERT INTO `sys_role_menu` VALUES (2, 1060);
INSERT INTO `sys_role_menu` VALUES (2, 2000);
INSERT INTO `sys_role_menu` VALUES (2, 2002);
INSERT INTO `sys_role_menu` VALUES (2, 2005);
INSERT INTO `sys_role_menu` VALUES (2, 2006);
INSERT INTO `sys_role_menu` VALUES (2, 2007);
INSERT INTO `sys_role_menu` VALUES (2, 2008);
INSERT INTO `sys_role_menu` VALUES (2, 2009);
INSERT INTO `sys_role_menu` VALUES (2, 2010);
INSERT INTO `sys_role_menu` VALUES (2, 2011);
INSERT INTO `sys_role_menu` VALUES (2, 2012);
INSERT INTO `sys_role_menu` VALUES (2, 2013);
INSERT INTO `sys_role_menu` VALUES (2, 2014);
INSERT INTO `sys_role_menu` VALUES (2, 2015);
INSERT INTO `sys_role_menu` VALUES (2, 2016);
INSERT INTO `sys_role_menu` VALUES (2, 2018);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint NULL DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '账号状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
  `pwd_update_date` datetime NULL DEFAULT NULL COMMENT '密码最后更新时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 101 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 103, 'admin', '若依', '00', 'ry@163.com', '15888888888', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2025-10-05 21:48:19', '2025-09-10 15:45:27', 'admin', '2025-09-10 15:45:27', '', NULL, '管理员');
INSERT INTO `sys_user` VALUES (2, 105, 'ry', '测试用户', '00', 'ry@qq.com', '15666666666', '1', '', '$2a$10$eCXjRzdtoywhcHLNDjT4aOYpOpxn42ZZC3CE4hGiB7v6vo3xcE/O2', '0', '0', '127.0.0.1', '2025-09-28 16:19:26', '2025-09-13 14:53:34', 'admin', '2025-09-10 15:45:27', '', '2025-09-13 14:53:34', '测试员');
INSERT INTO `sys_user` VALUES (100, NULL, '111', '1', '00', '', '', '0', '', '$2a$10$k03uFnl2CPnmKVd6lgRzXuq2j6FvGbbSmmgAIIOmihwUfSS6R2buO', '0', '2', '', NULL, NULL, 'ry', '2025-09-13 14:54:37', '', NULL, NULL);

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `post_id` bigint NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`, `post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户与岗位关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO `sys_user_post` VALUES (1, 1);
INSERT INTO `sys_user_post` VALUES (2, 2);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户和角色关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);
INSERT INTO `sys_user_role` VALUES (2, 2);

SET FOREIGN_KEY_CHECKS = 1;
