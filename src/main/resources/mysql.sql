DROP DATABASE IF EXISTS `guess`;
CREATE DATABASE `guess`;
USE `guess`;

/*用户表*/
DROP TABLE IF EXISTS `guess_user`;
CREATE TABLE `guess_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `userName` varchar(128) NOT NULL COMMENT '用户名',
  `passWord` varchar(128) NOT NULL COMMENT '密码(md5加密过后的)',
  `withdrawPassword` varchar(128) COMMENT '取款密码',
  `balance` decimal(15, 6) COMMENT '帐户余额',
  `nickName` varchar(128) COMMENT '昵称',
  `qq` varchar(128) COMMENT 'qq',
  `phone` varchar(128) COMMENT '手机号码',
  `email` varchar(128) COMMENT '电子邮箱',
  `registTime` datetime COMMENT '注册时间',
  `lastLoginIp` varchar(128) COMMENT '最后登陆ip',
  `lastLoginTime` datetime COMMENT '最后登陆时间',
  `lastLoginType` enum('WEB', 'APP') COMMENT '最后登陆类型',
  `superUserId` int(11) COMMENT '父用户ID，0代表顶级用户',
  `rebateRate` decimal(4, 4) COMMENT '返点率',
  `createTime` datetime COMMENT '记录创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userName` (`userName`)
  KEY `superUserId` (`superUserId`)
) ENGINE=InnoDB AUTO_INCREMENT=100001 DEFAULT CHARSET=utf8;

/*交易流水表*/
DROP TABLE IF EXISTS `guess_trading_flow`;
CREATE TABLE `guess_trading_flow` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*投注归档，投注结算后保存的归档*/
DROP TABLE IF EXISTS `guess_bet_archive`;
CREATE TABLE `guess_bet_archive` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `versusId` int(11) NOT NULL COMMENT '对阵id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*用户登陆日志*/
DROP TABLE IF EXISTS `guess_user_login_log`;
CREATE TABLE `guess_user_login_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `userId` int(11) COMMENT '用户id,关联user表id',
  `userName` varchar(128) COMMENT '用户名',
  `loginIp` varchar(128) COMMENT '登陆ip',
  `loginTime` datetime COMMENT '登陆时间',
  `loginType` enum('WEB', 'APP') COMMENT '登陆类型',
  `userAgent` varchar(512) COMMENT 'userAgent',
  `createTime` datetime COMMENT '记录创建时间',
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*管理员表*/
DROP TABLE IF EXISTS `guess_admin_user`;
CREATE TABLE `guess_admin_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `userName` varchar(128) NOT NULL COMMENT '用户名',
  `passWord` varchar(128) NOT NULL COMMENT '密码',
  `lastLoginIp` varchar(128) COMMENT '最后登陆IP',
  `lastLoginTime` datetime COMMENT '最后登陆时间',
  `createTime` datetime COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userName` (`userName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO guess_admin_user(userName, passWord, createTime) VALUES('admin', 'e10adc3949ba59abbe56e057f20f883e', now());

/*管理员登陆日志*/
DROP TABLE IF EXISTS `guess_admin_user_login_log`;
CREATE TABLE `guess_admin_user_login_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `adminUserId` int(11),
  `adminUserName` varchar(128),
  `loginIp` varchar(128),
  `loginTime` datetime,
  `userAgent` varchar(512),
  `createTime` datetime,
  PRIMARY KEY (`id`),
  KEY `adminUserId` (`adminUserId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*web配置表*/
DROP TABLE IF EXISTS `guess_config`;
CREATE TABLE `guess_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(128) NOT NULL COMMENT '键名',
  `val` varchar(128) COMMENT '值',
  `description` varchar(258) COMMENT '描述',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO guess_config VALUES(null, 'webTitle', '竞猜', '网站标题名');
INSERT INTO guess_config VALUES(null, 'uploadUrl', 'http://aidazhou.cn/staticSourceAdmin/fileUpload', '文件上传url');

/*体育运动表*/
DROP TABLE IF EXISTS `guess_sport`;
CREATE TABLE `guess_sport` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(128) NOT NULL COMMENT '运动名称',
  `logoUrl` varchar(512) COMMENT 'log图url',
  `description` varchar(512) COMMENT '运动描述',
  `createTime` datetime COMMENT '记录创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8;

/*赛事表*/
DROP TABLE IF EXISTS `guess_match`;
CREATE TABLE `guess_match` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `sportId` int(11) NOT NULL COMMENT '体育运动id，关联sportId表id',
  `sportName` varchar(128) COMMENT '体育运动名',
  `name` varchar(128) NOT NULL COMMENT '赛事名',
  `logoUrl` varchar(512) COMMENT 'log图url',
  `description` varchar(512) COMMENT '赛事描述',
  `startTime` datetime COMMENT '开始时间',
  `endTime` datetime COMMENT '结束时间',
  `status` enum('未开始', '进行中', '已结束', '未比赛') COMMENT '赛事状态',
  `createTime` datetime COMMENT '记录创建时间',
  PRIMARY KEY (`id`),
  KEY `sportId` (`sportId`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8;

/*赛事对阵表*/
DROP TABLE IF EXISTS `guess_match_versus`;
CREATE TABLE `guess_match_versus` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(128) COMMENT '对阵名，例如：小组赛、半绝赛',
  `matchId` int(11) NOT NULL COMMENT '赛事id，关联match表id',
  `matchName` varchar(128) NOT NULL COMMENT '赛事名',
  `leftTeamId` int(11) NOT NULL COMMENT '比赛队伍，关联team表id',
  `leftTeamName` varchar(128) NOT NULL COMMENT '比赛队伍名',
  `rightTeamId` int(11) NOT NULL COMMENT '比赛队伍，关联team表id',
  `rightTeamName` varchar(128) NOT NULL COMMENT '比赛队伍名',
  `startTime` datetime COMMENT '比赛开始时间',
  `status` enum('未开始', '进行中', '已结束', '未比赛') COMMENT '比赛状态',
  `boCount` tinyint COMMENT '几局定胜负',
  `realBoCount` tinyint COMMENT '实际比赛局数',
  `result` tinyint COMMENT '比赛结果：负数为左team赢、零为平、正数为右team赢',
  `createTime` datetime COMMENT '记录创建时间',
  PRIMARY KEY (`id`),
  KEY `matchId` (`matchId`),
  KEY `leftTeamId` (`leftTeamId`),
  KEY `rightTeamId` (`rightTeamId`)
) ENGINE=InnoDB AUTO_INCREMENT=10000 DEFAULT CHARSET=utf8;

/*赛事对阵bo表*/
DROP TABLE IF EXISTS `guess_match_versus_bo`;
CREATE TABLE `guess_match_versus_bo` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `versusId` int(11) NOT NULL COMMENT '对阵表id，关联versus表id',
  `bo` tinyint COMMENT '比赛场次',
  `status` enum('未开始', '进行中', '已结束', '未比赛') COMMENT '比赛状态',
  `result` tinyint COMMENT '比赛结果：负数为左team赢、零为平、正数为右team赢',
  `firstKillTeam` tinyint COMMENT '首杀(一血)队伍：负数为左team拿，零为无，正数为右team拿',
  `firstKillTime` int(11) COMMENT '首杀所用时间，单位：秒',
  `tenthKillTeam` tinyint COMMENT '十杀队伍：负数为左team拿，零为无，正数为右team拿',
  `tenthKillTime` int(11) COMMENT '十杀所用时间，单位：秒',
  `leftTeamKillCount` int(11) COMMENT '左team击杀(比分)数',
  `rightTeamKillCount` int(11) COMMENT '右team击杀(比分)数',
  `matchTime` int(11) COMMENT '比赛时长，单位：秒',
  `createTime` datetime COMMENT '记录创建时间',
  PRIMARY KEY (`id`),
  KEY `versusId` (`versusId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*比赛战队、队伍表*/
DROP TABLE IF EXISTS `guess_team`;
CREATE TABLE `guess_team` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `sportId` int(11) NOT NULL COMMENT '体育运动id，关联sportId表id',
  `sportName` varchar(128) COMMENT '体育运动名',
  `name` varchar(128) NOT NULL COMMENT '队伍名',
  `logoUrl` varchar(512) COMMENT 'log图url',
  `description` varchar(512) COMMENT '队伍描述',
  `createTime` datetime COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `sportId` (`sportId`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8;

show tables;
