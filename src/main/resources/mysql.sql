/*用户表*/
DROP TABLE IF EXISTS `guess_user`;
CREATE TABLE `guess_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `userName` varchar(128) NOT NULL COMMENT '用户名',
  `passWord` varchar(128) NOT NULL COMMENT '密码(md5加密过后的)',
  `withdrawPassword` varchar(128) COMMENT '取款密码',
  `balance` decimal(14, 5) COMMENT '帐户余额',
  `nickName` varchar(128) COMMENT '昵称',
  `qq` varchar(128) COMMENT 'qq',
  `phone` varchar(128) COMMENT '手机号码',
  `email` varchar(128) COMMENT '电子邮箱',
  `registTime` datetime COMMENT '注册时间',
  `lastLoginIp` varchar(128) COMMENT '最后登陆ip',
  `lastLoginTime` datetime COMMENT '最后登陆时间',
  `lastLoginType` enum('WEB', 'APP') COMMENT '最后登陆类型',
  `createTime` datetime COMMENT '记录创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userName` (`userName`)
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

show tables;
