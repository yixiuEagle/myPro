DROP TABLE IF EXISTS `tc_user`;
CREATE TABLE IF NOT EXISTS `tc_user` (
  `uid` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL DEFAULT '',
  `head` varchar(100) NOT NULL DEFAULT '',
  `extend` text NOT NULL DEFAULT '',
  `password` varchar(100) NOT NULL DEFAULT '' COMMENT '密码',
  KEY (`uid`),
  UNIQUE (`uid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 ;

DROP TABLE IF EXISTS `tc_user_push`;
CREATE TABLE IF NOT EXISTS `tc_user_push` (
	`uid` int(11) NOT NULL COMMENT '用户',
	`udid` varchar(100) NOT NULL COMMENT '设备号',
	`bnotice` tinyint(1) NOT NULL DEFAULT '1' COMMENT '0-不接收 1-接收',
	key (`uid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT '用户ios消息推送表';