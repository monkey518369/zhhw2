/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50155
Source Host           : localhost:3306
Source Database       : zhhw

Target Server Type    : MYSQL
Target Server Version : 50155
File Encoding         : 65001

Date: 2015-08-27 14:52:21
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `qrtz_blob_triggers`
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers` (
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `BLOB_DATA` blob,
  PRIMARY KEY (`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `TRIGGER_NAME` (`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_blob_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for `qrtz_calendars`
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars` (
  `CALENDAR_NAME` varchar(200) NOT NULL,
  `CALENDAR` blob NOT NULL,
  PRIMARY KEY (`CALENDAR_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_calendars
-- ----------------------------

-- ----------------------------
-- Table structure for `qrtz_cron_triggers`
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers` (
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `CRON_EXPRESSION` varchar(120) NOT NULL,
  `TIME_ZONE_ID` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `TRIGGER_NAME` (`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_cron_triggers
-- ----------------------------
INSERT INTO `qrtz_cron_triggers` VALUES ('trigger1', 'GROUP1', '0/15 * * ? * *', 'Asia/Shanghai');
INSERT INTO `qrtz_cron_triggers` VALUES ('trigger2', 'GROUP2', '0/3 * *  ? * *', 'Asia/Shanghai');

-- ----------------------------
-- Table structure for `qrtz_fired_triggers`
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers` (
  `ENTRY_ID` varchar(95) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `IS_VOLATILE` varchar(1) NOT NULL,
  `INSTANCE_NAME` varchar(200) NOT NULL,
  `FIRED_TIME` bigint(13) NOT NULL,
  `PRIORITY` int(11) NOT NULL,
  `STATE` varchar(16) NOT NULL,
  `JOB_NAME` varchar(200) DEFAULT NULL,
  `JOB_GROUP` varchar(200) DEFAULT NULL,
  `IS_STATEFUL` varchar(1) DEFAULT NULL,
  `REQUESTS_RECOVERY` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`ENTRY_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_fired_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for `qrtz_job_details`
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details` (
  `JOB_NAME` varchar(200) NOT NULL,
  `JOB_GROUP` varchar(200) NOT NULL,
  `DESCRIPTION` varchar(250) DEFAULT NULL,
  `JOB_CLASS_NAME` varchar(250) NOT NULL,
  `IS_DURABLE` varchar(1) NOT NULL,
  `IS_VOLATILE` varchar(1) NOT NULL,
  `IS_STATEFUL` varchar(1) NOT NULL,
  `REQUESTS_RECOVERY` varchar(1) NOT NULL,
  `JOB_DATA` blob,
  PRIMARY KEY (`JOB_NAME`,`JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_job_details
-- ----------------------------
INSERT INTO `qrtz_job_details` VALUES ('statefuljob', 'GROUP1', null, 'com.gph.saviorframework.quartz.StatefulJob', '0', '0', '1', '0', 0x230D0A23467269204A756C2032352031303A34353A35382043535420323031340D0A);
INSERT INTO `qrtz_job_details` VALUES ('statefuljob2', 'GROUP2', null, 'com.gph.saviorframework.quartz.StatefulJob', '0', '0', '1', '0', 0x230D0A23467269204A756C2032352031363A35353A30382043535420323031340D0A);

-- ----------------------------
-- Table structure for `qrtz_job_listeners`
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_listeners`;
CREATE TABLE `qrtz_job_listeners` (
  `JOB_NAME` varchar(200) NOT NULL,
  `JOB_GROUP` varchar(200) NOT NULL,
  `JOB_LISTENER` varchar(200) NOT NULL,
  PRIMARY KEY (`JOB_NAME`,`JOB_GROUP`,`JOB_LISTENER`),
  KEY `JOB_NAME` (`JOB_NAME`,`JOB_GROUP`),
  CONSTRAINT `qrtz_job_listeners_ibfk_1` FOREIGN KEY (`JOB_NAME`, `JOB_GROUP`) REFERENCES `qrtz_job_details` (`JOB_NAME`, `JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_job_listeners
-- ----------------------------

-- ----------------------------
-- Table structure for `qrtz_locks`
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks` (
  `LOCK_NAME` varchar(40) NOT NULL,
  PRIMARY KEY (`LOCK_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_locks
-- ----------------------------
INSERT INTO `qrtz_locks` VALUES ('CALENDAR_ACCESS');
INSERT INTO `qrtz_locks` VALUES ('JOB_ACCESS');
INSERT INTO `qrtz_locks` VALUES ('MISFIRE_ACCESS');
INSERT INTO `qrtz_locks` VALUES ('STATE_ACCESS');
INSERT INTO `qrtz_locks` VALUES ('TRIGGER_ACCESS');

-- ----------------------------
-- Table structure for `qrtz_paused_trigger_grps`
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps` (
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  PRIMARY KEY (`TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_paused_trigger_grps
-- ----------------------------

-- ----------------------------
-- Table structure for `qrtz_scheduler_state`
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state` (
  `INSTANCE_NAME` varchar(200) NOT NULL,
  `LAST_CHECKIN_TIME` bigint(13) NOT NULL,
  `CHECKIN_INTERVAL` bigint(13) NOT NULL,
  PRIMARY KEY (`INSTANCE_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------

-- ----------------------------
-- Table structure for `qrtz_simple_triggers`
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers` (
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `REPEAT_COUNT` bigint(7) NOT NULL,
  `REPEAT_INTERVAL` bigint(12) NOT NULL,
  `TIMES_TRIGGERED` bigint(10) NOT NULL,
  PRIMARY KEY (`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `TRIGGER_NAME` (`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_simple_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for `qrtz_triggers`
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers` (
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `JOB_NAME` varchar(200) NOT NULL,
  `JOB_GROUP` varchar(200) NOT NULL,
  `IS_VOLATILE` varchar(1) NOT NULL,
  `DESCRIPTION` varchar(250) DEFAULT NULL,
  `NEXT_FIRE_TIME` bigint(13) DEFAULT NULL,
  `PREV_FIRE_TIME` bigint(13) DEFAULT NULL,
  `PRIORITY` int(11) DEFAULT NULL,
  `TRIGGER_STATE` varchar(16) NOT NULL,
  `TRIGGER_TYPE` varchar(8) NOT NULL,
  `START_TIME` bigint(13) NOT NULL,
  `END_TIME` bigint(13) DEFAULT NULL,
  `CALENDAR_NAME` varchar(200) DEFAULT NULL,
  `MISFIRE_INSTR` smallint(2) DEFAULT NULL,
  `JOB_DATA` blob,
  PRIMARY KEY (`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `JOB_NAME` (`JOB_NAME`,`JOB_GROUP`),
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`JOB_NAME`, `JOB_GROUP`) REFERENCES `qrtz_job_details` (`JOB_NAME`, `JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_triggers
-- ----------------------------
INSERT INTO `qrtz_triggers` VALUES ('trigger1', 'GROUP1', 'statefuljob', 'GROUP1', '0', null, '1406468755987', '1406463930000', '5', 'WAITING', 'CRON', '1406256358000', '0', null, '0', '');
INSERT INTO `qrtz_triggers` VALUES ('trigger2', 'GROUP2', 'statefuljob2', 'GROUP2', '0', null, '1406468815986', '1406463933000', '5', 'WAITING', 'CRON', '1406278508000', '0', null, '0', '');

-- ----------------------------
-- Table structure for `qrtz_trigger_listeners`
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_trigger_listeners`;
CREATE TABLE `qrtz_trigger_listeners` (
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `TRIGGER_LISTENER` varchar(200) NOT NULL,
  PRIMARY KEY (`TRIGGER_NAME`,`TRIGGER_GROUP`,`TRIGGER_LISTENER`),
  KEY `TRIGGER_NAME` (`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `qrtz_trigger_listeners_ibfk_1` FOREIGN KEY (`TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_trigger_listeners
-- ----------------------------

-- ----------------------------
-- Table structure for `sf_field`
-- ----------------------------
DROP TABLE IF EXISTS `sf_field`;
CREATE TABLE `sf_field` (
  `FIELD_ID` int(11) NOT NULL COMMENT '字段ID',
  `FUNCTION_ID` varchar(50) DEFAULT NULL COMMENT '功能ID',
  `FIELD_CODE` varchar(50) DEFAULT NULL COMMENT '字段编码',
  `FIELD_NAME` varchar(100) DEFAULT NULL COMMENT '字段名称',
  `FIELD_TYPE` varchar(10) DEFAULT NULL COMMENT '字段类型',
  `FIELD_READ_ONLY` smallint(6) DEFAULT NULL COMMENT '只读数据',
  `FIELD_VERSION` int(11) DEFAULT '0' COMMENT '字段数据版本',
  `FIELD_ORDER` int(11) DEFAULT NULL COMMENT '字段顺序',
  `FIELD_CREATOR` varchar(50) DEFAULT NULL COMMENT '字段创建用户',
  `FIELD_CREATED` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '字段创建时间',
  `FIELD_MODIFIER` varchar(50) DEFAULT NULL COMMENT '字段修改用户',
  `FIELD_MODIFIED` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '字段修改时间',
  PRIMARY KEY (`FIELD_ID`),
  KEY `FK_FUNCTION_FIELD` (`FUNCTION_ID`),
  CONSTRAINT `FUNCTION_FIELD` FOREIGN KEY (`FUNCTION_ID`) REFERENCES `sf_function` (`FUNCTION_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sf_field
-- ----------------------------

-- ----------------------------
-- Table structure for `sf_function`
-- ----------------------------
DROP TABLE IF EXISTS `sf_function`;
CREATE TABLE `sf_function` (
  `FUNCTION_ID` varchar(50) NOT NULL COMMENT '功能ID',
  `MODULE_ID` varchar(50) DEFAULT NULL COMMENT '模块ID',
  `FUNCTION_NAME` varchar(100) DEFAULT NULL COMMENT '功能名称',
  `FUNCTION_URL` varchar(500) DEFAULT NULL COMMENT '功能地址',
  `FUNCTION_TYPE` varchar(50) DEFAULT NULL COMMENT '菜单功能|页面功能|...',
  `FUNCTION_HAS_PERMISSION` smallint(6) DEFAULT '0' COMMENT '可配权限',
  `FUNCTION_ORDER` int(11) DEFAULT '0' COMMENT '功能顺序',
  `FUNCTION_READ_ONLY` smallint(6) DEFAULT NULL COMMENT '功能只读数据',
  `FUNCTION_VERSION` int(11) DEFAULT '0' COMMENT '功能数据版本',
  `FUNCTION_CREATOR` varchar(50) DEFAULT NULL COMMENT '功能创建者',
  `FUNCTION_CREATED` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '功能创建时间',
  `FUNCTION_MODIFIER` varchar(50) DEFAULT NULL COMMENT '功能修改者',
  `FUNCTION_MODIFIED` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '功能修改时间',
  PRIMARY KEY (`FUNCTION_ID`),
  KEY `FK_FUNCTION_MODULE` (`MODULE_ID`),
  CONSTRAINT `FUNCTION_MODULE` FOREIGN KEY (`MODULE_ID`) REFERENCES `sf_module` (`MODULE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sf_function
-- ----------------------------
INSERT INTO `sf_function` VALUES ('INDEX', 'SF_OTHER', '首页', '/', null, '0', '0', null, '0', 'admin', '2014-05-07 14:34:46', 'admin', '2014-05-07 14:34:46');
INSERT INTO `sf_function` VALUES ('ORG_CREATE', 'SF_ORG', '机构新建', '/sf/org/create*', null, '0', '101010', null, '0', 'admin', '2014-05-07 14:34:46', 'admin', '2014-05-07 14:34:46');
INSERT INTO `sf_function` VALUES ('ORG_DELETE', 'SF_ORG', '机构删除', '/sf/org/edit*', null, '0', '101011', null, '0', 'admin', '2014-05-07 14:34:46', 'admin', '2014-05-07 14:34:46');
INSERT INTO `sf_function` VALUES ('ORG_DISABLE', 'SF_ORG', '机构停用', '/sf/org/disabled*', null, '0', '101015', null, '0', 'admin', '2014-05-07 14:34:46', 'admin', '2014-05-07 14:34:46');
INSERT INTO `sf_function` VALUES ('ORG_EDIT', 'SF_ORG', '机构修改', '/sf/org/delete*', null, '0', '101012', null, '0', 'admin', '2014-05-07 14:34:46', 'admin', '2014-05-07 14:34:46');
INSERT INTO `sf_function` VALUES ('ORG_ENABLE', 'SF_ORG', '机构启用', '/sf/org/enabled*', null, '0', '101014', null, '0', 'admin', '2014-05-07 14:34:46', 'admin', '2014-05-07 14:34:46');
INSERT INTO `sf_function` VALUES ('ORG_LIST', 'SF_ORG', '机构查询', '/sf/org/index*', null, '1', '101013', null, '0', 'admin', '2014-05-07 14:34:46', 'admin', '2014-05-07 14:34:46');
INSERT INTO `sf_function` VALUES ('PRESSIE_CREATE', 'SF_WORKFLOW', '创建礼品申请', '/gph/pressie/create*', null, '0', '1', null, '0', 'admin', '2014-09-07 00:00:00', 'admin', '2014-09-07 00:00:00');
INSERT INTO `sf_function` VALUES ('USER_CREATE', 'SF_USER', '用户新建', '/sf/user/create*', null, '0', '101020', null, '0', 'admin', '2014-05-07 14:34:46', 'admin', '2014-05-07 14:34:46');
INSERT INTO `sf_function` VALUES ('USER_DELETE', 'SF_USER', '用户删除', '/sf/user/delete*', null, '0', '101021', null, '0', 'admin', '2014-05-07 14:34:46', 'admin', '2014-05-07 14:34:46');
INSERT INTO `sf_function` VALUES ('USER_DISABLE', 'SF_USER', '用户停用', '/sf/user/disabled*', null, '0', '101025', null, '0', 'admin', '2014-05-07 14:34:46', 'admin', '2014-05-07 14:34:46');
INSERT INTO `sf_function` VALUES ('USER_EDIT', 'SF_USER', '用户修改', '/sf/user/edit*', null, '0', '101022', null, '0', 'admin', '2014-05-07 14:34:46', 'admin', '2014-05-07 14:34:46');
INSERT INTO `sf_function` VALUES ('USER_ENABLE', 'SF_USER', '用户启用', '/sf/user/enabled*', null, '0', '101024', null, '0', 'admin', '2014-05-07 14:34:46', 'admin', '2014-05-07 14:34:46');
INSERT INTO `sf_function` VALUES ('USER_LIST', 'SF_USER', '用户查询', '/sf/user/index*', null, '1', '101023', null, '0', 'admin', '2014-05-07 14:34:46', 'admin', '2014-05-07 14:34:46');
INSERT INTO `sf_function` VALUES ('USER_ROLE', 'SF_USER', '用户授权', '/sf/user/role*', null, '0', '101026', null, '0', 'admin', '2014-05-07 14:34:46', 'admin', '2014-05-07 14:34:46');
INSERT INTO `sf_function` VALUES ('WFDEF_CREATE', 'SF_WORKFLOW', '新建流程', '/sf/wfdef/created*', null, '0', '101015', null, '1', 'admin', '2014-07-20 09:50:21', 'admin', '2014-07-20 00:00:00');
INSERT INTO `sf_function` VALUES ('WFDEF_UPLOAD', 'SF_WORKFLOW', '上传流程定义文件', '/sf/wfdef/upload*', null, '0', '101015', null, '0', 'admin', '2014-07-20 00:00:00', 'admin', '2014-07-20 00:00:00');

-- ----------------------------
-- Table structure for `sf_item`
-- ----------------------------
DROP TABLE IF EXISTS `sf_item`;
CREATE TABLE `sf_item` (
  `ITEM_ID` varchar(50) NOT NULL COMMENT '数据主项ID',
  `ITEM_NAME` varchar(100) DEFAULT NULL COMMENT '数据主项名称',
  `ITEM_DESCRIPTION` varchar(500) DEFAULT NULL COMMENT '数据主项描述',
  `ITEM_IS_PERMISSION` smallint(6) DEFAULT NULL COMMENT '是字典权限',
  `ITEM_ORDER` int(11) DEFAULT '0' COMMENT '数据主项顺序',
  `ITEM_READ_ONLY` smallint(6) DEFAULT NULL COMMENT '数据主项只读数据',
  `ITEM_CREATOR` varchar(50) DEFAULT NULL COMMENT '数据主项创建者',
  `ITEM_CREATED` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '数据主项创建时间',
  `ITEM_MODIFIER` varchar(50) DEFAULT NULL COMMENT '数据主项修改者',
  `ITEM_MODIFIED` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '数据主项修改时间',
  `ITEM_VERSION` int(11) DEFAULT '0' COMMENT '数据主项数据版本',
  PRIMARY KEY (`ITEM_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sf_item
-- ----------------------------
INSERT INTO `sf_item` VALUES ('', '', '', '0', '0', null, 'admin', '2015-08-27 00:00:00', 'admin', '2015-08-27 00:00:00', '0');
INSERT INTO `sf_item` VALUES ('COMMON_YESNO', '是', null, '0', '5', null, 'admin', '2014-05-07 14:34:46', 'admin', '2014-05-07 14:34:46', '0');
INSERT INTO `sf_item` VALUES ('GROUP', '触发器组', '', '0', '10', null, 'admin', '2014-07-24 00:00:00', 'admin', '2014-07-24 00:00:00', '0');
INSERT INTO `sf_item` VALUES ('ORG_CATEGORY', '机构类型', null, '1', '2', null, 'admin', '2014-05-07 14:34:46', 'admin', '2014-05-07 14:34:46', '0');
INSERT INTO `sf_item` VALUES ('ORG_PROPERTY', '机构属性', null, '1', '1', null, 'admin', '2014-05-07 14:34:46', 'admin', '2014-05-07 14:34:46', '0');
INSERT INTO `sf_item` VALUES ('PERMISSION_TYPE', '权限类型', null, '0', '6', null, 'admin', '2014-05-07 14:34:46', 'admin', '2014-05-07 14:34:46', '0');
INSERT INTO `sf_item` VALUES ('PERMISSION_TYPE_ORG', '机构权限类型', null, '0', '8', null, 'admin', '2014-05-07 14:34:46', 'admin', '2014-05-07 14:34:46', '0');
INSERT INTO `sf_item` VALUES ('PERMISSION_TYPE_USER', '用户权限类型', null, '0', '7', null, 'admin', '2014-05-07 14:34:46', 'admin', '2014-05-07 14:34:46', '0');
INSERT INTO `sf_item` VALUES ('POSITION_TYPE', '岗位类型', null, '0', '3', null, 'admin', '2014-05-07 14:34:46', 'admin', '2014-05-07 14:34:46', '0');
INSERT INTO `sf_item` VALUES ('ROLE_TYPE', '角色类型', null, '0', '9', null, 'admin', '2014-05-07 14:34:46', 'admin', '2014-05-07 14:34:46', '0');
INSERT INTO `sf_item` VALUES ('SPZT', '审批意见', '', '0', '11', null, 'admin', '2014-09-07 00:00:00', 'admin', '2014-09-07 00:00:00', '0');
INSERT INTO `sf_item` VALUES ('TEST', '测试数据', '测试数据', '0', '12', null, 'admin', '2014-12-20 00:00:00', 'admin', '2014-12-20 00:00:00', '0');
INSERT INTO `sf_item` VALUES ('USER_GENDER', '用户性别', null, '0', '4', null, 'admin', '2014-05-07 14:34:46', 'admin', '2014-05-07 14:34:46', '0');

-- ----------------------------
-- Table structure for `sf_menu`
-- ----------------------------
DROP TABLE IF EXISTS `sf_menu`;
CREATE TABLE `sf_menu` (
  `MENU_ID` varchar(50) NOT NULL COMMENT '菜单ID',
  `PARENT_MENU_ID` varchar(50) DEFAULT NULL COMMENT '父菜单ID',
  `MENU_NAME` varchar(100) DEFAULT NULL COMMENT '菜单名称',
  `MENU_URL` varchar(500) DEFAULT NULL COMMENT '菜单地址',
  `MENU_DESCRIPTION` varchar(1000) DEFAULT NULL COMMENT '菜单描述',
  `MENU_IFRAME` smallint(6) DEFAULT NULL COMMENT '嵌入页面',
  `MENU_ICON` varchar(50) DEFAULT NULL COMMENT '菜单图标',
  `MENU_ORDER` int(11) DEFAULT '0' COMMENT '菜单顺序',
  `MENU_READ_ONLY` smallint(6) DEFAULT NULL COMMENT '菜单只读数据',
  `MENU_OPEN_IN_HOME` smallint(6) DEFAULT '0' COMMENT '是否主页中打开',
  `MENU_VERSION` int(11) DEFAULT '0' COMMENT '菜单数据版本',
  `MENU_CREATOR` varchar(50) DEFAULT NULL COMMENT '菜单创建者',
  `MENU_CREATED` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '菜单创建时间',
  `MENU_MODIFIER` varchar(50) DEFAULT NULL COMMENT '菜单修改者',
  `MENU_MODIFIED` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '菜单修改时间',
  PRIMARY KEY (`MENU_ID`),
  KEY `FK_MENU_PARENT` (`PARENT_MENU_ID`),
  CONSTRAINT `MENU_PARENT` FOREIGN KEY (`PARENT_MENU_ID`) REFERENCES `sf_menu` (`MENU_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sf_menu
-- ----------------------------
INSERT INTO `sf_menu` VALUES ('ATTENDANCE', 'PERSONALWORK', '实时考勤', '/attendance/showAttendanceManage', '', '0', null, '0', null, '0', '2', 'admin', '2015-07-22 14:36:51', 'admin', '2015-07-22 00:00:00');
INSERT INTO `sf_menu` VALUES ('CARUSE', null, '用车管理', '', '', '0', null, '204', null, '0', '0', 'admin', '2015-07-23 00:00:00', 'admin', '2015-07-23 00:00:00');
INSERT INTO `sf_menu` VALUES ('CARUSE_MANAGE', 'USERMANAGE', '用车信息', '/car/showUserCarUseManage', '', '0', null, '3', null, '0', '1', 'admin', '2015-07-25 11:05:34', 'admin', '2015-07-25 00:00:00');
INSERT INTO `sf_menu` VALUES ('CAR_COUNT', 'CARUSE', '车辆统计', '/car/showCarCount', '', '0', null, '1', null, '0', '1', 'admin', '2015-07-23 19:24:18', 'admin', '2015-07-23 00:00:00');
INSERT INTO `sf_menu` VALUES ('CAR_DISTRIBUTE', 'CARUSE', '车辆分布', '/car/showCarDistribute', '', '0', null, '4', null, '0', '1', 'admin', '2015-07-23 19:24:37', 'admin', '2015-07-23 00:00:00');
INSERT INTO `sf_menu` VALUES ('CAR_EXCEPTION', 'CARUSE', '车辆异常', '/car/showCarException', '', '0', null, '5', null, '0', '1', 'admin', '2015-07-23 19:24:43', 'admin', '2015-07-23 00:00:00');
INSERT INTO `sf_menu` VALUES ('CAR_MANAGE', 'CARUSE', '车辆管理', '/car/showCarManage', '', '0', null, '0', null, '0', '0', 'admin', '2015-07-23 00:00:00', 'admin', '2015-07-23 00:00:00');
INSERT INTO `sf_menu` VALUES ('CAR_USE', 'CARUSE', '用车情况', '/car/showCarUse', '', '0', null, '3', null, '0', '1', 'admin', '2015-07-23 19:24:30', 'admin', '2015-07-23 00:00:00');
INSERT INTO `sf_menu` VALUES ('CONFIG', null, '系统配置', null, null, '0', 'config', '200', null, '0', '0', 'admin', '2014-12-16 11:54:40', 'admin', '2014-05-07 14:34:46');
INSERT INTO `sf_menu` VALUES ('DEPARTMENT', null, '部门管理', '', '', '0', null, '205', null, '0', '0', 'admin', '2015-07-23 00:00:00', 'admin', '2015-07-23 00:00:00');
INSERT INTO `sf_menu` VALUES ('DOCUMENT_MANAGE', 'DEPARTMENT', '公文管理', '/document/showDocumentManage', '', '0', null, '0', null, '0', '0', 'admin', '2015-07-23 00:00:00', 'admin', '2015-07-23 00:00:00');
INSERT INTO `sf_menu` VALUES ('FINANCIAL_AUDIT', 'DEPARTMENT', '财务统计', '/chart/showFinancialAuditManage', '', '0', null, '5', null, '0', '1', 'admin', '2015-07-24 19:47:04', 'admin', '2015-07-24 00:00:00');
INSERT INTO `sf_menu` VALUES ('FUNCTION_LIST', 'SECURITY', '功能', 'sf/function/index', null, '0', 'function', '170', null, '0', '0', 'admin', '2014-05-07 14:34:46', 'admin', '2014-05-07 14:34:46');
INSERT INTO `sf_menu` VALUES ('ITEM_LIST', 'CONFIG', '数据字典', 'sf/item/list', null, '0', 'item', '210', null, '0', '0', 'admin', '2014-05-07 14:34:46', 'admin', '2014-05-07 14:34:46');
INSERT INTO `sf_menu` VALUES ('LIBRARY', null, '枕流文库', '', '', '0', null, '202', null, '0', '1', 'admin', '2015-07-23 15:08:59', 'admin', '2015-07-23 00:00:00');
INSERT INTO `sf_menu` VALUES ('LIBRARY_MANAGE', 'LIBRARY', '枕流文库', '/library/showLibraryManage', '', '0', null, '0', null, '0', '2', 'admin', '2015-07-23 12:56:57', 'admin', '2015-07-23 00:00:00');
INSERT INTO `sf_menu` VALUES ('MEETING_MANAGE', 'DEPARTMENT', '会务接待管理', '/meeting/showMeetingManage', '', '0', null, '3', null, '0', '1', 'admin', '2015-07-23 21:01:39', 'admin', '2015-07-23 00:00:00');
INSERT INTO `sf_menu` VALUES ('MENU_LIST', 'SECURITY', '菜单', 'sf/menu/index', null, '0', 'menu', '130', null, '0', '0', 'admin', '2014-05-07 14:34:46', 'admin', '2014-05-07 14:34:46');
INSERT INTO `sf_menu` VALUES ('MODULE_LIST', 'SECURITY', '模块', 'sf/module/list', null, '0', 'module', '160', null, '0', '0', 'admin', '2014-12-14 09:15:38', 'admin', '2014-05-07 14:34:46');
INSERT INTO `sf_menu` VALUES ('MONTH_STATISTICS', 'PERSONALWORK', '月度统计', '/attendance/showAttMonthStatisticsManage', '', '0', null, '0', null, '0', '0', 'admin', '2015-07-23 00:00:00', 'admin', '2015-07-23 00:00:00');
INSERT INTO `sf_menu` VALUES ('NEWS', null, '枕流学闻', '', '', '0', null, '203', null, '0', '1', 'admin', '2015-07-23 15:08:54', 'admin', '2015-07-23 00:00:00');
INSERT INTO `sf_menu` VALUES ('NEWS_MANAGE', 'NEWS', '枕流学闻', '/news/showNewsManage', '', '0', null, '0', null, '0', '1', 'admin', '2015-07-23 15:24:47', 'admin', '2015-07-23 00:00:00');
INSERT INTO `sf_menu` VALUES ('ORG_LIST', 'SECURITY', '组织机构', 'sf/org/index', null, '0', 'org', '110', null, '0', '0', 'admin', '2014-05-07 14:34:46', 'admin', '2014-05-07 14:34:46');
INSERT INTO `sf_menu` VALUES ('PERSONALWORK', null, '个人办公', '', '', '0', null, '201', null, '0', '0', 'admin', '2015-07-22 00:00:00', 'admin', '2015-07-22 00:00:00');
INSERT INTO `sf_menu` VALUES ('PERSONAL_ARCHIVE', 'USERMANAGE', '个人档案', '/archive/showArchiveManage', '', '0', null, '2', null, '0', '1', 'admin', '2015-07-25 11:04:47', 'admin', '2015-07-25 00:00:00');
INSERT INTO `sf_menu` VALUES ('PERSONAL_MANAGE_VIEW', 'USERMANAGE', '管理检视', '/chart/showManageViewManage', '', '0', null, '6', null, '0', '1', 'admin', '2015-07-25 15:20:13', 'admin', '2015-07-25 00:00:00');
INSERT INTO `sf_menu` VALUES ('PERSONAL_MONTH_AUDIT', 'USERMANAGE', '月度考核', '/chart/showPersonMonthAuditManage', '', '0', null, '4', null, '0', '1', 'admin', '2015-07-25 15:19:58', 'admin', '2015-07-25 00:00:00');
INSERT INTO `sf_menu` VALUES ('PERSONAL_YEAR_AUDIT', 'USERMANAGE', '年度考核', '/chart/showPersonYearAuditManage', '', '0', null, '5', null, '0', '1', 'admin', '2015-07-25 15:20:05', 'admin', '2015-07-25 00:00:00');
INSERT INTO `sf_menu` VALUES ('POSITION_LIST', 'SECURITY', '岗位', 'sf/position/list', null, '0', 'position', '150', null, '0', '0', 'admin', '2014-05-07 14:34:46', 'admin', '2014-05-07 14:34:46');
INSERT INTO `sf_menu` VALUES ('ROLE_LIST', 'SECURITY', '角色', 'sf/role/index', null, '0', 'role', '140', null, '0', '0', 'admin', '2014-05-07 14:34:46', 'admin', '2014-05-07 14:34:46');
INSERT INTO `sf_menu` VALUES ('ROLLROME_MANAGE', 'DEPARTMENT', '卷库管理', '/rollrooms/showRollRoomsManage', '', '0', null, '1', null, '0', '1', 'admin', '2015-07-23 21:00:29', 'admin', '2015-07-23 00:00:00');
INSERT INTO `sf_menu` VALUES ('ROLL_MANAGE', 'DEPARTMENT', '卷宗管理', '/rolls/showRollsManage', '', '0', null, '2', null, '0', '0', 'admin', '2015-07-23 00:00:00', 'admin', '2015-07-23 00:00:00');
INSERT INTO `sf_menu` VALUES ('SCHEDULE_MANAGE', 'USERMANAGE', '日程安排', '/schedule/showScheduleManage', '', '0', null, '0', null, '0', '0', 'admin', '2015-07-23 00:00:00', 'admin', '2015-07-23 00:00:00');
INSERT INTO `sf_menu` VALUES ('SECURITY', null, '系统安全', null, null, '0', 'menu-node-security', '100', null, '0', '0', 'admin', '2014-12-16 11:51:31', 'admin', '2014-05-07 14:34:46');
INSERT INTO `sf_menu` VALUES ('SURVEY_MANAGE', 'DEPARTMENT', '课题调研管理', '/survey/showSurveyManage', '', '0', null, '4', null, '0', '0', 'admin', '2015-07-23 00:00:00', 'admin', '2015-07-23 00:00:00');
INSERT INTO `sf_menu` VALUES ('TASK_STATISTICS', 'DEPARTMENT', '任务统计', '/chart/showTaskStatisticsManage', '', '0', null, '6', null, '0', '1', 'admin', '2015-07-24 19:47:14', 'admin', '2015-07-24 00:00:00');
INSERT INTO `sf_menu` VALUES ('TODAY_STATISTICS', 'PERSONALWORK', '今日统计', '/attendance/showAttTodayStatisticsManage', '', '0', null, '0', null, '0', '2', 'admin', '2015-07-22 14:37:02', 'admin', '2015-07-22 00:00:00');
INSERT INTO `sf_menu` VALUES ('TODAY_TASK', 'USERMANAGE', '今日工作', '/todaytask/showTodayTaskManage', '', '0', null, '1', null, '0', '2', 'admin', '2015-07-25 11:04:41', 'admin', '2015-07-25 00:00:00');
INSERT INTO `sf_menu` VALUES ('USERMANAGE', null, '人员管理', '', '', '0', null, '206', null, '0', '0', 'admin', '2015-07-23 00:00:00', 'admin', '2015-07-23 00:00:00');
INSERT INTO `sf_menu` VALUES ('USER_LIST', 'SECURITY', '用户', 'sf/user/index', null, '0', 'user', '120', null, '0', '0', 'admin', '2014-05-07 14:34:46', 'admin', '2014-05-07 14:34:46');
INSERT INTO `sf_menu` VALUES ('YEAR_STATISTICS', 'PERSONALWORK', '年度统计', '/attendance/showAttYearStatisticsManage', '', '0', null, '0', null, '0', '0', 'admin', '2015-07-23 00:00:00', 'admin', '2015-07-23 00:00:00');

-- ----------------------------
-- Table structure for `sf_module`
-- ----------------------------
DROP TABLE IF EXISTS `sf_module`;
CREATE TABLE `sf_module` (
  `MODULE_ID` varchar(50) NOT NULL COMMENT '模块ID',
  `MODULE_NAME` varchar(100) DEFAULT NULL COMMENT '模块名称',
  `MODULE_DESCRIPTION` varchar(500) DEFAULT NULL COMMENT '模块描述',
  `MODULE_ORDER` int(11) DEFAULT '0' COMMENT '模块顺序',
  `MODULE_READ_ONLY` smallint(6) DEFAULT NULL COMMENT '模块只读数据',
  `MODULE_VERSION` int(11) DEFAULT '0' COMMENT '模块数据版本',
  `MODULE_CREATOR` varchar(50) DEFAULT NULL COMMENT '模块创建者',
  `MODULE_CREATED` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '模块创建时间',
  `MODULE_MODIFIER` varchar(50) DEFAULT NULL COMMENT '模块修改者',
  `MODULE_MODIFIED` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '模块修改时间',
  PRIMARY KEY (`MODULE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sf_module
-- ----------------------------
INSERT INTO `sf_module` VALUES ('CBS_NEWS', '新闻管理', null, '10000', null, '0', 'admin', '2014-12-19 00:00:00', 'admin', '2014-12-19 00:00:00');
INSERT INTO `sf_module` VALUES ('SF_FUNCTION', '功能管理', null, '5', null, '0', 'admin', '2014-05-07 14:34:46', 'admin', '2014-05-07 14:34:46');
INSERT INTO `sf_module` VALUES ('SF_ITEM', '数据字典管理', null, '9', null, '0', 'admin', '2014-05-07 14:34:46', 'admin', '2014-05-07 14:34:46');
INSERT INTO `sf_module` VALUES ('SF_LOG', '平台日志', null, '8', null, '0', 'admin', '2014-05-07 14:34:46', 'admin', '2014-05-07 14:34:46');
INSERT INTO `sf_module` VALUES ('SF_MENU', '菜单管理', null, '2', null, '0', 'admin', '2014-05-07 14:34:46', 'admin', '2014-05-07 14:34:46');
INSERT INTO `sf_module` VALUES ('SF_MODULE', '模块管理', null, '6', null, '0', 'admin', '2014-05-07 14:34:46', 'admin', '2014-05-07 14:34:46');
INSERT INTO `sf_module` VALUES ('SF_ORG', '机构管理', null, '0', null, '0', 'admin', '2014-05-07 14:34:46', 'admin', '2014-05-07 14:34:46');
INSERT INTO `sf_module` VALUES ('SF_OTHER', '其他', null, '11', null, '0', 'admin', '2014-05-07 14:34:46', 'admin', '2014-05-07 14:34:46');
INSERT INTO `sf_module` VALUES ('SF_PERMISSION', '权限管理', null, '200', null, '0', 'admin', '2014-05-07 14:34:46', 'admin', '2014-05-07 14:34:46');
INSERT INTO `sf_module` VALUES ('SF_POSITION', '岗位管理', null, '4', null, '0', 'admin', '2014-05-07 14:34:46', 'admin', '2014-05-07 14:34:46');
INSERT INTO `sf_module` VALUES ('SF_ROLE', '角色管理', null, '3', null, '0', 'admin', '2014-05-07 14:34:46', 'admin', '2014-05-07 14:34:46');
INSERT INTO `sf_module` VALUES ('SF_USER', '用户管理', null, '1', null, '0', 'admin', '2014-05-07 14:34:46', 'admin', '2014-05-07 14:34:46');
INSERT INTO `sf_module` VALUES ('SF_WORKFLOW', '工作流管理', null, '10', null, '0', 'admin', '2014-05-07 14:34:46', 'admin', '2014-05-07 14:34:46');

-- ----------------------------
-- Table structure for `sf_org`
-- ----------------------------
DROP TABLE IF EXISTS `sf_org`;
CREATE TABLE `sf_org` (
  `ORG_ID` varchar(50) NOT NULL COMMENT '机构ID',
  `ORG_NAME` varchar(100) DEFAULT NULL COMMENT '机构名称',
  `PARENT_ORG_ID` varchar(50) DEFAULT NULL COMMENT '上级机构ID',
  `ORG_DESCRIPTION` varchar(500) DEFAULT NULL COMMENT '机构描述',
  `ORG_TEL` varchar(50) DEFAULT NULL COMMENT '机构电话',
  `ORG_ADDRESS` varchar(500) DEFAULT NULL COMMENT '机构地址',
  `ORG_CONTACT` varchar(50) DEFAULT NULL COMMENT '机构联系人',
  `ORG_PATH` varchar(500) DEFAULT NULL COMMENT '机构路径',
  `ORG_LEVEL` varchar(10) DEFAULT NULL COMMENT '机构等级',
  `ORG_ENABLED` smallint(6) DEFAULT NULL COMMENT '机构启用标志',
  `ORG_TYPE` varchar(50) DEFAULT NULL COMMENT '机构类型',
  `ORG_PROPERTY` varchar(50) DEFAULT NULL COMMENT '机构属性',
  `ORG_ORDER` int(11) DEFAULT '0' COMMENT '机构顺序',
  `ORG_VERSION` int(11) DEFAULT '0' COMMENT '机构数据版本',
  `ORG_CREATOR` varchar(50) DEFAULT NULL COMMENT '机构创建者',
  `ORG_CREATED` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '机构创建时间',
  `ORG_MODIFIER` varchar(50) DEFAULT NULL COMMENT '机构修改者',
  `ORG_MODIFIED` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '机构修改时间',
  PRIMARY KEY (`ORG_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sf_org
-- ----------------------------
INSERT INTO `sf_org` VALUES ('00012', '研发002', '1005', 'qq', '13124741542', 'aa', '王思', '1000|1005|00012', '3', '1', '1', '1', '0', '0', 'admin', '2015-07-30 00:00:00', 'admin', '2015-07-30 00:00:00');
INSERT INTO `sf_org` VALUES ('001', '研发001', '1005', '11', '13733173333', '北京市海淀区 ', '123', '1000|1005|001', '3', '1', '1', '1', '1', '0', 'admin', '2015-07-29 00:00:00', 'admin', '2015-07-29 00:00:00');
INSERT INTO `sf_org` VALUES ('002', '工业应用软件001 ', '1010', '1111', '12345678977', '北京市朝阳区', '工业', '1000|1010|002', '3', '1', '1', '1', '11111', '1', 'admin', '2015-07-29 14:32:15', 'admin', '2015-07-29 00:00:00');
INSERT INTO `sf_org` VALUES ('1000', '检察院', null, '', '053212345678', '临沂市', '', '1000', '1', '1', '1', '1', '1', '5', 'admin', '2015-07-21 15:42:33', 'admin', '2015-07-21 00:00:00');
INSERT INTO `sf_org` VALUES ('1005', '研发部11', '1000', '研发部', '123456788', '青岛市高新区智力岛路1号创业大厦C座', '郑敏', '1000|1005', '2', '1', '1', '1', '5', '5', 'admin', '2015-07-21 15:48:36', 'admin', '2015-07-21 00:00:00');
INSERT INTO `sf_org` VALUES ('1010', '工业应用软件研究室', '1000', '工业应用软件研究室', '123456', '青岛市高新区智力岛路1号创业大厦C座', '郑敏', '1000|1010', '2', '1', '1', '1', '10', '1', 'admin', '2014-12-16 11:09:38', 'admin', '2014-12-16 00:00:00');
INSERT INTO `sf_org` VALUES ('1011', '基础软件研究室', '1000', '基础软件研究室', '123456', '青岛市高新区智力岛路1号创业大厦C座', '王风涛', '1000|1011', '2', '1', '1', '1', '11', '2', 'admin', '2014-12-16 11:10:03', 'admin', '2014-12-16 00:00:00');

-- ----------------------------
-- Table structure for `sf_permission`
-- ----------------------------
DROP TABLE IF EXISTS `sf_permission`;
CREATE TABLE `sf_permission` (
  `PERMISSION_ID` varchar(50) NOT NULL COMMENT '权限ID',
  `FIELD_ID` int(11) DEFAULT NULL COMMENT '字段ID',
  `SUB_ITEM_ID` varchar(50) DEFAULT NULL COMMENT '数据子项ID',
  `PERMISSION_NAME` varchar(100) DEFAULT NULL COMMENT '权限名称',
  `PERMISSION_TYPE` varchar(50) DEFAULT NULL COMMENT '字典权限|用户权限|其他权限',
  `PERMISSION_EXPRESSION` varchar(500) DEFAULT NULL COMMENT '权限表达式',
  `PERMISSION_USER_TYPE` varchar(50) DEFAULT NULL COMMENT '用户权限类型',
  `PERMISSION_ORG_TYPE` varchar(50) DEFAULT NULL COMMENT '机构权限类型',
  `PERMISSION_FIELD_VALUE` varchar(100) DEFAULT NULL COMMENT '权限字段数值',
  `PERMISSION_DESCRIPTION` varchar(500) DEFAULT NULL COMMENT '权限描述',
  `PERMISSION_ORDER` int(11) DEFAULT '0' COMMENT '权限顺序',
  `PERMISSION_READ_ONLY` smallint(6) DEFAULT NULL COMMENT '权限只读数据',
  `PERMISSION_VERSION` int(11) DEFAULT '0' COMMENT '权限数据版本',
  `PERMISSION_CREATOR` varchar(50) DEFAULT NULL COMMENT '权限创建者',
  `PERMISSION_CREATED` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '权限创建时间',
  `PERMISSION_MODIFIER` varchar(50) DEFAULT NULL COMMENT '权限修改者',
  `PERMISSION_MODIFIED` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '权限修改时间',
  PRIMARY KEY (`PERMISSION_ID`),
  KEY `FK_ITEM_PERMISSION` (`SUB_ITEM_ID`),
  KEY `FK_PERMISSION_FIELD` (`FIELD_ID`),
  CONSTRAINT `ITEM_PERMISSION` FOREIGN KEY (`SUB_ITEM_ID`) REFERENCES `sf_sub_item` (`SUB_ITEM_ID`),
  CONSTRAINT `PERMISSION_FIELD` FOREIGN KEY (`FIELD_ID`) REFERENCES `sf_field` (`FIELD_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sf_permission
-- ----------------------------

-- ----------------------------
-- Table structure for `sf_permission_org`
-- ----------------------------
DROP TABLE IF EXISTS `sf_permission_org`;
CREATE TABLE `sf_permission_org` (
  `ORG_ID` varchar(50) NOT NULL COMMENT '机构ID',
  `PERMISSION_ID` varchar(50) NOT NULL COMMENT '权限ID',
  PRIMARY KEY (`ORG_ID`,`PERMISSION_ID`),
  KEY `FK_PERMISSION_ORG` (`ORG_ID`),
  KEY `FK_PERMISSION_ORG2` (`PERMISSION_ID`),
  CONSTRAINT `PERMISSION_ORG` FOREIGN KEY (`ORG_ID`) REFERENCES `sf_org` (`ORG_ID`),
  CONSTRAINT `PERMISSION_ORG2` FOREIGN KEY (`PERMISSION_ID`) REFERENCES `sf_permission` (`PERMISSION_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sf_permission_org
-- ----------------------------

-- ----------------------------
-- Table structure for `sf_permission_user`
-- ----------------------------
DROP TABLE IF EXISTS `sf_permission_user`;
CREATE TABLE `sf_permission_user` (
  `PERMISSION_ID` varchar(50) NOT NULL COMMENT '权限ID',
  `USER_ID` varchar(50) NOT NULL COMMENT '用户ID',
  PRIMARY KEY (`PERMISSION_ID`,`USER_ID`),
  KEY `FK_PERMISSION_USER` (`PERMISSION_ID`),
  KEY `FK_PERMISSION_USER2` (`USER_ID`),
  CONSTRAINT `PERMISSION_USER` FOREIGN KEY (`PERMISSION_ID`) REFERENCES `sf_permission` (`PERMISSION_ID`),
  CONSTRAINT `PERMISSION_USER2` FOREIGN KEY (`USER_ID`) REFERENCES `sf_user` (`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sf_permission_user
-- ----------------------------

-- ----------------------------
-- Table structure for `sf_portlet`
-- ----------------------------
DROP TABLE IF EXISTS `sf_portlet`;
CREATE TABLE `sf_portlet` (
  `PORTLET_ID` varchar(50) NOT NULL COMMENT '门户应用ID',
  `PORTLET_TITLE` varchar(100) DEFAULT NULL COMMENT '门户应用标题',
  `PORTLET_URL` varchar(100) DEFAULT NULL COMMENT '门户应用地址',
  `PORTLET_DESCRIPTION` varchar(500) DEFAULT NULL COMMENT '门户应用描述',
  `PORTLET_ORDER` int(11) DEFAULT NULL COMMENT '门户应用顺序',
  `PORTLET_CREATOR` varchar(50) DEFAULT NULL COMMENT '门户应用创建用户',
  `PORTLET_CREATED` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '门户应用创建时间',
  `PORTLET_MODIFIER` varchar(50) DEFAULT NULL COMMENT '门户应用修改用户',
  `PORTLET_MODIFIED` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '门户应用修改时间',
  `PORTLET_VERSION` int(11) DEFAULT NULL COMMENT '门户应用数据版本',
  PRIMARY KEY (`PORTLET_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sf_portlet
-- ----------------------------
INSERT INTO `sf_portlet` VALUES ('PROPERTY_PORTLET', '平台属性', 'sf/config/property/portlet', '', '1', 'admin', '2014-05-07 14:34:46', 'admin', '2014-05-07 14:34:46', null);

-- ----------------------------
-- Table structure for `sf_portlet_location`
-- ----------------------------
DROP TABLE IF EXISTS `sf_portlet_location`;
CREATE TABLE `sf_portlet_location` (
  `PORTLET_LOCATION_ID` int(11) NOT NULL COMMENT '门户应用位置ID',
  `PORTLET_ID` varchar(50) DEFAULT NULL COMMENT '门户应用ID',
  `POSITION_ID` varchar(50) DEFAULT NULL COMMENT '岗位ID',
  `PORTLET_LOCATION_ROW` int(11) DEFAULT NULL COMMENT '门户应用位置行数',
  `PORTLET_LOCATION_COLUMN` int(11) DEFAULT NULL COMMENT '门户应用位置列数',
  `PORTLET_LOCATION_ORDER` int(11) DEFAULT NULL COMMENT '门户应用位置顺序',
  `PORTLET_LOCATION_CREATOR` varchar(50) DEFAULT NULL COMMENT '门户应用位置创建用户',
  `PORTLET_LOCATION_CREATED` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '门户应用位置创建时间',
  `PORTLET_LOCATION_MODIFIER` varchar(50) DEFAULT NULL COMMENT '门户应用位置修改用户',
  `PORTLET_LOCATION_MODIFIED` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '门户应用位置修改时间',
  `PORTLET_LOCATION_VERSION` int(11) DEFAULT NULL COMMENT '门户应用位置修改时间',
  PRIMARY KEY (`PORTLET_LOCATION_ID`),
  KEY `FK_PORTLET_LOCATION_PORTLET` (`PORTLET_ID`),
  KEY `FK_POSITION_PORTLET_LOCATION` (`POSITION_ID`),
  CONSTRAINT `PORTLET_LOCATION_POR` FOREIGN KEY (`PORTLET_ID`) REFERENCES `sf_portlet` (`PORTLET_ID`),
  CONSTRAINT `POSITION_PORTLET_LOC` FOREIGN KEY (`POSITION_ID`) REFERENCES `sf_position` (`POSITION_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sf_portlet_location
-- ----------------------------
INSERT INTO `sf_portlet_location` VALUES ('53', 'PROPERTY_PORTLET', '1', '0', '0', null, null, '2014-08-04 13:10:02', null, '0000-00-00 00:00:00', '0');

-- ----------------------------
-- Table structure for `sf_position`
-- ----------------------------
DROP TABLE IF EXISTS `sf_position`;
CREATE TABLE `sf_position` (
  `POSITION_ID` varchar(50) NOT NULL COMMENT '岗位ID',
  `POSITION_NAME` varchar(100) DEFAULT NULL COMMENT '岗位名称',
  `POSITION_DESCRIPTION` varchar(500) DEFAULT NULL COMMENT '岗位描述',
  `POSITION_TYPE` varchar(50) DEFAULT NULL COMMENT '岗位类型',
  `POSITION_ORDER` int(11) DEFAULT '0' COMMENT '岗位顺序',
  `POSITION_VERSION` int(11) DEFAULT '0' COMMENT '岗位数据版本',
  `POSITION_CREATOR` varchar(50) DEFAULT NULL COMMENT '岗位创建者',
  `POSITION_CREATED` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '岗位创建时间',
  `POSITION_MODIFIER` varchar(50) DEFAULT NULL COMMENT '岗位修改者',
  `POSITION_MODIFIED` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '岗位修改时间',
  PRIMARY KEY (`POSITION_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sf_position
-- ----------------------------
INSERT INTO `sf_position` VALUES ('1', '管理员', '管理员', '2', '1', '1', 'admin', '2014-12-17 19:32:32', 'admin', '2014-12-17 00:00:00');
INSERT INTO `sf_position` VALUES ('102', '操作员', '操作员', '0', '1', '11', 'admin', '2014-12-19 14:28:51', 'admin', '2014-12-17 00:00:00');
INSERT INTO `sf_position` VALUES ('103', '测试员', '测试员', '0', '103', '7', 'admin', '2014-12-19 16:08:48', 'admin', '2014-12-17 00:00:00');
INSERT INTO `sf_position` VALUES ('107', '高级测试员', '高级测试员', '1', '123', '4', 'admin', '2014-12-19 16:10:10', 'admin', '2014-12-17 00:00:00');
INSERT INTO `sf_position` VALUES ('108', '行政人员', '行政人员-指定级别', '2', '124', '5', 'admin', '2014-12-19 16:08:56', 'admin', '2014-12-17 00:00:00');
INSERT INTO `sf_position` VALUES ('109', '高级管理岗位', '高级管理岗位', '2', '1020', '2', 'admin', '2014-12-19 14:37:07', 'admin', '2014-12-19 00:00:00');
INSERT INTO `sf_position` VALUES ('110', '办公室主任', '', '0', '12', '5', 'admin', '2015-07-23 19:16:49', 'admin', '2015-07-21 00:00:00');

-- ----------------------------
-- Table structure for `sf_position_level`
-- ----------------------------
DROP TABLE IF EXISTS `sf_position_level`;
CREATE TABLE `sf_position_level` (
  `PL_ID` varchar(50) NOT NULL COMMENT '岗位级别ID',
  `PL_NAME` varchar(100) DEFAULT NULL COMMENT '岗位级别名称',
  `PL_VALUE` varchar(50) DEFAULT NULL COMMENT '岗位级别数值',
  PRIMARY KEY (`PL_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sf_position_level
-- ----------------------------
INSERT INTO `sf_position_level` VALUES ('1', '一级', '1');
INSERT INTO `sf_position_level` VALUES ('2', '二级', '2');
INSERT INTO `sf_position_level` VALUES ('3', '三级', '3');

-- ----------------------------
-- Table structure for `sf_position_org`
-- ----------------------------
DROP TABLE IF EXISTS `sf_position_org`;
CREATE TABLE `sf_position_org` (
  `ORG_ID` varchar(50) NOT NULL COMMENT '机构ID',
  `POSITION_ID` varchar(50) NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`ORG_ID`,`POSITION_ID`),
  KEY `FK_POSITION_ORG` (`ORG_ID`),
  KEY `FK_POSITION_ORG2` (`POSITION_ID`),
  CONSTRAINT `POSITION_ORG` FOREIGN KEY (`ORG_ID`) REFERENCES `sf_org` (`ORG_ID`),
  CONSTRAINT `POSITION_ORG2` FOREIGN KEY (`POSITION_ID`) REFERENCES `sf_position` (`POSITION_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sf_position_org
-- ----------------------------
INSERT INTO `sf_position_org` VALUES ('1010', '107');
INSERT INTO `sf_position_org` VALUES ('1011', '107');

-- ----------------------------
-- Table structure for `sf_position_pl`
-- ----------------------------
DROP TABLE IF EXISTS `sf_position_pl`;
CREATE TABLE `sf_position_pl` (
  `POSITION_ID` varchar(50) NOT NULL COMMENT '岗位ID',
  `PL_ID` varchar(50) NOT NULL COMMENT '岗位级别ID',
  PRIMARY KEY (`POSITION_ID`,`PL_ID`),
  KEY `FK_POSITION_PL` (`POSITION_ID`),
  KEY `FK_POSITION_PL2` (`PL_ID`),
  CONSTRAINT `POSITION_PL` FOREIGN KEY (`POSITION_ID`) REFERENCES `sf_position` (`POSITION_ID`),
  CONSTRAINT `POSITION_PL2` FOREIGN KEY (`PL_ID`) REFERENCES `sf_position_level` (`PL_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sf_position_pl
-- ----------------------------
INSERT INTO `sf_position_pl` VALUES ('1', '1');
INSERT INTO `sf_position_pl` VALUES ('1', '2');
INSERT INTO `sf_position_pl` VALUES ('1', '3');
INSERT INTO `sf_position_pl` VALUES ('108', '1');
INSERT INTO `sf_position_pl` VALUES ('108', '2');
INSERT INTO `sf_position_pl` VALUES ('108', '3');
INSERT INTO `sf_position_pl` VALUES ('109', '1');
INSERT INTO `sf_position_pl` VALUES ('109', '2');
INSERT INTO `sf_position_pl` VALUES ('109', '3');

-- ----------------------------
-- Table structure for `sf_property`
-- ----------------------------
DROP TABLE IF EXISTS `sf_property`;
CREATE TABLE `sf_property` (
  `PROPERTY_ID` int(11) NOT NULL COMMENT '属性ID',
  `PROPERTY_VERSION` int(11) DEFAULT '0' COMMENT '属性数据版本',
  `PROPERTY_TAB_SIZE` int(11) DEFAULT NULL COMMENT '标签数量',
  `PROPERTY_FILE_ROOT` varchar(100) DEFAULT NULL COMMENT '文件根路径',
  `PROPERTY_COPYRIGHT` varchar(50) DEFAULT NULL COMMENT '版权信息',
  `PROPERTY_APP_TITLE` varchar(50) DEFAULT NULL COMMENT '系统名称',
  PRIMARY KEY (`PROPERTY_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sf_property
-- ----------------------------
INSERT INTO `sf_property` VALUES ('0', '0', '12', '/', '青岛工业软件研究所', '企业应用开发平台V0.1');

-- ----------------------------
-- Table structure for `sf_role`
-- ----------------------------
DROP TABLE IF EXISTS `sf_role`;
CREATE TABLE `sf_role` (
  `ROLE_ID` varchar(50) NOT NULL COMMENT '角色ID',
  `ROLE_NAME` varchar(100) DEFAULT NULL COMMENT '角色名称',
  `ROLE_DESCRIPTION` varchar(500) DEFAULT NULL COMMENT '角色描述',
  `ROLE_TYPE` varchar(50) DEFAULT NULL COMMENT '角色类型',
  `ROLE_ORDER` int(11) DEFAULT '0' COMMENT '角色顺序',
  `ROLE_READ_ONLY` smallint(6) DEFAULT NULL COMMENT '角色只读数据',
  `ROLE_VERSION` int(11) DEFAULT '0' COMMENT '角色数据版本',
  `ROLE_CREATOR` varchar(50) DEFAULT NULL COMMENT '角色创建者',
  `ROLE_CREATED` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '角色创建时间',
  `ROLE_MODIFIER` varchar(50) DEFAULT NULL COMMENT '角色修改者',
  `ROLE_MODIFIED` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '角色修改时间',
  PRIMARY KEY (`ROLE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sf_role
-- ----------------------------
INSERT INTO `sf_role` VALUES ('Administrator', '管理员', null, null, '0', null, '62', 'admin', '2015-07-23 17:31:23', 'admin', '2014-05-07 14:34:46');
INSERT INTO `sf_role` VALUES ('director', '办公室主任角色', '', 'PERMISSION', '0', null, '8', 'admin', '2015-07-25 11:22:56', 'admin', '2015-07-21 00:00:00');
INSERT INTO `sf_role` VALUES ('GphUser', '业务管理角色', null, 'PERMISSION', '1', null, '27', 'admin', '2015-07-23 17:36:53', 'admin', '2014-05-07 14:34:46');
INSERT INTO `sf_role` VALUES ('SeniorManager', '高级管理角色', '', '', '100', null, '5', 'admin', '2014-12-20 11:45:45', 'admin', '2014-12-19 00:00:00');

-- ----------------------------
-- Table structure for `sf_role_function`
-- ----------------------------
DROP TABLE IF EXISTS `sf_role_function`;
CREATE TABLE `sf_role_function` (
  `ROLE_ID` varchar(50) NOT NULL COMMENT '角色ID',
  `FUNCTION_ID` varchar(50) NOT NULL COMMENT '功能ID',
  PRIMARY KEY (`ROLE_ID`,`FUNCTION_ID`),
  KEY `FK_ROLE_FUNCTION` (`ROLE_ID`),
  KEY `FK_ROLE_FUNCTION2` (`FUNCTION_ID`),
  CONSTRAINT `ROLE_FUNCTION` FOREIGN KEY (`ROLE_ID`) REFERENCES `sf_role` (`ROLE_ID`),
  CONSTRAINT `ROLE_FUNCTION2` FOREIGN KEY (`FUNCTION_ID`) REFERENCES `sf_function` (`FUNCTION_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sf_role_function
-- ----------------------------
INSERT INTO `sf_role_function` VALUES ('Administrator', 'INDEX');
INSERT INTO `sf_role_function` VALUES ('Administrator', 'ORG_CREATE');
INSERT INTO `sf_role_function` VALUES ('Administrator', 'ORG_DELETE');
INSERT INTO `sf_role_function` VALUES ('Administrator', 'ORG_DISABLE');
INSERT INTO `sf_role_function` VALUES ('Administrator', 'ORG_EDIT');
INSERT INTO `sf_role_function` VALUES ('Administrator', 'ORG_ENABLE');
INSERT INTO `sf_role_function` VALUES ('Administrator', 'ORG_LIST');
INSERT INTO `sf_role_function` VALUES ('Administrator', 'PRESSIE_CREATE');
INSERT INTO `sf_role_function` VALUES ('Administrator', 'USER_CREATE');
INSERT INTO `sf_role_function` VALUES ('Administrator', 'USER_DELETE');
INSERT INTO `sf_role_function` VALUES ('Administrator', 'USER_DISABLE');
INSERT INTO `sf_role_function` VALUES ('Administrator', 'USER_EDIT');
INSERT INTO `sf_role_function` VALUES ('Administrator', 'USER_ENABLE');
INSERT INTO `sf_role_function` VALUES ('Administrator', 'USER_LIST');
INSERT INTO `sf_role_function` VALUES ('Administrator', 'USER_ROLE');
INSERT INTO `sf_role_function` VALUES ('Administrator', 'WFDEF_CREATE');
INSERT INTO `sf_role_function` VALUES ('Administrator', 'WFDEF_UPLOAD');
INSERT INTO `sf_role_function` VALUES ('director', 'INDEX');
INSERT INTO `sf_role_function` VALUES ('GphUser', 'INDEX');
INSERT INTO `sf_role_function` VALUES ('GphUser', 'ORG_CREATE');
INSERT INTO `sf_role_function` VALUES ('GphUser', 'ORG_DELETE');
INSERT INTO `sf_role_function` VALUES ('GphUser', 'ORG_DISABLE');
INSERT INTO `sf_role_function` VALUES ('GphUser', 'ORG_EDIT');
INSERT INTO `sf_role_function` VALUES ('GphUser', 'ORG_ENABLE');
INSERT INTO `sf_role_function` VALUES ('GphUser', 'ORG_LIST');
INSERT INTO `sf_role_function` VALUES ('GphUser', 'USER_CREATE');
INSERT INTO `sf_role_function` VALUES ('GphUser', 'USER_DELETE');
INSERT INTO `sf_role_function` VALUES ('GphUser', 'USER_DISABLE');
INSERT INTO `sf_role_function` VALUES ('GphUser', 'USER_EDIT');
INSERT INTO `sf_role_function` VALUES ('GphUser', 'USER_ENABLE');
INSERT INTO `sf_role_function` VALUES ('GphUser', 'USER_LIST');
INSERT INTO `sf_role_function` VALUES ('GphUser', 'USER_ROLE');
INSERT INTO `sf_role_function` VALUES ('SeniorManager', 'ORG_CREATE');
INSERT INTO `sf_role_function` VALUES ('SeniorManager', 'ORG_DELETE');
INSERT INTO `sf_role_function` VALUES ('SeniorManager', 'ORG_DISABLE');
INSERT INTO `sf_role_function` VALUES ('SeniorManager', 'ORG_EDIT');
INSERT INTO `sf_role_function` VALUES ('SeniorManager', 'ORG_ENABLE');
INSERT INTO `sf_role_function` VALUES ('SeniorManager', 'ORG_LIST');
INSERT INTO `sf_role_function` VALUES ('SeniorManager', 'USER_CREATE');
INSERT INTO `sf_role_function` VALUES ('SeniorManager', 'USER_DELETE');
INSERT INTO `sf_role_function` VALUES ('SeniorManager', 'USER_DISABLE');
INSERT INTO `sf_role_function` VALUES ('SeniorManager', 'USER_EDIT');
INSERT INTO `sf_role_function` VALUES ('SeniorManager', 'USER_ENABLE');
INSERT INTO `sf_role_function` VALUES ('SeniorManager', 'USER_LIST');
INSERT INTO `sf_role_function` VALUES ('SeniorManager', 'USER_ROLE');

-- ----------------------------
-- Table structure for `sf_role_menu`
-- ----------------------------
DROP TABLE IF EXISTS `sf_role_menu`;
CREATE TABLE `sf_role_menu` (
  `ROLE_ID` varchar(50) NOT NULL COMMENT '角色ID',
  `MENU_ID` varchar(50) NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`ROLE_ID`,`MENU_ID`),
  KEY `FK_ROLE_MENU` (`ROLE_ID`),
  KEY `FK_ROLE_MENU2` (`MENU_ID`),
  CONSTRAINT `ROLE_MENU2` FOREIGN KEY (`MENU_ID`) REFERENCES `sf_menu` (`MENU_ID`),
  CONSTRAINT `ROLE_MENU` FOREIGN KEY (`ROLE_ID`) REFERENCES `sf_role` (`ROLE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sf_role_menu
-- ----------------------------
INSERT INTO `sf_role_menu` VALUES ('Administrator', 'CONFIG');
INSERT INTO `sf_role_menu` VALUES ('Administrator', 'FUNCTION_LIST');
INSERT INTO `sf_role_menu` VALUES ('Administrator', 'ITEM_LIST');
INSERT INTO `sf_role_menu` VALUES ('Administrator', 'MENU_LIST');
INSERT INTO `sf_role_menu` VALUES ('Administrator', 'MODULE_LIST');
INSERT INTO `sf_role_menu` VALUES ('Administrator', 'ORG_LIST');
INSERT INTO `sf_role_menu` VALUES ('Administrator', 'POSITION_LIST');
INSERT INTO `sf_role_menu` VALUES ('Administrator', 'ROLE_LIST');
INSERT INTO `sf_role_menu` VALUES ('Administrator', 'SECURITY');
INSERT INTO `sf_role_menu` VALUES ('Administrator', 'USER_LIST');
INSERT INTO `sf_role_menu` VALUES ('director', 'ATTENDANCE');
INSERT INTO `sf_role_menu` VALUES ('director', 'CARUSE');
INSERT INTO `sf_role_menu` VALUES ('director', 'CARUSE_MANAGE');
INSERT INTO `sf_role_menu` VALUES ('director', 'CAR_COUNT');
INSERT INTO `sf_role_menu` VALUES ('director', 'CAR_DISTRIBUTE');
INSERT INTO `sf_role_menu` VALUES ('director', 'CAR_EXCEPTION');
INSERT INTO `sf_role_menu` VALUES ('director', 'CAR_MANAGE');
INSERT INTO `sf_role_menu` VALUES ('director', 'CAR_USE');
INSERT INTO `sf_role_menu` VALUES ('director', 'DEPARTMENT');
INSERT INTO `sf_role_menu` VALUES ('director', 'DOCUMENT_MANAGE');
INSERT INTO `sf_role_menu` VALUES ('director', 'FINANCIAL_AUDIT');
INSERT INTO `sf_role_menu` VALUES ('director', 'LIBRARY');
INSERT INTO `sf_role_menu` VALUES ('director', 'LIBRARY_MANAGE');
INSERT INTO `sf_role_menu` VALUES ('director', 'MEETING_MANAGE');
INSERT INTO `sf_role_menu` VALUES ('director', 'MONTH_STATISTICS');
INSERT INTO `sf_role_menu` VALUES ('director', 'NEWS');
INSERT INTO `sf_role_menu` VALUES ('director', 'NEWS_MANAGE');
INSERT INTO `sf_role_menu` VALUES ('director', 'PERSONALWORK');
INSERT INTO `sf_role_menu` VALUES ('director', 'PERSONAL_ARCHIVE');
INSERT INTO `sf_role_menu` VALUES ('director', 'PERSONAL_MANAGE_VIEW');
INSERT INTO `sf_role_menu` VALUES ('director', 'PERSONAL_MONTH_AUDIT');
INSERT INTO `sf_role_menu` VALUES ('director', 'PERSONAL_YEAR_AUDIT');
INSERT INTO `sf_role_menu` VALUES ('director', 'ROLLROME_MANAGE');
INSERT INTO `sf_role_menu` VALUES ('director', 'ROLL_MANAGE');
INSERT INTO `sf_role_menu` VALUES ('director', 'SCHEDULE_MANAGE');
INSERT INTO `sf_role_menu` VALUES ('director', 'SURVEY_MANAGE');
INSERT INTO `sf_role_menu` VALUES ('director', 'TASK_STATISTICS');
INSERT INTO `sf_role_menu` VALUES ('director', 'TODAY_STATISTICS');
INSERT INTO `sf_role_menu` VALUES ('director', 'TODAY_TASK');
INSERT INTO `sf_role_menu` VALUES ('director', 'USERMANAGE');
INSERT INTO `sf_role_menu` VALUES ('director', 'YEAR_STATISTICS');
INSERT INTO `sf_role_menu` VALUES ('GphUser', 'FUNCTION_LIST');
INSERT INTO `sf_role_menu` VALUES ('GphUser', 'LIBRARY');
INSERT INTO `sf_role_menu` VALUES ('GphUser', 'LIBRARY_MANAGE');
INSERT INTO `sf_role_menu` VALUES ('GphUser', 'MENU_LIST');
INSERT INTO `sf_role_menu` VALUES ('GphUser', 'MODULE_LIST');
INSERT INTO `sf_role_menu` VALUES ('GphUser', 'NEWS');
INSERT INTO `sf_role_menu` VALUES ('GphUser', 'NEWS_MANAGE');
INSERT INTO `sf_role_menu` VALUES ('GphUser', 'ORG_LIST');
INSERT INTO `sf_role_menu` VALUES ('GphUser', 'POSITION_LIST');
INSERT INTO `sf_role_menu` VALUES ('GphUser', 'ROLE_LIST');
INSERT INTO `sf_role_menu` VALUES ('GphUser', 'SECURITY');
INSERT INTO `sf_role_menu` VALUES ('GphUser', 'USER_LIST');

-- ----------------------------
-- Table structure for `sf_role_permission`
-- ----------------------------
DROP TABLE IF EXISTS `sf_role_permission`;
CREATE TABLE `sf_role_permission` (
  `ROLE_ID` varchar(50) NOT NULL COMMENT '角色ID',
  `PERMISSION_ID` varchar(50) NOT NULL COMMENT '权限ID',
  PRIMARY KEY (`ROLE_ID`,`PERMISSION_ID`),
  KEY `FK_ROLE_PERMISSION` (`ROLE_ID`),
  KEY `FK_ROLE_PERMISSION2` (`PERMISSION_ID`),
  CONSTRAINT `ROLE_PERMISSION` FOREIGN KEY (`ROLE_ID`) REFERENCES `sf_role` (`ROLE_ID`),
  CONSTRAINT `ROLE_PERMISSION2` FOREIGN KEY (`PERMISSION_ID`) REFERENCES `sf_permission` (`PERMISSION_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sf_role_permission
-- ----------------------------

-- ----------------------------
-- Table structure for `sf_role_position`
-- ----------------------------
DROP TABLE IF EXISTS `sf_role_position`;
CREATE TABLE `sf_role_position` (
  `ROLE_ID` varchar(50) NOT NULL COMMENT '角色ID',
  `POSITION_ID` varchar(50) NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`ROLE_ID`,`POSITION_ID`),
  KEY `FK_ROLE_POSITION` (`ROLE_ID`),
  KEY `FK_ROLE_POSITION2` (`POSITION_ID`),
  CONSTRAINT `ROLE_POSITION` FOREIGN KEY (`ROLE_ID`) REFERENCES `sf_role` (`ROLE_ID`),
  CONSTRAINT `ROLE_POSITION2` FOREIGN KEY (`POSITION_ID`) REFERENCES `sf_position` (`POSITION_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sf_role_position
-- ----------------------------
INSERT INTO `sf_role_position` VALUES ('Administrator', '1');
INSERT INTO `sf_role_position` VALUES ('director', '110');
INSERT INTO `sf_role_position` VALUES ('GphUser', '102');
INSERT INTO `sf_role_position` VALUES ('SeniorManager', '109');

-- ----------------------------
-- Table structure for `sf_role_user`
-- ----------------------------
DROP TABLE IF EXISTS `sf_role_user`;
CREATE TABLE `sf_role_user` (
  `USER_ID` varchar(50) NOT NULL COMMENT '用户ID',
  `ROLE_ID` varchar(50) NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`USER_ID`,`ROLE_ID`),
  KEY `FK_ROLE_USER` (`USER_ID`),
  KEY `FK_ROLE_USER2` (`ROLE_ID`),
  CONSTRAINT `ROLE_USER` FOREIGN KEY (`USER_ID`) REFERENCES `sf_user` (`USER_ID`),
  CONSTRAINT `ROLE_USER2` FOREIGN KEY (`ROLE_ID`) REFERENCES `sf_role` (`ROLE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sf_role_user
-- ----------------------------
INSERT INTO `sf_role_user` VALUES ('aaa', 'director');
INSERT INTO `sf_role_user` VALUES ('admin', 'Administrator');
INSERT INTO `sf_role_user` VALUES ('guopeihui', 'Administrator');
INSERT INTO `sf_role_user` VALUES ('test', 'Administrator');
INSERT INTO `sf_role_user` VALUES ('TEST2', 'Administrator');
INSERT INTO `sf_role_user` VALUES ('test5', 'SeniorManager');
INSERT INTO `sf_role_user` VALUES ('test6', 'GphUser');
INSERT INTO `sf_role_user` VALUES ('user', 'GphUser');
INSERT INTO `sf_role_user` VALUES ('zg', 'Administrator');

-- ----------------------------
-- Table structure for `sf_sequences`
-- ----------------------------
DROP TABLE IF EXISTS `sf_sequences`;
CREATE TABLE `sf_sequences` (
  `SEQUENCE_NAME` varchar(100) NOT NULL COMMENT '主键名称',
  `NEXT_VAL` int(11) DEFAULT NULL COMMENT '下个数值',
  PRIMARY KEY (`SEQUENCE_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sf_sequences
-- ----------------------------
INSERT INTO `sf_sequences` VALUES ('PORTLET_LOCATION', '54');
INSERT INTO `sf_sequences` VALUES ('POSITION', '111');
INSERT INTO `sf_sequences` VALUES ('SUBITEM', '509');

-- ----------------------------
-- Table structure for `sf_sub_item`
-- ----------------------------
DROP TABLE IF EXISTS `sf_sub_item`;
CREATE TABLE `sf_sub_item` (
  `SUB_ITEM_ID` varchar(50) NOT NULL COMMENT '数据子项ID',
  `ITEM_ID` varchar(50) DEFAULT NULL COMMENT '数据主项ID',
  `SUB_ITEM_NAME` varchar(100) DEFAULT NULL COMMENT '数据子项名称',
  `SUB_ITEM_VALUE` varchar(100) DEFAULT NULL COMMENT '数据子项值',
  `SUB_ITEM_CASCADE` smallint(6) DEFAULT NULL COMMENT '级联字典',
  `SUB_ITEM_DESCRIPTION` varchar(500) DEFAULT NULL COMMENT '数据子项描述',
  `SUB_ITEM_ORDER` int(11) DEFAULT '0' COMMENT '数据子项顺序',
  `SUB_ITEM_CREATOR` varchar(50) DEFAULT NULL COMMENT '数据子项创建者',
  `SUB_ITEM_CREATED` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '数据子项创建时间',
  `SUB_ITEM_MODIFIER` varchar(50) DEFAULT NULL COMMENT '数据子项修改者',
  `SUB_ITEM_MODIFIED` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '数据子项修改时间',
  `SUB_ITEM_VERSION` int(11) DEFAULT '0' COMMENT '数据子项数据版本',
  PRIMARY KEY (`SUB_ITEM_ID`),
  KEY `FK_ITEM_SUBITEM` (`ITEM_ID`),
  CONSTRAINT `ITEM_SUBITEM` FOREIGN KEY (`ITEM_ID`) REFERENCES `sf_item` (`ITEM_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sf_sub_item
-- ----------------------------
INSERT INTO `sf_sub_item` VALUES ('101', 'ORG_PROPERTY', '自定义属性1', '1', '0', null, '0', 'admin', '2014-05-07 14:34:46', 'admin', '2014-05-07 14:34:46', '0');
INSERT INTO `sf_sub_item` VALUES ('102', 'ORG_PROPERTY', '自定义属性2', '2', '0', null, '1', 'admin', '2014-05-07 14:34:46', 'admin', '2014-05-07 14:34:46', '0');
INSERT INTO `sf_sub_item` VALUES ('103', 'ORG_CATEGORY', '自定义类型1', '1', '0', null, '0', 'admin', '2014-05-07 14:34:46', 'admin', '2014-05-07 14:34:46', '0');
INSERT INTO `sf_sub_item` VALUES ('104', 'ORG_CATEGORY', '自定义类型2', '2', '0', null, '1', 'admin', '2014-05-07 14:34:46', 'admin', '2014-05-07 14:34:46', '0');
INSERT INTO `sf_sub_item` VALUES ('201', 'USER_GENDER', '男', 'M', '0', null, '0', 'admin', '2014-05-07 14:34:46', 'admin', '2014-05-07 14:34:46', '0');
INSERT INTO `sf_sub_item` VALUES ('202', 'USER_GENDER', '女', 'F', '0', null, '1', 'admin', '2014-05-07 14:34:46', 'admin', '2014-05-07 14:34:46', '0');
INSERT INTO `sf_sub_item` VALUES ('301', 'PERMISSION_TYPE', '用户权限', 'PERMISSION_TYPE_USER', '1', null, '1', 'admin', '2014-05-07 14:34:46', 'admin', '2014-05-07 14:34:46', '0');
INSERT INTO `sf_sub_item` VALUES ('302', 'PERMISSION_TYPE', '机构权限', 'PERMISSION_TYPE_ORG', '1', null, '2', 'admin', '2014-05-07 14:34:46', 'admin', '2014-05-07 14:34:46', '0');
INSERT INTO `sf_sub_item` VALUES ('303', 'PERMISSION_TYPE', '字典权限', 'PERMISSION_TYPE_ITEM', '0', null, '3', 'admin', '2014-05-07 14:34:46', 'admin', '2014-05-07 14:34:46', '0');
INSERT INTO `sf_sub_item` VALUES ('304', 'PERMISSION_TYPE', '数值权限', 'PERMISSION_TYPE_CONSTANT', '0', null, '4', 'admin', '2014-05-07 14:34:46', 'admin', '2014-05-07 14:34:46', '0');
INSERT INTO `sf_sub_item` VALUES ('311', 'PERMISSION_TYPE_USER', '登录用户', '1', '0', null, '1', 'admin', '2014-05-07 14:34:46', 'admin', '2014-05-07 14:34:46', '0');
INSERT INTO `sf_sub_item` VALUES ('312', 'PERMISSION_TYPE_USER', '指定用户', '2', '0', null, '2', 'admin', '2014-05-07 14:34:46', 'admin', '2014-05-07 14:34:46', '0');
INSERT INTO `sf_sub_item` VALUES ('321', 'PERMISSION_TYPE_ORG', '登录用户所属机构', '1', '0', null, '1', 'admin', '2014-05-07 14:34:46', 'admin', '2014-05-07 14:34:46', '0');
INSERT INTO `sf_sub_item` VALUES ('322', 'PERMISSION_TYPE_ORG', '登录用户所属及其下级机构', '2', '0', null, '2', 'admin', '2014-05-07 14:34:46', 'admin', '2014-05-07 14:34:46', '0');
INSERT INTO `sf_sub_item` VALUES ('323', 'PERMISSION_TYPE_ORG', '登录用户所属及其上级机构', '3', '0', null, '3', 'admin', '2014-05-07 14:34:46', 'admin', '2014-05-07 14:34:46', '0');
INSERT INTO `sf_sub_item` VALUES ('324', 'PERMISSION_TYPE_ORG', '指定机构', '4', '0', null, '4', 'admin', '2014-05-07 14:34:46', 'admin', '2014-05-07 14:34:46', '0');
INSERT INTO `sf_sub_item` VALUES ('331', 'ROLE_TYPE', '普通权限角色', 'PERMISSION', '0', null, '0', 'admin', '2014-05-07 14:34:46', 'admin', '2014-05-07 14:34:46', '0');
INSERT INTO `sf_sub_item` VALUES ('332', 'ROLE_TYPE', '优先权限角色', 'PRIORITY', '0', null, '1', 'admin', '2014-05-07 14:34:46', 'admin', '2014-05-07 14:34:46', '0');
INSERT INTO `sf_sub_item` VALUES ('333', 'ROLE_TYPE', '禁止权限角色', 'FORBIDDEN', '0', null, '2', 'admin', '2014-05-07 14:34:46', 'admin', '2014-05-07 14:34:46', '0');
INSERT INTO `sf_sub_item` VALUES ('401', 'POSITION_TYPE', '全局', '0', '0', null, '0', 'admin', '2014-05-07 14:34:46', 'admin', '2014-05-07 14:34:46', '0');
INSERT INTO `sf_sub_item` VALUES ('402', 'POSITION_TYPE', '指定机构', '1', '0', null, '1', 'admin', '2014-05-07 14:34:46', 'admin', '2014-05-07 14:34:46', '0');
INSERT INTO `sf_sub_item` VALUES ('403', 'POSITION_TYPE', '指定级别', '2', '0', null, '2', 'admin', '2014-05-07 14:34:46', 'admin', '2014-05-07 14:34:46', '0');
INSERT INTO `sf_sub_item` VALUES ('504', 'GROUP', 'GROUP1', 'GROUP1', '0', null, '1', 'admin', '2014-07-24 00:00:00', 'admin', '2014-07-24 00:00:00', '0');
INSERT INTO `sf_sub_item` VALUES ('505', 'GROUP', 'GROUP2', 'GROUP2', '0', null, '2', 'admin', '2014-07-24 00:00:00', 'admin', '2014-07-24 00:00:00', '0');
INSERT INTO `sf_sub_item` VALUES ('506', 'GROUP', 'GROUP3', 'GROUP3', '0', null, '3', 'admin', '2014-07-24 00:00:00', 'admin', '2014-07-24 00:00:00', '0');
INSERT INTO `sf_sub_item` VALUES ('507', 'SPZT', '通过', '1', '0', null, '1', 'admin', '2014-09-07 00:00:00', 'admin', '2014-09-07 00:00:00', '0');
INSERT INTO `sf_sub_item` VALUES ('508', 'SPZT', '不通过', '2', '0', null, '2', 'admin', '2014-09-07 00:00:00', 'admin', '2014-09-07 00:00:00', '0');
INSERT INTO `sf_sub_item` VALUES ('901', 'COMMON_YESNO', '是', 'true', '0', null, '0', 'admin', '2014-12-16 12:50:03', 'admin', '2014-05-07 14:34:46', '0');
INSERT INTO `sf_sub_item` VALUES ('902', 'COMMON_YESNO', '否', 'false', '0', null, '1', 'admin', '2014-12-16 12:50:06', 'admin', '2014-05-07 14:34:46', '0');

-- ----------------------------
-- Table structure for `sf_user`
-- ----------------------------
DROP TABLE IF EXISTS `sf_user`;
CREATE TABLE `sf_user` (
  `USER_ID` varchar(50) NOT NULL COMMENT '用户ID',
  `POSITION_ID` varchar(50) DEFAULT NULL COMMENT '岗位ID',
  `ORG_ID` varchar(50) DEFAULT NULL COMMENT '机构ID',
  `USER_NAME` varchar(100) DEFAULT NULL COMMENT '用户姓名',
  `USER_PASSWORD` varchar(100) DEFAULT NULL COMMENT '用户密码',
  `USER_ID_NO` varchar(50) DEFAULT NULL COMMENT '用户身份证号',
  `USER_GENDER` varchar(1) DEFAULT NULL COMMENT '用户性别',
  `USER_EMAIL` varchar(100) DEFAULT NULL COMMENT '用户邮件地址',
  `USER_BIRTHDAY` date DEFAULT NULL COMMENT '用户生日',
  `USER_ADDRESS` varchar(500) DEFAULT NULL COMMENT '用户地址',
  `USER_POST` varchar(50) DEFAULT NULL COMMENT '用户邮编',
  `USER_TEL` varchar(50) DEFAULT NULL COMMENT '用户电话',
  `USER_MOBILE` varchar(50) DEFAULT NULL COMMENT '用户手机',
  `USER_DESCRIPTION` varchar(500) DEFAULT NULL COMMENT '用户描述',
  `USER_ENABLED` smallint(6) DEFAULT NULL COMMENT '帐户已启用',
  `USER_LOCKED` smallint(6) DEFAULT NULL COMMENT '锁定标志',
  `USER_ACCOUNT_NONEXPIRED` smallint(6) DEFAULT NULL COMMENT '帐户未过期',
  `USER_ACCOUNT_NONLOCKED` smallint(6) DEFAULT NULL COMMENT '帐户未锁定',
  `USER_CREDENTIALS_NONEXPIRED` smallint(6) DEFAULT NULL COMMENT '凭证未过期',
  `USER_ORDER` int(11) DEFAULT '0' COMMENT '用户顺序',
  `USER_VERSION` int(11) DEFAULT '0' COMMENT '用户数据版本',
  `USER_CREATOR` varchar(50) DEFAULT NULL COMMENT '用户创建者',
  `USER_CREATED` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '用户创建时间',
  `USER_MODIFIER` varchar(50) DEFAULT NULL COMMENT '用户修改者',
  `USER_MODIFIED` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '用户修改时间',
  `USER_EXT` blob COMMENT '人员头像',
  PRIMARY KEY (`USER_ID`),
  KEY `FK_USER_ORG` (`ORG_ID`),
  KEY `FK_POSITION_USER` (`POSITION_ID`),
  CONSTRAINT `POSITION_USER` FOREIGN KEY (`POSITION_ID`) REFERENCES `sf_position` (`POSITION_ID`),
  CONSTRAINT `USER_ORG` FOREIGN KEY (`ORG_ID`) REFERENCES `sf_org` (`ORG_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sf_user
-- ----------------------------
INSERT INTO `sf_user` VALUES ('aaa', '110', '1005', 'aaa', '21232f297a57a5a743894a0e4a801fc3', '23', 'M', '11@qq.com', '2015-07-02', '312', '123123', '123123', '13113213121', '', '1', null, '1', '1', '1', '0', '2', 'admin', '2015-07-29 10:18:40', 'admin', '2015-07-29 00:00:00', 0xFFD8FFE000104A46494600010200000100010000FFDB004300080606070605080707070909080A0C140D0C0B0B0C1912130F141D1A1F1E1D1A1C1C20242E2720222C231C1C2837292C30313434341F27393D38323C2E333432FFDB0043010909090C0B0C180D0D1832211C213232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232FFC000110800C9009603012200021101031101FFC4001F0000010501010101010100000000000000000102030405060708090A0BFFC400B5100002010303020403050504040000017D01020300041105122131410613516107227114328191A1082342B1C11552D1F02433627282090A161718191A25262728292A3435363738393A434445464748494A535455565758595A636465666768696A737475767778797A838485868788898A92939495969798999AA2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE1E2E3E4E5E6E7E8E9EAF1F2F3F4F5F6F7F8F9FAFFC4001F0100030101010101010101010000000000000102030405060708090A0BFFC400B51100020102040403040705040400010277000102031104052131061241510761711322328108144291A1B1C109233352F0156272D10A162434E125F11718191A262728292A35363738393A434445464748494A535455565758595A636465666768696A737475767778797A82838485868788898A92939495969798999AA2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE2E3E4E5E6E7E8E9EAF2F3F4F5F6F7F8F9FAFFDA000C03010002110311003F00784C538254C16942D6C49104EF4FC549B29C1290C8B068EF5215A4C6392714C0695E7A53F6051C9C7D6B3EEB5DB1B3491E57DC2319609CD43A9EB6F6BE08B1D4879265BE2ED1C8472A33C2FB1C54DEC343AFBC43A3E9B214BABF8D1FFBA3935562F18E81336D4D4A307FDB056BC8F53D426BCB86797E624F5359FB96A5CC2C7D0105E5BDD2EE866475EB956CD4E4578158DFDDE9F3ACD69332329CF07835E8FA57C40B49ED33768D1CC8BCE3A35529203B4DB462A1B0BD8750B55B885F72B55A22AB7111629852A5229BCD00C81969A56AC9424530A502228B873F4A2A48D30E7E9452196F65382D3C2D3C2D3191EDA31526DA36E681104CE91465DCE145731AFF0088163B364851C971FEB1472BEF5B1AC4D9416CA15B3FEB41E30A6B16EF45DB061509523A67AFF9F4ACA73B685C21CC73BA3FD9DD2E277628E1B77CDF316FC0D57D47C542F34B3A64D66160192117E5DADEA2B596D63B07558D1491F7BE5EA7BD4E3488AEE4674B653BBEF1DBD7DAB1752DB9B2A3CDB1E54EADB8E0E71DA84524E0F4AEFAFBC230C6FBC9283AF0334DB5F0979A46CDC47A95A3DB445F5799C508F68E99534F8E172DC641F5AF4493C188B0FDDE7DB8AACBA3C165130923594F638A9F6C8AFAB35B9CC596A9A8680C4C33C91EF3968F3F2B57A7F86B5B4D674C8E6674F37A3A2FF09AF34D5C8965D8D8C0FBA7155745D565D17538E6591962271263D2B7A73B98CE16763DC7146DE299693A5CDBA4D11CA48BB94D4E47A56D7332065A6ED3536DCD215A008E31F3FE1454918F9BF0A29302D85A7E2971ED4E0B4C63314D23E535631ED55EF9D61B39A52768543923B526EC80E1EF2549F5D72F70D2246DC26EE17039ADA97568CC03601C7DCFF1AF3E8E41148E55C95772724FF0E6B534B926D42F822E4A2FBD70CA776D9DB4E1A58E86CAC7EDC448EBF28E40AE862B0250286DA07A51670AC312AA8C715AB6C8188AC5BBB3B22B9514174789F05D371F7AB02C1178095B31C400A788945350B8B9D23024B15390571587AAE944C4E5076E2BB996253DAB36EA15208C526AC352BEE78A6B7A53C077918C8FD6B9ABD4062CE00F6AF5EF126922E2D9F60C1EBD2BC8EF91A195E271823822B6A5238F130B6A775F0E75B92681B4E9F7109CC4C7A11DC57A0F4AF1DF016A7F65D645ABE5A398E547F75BD6BD936FCA315DB1D8E1198A42B914FC525500D8D70DD7B515227DEFC28A9605B0B8A785C1A5029C0550C4039AC7F14023C3F78010A7CB6E73ED5BA16B9CF1A6F1A04D1A7DF7F9454CB61ADCF1B92E311F53D2BB1F042EEB7798F563FA579E5D48C1BCBEFD0D7ABF846C9ADF4B8D0FDE6009AE09AB23BA8BBC8EBAD972A2B52D8006B9C975131111C48588A960F10946025B593EAA2A63066FCF73B04031D69769F5ACAB1D5A3B8E1720FF00B42B53CCF9371AD091587154671D6A2BBD4D20C92ACDF4158B36B37D331F26C9F6FAF5A4E371A762E5CC2AE8C0F208AF17F1DE9DF61D484AA3E493F9D7AD25FDCA6D4BA84AE4E03E2B91F88563F69D09EE00F9A16DDC7A54C572C88ABEFC19C17830B7FC249110B950AD9FCABDC6D9FCCB589FBED15E2DE05D3DEF757664E04699CD7B3D8A3259C4AE30C0722BBE27984D8A6E2A5C5211C558C620F9B8F4A29CAB863452605D0334F0314BB69C05301DC5737E30E74F85429277EEC0EF81FF00D7AE931EB58DE27819F4BF3D39681B7E3DB14A5B0D6E7CF8F1B0D6442EA7226C1CFD6BDC748B7F22C11DC751C0AF39F10D8887C55A7CAE9F2CAD1E4818EFCD7B88D29058AA63E50BC570D6DD1D98756B9C9DE6BB67A580D31550DD06324D456BE38D0AE6736B3A4F0CC1B6E648B001F43572FF00C2B6F717D1DD0E2688E518AE40FC2B361F01C116BFFDACF33B3F9BE6F94BF737FAD285BA9ACF9D5B94E963F241592120AB7208AD745636FBB9C5664165E440C00C027200180BF4AD78CE6C48F6A499A330EEEEA180B3CB8C2D738BF10ADEE6E12D2C34D9E67666556042EE2BD702BABBBD34DC6D74E36F6C560DAF8274DB3D51B5081248AE4EE2086C8527AE076A71E5EA44F9BEC93693AFC1ACA32A2323A1C3C722E194FB8ACEF1946ABE1CBEC8E3CA35D3D868D6F65B8C51FCCDCB31E49AC0F1BA83A2CF11380E36FEB5175729A6E366727F0CAC2336925CA0C33611FF003AF4AD836F4AC2F0CE951E9B648B160AEC009F5FF39AE882FCA3D6BD086C796D34ECC84AD308AB06A32335621883E6A295386A2A581A0169C173522A714BB71540302D57D462F374E9E3C7DE4239ABB8F6A4640EA54F43C1A181E6FE2ED23ED46CFCB2AB24419C1C6738E40AF4BB7BA12E956930E9242ADFA5624D626E2D5E1603CD8D4AAE6ACD88921F0FD9C52021E252841F635C1522D48EEA335249752EAA891AA5FB3803359F6F7383571EF1444695ADA9D3620BC95530952DA966B56F4AC49EE63FB5CCD7332C4100C163815AB69A9D98B238990A63EF6E18A84F5134D16EDDC3707F2A9FC84CEEAC48EF2DEE31259CE937CD83E5B66B420BADC30C79A7CC162CCA142F15C3F8AD7ED2160C677367F2AEBEE2E00438AF2BF1FEB77161B56DD3E79832F99FDC1DFF003A231BBB22272518DD9DB685FBCB0473CE73DAB576D50F0FC4468966D9CE62539F5E2B4F15E8455958F364EEEE57295191561B8351119A622250371A29E17E6A280352940CD00548A29809B294253F14E02802A9B7FDE971CEEEA0D457CBB6D08E000D9AD0C71556F23F3ADA443C7CBC1F7ACAA46F1D0D29CF9648C040C18ED347DA764816438A6DABE72ADC3A9C303D8D4D79A6DB5FC5B6553B5873B5B6D79E7AA4777636BA8A8F3141A86DFC3B6D18001CA1FE0ED5CFB58DCE9F76D0ADF4ED10FB91BBFF00ECD5B30C4E1902B6A7B08F9D460F3F5AB5029C5DAE6D5A595AD8061044A80F751C1A8F7665DC9D2B9A7B7BC9EF04697D711425B1E5AB7CC7EA7B574D67630D8C2123DD8FF69B71FCE9344DACC7CFCC79AE7AFF00C2C35E81CCABF29FF56C3A835B93C8D3BADBC432EE71F415B7142B146A89D146056D423AB6716265A72942C2D85B59451018DA8062A675E3A55A2800E951915D88E32A1151B2D5B2951327B502B95954EEA2A755F9A8A065E02A45149B7029CA39A60382D382D28A701400CC5023DE40A9B6D733E37F142784B406BCD824B990EC8633D0B7A9F6152C04F13598B29D2F6204171FBC03A1F7AAD6378B3A0C3564E817B79AC780ECAFAFE669AE2E2495D99FBFCDC7E155CC53DA4C26B7639EA57D6BCB9CBDF67A94AFC88E86FB4A4BF8C67861D0D678D23508FE459CEDFF007AB534FD5E09A201DB63F706B4C491919C822AA3A9AA9496C6458695F66F9E43B9FB9A9EEAE12DE3CB1A96F350B7B6425D813D9075358E904F7D3F9F7030BD553D2A5B25B6DDD9A9E1F89A7B89EED8F18DA01ED5BCCB8E315E21E34D6756F0DF892CAF74DBB9615C1CA06F91B1EA2BD7BC39AFDAF89F43B7D4AD7F8D76CB1FFCF37FE25AEFA5F0267995AFED1DCBBB72699B6AC6D151B0C56A6640CBDE98578A988A61A622109CD152114526C0B34F51415A728A631C054805222935623849A180B1C79ED5E2DF1B673712436F130648319C766EF5EA7ADF8821D391ADA0901BA3C33768C7F8D789F8CE749EE268432B7BE7A9A5AD89BEA769E1DB843E18D3EC963DA96F084EBD7FCE6AE88B3D7A561F846513E8B6F2A1C82BB5C7A30E0D74F1C3B85794D3BBB9EBC5AE55628BD8A3FF00067DFBD4434E98F093CAABE9BAB7A2B6E07156A3B451DA93455CC8D3F468D1BCC6CB3FAB735A8F088D4FB55E58760A8E55F94D34AC2B9E2DF1536892C463E6DED83ED8A4F847E22FEC9F111D2A79316BA87CA33D124FE13F8F4AB5F16612A74E971F2EF75AF38819E299258988646DC0FA1AEEA2BDC47998976AACFAE5A22BD6A274F6AC9F05F8BEC7C5FA3A3C6C12FA04517301EA1BFBC3D54D6F4898ADD2334EFB1476D30AD4EC39A6114C642060D14FC5152D81642E7B54C9096ED5049A9E95696EF3CFA85AA469F78F9CA71F80AE4358F8A36F6E1A3D1AC5AE5FFE7B5C7C918FC3EF1AA15CEF446B1465E465545E4B31C015C3F88FC7D1C521B1D2A4018FCA6E07FECBE95E71AC789758D79F76A7A8C9245FC36D0FEEE3FC8726B2EED8B3452A0FE1FCB14244B66FCD78F7568DBA56322BB6E19FE2CF7AE235D422EBF764FDDC9F735B4973E56A532A7314C04AA0F7AA17CD03DE0F3E3C2E09C6EC1A6C866F7C33D6512F9F4BB83B56E398FDA41FE35EB11C5B480457CF2C1ACAEC496EEC92290C8DE87B57BFF87B538F5DD0ACF501F7A44FDE01D9C7DE1F9D715785BDE3D0C254BA7135A14C6335600149147D3B54E22AE73B085B3E950386356A45C74AACFC67D28B12DB3C9FE2FF001069899E4C8E7F4AF3041FBBF435DE7C55D492FBC456F6B11056D62F9FFDE6FF0022B875CAA81D3DEBBE92B451E5E21DE6CB5A26B57FA06AA9A869B37933467AE3861E8C3B8AF6FF000D7C5CD1B57B7F2B5B2BA75D8E378C98E4FA7A578174F6A8CF31E0D6A60A4D1F59DA5F69FAA217D3EF21B951D7CB6048FC29CF1E2BE50B4D5EFB4E9926B4B9920963380F1B9538AF41D0BE316AB66447A9C7FDA319C7270AEBF881CFE35268A5DCF6AC73D28AE6B48F887E1DD5E2DED726D24032D1DC0C1FCC7068A455D1E2497FFD9F3DC45B7E676DE1BBFD2897547953E6386EFEF580D39958B38F9BAD4B1BE7835A191A7FDAADB7EE8E288F55793E5200C0F979EB596C70DD3149D4F070DED405CD9B7B869B62B365E338C8F4AD21A6A5F594B2DC4F1DB2C3FF002D9FD4F6F735CD5BDC18668DF90BF75C7A55CB9BA92E23F299CEC4C9551D28B8135D698D6F60666BC8674DC15361F99BDEBD2FE0D5DFDAF4ED46C19BE682512A8FF65B83FA8AF1D5678A754C9653DABD13E105D7D97C70D6FBBE5BAB665FC460FF008D63557344DA84B96699EEA90FCA0814EDBD6A43C52039AE4B5CF4AE4061DCD9E2AA6A0A96B6735C3B612342CC7D85691E2B8BF89FA9B58F82EF151B0D30F2F23DCE29A892E6D2B9F3F6A174FA86A573772365E590BE4FD6A273F2F3C8EF51C6F9765F414F76C8C237D735DD1491E536DB6D9148FB72DDCF414E4F53D874A89FE67E4E427F3A9D5B118E064F3EF4C92949C3B77E695194F0D85A6B64B1C75C9A4DDFDEA928D2B0893CE631BE46DFE21EF4543A7BB2CCC14951B7FC28A2E05627E6E3A54B1B638F7A881F5A419CD3B88B8467A740680D8C66A289CBB6D271C7E75291B48E847B55262B0D9393BBBF420510DC01F21FD7D2A4D85C119F719A8278F3F3282ADE87A1A4D0C96E0E63E9874E57DC574FF0F3508ACBC6FA4DD48D88DA5311F6DCB81FAD7251CA2440B9F9D7A52D9CCD6F72154957DC191876239A865C74773EC166C1EF8A66727835CEF827C59078AF4159FE55BE87097318ECDFDE1EC6BA25423A715C8D5B467A509292BA0635E61F19AE445E1EB580B7CD34E063D8735EA3B6BC0FE2D6BA2FFC502C6320C3A7A6D3EF21FBDFD055415E4456972C19E791E4991FA76A7640519A68C8C2F73F31A6B49B40C76E16BB11E68A7EF055E71D48A914E00CF1EFE944685555BBFA52B67631F6F5A00A2D93F377CD20F9BEB4A0E290E0722A4A2D5937EFC8CFF0FF008514DB0199D88FEEFF00514522910939E94EC718F7A653BF8CD1722C3836C90301D2ACAB090ED183B8678F5AA8D52C1FF2CFFDEAA4162EC239C939F5A8E79BCD25012B8EA4D28FB8F55E1FB8D5571588658B605962C8F5A5245C01227138EA3D6A55FB95522FF8F95FAD432D1D6782FC54FE18F11417E3735BBAEC9A35E372F7FF001AFA4F4CD4ECF58D3E3BFB0B8492DE4E8C0F43E87D0FB57C907FF6A575BA3FFC8BFF00F6F3FF00B2D6538A66D4A6E3B1F43EBBAB5BE87A1DCEA53C88238909E0E727B0AF956F2E9EF6FE7BA98EE79242E727B935B9AA7FC8053FEBB572EDF7569D35CA4D69393D4733163B13AF734F30EDDAF8247A66A287EFFF00C0AACCBFFB3568623830DBC13C54770D8802F1B8F5A6C5FC7F5A2E3F8698AC551C9C50C33C74EF4529ED52593581FDF363FBA7F98A29961FEB9BE87FA514058FFFD9);
INSERT INTO `sf_user` VALUES ('admin', '1', '1000', '超级管理员', '21232f297a57a5a743894a0e4a801fc3', null, null, null, null, null, null, null, null, null, '1', null, '1', '1', '1', '0', '0', null, '2015-07-28 15:04:33', null, '0000-00-00 00:00:00', 0xFF3F3F);
INSERT INTO `sf_user` VALUES ('guopeihui', '1', '1005', '郭培辉', '21232f297a57a5a743894a0e4a801fc3', '370784198502032818', 'M', 'peihui@qd.iscas.ac.cn', '1985-02-03', '青岛', '100080', '12345678', '13811396986', '', '1', null, '1', '1', '1', '1', '2', 'admin', '2015-07-29 10:20:18', 'admin', '2015-07-29 00:00:00', 0xFFD8FFE000104A46494600010200000100010000FFDB004300080606070605080707070909080A0C140D0C0B0B0C1912130F141D1A1F1E1D1A1C1C20242E2720222C231C1C2837292C30313434341F27393D38323C2E333432FFDB0043010909090C0B0C180D0D1832211C213232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232FFC000110800C8009603012200021101031101FFC4001F0000010501010101010100000000000000000102030405060708090A0BFFC400B5100002010303020403050504040000017D01020300041105122131410613516107227114328191A1082342B1C11552D1F02433627282090A161718191A25262728292A3435363738393A434445464748494A535455565758595A636465666768696A737475767778797A838485868788898A92939495969798999AA2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE1E2E3E4E5E6E7E8E9EAF1F2F3F4F5F6F7F8F9FAFFC4001F0100030101010101010101010000000000000102030405060708090A0BFFC400B51100020102040403040705040400010277000102031104052131061241510761711322328108144291A1B1C109233352F0156272D10A162434E125F11718191A262728292A35363738393A434445464748494A535455565758595A636465666768696A737475767778797A82838485868788898A92939495969798999AA2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE2E3E4E5E6E7E8E9EAF2F3F4F5F6F7F8F9FAFFDA000C03010002110311003F00F7FA28A2800A28A2800A28AA77FA959E9768F757B7090C29D59CD005CA4CD795F88FE39E85A5298F4D825BFB8ED9FDDA0FA9EBFA570ADF1CBC4BA8CB8486CEC613DD10B63F134AE07D1DB80A370F5AF998FC47D5A7BA68D3519E524FFAC66FE4BD00AEBB48F885A95946C3C89AFA56E81DF007D28B81ED94579B5B7C5286340352B668643FC0BD07D4D5D5F89760AF9913F77EA87245303BCA2B3748D6EC75BB51716338913B8EE3F0AD2A0028A28A0028A28A0082E9FCB881F7A2997FFEA17FDEFE868A00B54514500148696A29E64821795CE15464D0062F8ABC4F69E18D2DAEEE586E3C22679635F2B78D3C75AAF89B567925BA916153F244ADF2AD6D7C4FF15DCEB9AD31CB2C5C855CFDD5E82BCE9546ECB1A49DC05DCCCD92493EF5209DF6042E768ED48AF186E10B7D6A4436C4FEF226FF00809A2E32C5ADD45BB13CD321CF0EA7815AB03595D29275978E55FBA6426B32DAD9253C37E95AE6DED85A80F6B1B81D481F35213266835068F747ABC73A01DDB3FCEA6B5B9459563BAB8477CE4064C7EB5922CEC253982ECC4FFDC63555AE67B3BADB3166DBC00DDC7B1A35067A7785B5CBED2B5506D9D539F99CA05561E9C57D05A5DEFDBEC629CEDF9D41F94E457C77078AAEAD58A2E2687B093EF2FE22BA5F04FC43D5EC75E8A1827862499B6EC99888F3EFE95407D5B4550D36EE7BAB706EAD4DBCC3EF2EEDCA7DD5BB8ABF4005145140156FFF00D42FFBDFD0D145FF00FA85FF007BFA1A2802D51451400560F8C25961F0BDFBC3F7FCA38ADEACFD65ACE3D22E64D41956D5632642DD00A4C0F8BAEEE66124D0CC37B331E4F51540DB48C4000D7497B6D6B7FE23BA9ED83AD9F985A3DFD76E78A9DE0851F70C66A39AC9156398FB3323EC3D6A75B22EBDC56EBDB432A6EDBF3FB54F696CAABF38C8A1CCA50BA3122D3A65C14622A632DE4006EE07AD6FCAA8870A38ACBB8BA5472920050D28C9038328B5B4774DB89F2E43DC74AA7730DC47B5263B82FDD3D6B4A49E14418E71D2B3AE2F082403B93D0D5DFA13CA5170629030C11E86A49EE2394AB242236EFB7A1A8A5396C8E86980557424FA1BE0F7C4B4974FFEC4D72EB0F0E16DE693BAFF00758D7B72B0650C0820F715F18F84655B5D521BD3179BE4382D18EA47B57D77E1FD52DF58D1ADEF2D98346EBC63B7B1F7A00D5A28A2802ADFFF00A85FF7BFA1A28BFF00F50BFEF7F4345005AA28A2800AE33E25CAA3C2AF6CEC024F22ABF3D57A915D9D7937C72D40DAE8BA7C0870F2C8E73F41FF00D7A52D86B73C7B56BDB45DF6F6E1463A62B1E3779242BD6B3D1F7B72726BA4D034E374E5B6F1EB58C9D91D14E17196D6EF80DC9C1AD94B338E95AB6FA365822AF15B10E968B1856AC253B9D90A692D4E326B27DB9158D7B63BC1C8EB5E873592464A8C1ACAB9D355F77CB494DDC254D58F3A6B7660D191F30A805B12C51C60D76D269B1063903354AE74827E745CE2B6550C5D3471B2DB344E548A615C0ADFBDB27316557E75ED58AE98FAD6B195CE79C2CCD4F0ADFA596AC86545743C10C2BE94F01DBBE977922DB46E34DD4545C4601C889FA32D7CC5A45A4971A945144BBA46FBA07F17B57D69E008664F0C5B0B842AC065411CAFB56864D1D68E94514504956FFF00D42FFBDFD0D145FF00FA85FF007BFA1A2802D51451400578B7ED0703B697A3CE3EE24B221FC40FF0AF69AF3CF8C7A449AAF81A568F6836AFE7B13FDD00E6A65B0E3B9F2F44989073D7A57ABE8F691E95A0A5CCA84B6DDD81D49AF37B1B5469EDD7196F3003F9D7B05F438D3E389572001C572D695AC8F430F0DD9C85C6B7AACD216847949D916AA36B3AC07F9DE4C55FBCBABE89FCAB3B4207F7CAD736DADEAF2DE18248CF071CA535AAD06D59EE757A66A32C8D89CEECF735AD391E4EEC561E856B717EEADE4BA73860548AF4B5F0DA4DA2B029FBCDB584B73A63B1E43AB5E382560FBD58BE6EAC7EEB3E3DABA4D6345BEB6790C309924CE028AE6A6B7F1124C5121B8DBFECAF15D10DB439AAA25B69EF239C79ABBC1EA18556D7AC16DAE209D176C53FE86B56D21D4E3940B985A443D7D45687892D7CFF000C2314C3C5203C8AAE6B33370BC4CEF87D6C9378EF4881D7205D2E6BEB88614854AA000673815F2DFC288CC9F11F492DCE198FFE38D5F540ADD1C93DC5A28A299055BFFF0050BFEF7F434517FF00EA17FDEFE868A00B545145001599E20B31A8787EFED08CF9B032FE95A74D6195C50C6B4773E499F4F1637B0863B644906571D467AD7B1585BA4F023901B22B80F1DE9CF6DAF5C3AA9016520E07BD77FE1B981B183D4A035E6D677499EC528DA4D097DA14D37CF07C8DF4E2A945E1BD56497324D085FEF6DE6BB78E54D9CE2A39AE6241D40A98DFB97BBB58C8B4D263B3037B9964EEC6BA4B208D6528C74158F1BB4EC5F858C7735A16FA859DB40E1E64E47AD5437D48AA9F2E87177B1433DECA92A7F15509BC2FE736E82EE68D4F60735B5A949617973886E424A3A7A1A5D3B50450639B01978A57B1B28A68C6B7F0AFD94991A4795FD5AB1FC57681340B95C636E0FEB5DDDD6A10A21C115C5F89A75B8D26E427F12E29C64F988A915CA57F821A72CFE2992E9F07C881997233C9207F5AFA1ABC7FE07E96F6F6FA85E491E33B6256FD48FF00D06BD82BD08EC7915BE2B051451546455BFF00F50BFEF7F434517FFEA17FDEFE868A00B5451450014514500707E3AF0BADF452DDC289BDD0AC99FD0D713A64EF61A75B191B0DB7691F4AF70650C0820107D6BCFBC7BA2048A3BBB6882C6BC3AA2E00F7AE4AF4B472477E1ABEAA1239D3E22272149C0EF4CB2D61B50BBDA4E10753EB5CFDC4724B03470F0E7BD410EB49A2CAB1496C4201F7F6935CB147A3CD635FC51AC6A36B9B7B39362B8E091D2B927D56F63876CD71BA4EE4715B17DE2BD3AF53E486491BFDC35CFDDA2DD03325ADC03D8043CFE95AC15B713526B4324EA57DF6FDEB23B73C015DFDBCB39D3E1600F98AA335C6A3DD59FCEBA5C9C7765ADCD2EE35BD4F0E204B6823EA58F5FC29CD131E68EE5BBEBF98A801C9ABBA5689AAF896C2E6DF4E489E6450DFBD7DA3AD62DFCE3CC64C82DDF68E2BD73E16698F6FA1CB7D22906E1F6A67FBABDFF3CFE5554A1CCCE7C4557189D3F85F4C6D27C3963692C491CEB12F9C13BC98F98D6CD26296BB4F29BBEA1451450055BFFF0050BFEF7F434517FF00EA17FDEFE868A00B5451450014514500150DC5BC57503C332868DC60835351401E1DE25D1E7D0B58787AC4DF344FEAB5058CD0DC7CB2A03EB9AF55F1868F16A7A348FB333423729EF8EF5E3EB13DB4E1BAA9EF5C1561C8EC8F5F0F5BDA47534E68E0B5CB24031EAA2B26E75C741B238982FA574102F9D10CF20D24B61689F332026B152773B799DB438F596E6FA7198F68F5AD39E76B7B41043D7D6B4668A18C12800ACB9DD1793DA9F35D994DB28695A449A96A8909E016F99BD2BE8CD3ED22B0B082D6050B1C481540AF0EF0B4EB71AEC11A11B438673FD2BDE80C0AEEA2B43CAC53D52168A28AD8E50A28A2802ADFFF00A85FF7BFA1A28BFF00F50BFEF7F4345005AA28A2800A28A2800A28A43C5004570035BC8A7A1520FE55F3D4B7A565719CC658E2BA8F8B5F1216CD1FC33A3CA4DDCD84BA9D0FFAB53D517FDA3DFD2B98D46D91218CC4309B1768F4E2B9B11D0EDC1E972EDAEAE912F5C8AAB7DAFEE3C56206256B3AF19C720D7372A3D0E6D2C6B4DAE48C31D0563DE6B2EE3CB8DB26B22796573CB9A92CADCBBF35A282DCC9C9EC773F0FDD57548D9DF0C5D7AFD6BE8E1C8AF96AD564814344C5187423AD7ABFC33F897178813FB1B559553548B2B1BB1E2751FF00B37F3ADE8CAF7471E2A16B33D3E8A28ADCE30A28A2802ADFFF00A85FF7BFA1A28BFF00F50BFEF7F4345005AA28AA77FA9596976CD737D750DB42BD5E570A2802E526457986B5F1C3C3B605E3D3E1B8D4241D180F2D0FE279FD2BCDF5FF008D1E24D515A3B478F4E8CF6B7E5FFEFA3FD314AE3B1F41EB1E23D234180CBAA6A105B2F60EDF31FA2F535E41E31F8E0B35B4B65E1B8A48CB7CA6F2518207FB2BFD4D78ADD5FDCDECED35CCF24D2375791CB13F89A819B229D98D245AB491EEB5A85E472ECD26E624E49F5AF4DB895A524F6F4AF34D090BEA8ADFDD19AF4443BA3AE4AFB9E86157BA50906D73542E5F822B5664DD9ACF9EDD9FA5648EA662B47B9F18AD7D3ADBA1C547158B07F9856DD9C0116AEFA10A3A934507CB8C579C4D24B63AC4FB1D9248A625594E0820F515EAB1475E59AEAECF10DF0FFA6A6AA86ECC716972A3D3FC35F1CB57D35238358817518578F301D92FE7D0D7AA685F14FC29AEEC54D445A4EDFF002CAEFF00767F3FBBFAD7CA19E280C56BAEC79D647DC49224881D1C329E854E41A7E7DEBE38D1FC5DAEE8657FB3754B9B651FC08F943F553C7E95E87A27C75D66D8AC7AAD9DBDEC7D0BA7EEDFFC3F4A57158F7ABEFF0050BFEF7F434571FA5FC4BF0DF886D479374D6F3AFCCD0CEB8603EBD0F5A2988E43C4FF001C5543C1E1DB6C9C7FC7CDC2F4FA2FF8D78F6B5E21D4F5CBA371A95ECD712762EDC2FD0741F85653495196A2C57A0E692A33CD21351492953D3E5A1012F4A69A15C30E0D29E6981A9E18024D61A33FC49C57A559D9BB438C74AF27D2AF3EC1AB43727A46E091EA3BD7D03A55BC5716714F010F148A19587A57257563D1C26C727359303D2AABD9383D2BBBBAD2F72E42F350AE9419395E6B9EF63B6C718964E7B1AD1B4D3A5761F29FCABA5834C8C48015CD7416DA6246A30A2A79AE2765B9CCDA68CEDD5715E13AF4AB378935191394370DB4FE35EFDE3CF11C3E15D064D841BDB805204F4FF6BF0AF9C86E6767607E63D7D6BAB0D07AB670E2E69A490F14525452499F957AD759C04E0FA1A7AB1AAE990BCD499A4C4753E0D90FF6B4A3FE981FFD0968A8BC187FE26F2FFD7BB7FE84B453B06A7341B2697350A9F9AA4CD0C00F5A0A8239A00A75004423D8D9152519A3A52405C16334F6B13C6A33B59BAF279AEEBE1B78C4D85C268D7CD881CFEE9D8FDC3E9F4AC9F0C3583B5B457B1E50A9CB8CE41CFD47F5A9BC6BE1CB2B5916FF004D997E7E5A3539C7B8A2A4149599A52AAE12B9EEF1A24B1E4720D35AD80E00AF10F0BFC4AD4F44416D76BF6EB651F2877C32FD0D7532FC628767EEB497DDFED4BFFD6AE1951923D25898B3D105A7CDB8552D73C5BA77862C8C97D3A9971F242A72EC7E95E49AA7C57D7EEE368EDBC8B356EF1AE5BF335C3DC4D77A85C19EE5E495DCFCD24849AAA7877D4CAA62A36B236B59D5753F1C6BD24E51987F0A2F2234ACDD46C1EC62891F76ECB70C854FEB5E87E1DBFD1744D05A3B668D6F88CB023733B7BFB7B571BE27D6A7D5E4579E7F3595DB9D8171ED815DB18D9591E7CA4E4EECE74D20403EB4B4034BA8808A40714E1CD34D303A3F061FF89C4BFF005EEDFF00A12D149E0CFF0090C4DFF5EEDFFA12D14AE23975EB52D14556EC6283838A5A28A4C16A277A53451408D1B092D21F2E492ECAC833903770076A9A10B3348609A5662A41F34F0DED9F5A28AB405A93C3576B1A3A4966433AC602CDF39CF7DB57A3D2B4F53650DD433C724CCE8F279A0A657D28A2931DC96EF41D1ED9617172F36623248ABD5462B1C5CE826CC2476D76270986767DC0B67A81451421122DCD95B5E4539D2A431FCAD8F319B208FEB54354BCD36E963FB0D89B5914B093E6C8619E28A29B03368145159F50169A0E734514D6C33A3F05F3ACCDFF005EE7FF00425A28A2908FFFD9);
INSERT INTO `sf_user` VALUES ('lala', '110', '1005', 'lala', '21232f297a57a5a743894a0e4a801fc3', '123', 'M', '222@qq.com', '2015-07-02', '132', '123213', '123123', '13113131313', '', '1', null, '1', '1', '1', '0', '4', 'admin', '2015-07-29 10:19:06', 'admin', '2015-07-29 00:00:00', 0xFFD8FFE000104A46494600010200000100010000FFDB004300080606070605080707070909080A0C140D0C0B0B0C1912130F141D1A1F1E1D1A1C1C20242E2720222C231C1C2837292C30313434341F27393D38323C2E333432FFDB0043010909090C0B0C180D0D1832211C213232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232FFC000110800C9009603012200021101031101FFC4001F0000010501010101010100000000000000000102030405060708090A0BFFC400B5100002010303020403050504040000017D01020300041105122131410613516107227114328191A1082342B1C11552D1F02433627282090A161718191A25262728292A3435363738393A434445464748494A535455565758595A636465666768696A737475767778797A838485868788898A92939495969798999AA2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE1E2E3E4E5E6E7E8E9EAF1F2F3F4F5F6F7F8F9FAFFC4001F0100030101010101010101010000000000000102030405060708090A0BFFC400B51100020102040403040705040400010277000102031104052131061241510761711322328108144291A1B1C109233352F0156272D10A162434E125F11718191A262728292A35363738393A434445464748494A535455565758595A636465666768696A737475767778797A82838485868788898A92939495969798999AA2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE2E3E4E5E6E7E8E9EAF2F3F4F5F6F7F8F9FAFFDA000C03010002110311003F00AA169718F5A7E2822B7246527E74A47347140C3B526EC1AA97B7290C4493823FDA02B88D4BC4F31728ADB71C6E8CF23EB49BB0CEF1EEA242559C03EF51AEA1036DF9D40638073D6BCD0EA37978C37DDA82A3A39AB48A6161E6CA445B79079DDF974A8E611E86D7912E72D923D3D2A68E54954323061EC6BCD8DEB6EDB14A1140F944BE9ED562C35F9EC6E02B4640030400482285219E894560DB789ED667F2CE33EB9C015B493472286470C0F70739ABB887D14B8A31EF4C4277A3B52D250021A42297BD068018073453B14526344D4EA31494C04354353D420D321F3666C93F757D6AF48DE5C4CE4671D877AE27C40A6FA547457F30FF00CB3DDC67D7353295868C3D7358BBD46F480FB63CFCA83B0ACE82C1E799A35DD239EA3A73E945D010CF971BB69F9B1FCAA75D6C3AAA490ECDBC0788E180ACD887B476D00D8D1C89205EAABBB26AACF712E48DEC0630093DBE9524B708586C95DD7D5B8354A6973943C8F5239A1086956E087F9BA75A72DE4C836095B15102B9EE694C44E48E47A52027174CDF2BB0AD0D37587B56D85F207DD39E45631423914BB32383F37A5303D6F46D5E0D462088C7CE5EAADFD2B57AD78FE97AB4DA6DDABFCC403C8CD7AA69BA9C1A9DAA4F0B1C91F329EA2B48B196FA518A5EB486A8425253A90F5A004CD149452632CE28C669D8F7A00E453033B5BBE16D6A218F6876EA73D2B93B7BF8A3B69A7958796DF283DCFB0F5AABE2DD4C9D6278F70F97E4DBE95CF47E65F4C230096E8B8ED5CF365AEC875DBFDB2EDB621209E303A55CB4F0A5EDDE1D23207BD75BE1BF0BC685649F96F415E8B69631451808A05632ADD8E9861BAC8F2A4F045DB5972999074AC4BAF086A90CDB3ECF231F502BE808EDD01CE2AC8B285C86D833F4A88D49172A103E6D7F0BEA71A67EC721FC2AB9D1F5043FF1EB27D08AFA8574E824F95A35FCAAADD68564E873080C3BE2B4552466E840F992412400A4B0B46C3B1151EE8E45C1187EC6BDD359F08585FAB2BC4BBBB381CD795F88FC2B368B233E09889E185546B27A333A9869455D1CE4A8C086EA31D6BA6F096B26C6ED6D653BA191B00FF74D73F1B29F95C657383445234370AC382A4722B639CF685C11C1CD29150D9CA27B2865CE77A039A98D6A31B8A4229F8A422810CC51411452632DE28FBBCE3A0A931514EDE55BCAE7F8509FD29B03C57579CCDAADCCADD5A463FAD6AF856356BDDEC338AE7EE583DD4AE060162715D2F84A276776C702B96AFC2CD686B511E99A79C15C0E2BA685B2062B95B22625058F15D25A4AAE839ED5C2933D36D1A51658D5C8D706ABDB006AE0C03D715B2466D9229A499B294CF3141E4F1DA89E5882FDF009ABE867D4CDB8C1AE5BC4B6297BA64D095059875AE8AE6EA1126D322FE06B32E409B956C8C5612BA77378DA4AC7CFF776CD6B72F13F186C546C70467903BD747E37B36B5D619F6ED0FCE6B995E6320F6AEE84AF13C9A91E59347AEF870993C3964CDD426335A758DE0F7DDE14B5EBC6E1FAD6D56F1121B47D2971462988691453C51498CBBB6A1BB8BCCB49A31C16461FA55CC535932318A6C4781484417122B26E7076F3D0577BE15B3115BABB0E48DE45723E24B27B1D7EE23207FACDC31E86BD2B4EB6F234585C759507E55C559DAC7561D2BB31F56B8D5AE663F634D9E9CD538BFE129B775679250A39EB5BA75CB6D3AE56254F3EE0F48D7FAD3A2F1E5E49AB0D2E6D0B73336DC2365B1EBD2A53935A236718A6AECD4D03C497CC563BA0491D4915DA25E191030AE623B6B6B9845E5A8063CF2BFDD3E86BA6D2214923191C62B34F5366924616B7AB5D461A3B70779E84571D736FE2ED424FDCCF204618C135E857B64A6766083EB5CCEAFA96A90C33AE931A79B08C80E397FF0074538CA57D0528A6AECC8B7F0EF89ADD15EE89603FDACD6B5A8BD8366E2D81F781159DA7F897C59FD9C6F2FE086440DB56164D8EC3D45749A5EA11EA51091ED6685DBF8644C539B7D49A495AE8E5BC79A6ADDE866E9573243F367DABCAE12B86079AF77F10DB06D16EE3C70D19AF09303AC8100EA715A507A339B16BDE4D1EA5E0E4DBE1B8060FDE63CFD6B77154B40B592DB41B48665DAEA9822B482D7645E973988B1460D4A5690AD3111628A7EDA29319A84734D2B5315A0A9A6079B7C44D276DC457C17E57C29C0AEE74FD33ED7A35A0CED5102E07E155FC5F642EFC3175C6648D77AD5AD0EF563F0ED873F3794B9CD70D74D3D4EDA2D3B34643F85E24BCF33CBC907AD6E5A692B1C8B2ED01C0C6F2727157E3DB27CDD6AD22E062B0BB3A8AB32C76D010000CE7E6C0EB5A1A51C5B8DB583AA4CC2F1225E78E6B7B498CB4223180D8A23B84B62650A643B8021B8350DDE97116DDD3D29B2332310474AD08984912E4E722A912EEB5466FF65C6C06E446F4F96A45B558D7EE0005682E6363DC5579E618EF54D212936616B712BD84CBD3284579AF843C3235BB99E57DBE546DB493EBDEBD135C9CAD9CA475DA6B27C2FE1A9F48B78AFBCEE6E37178C1E0528B6A2EC270529A6FA0B6B606C564803B322B9D9B8E78AB6AA48AB0C9BA43DC0E8694262BB68C6D0D4E0AF2529B68AE529A52AD95E2A3295A991576F34558DB83D28A4C668EDA3654FB29420A2E054B9B51776535B138122EDCFA573696D3585A436B213BE22573EB5D805C56378851516197D4E0D73D78DE3CC7461A6D4B959258CA76A8AD643F2EE3D0573B6B261979AD913A9848EFDEB891DFEA73BAA6AE905CDCC9B3CC651845CE09A934FF001548601BE0915CFF0008E4D5D9F4FB1B842658D4F724D59D3ED34E82DD443E5028739F4A686DE9A19F61E24B9B9D465B6B8B06857FE59966CB37E15D7C08D14481BD39AAF13DAB486589A367F6EB5612E1186091549752252E84CCC029ACDB825B38E6ACC8F90706A2200425AA5B1A4615E43F6BB84809DA19864FB55EB990AFFA3478DA0609F6AA0EEF26A84458F956AE4706D1DCFB9ADA8D3727739EB55E4565B8C58F1415E6AC6CC0A695AEF380848A615A94AD348A0084AFBD152114526334F6E6976D3B1E94A4516019597E2080CDA4C85465A3F9EB5B14D78C32B2919561823DAA671BAB15095A57386B2BB195CB76AB9793DE259B3DAC5BDBEB5917F6AFA46A725B3FFAB27744DEAB5B16376BE48F9B20F6AF365EEBB1EA45F32B9CFEED6AF2711BBC707A6F62455E8F4AD7C3829736CEBF88AD29EC85C31313947ED4B0689ACB3612FE1553EAB445DCDE338C558A73D96BB6CCAAD716E24C678278A9E24F1223C3348D0491670C149CFD6B6ADB437B660D7172D33FB0C0AD172121DA800A6DBE844E6A446B2ED8D72DC9EB4B35C01163359F24877126ABBDC81B8939C7415295CCA5A17F4C803C93CCC3AB6D06B44C78AABA1FCFA5C4E39CB3063FED679AD229C57A50B289E6D46DCDDCA857B530AD5964F6A8CAD5905622A365AB4CB9A89969815F1CD15215E7345481AA12976D3C034E094010ECA4DB5315A36F140195AAE8D6FAC5AF9330DAEBCC720EAA7FCF6AE325B4B9D12EC5BDE282A794917A30AF47DB589E2DD3BED1A44576A33E5C9B3F035857826AE7450A8D4ADD0C886EA30A31D6AEDBDFA63A8FCEB90C4917CBCD2899C725F1ED5C6AC763B9DE477EAD8C9CD477BA8C312F504FA5720B78147329FC29CAF2DCB6218DD98FF135376EE0B9BB17AEB523270A393D00AD1D2345B9BE91377DF6EDD947A9A7E83E1F96E6E01DBBE4EA49E8B5E9165A743A7DBEC41B98FDE7EED570A6E6FC88AB5553F539ED4A18741D119E386478AD537B2A0F9987F11FAD51D2B55B1D6EC12F34FB81342DDFBA9F423B1AEBEF62885ACBE7001361DF9E9B71CD7CD5E1AF13AF85FC533B264E97712B2C883B2E7861F4AEF4B4D0F35CB5D4F7122A265A9A39239A149A17578DC06561D08A0AD032B15A8D96AD15A89D69814D971454E573452034F14EC518A53D28018452014F2400492303B9AC0D4FC65A2E96C51AE7CE987FCB3806E346A0DD8DB7658E3677215146E627B0ACFD12F1BC59E15D5258D40896E196DFDC2F7FC6BCFBC53E3D9EEF48B8821B616D148B8E5B2E47A577DF0842FF00C2BEB365E77492337D771A271D2CC519D9DCE1D9E295FE5F5C7D2A71A78948C0CE7DAA0F15E9573E1DF15DC8DA7EC774FE742D8E39EABF5AB7A6DEB1C0542CC78DBDEBCD71B3B1EB42578F316A1D1E0420B8CD747A468125E91B13CA8475723F9569E8BE1979556E2FD4A6EE561CE0FF00C0ABAD8E35850246A001C003B56D4E85F591855C45BDD895ECAC60D3E0F2A24C7AE7A93EF539EA33F80A52483EADFCAB1FC47AF5B786F45B8D4AE58111AFC8BFDF6ECA2BAD456C8E293BEACE33E2C78B174CD33FB12D65FF004CBB5FDE95EA91FF00F5EBC265B70EBD39AD1BFD42E758D4EE751BC7DF3CEFB98E7A7B541F8D744636473C9DD9D7FC3CF188D35D344D564DB6AC716F331FF567FBA7DABD70A0238E47A8AF9BA64565C75ADDD0FC77AFE885231706EED17E5105C7CC00F63D4567283E85A9F73DC0AE3AD46CA2B9ED17E20E85AC2AC734DF61BA3FF2CA73804FFB2DD0D74B80C81D48653C823906A352D3B955979A2A665F6A2818CD4759B0D2D37DE5D4710ECA4F27E82B90D47E265BA6E1A759B4BD84929DA3F2AF3592469A42F2BB3B7AB9C93519624EC51927D2B65048C5CD9B5AA789B58D6E431CB70FB4FF00CB343B5055782D52D93CE979F7A5B4682288E47EF0751DEAADD5CBDC139E17B62A9225BB99BAECE648F2060357BFFC1DB492DFE1D599901CC923B807D09AF9FEE6DDEF6EEDAD2304BC8E140FAD7BDF8A35EFF8407E1DD9D9598C5EB42B1443FBA71CB5615373581A9E33B7D27C476E748FB481A8C5FBC8DD06E1130FEF9ED9A7F82FC3167A65AACCF247737F8C3B01C47EC3FC6BE7BB6D4AF2C6F22D51AE6E5AC2FC159DC39CAB7F173FDE079AD8D37C5DE20F0E6BA616D4249C380D6F23E1848A7EEE7D9BF4ACB962DDCD94E4A3CBD0FA700E0807F13CD4458924271EA6B13C29E2BB3F176902EADBF772C6765C405B98DFB8FA56EEDC0E785FE75688226C853C800739AF9E3E2578B3FE122F10FD92D5F3A7D992898E8EFF00C4D5E97F157C58743D13FB3ED64DB7D7C0A8C1E638FBB7F4AF03450ABEB9AD611BEA44E5D09067D29A77376A50C54F5E290BB62B6311ACBB6A15E58E7D69E724F26A31CB37D6900E9230F57F4DF10EB5A0B8FB05ECA917FCF263BA33FF000135487514A7E7A4D2634EC7A3E95F15ED9E2DBAB59491CA07DFB6E437E07914579A98016EB4547B3468A6CB45CB360559B74FE23C7D6AA85C1039AB8DFBB402B4321D2C83CCDA00DA2AA97CB914C9A50BD383512B6324F7A57B01D0F80AD92FFC7F63E68CC506E95BF015E8DE2AD324D62F66BEBC51B154A4287A2AFAD70BF09A555F16CDBC677C5B413F5CD7ACF890A7D9B633041B49663D1463AD6327A9BC363C3F10D9471695212FA5EA1BA44940FF0056D9C06FAAF422A468059E9775A45EBAB5E592B4B6CFEABFC4A3D8FDE1516928F72BA859C4167D2D32C2EE4C22C0FD9F27B1F4EF5D8FC35F0E58F88A23A96ACA973259EEB745DC76C8BD413FDE1DAA62CA31FE1B4FAB5B6B4BAC59EFF2E44092C2178988F6FEB5F404BACDA43A449A9DC3F970C285E407AAE3A8ACFD2ECAC2CDF16D69142DB3F81715E61F1775E61769A359CC57CE50F748BD1867E5069A57D04DD95CE0BC45AEDC78A35FB9D4EE3A48D88A3FEE20E82B3CB0140511A6075A6E4035BA5656307A8EC647CDD2A094C89F2A206F727A5481C3B119E7BD2F6C0A1EA08ADE54B273249F82714E54DBC0A79F97BE4520E7D68481884E09A729E6A3EA69EA6811271D68A681C514CA458CE179EB4E9A6F97D699FC155E7FBB49E824AE412CDB9FD6A6C3795935557EFD5D6FF8F7A92EC76DF09ACCBEAED718E926DCFF00C0735DDFC459E38F42BA12CA638CAE1D87DEC67A0F735CA7C20FBEFF00F5F1FF00B2D6A7C5CFF917E6FF00AEA958B7A9AAD8F38BCCDE58C0241F60D0ADFA4487991BD07F7DFDFB577FF0C8CCFAB472B2A5B59490B450C45BAE39C2FAFB9AE03C5FFF001EDA2FFD7A57A0786FFE43BE0CFF00AF47FEB4E3BB11E91A86A10689A5DEEA372C1628138F73D857CDF7D7936ABA9DC6A170732CEE5CFF00B23B0AF68F8A7FF2224DFF005F495E229F72AE9A22A31AE71F5A8B3BAA47FBFF0085442B53262BAE4829C35383051D71EA4D3569B2FDCFC6829210B17CE385FE7413C53EA36A04263EB4E029DFC34A940EC2A74C74A29B37DC1F5A295C691FFFD9);
INSERT INTO `sf_user` VALUES ('lpp', '110', '1005', 'lpp', '21232f297a57a5a743894a0e4a801fc3', '123', 'M', '123@qq.com', '2015-07-08', '12', '123123', '123123', '13112311231', '', '1', null, '1', '1', '1', '0', '2', 'admin', '2015-07-29 10:18:53', 'admin', '2015-07-29 00:00:00', 0xFFD8FFE000104A46494600010200000100010000FFDB004300080606070605080707070909080A0C140D0C0B0B0C1912130F141D1A1F1E1D1A1C1C20242E2720222C231C1C2837292C30313434341F27393D38323C2E333432FFDB0043010909090C0B0C180D0D1832211C213232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232FFC000110800C8009603012200021101031101FFC4001F0000010501010101010100000000000000000102030405060708090A0BFFC400B5100002010303020403050504040000017D01020300041105122131410613516107227114328191A1082342B1C11552D1F02433627282090A161718191A25262728292A3435363738393A434445464748494A535455565758595A636465666768696A737475767778797A838485868788898A92939495969798999AA2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE1E2E3E4E5E6E7E8E9EAF1F2F3F4F5F6F7F8F9FAFFC4001F0100030101010101010101010000000000000102030405060708090A0BFFC400B51100020102040403040705040400010277000102031104052131061241510761711322328108144291A1B1C109233352F0156272D10A162434E125F11718191A262728292A35363738393A434445464748494A535455565758595A636465666768696A737475767778797A82838485868788898A92939495969798999AA2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE2E3E4E5E6E7E8E9EAF2F3F4F5F6F7F8F9FAFFDA000C03010002110311003F00F7FA28A2800A28A2800A28AA77FA959E9768F757B7090C29D59CD005CA4CD795F88FE39E85A5298F4D825BFB8ED9FDDA0FA9EBFA570ADF1CBC4BA8CB8486CEC613DD10B63F134AE07D1DB80A370F5AF998FC47D5A7BA68D3519E524FFAC66FE4BD00AEBB48F885A95946C3C89AFA56E81DF007D28B81ED94579B5B7C5286340352B668643FC0BD07D4D5D5F89760AF9913F77EA87245303BCA2B3748D6EC75BB51716338913B8EE3F0AD2A0028A28A0028A28A0082E9FCB881F7A2997FFEA17FDEFE868A00B54514500148696A29E64821795CE15464D0062F8ABC4F69E18D2DAEEE586E3C22679635F2B78D3C75AAF89B567925BA916153F244ADF2AD6D7C4FF15DCEB9AD31CB2C5C855CFDD5E82BCE9546ECB1A49DC05DCCCD92493EF5209DF6042E768ED48AF186E10B7D6A4436C4FEF226FF00809A2E32C5ADD45BB13CD321CF0EA7815AB03595D29275978E55FBA6426B32DAD9253C37E95AE6DED85A80F6B1B81D481F35213266835068F747ABC73A01DDB3FCEA6B5B9459563BAB8477CE4064C7EB5922CEC253982ECC4FFDC63555AE67B3BADB3166DBC00DDC7B1A35067A7785B5CBED2B5506D9D539F99CA05561E9C57D05A5DEFDBEC629CEDF9D41F94E457C77078AAEAD58A2E2687B093EF2FE22BA5F04FC43D5EC75E8A1827862499B6EC99888F3EFE95407D5B4550D36EE7BAB706EAD4DBCC3EF2EEDCA7DD5BB8ABF4005145140156FFF00D42FFBDFD0D145FF00FA85FF007BFA1A2802D51451400560F8C25961F0BDFBC3F7FCA38ADEACFD65ACE3D22E64D41956D5632642DD00A4C0F8BAEEE66124D0CC37B331E4F51540DB48C4000D7497B6D6B7FE23BA9ED83AD9F985A3DFD76E78A9DE0851F70C66A39AC9156398FB3323EC3D6A75B22EBDC56EBDB432A6EDBF3FB54F696CAABF38C8A1CCA50BA3122D3A65C14622A632DE4006EE07AD6FCAA8870A38ACBB8BA5472920050D28C9038328B5B4774DB89F2E43DC74AA7730DC47B5263B82FDD3D6B4A49E14418E71D2B3AE2F082403B93D0D5DFA13CA5170629030C11E86A49EE2394AB242236EFB7A1A8A5396C8E86980557424FA1BE0F7C4B4974FFEC4D72EB0F0E16DE693BAFF00758D7B72B0650C0820F715F18F84655B5D521BD3179BE4382D18EA47B57D77E1FD52DF58D1ADEF2D98346EBC63B7B1F7A00D5A28A2802ADFFF00A85FF7BFA1A28BFF00F50BFEF7F4345005AA28A2800AE33E25CAA3C2AF6CEC024F22ABF3D57A915D9D7937C72D40DAE8BA7C0870F2C8E73F41FF00D7A52D86B73C7B56BDB45DF6F6E1463A62B1E3779242BD6B3D1F7B72726BA4D034E374E5B6F1EB58C9D91D14E17196D6EF80DC9C1AD94B338E95AB6FA365822AF15B10E968B1856AC253B9D90A692D4E326B27DB9158D7B63BC1C8EB5E873592464A8C1ACAB9D355F77CB494DDC254D58F3A6B7660D191F30A805B12C51C60D76D269B1063903354AE74827E745CE2B6550C5D3471B2DB344E548A615C0ADFBDB27316557E75ED58AE98FAD6B195CE79C2CCD4F0ADFA596AC86545743C10C2BE94F01DBBE977922DB46E34DD4545C4601C889FA32D7CC5A45A4971A945144BBA46FBA07F17B57D69E008664F0C5B0B842AC065411CAFB56864D1D68E94514504956FFF00D42FFBDFD0D145FF00FA85FF007BFA1A2802D51451400578B7ED0703B697A3CE3EE24B221FC40FF0AF69AF3CF8C7A449AAF81A568F6836AFE7B13FDD00E6A65B0E3B9F2F44989073D7A57ABE8F691E95A0A5CCA84B6DDD81D49AF37B1B5469EDD7196F3003F9D7B05F438D3E389572001C572D695AC8F430F0DD9C85C6B7AACD216847949D916AA36B3AC07F9DE4C55FBCBABE89FCAB3B4207F7CAD736DADEAF2DE18248CF071CA535AAD06D59EE757A66A32C8D89CEECF735AD391E4EEC561E856B717EEADE4BA73860548AF4B5F0DA4DA2B029FBCDB584B73A63B1E43AB5E382560FBD58BE6EAC7EEB3E3DABA4D6345BEB6790C309924CE028AE6A6B7F1124C5121B8DBFECAF15D10DB439AAA25B69EF239C79ABBC1EA18556D7AC16DAE209D176C53FE86B56D21D4E3940B985A443D7D45687892D7CFF000C2314C3C5203C8AAE6B33370BC4CEF87D6C9378EF4881D7205D2E6BEB88614854AA000673815F2DFC288CC9F11F492DCE198FFE38D5F540ADD1C93DC5A28A299055BFFF0050BFEF7F434517FF00EA17FDEFE868A00B545145001599E20B31A8787EFED08CF9B032FE95A74D6195C50C6B4773E499F4F1637B0863B644906571D467AD7B1585BA4F023901B22B80F1DE9CF6DAF5C3AA9016520E07BD77FE1B981B183D4A035E6D677499EC528DA4D097DA14D37CF07C8DF4E2A945E1BD56497324D085FEF6DE6BB78E54D9CE2A39AE6241D40A98DFB97BBB58C8B4D263B3037B9964EEC6BA4B208D6528C74158F1BB4EC5F858C7735A16FA859DB40E1E64E47AD5437D48AA9F2E87177B1433DECA92A7F15509BC2FE736E82EE68D4F60735B5A949617973886E424A3A7A1A5D3B50450639B01978A57B1B28A68C6B7F0AFD94991A4795FD5AB1FC57681340B95C636E0FEB5DDDD6A10A21C115C5F89A75B8D26E427F12E29C64F988A915CA57F821A72CFE2992E9F07C881997233C9207F5AFA1ABC7FE07E96F6F6FA85E491E33B6256FD48FF00D06BD82BD08EC7915BE2B051451546455BFF00F50BFEF7F434517FFEA17FDEFE868A00B5451450014514500707E3AF0BADF452DDC289BDD0AC99FD0D713A64EF61A75B191B0DB7691F4AF70650C0820107D6BCFBC7BA2048A3BBB6882C6BC3AA2E00F7AE4AF4B472477E1ABEAA1239D3E22272149C0EF4CB2D61B50BBDA4E10753EB5CFDC4724B03470F0E7BD410EB49A2CAB1496C4201F7F6935CB147A3CD635FC51AC6A36B9B7B39362B8E091D2B927D56F63876CD71BA4EE4715B17DE2BD3AF53E486491BFDC35CFDDA2DD03325ADC03D8043CFE95AC15B713526B4324EA57DF6FDEB23B73C015DFDBCB39D3E1600F98AA335C6A3DD59FCEBA5C9C7765ADCD2EE35BD4F0E204B6823EA58F5FC29CD131E68EE5BBEBF98A801C9ABBA5689AAF896C2E6DF4E489E6450DFBD7DA3AD62DFCE3CC64C82DDF68E2BD73E16698F6FA1CB7D22906E1F6A67FBABDFF3CFE5554A1CCCE7C4557189D3F85F4C6D27C3963692C491CEB12F9C13BC98F98D6CD26296BB4F29BBEA1451450055BFFF0050BFEF7F434517FF00EA17FDEFE868A00B5451450014514500150DC5BC57503C332868DC60835351401E1DE25D1E7D0B58787AC4DF344FEAB5058CD0DC7CB2A03EB9AF55F1868F16A7A348FB333423729EF8EF5E3EB13DB4E1BAA9EF5C1561C8EC8F5F0F5BDA47534E68E0B5CB24031EAA2B26E75C741B238982FA574102F9D10CF20D24B61689F332026B152773B799DB438F596E6FA7198F68F5AD39E76B7B41043D7D6B4668A18C12800ACB9DD1793DA9F35D994DB28695A449A96A8909E016F99BD2BE8CD3ED22B0B082D6050B1C481540AF0EF0B4EB71AEC11A11B438673FD2BDE80C0AEEA2B43CAC53D52168A28AD8E50A28A2802ADFFF00A85FF7BFA1A28BFF00F50BFEF7F4345005AA28A2800A28A2800A28A43C5004570035BC8A7A1520FE55F3D4B7A565719CC658E2BA8F8B5F1216CD1FC33A3CA4DDCD84BA9D0FFAB53D517FDA3DFD2B98D46D91218CC4309B1768F4E2B9B11D0EDC1E972EDAEAE912F5C8AAB7DAFEE3C56206256B3AF19C720D7372A3D0E6D2C6B4DAE48C31D0563DE6B2EE3CB8DB26B22796573CB9A92CADCBBF35A282DCC9C9EC773F0FDD57548D9DF0C5D7AFD6BE8E1C8AF96AD564814344C5187423AD7ABFC33F897178813FB1B559553548B2B1BB1E2751FF00B37F3ADE8CAF7471E2A16B33D3E8A28ADCE30A28A2802ADFFF00A85FF7BFA1A28BFF00F50BFEF7F4345005AA28AA77FA9596976CD737D750DB42BD5E570A2802E526457986B5F1C3C3B605E3D3E1B8D4241D180F2D0FE279FD2BCDF5FF008D1E24D515A3B478F4E8CF6B7E5FFEFA3FD314AE3B1F41EB1E23D234180CBAA6A105B2F60EDF31FA2F535E41E31F8E0B35B4B65E1B8A48CB7CA6F2518207FB2BFD4D78ADD5FDCDECED35CCF24D2375791CB13F89A819B229D98D245AB491EEB5A85E472ECD26E624E49F5AF4DB895A524F6F4AF34D090BEA8ADFDD19AF4443BA3AE4AFB9E86157BA50906D73542E5F822B5664DD9ACF9EDD9FA5648EA662B47B9F18AD7D3ADBA1C547158B07F9856DD9C0116AEFA10A3A934507CB8C579C4D24B63AC4FB1D9248A625594E0820F515EAB1475E59AEAECF10DF0FFA6A6AA86ECC716972A3D3FC35F1CB57D35238358817518578F301D92FE7D0D7AA685F14FC29AEEC54D445A4EDFF002CAEFF00767F3FBBFAD7CA19E280C56BAEC79D647DC49224881D1C329E854E41A7E7DEBE38D1FC5DAEE8657FB3754B9B651FC08F943F553C7E95E87A27C75D66D8AC7AAD9DBDEC7D0BA7EEDFFC3F4A57158F7ABEFF0050BFEF7F434571FA5FC4BF0DF886D479374D6F3AFCCD0CEB8603EBD0F5A2988E43C4FF001C5543C1E1DB6C9C7FC7CDC2F4FA2FF8D78F6B5E21D4F5CBA371A95ECD712762EDC2FD0741F85653495196A2C57A0E692A33CD21351492953D3E5A1012F4A69A15C30E0D29E6981A9E18024D61A33FC49C57A559D9BB438C74AF27D2AF3EC1AB43727A46E091EA3BD7D03A55BC5716714F010F148A19587A57257563D1C26C727359303D2AABD9383D2BBBBAD2F72E42F350AE9419395E6B9EF63B6C718964E7B1AD1B4D3A5761F29FCABA5834C8C48015CD7416DA6246A30A2A79AE2765B9CCDA68CEDD5715E13AF4AB378935191394370DB4FE35EFDE3CF11C3E15D064D841BDB805204F4FF6BF0AF9C86E6767607E63D7D6BAB0D07AB670E2E69A490F14525452499F957AD759C04E0FA1A7AB1AAE990BCD499A4C4753E0D90FF6B4A3FE981FFD0968A8BC187FE26F2FFD7BB7FE84B453B06A7341B2697350A9F9AA4CD0C00F5A0A8239A00A75004423D8D9152519A3A52405C16334F6B13C6A33B59BAF279AEEBE1B78C4D85C268D7CD881CFEE9D8FDC3E9F4AC9F0C3583B5B457B1E50A9CB8CE41CFD47F5A9BC6BE1CB2B5916FF004D997E7E5A3539C7B8A2A4149599A52AAE12B9EEF1A24B1E4720D35AD80E00AF10F0BFC4AD4F44416D76BF6EB651F2877C32FD0D7532FC628767EEB497DDFED4BFFD6AE1951923D25898B3D105A7CDB8552D73C5BA77862C8C97D3A9971F242A72EC7E95E49AA7C57D7EEE368EDBC8B356EF1AE5BF335C3DC4D77A85C19EE5E495DCFCD24849AAA7877D4CAA62A36B236B59D5753F1C6BD24E51987F0A2F2234ACDD46C1EC62891F76ECB70C854FEB5E87E1DBFD1744D05A3B668D6F88CB023733B7BFB7B571BE27D6A7D5E4579E7F3595DB9D8171ED815DB18D9591E7CA4E4EECE74D20403EB4B4034BA8808A40714E1CD34D303A3F061FF89C4BFF005EEDFF00A12D149E0CFF0090C4DFF5EEDFFA12D14AE23975EB52D14556EC6283838A5A28A4C16A277A53451408D1B092D21F2E492ECAC833903770076A9A10B3348609A5662A41F34F0DED9F5A28AB405A93C3576B1A3A4966433AC602CDF39CF7DB57A3D2B4F53650DD433C724CCE8F279A0A657D28A2931DC96EF41D1ED9617172F36623248ABD5462B1C5CE826CC2476D76270986767DC0B67A81451421122DCD95B5E4539D2A431FCAD8F319B208FEB54354BCD36E963FB0D89B5914B093E6C8619E28A29B03368145159F50169A0E734514D6C33A3F05F3ACCDFF005EE7FF00425A28A2908FFFD9);
INSERT INTO `sf_user` VALUES ('test', '1', '1005', 'test', '21232f297a57a5a743894a0e4a801fc3', '1111111111111116055', 'M', 'test@163.com', '2014-09-07', '11', '111111', '11111111', '11111111111', '', '1', null, '1', '1', '1', '2', '2', 'admin', '2015-07-29 10:20:07', 'admin', '2015-07-29 00:00:00', 0xFFD8FFE000104A46494600010200000100010000FFDB004300080606070605080707070909080A0C140D0C0B0B0C1912130F141D1A1F1E1D1A1C1C20242E2720222C231C1C2837292C30313434341F27393D38323C2E333432FFDB0043010909090C0B0C180D0D1832211C213232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232FFC000110800DC009603012200021101031101FFC4001F0000010501010101010100000000000000000102030405060708090A0BFFC400B5100002010303020403050504040000017D01020300041105122131410613516107227114328191A1082342B1C11552D1F02433627282090A161718191A25262728292A3435363738393A434445464748494A535455565758595A636465666768696A737475767778797A838485868788898A92939495969798999AA2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE1E2E3E4E5E6E7E8E9EAF1F2F3F4F5F6F7F8F9FAFFC4001F0100030101010101010101010000000000000102030405060708090A0BFFC400B51100020102040403040705040400010277000102031104052131061241510761711322328108144291A1B1C109233352F0156272D10A162434E125F11718191A262728292A35363738393A434445464748494A535455565758595A636465666768696A737475767778797A82838485868788898A92939495969798999AA2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE2E3E4E5E6E7E8E9EAF2F3F4F5F6F7F8F9FAFFDA000C03010002110311003F00F7A1D697BD1477A60145145020A33484F14C790229662001EB400FCE29AD2AA8CB3002B8DD7FC64B6B37D9EC995987561CD729AB78AAF258F0D3B0623A038AB54DB19EB06F20C13E6A1C75E69C2EA1C03E62E0FBD78A43AC4CDB4493E011C9CF5AB6FAB95000BA607B7CD472A1D8F641346DD1C1CFBD3C1CD78945E26B949029B83853D73D2B76D3C637713AEE6DC3B7BD3F66FA0AC7A9034572BA678C2DAE5BCB9D951EBA68678E740F1B0607D2A1C5A025A29296A4028A28A0028A28A008E8A4ED453016909C504D358E2801B24811092700739AF34F16F8BA4B8B86B0D3E4F9070CEA6B5FC77E253A5D9FD8E01FBF9D4F20FDD15E50B76103066F98F535B53875606D42A89F3C8DB98F258F3583ACCB279C368C02785EF5A16D7006D25B23A203FCEAC7D823BE91A79B19236A0E95B72E82E6B1CA4B7732F3C8029DF699658C32B13B6B7AFB47B6788450B00C872EC4F6AE7634923B82D18C85C923D4567C966527745D7F3AD7CBB9C6F8DC7208AD6B4B959625313640EC7A8A68BDB6B8B58C320D8E39F63556385602C8A7E65E847F10AD52B1373663B88C90EAD861DF35D1E85E299F4DB911DC366263C0CD79F0B9D8048A4F07E61EB57E0BD49D47231D89EA2A64931A3E85B5B84BAB68E64395750C2A7AE17C0BAE79D10D3A5E1957287E9DABB906B91AB30168A28A401451450043F5A5A4A5A004ED50CAE114B13D2A5638AC1F14EA274CF0F5E5D03F324785FA9E29EE08F1FF001E6B2B75AE5C32302236D8BEFEB5C61BD2485DDCF7351EA97464B8639CF24E6B25A5393CD6E9D8763A58752C11F31C0E38F4A9C6BF229014901727FC2B978AE4AF04D3FCE04F5E7156A7A0AC74967AA4ACCC1896F33B55E89459DD895C661231C8AC0D2D5E595180381CD747344D3694FBB9C0CD43AA87633F516862CC9030084852A3D6A93DF36D8DF272BC75AA370EC78278AAE9719186AD39C2C6C4D75B1B72FDD3F787F5A896F4C2E0A9F90D678BA1B0A67DAA14B865574C29DC319619239EDE952E407A1F867C40F6D7714BB8EE8C8239EA2BDFACEE16EAD629D46048A180FAD7C9FA65D347329CF7AFA57C137A6FBC336AEC7951B0FE158CFB833A414B48296B310514514010D068A4A006B1AF32F8B3AA793A6DBD823E0CA4C8E3D874FD6BD2DCF15E0DF152FBCEF12CB1E78891507B7193FCEAA3B8D1E6F75265CD5266C9A9A73935549E69B60058E6A688966C773C556FE3AB766BB9F349B03AAD1D544608EEADFA5747663CDD21C1E495E6B9FB54F221008E9137F4ADBD2D8FF65907DEB27234E5386BA622475FEEB1ACF91F0E48E01AD89E0DD7F347FED9E3F0AC6B988C52321ED5AA990C68724D488FF366AB67352A9A77034AD5F6B0AF7DF8497BE768F736E5B3B1C301E991FF00D6AF9F2DC8CD7AFF00C20BF31EA935AEEC2CB1E71F4A1EA80F6D14B4D5A5A8245A28A28020EF4868A0F5A0644E78AF9B7C77746E3C497CE7B4ACBF8038AFA464E01AF99FC6498D7EF78EB2B1FD6AA208E426EB558F5AB528E6A35859CF00D26320C735A9A52A999413DF354CDBB194A01D0D6C58D8344C19B22A64F41C55D9B6EC36291FF3CDAB5F4E3FF12E43EAB58890B31450091C8ADF82230D8018E40E335837A1D5CBAEA72B3AECD70FA31C9ACCD6A3513E548AD3D4ADE5378B20CF279AAF79A633A17FE2C77AD535A330927A9CEE0D3D7AD586B47519DA6A354C1E462B4332787AF4AF42F8693F95E27B6E719C8FCEBCFE218C5763E0890C7E23B239C7EF00AA5B01F4C274A7D323FBB4FA8245A2928A0082834941EB40C8E400A9FA57CFBF116D563F14CF1C6BD54374F5AFA0DFA1AF14F887083E3440C3868579FCE84347980B17998802AF25A791160264FD2B7ED34E0970CB8041E47D2B48E968E9F76A25234513CFEE2DA554F34139279C76ABFA535C60B49B8C5903915D336928BC151562DEC368D817E5A9734D171A6D3B95ECA1C483E5E0D740F687ECB9C638A8ED6CF12AF03AD74B3DA8FB22600E4566B5349CAD63CEAFD1A3C8541B8F4E2B947B8BA926F2D99B713DABD4EF34C0EA580E456447A4C666DCC8B9F5C55C5A89135CDAA3968EDE58DCC7326463EF53E7D19648CBA27BD775068AB2725739AB7FD8C8885428C629F319B4AC7941D3E489F0C302BA5F08DA37F6C5ABF61328CFBE6B5352D281380B923D056A78274DFF00898DC2BAF3018E4FA12D8AD14B421A3DAA2C88C67D2A51D29883029E29902D14514015B3CD0690734A78140C6B0E0D79378CE1597C7F648C3E578C260FE35EB27A579CF8F20F27C41A4DFE3E50C118FF00C0B3FD685B8D1C818D60D4767A0C62AFA1078AECF52F0A58CC92DEC6A44FB0B020F535C5AA957E4563246D06AE4BF6756232334D30EC071569318151DCF119359BD8D931F62A66986DEDD6BAA7B7CDA28EF8AE3ACB5282D1D5370DC79E7BD740BAF43E48DCD803D6945D8538B7B15D94162B51FD8519B7629EF2C72CA2488E55B938AB08462AEF722D60863F2C63D2A493183C5267029150CAE17D6A919B28C76FE6DC330507DEA5F0E5A4D0788AEE22DCC9E4E7DFF8BFA569DBE96F14A595F31119C11CFD2A6F0DDA993C497F363E48DC0CFB85C7F8D5C112D9DCAF4A753453EACCC28A28A00ADD68C50314BD6900D238AE33E21DB6FD122982E4C5303F85769595E20B2FB7E8F3DB85DC58700D1B31A1BA6C8B77A3DB3E721E219FCB9AF37D4ADDAD2FE6888C15722BAEF04DC93A635A48DF3C2C463D3D6ABF8BF4A2585F463231B64F6F4353245C7467291CBD39E94EB86DF0B2E7AF15509287A553BCBF36E3272401DAB9DF63AA2BA99F2DBC82E0123254F06AFC304D78863271EB59C7575720818FAD5F875858F6B00326A5DCDAD75A1D469B6A6DEDC2B9C9C55ADFB4F06B9A4F112B30508D93ED5AD0DCF9A80FAD68B439E49EECD212FAD5ED39775C2B003E5E4D632B9C8156F41D452E35D92046051232B9FF006B22B58A3091D528442D2390235F98FD319A93C276C63D2DAE245C4B732BCAD9F73C7E9552EC349FE8CBC99B09F41DEBA6B7896181235180AA0015643251D2968028A648B45145005514BF4A68CD3B348614C9172A453E90F228039282CA5D37C4D2322E219CEEF6AE8EE204B881A29143230C107BD4AF12BE0900E3A5078A4C6797788347934CB92002626E51BFA5731344AF90C2BD3BC6A5574B462390FC7E55E6EC55C920FE15CF38D99D34A7D0CE16C8872147D31566D56307E58C027DAACA2237DEAB90C50F602B2BB3A93D06436CABCED19AB7170781F953846B8A8DE50870BC9AB8F7309B2CBCBE5DB4AF9C108C47E5553E1E92FA9CCEDC909D7F1A90A192D27527968D87E9527C36B7266B8931D80AE883BA3965B9E95A7C3E6DE79CC3EE8E2B6C74AA9670AC6808EE2AD8AB218E1D28A28A620A28A2802A8A5C714D069D486141F7A2909E2801AC71D6B9FD5FC5361A5A36F7DCC3B569EA971F67B391FA71815E25E31B876B95504FCC69DBA8D1D06B1E2BFEDDB5202048D18EDF7AE51A62AE4A9A8A33E459A479E719350F99935CF37737A48D14BB18F9854F1DE2AE3935941895A950F3581D291ADF6D77185E054F02966C9EB542D90B1CD6C5BA631549912B22EDBA0FCEB5FC1F6F068734E93C8BB656DC9FEC8ACDB75E7A558BFB5966B71241912A0EDDEB683EE734D1E8F05D41201B2453F8D5B041E6BC5A0D62E617DACEC8CBD41AEDFC2DAB5EDE3932393028C64F735B19D8ED0519A453919A5A090C514514C0A94A3A53690BAA8E4E290C79A63B051924015566BF8D0ED520B5665E5E48E319FC29D9B111EBD7D1C96CD021CB6412457997886D3CF512A8CB46735D85E6119B272CD5932C4245604718AD14741DCE02597383DAA03260835B1AC6966DD8CA8A7CB3C9F6AC42A41AE7944D6322D4726473FCEAD42371154A1058D6C5A4193922B9E48EA8CB42DDB2F23B56B5B8248AAB05B9C569DB407209144519CE45DB68FA1C56BDAA06C022AA5B45F2818AD3882C4071C9E95AA461720D4741B5BE8C0650B21E8C3A8AD5D3AD62B0B58EDE2185518A811C82493F35588C96AE8846DB99499BF6D20789707A0C54D59966C50F5E2B455C3526AC03E8A28A00C79AE1870BC7D6A8CCED271B89CF7A649216908EC3B534CA00C66AD2B0AE45E508999C9C9A858EE25AA49E4C8C7AD53966C0C01815490185793B1D45E22380015F7A140DBC9FCE9DA9322CCAE7031FC46B84D775AB89E568A07648471C1C66AB41A3AABEBAB28D0ACD3C401E319CD72F716B6B24A4DB4C8CA7B66B9B123B1C3126B46C50094165C91D056334994B435ED74E70E38ADFB6D3D80191556C2F332A0652003C835D5C30A98C30E87A573385B736F68FA14E1B60A066B4608148E955E706342DD854B0DF2A4070416DBFAD35125B34902C6B803E6F4A72B73C9E6B9CB5F12446E8C178042FD9C1F94FF856EC7862181C83D083D6BA210B6ACCA4CB8B9AB9003915521073CD5E84E3DAB56665E8B22AD2B7CB9E845511280CA3BD59F357159B434482F148E99A2A130A8E6318CF5A29586604EF876C544181E6993C9FBF7071DBF90A894F27A568843DDF2D55663DF3523364D432F239AA4064EAF079D6CC17938AE1E4D2E4321DFC007A57A237CCA41C62B16EEDBF78C7068B0EE7396FA740DC6C50E3DA9971686171228C6DEB5B0F6E55B7AF069E621730953F7A9343B94AD981C48475FE215D7E97721E10A4F6AE36266B190C720CC64F20D7416122AA878CFCBD6B19A2D335B50906D58FFBC79FA562CB3ADBCA1508391D2A4BD966BA9C08BA74CD4D6FA524519676258F249A7086826CE76FAC9EE58C83E5C0A5D335BBFD21C2365E01FC2DD2BA4166643F2AFCA3A5452E905C60A641AD92449BBA47882CB51550AE2397BA39ADEF35228F7BB0DB5E73FF0008FEC6DD19743EA2BA1D1AD6ED828B9959D13EE834348968E96DD99DCB9FE2E9ED5777605568C6D51564608A8604AB21DA28A8776D24514AC2399BA245EC99E991FC850AD9A6DE93FDA528EDC7FE822A0998AE3071CD5A45344E78A639E2A4500C6A4F5C5324000E2992572A09351CD6E1D7A54E00CD3939CE681992F643D2A26B423EEF02B6A451C714C2A3D2819CF5CDA89400EA0F6AA96CB2E9D7210E5A263C57433469C7CA2A231A3019506A1EC345BB681360755FBDCD5916ECEC0B1C28A758A8FB38E3B54CDDFE94D313155500C0029CB8E9818A555181C54AAA3D2A9EE2048D4F60455AB78D50F1C0A8900CD5887BD215CB200DA69D0C8395279A17A7E1559FE5B9E38A5602CB6431A286A2815CFFD9);
INSERT INTO `sf_user` VALUES ('TEST2', '1', '1010', '测试2', '21232f297a57a5a743894a0e4a801fc3', '111111111', 'M', '11@163.com', '2014-12-16', '青岛市高新区', '111111', '11111111', '13244444444', '', '1', null, '1', '1', '1', '0', '8', 'admin', '2015-07-28 15:04:35', 'admin', '2015-07-27 00:00:00', 0xFF3F3F);
INSERT INTO `sf_user` VALUES ('test5', '109', '1005', 'test5', '21232f297a57a5a743894a0e4a801fc3', '111111', 'M', '11@163.com', '2014-12-19', '121212121', '121111', '111111', '11111111111', '', '1', null, '1', '1', '1', '0', '3', 'admin', '2015-07-29 10:19:20', 'admin', '2015-07-29 00:00:00', 0xFFD8FFE000104A46494600010200000100010000FFDB004300080606070605080707070909080A0C140D0C0B0B0C1912130F141D1A1F1E1D1A1C1C20242E2720222C231C1C2837292C30313434341F27393D38323C2E333432FFDB0043010909090C0B0C180D0D1832211C213232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232FFC000110800DC009603012200021101031101FFC4001F0000010501010101010100000000000000000102030405060708090A0BFFC400B5100002010303020403050504040000017D01020300041105122131410613516107227114328191A1082342B1C11552D1F02433627282090A161718191A25262728292A3435363738393A434445464748494A535455565758595A636465666768696A737475767778797A838485868788898A92939495969798999AA2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE1E2E3E4E5E6E7E8E9EAF1F2F3F4F5F6F7F8F9FAFFC4001F0100030101010101010101010000000000000102030405060708090A0BFFC400B51100020102040403040705040400010277000102031104052131061241510761711322328108144291A1B1C109233352F0156272D10A162434E125F11718191A262728292A35363738393A434445464748494A535455565758595A636465666768696A737475767778797A82838485868788898A92939495969798999AA2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE2E3E4E5E6E7E8E9EAF2F3F4F5F6F7F8F9FAFFDA000C03010002110311003F00F7A1D697BD1477A60145145020A33484F14C790229662001EB400FCE29AD2AA8CB3002B8DD7FC64B6B37D9EC995987561CD729AB78AAF258F0D3B0623A038AB54DB19EB06F20C13E6A1C75E69C2EA1C03E62E0FBD78A43AC4CDB4493E011C9CF5AB6FAB95000BA607B7CD472A1D8F641346DD1C1CFBD3C1CD78945E26B949029B83853D73D2B76D3C637713AEE6DC3B7BD3F66FA0AC7A9034572BA678C2DAE5BCB9D951EBA68678E740F1B0607D2A1C5A025A29296A4028A28A0028A28A008E8A4ED453016909C504D358E2801B24811092700739AF34F16F8BA4B8B86B0D3E4F9070CEA6B5FC77E253A5D9FD8E01FBF9D4F20FDD15E50B76103066F98F535B53875606D42A89F3C8DB98F258F3583ACCB279C368C02785EF5A16D7006D25B23A203FCEAC7D823BE91A79B19236A0E95B72E82E6B1CA4B7732F3C8029DF699658C32B13B6B7AFB47B6788450B00C872EC4F6AE7634923B82D18C85C923D4567C966527745D7F3AD7CBB9C6F8DC7208AD6B4B959625313640EC7A8A68BDB6B8B58C320D8E39F63556385602C8A7E65E847F10AD52B1373663B88C90EAD861DF35D1E85E299F4DB911DC366263C0CD79F0B9D8048A4F07E61EB57E0BD49D47231D89EA2A64931A3E85B5B84BAB68E64395750C2A7AE17C0BAE79D10D3A5E1957287E9DABB906B91AB30168A28A401451450043F5A5A4A5A004ED50CAE114B13D2A5638AC1F14EA274CF0F5E5D03F324785FA9E29EE08F1FF001E6B2B75AE5C32302236D8BEFEB5C61BD2485DDCF7351EA97464B8639CF24E6B25A5393CD6E9D8763A58752C11F31C0E38F4A9C6BF229014901727FC2B978AE4AF04D3FCE04F5E7156A7A0AC74967AA4ACCC1896F33B55E89459DD895C661231C8AC0D2D5E595180381CD747344D3694FBB9C0CD43AA87633F516862CC9030084852A3D6A93DF36D8DF272BC75AA370EC78278AAE9719186AD39C2C6C4D75B1B72FDD3F787F5A896F4C2E0A9F90D678BA1B0A67DAA14B865574C29DC319619239EDE952E407A1F867C40F6D7714BB8EE8C8239EA2BDFACEE16EAD629D46048A180FAD7C9FA65D347329CF7AFA57C137A6FBC336AEC7951B0FE158CFB833A414B48296B310514514010D068A4A006B1AF32F8B3AA793A6DBD823E0CA4C8E3D874FD6BD2DCF15E0DF152FBCEF12CB1E78891507B7193FCEAA3B8D1E6F75265CD5266C9A9A73935549E69B60058E6A688966C773C556FE3AB766BB9F349B03AAD1D544608EEADFA5747663CDD21C1E495E6B9FB54F221008E9137F4ADBD2D8FF65907DEB27234E5386BA622475FEEB1ACF91F0E48E01AD89E0DD7F347FED9E3F0AC6B988C52321ED5AA990C68724D488FF366AB67352A9A77034AD5F6B0AF7DF8497BE768F736E5B3B1C301E991FF00D6AF9F2DC8CD7AFF00C20BF31EA935AEEC2CB1E71F4A1EA80F6D14B4D5A5A8245A28A28020EF4868A0F5A0644E78AF9B7C77746E3C497CE7B4ACBF8038AFA464E01AF99FC6498D7EF78EB2B1FD6AA208E426EB558F5AB528E6A35859CF00D26320C735A9A52A999413DF354CDBB194A01D0D6C58D8344C19B22A64F41C55D9B6EC36291FF3CDAB5F4E3FF12E43EAB58890B31450091C8ADF82230D8018E40E335837A1D5CBAEA72B3AECD70FA31C9ACCD6A3513E548AD3D4ADE5378B20CF279AAF79A633A17FE2C77AD535A330927A9CEE0D3D7AD586B47519DA6A354C1E462B4332787AF4AF42F8693F95E27B6E719C8FCEBCFE218C5763E0890C7E23B239C7EF00AA5B01F4C274A7D323FBB4FA8245A2928A0082834941EB40C8E400A9FA57CFBF116D563F14CF1C6BD54374F5AFA0DFA1AF14F887083E3440C3868579FCE84347980B17998802AF25A791160264FD2B7ED34E0970CB8041E47D2B48E968E9F76A25234513CFEE2DA554F34139279C76ABFA535C60B49B8C5903915D336928BC151562DEC368D817E5A9734D171A6D3B95ECA1C483E5E0D740F687ECB9C638A8ED6CF12AF03AD74B3DA8FB22600E4566B5349CAD63CEAFD1A3C8541B8F4E2B947B8BA926F2D99B713DABD4EF34C0EA580E456447A4C666DCC8B9F5C55C5A89135CDAA3968EDE58DCC7326463EF53E7D19648CBA27BD775068AB2725739AB7FD8C8885428C629F319B4AC7941D3E489F0C302BA5F08DA37F6C5ABF61328CFBE6B5352D281380B923D056A78274DFF00898DC2BAF3018E4FA12D8AD14B421A3DAA2C88C67D2A51D29883029E29902D14514015B3CD0690734A78140C6B0E0D79378CE1597C7F648C3E578C260FE35EB27A579CF8F20F27C41A4DFE3E50C118FF00C0B3FD685B8D1C818D60D4767A0C62AFA1078AECF52F0A58CC92DEC6A44FB0B020F535C5AA957E4563246D06AE4BF6756232334D30EC071569318151DCF119359BD8D931F62A66986DEDD6BAA7B7CDA28EF8AE3ACB5282D1D5370DC79E7BD740BAF43E48DCD803D6945D8538B7B15D94162B51FD8519B7629EF2C72CA2488E55B938AB08462AEF722D60863F2C63D2A493183C5267029150CAE17D6A919B28C76FE6DC330507DEA5F0E5A4D0788AEE22DCC9E4E7DFF8BFA569DBE96F14A595F31119C11CFD2A6F0DDA993C497F363E48DC0CFB85C7F8D5C112D9DCAF4A753453EACCC28A28A00ADD68C50314BD6900D238AE33E21DB6FD122982E4C5303F85769595E20B2FB7E8F3DB85DC58700D1B31A1BA6C8B77A3DB3E721E219FCB9AF37D4ADDAD2FE6888C15722BAEF04DC93A635A48DF3C2C463D3D6ABF8BF4A2585F463231B64F6F4353245C7467291CBD39E94EB86DF0B2E7AF15509287A553BCBF36E3272401DAB9DF63AA2BA99F2DBC82E0123254F06AFC304D78863271EB59C7575720818FAD5F875858F6B00326A5DCDAD75A1D469B6A6DEDC2B9C9C55ADFB4F06B9A4F112B30508D93ED5AD0DCF9A80FAD68B439E49EECD212FAD5ED39775C2B003E5E4D632B9C8156F41D452E35D92046051232B9FF006B22B58A3091D528442D2390235F98FD319A93C276C63D2DAE245C4B732BCAD9F73C7E9552EC349FE8CBC99B09F41DEBA6B7896181235180AA0015643251D2968028A648B45145005514BF4A68CD3B348614C9172A453E90F228039282CA5D37C4D2322E219CEEF6AE8EE204B881A29143230C107BD4AF12BE0900E3A5078A4C6797788347934CB92002626E51BFA5731344AF90C2BD3BC6A5574B462390FC7E55E6EC55C920FE15CF38D99D34A7D0CE16C8872147D31566D56307E58C027DAACA2237DEAB90C50F602B2BB3A93D06436CABCED19AB7170781F953846B8A8DE50870BC9AB8F7309B2CBCBE5DB4AF9C108C47E5553E1E92FA9CCEDC909D7F1A90A192D27527968D87E9527C36B7266B8931D80AE883BA3965B9E95A7C3E6DE79CC3EE8E2B6C74AA9670AC6808EE2AD8AB218E1D28A28A620A28A2802A8A5C714D069D486141F7A2909E2801AC71D6B9FD5FC5361A5A36F7DCC3B569EA971F67B391FA71815E25E31B876B95504FCC69DBA8D1D06B1E2BFEDDB5202048D18EDF7AE51A62AE4A9A8A33E459A479E719350F99935CF37737A48D14BB18F9854F1DE2AE3935941895A950F3581D291ADF6D77185E054F02966C9EB542D90B1CD6C5BA631549912B22EDBA0FCEB5FC1F6F068734E93C8BB656DC9FEC8ACDB75E7A558BFB5966B71241912A0EDDEB683EE734D1E8F05D41201B2453F8D5B041E6BC5A0D62E617DACEC8CBD41AEDFC2DAB5EDE3932393028C64F735B19D8ED0519A453919A5A090C514514C0A94A3A53690BAA8E4E290C79A63B051924015566BF8D0ED520B5665E5E48E319FC29D9B111EBD7D1C96CD021CB6412457997886D3CF512A8CB46735D85E6119B272CD5932C4245604718AD14741DCE02597383DAA03260835B1AC6966DD8CA8A7CB3C9F6AC42A41AE7944D6322D4726473FCEAD42371154A1058D6C5A4193922B9E48EA8CB42DDB2F23B56B5B8248AAB05B9C569DB407209144519CE45DB68FA1C56BDAA06C022AA5B45F2818AD3882C4071C9E95AA461720D4741B5BE8C0650B21E8C3A8AD5D3AD62B0B58EDE2185518A811C82493F35588C96AE8846DB99499BF6D20789707A0C54D59966C50F5E2B455C3526AC03E8A28A00C79AE1870BC7D6A8CCED271B89CF7A649216908EC3B534CA00C66AD2B0AE45E508999C9C9A858EE25AA49E4C8C7AD53966C0C01815490185793B1D45E22380015F7A140DBC9FCE9DA9322CCAE7031FC46B84D775AB89E568A07648471C1C66AB41A3AABEBAB28D0ACD3C401E319CD72F716B6B24A4DB4C8CA7B66B9B123B1C3126B46C50094165C91D056334994B435ED74E70E38ADFB6D3D80191556C2F332A0652003C835D5C30A98C30E87A573385B736F68FA14E1B60A066B4608148E955E706342DD854B0DF2A4070416DBFAD35125B34902C6B803E6F4A72B73C9E6B9CB5F12446E8C178042FD9C1F94FF856EC7862181C83D083D6BA210B6ACCA4CB8B9AB9003915521073CD5E84E3DAB56665E8B22AD2B7CB9E845511280CA3BD59F357159B434482F148E99A2A130A8E6318CF5A29586604EF876C544181E6993C9FBF7071DBF90A894F27A568843DDF2D55663DF3523364D432F239AA4064EAF079D6CC17938AE1E4D2E4321DFC007A57A237CCA41C62B16EEDBF78C7068B0EE7396FA740DC6C50E3DA9971686171228C6DEB5B0F6E55B7AF069E621730953F7A9343B94AD981C48475FE215D7E97721E10A4F6AE36266B190C720CC64F20D7416122AA878CFCBD6B19A2D335B50906D58FFBC79FA562CB3ADBCA1508391D2A4BD966BA9C08BA74CD4D6FA524519676258F249A7086826CE76FAC9EE58C83E5C0A5D335BBFD21C2365E01FC2DD2BA4166643F2AFCA3A5452E905C60A641AD92449BBA47882CB51550AE2397BA39ADEF35228F7BB0DB5E73FF0008FEC6DD19743EA2BA1D1AD6ED828B9959D13EE834348968E96DD99DCB9FE2E9ED5777605568C6D51564608A8604AB21DA28A8776D24514AC2399BA245EC99E991FC850AD9A6DE93FDA528EDC7FE822A0998AE3071CD5A45344E78A639E2A4500C6A4F5C5324000E2992572A09351CD6E1D7A54E00CD3939CE681992F643D2A26B423EEF02B6A451C714C2A3D2819CF5CDA89400EA0F6AA96CB2E9D7210E5A263C57433469C7CA2A231A3019506A1EC345BB681360755FBDCD5916ECEC0B1C28A758A8FB38E3B54CDDFE94D313155500C0029CB8E9818A555181C54AAA3D2A9EE2048D4F60455AB78D50F1C0A8900CD5887BD215CB200DA69D0C8395279A17A7E1559FE5B9E38A5602CB6431A286A2815CFFD9);
INSERT INTO `sf_user` VALUES ('test6', '102', '1005', 'eee', '21232f297a57a5a743894a0e4a801fc3', '111', 'M', '111@123.com', '2014-12-19', '1111', '111111', '111111', '13523214565', '', '1', null, '1', '1', '1', '0', '2', 'admin', '2015-07-29 10:19:38', 'admin', '2015-07-29 00:00:00', 0xFFD8FFE000104A46494600010200000100010000FFDB004300080606070605080707070909080A0C140D0C0B0B0C1912130F141D1A1F1E1D1A1C1C20242E2720222C231C1C2837292C30313434341F27393D38323C2E333432FFDB0043010909090C0B0C180D0D1832211C213232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232FFC00011080096007003012200021101031101FFC4001F0000010501010101010100000000000000000102030405060708090A0BFFC400B5100002010303020403050504040000017D01020300041105122131410613516107227114328191A1082342B1C11552D1F02433627282090A161718191A25262728292A3435363738393A434445464748494A535455565758595A636465666768696A737475767778797A838485868788898A92939495969798999AA2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE1E2E3E4E5E6E7E8E9EAF1F2F3F4F5F6F7F8F9FAFFC4001F0100030101010101010101010000000000000102030405060708090A0BFFC400B51100020102040403040705040400010277000102031104052131061241510761711322328108144291A1B1C109233352F0156272D10A162434E125F11718191A262728292A35363738393A434445464748494A535455565758595A636465666768696A737475767778797A82838485868788898A92939495969798999AA2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE2E3E4E5E6E7E8E9EAF2F3F4F5F6F7F8F9FAFFDA000C03010002110311003F00F292619E47F3D72CABF7B38E6B3A6B7C3B1420AFA66AD0B73F3101980F4A64565248F9964D8073B4570C5A5D4F3E2EDADC86CF4F92E6505D59211F79EB678888504150B8E6A4499400AA8A133D00A86E18FDA1F76179ED594E6E6F5093721648EDE5C79B0AB1000CFB0AACF6D6E306306338C7069FBB238E6985F0703AD11725D449C9752BCF0BC0A4A9DC9EBE959F202C739AD5DEC7B566DD205932A301B9AE8A736F466D095F4657391401ED464D2E4FB56A684D6B189271C7039A9E6521B27F2A9B4A405267C8C8C0E94EB84CB163D2B194FDFB18CE5EF58A5302256F7E4542CA339AB528DD2E071F2823F2A88AF7C75AB4CA4CE92D638A69023BEC53D31DEAFDC58C31008A09F52DD6B0F3F3E71839E31DAADA6A12BE51B0C7A2E05725B4D0C10D9E268CFEEDF81EBC551BA9152E1B2727BE4D36F2E9BBF4FAD664F73B9F3ED5A53A6D9AC62D97C48A79DD8A7172A46FFBBEDCD6509C8AB562B75A8DD43656C85E495B6A8AD7D932BD9B2F075F4AA3A832E13B1ABBACD85C6877E6D27757039574E8D58B74CE66657EAA718A70A6D4B51C20EFA8DDF8EF4D7931D2A326ACDB42AE373F35BD9237B25A9D0E97098F4A43202BE633313FCA9970996F6F6AB769FF002098B1EFC7E3504ABB2323B8F515E7B7EFB7E670CDDE4CA17084498C72AABFCA98061B23F8BD6A795009179C82A01FCA9846323D2B54CAB9619B00E5B7718C5206213721C0E946C383F2F3E86819E013F856642DCCBBD244BB77645450F97E7C266198F70DC33DB3CD6A5EC21EDB72C64B0E41F4151E97E1ED5F56557B0B096642D80FB7E4C8EBC9E2BB68DE6AD15A9D74DDD1E81A7E87E1BFB3ACB1E9A27C9E03166AE86DAD741D3E3FB6D9E9F0DBDCC8BB328304545E03F0BEB1A7CAD3EB30A4691A8312AB03B8FBFD3FAD6C78A3418E788CD03B4538CB851C863513C2E27E3BDBC8D13B2380D42C23D5B5509E5F98EF280A1B9C1AE5359D0674D52F5B2AABE6BEC1EA335EBDE1CBF86D6DE78CDA3ADC245CCB2444166EFCFE558DA8D9595C46CAE4B48CDB98AF1C9EB5C71C44E2F51F2E9A1E5DA768735D4CCACBF2AF523A0FC6B462D1BECF1CB1C8A30E7E563D56BA246105BAC11A6C55EE46377BD588A18E78CF9BF3606719E294F18D3B9936D98965E5DBDB7D9E4986777C99F9460D569D0F98C0E485EB46B8A11A210F5DC718AB93A6D5DDDD8F4F5A96F697739AAAB3B9952A1323A7F740FE5504879CF3835A8F0892EB70E164271514DA7B87099386E41C122B58BB92B52BC8EAC31BD9BD69B10F309E32DDA9F2AE30E9B4A9EBC52C6E8ACAC533CD1B02170EF132ABEC7E808ED5E85F0A2412786A7B7CFCD1DD3123EA17FC0D79C5DB471AC826380E48C815D5F8074DF14E9133CCBA45C9B2B95072401CFF000B007B735DF97CD539733D8E8A29D9D8F70B7B666894FF000D64EB97291C0D18237D36C35A78B4F097ACCB7433BD08C62B9CD52456679B790393834B135E7291D31B58CE7D5D633242792E3059BA67B7EB5B7A5D9CC9A0AB5EA462E9CEE7545C05F61EBF5AC3D0AD22B9D516F2E39815B08A7F89BFFAD5DC0B49E48D9E289E4403D2B9AB4DF3A928EA10574EE7131E890EABAC3C7239540A5B628F4F7AAF7FA75BDAA911C5B47231935D069588BC548A06D0EACBCF6ABFAC68F0AA9677F98F40A05754214650B72ABB26DD59E5F2E9E2F2689E4531B4241591475F622A1BA87FD2B61C6D53DEBB1B3D3E6176EE90BCA838385E9589ABD92C5A948AC30326BC6A92946AB835648E6AF1BD9A3012260517B87E9570EAD1C70A9DAA0A7734C95BC9919F3F779CFBD7317F23199573F23B1602BA68DDA328265E4DB315427603C124D42ABCE324629F136D3BB8FC6A09EE5112404ED7604A8C75A766F44093E81F65BBD5F51874CB487CD9E661B077EFFA57D14CCDA568B670C8E0C90C091B15E848502BC3BC0F7577A4EB4FABDDE9F77245E4B22CAB11E0F1FD38AF4EBDD53FB4AC83C52673FC27AD74554E95356677534A3A0AB2BEB57D2442658FCB42FB8FE43F9D67EA7A25E60E2EE19863A213CD6B683A747676D2DE05FB5BC8424986E3D4A8FD326935B32CD7225B6057A601E315E6BC64A9BB2B1AB826AECD3F0968B0CDA2D8DE5F42E82DDE4DB11C7CFF0036149FCABB092E536654617D0566787E5DBA5A5B320DCAB9277672C49DC287676BB16E83E663C67A55CEBCA4D4D75FCCD6314958C116CE3C48D7A6DE4F29C903033B7D09A5D4AE127564F9837A8AEC8D8C5146BB5F79EED589ABDB4240DC8A4E7E95EC611D351E796B639AAC5EC8E634A32DB5D1708F247B4F9981D07AD72FE23984F7D3B9455518DB839278AEE6E6FDF4ED02EA64854888336147500735E23AEF89AEA7B3881DB15CCF9918C7D557B0FA9EB5E76279B1559D95ADFD5C89C3DC51B95B59BF108D8FCBF641FCCD73CB71249722491B2C78CD432C8F2C8CEEC59D8E493DE981B0C39EF5D74E92846C28D34958E92492311C8FC2E012013D6A1D2F53B8B5D5A0BD5B78A7316014740411FD0FBD2456BF6B6F3A6DC013F2C6076AB46354F95405C76515945FB2775B9CE9F26DB9EC7A5EA567AED8F9F6C411F75E36EAA7D0D43A868D67770C80A946FF00678AE13C2AD3D9CB2EE668964F9E324E0B7AD7751DDB4D0F7CB0EA7BD7ACED89A0A5D4E98CAEAECD3F09D9347E0FFB242CC521B87524F5E4E7FAD4D67A479BA823DC279ED165909932074CF153F83A50B6BAB5A96F98B0603DB1D6A0BF8B56B6B57B9D11ADDEE97257ED19DA41183D2BE531745AAFCB7DCEA85B96E5B8FC8B0BA0B668630CE59B1D0B1EA6B774E9449781EE1402CA53F1AE1FC229E20D4F5A88EAC618D554BC90A277EDCD7733C5F6790B606D3D6AF0CB91DA7AA6C7F12BA346E48814F3C57357B289AE177FDC0DD2B46F2EFCC5505F85EE7BD614C4C926ECE114F3EB5EF61E8D249FBC8C2A4E4FA185E35F10DAE95A2BDB08269A59D5915224C85C8EA4D7CFEC3048239AF55F8A57C901B38624902CA8DF3C7315C118EA3A1AF2827D6B9A95274EE9EF73394B9990C80A9F6A8AACB0CA9155EB78B2E2F43B5C21F56F61D2B460B0DB009AE36818CA20FEB54FEC0F14998E6248E57CC5E07BD5A4BB753147729B515B2CF9C835C314A5BB3862975349E32D7116461827F4AAB2EADAB5BED8A1BA3B776D0A403EC39A922BE81A432193A71F8560F89AEC5B45044BCBBAEF383DBB574C39A3A459D11DCF4DF0968FA8C16F36A335E79B72D2F96C8AC08552BDFF001C577505A13A789966CA63E6FF000AF15F84FE258B4CB8D42DAF2E238A0976CA7CC70A33D3BFE15DCEB3F11343B080DADADC9BA62FF325BF2ABEE4F4AE5C5D19C9F344EA8CA315A9D5E9370B1DEBA0CF9850952076DC2B4EF0CD719707A0E82B8CD0BC51A54DA8BCC9748163881258E383FF00D7C5367F8B9A24573716CEAE4C2A489157E59187F08FF1AE68E16A2B27A14AA46C6E49A9C42258645DB2AF0C0F7AC3D4F59B5D2ED25B8B9758B3C9C0E4D711178F24D53EDF753848255DCD1A8E807F0D79F5E6A97DA8B335D5D4B29F466E3F2AECA186853E672DD98CEA5F62FF008A2F8EA3A9BDD25E7DA2073FBB5C9FDDFB60D609E69E47AD26D045742D0C4662A0718622ACE0D452AE5C0AA8B2E2F53D5E1B28CC5E6CB90BE99E5AABCF14196458D0E3B019E6AFBC65D819DCC6A380A071F9D35CF970B797E5E3DD79AE7F668C3951C9EA1711582379B84CFDC8C7DE73FD057293CEF70E5E572CC6A7D66E5AEB519A432798A18AAB0F4AA70C6F29608B9C0C915BC6092B9BC6365718ABF355DB2902CA50F1BBA56C47E13927D352EA1BB8CC8577346DC62B265B5360A1A6E27CFCABE9F5A6DA92B152D558D3B7F3228E564202BA946F7154E541BB00726A6826F3630C0EDDDD40F5A6C809E9C9F5AE757BD99CC9BBD995999972109008C1F7A88F156A48F8000CD46D191DB15772AE459DDD4F348065B8A7E0E29FB72385FC68B85C8B1C723F1ABBA4D9A4F7EB24A3F7510DED9FD05354AAAED619F4C8AB96AA6183FDF3B980FD2A6726A2EC0E564779F6962C53605239F635475CBD92D6CE473B43EC6DA02E727DFF003A6ADCAC8CCEC4A7A7AD62EBD7EAD6CE1B6B0202A8DDCE6B4E5B2B823913927E61CD6C687040B2B4D32965C6001D3F1AC92DE61F956BA8D2AD1ECACDD251867C363D2A6A36A2686BDD69CB6F60B3D84CD23483386E83E95932D823D86C9C877724B37BD757A7E9F726C94CB1B085D3747935933DAB248C654C03C735C929F2ABA09B6A37461B410088226176F4C5566888F46FA56B5C4217EEA0C7B1AC7BE4609BA3C8269D29BBD8E48B77B3108CA9ED9A8CC6767AD36D6E1E493CB946E27A1ADD8B45B8959555482DC80F5B4A4968CDB95F439FF2B8C8A96DD3E6DC7A55ABB861B29248E6702543CA0A8ACDD040D34BF2A6783EB4DBB2B86A4ED6EBB90FDECFB74A256553857FC054735EA4B1048DB681F85550C7359B4E4EEC97AB3BEB9F0BEA91B9C4D66739E58B67F9560DFF0085354B845067B6E58B1CBB7D3FBB4515D4F7354B52083C0DAA433C7219AC982B06C6F6FF00E26BADB4F0EDC5E324B3490EDCE4A8279FD28A2A2A6C59A0DA56A5731CD1BCB0029BD622B230E3A0CF1C7E15CDD9685ABAAB2CB7914A9D42B3B1C1EFDA8A2B9A308D9E82A9B1757C29A8B23032DA8C7230EDFF00C4D674FE15BC949F9ED86071F337F85145425A9C562BB781751570EB3DA820E7EF37FF00135D3D8E8F7AC91B4D3C6C5178DA4FF851455D55748EAA660788FC0DA8CFA999E39ED5778DC433375FFBE6AB4DE0EB96B785924814B2648DED8C8FC28A2B67F0C4B633FE104D470479F69FF7DB7FF134D8FC13A9E702E2D47FC09BFF0089A28AAB1958FFD9);
INSERT INTO `sf_user` VALUES ('user', '102', '1000', '系统管理员', '21232f297a57a5a743894a0e4a801fc3', '111111111111111111', 'M', 'tt@163.com', '2014-12-11', '青岛市', '262125', '22222222', '13865975555', '', '1', null, '1', '1', '1', '0', '6', 'admin', '2015-07-28 15:44:04', 'admin', '2015-07-28 00:00:00', 0xFFD8FFE000104A46494600010200000100010000FFDB004300080606070605080707070909080A0C140D0C0B0B0C1912130F141D1A1F1E1D1A1C1C20242E2720222C231C1C2837292C30313434341F27393D38323C2E333432FFDB0043010909090C0B0C180D0D1832211C213232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232FFC0001108009600C803012200021101031101FFC4001F0000010501010101010100000000000000000102030405060708090A0BFFC400B5100002010303020403050504040000017D01020300041105122131410613516107227114328191A1082342B1C11552D1F02433627282090A161718191A25262728292A3435363738393A434445464748494A535455565758595A636465666768696A737475767778797A838485868788898A92939495969798999AA2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE1E2E3E4E5E6E7E8E9EAF1F2F3F4F5F6F7F8F9FAFFC4001F0100030101010101010101010000000000000102030405060708090A0BFFC400B51100020102040403040705040400010277000102031104052131061241510761711322328108144291A1B1C109233352F0156272D10A162434E125F11718191A262728292A35363738393A434445464748494A535455565758595A636465666768696A737475767778797A82838485868788898A92939495969798999AA2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE2E3E4E5E6E7E8E9EAF2F3F4F5F6F7F8F9FAFFDA000C03010002110311003F00E8C649A93B547D2A41935EC9E10AA39A901029AA29C14D318EDD46EA365280050160EB4BB690B63A5337134584C972051B89A8C95442EEC151464B31C014EB7922B84DF0C8B227F794E41FA1EF48766D5C940A5A78000A6B75A65583B546E3D29DBA93A9A62645B09A511D5854CD3B60A0144AE13068D99AB056B3752D6F4CD2367DBEF6280BFDD563F31F7C0E71EF45D752940B26215191835241710DDC0935BC8B246E32AC0F514A6224D28C94B54EE12835D080D46466AD794293CB02A89E52A3459A85A2ABC56A32BED4038141A01455D318A28B93ECC708EA55514D06A4506A4DB94705028C814E0A68311CD03E5185BD2B1BC49AFC3E1AD24EA1730CB2296D88A83EF3107827B74AE820B6334C91AFDE638AE57E237813C49E288AD6DEC1ADD2DA02CCC8EF8DCDD01FCB3F9D70637175284E10A71BF36EFB25E9D5F43A70F868D5527376B7E279D37C60D63ED44A58589849C0460DB87E3BBFA57683C49A995892E6E34BB3B89B84B7B757BB989F40AA403F8122BCA755F00F88F48B9582E2C4BB348B1AF94C1B2CC70057B67823C0B67E15D3D19D125D4E45FDFDC75C67F857D00FD7F20328CEB621DA9CEC96FB7F48DE54E8D1D650BBE816BE1EBBBBD93EA1733F999DD994AC920FF7571E5C7FF01527FDAAE86DED23B65DA9BC93D5E476763F52C49ABBE5D023AF469D35056DFD4E39B727731B51BCBFD3B33269E6F6D472C2DCFEF507B21FBFF8107DA8D2F5CD2F5B8F758DE472303868C9DAEA7D0A9E456DF97815C5F8D7C010F88217BED35BEC9AC28C8910ED137FB2F8FD0D12728ABAD4518293B3D0EAFC9A708B1DABC03FB5EF34FD21EDAFAF2E96E412AF1CADF7181208C7639AABE1FF00883AB786F51568EE5EEAC8B7EF2D646CA91DF6FF0074FB8FC73597D6575452C3DF63E8C0950CD6ECEAC12E6E21DC31FBA931FA74FD29DA4EA367ADE976FA8D8C9E65BCEA194F71EA08EC455C31715AA70A91BEE98B96507D998D25B4D0DB30F2BFB4580C0135CC91487FE06A703F215E3175A36B5E22F145E5BD968F73E7ACA7746F2197CA5CF019CFB77EF5F465A696D344666184E807AD645E6ACFA0EB70DB3E12DEF62775CF1F3A15CFE6187FDF35E057C552A78E8E169A77927ADDB8AB6BDF73D0A7094E973CED65F79CF6AF67AAD8F870C6D35BDACE96E159CFCD860304A81C0F6E7F0A7783F577D73408E699D5EEA1630CECA301987F17E2083F5CD735E3DF1C4288F6F081379808600F4150FC1EBE49A3D5E0C9DC1A39003EFB81FE42BD0CBB054707170A4AD7D5F998E2F11531134E5B23D2361A618CD5934DEF5E95CE4E52A9879A3C8AB7F2D26F4A2E3E445331628A9DDD68A77172A40964C4D4C2CF1D6AD970A6A453BBA565766BCA8AE9683D29CD6DC55D4008C54AB18353CC57299F0AAD9C8B70FF00754FF3E2B59EEDAE90C16E9B9B60776FEE83D3F1383F91F6CE3F8A1C5B786AEE503E65D9B7EA5D40FE752F842E8CFE1386FC9FDE5E3BCB923F843154FF00C7556BCDC7CE5C8F95D9BD11D34125B993A8682D1DD24E252240DBBD483FD6B5161DCA1B1D4513B349296739E6AD5A91B4A9FA8AF3724C3D5C1D49464DB52EFDCE8C6D655E29BDD14CC473D29EB09C74AD208A7B0A95625F415F48EA58F3B94CAF209ED4E4B73D715A4EA83D29A30697B461CA791FC52F86DFDB76AFAD68F6FF00F1348F99A24FF978403A81FDF1FA8F7C5784DE6993D9461A52B92402BDC1AFB22EEF6DAC94BCF2045032C7D057CF9F1423B0BBD6A4D4B4F8C88E66CBA9EAAC7BE3DEB8EB41CA6B97E66F09A8C1F32F42C7C15D5A4B1D71F4B965636F7A38427859074207BF4FCBD2BDF7ECC49000C93C57CBFE0799ADFC4D6528F94A4AA73F88AFAB2C4896E222A72BF7B35B465C89A5D0CBE27A9AD1C2B1C2918E8A315E55F1CACE48FC296FAC5B3949B4FB80781D55C853FAEDAF539E5F2D09AF2CF8B974F73E03D5973F22A2F1FF00035AF1AA695233EB73B124E2D1F3EEA374D7712CDB89DC33CD7A2FC1030349AD267FD24AC4C07FB03767F523F4AF3BB3B632E9EA07F76BA9F83D706CFE222DB39DBF69B7962C7AE30FFF00B257BBAA6A479F4ADAC1743DE7C927AD235B9C66B43CB19A24550BC56BCC57298EF191511859BA569BA02699B76F6A7717219CD68D8C93455F675E828A399872211DC16A963917159CAC4D4CB9EF4AC3B9A2B281520B8AAB126465A9FB727029590EE73BF11F5A1A7F83EE49DB9970AB93DC10723E9C1ADBF0A4490780F45456F97EC51B6718E4A827F526BC33E25F887FB5BC4F77A72C99B6B15689403C161F78FD7771F857B2F87EF1E4F0AE942463B8D9C59CFF00B82B87114B9E71B7435A73DD1A0EE0375A65DADC4BA74FF64729728BBE223BB0E403EC7A1FAD4618193AE6B42D465AB66AC85B9CB7873E2368DAE2AC325CA59DF7430CCDB431FF00658F07E9D7DABAF174C2BC6A7F86DA70D5AF2296EEE24DD3BF971421576A93900E739E0D4B0407C2332C763E2E9C229E6CE58C5CA81E9C300BF810688D54DD9A2396496A7AF1999CD36699A08F700598F01477AF34D4BE26B4402594485997866FD4E39C743DCD4DE07F1134FA76A5AA5F4F24CF1C9B5771E3711DAAE52D3408D9BB0BE3BD7A4B18A385C02402EEA39058F63F4AF11D475396F277776383C6DAEAFC65AB1D4EF256DD92C49E2B839C6C6C566B4D41BE691B7A35C14BA8E45C2953D6BE87F0AF880DCF83ED2E639089A17FB3B7D54F03FEF9DB5F3A694A2287CC6C1C9AEFBC27E2EB5B3B3BAD3A5CAF9B3C72C4DD811C30FC4107F0AD250F7798C2152D51C7A1EEF36A82E6D377DD6C723DEB80F1DAB5D783F57881C9FB33B60FB0CFF4ADDB69FCC854839047150DEDB25DDB4B049F724428DF4231584F0D192D0EBE768F9B61B8F2EDA25DD8C003AD6A785AF96C3C7FA25E13F2FDA511CE7A06F949FC98D64EB7A55D687A95C69B72A77C270ADD9D7B30F6C566248C0060C43A1C823B1AD9CFDDB18C29DA5CC7DA062F9781558EEDFB48AA9E1FF1026BBE1BD3F530466E6057703B3E30C3F060454D24D96C8AB8DD96CB4605DB93C55578C938534DFB59E99A93CCC0DC45524D01565B590D156BED39FE13F9514AEC0A6B020038A795551C015AF1E94303249A9FFB3102FDDE6A1D688F94C20E41E2A9EAFAA0D1B47BCD465195B789A4C7A90381F89C0AE865D33072A2B89F88AC90DAE9BA5E72F753F9AE9EA918DDFF00A1ECA3DA2B68163C120F0FEA177ABDB9BADC1EFAE3648C7A827E66CFBE0E7F1AFA2ACD2186CE28A31B638D0228F400600AC2D4FC349A65B6891327FA4C7E6DDCA71FC4C029FCB701F8569DA4DFBAC1EBDAA29A4D8B55B9699F0FC1A96F75EB1D03499350D42611C318C63AB39ECA07726B3A698464B13803A9AF08F19F8B26F11EAEFB6422C60252040783EAC7DCFF002C53A8B51A66F6AFE39B8D72E2EEE9152CE091C6E456396C0C0CFA9C01ED58D657715C5C224ACEDB8F241C77FF00EBD2F82FC0BAC78CE66166A21B346C4B7527DD5F603F88FB7E6457D0BE18F86FE1EF0FDA24474CB7BB987DFB8BA8D64763EBC8C0FA0A8E6496847B36DEA7CDF796D7371AB496D67C927603B800ABEE6BA991FF00B07428B4C122B32E649580E0B37A7E181F857D0FA9E9BA441A0DD24BA55935A471B4861302EC240F4C75AF96F5BBD334F2FA678CF6F6A232E614D722B2326FAEF7DC124E72393F5AC5964324A58FAD4F3B925B27926AA907AD1265D38D8D48E52BA7B056E714CB5B829CE6A0898F90D81DAAFDE68D79A7AC65E2628E09CA0CE31D41FA66B473D519F22D51E83E0CF882B6812C7546260E8939E4A7FBDEA3DEBD504C92C4B246E1D1865594E4115F2DA3321CA9C8AEDFC19E369748996CAEA42D6121C0DC7FD51F51EDEBF9FAD6919261671D083E2A5D79BE2A28BFF2CA045FC724FF00515C3237735D1F8DEE45EF8A2FA55395DCA01FA28AE77188F8EB8AC277B9B46D63E80F829A92DDF82E5B376CBD9DCB2A8F4560187EA5ABD11F18E95E39FB3D5DA1F106ABA5C87FE3E2DD66407D51B07F47FD2BE817D363CE768A71AC92B31B8DF639C8E3DCDF76B52DE0565195FCEADB5AC718E17150A821B8CD373E6D856B131B288AFDD1454B19723A51597349751928931C74A9D0865AABBD7EB4F4900E95938949964A0C579E5F5AAEADF18EDA375DF169DA787C760CCE4FF3095DFF009A315C57850FDABC65E2AD59B91F6A5B48FD846AAAC3F35144534983B0FF0013A03E2AD12076F92782EA36C9F6523FF1E02B9924DB4AC8DC60E315B9E2A9A5B8F196962DB936A10B01FED38C8FC80FCEB2F5BB768AF6607208639AD60DA64C9189E289DC785F5378C90EB6D2118EA3E535E37E0EF0C4DE2AD6E2B6F992CD0837130FE15F41EE7B57B744564528E032918208E08A9AC6DED74EC0B68238109C858D028CFD053A9762868765E16B2B4D3152C6CA1586DA0876A22F41C8FD7AF35D48DA7A5735E19CCAB712F5030A0FE64FF4AE817835958D2E6378D2430F83B5371FF3C76FE640FEB5F2A6A4333EEE412792457D39F126E043E03D401EB26C403D7E707F9035F2E6A529F30FD39E7A56B4B639EAFC4918D707E720547FC23DA9653B98E4E7DE9A39C0A3A9AA5646F785F4EFED1D62D606198F7F98E0FF0075793F9F4FC6BD0FC7DE15BCFF0084274DF115A42EEB6B73379E53AA236D0ADF4054F3EE2B0BE1CD9802EAE8A92C48850FEA47EAB5F4DE93642D745B7B27505562DAEA464127A8FD4D3AAAC9110D5B3E579F435D73C2D65ABD8463EDA232B3A2FF00CB52BF2927FDBE037BE7D6B9146E76E3AF18AFAA7C6FA1DA58E9D692595A436F0A314290C6114679E838F5AF07F1AE8288C752B38F07FE5BAA8E0FFB5FE3530931C96B638B949CB6E62D9E849A60C73F4A18E57B714B082CF8AB7ABB0F64745F0FB5C3E1CF1E691A896DB12CE2394FFD337F95BF424FE15F67B006BE0E9005718AFB77C3B78751F0D6957CCDB8DC59C3293EA5901FEB585556348B2EB4418D2085476A9F029A4D45D8EC8454514534BE28A2CC3428C7181C9353ED5EC6B35353B53C798BF9D4CB7D6BB722453F8D6AC8B1648E793815CB7C394F33C196F7CE3126A134D78F9EE649188FD315BD25F5B490489E6A8DCA467358DE1BB8B7D27C3BA6698F2207B5B48A17C1FE25500FEB9A350B0FD222B7BBF126A97EEA3CBB79B6827BBA80BFA6D3F9D64F8B6E619E779A1C71C37BFBD3E2D496DECB518E1C0125ECAC5BFBD939E3F3AE3F51D406E705B8CE4D6908DAF264CE5D04F3C2B673814C6BF25D4EEF97D3358B71AA89998271CE07BD74BE08B0B4BDD6A39AFB6B410A9708DD0B76CFF87B5449F6262EECF4CF0CDAC96DA243E77124BFBD61E99E9FA62B5CA8CF5AA6FAB5A2381E6A7E74AFA85BEDDDE62FE751666A715F18AE1ADFC210A27492E46EFA05635F34DE9691CB11CF5AF7CF8CDA9C7268BA6DB21DC6599D8E3D00C7F5AF03BB906DDB8C71E95B53D8C26FDF32D8734F89324734C7233566D6232B04504B31C0006724D115791A49D91ECFF0834C5BC8ED1587CA6669DC1F41C7EBB6BDF77815E5DF0DEDA1D137C32955305B2C64E7AB13927F4AF408F53B6918FEF138F7A75D3E6B76151F86E3B5CB21AA68D716A3972BB93FDE1C8FF0FC6BC32E200659239546065595BFAD7B9C7A9DAB4A504AA48ED9AE0FC77E1D8E777D574D01E43CCF0A724FFB407F3AC63A15357D4F9D3C49A2BE8F784A2B1B49B2617EC3FD9FA8FE551685686FAEA4B653891E07D9EE546EFF00D96BBCD5E16D6B45B8B338DE312467A6D75FF247E35C478799ED3C4D662456478E52AEB8E47041AD61F1A21CAF06654D90FC8E7B82315F5E7C2BD406A1F0CB43973931C06023D36315FE4057CB5E2C48535EB930001188703D320135EC7FB3FF0088C1D2B51D0E7603C8905C4393D9B861F8103FEFAA9A91D5A2E9CAF14CF73DFC530B5557BC857AB8FCEA337F6E3FE5A0FCEB3502EE5B2C09A2A8FF0068DB1FF9683F3A2AB9493CA54F724D4A1881C135515891D6A4C9200CD6632D87247539FAD3D18006AA2BE3A9C536E6730DAC922FF0A1200EE681DC7DC5EAC7A280AF8CBB1248F7FF00EB57157970F349F78ECEB8F5ABFAA4F25A68508B8063C47BDC1ED9E6B95B3BEB8D4ADE6BB4B597C9808DEDD901E95D2F4491CB36E4F4362DC96900C038EE6BBAD1A1F2AD37F4DE781EC2B8BD210DDCD1AC78F98D77A85634541D14631513D117455F52D06A50F9EA6ABE73D0D2ABEECE39AC8E838DF89D2EF874388750F3027EBB31FD6BCE35EB4782ECC59FBAA38C57A378C2037DAE68F6CB9FBC5CB0EC030FF3F8D725E2E861835696243B9938627D6BA2946EAC72D47695CE1DF8FC2BA1F0632A7896CE474DE10B301EE14E0FE7FCAB05D03CC403C67B5747E14B7793C43004EC18E3D7236E3F5A29A7CF72EA3F74F6CD2989B332C9F7A462DF8741FD6ADF99CF06A28D552244ECA00A7703A11595497349B3584796290EDF8E4134D3330E8C79F7ACFB8B8BF133082D11D3A066940CFE151CD2DF7CAF1C518C7DE42DD7F1ACEE55CABE21B34308D4E2886F8F0B38518DC3B31F5F4FCAB8ABC822B690DE204C95DC8EDD42F71F857A52392184A80A3AEC75CE720D794EBEA963ACC9A34F2921D83427B2E471F98E3EB5AD39599CF5A17D8E675F713EA52B2B6EC018FCAB77E19DD1B4F14BC7BCA99ADDD0007A90437FECA6B0351B778AF56303E62A31B7BFB7F4FC29FA1BCF07896CBAC532DCA2B06C8E770041FAF4ABA9ABB8E969148F796BB9B3CCAFFF007D544F772938F31FFEFAA841EB9A8CB176247E15CE6A4C6EE519C48FF9D15549E09F5A28B8AE3D7AE72053F8EB558316208EF5206248C8247B52026FC41A532BC286444577504AAB0C8271C023D2A2520F6EBDB34EF310739393D28B8CF25F14F89EFF0056BAF2A65114610011A0386E38FE95E8FA5D98D13C17F679E1577168DE7464F52C0920FE26B93D534FD5AD1666FED185E256695229AD77AA9249C2961C1F7154DBC73A9C9692D9DCC305C992268E46524336E18E3DC7A553936C9565B127C3DD55975E6D3E462EAC1FCB607A6076FCABD54A2B292CC79F7AF0AD2A09B4DB94D42DAE2659E304C3B2DCB1C918C36EC01C67D6BAD8BC79AFED555D2622DDD88619FD78EF4F56178C4F464B76456D971263391BB9C0A9A3277819C83D4938C571A9E339E484B1D35E1908FBA1F760FE959F6DA88B4925B99EF2E955A466C4A30A0B727007BFBF6A9E59760F691E86AEBF7B15978D347594B9598F97B7FE05D727B74FD6BCE279AE75FD6447090F737529C76192739FA55EF117889A7D6A1BE82391D63B66891668F6EC660C09007D723DEAA785EFB4FB0BC59EEADEE5A4191BD3271D318C63DF39CD6919B4AC4CA29FBC6DEA1E0BB4D23C3B2DCDD5E837D10DCE236E06480063A918EF4CF02B431EB8F24853708FF7633D7B9FE949E29D7ACAFB4A9ED63B6BB495CA6249570BC60F5CE79FA572BA0EA4FA2EB36F7FE4998444E63071B81046338F7A154924D341C8A5AA67B88D4E521552067EFBB2307D31D29D6F737ACA37C0CADFC458AF1ED8CD71107C40F3B118D36E61C26D52A3774F7381CFD29D378BEFA58DE35B21E5B6304CBB5971CE723DF1D3E959F2C9F41BA915BB3B69BEDB29592299100E0AED073DB9E6ABB41ABB4AE4DD401081C2C678F61CD7132F89B53795659E545022C7931A3619BBB161D33F8F06A80D7AEE152FE5CAEFB8B2ABE76A7E64E7BFFF00A8E29F24BB0BDA459E889697AC70F7A3CB23A28C91EBCE6B85F8836A8D0D9C825F327811624913397CB138279C9E78FA62AA5CF887549963FF00897C03672D24CA5B39F63C0E82B2B50D4B56D42EA29E5B5B249631B519615F940E718E9FA668E563525DC8A277D47C4B0DB4D91B6625C8EC072D8CFD0D755AD691A5DE5D477B6F7D3ADF643997633AB118EBC0C1E2B92B2B7BB86F24B961E6CB206F99490771E73C56E8D4B538620A2C8281D19958FF003E3D2AED37A90E518E913AB875057B593FD2654519009DAC49F41F9F7AA53EB724102856BB9642A0961185503DC91D6B9E3AB6A71B6E2A029C9FF54B8C7D719FD6AC45AF6A8AA156257E0FCCC0B1C7E54BD9B27DA227B9D4F53B9803089A741F322952AD91DC8071FA76A29D6FA8EAC6E0347A7C66462406F231D703AFE5452E463524FA1D8863919FA707FCFBD3D2462C318E4E0E68A2B33643837C9BD947007009E79A5C81C80718E99CFF009E9451400EC004291D46400781DE90104920703939A28A92842A873C30000FBAE47F2A6F93192D969B81B8FEF9F9FF00C7BDA8A2842152D63949DC646C8070D2B1001C7BD31B4DB194032D95BC8A391E62063C63D68A29DD8590E6D3AD635216D605C119C463FC290C10BE06CDA0F185247F2C76A28A5763B2237D074E7DE7EC90B74C165CF523FC691742D35232FF0061B5E9FF003C81EFFCF9A28A399DB70E55D870D26C411BACEDC01D9631DBFF00ADFE7BD4A74FB36C8FB342769E7318E7FCE68A29DD8AC845B680ABEC821DC0705A31D87B53DADD232708808C0CAA8EF93FD28A295D8EC8816D2D98990DBC41F258108320FB714D288B2140B8663EBC67A7F4A28A684C7AC8EA1846ECA58E0F351A11BFE5C83CB123AFF9FF001A28A62050114B1FBC41C918E9505B5C2DD5BA4B1EE008E33C1A28A10855CB100F41C75A28A2988FFFD9);
INSERT INTO `sf_user` VALUES ('zg', '1', '1005', '主管', '21232f297a57a5a743894a0e4a801fc3', '111111111111111', 'M', '11@153.com', '2014-09-24', '11', '111111', '11111111', '11111111111', '', '1', null, '1', '1', '1', '3', '3', 'admin', '2015-07-29 10:19:53', 'admin', '2015-07-29 00:00:00', 0xFFD8FFE000104A46494600010200000100010000FFDB004300080606070605080707070909080A0C140D0C0B0B0C1912130F141D1A1F1E1D1A1C1C20242E2720222C231C1C2837292C30313434341F27393D38323C2E333432FFDB0043010909090C0B0C180D0D1832211C213232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232FFC000110800C9009603012200021101031101FFC4001F0000010501010101010100000000000000000102030405060708090A0BFFC400B5100002010303020403050504040000017D01020300041105122131410613516107227114328191A1082342B1C11552D1F02433627282090A161718191A25262728292A3435363738393A434445464748494A535455565758595A636465666768696A737475767778797A838485868788898A92939495969798999AA2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE1E2E3E4E5E6E7E8E9EAF1F2F3F4F5F6F7F8F9FAFFC4001F0100030101010101010101010000000000000102030405060708090A0BFFC400B51100020102040403040705040400010277000102031104052131061241510761711322328108144291A1B1C109233352F0156272D10A162434E125F11718191A262728292A35363738393A434445464748494A535455565758595A636465666768696A737475767778797A82838485868788898A92939495969798999AA2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE2E3E4E5E6E7E8E9EAF2F3F4F5F6F7F8F9FAFFDA000C03010002110311003F00AA169718F5A7E2822B7246527E74A47347140C3B526EC1AA97B7290C4493823FDA02B88D4BC4F31728ADB71C6E8CF23EB49BB0CEF1EEA242559C03EF51AEA1036DF9D40638073D6BCD0EA37978C37DDA82A3A39AB48A6161E6CA445B79079DDF974A8E611E86D7912E72D923D3D2A68E54954323061EC6BCD8DEB6EDB14A1140F944BE9ED562C35F9EC6E02B4640030400482285219E894560DB789ED667F2CE33EB9C015B493472286470C0F70739ABB887D14B8A31EF4C4277A3B52D250021A42297BD068018073453B14526344D4EA31494C04354353D420D321F3666C93F757D6AF48DE5C4CE4671D877AE27C40A6FA547457F30FF00CB3DDC67D7353295868C3D7358BBD46F480FB63CFCA83B0ACE82C1E799A35DD239EA3A73E945D010CF971BB69F9B1FCAA75D6C3AAA490ECDBC0788E180ACD887B476D00D8D1C89205EAABBB26AACF712E48DEC0630093DBE9524B708586C95DD7D5B8354A6973943C8F5239A1086956E087F9BA75A72DE4C836095B15102B9EE694C44E48E47A52027174CDF2BB0AD0D37587B56D85F207DD39E45631423914BB32383F37A5303D6F46D5E0D462088C7CE5EAADFD2B57AD78FE97AB4DA6DDABFCC403C8CD7AA69BA9C1A9DAA4F0B1C91F329EA2B48B196FA518A5EB486A8425253A90F5A004CD149452632CE28C669D8F7A00E453033B5BBE16D6A218F6876EA73D2B93B7BF8A3B69A7958796DF283DCFB0F5AABE2DD4C9D6278F70F97E4DBE95CF47E65F4C230096E8B8ED5CF365AEC875DBFDB2EDB621209E303A55CB4F0A5EDDE1D23207BD75BE1BF0BC685649F96F415E8B69631451808A05632ADD8E9861BAC8F2A4F045DB5972999074AC4BAF086A90CDB3ECF231F502BE808EDD01CE2AC8B285C86D833F4A88D49172A103E6D7F0BEA71A67EC721FC2AB9D1F5043FF1EB27D08AFA8574E824F95A35FCAAADD68564E873080C3BE2B4552466E840F992412400A4B0B46C3B1151EE8E45C1187EC6BDD359F08585FAB2BC4BBBB381CD795F88FC2B368B233E09889E185546B27A333A9869455D1CE4A8C086EA31D6BA6F096B26C6ED6D653BA191B00FF74D73F1B29F95C657383445234370AC382A4722B639CF685C11C1CD29150D9CA27B2865CE77A039A98D6A31B8A4229F8A422810CC51411452632DE28FBBCE3A0A931514EDE55BCAE7F8509FD29B03C57579CCDAADCCADD5A463FAD6AF856356BDDEC338AE7EE583DD4AE060162715D2F84A276776C702B96AFC2CD686B511E99A79C15C0E2BA685B2062B95B22625058F15D25A4AAE839ED5C2933D36D1A51658D5C8D706ABDB006AE0C03D715B2466D9229A499B294CF3141E4F1DA89E5882FDF009ABE867D4CDB8C1AE5BC4B6297BA64D095059875AE8AE6EA1126D322FE06B32E409B956C8C5612BA77378DA4AC7CFF776CD6B72F13F186C546C70467903BD747E37B36B5D619F6ED0FCE6B995E6320F6AEE84AF13C9A91E59347AEF870993C3964CDD426335A758DE0F7DDE14B5EBC6E1FAD6D56F1121B47D2971462988691453C51498CBBB6A1BB8BCCB49A31C16461FA55CC535932318A6C4781484417122B26E7076F3D0577BE15B3115BABB0E48DE45723E24B27B1D7EE23207FACDC31E86BD2B4EB6F234585C759507E55C559DAC7561D2BB31F56B8D5AE663F634D9E9CD538BFE129B775679250A39EB5BA75CB6D3AE56254F3EE0F48D7FAD3A2F1E5E49AB0D2E6D0B73336DC2365B1EBD2A53935A236718A6AECD4D03C497CC563BA0491D4915DA25E191030AE623B6B6B9845E5A8063CF2BFDD3E86BA6D2214923191C62B34F5366924616B7AB5D461A3B70779E84571D736FE2ED424FDCCF204618C135E857B64A6766083EB5CCEAFA96A90C33AE931A79B08C80E397FF0074538CA57D0528A6AECC8B7F0EF89ADD15EE89603FDACD6B5A8BD8366E2D81F781159DA7F897C59FD9C6F2FE086440DB56164D8EC3D45749A5EA11EA51091ED6685DBF8644C539B7D49A495AE8E5BC79A6ADDE866E9573243F367DABCAE12B86079AF77F10DB06D16EE3C70D19AF09303AC8100EA715A507A339B16BDE4D1EA5E0E4DBE1B8060FDE63CFD6B77154B40B592DB41B48665DAEA9822B482D7645E973988B1460D4A5690AD3111628A7EDA29319A84734D2B5315A0A9A6079B7C44D276DC457C17E57C29C0AEE74FD33ED7A35A0CED5102E07E155FC5F642EFC3175C6648D77AD5AD0EF563F0ED873F3794B9CD70D74D3D4EDA2D3B34643F85E24BCF33CBC907AD6E5A692B1C8B2ED01C0C6F2727157E3DB27CDD6AD22E062B0BB3A8AB32C76D010000CE7E6C0EB5A1A51C5B8DB583AA4CC2F1225E78E6B7B498CB4223180D8A23B84B62650A643B8021B8350DDE97116DDD3D29B2332310474AD08984912E4E722A912EEB5466FF65C6C06E446F4F96A45B558D7EE0005682E6363DC5579E618EF54D212936616B712BD84CBD3284579AF843C3235BB99E57DBE546DB493EBDEBD135C9CAD9CA475DA6B27C2FE1A9F48B78AFBCEE6E37178C1E0528B6A2EC270529A6FA0B6B606C564803B322B9D9B8E78AB6AA48AB0C9BA43DC0E8694262BB68C6D0D4E0AF2529B68AE529A52AD95E2A3295A991576F34558DB83D28A4C668EDA3654FB29420A2E054B9B51776535B138122EDCFA573696D3585A436B213BE22573EB5D805C56378851516197D4E0D73D78DE3CC7461A6D4B959258CA76A8AD643F2EE3D0573B6B261979AD913A9848EFDEB891DFEA73BAA6AE905CDCC9B3CC651845CE09A934FF001548601BE0915CFF0008E4D5D9F4FB1B842658D4F724D59D3ED34E82DD443E5028739F4A686DE9A19F61E24B9B9D465B6B8B06857FE59966CB37E15D7C08D14481BD39AAF13DAB486589A367F6EB5612E1186091549752252E84CCC029ACDB825B38E6ACC8F90706A2200425AA5B1A4615E43F6BB84809DA19864FB55EB990AFFA3478DA0609F6AA0EEF26A84458F956AE4706D1DCFB9ADA8D3727739EB55E4565B8C58F1415E6AC6CC0A695AEF380848A615A94AD348A0084AFBD152114526334F6E6976D3B1E94A4516019597E2080CDA4C85465A3F9EB5B14D78C32B2919561823DAA671BAB15095A57386B2BB195CB76AB9793DE259B3DAC5BDBEB5917F6AFA46A725B3FFAB27744DEAB5B16376BE48F9B20F6AF365EEBB1EA45F32B9CFEED6AF2711BBC707A6F62455E8F4AD7C3829736CEBF88AD29EC85C31313947ED4B0689ACB3612FE1553EAB445DCDE338C558A73D96BB6CCAAD716E24C678278A9E24F1223C3348D0491670C149CFD6B6ADB437B660D7172D33FB0C0AD172121DA800A6DBE844E6A446B2ED8D72DC9EB4B35C01163359F24877126ABBDC81B8939C7415295CCA5A17F4C803C93CCC3AB6D06B44C78AABA1FCFA5C4E39CB3063FED679AD229C57A50B289E6D46DCDDCA857B530AD5964F6A8CAD5905622A365AB4CB9A89969815F1CD15215E7345481AA12976D3C034E094010ECA4DB5315A36F140195AAE8D6FAC5AF9330DAEBCC720EAA7FCF6AE325B4B9D12EC5BDE282A794917A30AF47DB589E2DD3BED1A44576A33E5C9B3F035857826AE7450A8D4ADD0C886EA30A31D6AEDBDFA63A8FCEB90C4917CBCD2899C725F1ED5C6AC763B9DE477EAD8C9CD477BA8C312F504FA5720B78147329FC29CAF2DCB6218DD98FF135376EE0B9BB17AEB523270A393D00AD1D2345B9BE91377DF6EDD947A9A7E83E1F96E6E01DBBE4EA49E8B5E9165A743A7DBEC41B98FDE7EED570A6E6FC88AB5553F539ED4A18741D119E386478AD537B2A0F9987F11FAD51D2B55B1D6EC12F34FB81342DDFBA9F423B1AEBEF62885ACBE7001361DF9E9B71CD7CD5E1AF13AF85FC533B264E97712B2C883B2E7861F4AEF4B4D0F35CB5D4F7122A265A9A39239A149A17578DC06561D08A0AD032B15A8D96AD15A89D69814D971454E573452034F14EC518A53D28018452014F2400492303B9AC0D4FC65A2E96C51AE7CE987FCB3806E346A0DD8DB7658E3677215146E627B0ACFD12F1BC59E15D5258D40896E196DFDC2F7FC6BCFBC53E3D9EEF48B8821B616D148B8E5B2E47A577DF0842FF00C2BEB365E77492337D771A271D2CC519D9DCE1D9E295FE5F5C7D2A71A78948C0CE7DAA0F15E9573E1DF15DC8DA7EC774FE742D8E39EABF5AB7A6DEB1C0542CC78DBDEBCD71B3B1EB42578F316A1D1E0420B8CD747A468125E91B13CA8475723F9569E8BE1979556E2FD4A6EE561CE0FF00C0ABAD8E35850246A001C003B56D4E85F591855C45BDD895ECAC60D3E0F2A24C7AE7A93EF539EA33F80A52483EADFCAB1FC47AF5B786F45B8D4AE58111AFC8BFDF6ECA2BAD456C8E293BEACE33E2C78B174CD33FB12D65FF004CBB5FDE95EA91FF00F5EBC265B70EBD39AD1BFD42E758D4EE751BC7DF3CEFB98E7A7B541F8D744636473C9DD9D7FC3CF188D35D344D564DB6AC716F331FF567FBA7DABD70A0238E47A8AF9BA64565C75ADDD0FC77AFE885231706EED17E5105C7CC00F63D4567283E85A9F73DC0AE3AD46CA2B9ED17E20E85AC2AC734DF61BA3FF2CA73804FFB2DD0D74B80C81D48653C823906A352D3B955979A2A665F6A2818CD4759B0D2D37DE5D4710ECA4F27E82B90D47E265BA6E1A759B4BD84929DA3F2AF3592469A42F2BB3B7AB9C93519624EC51927D2B65048C5CD9B5AA789B58D6E431CB70FB4FF00CB343B5055782D52D93CE979F7A5B4682288E47EF0751DEAADD5CBDC139E17B62A9225BB99BAECE648F2060357BFFC1DB492DFE1D599901CC923B807D09AF9FEE6DDEF6EEDAD2304BC8E140FAD7BDF8A35EFF8407E1DD9D9598C5EB42B1443FBA71CB5615373581A9E33B7D27C476E748FB481A8C5FBC8DD06E1130FEF9ED9A7F82FC3167A65AACCF247737F8C3B01C47EC3FC6BE7BB6D4AF2C6F22D51AE6E5AC2FC159DC39CAB7F173FDE079AD8D37C5DE20F0E6BA616D4249C380D6F23E1848A7EEE7D9BF4ACB962DDCD94E4A3CBD0FA700E0807F13CD4458924271EA6B13C29E2BB3F176902EADBF772C6765C405B98DFB8FA56EEDC0E785FE75688226C853C800739AF9E3E2578B3FE122F10FD92D5F3A7D992898E8EFF00C4D5E97F157C58743D13FB3ED64DB7D7C0A8C1E638FBB7F4AF03450ABEB9AD611BEA44E5D09067D29A77376A50C54F5E290BB62B6311ACBB6A15E58E7D69E724F26A31CB37D6900E9230F57F4DF10EB5A0B8FB05ECA917FCF263BA33FF000135487514A7E7A4D2634EC7A3E95F15ED9E2DBAB59491CA07DFB6E437E07914579A98016EB4547B3468A6CB45CB360559B74FE23C7D6AA85C1039AB8DFBB402B4321D2C83CCDA00DA2AA97CB914C9A50BD383512B6324F7A57B01D0F80AD92FFC7F63E68CC506E95BF015E8DE2AD324D62F66BEBC51B154A4287A2AFAD70BF09A555F16CDBC677C5B413F5CD7ACF890A7D9B633041B49663D1463AD6327A9BC363C3F10D9471695212FA5EA1BA44940FF0056D9C06FAAF422A468059E9775A45EBAB5E592B4B6CFEABFC4A3D8FDE1516928F72BA859C4167D2D32C2EE4C22C0FD9F27B1F4EF5D8FC35F0E58F88A23A96ACA973259EEB745DC76C8BD413FDE1DAA62CA31FE1B4FAB5B6B4BAC59EFF2E44092C2178988F6FEB5F404BACDA43A449A9DC3F970C285E407AAE3A8ACFD2ECAC2CDF16D69142DB3F81715E61F1775E61769A359CC57CE50F748BD1867E5069A57D04DD95CE0BC45AEDC78A35FB9D4EE3A48D88A3FEE20E82B3CB0140511A6075A6E4035BA5656307A8EC647CDD2A094C89F2A206F727A5481C3B119E7BD2F6C0A1EA08ADE54B273249F82714E54DBC0A79F97BE4520E7D68481884E09A729E6A3EA69EA6811271D68A681C514CA458CE179EB4E9A6F97D699FC155E7FBB49E824AE412CDB9FD6A6C3795935557EFD5D6FF8F7A92EC76DF09ACCBEAED718E926DCFF00C0735DDFC459E38F42BA12CA638CAE1D87DEC67A0F735CA7C20FBEFF00F5F1FF00B2D6A7C5CFF917E6FF00AEA958B7A9AAD8F38BCCDE58C0241F60D0ADFA4487991BD07F7DFDFB577FF0C8CCFAB472B2A5B59490B450C45BAE39C2FAFB9AE03C5FFF001EDA2FFD7A57A0786FFE43BE0CFF00AF47FEB4E3BB11E91A86A10689A5DEEA372C1628138F73D857CDF7D7936ABA9DC6A170732CEE5CFF00B23B0AF68F8A7FF2224DFF005F495E229F72AE9A22A31AE71F5A8B3BAA47FBFF0085442B53262BAE4829C35383051D71EA4D3569B2FDCFC6829210B17CE385FE7413C53EA36A04263EB4E029DFC34A940EC2A74C74A29B37DC1F5A295C691FFFD9);
