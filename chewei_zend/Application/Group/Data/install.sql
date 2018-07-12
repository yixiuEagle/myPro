DROP TABLE IF EXISTS `tc_group`;
CREATE TABLE IF NOT EXISTS `tc_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL COMMENT '创建者',
  `name` varchar(100) NOT NULL DEFAULT '',
  `logosmall` varchar(128) NOT NULL DEFAULT '',
  `description` varchar(255) NOT NULL DEFAULT '',
  `extend` text NOT NULL DEFAULT '',
  `createtime` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

DROP TABLE IF EXISTS `tc_group_user`;
CREATE TABLE IF NOT EXISTS `tc_group_user` (
  `groupid` int(11) unsigned NOT NULL DEFAULT '0',
  `uid` int(11) unsigned NOT NULL DEFAULT '0',
  `role` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0-成员 1-创建者',
  `getmsg` tinyint(1) DEFAULT '1' COMMENT '0-不接收 1-接收',
  `addtime` int(11) NOT NULL DEFAULT '0',
  KEY `groupid` (`groupid`,`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;