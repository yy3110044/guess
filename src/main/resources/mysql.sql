DROP DATABASE IF EXISTS `guess`;
CREATE DATABASE `guess`;
USE `guess`;

/*用户表*/
DROP TABLE IF EXISTS `guess_user`;
CREATE TABLE `guess_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `userName` varchar(128) NOT NULL COMMENT '用户名',
  `passWord` varchar(128) NOT NULL COMMENT '密码(md5加密过后的)',
  `withdrawPassWord` varchar(128) COMMENT '取款密码',
  `balance` decimal(15, 6) COMMENT '帐户余额',
  `nickName` varchar(128) COMMENT '昵称',
  `realName` varchar(128) COMMENT '真实姓名',
  `realNameLock` bit(1) COMMENT '真实姓名锁定，锁定后不可更改',
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
  UNIQUE KEY `phone` (`phone`),
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
INSERT INTO guess_config VALUES(null, 'withdrawalMin', '100', '最小提款金额');
INSERT INTO guess_config VALUES(null, 'withdrawalMax', '10000', '最大提款金额');
INSERT INTO guess_config VALUES(null, 'payMin', '10', '最小充值金额');
INSERT INTO guess_config VALUES(null, 'payMax', '10000', '最大充值金额');

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
  `versusBoId` int(11) COMMENT '关联versusBo表的id，如果是总对阵则为0',
  `status` enum('未开始', '进行中', '已结束', '未比赛') COMMENT '对应Matchversus、MatchversusBo的status',
  `result` tinyint COMMENT '结果',
  `paramStr` varchar(128) COMMENT '此玩法需要用到的参数，json格式字符串',
  `templateClass` varchar(128) COMMENT '模版类class',
  `pause` bit(1) COMMENT '是否暂停竞猜',
  `guessStart` bit(1) COMMENT '是否开启竞猜，竞猜是否结束，true为未结束，false为结束',
  `leftGuessName` varchar(128) COMMENT '左方竞猜名',
  `rightGuessName` varchar(128) COMMENT '右方竞猜名',
  `leftWinRate` decimal(15, 6) COMMENT '左方预计胜率(根据这个算出初始赔率)',
  `rightWinRate` decimal(15, 6) COMMENT '右方预计胜率(根据这个算出始赔率)',
  `leftBonusPool` decimal(15, 6) COMMENT '左方奖金池',
  `rightBonusPool` decimal(15, 6) COMMENT '右方奖金池',
  `fixedOdds` bit(1) COMMENT '是否固定赔率',
  `changeOddsMin` decimal(15, 6) COMMENT '变动赔率下限，为零表示不限制',
  `changeOddsMax` decimal(15, 6) COMMENT '变动赔率上限，为零表示不限制',
  `createTime` datetime COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `versusId` (`versusId`),
  KEY `versusBoId` (`versusBoId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*下注表*/
DROP TABLE IF EXISTS `guess_bet`;
CREATE TABLE `guess_bet` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `orderNumber` char(64) NOT NULL COMMENT '订单号',
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
  UNIQUE KEY `orderNumber` (`orderNumber`),
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
  `title` varchar(256) NOT NULL COMMENT '通知标题',
  `content` text NOT NULL COMMENT '通知内容',
  `hadRead` bit(1) COMMENT '是否已读取',
  `readTime` datetime COMMENT '用户读取时间',
  `systemNotice` bit(1) COMMENT '是否是系统通知',
  `createTime` datetime COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*系统通知*/
DROP TABLE IF EXISTS `guess_system_notice`;
CREATE TABLE `guess_system_notice`(
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `content` varchar(512) COMMENT '通知内容',
  `top` int(11) COMMENT '置顶排序字段',
  `createTime` datetime COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `top` (`top`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*用户银行帐号*/
DROP TABLE IF EXISTS `guess_user_bank_account`;
CREATE TABLE `guess_user_bank_account`(
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `userId` int(11) NOT NULL COMMENT '用户ID',
  `userName` varchar(128) NOT NULL COMMENT '用户名',
  `bankCode` varchar(128) COMMENT '银行代码，例：ALIPAY、ICBC',
  `bankName` varchar(128) COMMENT '银行名',
  `bankAccount` varchar(128) COMMENT '银行帐号',
  `bankAccountName` varchar(128) COMMENT '开户人姓名',
  `createTime` datetime COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*用户提款*/
DROP TABLE IF EXISTS `guess_user_withdrawal`;
CREATE TABLE `guess_user_withdrawal` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `userId` int(11) NOT NULL COMMENT '用户ID',
  `userName` varchar(128) NOT NULL COMMENT '用户名',
  `amount` decimal(15, 6) COMMENT '提款金额',
  `bankCode` varchar(128) COMMENT '银行代码，例：ALIPAY、ICBC',
  `bankName` varchar(128) COMMENT '银行名',
  `bankAccount` varchar(128) COMMENT '银行帐号',
  `bankAccountName` varchar(128) COMMENT '开户人姓名',
  `status` enum('处理中', '已拒绝', '已同意') COMMENT '状态',
  `remark` varchar(256) COMMENT '备注',
  `createTime` datetime COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*充值支付订单*/
DROP TABLE IF EXISTS `guess_pay_order`;
CREATE TABLE `guess_pay_order` (
  `id` char(64) NOT NULL COMMENT '主键ID，使用UUID',
  `userId` int(11) NOT NULL COMMENT '用户ID',
  `userName` varchar(128) NOT NULL COMMENT '用户名',
  `amount` decimal(15, 6) COMMENT '充值金额',
  `subject` varchar(128) COMMENT '商品名',
  `payType` varchar(128) COMMENT '支付类型，如：ALIPAY_WAP、ALIPAY_PC等',
  `status` enum('未支付', '已支付', '支付异常') COMMENT '订单状态',
  `notifyTime` datetime COMMENT '服务商回调通知时间',
  `notifyCount` int(11) COMMENT '服务商回调通知次数',
  `createTime` datetime COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  KEY `createTime` (`createTime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


/*********************************NEW*****************************************/
/*竞猜项目new*/
DROP TABLE IF EXISTS `new_guess_item`;
CREATE TABLE `new_guess_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(128) NOT NULL COMMENT '项目名称',
  `logoUrl` varchar(512) COMMENT 'log图url',
  `description` varchar(512) COMMENT '项目描述',
  `createTime` datetime COMMENT '记录创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8;

/*竞猜对阵new*/
DROP TABLE IF EXISTS `new_guess_versus`;
CREATE TABLE `new_guess_versus` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(512) NOT NULL COMMENT '竞猜名称',
  `logoUrl` varchar(512) COMMENT 'logo图url',
  `itemId` int(11) NOT NULL COMMENT '类目id，new_guess_item id',
  `itemName` varchar(128) COMMENT '类目名',
  `returnRate` decimal(15, 6) COMMENT '赔率返还率，默认为1',
  `betAmountMin` decimal(15, 6) COMMENT '下注金额下限，单位：元',
  `betAmountMax` decimal(15, 6) COMMENT '下注金额上限，单位：元',
  `betAllAmount` decimal(15, 6) COMMENT '下注总金额',
  `startTime` datetime COMMENT '开始时间',
  `endTime` datetime COMMENT '结束时间(如果创建对阵时设置了结束时间，那么时间到的时候就自动暂停下注，如果没有设置，则在结果对阵结果时设置这个时间)',
  `betPause` bit(1) COMMENT '是否暂停下注',
  `winner` int(11) COMMENT '胜的那个结果new_guess_versus_item id，零表示未结束(还没有结果)，负数表示流局',
  `status` enum('未开始', '进行中', '已结束', '流局') COMMENT '状态',
  `superVersusId` int(11) COMMENT '属于哪个父对阵，零表示没有父对阵',
  `childVersusCount` int(11) COMMENT '子对阵数量',
  `createTime` datetime COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `itemId` (`itemId`),
  KEY `superVersusId` (`superVersusId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*竞猜类目表*/
DROP TABLE IF EXISTS `new_guess_versus_item`;
CREATE TABLE `new_guess_versus_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(256) NOT NULL COMMENT '竞猜名',
  `versusId` int(11) NOT NULL COMMENT '对阵id',
  `betAmount` decimal(15, 6) COMMENT '下注金额',
  `fixedOdds` bit(1) COMMENT '是否固定赔率',
  `odds` decimal(15, 6) COMMENT '赔率，当赔率为固定时，使用此值',
  `changeOddsMin` decimal(15, 6) COMMENT '变动赔率下限，为零表示不限制',
  `changeOddsMax` decimal(15, 6) COMMENT '变动赔率上限，为零表示不限制',
  `createTime` datetime COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `versusId` (`versusId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

show tables;
