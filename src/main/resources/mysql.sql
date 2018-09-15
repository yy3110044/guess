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
  `realName` varchar(128) COMMENT '真实姓名',
  `qq` varchar(128) COMMENT 'qq',
  `phone` varchar(128) COMMENT '手机号码',
  `email` varchar(128) COMMENT '电子邮箱',
  `registTime` datetime COMMENT '注册时间',
  `lastLoginIp` varchar(128) COMMENT '最后登陆ip',
  `lastLoginTime` datetime COMMENT '最后登陆时间',
  `lastLoginType` enum('WEB', 'APP') COMMENT '最后登陆类型',
  `superUserId` int(11) COMMENT '父用户ID，0代表顶级用户',
  `rebateRate` decimal(4, 4) COMMENT '返点率',
  `subordinateDefaultRebateRate` decimal(4, 4) COMMENT '下级注册时默认返点(不能大于自己的返点)',
  `createTime` datetime COMMENT '记录创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userName` (`userName`),
  KEY `superUserId` (`superUserId`)
) ENGINE=InnoDB AUTO_INCREMENT=100001 DEFAULT CHARSET=utf8;

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
INSERT INTO guess_config VALUES(null, 'userRebateRateMax', '0.1', '用户返点率上限');
INSERT INTO guess_config VALUES(null, 'userRebateRateMin', '0', '用户返点率下限');
INSERT INTO guess_config VALUES(null, 'platformRate', '0.05', '平台抽成');
INSERT INTO guess_config VALUES(null, 'returnRate', '1', '返还率，此参数影响赔率');
INSERT INTO guess_config VALUES(null, 'betAmountMin', '0.01', '下注金额下限，单位：元');
INSERT INTO guess_config VALUES(null, 'betAmountMax', '10000', '下注金额上限，单位：元');
INSERT INTO guess_config VALUES(null, 'customerServiceUrl', 'https://www.baidu.com/', '客服链接');
INSERT INTO guess_config VALUES(null, 'clientLoadDataInterval', '60', '客户端加载数据间隔，单位：秒');

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
  `matchLogoUrl` varchar(512) NOT NULL COMMENT '赛事logo图',
  `sportId` int(11) NOT NULL COMMENT '运动类型id',
  `sportName` varchar(128) NOT NULL COMMENT '运动类型名',
  `sportLogoUrl` varchar(512) NOT NULL COMMENT '运动logo图',
  `leftTeamId` int(11) NOT NULL COMMENT '比赛队伍，关联team表id',
  `leftTeamName` varchar(128) NOT NULL COMMENT '比赛队伍名',
  `rightTeamId` int(11) NOT NULL COMMENT '比赛队伍，关联team表id',
  `rightTeamName` varchar(128) NOT NULL COMMENT '比赛队伍名',
  `leftTeamLogoUrl` varchar(512) COMMENT '左team logo',
  `rightTeamLogoUrl` varchar(512) COMMENT '右team logo',
  `leftTeamScore` int(11) COMMENT '左team得分或者bo胜局',
  `rightTeamScore` int(11) COMMENT '右team得分或者bo胜局',
  `playTypeCount` int(11) COMMENT '此对阵下的玩法数',
  `startTime` datetime COMMENT '对阵开始时间',
  `endTime` datetime COMMENT '对阵结束时间',
  `status` enum('未开始', '进行中', '已结束', '未比赛') COMMENT '比赛状态',
  `autoSwitchStatus` bit(1) COMMENT '开始时间到时，自动变更状态为进行中',
  `boCount` tinyint COMMENT '几局定胜负',
  `realBoCount` tinyint COMMENT '实际比赛局数',
  `result` tinyint COMMENT '比赛结果：负数为左team赢、零为平、正数为右team赢',
  `createTime` datetime COMMENT '记录创建时间',
  PRIMARY KEY (`id`),
  KEY `matchId` (`matchId`),
  KEY `status` (`status`),
  KEY `sportId` (`sportId`),
  KEY `leftTeamId` (`leftTeamId`),
  KEY `rightTeamId` (`rightTeamId`),
  KEY `startTime` (`startTime`)
) ENGINE=InnoDB AUTO_INCREMENT=10000 DEFAULT CHARSET=utf8;

/*赛事对阵bo表*/
DROP TABLE IF EXISTS `guess_match_versus_bo`;
CREATE TABLE `guess_match_versus_bo` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `versusId` int(11) NOT NULL COMMENT '对阵表id，关联versus表id',
  `bo` tinyint COMMENT '比赛场次，从1开始',
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

/*玩法(投注)类型表*/
DROP TABLE IF EXISTS `guess_play_type`;
CREATE TABLE `guess_play_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `versusId` int(11) COMMENT '对阵id',
  `name` varchar(64) COMMENT '玩法名',
  `bo` tinyint COMMENT '对应比赛场次，从1开始，0代表总对阵',
  `paramStr` varchar(128) COMMENT '此玩法需要用到的参数，json格式字符串',
  `templateClass` varchar(128) COMMENT '模版类class',
  `pause` bit(1) COMMENT '是否暂停竞猜',
  `guessStart` bit(1) COMMENT '是否开启竞猜',
  `leftGuessName` varchar(128) COMMENT '左方竞猜名',
  `rightGuessName` varchar(128) COMMENT '右方竞猜名',
  `leftWinRate` decimal(15, 6) COMMENT '左方预计胜率(根据这个算出初始赔率)',
  `rightWinRate` decimal(15, 6) COMMENT '右方预计胜率(根据这个算出始赔率)',
  `leftBonusPool` decimal(15, 6) COMMENT '左方奖金池',
  `rightBonusPool` decimal(15, 6) COMMENT '右方奖金池',
  `fixedOdds` bit(1) COMMENT '是否固定赔率',
  `createTime` datetime COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `versusId` (`versusId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*下注表*/
DROP TABLE IF EXISTS `guess_bet`;
CREATE TABLE `guess_bet` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `versusId` int(11) COMMENT '对阵id',
  `bo` tinyint COMMENT '对应比赛场次，从1开始，0代表总对阵',
  `playTypeId` int(11) COMMENT '玩法id',
  `userId` int(11) COMMENT '下注用户 id',
  `userName` varchar(128) COMMENT '下注用户名',
  `betDirection` enum('LEFT', 'RIGHT') COMMENT '下注的哪一方',
  `leftOdds` decimal(15, 6) COMMENT '下注时左方赔率',
  `rightOdds` decimal(15, 6) COMMENT '下注时右方赔率',
  `betAmount` decimal(15, 6) COMMENT '下注金额',
  `realPayBonus` decimal(15, 6) COMMENT '真实发放奖金',
  `status` enum('已下注', '未猜中', '已结算', '已退回') COMMENT '是否已结算',
  `createTime` datetime COMMENT '创建时间',
  KEY `versusId` (`versusId`),
  KEY `playTypeId` (`playTypeId`),
  KEY `userId` (`userId`),
  KEY `status` (`status`),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*交易流水表*/
DROP TABLE IF EXISTS `guess_trade_flow`;
CREATE TABLE `guess_trade_flow` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `userId` int(11) COMMENT '用户id',
  `userName` varchar(128) COMMENT '用户名',
  `preBalance` decimal(15, 6) COMMENT '变动前余额',
  `amount` decimal(15, 6) COMMENT '变动金额',
  `type` enum('下注 ', '退款', '返点', '返奖', '充值', '提现', '其它') COMMENT '类型',
  `description` varchar(256) COMMENT '描述',
  `createTime` datetime COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  KEY `type` (`type`),
  KEY `userId_type` (`userId`, `type`),
  KEY `createTime` (`createTime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*平台抽成记录*/
DROP TABLE IF EXISTS `guess_rate_record`;
CREATE TABLE `guess_rate_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `userId` int(11) COMMENT '用户id',
  `betId` int(11) COMMENT 'betId',
  `amount` decimal(15, 6) COMMENT '抽成金额',
  `platformRate` decimal(15, 6) COMMENT '抽成时的平台费率',
  `createTime` datetime COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `createTime` (`createTime`)
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

/*用户通知*/
DROP TABLE IF EXISTS `guess_user_notice`;
CREATE TABLE `guess_user_notice`(
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `userId` int(11) NOT NULL COMMENT '用户id',
  `userName` varchar(128) COMMENT '用户名',
  `content` varchar(256) NOT NULL COMMENT '通知内容',
  `hadRead` bit(1) COMMENT '是否已读取',
  `readTime` datetime COMMENT '用户读取时间',
  `createTime` datetime COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*系统通知*/
DROP TABLE IF EXISTS `guess_system_notice`;
CREATE TABLE `guess_system_notice`(
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `content` varchar(256) COMMENT '通知内容',
  `top` int(11) COMMENT '置顶排序字段',
  `createTime` datetime COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `top` (`top`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

show tables;
