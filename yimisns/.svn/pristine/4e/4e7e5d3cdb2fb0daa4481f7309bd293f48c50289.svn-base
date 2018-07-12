-- phpMyAdmin SQL Dump
-- version phpStudy 2014
-- http://www.phpmyadmin.net
--
-- 主机: 127.0.0.1
-- 生成日期: 2016-02-24 02:42:15
-- 服务器版本: 5.5.36-log
-- PHP 版本: 5.4.26
drop database if exists yimi;
create database if not exists yimi;
use yimi;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- 数据库: `yimi`
--

DELIMITER $$
--
-- 函数
--
CREATE DEFINER=`root`@`localhost` FUNCTION `get_distance`(x1 double,y1 double,x2 double,y2 double) RETURNS double
BEGIN
declare Flattening,er,pix,z1,z2,d1,b1,b2,l1,l2,theta,distance double;
set Flattening=298.257223563002;
set er=6378.137;
set pix=3.1415926535;
set b1 = (0.5-x1/180)*pix;
set l1 = (y1/180)*pix; 
set b2 = (0.5-x2/180)*pix; 
set l2 = (y2/180)*pix; 
set x1 = er*COS(l1)*SIN(b1); 
set y1 = er*SIN(l1)*SIN(b1);
set z1 = er*COS(b1); 
set x2 = er*COS(l2)*SIN(b2); 
set y2 = er*SIN(l2)*SIN(b2); 
set z2 = er*COS(b2); 
set d1 = sqrt((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2)+(z1-z2)*(z1-z2)); 
set theta= acos((er*er+er*er-d1*d1)/(2*er*er)); 
set distance= theta*er; 
RETURN distance;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- 表的结构 `tc_admin`
--

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- 转存表中的数据 `tc_admin`
--

INSERT INTO `tc_admin` (`userid`, `username`, `password`, `roleid`, `encrypt`, `lastloginip`, `lastlogintime`, `lastlifetime`, `email`, `realname`) VALUES
(1, 'admin', '11e8ab79a9105712ede58e4bee9cd5a1', 1, 'ZEDrmj', '123.56.101.233', 1455757550, 1455791751, '', '');

-- --------------------------------------------------------

--
-- 表的结构 `tc_admin_role`
--

CREATE TABLE IF NOT EXISTS `tc_admin_role` (
  `roleid` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `rolename` varchar(50) NOT NULL,
  `description` text NOT NULL,
  `listorder` smallint(5) unsigned NOT NULL DEFAULT '0',
  `disabled` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`roleid`),
  KEY `listorder` (`listorder`),
  KEY `disabled` (`disabled`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- 转存表中的数据 `tc_admin_role`
--

INSERT INTO `tc_admin_role` (`roleid`, `rolename`, `description`, `listorder`, `disabled`) VALUES
(1, '超级管理员', '超级管理员', 0, 0);

-- --------------------------------------------------------

--
-- 表的结构 `tc_admin_role_priv`
--

CREATE TABLE IF NOT EXISTS `tc_admin_role_priv` (
  `roleid` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `m` char(20) NOT NULL,
  `a` char(20) NOT NULL,
  `data` char(30) NOT NULL DEFAULT '',
  KEY `roleid` (`roleid`,`m`,`a`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `tc_adv`
--

CREATE TABLE IF NOT EXISTS `tc_adv` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(11) NOT NULL DEFAULT '0',
  `img` varchar(200) NOT NULL,
  `url` varchar(200) DEFAULT '',
  `pos` int(11) NOT NULL DEFAULT '1',
  `sort` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- 转存表中的数据 `tc_adv`
--

INSERT INTO `tc_adv` (`id`, `type`, `img`, `url`, `pos`, `sort`) VALUES
(3, 0, 'http://yhcd.net/skin/images/banner.jpg', 'http://www.baidu.com', 1, 0),
(4, 0, 'http://yhcd.net/skin/images/banner.jpg', 'http://wwww.qq.com', 1, 0),
(5, 1, 'http://yhcd.net/skin/images/banner.jpg', 'http://www.baidu.com', 1, 0),
(6, 1, 'http://yhcd.net/skin/images/banner.jpg', 'http://wwww.qq.com', 1, 0);

-- --------------------------------------------------------

--
-- 表的结构 `tc_album`
--

CREATE TABLE IF NOT EXISTS `tc_album` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `smallurl` varchar(500) NOT NULL,
  `bigurl` varchar(500) NOT NULL,
  `uid` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='相册' AUTO_INCREMENT=3 ;

--
-- 转存表中的数据 `tc_album`
--

INSERT INTO `tc_album` (`id`, `name`, `smallurl`, `bigurl`, `uid`) VALUES
(1, 'fdf', 'http://img6.cache.netease.com/cnews/2016/1/10/201601101703369b0bc_550.jpg', 'http://img6.cache.netease.com/cnews/2016/1/10/201601101703369b0bc_550.jpg', 200007),
(2, '', 'http://img6.cache.netease.com/cnews/2016/1/10/201601101703369b0bc_550.jpg', 'http://img6.cache.netease.com/cnews/2016/1/10/201601101703369b0bc_550.jpg', 200007);

-- --------------------------------------------------------

--
-- 表的结构 `tc_consume_record`
--

CREATE TABLE IF NOT EXISTS `tc_consume_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  `type` int(1) NOT NULL DEFAULT '1' COMMENT '1-收入 0-支出',
  `money` double NOT NULL,
  `createtime` int(11) NOT NULL DEFAULT '0',
  `uid` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- 转存表中的数据 `tc_consume_record`
--

INSERT INTO `tc_consume_record` (`id`, `title`, `type`, `money`, `createtime`, `uid`) VALUES
(1, '充值', 1, 100, 1455761385, 200007),
(2, '消费', 0, 23.2, 1455761385, 200007);

-- --------------------------------------------------------

--
-- 表的结构 `tc_dynamic`
--

CREATE TABLE IF NOT EXISTS `tc_dynamic` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `title` varchar(500) DEFAULT NULL,
  `content` text NOT NULL,
  `lat` varchar(30) NOT NULL,
  `lng` varchar(30) NOT NULL,
  `sharecount` int(11) NOT NULL DEFAULT '0',
  `zancount` int(11) NOT NULL DEFAULT '0',
  `commentcount` int(11) NOT NULL DEFAULT '0',
  `createtime` int(11) DEFAULT NULL,
  `linkurl` varchar(500) DEFAULT NULL,
  `addr_lat` varchar(20) DEFAULT NULL,
  `addr_lng` varchar(20) DEFAULT NULL,
  `addr` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='动态表' AUTO_INCREMENT=3 ;

--
-- 转存表中的数据 `tc_dynamic`
--

INSERT INTO `tc_dynamic` (`id`, `uid`, `title`, `content`, `lat`, `lng`, `sharecount`, `zancount`, `commentcount`, `createtime`, `linkurl`, `addr_lat`, `addr_lng`, `addr`) VALUES
(1, 200007, 'showme', '', '30.6667720000', '104.0369670000', 1, 2, 12, 123, NULL, NULL, NULL, NULL),
(2, 200007, 'test', '', '30.6667720000', '104.0369670000', 0, 1, 1, 123, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- 表的结构 `tc_dynamic_comment`
--

CREATE TABLE IF NOT EXISTS `tc_dynamic_comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `replyuid` int(11) NOT NULL DEFAULT '0',
  `content` varchar(500) NOT NULL,
  `createtime` int(11) NOT NULL,
  `linkid` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=14 ;

--
-- 转存表中的数据 `tc_dynamic_comment`
--

INSERT INTO `tc_dynamic_comment` (`id`, `uid`, `replyuid`, `content`, `createtime`, `linkid`) VALUES
(1, 200008, 0, '1', 1452677633, 1),
(2, 200009, 0, '2', 1452677634, 1),
(3, 200009, 0, '0', 1452677635, 1),
(4, 200009, 0, '0', 1452677813, 1),
(5, 200009, 200008, 'don''t show', 1452678278, 1),
(6, 200009, 0, 'good123', 1452678422, 1),
(7, 200009, 0, 'good123', 1452678809, 1),
(8, 200009, 200007, '兔兔去同心协力', 1453338628, 1),
(9, 200009, 200007, '兔兔', 1453338655, 1),
(10, 200009, 200007, '、[emoji_340][emoji_346][emoji_347][emoji_347]', 1453440016, 1),
(11, 200009, 0, '[emoji_345][emoji_346][emoji_345]', 1453442299, 1),
(12, 200009, 0, '近距离', 1453444538, 2),
(13, 200017, 0, '兴民明敏', 1456278031, 1);

-- --------------------------------------------------------

--
-- 表的结构 `tc_dynamic_guest`
--

CREATE TABLE IF NOT EXISTS `tc_dynamic_guest` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `fuid` int(11) NOT NULL,
  `createtime` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- 转存表中的数据 `tc_dynamic_guest`
--

INSERT INTO `tc_dynamic_guest` (`id`, `uid`, `fuid`, `createtime`) VALUES
(1, 200008, 200007, 123),
(2, 200009, 200007, 123);

-- --------------------------------------------------------

--
-- 表的结构 `tc_dynamic_pic`
--

CREATE TABLE IF NOT EXISTS `tc_dynamic_pic` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `path` varchar(500) NOT NULL,
  `dynamicid` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- 转存表中的数据 `tc_dynamic_pic`
--

INSERT INTO `tc_dynamic_pic` (`id`, `path`, `dynamicid`) VALUES
(1, 'http://yhcd.net/skin/images/banner.jpg', 1),
(2, 'http://yhcd.net/skin/images/banner.jpg', 2);

-- --------------------------------------------------------

--
-- 表的结构 `tc_dynamic_share`
--

CREATE TABLE IF NOT EXISTS `tc_dynamic_share` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `linkid` int(11) NOT NULL,
  `createtime` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- 转存表中的数据 `tc_dynamic_share`
--

INSERT INTO `tc_dynamic_share` (`id`, `uid`, `linkid`, `createtime`) VALUES
(1, 200009, 1, 1452679193);

-- --------------------------------------------------------

--
-- 表的结构 `tc_dynamic_statistics`
--

CREATE TABLE IF NOT EXISTS `tc_dynamic_statistics` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `linkid` int(11) NOT NULL,
  `viewcount` int(11) NOT NULL DEFAULT '0',
  `zancount` int(11) NOT NULL DEFAULT '0',
  `forwardcount` int(11) NOT NULL DEFAULT '0',
  `followedcount` int(11) NOT NULL DEFAULT '0',
  `fee` double NOT NULL DEFAULT '0',
  `createtime` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='动态统计' AUTO_INCREMENT=3 ;

--
-- 转存表中的数据 `tc_dynamic_statistics`
--

INSERT INTO `tc_dynamic_statistics` (`id`, `linkid`, `viewcount`, `zancount`, `forwardcount`, `followedcount`, `fee`, `createtime`) VALUES
(1, 1, 100, 23, 34, 23, 123, 12345678),
(2, 2, 100, 23, 34, 23, 23, 12345678);

-- --------------------------------------------------------

--
-- 表的结构 `tc_dynamic_zan`
--

CREATE TABLE IF NOT EXISTS `tc_dynamic_zan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `linkid` int(11) NOT NULL,
  `content` varchar(20) NOT NULL,
  `createtime` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=12 ;

--
-- 转存表中的数据 `tc_dynamic_zan`
--

INSERT INTO `tc_dynamic_zan` (`id`, `uid`, `linkid`, `content`, `createtime`) VALUES
(1, 200008, 1, '', 1221111),
(6, 200009, 2, 'emoji_503', 1453443169),
(10, 200009, 1, 'emoji_511', 1453807676);

-- --------------------------------------------------------

--
-- 表的结构 `tc_group`
--

CREATE TABLE IF NOT EXISTS `tc_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(50) NOT NULL DEFAULT '' COMMENT '创建者',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '群名称',
  `logosmall` varchar(128) NOT NULL DEFAULT '' COMMENT '群logo',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '群描述',
  `extend` text NOT NULL COMMENT '扩展字段',
  `createtime` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `tc_group_user`
--

CREATE TABLE IF NOT EXISTS `tc_group_user` (
  `groupid` int(11) unsigned NOT NULL DEFAULT '0',
  `uid` varchar(50) NOT NULL DEFAULT '' COMMENT '用户id',
  `role` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0-成员 1-创建者',
  `getmsg` tinyint(1) DEFAULT '1' COMMENT '0-不接收 1-接收',
  `addtime` int(11) NOT NULL DEFAULT '0',
  KEY `groupid` (`groupid`,`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `tc_hometown`
--

CREATE TABLE IF NOT EXISTS `tc_hometown` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parentId` int(11) NOT NULL DEFAULT '0',
  `name` varchar(20) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- 转存表中的数据 `tc_hometown`
--

INSERT INTO `tc_hometown` (`id`, `parentId`, `name`) VALUES
(1, 0, '四川'),
(2, 1, '成都'),
(3, 1, '绵阳'),
(4, 0, '上海'),
(5, 4, '上海');

-- --------------------------------------------------------

--
-- 表的结构 `tc_hongbao`
--

CREATE TABLE IF NOT EXISTS `tc_hongbao` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `money` double NOT NULL DEFAULT '0',
  `singlemoney` double NOT NULL DEFAULT '0',
  `nums` int(11) NOT NULL,
  `fid` int(11) NOT NULL COMMENT '可能是群id或用户id',
  `type` int(11) NOT NULL DEFAULT '1' COMMENT '1-拼手气红包 2-普通红包',
  `title` varchar(100) NOT NULL DEFAULT '',
  `createtime` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='红包' AUTO_INCREMENT=2 ;

--
-- 转存表中的数据 `tc_hongbao`
--

INSERT INTO `tc_hongbao` (`id`, `uid`, `money`, `singlemoney`, `nums`, `fid`, `type`, `title`, `createtime`) VALUES
(1, 200007, 3.5, 0, 3, 200008, 1, '0', 1454272465);

-- --------------------------------------------------------

--
-- 表的结构 `tc_hongbao_record`
--

CREATE TABLE IF NOT EXISTS `tc_hongbao_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `hongbao_id` int(11) NOT NULL,
  `money` double NOT NULL DEFAULT '0',
  `isbest` int(11) DEFAULT '0',
  `createtime` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=13 ;

--
-- 转存表中的数据 `tc_hongbao_record`
--

INSERT INTO `tc_hongbao_record` (`id`, `uid`, `hongbao_id`, `money`, `isbest`, `createtime`) VALUES
(10, 200007, 1, 0.35116666666667, 0, 1454273677),
(11, 200008, 1, 1.73343275, 1, 1454273893),
(12, 200009, 1, 1.4154005833333, 0, 1454273897);

-- --------------------------------------------------------

--
-- 表的结构 `tc_htmlcontent`
--

CREATE TABLE IF NOT EXISTS `tc_htmlcontent` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(50) NOT NULL,
  `content` text NOT NULL,
  `createtime` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- 转存表中的数据 `tc_htmlcontent`
--

INSERT INTO `tc_htmlcontent` (`id`, `key`, `content`, `createtime`) VALUES
(1, 'memberprotocol', '会员协议内容', 12345678),
(2, 'yinshen', '定向隐身内容', 12345678),
(3, 'userprotocol', '用户协议', 12345678),
(4, 'guihuan', '规范', 12345678),
(5, 'shouyi', '收益分润', 12345678);

-- --------------------------------------------------------

--
-- 表的结构 `tc_huati`
--

CREATE TABLE IF NOT EXISTS `tc_huati` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- 转存表中的数据 `tc_huati`
--

INSERT INTO `tc_huati` (`id`, `title`) VALUES
(1, '2016春节'),
(2, '新年快乐');

-- --------------------------------------------------------

--
-- 表的结构 `tc_income`
--

CREATE TABLE IF NOT EXISTS `tc_income` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(11) NOT NULL,
  `state` int(1) NOT NULL DEFAULT '0' COMMENT '1-已领取 0-未领取',
  `linkid` int(11) NOT NULL DEFAULT '0',
  `fee` double NOT NULL DEFAULT '0',
  `createtime` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='收益表' AUTO_INCREMENT=2 ;

--
-- 转存表中的数据 `tc_income`
--

INSERT INTO `tc_income` (`id`, `type`, `state`, `linkid`, `fee`, `createtime`, `uid`) VALUES
(1, 1, 0, 1, 12, 12345678, 200007);

-- --------------------------------------------------------

--
-- 表的结构 `tc_job`
--

CREATE TABLE IF NOT EXISTS `tc_job` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parentId` int(11) NOT NULL DEFAULT '0',
  `name` varchar(20) NOT NULL DEFAULT '',
  `icon` varchar(200) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- 转存表中的数据 `tc_job`
--

INSERT INTO `tc_job` (`id`, `parentId`, `name`, `icon`) VALUES
(1, 0, '计算机', ''),
(2, 1, '移动互联网', ''),
(3, 1, 'PC', ''),
(4, 0, '金融', ''),
(5, 0, '农业', '');

-- --------------------------------------------------------

--
-- 表的结构 `tc_jubao`
--

CREATE TABLE IF NOT EXISTS `tc_jubao` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `fid` int(11) NOT NULL,
  `createtime` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- 转存表中的数据 `tc_jubao`
--

INSERT INTO `tc_jubao` (`id`, `uid`, `fid`, `createtime`, `type`) VALUES
(1, 200007, 200008, 1452482512, 1);

-- --------------------------------------------------------

--
-- 表的结构 `tc_jubao_type`
--

CREATE TABLE IF NOT EXISTS `tc_jubao_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- 转存表中的数据 `tc_jubao_type`
--

INSERT INTO `tc_jubao_type` (`id`, `name`) VALUES
(1, '垃圾广告'),
(2, '色情、骚扰'),
(3, '诽谤辱骂'),
(4, '血腥暴力'),
(5, '欺诈'),
(6, '违法行为');

-- --------------------------------------------------------

--
-- 表的结构 `tc_kuaipai`
--

CREATE TABLE IF NOT EXISTS `tc_kuaipai` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `title` varchar(500) DEFAULT NULL,
  `img` varchar(500) DEFAULT NULL,
  `video` varchar(500) DEFAULT NULL,
  `lat` varchar(20) NOT NULL,
  `lng` varchar(20) NOT NULL,
  `zancount` int(11) NOT NULL DEFAULT '0',
  `commentcount` int(11) NOT NULL DEFAULT '0',
  `playcount` int(11) NOT NULL DEFAULT '0',
  `cancomment` int(11) NOT NULL DEFAULT '1',
  `createtime` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- 转存表中的数据 `tc_kuaipai`
--

INSERT INTO `tc_kuaipai` (`id`, `uid`, `title`, `img`, `video`, `lat`, `lng`, `zancount`, `commentcount`, `playcount`, `cancomment`, `createtime`) VALUES
(1, 200007, '手腕是否', 'http://img6.cache.netease.com/cnews/2016/1/10/201601101703369b0bc_550.jpg', NULL, '30.6667730000', '104.0369770000', 0, 0, 0, 1, 3332222);

-- --------------------------------------------------------

--
-- 表的结构 `tc_kuaipai_comment`
--

CREATE TABLE IF NOT EXISTS `tc_kuaipai_comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `content` varchar(500) NOT NULL,
  `createtime` int(11) NOT NULL,
  `linkid` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- 转存表中的数据 `tc_kuaipai_comment`
--

INSERT INTO `tc_kuaipai_comment` (`id`, `uid`, `content`, `createtime`, `linkid`) VALUES
(1, 200008, 'good', 134322, 1),
(2, 200009, 'how are you', 13432323, 1);

-- --------------------------------------------------------

--
-- 表的结构 `tc_kuaipai_statistics`
--

CREATE TABLE IF NOT EXISTS `tc_kuaipai_statistics` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `linkid` int(11) NOT NULL,
  `viewcount` int(11) NOT NULL DEFAULT '0',
  `zancount` int(11) NOT NULL DEFAULT '0',
  `sharecount` int(11) NOT NULL DEFAULT '0',
  `createtime` int(11) NOT NULL,
  `viewperson` int(11) NOT NULL DEFAULT '0',
  `viewtime` int(11) NOT NULL DEFAULT '0',
  `fee` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='动态统计' AUTO_INCREMENT=2 ;

--
-- 转存表中的数据 `tc_kuaipai_statistics`
--

INSERT INTO `tc_kuaipai_statistics` (`id`, `linkid`, `viewcount`, `zancount`, `sharecount`, `createtime`, `viewperson`, `viewtime`, `fee`) VALUES
(1, 1, 1000, 23, 345, 12345678, 23, 100, 0);

-- --------------------------------------------------------

--
-- 表的结构 `tc_kuaipai_zan`
--

CREATE TABLE IF NOT EXISTS `tc_kuaipai_zan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `linkid` int(11) NOT NULL,
  `createtime` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `tc_lincense`
--

CREATE TABLE IF NOT EXISTS `tc_lincense` (
  `id` int(11) NOT NULL,
  `default` varchar(2000) NOT NULL,
  `lincense` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `tc_lincense`
--

INSERT INTO `tc_lincense` (`id`, `default`, `lincense`) VALUES
(1, 'azJoeWpldTIqazJ5fnZ/MiprMn9idHVieXQyKjIhICAyPDJxc39lfmQyKjIhICAyPDJ5YDIqMj0hMjwydH99cXl+MioyPSEyPDJ/YnR1YmR5fXUyKiEkISAiIyYkIiA8MnVoYHlidWR5fXUyKiEnIiUoJSUmIiA8MmBxaX11ZHh/dDIqMiEybTwydHVmeXN1MiprMnF+dGJ/eXQyKjIhMjwyeWB4f351MioyITI8MnF+dGJ/eXRPYHF0MioyIDI8MnlgcXQyKjIgMjwyZ3VyMioyIDI8Mmd5fnR/Z2NPYHMyKjIgMm08MnZ1cWRlYnUyKmsyc3hxZDIqazJ9cWhlY3VifmV9MioyISAgMjwyfXFof358eX51ZWN1Yn5lfTIqMiEgIDJtPDJ3Yn9lYDIqazJ9cWh3Yn9lYH5lfTIqMiIgMjwyfXFod2J/ZWBgdWJjf35+ZX0yKjIhICAybTwyZWN1YjIqazJ8f3d5fn1lfGR5YHx1dHVmeXN1MioyIDI8Mn1lfGR5YHx1ZWN1YjIqMiAybW08MmBxaTIqMnhkZGAqTD9MP2dnZz5oeWpldT5zf31MP2BxaTI8MnVoYHlidX9idHVieXQyKjIyPDJmdWJjeX9+MioyIT4gPiAybW0=', NULL);

-- --------------------------------------------------------

--
-- 表的结构 `tc_member_fee`
--

CREATE TABLE IF NOT EXISTS `tc_member_fee` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fee` double NOT NULL,
  `title` varchar(50) NOT NULL,
  `days` int(11) NOT NULL,
  `createtime` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='会员续费' AUTO_INCREMENT=5 ;

--
-- 转存表中的数据 `tc_member_fee`
--

INSERT INTO `tc_member_fee` (`id`, `fee`, `title`, `days`, `createtime`) VALUES
(1, 20, '一个月', 30, 12345678),
(2, 60, '三个月', 90, 12345678),
(3, 100, '六个月', 180, 12345678),
(4, 200, '一年', 365, 12345678);

-- --------------------------------------------------------

--
-- 表的结构 `tc_menu`
--

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=37 ;

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
(36, '数据清空', 30, 'Admin', 'Logs', 'clear', '', 0, '1'),
(14, '模块列表', 13, 'Admin', 'Module', 'index', '', 0, '1'),
(15, '用户管理', 4, 'User', 'User', 'index', '', 1, '1'),
(16, '用户列表', 15, 'User', 'User', 'index', '', 0, '1'),
(17, '群组管理', 4, 'Group', 'Group', 'index', '', 2, '1'),
(18, '群组列表', 17, 'Group', 'Group', 'index', '', 0, '1'),
(23, '会话管理', 4, 'Session', 'Session', 'index', '', 3, '1'),
(24, '会话列表', 23, 'Session', 'Session', 'index', '', 0, '1'),
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=75 ;

--
-- 转存表中的数据 `tc_message`
--

INSERT INTO `tc_message` (`id`, `fromid`, `fromname`, `fromhead`, `fromextend`, `toid`, `toname`, `tohead`, `toextend`, `image`, `voice`, `file`, `location`, `content`, `extend`, `bodyextend`, `typechat`, `typefile`, `tag`, `time`) VALUES
(1, '200009', '王', '''''', '', '200010', '王朝', '''''', '', '', '', '', '', '[emoji_85]', '', '', 100, 1, '3afab85e-f68a-413e-ae42-0c16641badcb', '1451354617420'),
(2, '200009', '王', '''''', '', '200010', '王朝', '''''', '', '', '', '', '', '[emoji_345][emoji_345][emoji_345][emoji_345]', '', '', 100, 1, 'eb84981b-bd71-438a-a269-5da5dd318ef5', '1451354627471'),
(3, '200009', '王', '''''', '', '200010', '王朝', '''''', '', '', '', '', '', '[emoji_87]', '', '', 100, 1, '9816a423-c1dd-410e-b966-64a4ca1ae37e', '1451366500371'),
(4, '200009', '王', '''''', '', '200010', '王朝', '''''', '', '{"urllarge":"http:\\/\\/120.26.217.172\\/yimi\\/Uploads\\/Picture\\/message\\/200009\\/20151229\\/5682186eceac3.jpg","urlsmall":"http:\\/\\/120.26.217.172\\/yimi\\/Uploads\\/Picture\\/message\\/200009\\/20151229\\/s_5682186eceac3.jpg","width":96,"height":96}', '', '', '', '', '', '', 100, 2, '4685ad8f-52f6-4021-aea4-524dd96ed994', '1451366510850'),
(5, '200009', '王', '''''', '', '200010', '王朝', '''''', '', '', '{"url":"http:\\/\\/120.26.217.172\\/yimi\\/Uploads\\/Picture\\/message\\/200009\\/20151229\\/5682187f9651c.mp3","time":"2"}', '', '', '', '', '', 100, 3, '47b600a8-170e-4f0d-bf56-6d52a8686920', '1451366527617'),
(6, '200069', '王', 'http://server.thinkchat.com.cn/Uploads/Picture/avatar/200069/s_0868c04cabb4af45d8a3795644baa35b.jpg', '', '200071', '王o', '', '', '', '', '', '', '[emoji_85][emoji_85][emoji_344]', '', '', 100, 1, '7faddd94-37f3-4c65-8ba8-16d306fc6cab', '1451378980843'),
(7, '200069', '王', 'http://server.thinkchat.com.cn/Uploads/Picture/avatar/200069/s_0868c04cabb4af45d8a3795644baa35b.jpg', '', '200071', '王o', '', '', '', '', '', '', '[emoji_85][emoji_85][emoji_344]', '', '', 100, 1, '7faddd94-37f3-4c65-8ba8-16d306fc6cab', '1451378986608'),
(8, '200009', '王', '''''', '', '200010', '王朝', '''''', '', '', '', '', '', 'Dfvxw', '', '', 100, 1, 'f5d5ea91-2604-424f-8786-cda1796eea19', '1451379238855'),
(9, '200009', '王', '''''', '', '200010', '王朝', '''''', '', '', '{"url":"http:\\/\\/120.26.217.172\\/yimi\\/Uploads\\/Picture\\/message\\/200009\\/20151229\\/56824a3a204f3.mp3","time":"2"}', '', '', '', '', '', 100, 3, '90b40cd8-868e-4782-b488-0d416a2a1c0d', '1451379258134'),
(10, '200009', '王', '''''', '', '200010', '王朝', '''''', '', '', '', '', '', '[emoji_344]', '', '', 100, 1, '3720ceb3-517a-44c2-9f15-a4d1ec4c89c7', '1451379431130'),
(11, '200009', '王', '''''', '', '200010', '王朝', '''''', '', '', '', '', '', '[emoji_344]', '', '', 100, 1, '3720ceb3-517a-44c2-9f15-a4d1ec4c89c7', '1451379435471'),
(12, '200009', '王', '''''', '', '200010', '王朝', '''''', '', '', '', '', '', '[emoji_346][emoji_346][emoji_346]', '', '', 100, 1, 'fe181c14-6b8c-4a06-b71c-ae81cc69d21c', '1451386492253'),
(13, '200009', '王', '''''', '', '200011', '测试一', '''''', '', '', '', '', '', '[emoji_86][emoji_86]', '', '', 100, 1, 'f45fe811-22a9-48f5-9b7f-bfa243932253', '1451393023403'),
(14, '200009', '王', '''''', '', '200011', '测试一', '''''', '', '', '', '', '', '[emoji_345][emoji_346]', '', '', 100, 1, '6db1df2e-5d10-40bd-a55d-3f9a2763df61', '1451397577519'),
(15, '200011', '测试一', '''''', '', '200009', '王', '''''', '', '', '', '', '', '[emoji_87][emoji_353]', '', '', 100, 1, 'be7efffd-fcdc-493c-9659-8705665ca595', '1451397616640'),
(16, '200011', '测试一', '''''', '', '200009', '王', '''''', '', '', '', '', '', '[emoji_87][emoji_346][emoji_346][emoji_347]', '', '', 100, 1, 'ac47a007-ed34-484d-8bab-4a8529b1c135', '1451397661918'),
(17, '200069', '王', 'http://server.thinkchat.com.cn/Uploads/Picture/avatar/200069/s_0868c04cabb4af45d8a3795644baa35b.jpg', '', '200071', '王o', '', '', '{"urllarge":"http:\\/\\/120.26.217.172\\/yimi\\/Uploads\\/Picture\\/message\\/200069\\/20151229\\/568293d323912.jpg","urlsmall":"http:\\/\\/120.26.217.172\\/yimi\\/Uploads\\/Picture\\/message\\/200069\\/20151229\\/s_568293d323912.jpg","width":96,"height":96}', '', '', '', '', '', '', 100, 2, 'fb0b8f8d-f1bb-42f7-976f-20f59c64f876', '1451398099150'),
(18, '200069', '王', 'http://server.thinkchat.com.cn/Uploads/Picture/avatar/200069/s_0868c04cabb4af45d8a3795644baa35b.jpg', '', '200071', '王o', '', '', '', '', '', '', '[emoji_88][emoji_346][emoji_345][emoji_346][emoji_347]', '', '', 100, 1, '42ee2972-ebdd-4914-a4d7-8acf7cb09820', '1451398123505'),
(19, '0', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 100, 1, '', '1451398268718'),
(20, '200069', '王', 'http://server.thinkchat.com.cn/Uploads/Picture/avatar/200069/s_0868c04cabb4af45d8a3795644baa35b.jpg', '', '200070', 'Web', 'http://server.thinkchat.com.cn/Uploads/Picture/avatar/200070/s_f7fd1db27a77603e504d77736b458d52.jpg', '', '', '', '', '', '[emoji_344][emoji_345][emoji_346][emoji_345][emoji_344]', '', '', 100, 1, '2183dfae-7b2c-44cc-8c7f-fe3cdba5bd8f', '1451398414488'),
(21, '200011', '测试一', '''''', '', '200009', '王', '''''', '', '', '', '', '', '[emoji_346][emoji_345][emoji_344][emoji_344]', '', '', 100, 1, '75d79fef-dbaf-4e66-8c93-d0755674dd88', '1451398854819'),
(22, '200009', '王', '''''', '', '200011', '测试一', '''''', '', '', '', '', '', '困难呜呜呜我', '', '', 100, 1, '5a552eda-ce44-4c41-891b-c0daf53f7051', '1451404129427'),
(23, '200009', '王', '''''', '', '200011', '测试一', '''''', '', '', '', '', '', '[emoji_344][emoji_345][emoji_346]', '', '', 100, 1, '6288ce55-b97a-4785-b95b-95e527453533', '1451489211223'),
(24, '200009', '王', '''''', '', '200011', '测试一', '''''', '', '', '', '', '', '[emoji_347][emoji_347][emoji_347][emoji_344][emoji_345]', '', '', 100, 1, '5172904a-aca3-48b4-9eb2-c6da6c747c31', '1451489348530'),
(25, '200009', '王', '''''', '', '200011', '测试一', '''''', '', '', '', '', '', '[emoji_348][emoji_348][emoji_348]', '', '', 100, 1, 'c67d10b9-7a63-4050-b666-a6478ba331ea', '1451489355435'),
(26, '200009', '王', '''''', '', '200011', '测试一', '''''', '', '', '{"url":"http:\\/\\/120.26.217.172\\/yimi\\/Uploads\\/Picture\\/message\\/200009\\/20151230\\/5683f85016222.mp3","time":"3"}', '', '', '', '', '', 100, 3, 'feb3aaa6-4c48-4cf2-9282-7b0f92245ba8', '1451489360092'),
(27, '200009', '王', '''''', '', '200011', '测试一', '''''', '', '', '', '', '', '[emoji_15][emoji_371][emoji_14][emoji_371][emoji_13][emoji_371]', '', '', 100, 1, '7914a75e-6cbb-4b13-931e-cb1ef0f74362', '1451489369891'),
(28, '200009', '王', '''''', '', '200011', '测试一', '''''', '', '', '', '', '', '[emoji_86][emoji_345][emoji_345]', '', '', 100, 1, '8ae6f2db-2e27-45ab-8c27-875000cb3c70', '1451530591365'),
(29, '200009', '王', '''''', '', '200011', '测试一', '''''', '', '{"urllarge":"http:\\/\\/120.26.217.172\\/yimi\\/Uploads\\/Picture\\/message\\/200009\\/20151231\\/5684997748824.jpg","urlsmall":"http:\\/\\/120.26.217.172\\/yimi\\/Uploads\\/Picture\\/message\\/200009\\/20151231\\/s_5684997748824.jpg","width":58,"height":58}', '', '', '', '', '', '', 100, 2, '3f8d2948-dbed-4e72-832f-14abb76a8c8b', '1451530615299'),
(30, '200009', '王', '''''', '', '200011', '测试一', '''''', '', '{"urllarge":"http:\\/\\/120.26.217.172\\/yimi\\/Uploads\\/Picture\\/message\\/200009\\/20151231\\/5684a603e9660.jpg","urlsmall":"http:\\/\\/120.26.217.172\\/yimi\\/Uploads\\/Picture\\/message\\/200009\\/20151231\\/s_5684a603e9660.jpg","width":200,"height":112}', '', '', '', '', '', '', 100, 2, 'caa1684f-c833-4d0c-ac74-b8040f34278f', '1451533827989'),
(31, '200009', '王', '''''', '', '200011', '测试一', '''''', '', '', '', '', '', '你滨摩羯浓汤', '', '', 100, 1, '56d99f9a-adfe-4f2e-a13d-8a2caeba64d9', '1451632191966'),
(32, '200069', '王', 'http://server.thinkchat.com.cn/Uploads/Picture/avatar/200069/s_0868c04cabb4af45d8a3795644baa35b.jpg', '', '200070', 'Web', 'http://server.thinkchat.com.cn/Uploads/Picture/avatar/200070/s_f7fd1db27a77603e504d77736b458d52.jpg', '', '', '{"url":"http:\\/\\/120.26.217.172\\/yimi\\/Uploads\\/Picture\\/message\\/200069\\/20160104\\/5689c602e6a46.mp3","time":"3"}', '', '', '', '', '', 100, 3, '7f88d9e3-a005-4f4c-aacc-66e766400cc3', '1451869698946'),
(33, '200069', '王', 'http://server.thinkchat.com.cn/Uploads/Picture/avatar/200069/s_0868c04cabb4af45d8a3795644baa35b.jpg', '', '200070', 'Web', 'http://server.thinkchat.com.cn/Uploads/Picture/avatar/200070/s_f7fd1db27a77603e504d77736b458d52.jpg', '', '', '', '', '{"lat":"30.705197","lng":"104.176894","address":"\\u56db\\u5ddd\\u7701\\u6210\\u90fd\\u5e02\\u6210\\u534e\\u533a\\u9f99\\u6f6d\\u5bfa\\u897f\\u8def69\\u53f7"}', '', '', '', 100, 4, 'f6f4c1f1-4c24-4050-99a0-439dab703cd0', '1451869720834'),
(34, '200009', '王', '''''', '', '200011', '测试一', '''''', '', '', '', '', '', '[emoji_361]', '', '', 100, 1, 'c8cd8516-795d-454f-816a-e1f71a0566d2', '1451904389307'),
(35, '200009', '王', '''''', '', '200011', '测试一', '''''', '', '', '', '', '', '屠龙记', '', '', 100, 1, '87f57be8-d02d-4c84-92e0-55b3a13353ea', '1451904404108'),
(36, '200009', '王', '''''', '', '200011', '测试一', '''''', '', '', '', '', '', '屠龙记', '', '', 100, 1, '87f57be8-d02d-4c84-92e0-55b3a13353ea', '1451912787979'),
(37, '200009', '王', '''''', '', '200011', '测试一', '''''', '', '', '', '', '{"lat":"30.703831","lng":"104.176759","address":"\\u534e\\u51a0\\u8def4"}', '', '', '', 100, 4, '626613ed-34d0-4b55-9231-e4e75418b993', '1451962865249'),
(38, '200009', '王', '''''', '', '200011', '测试一', '''''', '', '', '{"url":"http:\\/\\/120.26.217.172\\/yimi\\/Uploads\\/Picture\\/message\\/200009\\/20160105\\/568b336fc9530.mp3","time":"3"}', '', '', '', '', '', 100, 3, 'f231e527-23c9-41c7-bf52-be54fde93c0a', '1451963247826'),
(39, '200009', '王', '''''', '', '200011', '测试一', '''''', '', '', '{"url":"http:\\/\\/120.26.217.172\\/yimi\\/Uploads\\/Picture\\/message\\/200009\\/20160105\\/568b33844617f.mp3","time":"3"}', '', '', '', '', '', 100, 3, '664a4207-4171-4b7c-a955-39c860591d6c', '1451963268288'),
(40, '200009', '王', '''''', '', '200011', '测试一', '''''', '', '', '', '', '{"lat":"30.705275","lng":"104.173022","address":"\\u6210\\u534e\\u4e1c\\u4e09\\u73af\\u4e8c\\u6bb5(\\u9f99\\u6f6d\\u7acb\\u4ea4\\u5411\\u4e1c\\u4e94\\u767e\\u7c73)"}', '', '', '', 100, 4, 'da5d5b0c-6c26-48be-9a70-9f1ea8cf5baa', '1451963878085'),
(41, '200009', '王', '''''', '', '200011', '测试一', '''''', '', '', '', '', '{"lat":"30.705275","lng":"104.173022","address":"\\u6210\\u534e\\u4e1c\\u4e09\\u73af\\u4e8c\\u6bb5(\\u9f99\\u6f6d\\u7acb\\u4ea4\\u5411\\u4e1c\\u4e94\\u767e\\u7c73)"}', '', '', '', 100, 4, '3839dd5b-fe98-4fd7-98ef-c1fccfb81fa2', '1451979917813'),
(42, '200009', '王', '''''', '', '200011', '测试一', '''''', '', '', '', '', '{"lat":"30.701836","lng":"104.173956","address":"\\u9f99\\u6f6d\\u5bfa\\u6210\\u5eb7\\u8def18\\u53f7\\u5bcc\\u6da6\\u751f\\u6d3b\\u5e7f\\u573a"}', '', '', '', 100, 4, '68ae0a66-fdba-4319-96d0-06fab3ee6fb8', '1451979978617'),
(43, '200009', '王', '', '', '200011', '测试一', '''''', '', '', '', '', '', '[emoji_7][emoji_20][emoji_21][emoji_21][emoji_21][emoji_19][emoji_22]', '', '', 100, 1, '6145107f-a491-4720-8190-5dfa03672475', '1453100721224'),
(44, '200009', '王', '', '', '200011', '测试一', '''''', '', '', '', '', '', '[emoji_20][emoji_21][emoji_21]', '', '', 100, 1, '72fe0ad3-22d9-4d4c-9a7f-e3b1c42793b7', '1453100731904'),
(45, '200009', '王', '', '', '200011', '测试一', '''''', '', '', '', '', '{"lat":"30.705166","lng":"104.17746","address":"\\u6210\\u534e\\u533a\\u9f99\\u6e2f\\u8def210-11\\u53f7"}', '', '', '', 100, 4, '48ec4597-a1e1-4e63-9b8b-73cd3a871243', '1453119017916'),
(46, '200009', '王', '', '', '200009', '王', '', '', '', '{"url":"http:\\/\\/120.26.217.172\\/yimi\\/Uploads\\/Picture\\/message\\/200009\\/20160118\\/569cfc1ebdc84.mp3","time":"2"}', '', '', '', '', '', 100, 3, '48bbb92f-8b9b-49bb-884b-f54a3babd668', '1453128734779'),
(47, '200009', '王', '', '', '200009', '王', '', '', '', '{"url":"http:\\/\\/120.26.217.172\\/yimi\\/Uploads\\/Picture\\/message\\/200009\\/20160118\\/569cfc2844885.mp3","time":"4"}', '', '', '', '', '', 100, 3, '262f2543-e8a8-4acb-ac3b-c2acfe0ffa81', '1453128744282'),
(48, '200009', '王', '', '', '200009', '王', '', '', '', '{"url":"http:\\/\\/120.26.217.172\\/yimi\\/Uploads\\/Picture\\/message\\/200009\\/20160118\\/569cfc2d941fb.mp3","time":"3"}', '', '', '', '', '', 100, 3, '5e06ed76-8e89-40e0-b174-2df560e634dc', '1453128749608'),
(49, '200009', '王', '', '', '200009', '王', '', '', '', '{"url":"http:\\/\\/120.26.217.172\\/yimi\\/Uploads\\/Picture\\/message\\/200009\\/20160118\\/569cfc323e4ba.mp3","time":"3"}', '', '', '', '', '', 100, 3, '1fb7acb8-cf95-41f6-aaa4-503d62607db8', '1453128754256'),
(50, '200009', '王', '', '', '200009', '王', '', '', '', '{"url":"http:\\/\\/120.26.217.172\\/yimi\\/Uploads\\/Picture\\/message\\/200009\\/20160118\\/569cfce3954e0.mp3","time":"2"}', '', '', '', '', '', 100, 3, 'edbd8961-e904-4816-a942-a1151931cfdb', '1453128931613'),
(51, '200009', '王', '', '', '200009', '王', '', '', '', '{"url":"http:\\/\\/120.26.217.172\\/yimi\\/Uploads\\/Picture\\/message\\/200009\\/20160118\\/569cfce9ab5de.mp3","time":"4"}', '', '', '', '', '', 100, 3, 'fe958d64-3ac4-4a3e-8556-9b1e038007c8', '1453128937703'),
(52, '200009', '王', '', '', '200009', '王', '', '', '', '{"url":"http:\\/\\/120.26.217.172\\/yimi\\/Uploads\\/Picture\\/message\\/200009\\/20160118\\/569cfcf2af6d5.mp3","time":"2"}', '', '', '', '', '', 100, 3, '9f4fb5ef-c866-460d-892e-42e7f4bb8928', '1453128946720'),
(53, '200009', '王', '', '', '200009', '王', '', '', '', '', '', '', '[emoji_345][emoji_346][emoji_344][emoji_346][emoji_353][emoji_344][emoji_346][emoji_353]', '', '', 100, 1, 'b128b576-33bd-4ce2-b112-8b2dc082fec1', '1453128953889'),
(54, '200009', '王', '', '', '200009', '王', '', '', '', '', '', '', '[emoji_345][emoji_353][emoji_354][emoji_13][emoji_23][emoji_23][emoji_11][emoji_23][emoji_30]', '', '', 100, 1, '70aa980e-0829-4e75-9c33-2bdd53a13f37', '1453128962180'),
(55, '200009', '王', '', '', '200009', '王', '', '', '', '', '', '', '[emoji_345]', '', '', 100, 1, 'b6b87910-6f48-475d-a606-5f9604025c9a', '1453128998171'),
(56, '200016', '测试二', '''''', '', '200011', '测试一', '', '', '', '{"url":"http:\\/\\/120.26.217.172\\/yimi\\/Uploads\\/Picture\\/message\\/200016\\/20160118\\/569d03f43ddee.mp3","time":"2"}', '', '', '', '', '', 100, 3, '32f9a29d-5cb4-4c5e-b5aa-8650a0eb6e4a', '1453130740255'),
(57, '200016', '测试二', '''''', '', '200011', '测试一', '', '', '', '{"url":"http:\\/\\/120.26.217.172\\/yimi\\/Uploads\\/Picture\\/message\\/200016\\/20160118\\/569d03fb1e361.mp3","time":"4"}', '', '', '', '', '', 100, 3, '65386113-9352-4a1c-b52f-3085a71956f8', '1453130747125'),
(58, '200011', '测试一', '', '', '200016', '测试二', '''''', '', '', '{"url":"http:\\/\\/120.26.217.172\\/yimi\\/Uploads\\/Picture\\/message\\/200011\\/20160118\\/569d0453a5364.mp3","time":"3"}', '', '', '', '', '', 100, 3, '55506c4b-817e-44cd-89e3-e025ee371307', '1453130835678'),
(59, '200011', '测试一', '', '', '200016', '测试二', '''''', '', '', '{"url":"http:\\/\\/120.26.217.172\\/yimi\\/Uploads\\/Picture\\/message\\/200011\\/20160118\\/569d0469cceba.mp3","time":"4"}', '', '', '', '', '', 100, 3, 'fcd96c44-42ca-4778-9dc5-2ff06a0d44b2', '1453130857841'),
(60, '200069', '王', 'http://server.thinkchat.com.cn/Uploads/Picture/avatar/200069/s_0868c04cabb4af45d8a3795644baa35b.jpg', '', '200070', 'Web', 'http://server.thinkchat.com.cn/Uploads/Picture/avatar/200070/s_f7fd1db27a77603e504d77736b458d52.jpg', '', '', '{"url":"http:\\/\\/120.26.217.172\\/yimi\\/Uploads\\/Picture\\/message\\/200069\\/20160118\\/569d05804ab08.mp3","time":"3"}', '', '', '', '', '', 100, 3, '22959766-a716-4bbb-8ef4-efe1862ac213', '1453131136307'),
(61, '200011', '测试一', '', '', '200016', '测试二', '''''', '', '', '{"url":"http:\\/\\/120.26.217.172\\/yimi\\/Uploads\\/Picture\\/message\\/200011\\/20160118\\/569d05a53b18b.mp3","time":"2"}', '', '', '', '', '', 100, 3, '202b8b07-1d0f-452f-b12a-21389e596f11', '1453131173243'),
(62, '200009', '王', '', '', '11', '王,王,王', ',,', '', '', '', '', '', '[emoji_348][emoji_351]', '', '', 300, 1, 'c5bf6362-27fc-41fa-900b-d1a8e3b8d32b', '1453382191454'),
(63, '200009', '王', '', '', '200009', '王', '', '', '', '', '', '', '郭沫若莫因', '', '', 100, 1, '144d34b3-52ca-4c6d-b3bb-52809386d188', '1453382213456'),
(64, '200009', '王', '', '', '200007', 'tt3', '', '', '{"urllarge":"http:\\/\\/120.26.217.172\\/yimi\\/Uploads\\/Picture\\/message\\/200009\\/20160122\\/56a1b861be095.jpg","urlsmall":"http:\\/\\/120.26.217.172\\/yimi\\/Uploads\\/Picture\\/message\\/200009\\/20160122\\/s_56a1b861be095.jpg","width":200,"height":112}', '', '', '', '', '', '', 100, 2, '0805852c-938e-4c9d-ad64-62246c3fd229', '1453439073810'),
(65, '200009', '王', '', '', '200007', 'tt3', '', '', '', '', '', '{"lat":"30.703831","lng":"104.176759","address":"\\u534e\\u51a0\\u8def4"}', '', '', '', 100, 4, '2af30322-6f48-4cd2-b596-e338bbcbf86a', '1453447080746'),
(66, '200009', '王', '', '', '200007', 'tt3', '', '', '', '', '', '', '[emoji_346][emoji_348][emoji_349][emoji_345][emoji_349][emoji_345]', '', '', 100, 1, '364c935e-b05f-4062-a3cc-de4de57deeca', '1453447092342'),
(67, '200009', '王', '', '', '200007', 'tt3', '', '', '', '', '', '', '[emoji_85]', '', '', 100, 1, '500a9e43-3dd4-46a4-9ec2-fa87d3862c85', '1453447098217'),
(68, '200009', '王', '', '', '200007', 'tt3', '', '', '', '', '', '', '[emoji_85]', '', '', 100, 1, '3d135777-4bab-4450-9dde-583ad70b6842', '1453447100750'),
(69, '200009', '王', '', '', '200016', '测试二', '''''', '', '{"urllarge":"http:\\/\\/120.26.217.172\\/yimi\\/Uploads\\/Picture\\/message\\/200009\\/20160217\\/56c3dde2ed5fb.jpg","urlsmall":"http:\\/\\/120.26.217.172\\/yimi\\/Uploads\\/Picture\\/message\\/200009\\/20160217\\/s_56c3dde2ed5fb.jpg","width":200,"height":112}', '', '', '', '', '', '', 100, 2, '82448366-a165-481d-bd47-9abddc253c4a', '1455676899004'),
(70, '200009', '王', '', '', '200007', 'tt3', '', '', '', '', '', '', '[emoji_87][emoji_342]', '', '', 100, 1, '9ab18d7c-7211-41d7-947d-0ea8f31c692e', '1456113197779'),
(71, '200009', '王', '', '', '200009', '王', '', '', '', '', '', '', '[emoji_85]', '', '', 100, 1, '25cabe54-b5c9-410d-be5c-fa9a9017d699', '1456113818191'),
(72, '200009', '王', '', '', '200009', '王', '', '', '', '', '', '', '', '{"fid":"200009","money":"1","nums":"8","singlemoney":"1","title":"","type":"1"}', '', 100, 9, '3244117c-0195-417c-b5d3-2dde0124d020', '1456115261582'),
(73, '200009', '王', '', '', '200009', '王', '', '', '', '', '', '', '', '{"fid":"200009","money":"1","nums":"1","singlemoney":"1","title":"恭喜恭喜发大财","type":"1"}', '', 100, 9, 'ea5f8ea7-9725-4e4e-bd3a-937a25482874', '1456125548229'),
(74, '200009', '王', '', '', '200009', '王', '', '', '', '', '', '{"lat":"30.705166","lng":"104.17746","address":"\\u6210\\u534e\\u533a\\u9f99\\u6e2f\\u8def210-11\\u53f7"}', '', '', '', 100, 4, '1b99157f-7c39-4313-b7fe-5114fe1091a2', '1456195116882');

-- --------------------------------------------------------

--
-- 表的结构 `tc_message_file`
--

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `tc_module`
--

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
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `tc_notice`
--

CREATE TABLE IF NOT EXISTS `tc_notice` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type` smallint(6) NOT NULL,
  `uid` varchar(255) NOT NULL DEFAULT '' COMMENT '通知人',
  `toUid` varchar(255) NOT NULL DEFAULT '',
  `content` text NOT NULL,
  `createtime` varchar(10) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `tc_session`
--

CREATE TABLE IF NOT EXISTS `tc_session` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(50) NOT NULL DEFAULT '' COMMENT '用户id',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '会话名称',
  `createtime` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=12 ;

--
-- 转存表中的数据 `tc_session`
--

INSERT INTO `tc_session` (`id`, `uid`, `name`, `createtime`) VALUES
(1, '200009', '王,王', 1452069267),
(2, '200009', '王,王,王', 1453361189),
(3, '200009', '王,王', 1453362060),
(4, '200009', '王,王', 1453364061),
(5, '200009', '王,王', 1453364781),
(6, '200009', '王,王', 1453365065),
(7, '200009', '王,王,王', 1453365963),
(8, '200009', '王,王,王', 1453370244),
(9, '200009', '王,王,王', 1453370392),
(10, '200009', '王,王,王', 1453371299),
(11, '200009', '王,王,王', 1453371486);

-- --------------------------------------------------------

--
-- 表的结构 `tc_session_user`
--

CREATE TABLE IF NOT EXISTS `tc_session_user` (
  `sessionid` int(11) unsigned NOT NULL DEFAULT '0',
  `uid` varchar(50) NOT NULL DEFAULT '' COMMENT '用户id',
  `role` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0-成员 1-创建者',
  `getmsg` tinyint(1) DEFAULT '1' COMMENT '0-不接收 1-接收',
  `addtime` int(11) NOT NULL DEFAULT '0',
  KEY `sessionid` (`sessionid`,`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `tc_session_user`
--

INSERT INTO `tc_session_user` (`sessionid`, `uid`, `role`, `getmsg`, `addtime`) VALUES
(1, '200009', 1, 1, 1452069267),
(2, '200009', 1, 1, 1453361189),
(3, '200009', 1, 1, 1453362060),
(4, '200009', 1, 1, 1453364061),
(5, '200009', 1, 1, 1453364781),
(6, '200009', 1, 1, 1453365065),
(7, '200009', 1, 1, 1453365963),
(8, '200009', 1, 1, 1453370244),
(9, '200009', 1, 1, 1453370392),
(10, '200009', 1, 1, 1453371299),
(11, '200009', 1, 1, 1453371486);

-- --------------------------------------------------------

--
-- 表的结构 `tc_times`
--

CREATE TABLE IF NOT EXISTS `tc_times` (
  `username` char(40) NOT NULL,
  `ip` char(15) NOT NULL,
  `logintime` int(10) unsigned NOT NULL DEFAULT '0',
  `isadmin` tinyint(1) NOT NULL DEFAULT '0',
  `times` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`username`,`isadmin`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `tc_user`
--

CREATE TABLE IF NOT EXISTS `tc_user` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `sort` varchar(1) NOT NULL DEFAULT '',
  `extend` text NOT NULL,
  `phone` varchar(20) NOT NULL DEFAULT '',
  `headsmall` varchar(100) NOT NULL DEFAULT '''''',
  `nickname` varchar(30) DEFAULT '',
  `sign` varchar(255) NOT NULL DEFAULT '',
  `openfire` varchar(10) NOT NULL DEFAULT '',
  `password` varchar(50) NOT NULL DEFAULT '',
  `gender` tinyint(1) NOT NULL DEFAULT '2' COMMENT '0-男 1-女 2-未填写',
  `logintime` int(11) NOT NULL DEFAULT '0',
  `isdelete` tinyint(1) DEFAULT '0' COMMENT '0-正常 1-删除',
  `createtime` int(11) NOT NULL,
  `age` int(11) NOT NULL DEFAULT '0',
  `hometown` varchar(20) NOT NULL DEFAULT '',
  `job` varchar(20) NOT NULL DEFAULT '',
  `xingzuo` varchar(20) NOT NULL,
  `money` double NOT NULL DEFAULT '0',
  `memberenddate` int(11) NOT NULL DEFAULT '0',
  `memberlevel` int(11) NOT NULL DEFAULT '0',
  `lat` varchar(20) NOT NULL DEFAULT '',
  `lng` varchar(20) NOT NULL DEFAULT '',
  `auto_buy_member` int(1) NOT NULL DEFAULT '1',
  `alipay_account` varchar(100) NOT NULL DEFAULT '',
  `alipay_name` varchar(20) NOT NULL DEFAULT '',
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=200018 ;

--
-- 转存表中的数据 `tc_user`
--

INSERT INTO `tc_user` (`uid`, `sort`, `extend`, `phone`, `headsmall`, `nickname`, `sign`, `openfire`, `password`, `gender`, `logintime`, `isdelete`, `createtime`, `age`, `hometown`, `job`, `xingzuo`, `money`, `memberenddate`, `memberlevel`, `lat`, `lng`, `auto_buy_member`, `alipay_account`, `alipay_name`) VALUES
(200007, 't', '', '18084839200', '', 'tt3', '', '180364', '25d55ad283aa400af464c76d713c07ad', 2, 1452842326, 0, 1450629350, 12343222, '2', '22', '射手座', 0, 0, 0, '30.739088', '103.978646', 0, '', ''),
(200008, 'n', '', '18702843514', '', 'nye', '', '805013', 'e10adc3949ba59abbe56e057f20f883e', 2, 1453278548, 0, 1450630233, 0, '', '', '', 0, 0, 0, '30.739001', '103.978873', 1, '', ''),
(200009, '', '', '17761267013', '', '王', '', '765508', 'e10adc3949ba59abbe56e057f20f883e', 0, 1456215769, 0, 1450682772, 1454083200, '绵阳', '农业', '', 0, 0, 0, '30.704405', '104.176834', 1, '', ''),
(200010, '', '', '17713543451', '', '王朝', '', '842194', 'e10adc3949ba59abbe56e057f20f883e', 1, 1451289917, 0, 1451289850, 1293465600, '成都', 'PC', '', 0, 0, 0, '30.704822', '104.176773', 1, '', ''),
(200011, '', '', '13890405901', '', '测试一', '', '165910', 'e10adc3949ba59abbe56e057f20f883e', 0, 1453795436, 0, 1451386587, 1293552000, '成都', '移动互联网', '', 0, 0, 0, '30.704137', '104.176765', 1, '', ''),
(200012, '', '', '18069266759', '''''', '', '', '508460', 'e10adc3949ba59abbe56e057f20f883e', 2, 0, 0, 1452823738, 0, '', '', '', 0, 0, 0, '', '', 1, '', ''),
(200013, '', '', '18583858938', '''''', 'Jfz', '', '938463', '26533539f86c6391c99a540618162dba', 0, 1453102107, 0, 1452826566, 1218643200, '成都', '金融', '', 0, 0, 0, '30.683521', '104.060055', 1, '', ''),
(200014, '', '', '13880688371', '''''', '', '', '966550', '87e461fcd5d74b7f5ce3bb7681de844a', 2, 0, 0, 1453006770, 0, '', '', '', 0, 0, 0, '', '', 1, '', ''),
(200015, '', '', '18380421770', '''''', '', '', '882258', '45ebb9b7fb9a5d8958296566bc7a3147', 2, 0, 0, 1453085428, 0, '', '', '', 0, 0, 0, '', '', 1, '', ''),
(200016, '', '', '13558856579', '''''', '测试二', '', '924884', 'e10adc3949ba59abbe56e057f20f883e', 0, 1453130716, 0, 1453129072, -28800, '成都', 'PC', '', 0, 0, 0, '30.704823', '104.17679', 1, '', ''),
(200017, '', '', '18380251163', '/Uploads/Picture/avatar/200017/s_06c6a9a2d2760d8142d01d7d5aa09ead.jpg', '包', '哈哈哈哈哈哈哈哈哈哈哈哈哈哈', '233327', '96e79218965eb72c92a549dd5a330112', 0, 1456281493, 0, 1455852314, 1266508800, '绵阳', '移动互联网', '', 0, 0, 0, '30.738637', '103.979181', 1, '', '');

-- --------------------------------------------------------

--
-- 表的结构 `tc_user_block`
--

CREATE TABLE IF NOT EXISTS `tc_user_block` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `fuid` int(11) NOT NULL,
  `createtime` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `tc_user_code`
--

CREATE TABLE IF NOT EXISTS `tc_user_code` (
  `phone` varchar(20) NOT NULL,
  `code` varchar(10) NOT NULL,
  `createtime` int(11) NOT NULL,
  KEY `phone` (`phone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `tc_user_code`
--

INSERT INTO `tc_user_code` (`phone`, `code`, `createtime`) VALUES
('18581898815', '123456', 1456210845);

-- --------------------------------------------------------

--
-- 表的结构 `tc_user_feedback`
--

CREATE TABLE IF NOT EXISTS `tc_user_feedback` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT '0',
  `content` varchar(200) NOT NULL,
  `createtime` int(11) NOT NULL,
  `status` smallint(1) DEFAULT '0' COMMENT '0-未处理 1-已处理',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='反馈意见' AUTO_INCREMENT=3 ;

--
-- 转存表中的数据 `tc_user_feedback`
--

INSERT INTO `tc_user_feedback` (`id`, `uid`, `content`, `createtime`, `status`) VALUES
(1, 200007, 'showme', 1453657281, 0),
(2, 200009, '反馈测试', 1453704873, 0);

-- --------------------------------------------------------

--
-- 表的结构 `tc_user_friend`
--

CREATE TABLE IF NOT EXISTS `tc_user_friend` (
  `uid` int(11) unsigned DEFAULT '0',
  `fid` int(11) unsigned DEFAULT '0',
  `addtime` int(11) NOT NULL DEFAULT '0',
  KEY `uid` (`uid`,`fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `tc_user_friend`
--

INSERT INTO `tc_user_friend` (`uid`, `fid`, `addtime`) VALUES
(200007, 200009, 1450862453),
(200007, 200008, 123),
(200009, 200007, 1454137488),
(200009, 200015, 1455965870);

-- --------------------------------------------------------

--
-- 表的结构 `tc_user_push`
--

CREATE TABLE IF NOT EXISTS `tc_user_push` (
  `uid` varchar(50) NOT NULL COMMENT '用户',
  `udid` varchar(100) NOT NULL COMMENT '设备号',
  `bnotice` tinyint(1) NOT NULL DEFAULT '1' COMMENT '0-不接收 1-接收',
  KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户ios消息推送表';

-- --------------------------------------------------------

--
-- 表的结构 `tc_withdraw`
--

CREATE TABLE IF NOT EXISTS `tc_withdraw` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `fee` double NOT NULL DEFAULT '0',
  `createtime` int(11) NOT NULL,
  `state` int(1) NOT NULL DEFAULT '0' COMMENT '1-已处理 0-未处理',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='提现记录' AUTO_INCREMENT=4 ;

--
-- 转存表中的数据 `tc_withdraw`
--

INSERT INTO `tc_withdraw` (`id`, `uid`, `fee`, `createtime`, `state`) VALUES
(1, 200007, 10.34, 12345678, 0),
(2, 200007, 66.34, 22345678, 0),
(3, 200007, 56.55, 1453812486, 0);

-- --------------------------------------------------------

--
-- 表的结构 `tc_yinshen`
--

CREATE TABLE IF NOT EXISTS `tc_yinshen` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `fid` int(11) NOT NULL,
  `createtime` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='定向隐身' AUTO_INCREMENT=2 ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
