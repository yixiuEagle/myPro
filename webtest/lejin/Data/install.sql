-- phpMyAdmin SQL Dump
-- version phpStudy 2014
-- http://www.phpmyadmin.net
--
-- 主机: 127.0.0.1
-- 生成日期: 2014-12-02 08:56:23
-- 服务器版本: 5.5.36-log
-- PHP 版本: 5.4.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- 数据库: `tc_sdk`
--

-- --------------------------------------------------------

--
-- 表的结构 `tc_admin`
--

DROP TABLE IF EXISTS `tc_admin`;
CREATE TABLE IF NOT EXISTS `tc_admin` (
  `userid` mediumint(6) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(20) DEFAULT NULL,
  `password` varchar(32) DEFAULT NULL,
  `roleid` smallint(5) DEFAULT '0',
  `encrypt` varchar(6) DEFAULT NULL,
  `lastloginip` varchar(15) DEFAULT NULL,
  `lastlogintime` int(10) unsigned DEFAULT '0',
  `lastlifetime` int(10) unsigned DEFAULT '0',
  `email` varchar(40) DEFAULT NULL,
  `realname` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`userid`),
  KEY `username` (`username`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 COMMENT='后台管理员表';

--
-- 表的结构 `tc_admin_role`
--

DROP TABLE IF EXISTS `tc_admin_role`;
CREATE TABLE IF NOT EXISTS `tc_admin_role` (
  `roleid` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `rolename` varchar(50) NOT NULL,
  `description` text NOT NULL,
  `listorder` smallint(5) unsigned NOT NULL DEFAULT '0',
  `disabled` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`roleid`),
  KEY `listorder` (`listorder`),
  KEY `disabled` (`disabled`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2  COMMENT='后台角色表';

--
-- 转存表中的数据 `tc_admin_role`
--

INSERT INTO `tc_admin_role` (`roleid`, `rolename`, `description`, `listorder`, `disabled`) VALUES
(1, '超级管理员', '超级管理员', 0, 0);

-- --------------------------------------------------------

--
-- 表的结构 `tc_admin_role_priv`
--

DROP TABLE IF EXISTS `tc_admin_role_priv`;
CREATE TABLE IF NOT EXISTS `tc_admin_role_priv` (
  `roleid` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `m` char(20) NOT NULL,
  `a` char(20) NOT NULL,
  `data` char(30) NOT NULL DEFAULT '',
  KEY `roleid` (`roleid`,`m`,`a`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='权限表';

-- --------------------------------------------------------

--
-- 表的结构 `tc_group`
--

DROP TABLE IF EXISTS `tc_group`;
CREATE TABLE IF NOT EXISTS `tc_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(50) NOT NULL DEFAULT '' COMMENT '创建者',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '群名称',
  `logosmall` varchar(128) NOT NULL DEFAULT '' COMMENT '群logo',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '群描述',
  `extend` text NOT NULL DEFAULT '' COMMENT '扩展字段',
  `createtime` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 COMMENT='群表';

-- --------------------------------------------------------

--
-- 表的结构 `tc_group_user`
--

DROP TABLE IF EXISTS `tc_group_user`;
CREATE TABLE IF NOT EXISTS `tc_group_user` (
  `groupid` int(11) unsigned NOT NULL DEFAULT '0',
  `uid` varchar(50) NOT NULL DEFAULT '' COMMENT '用户id',
  `role` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0-成员 1-创建者',
  `getmsg` tinyint(1) DEFAULT '1' COMMENT '0-不接收 1-接收',
  `addtime` int(11) NOT NULL DEFAULT '0',
  KEY `groupid` (`groupid`,`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='群组用户表';

-- --------------------------------------------------------

--
-- 表的结构 `tc_lincense`
--

DROP TABLE IF EXISTS `tc_lincense`;
CREATE TABLE IF NOT EXISTS `tc_lincense` (
  `id` int(11) NOT NULL,
  `default` varchar(2000) NOT NULL,
  `lincense` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='授权表';

--
-- 转存表中的数据 `tc_lincense`
--

INSERT INTO `tc_lincense` (`id`, `default`, `lincense`) VALUES
(1, 'azJoeWpldTIqazJ5fnZ/MiprMn9idHVieXQyKjIhICAyPDJxc39lfmQyKjIhICAyPDJ5YDIqMj0hMjwydH99cXl+MioyPSEyPDJ/YnR1YmR5fXUyKiEkISAiIyYkIiA8MnVoYHlidWR5fXUyKiEnIiUoJSUmIiA8MmBxaX11ZHh/dDIqMiEybTwydHVmeXN1MiprMnF+dGJ/eXQyKjIhMjwyeWB4f351MioyITI8MnF+dGJ/eXRPYHF0MioyIDI8MnlgcXQyKjIgMjwyZ3VyMioyIDI8Mmd5fnR/Z2NPYHMyKjIgMm08MnZ1cWRlYnUyKmsyc3hxZDIqazJ9cWhlY3VifmV9MioyISAgMjwyfXFof358eX51ZWN1Yn5lfTIqMiEgIDJtPDJ3Yn9lYDIqazJ9cWh3Yn9lYH5lfTIqMiIgMjwyfXFod2J/ZWBgdWJjf35+ZX0yKjIhICAybTwyZWN1YjIqazJ8f3d5fn1lfGR5YHx1dHVmeXN1MioyIDI8Mn1lfGR5YHx1ZWN1YjIqMiAybW08MmBxaTIqMnhkZGAqTD9MP2dnZz5oeWpldT5zf31MP2BxaTI8MnVoYHlidX9idHVieXQyKjIyPDJmdWJjeX9+MioyIT4gPiAybW0=', NULL);

-- --------------------------------------------------------

--
-- 表的结构 `tc_menu`
--

DROP TABLE IF EXISTS `tc_menu`;
CREATE TABLE IF NOT EXISTS `tc_menu` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `name` char(40) NOT NULL DEFAULT '',
  `parentid` smallint(6) NOT NULL DEFAULT '0',
  `module` varchar(40) NOT NULL DEFAULT '',
  `m` char(20) NOT NULL DEFAULT '',
  `a` char(20) NOT NULL DEFAULT '',
  `data` char(100) NOT NULL DEFAULT '',
  `listorder` smallint(6) unsigned NOT NULL DEFAULT '0',
  `display` enum('1','0') NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `listorder` (`listorder`),
  KEY `parentid` (`parentid`),
  KEY `module` (`m`,`a`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=36 COMMENT='后台菜单表';

--
-- 转存表中的数据 `tc_menu`
--

INSERT INTO `tc_menu` (`id`, `name`, `parentid`, `module`, `m`, `a`, `data`, `listorder`, `display`) VALUES
(1, '我的面板', 0, '', 'Index', 'index', '', 1, '1'),
(2, '管理员', 0, '', 'Back', 'index', '', 2, '1'),
(3, '系统', 0, '', 'System', 'index', '', 3, '1'),
(4, '网站管理', 0, '', 'Website', 'index', '', 4, '1'),
(5, '个人信息', 1, 'Admin', 'Admin', 'personal', '', 0, '1'),
(8, '修改密码', 5, 'Admin', 'Admin', 'public_editPwd', '', 1, '1'),
(9, '修改个人信息', 5, 'Admin', 'Admin', 'public_editInfo', '', 0, '1'),
(7, '菜单管理', 3, 'Admin', 'Menu', 'index', '', 2, '1'),
(12, '菜单列表', 7, 'Admin', 'Menu', 'index', '', 1, '1'),
(6, '管理员管理', 2, 'Admin', 'Admin', 'index', '', 2, '1'),
(10, '管理员列表', 6, 'Admin', 'Admin', 'index', '', 1, '1'),
(11, '角色列表', 6, 'Admin', 'Admin', 'roleList', '', 2, '1'),
(13, '模块管理', 3, 'Admin', 'Module', 'index', '', 1, '1'),
(14, '模块列表', 13, 'Admin', 'Module', 'index', '', 0, '1'),
(15, '用户管理', 4, 'User', 'User', 'index', '', 1, '1'),
(16, '用户列表', 15, 'User', 'User', 'index', '', 0, '1'),
(17, '群组管理', 4, 'Group', 'Group', 'index', '', 2, '1'),
(18, '群组列表', 17, 'Group', 'Group', 'index', '', 0, '1'),
(23, '会话管理', 4, 'Session', 'Session', 'index', '', 3, '1'),
(24, '会话列表', 23, 'Session', 'Session', 'index', '', 0, '1'),
(25, '授权管理', 3, 'Lincense', 'Index', 'index', '', 0, '1'),
(26, '授权信息', 25, 'Lincense', 'Index', 'index', '', 0, '1'),
(27, '投置授权', 25, 'Lincense', 'Index', 'setLincense', '', 0, '1'),
(28, '数据备份', 3, 'Admin', 'Database', 'index', '', 0, '1'),
(29, '备份数据库', 28, 'Admin', 'Database', 'index', '', 0, '1'),
(30, '网站设置', 3, 'Admin', 'Logs', 'index', '', 0, '1'),
(31, 'Logs文件列表', 30, 'Admin', 'Logs', 'index', '', 3, '1'),
(32, '网站模式', 30, 'Admin', 'Logs', 'debug', '', 0, '1'),
(34, 'IOS推送设置', 30, 'Admin', 'Push', 'index', '', 1, '1'),
(35, 'IOS推送证书', 30, 'Admin', 'Push', 'upload', '', 2, '1');

-- --------------------------------------------------------

--
-- 表的结构 `tc_message`
--

DROP TABLE IF EXISTS `tc_message`;
CREATE TABLE IF NOT EXISTS `tc_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fromid` varchar(50) NOT NULL DEFAULT '0' COMMENT '发送者',
  `fromname` varchar(100) NOT NULL DEFAULT '',
  `fromhead` varchar(100) NOT NULL DEFAULT '',
  `fromextend` text NOT NULL COMMENT '发送者扩展',
  `toid` varchar(50) NOT NULL DEFAULT '0' COMMENT '接收者',
  `toname` varchar(100) NOT NULL DEFAULT '',
  `tohead` varchar(100) NOT NULL DEFAULT '',
  `toextend` text NOT NULL COMMENT '接收者扩展',
  `image` varchar(255) NOT NULL DEFAULT '' COMMENT '图片信息',
  `voice` varchar(255) NOT NULL DEFAULT '' COMMENT '语音信息',
  `file` varchar(255) NOT NULL DEFAULT '' COMMENT '文件信息',
  `location` varchar(255) NOT NULL DEFAULT '' COMMENT '位置信息',
  `content` varchar(500) NOT NULL DEFAULT '' COMMENT '文字内容',
  `extend` text NOT NULL COMMENT '消息的扩展',
  `bodyextend` text NOT NULL COMMENT '上传文件扩展',
  `typechat` smallint(3) NOT NULL DEFAULT '100' COMMENT '100-单聊 200-群聊',
  `typefile` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1-文字 2-图片 3-声音 4-位置',
  `tag` varchar(50) NOT NULL DEFAULT '',
  `time` varchar(15) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `from` (`fromid`),
  KEY `to` (`toid`),
  KEY `typechat` (`typechat`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 COMMENT='消息表';

-- --------------------------------------------------------

--
-- 表的结构 `tc_message_file`
--

DROP TABLE IF EXISTS `tc_message_file`;
CREATE TABLE IF NOT EXISTS `tc_message_file` (
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '文件名',
  `type` varchar(20) NOT NULL DEFAULT '' COMMENT '文件类型',
  `size` varchar(20) NOT NULL DEFAULT '' COMMENT '文件大小',
  `key` varchar(10) NOT NULL DEFAULT '' COMMENT '文件key',
  `ext` varchar(10) NOT NULL DEFAULT '' COMMENT '文件后缀名',
  `md5` varchar(50) NOT NULL DEFAULT '' COMMENT '文件md5值',
  `sha1` varchar(50) NOT NULL DEFAULT '' COMMENT '文件稀哈值',
  `savename` varchar(100) NOT NULL DEFAULT '' COMMENT '文件保存名',
  `savepath` varchar(100) NOT NULL DEFAULT '' COMMENT '文件路径',
  KEY `md5` (`md5`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='消息文件表';

-- --------------------------------------------------------

--
-- 表的结构 `tc_module`
--

DROP TABLE IF EXISTS `tc_module`;
CREATE TABLE IF NOT EXISTS `tc_module` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  `displayname` varchar(40) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '模块状态 0-未运行 1-运行中',
  `description` varchar(100) DEFAULT NULL,
  `version` varchar(20) NOT NULL,
  `author` varchar(20) DEFAULT NULL,
  `price` double DEFAULT '0',
  `createtime` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 COMMENT='模块表' ;

-- --------------------------------------------------------

--
-- 表的结构 `tc_notice`
--

DROP TABLE IF EXISTS `tc_notice`;
CREATE TABLE IF NOT EXISTS `tc_notice` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type` smallint(6) NOT NULL,
  `uid` varchar(255) NOT NULL DEFAULT '' COMMENT '通知人',
  `toUid` varchar(255) NOT NULL DEFAULT '',
  `content` text NOT NULL,
  `createtime` varchar(10) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 COMMENT='通知记录表';

-- --------------------------------------------------------

--
-- 表的结构 `tc_session`
--

DROP TABLE IF EXISTS `tc_session`;
CREATE TABLE IF NOT EXISTS `tc_session` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(50) NOT NULL DEFAULT '' COMMENT '用户id',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '会话名称',
  `createtime` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 COMMENT='临时会话表';

-- --------------------------------------------------------

--
-- 表的结构 `tc_session_user`
--

DROP TABLE IF EXISTS `tc_session_user`;
CREATE TABLE IF NOT EXISTS `tc_session_user` (
  `sessionid` int(11) unsigned NOT NULL DEFAULT '0',
  `uid` varchar(50) NOT NULL DEFAULT '' COMMENT '用户id',
  `role` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0-成员 1-创建者',
  `getmsg` tinyint(1) DEFAULT '1' COMMENT '0-不接收 1-接收',
  `addtime` int(11) NOT NULL DEFAULT '0',
  KEY `sessionid` (`sessionid`,`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='临时会话用户表';

-- --------------------------------------------------------

--
-- 表的结构 `tc_times`
--

DROP TABLE IF EXISTS `tc_times`;
CREATE TABLE IF NOT EXISTS `tc_times` (
  `username` char(40) NOT NULL,
  `ip` char(15) NOT NULL,
  `logintime` int(10) unsigned NOT NULL DEFAULT '0',
  `isadmin` tinyint(1) NOT NULL DEFAULT '0',
  `times` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`username`,`isadmin`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='后台管理员登录次数限制';

-- --------------------------------------------------------

--
-- 表的结构 `tc_user`
--

DROP TABLE IF EXISTS `tc_user`;
CREATE TABLE IF NOT EXISTS `tc_user` (
  `uid` int(11) NOT NULL auto_increment,
  `name` varchar(50) NOT NULL DEFAULT '',
  `head` varchar(100) NOT NULL DEFAULT '',
  `password` varchar(100) NOT NULL DEFAULT '' COMMENT '密码',
  `sign` varchar(128) NOT NULL DEFAULT '' COMMENT '用户签名',
  `extend` text NOT NULL,
  primary KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=200000 COMMENT='用户表' ;

--
-- 用户头像表
--
DROP TABLE IF EXISTS `tc_user_head`;
CREATE TABLE IF NOT EXISTS `tc_user_head` (
  `id` varchar(50) NOT NULL,
  `uid` int(11) NOT NULL DEFAULT '' COMMENT '用户',
  `originUrl` varchar(128) NOT NULL DEFAULT '' comment '用户名称',
  `smallUrl` varchar(128) NOT NULL DEFAULT '' comment '用户头像',
  `key` varchar(100) NOT NULL DEFAULT '' COMMENT 'key',
  unique KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户表对像表' ;

-- --------------------------------------------------------

--
-- 表的结构 `tc_user_push`
--

DROP TABLE IF EXISTS `tc_user_push`;
CREATE TABLE IF NOT EXISTS `tc_user_push` (
  `uid` varchar(50) NOT NULL COMMENT '用户',
  `udid` varchar(100) NOT NULL COMMENT '设备号',
  `bnotice` tinyint(1) NOT NULL DEFAULT '1' COMMENT '0-不接收 1-接收',
  KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户ios消息推送表';




->订单提交->待发货->后台商家点击发货(输入运单号)->配送中->（对用户）待收货->用户收货

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
