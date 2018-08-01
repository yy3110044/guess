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
  `lastLoginTime` datetime COMMENT '最后登陆时间',
  `lastLoginIp` varchar(128) COMMENT '最后登陆ip',
  `createTime` datetime COMMENT '记录创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userName` (`userName`)
) ENGINE=InnoDB AUTO_INCREMENT=100001 DEFAULT CHARSET=utf8;

show tables;
