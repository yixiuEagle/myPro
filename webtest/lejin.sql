/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50623
Source Host           : localhost:3306
Source Database       : lejin

Target Server Type    : MYSQL
Target Server Version : 50623
File Encoding         : 65001

Date: 2017-03-30 10:02:44
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `tc_activity_sign`
-- ----------------------------
DROP TABLE IF EXISTS `tc_activity_sign`;
CREATE TABLE `tc_activity_sign` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `order_no` varchar(30) NOT NULL DEFAULT '',
  `activity_id` int(11) NOT NULL,
  `name` varchar(10) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `pay_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '实际支付',
  `balance` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '余额抵扣',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0.未支付，1.已支付',
  `create_time` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tc_activity_sign
-- ----------------------------
INSERT INTO `tc_activity_sign` VALUES ('1', '20000313', '', '2', '哈哈哈', '13422222222', '0.00', '10.00', '1', '1490323223');
INSERT INTO `tc_activity_sign` VALUES ('2', '20000315', '2017032454999898', '2', '呀呀', '13700000000', '0.00', '10.00', '1', '1490323638');
INSERT INTO `tc_activity_sign` VALUES ('3', '20000315', '', '3', '呀呀', '13700000000', '0.00', '0.00', '0', '1490332270');
INSERT INTO `tc_activity_sign` VALUES ('4', '20000313', '2017032454975655', '3', '哈哈哈', '13422222222', '0.00', '0.00', '1', '1490337014');

-- ----------------------------
-- Table structure for `tc_activity_source`
-- ----------------------------
DROP TABLE IF EXISTS `tc_activity_source`;
CREATE TABLE `tc_activity_source` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `pic` text NOT NULL,
  `title` varchar(100) NOT NULL,
  `start_time` varchar(30) NOT NULL,
  `end_time` varchar(30) NOT NULL,
  `address` varchar(100) NOT NULL,
  `fees_type` tinyint(4) DEFAULT '0' COMMENT '0.字段无效，1.免费，2.租金，3.售价',
  `fees_price` varchar(20) DEFAULT '0',
  `remark` varchar(200) DEFAULT '',
  `type` tinyint(4) DEFAULT '1' COMMENT '1.活动，2.闲置资源',
  `create_time` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tc_activity_source
-- ----------------------------
INSERT INTO `tc_activity_source` VALUES ('1', '20000314', '[{\"smallUrl\":\"\\/Uploads\\/Picture\\/20170323\\/s_54e49d2d3e69d8a9.jpg\",\"originUrl\":\"\\/Uploads\\/Picture\\/20170323\\/54e49d2d3e69d8a9.jpg\"}]', '书桌', '1490198400', '1490371200', '四川省成都市郫县天辰路', '1', '', '无', '2', '1490263347');
INSERT INTO `tc_activity_source` VALUES ('2', '20000313', '[{\"smallUrl\":\"\\/Uploads\\/Picture\\/20170324\\/s_ae51fab886215f30.jpg\",\"originUrl\":\"\\/Uploads\\/Picture\\/20170324\\/ae51fab886215f30.jpg\"},{\"smallUrl\":\"\\/Uploads\\/Picture\\/20170324\\/s_308c6fc9d95cb778.jpg\",\"originUrl\":\"\\/Uploads\\/Picture\\/20170324\\/308c6fc9d95cb778.jpg\"},{\"smallUrl\":\"\\/Uploads\\/Picture\\/20170324\\/s_264d12fb6effaa2f.jpg\",\"originUrl\":\"\\/Uploads\\/Picture\\/20170324\\/264d12fb6effaa2f.jpg\"}]', '聚餐', '1490284800', '1490371200', '四川省成都市郫县西芯大道4号', '0', '10', '无8', '1', '1490323223');
INSERT INTO `tc_activity_source` VALUES ('3', '20000315', '[{\"smallUrl\":\"\\/Uploads\\/Picture\\/20170324\\/s_7915dea4f2844a9a.jpg\",\"originUrl\":\"\\/Uploads\\/Picture\\/20170324\\/7915dea4f2844a9a.jpg\"}]', '兔子', '1490332200', '1491109860', '中国大学生创业园西部园区孵化园', '0', '0', '哈哈', '1', '1490332270');

-- ----------------------------
-- Table structure for `tc_activity_source_comment`
-- ----------------------------
DROP TABLE IF EXISTS `tc_activity_source_comment`;
CREATE TABLE `tc_activity_source_comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `activity_id` int(11) NOT NULL,
  `content` text NOT NULL,
  `create_time` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tc_activity_source_comment
-- ----------------------------
INSERT INTO `tc_activity_source_comment` VALUES ('1', '20000315', '2', '\\u54c8\\u54c8', '1490323670');
INSERT INTO `tc_activity_source_comment` VALUES ('2', '20000315', '2', '\\u5154\\u5b50', '1490323680');
INSERT INTO `tc_activity_source_comment` VALUES ('3', '20000313', '2', '。你', '1490323726');
INSERT INTO `tc_activity_source_comment` VALUES ('4', '20000313', '2', '[emoji_86]', '1490323729');
INSERT INTO `tc_activity_source_comment` VALUES ('5', '20000313', '1', '宝宝', '1490323900');
INSERT INTO `tc_activity_source_comment` VALUES ('6', '20000313', '3', '\\ud83d\\ude4f', '1490337021');

-- ----------------------------
-- Table structure for `tc_admin`
-- ----------------------------
DROP TABLE IF EXISTS `tc_admin`;
CREATE TABLE `tc_admin` (
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
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='后台管理员表';

-- ----------------------------
-- Records of tc_admin
-- ----------------------------
INSERT INTO `tc_admin` VALUES ('1', 'admin', '11e8ab79a9105712ede58e4bee9cd5a1', '1', 'ZEDrmj', '112.112.48.237', '1490592808', '1490608845', null, '');

-- ----------------------------
-- Table structure for `tc_admin_role`
-- ----------------------------
DROP TABLE IF EXISTS `tc_admin_role`;
CREATE TABLE `tc_admin_role` (
  `roleid` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `rolename` varchar(50) NOT NULL,
  `description` text NOT NULL,
  `listorder` smallint(5) unsigned NOT NULL DEFAULT '0',
  `disabled` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`roleid`),
  KEY `listorder` (`listorder`),
  KEY `disabled` (`disabled`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='后台角色表';

-- ----------------------------
-- Records of tc_admin_role
-- ----------------------------
INSERT INTO `tc_admin_role` VALUES ('1', '超级管理员', '超级管理员', '0', '0');
INSERT INTO `tc_admin_role` VALUES ('2', '123', '', '0', '0');

-- ----------------------------
-- Table structure for `tc_admin_role_priv`
-- ----------------------------
DROP TABLE IF EXISTS `tc_admin_role_priv`;
CREATE TABLE `tc_admin_role_priv` (
  `roleid` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `m` char(20) NOT NULL,
  `a` char(20) NOT NULL,
  `data` char(30) NOT NULL DEFAULT '',
  KEY `roleid` (`roleid`,`m`,`a`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='权限表';

-- ----------------------------
-- Records of tc_admin_role_priv
-- ----------------------------

-- ----------------------------
-- Table structure for `tc_background`
-- ----------------------------
DROP TABLE IF EXISTS `tc_background`;
CREATE TABLE `tc_background` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `background_user` varchar(128) NOT NULL DEFAULT '' COMMENT '用户',
  `background_group` varchar(128) NOT NULL DEFAULT '' COMMENT '群',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='记录提醒';

-- ----------------------------
-- Records of tc_background
-- ----------------------------
INSERT INTO `tc_background` VALUES ('1', '/Uploads/Picture/20151210/s_e26b3f037f5ed0ff.jpg', '/Uploads/Picture/20160728/s_bde4c8462054f74b.jpg');

-- ----------------------------
-- Table structure for `tc_banner`
-- ----------------------------
DROP TABLE IF EXISTS `tc_banner`;
CREATE TABLE `tc_banner` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(11) NOT NULL DEFAULT '0' COMMENT '0-html 1-三方URL',
  `image` varchar(256) NOT NULL DEFAULT '' COMMENT '图片',
  `content` text NOT NULL COMMENT '内容根据type来决定',
  `createtime` int(11) NOT NULL,
  `action` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0-大家帮 1-关注 2-动态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='banner列表';

-- ----------------------------
-- Records of tc_banner
-- ----------------------------
INSERT INTO `tc_banner` VALUES ('1', '0', '/Uploads/Picture/20160705/s_0c972b284e58d562.jpg', '<p>\r\n	<span style=\"color:#E53333;font-family:Microsoft YaHei;font-size:16px;\"><strong>如何创建属于自己的空间？</strong></span> \r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<span style=\"font-family:Microsoft YaHei;font-size:14px;\"><strong>一、有两个途径可以建立空间号：</strong></span> \r\n</p>\r\n<p>\r\n	<span style=\"font-family:Microsoft YaHei;font-size:14px;\"><strong>1、从”我的</strong></span><span style=\"font-family:Microsoft YaHei;font-size:14px;\"><strong>→空间号</strong></span><span style=\"font-family:Microsoft YaHei;font-size:14px;\"><strong>→我所建的“界面建立</strong></span> \r\n</p>\r\n<p>\r\n	<img alt=\"\" src=\"/lejin/Uploads/Editor/image/20160607/054935_775.jpg\" />\r\n</p>\r\n<p>\r\n	<span style=\"font-family:Microsoft YaHei;font-size:14px;\"><strong><b><span><br />\r\n</span></b></strong></span>\r\n</p>\r\n<p>\r\n	<span style=\"font-family:Microsoft YaHei;font-size:14px;\"><strong><b><span>点击右上角符号，</span></b><strong>出现创建号弹窗，点击进入即可创建</strong></strong></span> \r\n</p>\r\n<p>\r\n	<img alt=\"\" src=\"/lejin/Uploads/Editor/image/20160607/105502_660.jpg\" /> \r\n</p>\r\n<p>\r\n	<span style=\"font-family:Microsoft YaHei;font-size:14px;\"><strong><br />\r\n</strong></span> \r\n</p>\r\n<p>\r\n	<span style=\"font-family:Microsoft YaHei;font-size:14px;\"><strong>2、从”空间</strong></span><span style=\"font-family:Microsoft YaHei;font-size:14px;\"><strong>→话题“界面建立，点击右上角符号，</strong></span><span style=\"font-family:Microsoft YaHei;font-size:14px;\"><strong>出现创建号弹窗，点击进入即可创建</strong></span> <img alt=\"\" src=\"/lejin/Uploads/Editor/image/20160607/105522_357.jpg\" /> \r\n</p>\r\n<p>\r\n	<span style=\"font-family:Microsoft YaHei;font-size:14px;\"><strong><br />\r\n</strong></span> \r\n</p>\r\n<p>\r\n	<span style=\"font-family:Microsoft YaHei;font-size:14px;\"><strong>二、进入创建号界面，里面可选择更换封面、添加头像、选择类别、确认位置等选项，编辑完成后点击右上角符号确认即可</strong></span> \r\n</p>\r\n<p>\r\n	<img alt=\"\" src=\"/lejin/Uploads/Editor/image/20160607/105638_286.jpg\" /> \r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<span style=\"font-family:Microsoft YaHei;font-size:14px;\"><strong>三、创建完成后，可选择在号或类别下发布信息</strong></span> \r\n</p>\r\n<p>\r\n	<img alt=\"\" src=\"/lejin/Uploads/Editor/image/20160607/105701_288.jpg\" /> \r\n</p>\r\n<p>\r\n	<span style=\"font-family:Microsoft YaHei;font-size:14px;\"><b><b><span>选择是在号下还是在其他类别发布信息（在其他类别下发布就不会在自己号名下显示）</span></b></b></span> \r\n</p>\r\n<p>\r\n	<img alt=\"\" src=\"/lejin/Uploads/Editor/image/20160607/105722_287.jpg\" /> \r\n</p>\r\n<p>\r\n	<span style=\"font-family:Microsoft YaHei;font-size:14px;\"><b><br />\r\n</b></span> \r\n</p>\r\n<p>\r\n	<img alt=\"\" src=\"/lejin/Uploads/Editor/image/20160607/105740_764.jpg\" /> \r\n</p>\r\n<p>\r\n	<span style=\"font-family:Microsoft YaHei;font-size:14px;\"><b><b><span><br />\r\n</span></b></b></span>\r\n</p>\r\n<p>\r\n	<span style=\"font-family:Microsoft YaHei;font-size:14px;\"><b><b><span>在自己的空间号里显示号下发布的全部信息</span></b></b></span> \r\n</p>\r\n<p>\r\n	<img alt=\"\" src=\"/lejin/Uploads/Editor/image/20160607/105758_829.jpg\" /> \r\n</p>\r\n<p>\r\n	<span style=\"font-family:Microsoft YaHei;font-size:14px;\"><b><br />\r\n</b></span> \r\n</p>', '1445507239', '2');
INSERT INTO `tc_banner` VALUES ('5', '0', '/Uploads/Picture/20170323/s_97ebf8f6618f8cdb.jpg', '&nbsp; &nbsp;', '1490262354', '3');
INSERT INTO `tc_banner` VALUES ('6', '0', '/Uploads/Picture/20170323/s_c0ab2c72fc9035ab.jpg', '&nbsp; &nbsp;', '1490262376', '3');

-- ----------------------------
-- Table structure for `tc_cart`
-- ----------------------------
DROP TABLE IF EXISTS `tc_cart`;
CREATE TABLE `tc_cart` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `sid` int(11) NOT NULL,
  `goods_id` int(11) NOT NULL,
  `pay_count` int(11) NOT NULL DEFAULT '1',
  `create_time` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=155 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tc_cart
-- ----------------------------
INSERT INTO `tc_cart` VALUES ('53', '20000002', '1', '1', '1', '1490452320');

-- ----------------------------
-- Table structure for `tc_city`
-- ----------------------------
DROP TABLE IF EXISTS `tc_city`;
CREATE TABLE `tc_city` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL DEFAULT '' COMMENT '城市名称',
  `sort` char(1) NOT NULL DEFAULT '' COMMENT '城市首字母',
  `lat` varchar(30) NOT NULL DEFAULT '',
  `lng` varchar(30) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=366 DEFAULT CHARSET=utf8 COMMENT='城市表';

-- ----------------------------
-- Records of tc_city
-- ----------------------------
INSERT INTO `tc_city` VALUES ('1', '成都市', 'c', '30.6651880000', '104.0722520000');
INSERT INTO `tc_city` VALUES ('2', '北京市', 'b', '39.9110130000', '116.4135540000');
INSERT INTO `tc_city` VALUES ('3', '遂宁市', 's', '30.5391560000', '105.5991520000');
INSERT INTO `tc_city` VALUES ('4', '绵阳市', 'm', '31.4733640000', '104.6861640000');
INSERT INTO `tc_city` VALUES ('5', '德阳市', 'd', '31.1331050000', '104.4043190000');
INSERT INTO `tc_city` VALUES ('6', '上海市', 's', '31.2363050000', '121.4802370000');
INSERT INTO `tc_city` VALUES ('7', '长沙市', 'c', '28.2339710000', '112.9453330000');
INSERT INTO `tc_city` VALUES ('8', '重庆市', 'c', '29.5709970000', '106.5571650000');
INSERT INTO `tc_city` VALUES ('9', '贵阳市', 'g', '26.6527470000', '106.6368160000');
INSERT INTO `tc_city` VALUES ('10', '广州市', 'g', '23.1353080000', '113.2707930000');
INSERT INTO `tc_city` VALUES ('11', '天津市', 't', '39.0909080000', '117.2059140000');
INSERT INTO `tc_city` VALUES ('12', '太原市', 't', '37.8768850000', '112.5570600000');
INSERT INTO `tc_city` VALUES ('13', '石家庄市', 's', '38.0486840000', '114.5208280000');
INSERT INTO `tc_city` VALUES ('14', '深圳市', 's', '22.5485150000', '114.0661120000');
INSERT INTO `tc_city` VALUES ('15', '昆明市', 'k', '24.8859530000', '102.8396670000');
INSERT INTO `tc_city` VALUES ('16', '南京市', 'n', '32.0647350000', '118.8028910000');
INSERT INTO `tc_city` VALUES ('17', '武汉市', 'w', '30.5984280000', '114.3118310000');
INSERT INTO `tc_city` VALUES ('18', '郑州市', 'z', '34.7534880000', '113.6313490000');
INSERT INTO `tc_city` VALUES ('19', '洛阳市', 'l', '34.6243760000', '112.4600330000');
INSERT INTO `tc_city` VALUES ('20', '长春市', 'c', '43.8217800000', '125.3301700000');
INSERT INTO `tc_city` VALUES ('21', '达州市', 'd', '31.2143470000', '107.4745040000');
INSERT INTO `tc_city` VALUES ('22', '广安市', 'g', '30.4617080000', '106.6397720000');
INSERT INTO `tc_city` VALUES ('23', '乐山市', 'l', '29.5581410000', '103.7719300000');
INSERT INTO `tc_city` VALUES ('24', '南充市', 'n', '30.8432970000', '106.1172310000');
INSERT INTO `tc_city` VALUES ('25', '拉萨市', 'l', '29.6500880000', '91.1210250000');
INSERT INTO `tc_city` VALUES ('26', '哈尔滨市', 'h', '45.8077820000', '126.5424170000');
INSERT INTO `tc_city` VALUES ('27', '乌鲁木齐市', 'w', '43.8328060000', '87.6233140000');
INSERT INTO `tc_city` VALUES ('28', '珠海市', 'z', '22.2763920000', '113.5832350000');
INSERT INTO `tc_city` VALUES ('29', '兰州市', 'l', '36.0673120000', '103.8406920000');
INSERT INTO `tc_city` VALUES ('30', '西安市', 'x', '34.3474360000', '108.9463060000');
INSERT INTO `tc_city` VALUES ('31', '合肥市', 'h', '31.8268700000', '117.2354470000');
INSERT INTO `tc_city` VALUES ('32', '宜宾市', 'y', '28.7576100000', '104.6481030000');
INSERT INTO `tc_city` VALUES ('33', '西昌市', 'x', '27.9006010000', '102.2695260000');
INSERT INTO `tc_city` VALUES ('34', '广元市', 'g', '32.4418080000', '105.8499930000');
INSERT INTO `tc_city` VALUES ('35', '雅安市', 'y', '30.0212770000', '103.0463600000');
INSERT INTO `tc_city` VALUES ('36', '济南市', 'j', '36.6716270000', '117.0013190000');
INSERT INTO `tc_city` VALUES ('37', '青岛市', 'q', '36.0723580000', '120.3894450000');
INSERT INTO `tc_city` VALUES ('38', '福州市', 'f', '26.0804470000', '119.3029380000');
INSERT INTO `tc_city` VALUES ('39', '厦门市', 'x', '24.4858210000', '118.0959150000');
INSERT INTO `tc_city` VALUES ('40', '南宁市', 'n', '22.8230370000', '108.3733510000');
INSERT INTO `tc_city` VALUES ('41', '南昌市', 'n', '28.6876750000', '115.8645280000');
INSERT INTO `tc_city` VALUES ('42', '杭州市', 'h', '30.2800590000', '120.1616930000');
INSERT INTO `tc_city` VALUES ('43', '银川市', 'y', '38.4923920000', '106.2389760000');
INSERT INTO `tc_city` VALUES ('44', '西宁市', 'x', '36.6234770000', '101.7842690000');
INSERT INTO `tc_city` VALUES ('45', '沈阳市', 's', '41.8113390000', '123.4389730000');
INSERT INTO `tc_city` VALUES ('46', '海口市', 'h', '20.0500570000', '110.2064240000');
INSERT INTO `tc_city` VALUES ('47', '呼和浩特市', 'h', '40.8474610000', '111.7585180000');
INSERT INTO `tc_city` VALUES ('64', '安庆市', 'a', '', '');
INSERT INTO `tc_city` VALUES ('65', '蚌埠市', 'b', '', '');
INSERT INTO `tc_city` VALUES ('66', '亳州市', 'h', '', '');
INSERT INTO `tc_city` VALUES ('67', '池州市', '', 'c', '');
INSERT INTO `tc_city` VALUES ('68', '滁州市', 'c', '', '');
INSERT INTO `tc_city` VALUES ('69', '阜阳市', 'f', '', '');
INSERT INTO `tc_city` VALUES ('70', '淮北市', 'h', '', '');
INSERT INTO `tc_city` VALUES ('71', '淮南市', 'h', '', '');
INSERT INTO `tc_city` VALUES ('72', '黄山市', 'h', '', '');
INSERT INTO `tc_city` VALUES ('73', '六安市', 'l', '', '');
INSERT INTO `tc_city` VALUES ('74', '马鞍山市', 'm', '', '');
INSERT INTO `tc_city` VALUES ('75', '宿州市', 's', '', '');
INSERT INTO `tc_city` VALUES ('76', '铜陵市', 't', '', '');
INSERT INTO `tc_city` VALUES ('77', '芜湖市', 'w', '', '');
INSERT INTO `tc_city` VALUES ('78', '宣城市', 'x', '', '');
INSERT INTO `tc_city` VALUES ('79', '龙岩市', 'l', '', '');
INSERT INTO `tc_city` VALUES ('80', '南平市', 'n', '', '');
INSERT INTO `tc_city` VALUES ('81', '宁德市', 'n', '', '');
INSERT INTO `tc_city` VALUES ('82', '莆田市', 'p', '', '');
INSERT INTO `tc_city` VALUES ('83', '泉州市', 'q', '', '');
INSERT INTO `tc_city` VALUES ('84', '三明市', 's', '', '');
INSERT INTO `tc_city` VALUES ('85', '漳州市', 'z', '', '');
INSERT INTO `tc_city` VALUES ('86', '白银市', 'b', '', '');
INSERT INTO `tc_city` VALUES ('87', '定西市', 'd', '', '');
INSERT INTO `tc_city` VALUES ('88', '甘南市', 'g', '', '');
INSERT INTO `tc_city` VALUES ('89', '嘉峪关市', 'j', '', '');
INSERT INTO `tc_city` VALUES ('90', '金昌市', 'j', '', '');
INSERT INTO `tc_city` VALUES ('91', '酒泉市', 'j', '', '');
INSERT INTO `tc_city` VALUES ('92', '陇南市', 'l', '', '');
INSERT INTO `tc_city` VALUES ('93', '临夏市', 'l', '', '');
INSERT INTO `tc_city` VALUES ('94', '平凉市', 'p', '', '');
INSERT INTO `tc_city` VALUES ('95', '庆阳市', 'q', '', '');
INSERT INTO `tc_city` VALUES ('96', '天水市', 't', '', '');
INSERT INTO `tc_city` VALUES ('97', '武威市', 'w', '', '');
INSERT INTO `tc_city` VALUES ('98', '张掖市', 'z', '', '');
INSERT INTO `tc_city` VALUES ('99', '潮州市', 'c', '', '');
INSERT INTO `tc_city` VALUES ('100', '东莞市', 'd', '', '');
INSERT INTO `tc_city` VALUES ('101', '佛山市', 'f', '', '');
INSERT INTO `tc_city` VALUES ('102', '河源市', 'h', '', '');
INSERT INTO `tc_city` VALUES ('103', '惠州市', 'h', '', '');
INSERT INTO `tc_city` VALUES ('104', '江门市', 'j', '', '');
INSERT INTO `tc_city` VALUES ('105', '揭阳市', 'j', '', '');
INSERT INTO `tc_city` VALUES ('106', '茂名市', 'm', '', '');
INSERT INTO `tc_city` VALUES ('107', '梅州市', 'm', '', '');
INSERT INTO `tc_city` VALUES ('108', '清远市', 'q', '', '');
INSERT INTO `tc_city` VALUES ('109', '汕头市', 's', '', '');
INSERT INTO `tc_city` VALUES ('110', '汕尾市', 's', '', '');
INSERT INTO `tc_city` VALUES ('111', '韶关市', 's', '', '');
INSERT INTO `tc_city` VALUES ('112', '阳江市', 'y', '', '');
INSERT INTO `tc_city` VALUES ('113', '云浮市', 'y', '', '');
INSERT INTO `tc_city` VALUES ('114', '湛江市', 'z', '', '');
INSERT INTO `tc_city` VALUES ('115', '肇庆市', 'z', '', '');
INSERT INTO `tc_city` VALUES ('116', '中山市', 'z', '', '');
INSERT INTO `tc_city` VALUES ('117', '百色市', 'b', '', '');
INSERT INTO `tc_city` VALUES ('118', '北海市', 'b', '', '');
INSERT INTO `tc_city` VALUES ('119', '崇左市', 'c', '', '');
INSERT INTO `tc_city` VALUES ('120', '防城港市', 'f', '', '');
INSERT INTO `tc_city` VALUES ('121', '贵港市', 'g', '', '');
INSERT INTO `tc_city` VALUES ('122', '桂林市', 'g', '', '');
INSERT INTO `tc_city` VALUES ('123', '河池市', 'h', '', '');
INSERT INTO `tc_city` VALUES ('124', '贺州市', 'h', '', '');
INSERT INTO `tc_city` VALUES ('125', '来宾市', 'l', '', '');
INSERT INTO `tc_city` VALUES ('126', '柳州市', 'l', '', '');
INSERT INTO `tc_city` VALUES ('127', '钦州市', 'q', '', '');
INSERT INTO `tc_city` VALUES ('128', '梧州市', 'w', '', '');
INSERT INTO `tc_city` VALUES ('129', '玉林市', 'y', '', '');
INSERT INTO `tc_city` VALUES ('130', '安顺市', 'a', '', '');
INSERT INTO `tc_city` VALUES ('131', '毕节市', 'b', '', '');
INSERT INTO `tc_city` VALUES ('132', '六盘水市', 'l', '', '');
INSERT INTO `tc_city` VALUES ('133', '黔东南市', 'q', '', '');
INSERT INTO `tc_city` VALUES ('134', '黔南市', 'q', '', '');
INSERT INTO `tc_city` VALUES ('135', '黔西南市', 'q', '', '');
INSERT INTO `tc_city` VALUES ('136', '铜仁市', 't', '', '');
INSERT INTO `tc_city` VALUES ('137', '遵义市', 'z', '', '');
INSERT INTO `tc_city` VALUES ('138', '三沙市', 's', '', '');
INSERT INTO `tc_city` VALUES ('139', '三亚市', 's', '', '');
INSERT INTO `tc_city` VALUES ('140', '保定市', 'b', '', '');
INSERT INTO `tc_city` VALUES ('141', '沧州市', 'c', '', '');
INSERT INTO `tc_city` VALUES ('142', '承德市', 'c', '', '');
INSERT INTO `tc_city` VALUES ('143', '邯郸市', 'h', '', '');
INSERT INTO `tc_city` VALUES ('144', '衡水市', 'h', '', '');
INSERT INTO `tc_city` VALUES ('145', '廊坊市', 'l', '', '');
INSERT INTO `tc_city` VALUES ('146', '秦皇岛市', 'q', '', '');
INSERT INTO `tc_city` VALUES ('147', '唐山市', 't', '', '');
INSERT INTO `tc_city` VALUES ('148', '邢台市', 'x', '', '');
INSERT INTO `tc_city` VALUES ('149', '张家口市', 'z', '', '');
INSERT INTO `tc_city` VALUES ('150', '安阳市', 'a', '', '');
INSERT INTO `tc_city` VALUES ('151', '鹤壁市', 'h', '', '');
INSERT INTO `tc_city` VALUES ('152', '济源市', 'j', '', '');
INSERT INTO `tc_city` VALUES ('153', '焦作市', 'j', '', '');
INSERT INTO `tc_city` VALUES ('154', '开封市', 'k', '', '');
INSERT INTO `tc_city` VALUES ('155', '漯河市', 'l', '', '');
INSERT INTO `tc_city` VALUES ('156', '南阳市', 'n', '', '');
INSERT INTO `tc_city` VALUES ('157', '平顶山市', 'p', '', '');
INSERT INTO `tc_city` VALUES ('158', '濮阳市', 'p', '', '');
INSERT INTO `tc_city` VALUES ('159', '三门峡市', 's', '', '');
INSERT INTO `tc_city` VALUES ('160', '商丘市', 's', '', '');
INSERT INTO `tc_city` VALUES ('161', '新乡市', 'x', '', '');
INSERT INTO `tc_city` VALUES ('162', '信阳市', 'x', '', '');
INSERT INTO `tc_city` VALUES ('163', '许昌市', 'x', '', '');
INSERT INTO `tc_city` VALUES ('164', '周口市', 'z', '', '');
INSERT INTO `tc_city` VALUES ('165', '驻马店市', 'z', '', '');
INSERT INTO `tc_city` VALUES ('166', '大庆市', 'd', '', '');
INSERT INTO `tc_city` VALUES ('167', '大兴安岭市', 'd', '', '');
INSERT INTO `tc_city` VALUES ('168', '鹤岗市区', 'h', '', '');
INSERT INTO `tc_city` VALUES ('169', '黑河市', 'h', '', '');
INSERT INTO `tc_city` VALUES ('170', '佳木斯市', 'j', '', '');
INSERT INTO `tc_city` VALUES ('171', '鸡西市', 'j', '', '');
INSERT INTO `tc_city` VALUES ('172', '牡丹江市', 'm', '', '');
INSERT INTO `tc_city` VALUES ('173', '齐齐哈尔市', 'q', '', '');
INSERT INTO `tc_city` VALUES ('174', '七台河市', 'q', '', '');
INSERT INTO `tc_city` VALUES ('175', '双鸭山市', 's', '', '');
INSERT INTO `tc_city` VALUES ('176', '绥化市', 's', '', '');
INSERT INTO `tc_city` VALUES ('177', '伊春市', 'y', '', '');
INSERT INTO `tc_city` VALUES ('178', '鄂州市', 'e', '', '');
INSERT INTO `tc_city` VALUES ('179', '恩施市', 'e', '', '');
INSERT INTO `tc_city` VALUES ('180', '黄冈市', 'h', '', '');
INSERT INTO `tc_city` VALUES ('181', '黄石市', 'h', '', '');
INSERT INTO `tc_city` VALUES ('182', '荆门市', 'j', '', '');
INSERT INTO `tc_city` VALUES ('183', '荆州市', 'j', '', '');
INSERT INTO `tc_city` VALUES ('184', '潜江市', 'q', '', '');
INSERT INTO `tc_city` VALUES ('185', '神农架市', 's', '', '');
INSERT INTO `tc_city` VALUES ('186', '十堰市', 's', '', '');
INSERT INTO `tc_city` VALUES ('187', '随州市', 's', '', '');
INSERT INTO `tc_city` VALUES ('188', '天门市', 't', '', '');
INSERT INTO `tc_city` VALUES ('189', '咸宁市', 'x', '', '');
INSERT INTO `tc_city` VALUES ('190', '仙桃市', 'x', '', '');
INSERT INTO `tc_city` VALUES ('191', '襄樊市', 'x', '', '');
INSERT INTO `tc_city` VALUES ('192', '孝感市', 'x', '', '');
INSERT INTO `tc_city` VALUES ('193', '宜昌市', 'y', '', '');
INSERT INTO `tc_city` VALUES ('194', '常德市', 'c', '', '');
INSERT INTO `tc_city` VALUES ('195', '郴州市', 'c', '', '');
INSERT INTO `tc_city` VALUES ('196', '衡阳市', 'h', '', '');
INSERT INTO `tc_city` VALUES ('197', '怀化市', 'h', '', '');
INSERT INTO `tc_city` VALUES ('198', '娄底市', 'l', '', '');
INSERT INTO `tc_city` VALUES ('199', '邵阳市', 's', '', '');
INSERT INTO `tc_city` VALUES ('200', '湘潭市', 'x', '', '');
INSERT INTO `tc_city` VALUES ('201', '湘西市', 'x', '', '');
INSERT INTO `tc_city` VALUES ('202', '益阳市', 'y', '', '');
INSERT INTO `tc_city` VALUES ('203', '永州市', 'y', '', '');
INSERT INTO `tc_city` VALUES ('204', '岳阳市', 'y', '', '');
INSERT INTO `tc_city` VALUES ('205', '张家界市', 'z', '', '');
INSERT INTO `tc_city` VALUES ('206', '株洲市', 'z', '', '');
INSERT INTO `tc_city` VALUES ('207', '白城市', 'b', '', '');
INSERT INTO `tc_city` VALUES ('208', '白山市', 'b', '', '');
INSERT INTO `tc_city` VALUES ('209', '吉林市', 'j', '', '');
INSERT INTO `tc_city` VALUES ('210', '辽源市', 'l', '', '');
INSERT INTO `tc_city` VALUES ('211', '四平市', 's', '', '');
INSERT INTO `tc_city` VALUES ('212', '松原市', 's', '', '');
INSERT INTO `tc_city` VALUES ('213', '通化市', 't', '', '');
INSERT INTO `tc_city` VALUES ('214', '延边市', 'y', '', '');
INSERT INTO `tc_city` VALUES ('215', '常州市', 'c', '', '');
INSERT INTO `tc_city` VALUES ('216', '淮安市', 'h', '', '');
INSERT INTO `tc_city` VALUES ('217', '连云港市', 'l', '', '');
INSERT INTO `tc_city` VALUES ('218', '南通市', 'n', '', '');
INSERT INTO `tc_city` VALUES ('219', '苏州市', 's', '', '');
INSERT INTO `tc_city` VALUES ('220', '宿迁市', 's', '', '');
INSERT INTO `tc_city` VALUES ('221', '徐州市', 'x', '', '');
INSERT INTO `tc_city` VALUES ('222', '泰州市', 't', '', '');
INSERT INTO `tc_city` VALUES ('223', '无锡市', 'w', '', '');
INSERT INTO `tc_city` VALUES ('224', '盐城市', 'y', '', '');
INSERT INTO `tc_city` VALUES ('225', '扬州市', 'y', '', '');
INSERT INTO `tc_city` VALUES ('226', '镇江市', 'z', '', '');
INSERT INTO `tc_city` VALUES ('227', '赣州市', 'g', '', '');
INSERT INTO `tc_city` VALUES ('228', '吉安市', 'j', '', '');
INSERT INTO `tc_city` VALUES ('229', '景德镇市', 'j', '', '');
INSERT INTO `tc_city` VALUES ('230', '九江市', 'j', '', '');
INSERT INTO `tc_city` VALUES ('231', '萍乡市', 'p', '', '');
INSERT INTO `tc_city` VALUES ('232', '上饶市', 's', '', '');
INSERT INTO `tc_city` VALUES ('233', '抚州市', 'f', '', '');
INSERT INTO `tc_city` VALUES ('234', '新余市', 'x', '', '');
INSERT INTO `tc_city` VALUES ('235', '宜春市', 'y', '', '');
INSERT INTO `tc_city` VALUES ('236', '鹰潭市', 'y', '', '');
INSERT INTO `tc_city` VALUES ('237', '鞍山市', 'a', '', '');
INSERT INTO `tc_city` VALUES ('238', '本溪市', 'b', '', '');
INSERT INTO `tc_city` VALUES ('239', '朝阳市', 'c', '', '');
INSERT INTO `tc_city` VALUES ('240', '大连市', 'd', '', '');
INSERT INTO `tc_city` VALUES ('241', '丹东市', 'd', '', '');
INSERT INTO `tc_city` VALUES ('242', '葫芦岛市', 'h', '', '');
INSERT INTO `tc_city` VALUES ('243', '抚顺市', 'f', '', '');
INSERT INTO `tc_city` VALUES ('244', '阜新市', 'f', '', '');
INSERT INTO `tc_city` VALUES ('245', '锦州市', 'j', '', '');
INSERT INTO `tc_city` VALUES ('246', '辽阳市', 'l', '', '');
INSERT INTO `tc_city` VALUES ('247', '盘锦市', 'p', '', '');
INSERT INTO `tc_city` VALUES ('248', '铁岭市', 't', '', '');
INSERT INTO `tc_city` VALUES ('249', '营口市', 'y', '', '');
INSERT INTO `tc_city` VALUES ('250', '阿拉善盟市', 'a', '', '');
INSERT INTO `tc_city` VALUES ('251', '巴彦淖尔市', 'b', '', '');
INSERT INTO `tc_city` VALUES ('252', '包头市', 'b', '', '');
INSERT INTO `tc_city` VALUES ('253', '赤峰市', 'c', '', '');
INSERT INTO `tc_city` VALUES ('254', '鄂尔多斯市', 'e', '', '');
INSERT INTO `tc_city` VALUES ('255', '呼伦贝尔市', 'h', '', '');
INSERT INTO `tc_city` VALUES ('256', '通辽市', 't', '', '');
INSERT INTO `tc_city` VALUES ('257', '乌海市', 'w', '', '');
INSERT INTO `tc_city` VALUES ('258', '乌兰察布市', 'w', '', '');
INSERT INTO `tc_city` VALUES ('259', '锡林郭勒盟市', 'x', '', '');
INSERT INTO `tc_city` VALUES ('260', '兴安盟市', 'x', '', '');
INSERT INTO `tc_city` VALUES ('261', '固原市', 'g', '', '');
INSERT INTO `tc_city` VALUES ('262', '石嘴山市', 's', '', '');
INSERT INTO `tc_city` VALUES ('263', '吴忠市', 'w', '', '');
INSERT INTO `tc_city` VALUES ('264', '中卫市', 'z', '', '');
INSERT INTO `tc_city` VALUES ('265', '果洛市', 'g', '', '');
INSERT INTO `tc_city` VALUES ('266', '海北市', 'h', '', '');
INSERT INTO `tc_city` VALUES ('267', '海东市', 'h', '', '');
INSERT INTO `tc_city` VALUES ('268', '海南市', 'h', '', '');
INSERT INTO `tc_city` VALUES ('269', '海西市', 'h', '', '');
INSERT INTO `tc_city` VALUES ('270', '黄南市', 'h', '', '');
INSERT INTO `tc_city` VALUES ('271', '玉树市', 'y', '', '');
INSERT INTO `tc_city` VALUES ('272', '滨州市', 'b', '', '');
INSERT INTO `tc_city` VALUES ('273', '德州市', 'd', '', '');
INSERT INTO `tc_city` VALUES ('274', '东营市', 'd', '', '');
INSERT INTO `tc_city` VALUES ('275', '菏泽市', 'h', '', '');
INSERT INTO `tc_city` VALUES ('276', '济宁市', 'j', '', '');
INSERT INTO `tc_city` VALUES ('277', '莱芜市', 'l', '', '');
INSERT INTO `tc_city` VALUES ('278', '聊城市', 'l', '', '');
INSERT INTO `tc_city` VALUES ('279', '临沂市', 'l', '', '');
INSERT INTO `tc_city` VALUES ('280', '日照市', 'r', '', '');
INSERT INTO `tc_city` VALUES ('281', '泰安市', 't', '', '');
INSERT INTO `tc_city` VALUES ('282', '威海市', 'w', '', '');
INSERT INTO `tc_city` VALUES ('283', '潍坊市', 'w', '', '');
INSERT INTO `tc_city` VALUES ('284', '烟台市', 'y', '', '');
INSERT INTO `tc_city` VALUES ('285', '枣庄市', 'z', '', '');
INSERT INTO `tc_city` VALUES ('286', '淄博市', 'z', '', '');
INSERT INTO `tc_city` VALUES ('287', '长治市', 'c', '', '');
INSERT INTO `tc_city` VALUES ('288', '大同市', 'd', '', '');
INSERT INTO `tc_city` VALUES ('289', '晋城市', 'j', '', '');
INSERT INTO `tc_city` VALUES ('290', '晋中市', 'j', '', '');
INSERT INTO `tc_city` VALUES ('291', '临汾市', 'l', '', '');
INSERT INTO `tc_city` VALUES ('292', '吕梁市', 'l', '', '');
INSERT INTO `tc_city` VALUES ('293', '朔州市', 's', '', '');
INSERT INTO `tc_city` VALUES ('294', '忻州市', 'x', '', '');
INSERT INTO `tc_city` VALUES ('295', '阳泉市', 'y', '', '');
INSERT INTO `tc_city` VALUES ('296', '运城市', 'y', '', '');
INSERT INTO `tc_city` VALUES ('297', '安康市', 'a', '', '');
INSERT INTO `tc_city` VALUES ('298', '宝鸡市', 'b', '', '');
INSERT INTO `tc_city` VALUES ('299', '汉中市', 'h', '', '');
INSERT INTO `tc_city` VALUES ('300', '商洛市', 's', '', '');
INSERT INTO `tc_city` VALUES ('301', '铜川市', 't', '', '');
INSERT INTO `tc_city` VALUES ('302', '渭南市', 'w', '', '');
INSERT INTO `tc_city` VALUES ('303', '咸阳市', 'x', '', '');
INSERT INTO `tc_city` VALUES ('304', '延安市', 'y', '', '');
INSERT INTO `tc_city` VALUES ('305', '榆林市', 'y', '', '');
INSERT INTO `tc_city` VALUES ('306', '阿坝市', 'a', '', '');
INSERT INTO `tc_city` VALUES ('307', '巴中市', 'b', '', '');
INSERT INTO `tc_city` VALUES ('308', '甘孜市', 'g', '', '');
INSERT INTO `tc_city` VALUES ('309', '凉山市', 'l', '', '');
INSERT INTO `tc_city` VALUES ('310', '泸州市', 'l', '', '');
INSERT INTO `tc_city` VALUES ('311', '眉山市', 'm', '', '');
INSERT INTO `tc_city` VALUES ('312', '绵阳市', 'm', '', '');
INSERT INTO `tc_city` VALUES ('313', '内江市', 'n', '', '');
INSERT INTO `tc_city` VALUES ('314', '攀枝花市', 'p', '', '');
INSERT INTO `tc_city` VALUES ('315', '雅安市', 'y', '', '');
INSERT INTO `tc_city` VALUES ('316', '自贡市', 'z', '', '');
INSERT INTO `tc_city` VALUES ('317', '资阳市', 'z', '', '');
INSERT INTO `tc_city` VALUES ('318', '阿里市', 'a', '', '');
INSERT INTO `tc_city` VALUES ('319', '昌都市', 'c', '', '');
INSERT INTO `tc_city` VALUES ('320', '林芝市', 'l', '', '');
INSERT INTO `tc_city` VALUES ('321', '那曲市', 'n', '', '');
INSERT INTO `tc_city` VALUES ('322', '日喀则市', 'r', '', '');
INSERT INTO `tc_city` VALUES ('323', '山南市', 's', '', '');
INSERT INTO `tc_city` VALUES ('324', '阿克苏市', 'a', '', '');
INSERT INTO `tc_city` VALUES ('325', '阿拉尔市', 'a', '', '');
INSERT INTO `tc_city` VALUES ('326', '阿勒泰市', 'a', '', '');
INSERT INTO `tc_city` VALUES ('327', '巴音郭楞市', 'b', '', '');
INSERT INTO `tc_city` VALUES ('328', '博尔塔拉市', 'b', '', '');
INSERT INTO `tc_city` VALUES ('329', '昌吉市', 'c', '', '');
INSERT INTO `tc_city` VALUES ('330', '喀什市', 'k', '', '');
INSERT INTO `tc_city` VALUES ('331', '克拉玛依市', 'k', '', '');
INSERT INTO `tc_city` VALUES ('332', '克孜勒苏市', 'k', '', '');
INSERT INTO `tc_city` VALUES ('333', '哈密市', 'h', '', '');
INSERT INTO `tc_city` VALUES ('334', '和田市', 'h', '', '');
INSERT INTO `tc_city` VALUES ('335', '石河子市', 's', '', '');
INSERT INTO `tc_city` VALUES ('336', '塔城市', 't', '', '');
INSERT INTO `tc_city` VALUES ('337', '吐鲁番市', 't', '', '');
INSERT INTO `tc_city` VALUES ('338', '图木舒克市', 't', '', '');
INSERT INTO `tc_city` VALUES ('339', '五家渠市', 'w', '', '');
INSERT INTO `tc_city` VALUES ('340', '伊犁市', 'y', '', '');
INSERT INTO `tc_city` VALUES ('341', '保山市', 'b', '', '');
INSERT INTO `tc_city` VALUES ('342', '楚雄市', 'c', '', '');
INSERT INTO `tc_city` VALUES ('343', '大理市', 'd', '', '');
INSERT INTO `tc_city` VALUES ('344', '德宏市', 'd', '', '');
INSERT INTO `tc_city` VALUES ('345', '迪庆市', 'd', '', '');
INSERT INTO `tc_city` VALUES ('346', '红河市', 'h', '', '');
INSERT INTO `tc_city` VALUES ('347', '丽江市', 'l', '', '');
INSERT INTO `tc_city` VALUES ('348', '临沧市', 'l', '', '');
INSERT INTO `tc_city` VALUES ('349', '怒江市', 'n', '', '');
INSERT INTO `tc_city` VALUES ('350', '普洱市', 'p', '', '');
INSERT INTO `tc_city` VALUES ('351', '曲靖市', 'q', '', '');
INSERT INTO `tc_city` VALUES ('352', '文山市', 'w', '', '');
INSERT INTO `tc_city` VALUES ('353', '西双版纳市', 'x', '', '');
INSERT INTO `tc_city` VALUES ('354', '玉溪市', 'y', '', '');
INSERT INTO `tc_city` VALUES ('355', '昭通市', 's', '', '');
INSERT INTO `tc_city` VALUES ('356', '衡州市', 'h', '', '');
INSERT INTO `tc_city` VALUES ('357', '湖州市', 'h', '', '');
INSERT INTO `tc_city` VALUES ('358', '嘉兴市', 'j', '', '');
INSERT INTO `tc_city` VALUES ('359', '金华市', 'j', '', '');
INSERT INTO `tc_city` VALUES ('360', '丽水市', 'l', '', '');
INSERT INTO `tc_city` VALUES ('361', '宁波市', 'n', '', '');
INSERT INTO `tc_city` VALUES ('362', '绍兴市', 's', '', '');
INSERT INTO `tc_city` VALUES ('363', '台州市', 't', '', '');
INSERT INTO `tc_city` VALUES ('364', '温州市', 'w', '', '');
INSERT INTO `tc_city` VALUES ('365', '舟山市', 'z', '', '');

-- ----------------------------
-- Table structure for `tc_code`
-- ----------------------------
DROP TABLE IF EXISTS `tc_code`;
CREATE TABLE `tc_code` (
  `phone` varchar(20) NOT NULL,
  `code` varchar(10) NOT NULL,
  `createtime` int(11) NOT NULL,
  UNIQUE KEY `phone` (`phone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tc_code
-- ----------------------------

-- ----------------------------
-- Table structure for `tc_collect_supplier`
-- ----------------------------
DROP TABLE IF EXISTS `tc_collect_supplier`;
CREATE TABLE `tc_collect_supplier` (
  `uid` int(11) NOT NULL,
  `sid` int(11) NOT NULL,
  `create_time` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tc_collect_supplier
-- ----------------------------

-- ----------------------------
-- Table structure for `tc_feedback`
-- ----------------------------
DROP TABLE IF EXISTS `tc_feedback`;
CREATE TABLE `tc_feedback` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT '用户Id',
  `content` varchar(512) NOT NULL DEFAULT '' COMMENT '反馈内容',
  `createtime` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='反馈意见';

-- ----------------------------
-- Records of tc_feedback
-- ----------------------------
INSERT INTO `tc_feedback` VALUES ('1', '20000000', '咯男男女女', '1459299720');
INSERT INTO `tc_feedback` VALUES ('2', '20000000', '添加剂了', '1459353103');
INSERT INTO `tc_feedback` VALUES ('3', '20000002', '测试反馈', '1459499113');
INSERT INTO `tc_feedback` VALUES ('4', '20000002', '我要反馈', '1461899779');
INSERT INTO `tc_feedback` VALUES ('5', '20000002', '问题多多', '1462847210');
INSERT INTO `tc_feedback` VALUES ('6', '20000025', '这是什么问题', '1462847509');
INSERT INTO `tc_feedback` VALUES ('7', '20000115', 'Hhggff', '1474364156');

-- ----------------------------
-- Table structure for `tc_goods`
-- ----------------------------
DROP TABLE IF EXISTS `tc_goods`;
CREATE TABLE `tc_goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sid` int(11) NOT NULL,
  `smallUrl` varchar(100) NOT NULL,
  `originUrl` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `profile` text,
  `sale_price` varchar(20) DEFAULT '0',
  `original_price` varchar(20) NOT NULL,
  `cheap_price` varchar(20) NOT NULL,
  `type` tinyint(4) NOT NULL COMMENT '1.商品，2.优惠券',
  `transport_method` tinyint(4) NOT NULL COMMENT '1.到付，2.快递',
  `transport_price` varchar(20) DEFAULT '0',
  `is_cheap` tinyint(4) DEFAULT '0' COMMENT '0.没有特价，1.有特价',
  `deducted_price` varchar(20) DEFAULT '0',
  `start_time` varchar(20) DEFAULT '',
  `end_time` varchar(20) DEFAULT '',
  `click_count` int(11) DEFAULT '0' COMMENT '商品点击数量',
  `create_time` varchar(20) NOT NULL,
  `update_price` varchar(20) DEFAULT '0' COMMENT '修改的价格',
  `update_time` varchar(20) DEFAULT '' COMMENT '最后编辑时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tc_goods
-- ----------------------------
INSERT INTO `tc_goods` VALUES ('1', '1', '/Uploads/Picture/20170323/s_e31059b697bbf19a.jpg', '/Uploads/Picture/20170323/e31059b697bbf19a.jpg', '小吃', '哈哈大笑借钱给我看我小心翼翼小心翼翼与兔兔兔下雨天来了句QQ图图图图咯根据具体思路更可恶t咯微信我哦lo mo yjwwwwww', '0', '12', '0', '1', '2', '', '0', '0', '', '', '11', '1490278224', '12.0', '1490583410');
INSERT INTO `tc_goods` VALUES ('8', '1', '/Uploads/Picture/20170324/s_4c9a53dfde53cce8.jpg', '/Uploads/Picture/20170324/4c9a53dfde53cce8.jpg', '商品', '阿萨斯将会尽快海陆空回家看了你就看了就看了就看了好会考虑京津冀经济京津冀经济京津冀经济很快看看看看看看看看看看看看看看看看哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈好看好看好看好看好看好看好看好看好看户口结果公告公告公告公告公告公告公告高科技京津冀经济京津冀经济京津冀经济框架广告广告广告广告广告广告广告广告框架广告广告广告广告广告广告广告广告框架广告广告广告广告广告广告广告广告框架广告广告广告广告广告广告广告广告框架广告广告广告广告广告广告广告广告可根据京津冀经济京津冀经济京津冀经济可根据京津冀经济京津冀经济京津冀经济可根据解决经济京津冀经济京津冀经济即可观看经济', '0', '18', '0', '1', '1', '0', '0', '0', '', '', '10', '1490322085', '0', '');
INSERT INTO `tc_goods` VALUES ('11', '3', '/Uploads/Picture/20170324/s_17a6e99b046e4420.jpg', '/Uploads/Picture/20170324/17a6e99b046e4420.jpg', '辣条', '哈哈', '0', '5', '0', '1', '2', '2', '0', '0', '', '', '29', '1490324247', '5', '1490583089');
INSERT INTO `tc_goods` VALUES ('19', '3', '/Uploads/Picture/20170324/s_a84823a6340182df.jpg', '/Uploads/Picture/20170324/a84823a6340182df.jpg', '商品2', '无', '0', '101', '100', '1', '1', '0', '1', '0', '', '', '13', '1490335298', '0', '');
INSERT INTO `tc_goods` VALUES ('20', '3', '/Uploads/Picture/20170326/s_e67ad0b257218a5d.jpg', '/Uploads/Picture/20170326/e67ad0b257218a5d.jpg', '测优惠券', '44', '0', '5', '0', '2', '0', '0', '0', '10', '1490500020', '1490803200', '9', '1490500069', '0', '');
INSERT INTO `tc_goods` VALUES ('21', '1', '/Uploads/Picture/20170327/s_aef911d9d6af1794.jpg', '/Uploads/Picture/20170327/aef911d9d6af1794.jpg', '优惠券1', '优惠券', '0', '18', '0', '2', '0', '0', '0', '10', '1490577120', '1490976000', '11', '1490577142', '0', '');
INSERT INTO `tc_goods` VALUES ('22', '1', '/Uploads/Picture/20170327/s_b3705f2671783813.jpg', '/Uploads/Picture/20170327/b3705f2671783813.jpg', '优惠券2', '优惠券', '0', '10', '0', '2', '0', '0', '0', '15', '1490577120', '1490716800', '6', '1490577171', '0', '');
INSERT INTO `tc_goods` VALUES ('24', '3', '/Uploads/Picture/20170327/s_bd7631c70b309929.jpg', '/Uploads/Picture/20170327/bd7631c70b309929.jpg', '优惠券', '玉', '0', '18', '0', '2', '0', '0', '0', '12', '1490577600', '1490803200', '13', '1490577620', '0', '');
INSERT INTO `tc_goods` VALUES ('25', '3', '/Uploads/Picture/20170327/s_8a2b4dfc8aa043e0.jpg', '/Uploads/Picture/20170327/8a2b4dfc8aa043e0.jpg', '优惠券一', '优惠券', '0', '8', '0', '2', '0', '0', '0', '10', '1490577960', '1490716800', '10', '1490577974', '0', '');
INSERT INTO `tc_goods` VALUES ('26', '3', '/Uploads/Picture/20170327/s_ca0fdb6916d64466.jpg', '/Uploads/Picture/20170327/ca0fdb6916d64466.jpg', '优惠券二', '优惠券', '0', '10', '0', '2', '0', '0', '0', '20', '1490577960', '1490803200', '12', '1490578004', '0', '');
INSERT INTO `tc_goods` VALUES ('27', '3', '/Uploads/Picture/20170327/s_8b9f3634fc4ba938.jpg', '/Uploads/Picture/20170327/8b9f3634fc4ba938.jpg', '优惠券三', '该喝喝', '0', '10', '0', '2', '0', '0', '0', '15', '1490578260', '1490976000', '8', '1490578298', '0', '');
INSERT INTO `tc_goods` VALUES ('30', '1', '/Uploads/Picture/20170327/s_2028a6223b268eb2.jpg', '/Uploads/Picture/20170327/2028a6223b268eb2.jpg', '一拳', '科技', '0', '30', '0', '2', '0', '0', '0', '20', '1490587200', '1490716800', '3', '1490581849', '0', '');
INSERT INTO `tc_goods` VALUES ('31', '1', '/Uploads/Picture/20170327/s_c1d34211966313e7.jpg', '/Uploads/Picture/20170327/c1d34211966313e7.jpg', '商品2', '商品商品', '0', '20', '0', '1', '2', '2', '0', '0', '', '', '10', '1490583313', '0', '');
INSERT INTO `tc_goods` VALUES ('32', '1', '/Uploads/Picture/20170327/s_88efd1edb8f92673.jpg', '/Uploads/Picture/20170327/88efd1edb8f92673.jpg', '小馒头', '小馒头', '0', '30', '0', '1', '2', '0', '0', '0', '', '', '8', '1490583440', '0', '');
INSERT INTO `tc_goods` VALUES ('33', '4', '/Uploads/Picture/20170327/s_c137a0a936374bf0.jpg', '/Uploads/Picture/20170327/c137a0a936374bf0.jpg', '优惠券1', '优惠券', '0', '15', '0', '2', '0', '0', '0', '20', '1490605260', '1490630400', '8', '1490605327', '0', '');
INSERT INTO `tc_goods` VALUES ('34', '4', '/Uploads/Picture/20170327/s_c908f88afc39e973.jpg', '/Uploads/Picture/20170327/c908f88afc39e973.jpg', '优惠券2', '优惠券', '0', '15', '0', '2', '0', '0', '0', '30', '1490605320', '1490803200', '6', '1490605352', '0', '');
INSERT INTO `tc_goods` VALUES ('35', '4', '/Uploads/Picture/20170327/s_f6be1a1d5cac7983.jpg', '/Uploads/Picture/20170327/f6be1a1d5cac7983.jpg', '商品1', '商品1', '0', '20', '0', '1', '2', '0', '0', '0', '', '', '12', '1490605501', '0', '');

-- ----------------------------
-- Table structure for `tc_goods_click`
-- ----------------------------
DROP TABLE IF EXISTS `tc_goods_click`;
CREATE TABLE `tc_goods_click` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `goods_id` int(11) NOT NULL,
  `create_time` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=357 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tc_goods_click
-- ----------------------------
INSERT INTO `tc_goods_click` VALUES ('1', '1', '1490320407');
INSERT INTO `tc_goods_click` VALUES ('2', '9', '1490322605');
INSERT INTO `tc_goods_click` VALUES ('3', '10', '1490322617');
INSERT INTO `tc_goods_click` VALUES ('4', '2', '1490322626');
INSERT INTO `tc_goods_click` VALUES ('5', '3', '1490322631');
INSERT INTO `tc_goods_click` VALUES ('6', '4', '1490322636');
INSERT INTO `tc_goods_click` VALUES ('7', '4', '1490322644');
INSERT INTO `tc_goods_click` VALUES ('8', '3', '1490323349');
INSERT INTO `tc_goods_click` VALUES ('9', '2', '1490324687');
INSERT INTO `tc_goods_click` VALUES ('10', '4', '1490324691');
INSERT INTO `tc_goods_click` VALUES ('11', '10', '1490324704');
INSERT INTO `tc_goods_click` VALUES ('12', '9', '1490324704');
INSERT INTO `tc_goods_click` VALUES ('13', '14', '1490324726');
INSERT INTO `tc_goods_click` VALUES ('14', '13', '1490324728');
INSERT INTO `tc_goods_click` VALUES ('15', '14', '1490324756');
INSERT INTO `tc_goods_click` VALUES ('16', '13', '1490324838');
INSERT INTO `tc_goods_click` VALUES ('17', '14', '1490324850');
INSERT INTO `tc_goods_click` VALUES ('18', '14', '1490324882');
INSERT INTO `tc_goods_click` VALUES ('19', '13', '1490324955');
INSERT INTO `tc_goods_click` VALUES ('20', '13', '1490324960');
INSERT INTO `tc_goods_click` VALUES ('21', '14', '1490324963');
INSERT INTO `tc_goods_click` VALUES ('22', '14', '1490324965');
INSERT INTO `tc_goods_click` VALUES ('23', '13', '1490325174');
INSERT INTO `tc_goods_click` VALUES ('24', '14', '1490325177');
INSERT INTO `tc_goods_click` VALUES ('25', '13', '1490325227');
INSERT INTO `tc_goods_click` VALUES ('26', '14', '1490325235');
INSERT INTO `tc_goods_click` VALUES ('27', '13', '1490325249');
INSERT INTO `tc_goods_click` VALUES ('28', '13', '1490325298');
INSERT INTO `tc_goods_click` VALUES ('29', '14', '1490325304');
INSERT INTO `tc_goods_click` VALUES ('30', '15', '1490325525');
INSERT INTO `tc_goods_click` VALUES ('31', '16', '1490325527');
INSERT INTO `tc_goods_click` VALUES ('32', '15', '1490325542');
INSERT INTO `tc_goods_click` VALUES ('33', '3', '1490325586');
INSERT INTO `tc_goods_click` VALUES ('34', '1', '1490325612');
INSERT INTO `tc_goods_click` VALUES ('35', '3', '1490325619');
INSERT INTO `tc_goods_click` VALUES ('36', '3', '1490325641');
INSERT INTO `tc_goods_click` VALUES ('37', '1', '1490325668');
INSERT INTO `tc_goods_click` VALUES ('38', '3', '1490325670');
INSERT INTO `tc_goods_click` VALUES ('39', '11', '1490325711');
INSERT INTO `tc_goods_click` VALUES ('40', '1', '1490325734');
INSERT INTO `tc_goods_click` VALUES ('41', '3', '1490325737');
INSERT INTO `tc_goods_click` VALUES ('42', '15', '1490325849');
INSERT INTO `tc_goods_click` VALUES ('43', '16', '1490325852');
INSERT INTO `tc_goods_click` VALUES ('44', '15', '1490325869');
INSERT INTO `tc_goods_click` VALUES ('45', '13', '1490325929');
INSERT INTO `tc_goods_click` VALUES ('46', '14', '1490325934');
INSERT INTO `tc_goods_click` VALUES ('47', '13', '1490325938');
INSERT INTO `tc_goods_click` VALUES ('48', '14', '1490325942');
INSERT INTO `tc_goods_click` VALUES ('49', '15', '1490325953');
INSERT INTO `tc_goods_click` VALUES ('50', '15', '1490326571');
INSERT INTO `tc_goods_click` VALUES ('51', '13', '1490327043');
INSERT INTO `tc_goods_click` VALUES ('52', '14', '1490327044');
INSERT INTO `tc_goods_click` VALUES ('53', '14', '1490327110');
INSERT INTO `tc_goods_click` VALUES ('54', '14', '1490327146');
INSERT INTO `tc_goods_click` VALUES ('55', '14', '1490327931');
INSERT INTO `tc_goods_click` VALUES ('56', '14', '1490332430');
INSERT INTO `tc_goods_click` VALUES ('57', '14', '1490332436');
INSERT INTO `tc_goods_click` VALUES ('58', '14', '1490332497');
INSERT INTO `tc_goods_click` VALUES ('59', '17', '1490332546');
INSERT INTO `tc_goods_click` VALUES ('60', '18', '1490332550');
INSERT INTO `tc_goods_click` VALUES ('61', '17', '1490332554');
INSERT INTO `tc_goods_click` VALUES ('62', '17', '1490332572');
INSERT INTO `tc_goods_click` VALUES ('63', '18', '1490332576');
INSERT INTO `tc_goods_click` VALUES ('64', '18', '1490332580');
INSERT INTO `tc_goods_click` VALUES ('65', '18', '1490332586');
INSERT INTO `tc_goods_click` VALUES ('66', '17', '1490332591');
INSERT INTO `tc_goods_click` VALUES ('67', '17', '1490332608');
INSERT INTO `tc_goods_click` VALUES ('68', '17', '1490332612');
INSERT INTO `tc_goods_click` VALUES ('69', '18', '1490332629');
INSERT INTO `tc_goods_click` VALUES ('70', '17', '1490332652');
INSERT INTO `tc_goods_click` VALUES ('71', '18', '1490332655');
INSERT INTO `tc_goods_click` VALUES ('72', '17', '1490332686');
INSERT INTO `tc_goods_click` VALUES ('73', '16', '1490332983');
INSERT INTO `tc_goods_click` VALUES ('74', '16', '1490332987');
INSERT INTO `tc_goods_click` VALUES ('75', '16', '1490333001');
INSERT INTO `tc_goods_click` VALUES ('76', '3', '1490333016');
INSERT INTO `tc_goods_click` VALUES ('77', '12', '1490333062');
INSERT INTO `tc_goods_click` VALUES ('78', '11', '1490333065');
INSERT INTO `tc_goods_click` VALUES ('79', '11', '1490333070');
INSERT INTO `tc_goods_click` VALUES ('80', '3', '1490333086');
INSERT INTO `tc_goods_click` VALUES ('81', '3', '1490333091');
INSERT INTO `tc_goods_click` VALUES ('82', '3', '1490333094');
INSERT INTO `tc_goods_click` VALUES ('83', '3', '1490333098');
INSERT INTO `tc_goods_click` VALUES ('84', '8', '1490333157');
INSERT INTO `tc_goods_click` VALUES ('85', '8', '1490333161');
INSERT INTO `tc_goods_click` VALUES ('86', '12', '1490333609');
INSERT INTO `tc_goods_click` VALUES ('87', '8', '1490334133');
INSERT INTO `tc_goods_click` VALUES ('88', '12', '1490334148');
INSERT INTO `tc_goods_click` VALUES ('89', '8', '1490334162');
INSERT INTO `tc_goods_click` VALUES ('90', '12', '1490334251');
INSERT INTO `tc_goods_click` VALUES ('91', '12', '1490334258');
INSERT INTO `tc_goods_click` VALUES ('92', '12', '1490334330');
INSERT INTO `tc_goods_click` VALUES ('93', '12', '1490334452');
INSERT INTO `tc_goods_click` VALUES ('94', '11', '1490334661');
INSERT INTO `tc_goods_click` VALUES ('95', '11', '1490334687');
INSERT INTO `tc_goods_click` VALUES ('96', '17', '1490334721');
INSERT INTO `tc_goods_click` VALUES ('97', '17', '1490334727');
INSERT INTO `tc_goods_click` VALUES ('98', '18', '1490334728');
INSERT INTO `tc_goods_click` VALUES ('99', '6', '1490334730');
INSERT INTO `tc_goods_click` VALUES ('100', '14', '1490334732');
INSERT INTO `tc_goods_click` VALUES ('101', '12', '1490334736');
INSERT INTO `tc_goods_click` VALUES ('102', '11', '1490334737');
INSERT INTO `tc_goods_click` VALUES ('103', '12', '1490334748');
INSERT INTO `tc_goods_click` VALUES ('104', '11', '1490334776');
INSERT INTO `tc_goods_click` VALUES ('105', '3', '1490334793');
INSERT INTO `tc_goods_click` VALUES ('106', '11', '1490334813');
INSERT INTO `tc_goods_click` VALUES ('107', '11', '1490334866');
INSERT INTO `tc_goods_click` VALUES ('108', '6', '1490335128');
INSERT INTO `tc_goods_click` VALUES ('109', '12', '1490335211');
INSERT INTO `tc_goods_click` VALUES ('110', '16', '1490335242');
INSERT INTO `tc_goods_click` VALUES ('111', '12', '1490335262');
INSERT INTO `tc_goods_click` VALUES ('112', '12', '1490335402');
INSERT INTO `tc_goods_click` VALUES ('113', '19', '1490335407');
INSERT INTO `tc_goods_click` VALUES ('114', '17', '1490335417');
INSERT INTO `tc_goods_click` VALUES ('115', '18', '1490335443');
INSERT INTO `tc_goods_click` VALUES ('116', '17', '1490335445');
INSERT INTO `tc_goods_click` VALUES ('117', '17', '1490335463');
INSERT INTO `tc_goods_click` VALUES ('118', '12', '1490335467');
INSERT INTO `tc_goods_click` VALUES ('119', '19', '1490335471');
INSERT INTO `tc_goods_click` VALUES ('120', '12', '1490335738');
INSERT INTO `tc_goods_click` VALUES ('121', '12', '1490335744');
INSERT INTO `tc_goods_click` VALUES ('122', '12', '1490335750');
INSERT INTO `tc_goods_click` VALUES ('123', '12', '1490335758');
INSERT INTO `tc_goods_click` VALUES ('124', '14', '1490335762');
INSERT INTO `tc_goods_click` VALUES ('125', '14', '1490335775');
INSERT INTO `tc_goods_click` VALUES ('126', '14', '1490335795');
INSERT INTO `tc_goods_click` VALUES ('127', '14', '1490335807');
INSERT INTO `tc_goods_click` VALUES ('128', '12', '1490336122');
INSERT INTO `tc_goods_click` VALUES ('129', '12', '1490336124');
INSERT INTO `tc_goods_click` VALUES ('130', '12', '1490336127');
INSERT INTO `tc_goods_click` VALUES ('131', '12', '1490336149');
INSERT INTO `tc_goods_click` VALUES ('132', '12', '1490336157');
INSERT INTO `tc_goods_click` VALUES ('133', '12', '1490336173');
INSERT INTO `tc_goods_click` VALUES ('134', '12', '1490336244');
INSERT INTO `tc_goods_click` VALUES ('135', '12', '1490336405');
INSERT INTO `tc_goods_click` VALUES ('136', '17', '1490336864');
INSERT INTO `tc_goods_click` VALUES ('137', '17', '1490336877');
INSERT INTO `tc_goods_click` VALUES ('138', '6', '1490336881');
INSERT INTO `tc_goods_click` VALUES ('139', '17', '1490336883');
INSERT INTO `tc_goods_click` VALUES ('140', '12', '1490339223');
INSERT INTO `tc_goods_click` VALUES ('141', '19', '1490339227');
INSERT INTO `tc_goods_click` VALUES ('142', '15', '1490340784');
INSERT INTO `tc_goods_click` VALUES ('143', '1', '1490340803');
INSERT INTO `tc_goods_click` VALUES ('144', '1', '1490340826');
INSERT INTO `tc_goods_click` VALUES ('145', '11', '1490340973');
INSERT INTO `tc_goods_click` VALUES ('146', '12', '1490341496');
INSERT INTO `tc_goods_click` VALUES ('147', '18', '1490341638');
INSERT INTO `tc_goods_click` VALUES ('148', '14', '1490341642');
INSERT INTO `tc_goods_click` VALUES ('149', '1', '1490452311');
INSERT INTO `tc_goods_click` VALUES ('150', '19', '1490452342');
INSERT INTO `tc_goods_click` VALUES ('151', '11', '1490494398');
INSERT INTO `tc_goods_click` VALUES ('152', '17', '1490494409');
INSERT INTO `tc_goods_click` VALUES ('153', '18', '1490494414');
INSERT INTO `tc_goods_click` VALUES ('154', '14', '1490494416');
INSERT INTO `tc_goods_click` VALUES ('155', '18', '1490494434');
INSERT INTO `tc_goods_click` VALUES ('156', '14', '1490494438');
INSERT INTO `tc_goods_click` VALUES ('157', '17', '1490494439');
INSERT INTO `tc_goods_click` VALUES ('158', '16', '1490494451');
INSERT INTO `tc_goods_click` VALUES ('159', '16', '1490496027');
INSERT INTO `tc_goods_click` VALUES ('160', '11', '1490497417');
INSERT INTO `tc_goods_click` VALUES ('161', '11', '1490497606');
INSERT INTO `tc_goods_click` VALUES ('162', '11', '1490497759');
INSERT INTO `tc_goods_click` VALUES ('163', '11', '1490498056');
INSERT INTO `tc_goods_click` VALUES ('164', '11', '1490499245');
INSERT INTO `tc_goods_click` VALUES ('165', '11', '1490499267');
INSERT INTO `tc_goods_click` VALUES ('166', '16', '1490499892');
INSERT INTO `tc_goods_click` VALUES ('167', '14', '1490499904');
INSERT INTO `tc_goods_click` VALUES ('168', '16', '1490499911');
INSERT INTO `tc_goods_click` VALUES ('169', '20', '1490500072');
INSERT INTO `tc_goods_click` VALUES ('170', '20', '1490500100');
INSERT INTO `tc_goods_click` VALUES ('171', '12', '1490500112');
INSERT INTO `tc_goods_click` VALUES ('172', '17', '1490577036');
INSERT INTO `tc_goods_click` VALUES ('173', '18', '1490577039');
INSERT INTO `tc_goods_click` VALUES ('174', '14', '1490577041');
INSERT INTO `tc_goods_click` VALUES ('175', '19', '1490577042');
INSERT INTO `tc_goods_click` VALUES ('176', '8', '1490577059');
INSERT INTO `tc_goods_click` VALUES ('177', '22', '1490577207');
INSERT INTO `tc_goods_click` VALUES ('178', '21', '1490577209');
INSERT INTO `tc_goods_click` VALUES ('179', '21', '1490577269');
INSERT INTO `tc_goods_click` VALUES ('180', '6', '1490577296');
INSERT INTO `tc_goods_click` VALUES ('181', '21', '1490577320');
INSERT INTO `tc_goods_click` VALUES ('182', '21', '1490577322');
INSERT INTO `tc_goods_click` VALUES ('183', '8', '1490577361');
INSERT INTO `tc_goods_click` VALUES ('184', '21', '1490577368');
INSERT INTO `tc_goods_click` VALUES ('185', '21', '1490577888');
INSERT INTO `tc_goods_click` VALUES ('186', '14', '1490577904');
INSERT INTO `tc_goods_click` VALUES ('187', '21', '1490577918');
INSERT INTO `tc_goods_click` VALUES ('188', '24', '1490577938');
INSERT INTO `tc_goods_click` VALUES ('189', '25', '1490578028');
INSERT INTO `tc_goods_click` VALUES ('190', '26', '1490578031');
INSERT INTO `tc_goods_click` VALUES ('191', '24', '1490578034');
INSERT INTO `tc_goods_click` VALUES ('192', '20', '1490578041');
INSERT INTO `tc_goods_click` VALUES ('193', '25', '1490578074');
INSERT INTO `tc_goods_click` VALUES ('194', '26', '1490578100');
INSERT INTO `tc_goods_click` VALUES ('195', '25', '1490578105');
INSERT INTO `tc_goods_click` VALUES ('196', '26', '1490578309');
INSERT INTO `tc_goods_click` VALUES ('197', '17', '1490578315');
INSERT INTO `tc_goods_click` VALUES ('198', '27', '1490578321');
INSERT INTO `tc_goods_click` VALUES ('199', '27', '1490578347');
INSERT INTO `tc_goods_click` VALUES ('200', '26', '1490578352');
INSERT INTO `tc_goods_click` VALUES ('201', '23', '1490578513');
INSERT INTO `tc_goods_click` VALUES ('202', '25', '1490578534');
INSERT INTO `tc_goods_click` VALUES ('203', '26', '1490578536');
INSERT INTO `tc_goods_click` VALUES ('204', '27', '1490578538');
INSERT INTO `tc_goods_click` VALUES ('205', '25', '1490578584');
INSERT INTO `tc_goods_click` VALUES ('206', '26', '1490578586');
INSERT INTO `tc_goods_click` VALUES ('207', '27', '1490578588');
INSERT INTO `tc_goods_click` VALUES ('208', '6', '1490578804');
INSERT INTO `tc_goods_click` VALUES ('209', '12', '1490578850');
INSERT INTO `tc_goods_click` VALUES ('210', '19', '1490578858');
INSERT INTO `tc_goods_click` VALUES ('211', '19', '1490578866');
INSERT INTO `tc_goods_click` VALUES ('212', '5', '1490579170');
INSERT INTO `tc_goods_click` VALUES ('213', '21', '1490579623');
INSERT INTO `tc_goods_click` VALUES ('214', '12', '1490579640');
INSERT INTO `tc_goods_click` VALUES ('215', '12', '1490579649');
INSERT INTO `tc_goods_click` VALUES ('216', '19', '1490579651');
INSERT INTO `tc_goods_click` VALUES ('217', '19', '1490579662');
INSERT INTO `tc_goods_click` VALUES ('218', '19', '1490579684');
INSERT INTO `tc_goods_click` VALUES ('219', '12', '1490579711');
INSERT INTO `tc_goods_click` VALUES ('220', '11', '1490579720');
INSERT INTO `tc_goods_click` VALUES ('221', '3', '1490579905');
INSERT INTO `tc_goods_click` VALUES ('222', '3', '1490579917');
INSERT INTO `tc_goods_click` VALUES ('223', '5', '1490579926');
INSERT INTO `tc_goods_click` VALUES ('224', '3', '1490579928');
INSERT INTO `tc_goods_click` VALUES ('225', '6', '1490579938');
INSERT INTO `tc_goods_click` VALUES ('226', '1', '1490579946');
INSERT INTO `tc_goods_click` VALUES ('227', '12', '1490579983');
INSERT INTO `tc_goods_click` VALUES ('228', '26', '1490580011');
INSERT INTO `tc_goods_click` VALUES ('229', '28', '1490581142');
INSERT INTO `tc_goods_click` VALUES ('230', '29', '1490581242');
INSERT INTO `tc_goods_click` VALUES ('231', '28', '1490581425');
INSERT INTO `tc_goods_click` VALUES ('232', '27', '1490581526');
INSERT INTO `tc_goods_click` VALUES ('233', '24', '1490581544');
INSERT INTO `tc_goods_click` VALUES ('234', '25', '1490581548');
INSERT INTO `tc_goods_click` VALUES ('235', '26', '1490581550');
INSERT INTO `tc_goods_click` VALUES ('236', '26', '1490581556');
INSERT INTO `tc_goods_click` VALUES ('237', '26', '1490581585');
INSERT INTO `tc_goods_click` VALUES ('238', '26', '1490581608');
INSERT INTO `tc_goods_click` VALUES ('239', '12', '1490581610');
INSERT INTO `tc_goods_click` VALUES ('240', '25', '1490581612');
INSERT INTO `tc_goods_click` VALUES ('241', '20', '1490581628');
INSERT INTO `tc_goods_click` VALUES ('242', '30', '1490581893');
INSERT INTO `tc_goods_click` VALUES ('243', '29', '1490581895');
INSERT INTO `tc_goods_click` VALUES ('244', '23', '1490581898');
INSERT INTO `tc_goods_click` VALUES ('245', '22', '1490581901');
INSERT INTO `tc_goods_click` VALUES ('246', '21', '1490581903');
INSERT INTO `tc_goods_click` VALUES ('247', '29', '1490583016');
INSERT INTO `tc_goods_click` VALUES ('248', '11', '1490583038');
INSERT INTO `tc_goods_click` VALUES ('249', '11', '1490583083');
INSERT INTO `tc_goods_click` VALUES ('250', '11', '1490583088');
INSERT INTO `tc_goods_click` VALUES ('251', '11', '1490583091');
INSERT INTO `tc_goods_click` VALUES ('252', '22', '1490583094');
INSERT INTO `tc_goods_click` VALUES ('253', '5', '1490583096');
INSERT INTO `tc_goods_click` VALUES ('254', '5', '1490583183');
INSERT INTO `tc_goods_click` VALUES ('255', '1', '1490583186');
INSERT INTO `tc_goods_click` VALUES ('256', '6', '1490583188');
INSERT INTO `tc_goods_click` VALUES ('257', '6', '1490583218');
INSERT INTO `tc_goods_click` VALUES ('258', '8', '1490583220');
INSERT INTO `tc_goods_click` VALUES ('259', '8', '1490583224');
INSERT INTO `tc_goods_click` VALUES ('260', '1', '1490583348');
INSERT INTO `tc_goods_click` VALUES ('261', '31', '1490583370');
INSERT INTO `tc_goods_click` VALUES ('262', '31', '1490583401');
INSERT INTO `tc_goods_click` VALUES ('263', '1', '1490583404');
INSERT INTO `tc_goods_click` VALUES ('264', '30', '1490583448');
INSERT INTO `tc_goods_click` VALUES ('265', '32', '1490583636');
INSERT INTO `tc_goods_click` VALUES ('266', '31', '1490583640');
INSERT INTO `tc_goods_click` VALUES ('267', '31', '1490583649');
INSERT INTO `tc_goods_click` VALUES ('268', '32', '1490583652');
INSERT INTO `tc_goods_click` VALUES ('269', '32', '1490584092');
INSERT INTO `tc_goods_click` VALUES ('270', '31', '1490584096');
INSERT INTO `tc_goods_click` VALUES ('271', '22', '1490584300');
INSERT INTO `tc_goods_click` VALUES ('272', '32', '1490584427');
INSERT INTO `tc_goods_click` VALUES ('273', '31', '1490584429');
INSERT INTO `tc_goods_click` VALUES ('274', '31', '1490584644');
INSERT INTO `tc_goods_click` VALUES ('275', '32', '1490584647');
INSERT INTO `tc_goods_click` VALUES ('276', '32', '1490584940');
INSERT INTO `tc_goods_click` VALUES ('277', '31', '1490584943');
INSERT INTO `tc_goods_click` VALUES ('278', '32', '1490585049');
INSERT INTO `tc_goods_click` VALUES ('279', '31', '1490585055');
INSERT INTO `tc_goods_click` VALUES ('280', '25', '1490599688');
INSERT INTO `tc_goods_click` VALUES ('281', '26', '1490599691');
INSERT INTO `tc_goods_click` VALUES ('282', '27', '1490599715');
INSERT INTO `tc_goods_click` VALUES ('283', '28', '1490599718');
INSERT INTO `tc_goods_click` VALUES ('284', '24', '1490599721');
INSERT INTO `tc_goods_click` VALUES ('285', '30', '1490604446');
INSERT INTO `tc_goods_click` VALUES ('286', '32', '1490604552');
INSERT INTO `tc_goods_click` VALUES ('287', '29', '1490604560');
INSERT INTO `tc_goods_click` VALUES ('288', '23', '1490604562');
INSERT INTO `tc_goods_click` VALUES ('289', '29', '1490604573');
INSERT INTO `tc_goods_click` VALUES ('290', '23', '1490604579');
INSERT INTO `tc_goods_click` VALUES ('291', '23', '1490604581');
INSERT INTO `tc_goods_click` VALUES ('292', '23', '1490604583');
INSERT INTO `tc_goods_click` VALUES ('293', '23', '1490604585');
INSERT INTO `tc_goods_click` VALUES ('294', '23', '1490604588');
INSERT INTO `tc_goods_click` VALUES ('295', '23', '1490604591');
INSERT INTO `tc_goods_click` VALUES ('296', '8', '1490604609');
INSERT INTO `tc_goods_click` VALUES ('297', '25', '1490604626');
INSERT INTO `tc_goods_click` VALUES ('298', '19', '1490604635');
INSERT INTO `tc_goods_click` VALUES ('299', '11', '1490604645');
INSERT INTO `tc_goods_click` VALUES ('300', '11', '1490604653');
INSERT INTO `tc_goods_click` VALUES ('301', '11', '1490604658');
INSERT INTO `tc_goods_click` VALUES ('302', '11', '1490604662');
INSERT INTO `tc_goods_click` VALUES ('303', '11', '1490604667');
INSERT INTO `tc_goods_click` VALUES ('304', '27', '1490604678');
INSERT INTO `tc_goods_click` VALUES ('305', '19', '1490604683');
INSERT INTO `tc_goods_click` VALUES ('306', '19', '1490604689');
INSERT INTO `tc_goods_click` VALUES ('307', '11', '1490604693');
INSERT INTO `tc_goods_click` VALUES ('308', '27', '1490604707');
INSERT INTO `tc_goods_click` VALUES ('309', '20', '1490604717');
INSERT INTO `tc_goods_click` VALUES ('310', '24', '1490604723');
INSERT INTO `tc_goods_click` VALUES ('311', '24', '1490604735');
INSERT INTO `tc_goods_click` VALUES ('312', '20', '1490604737');
INSERT INTO `tc_goods_click` VALUES ('313', '25', '1490604741');
INSERT INTO `tc_goods_click` VALUES ('314', '20', '1490604763');
INSERT INTO `tc_goods_click` VALUES ('315', '21', '1490604791');
INSERT INTO `tc_goods_click` VALUES ('316', '22', '1490604796');
INSERT INTO `tc_goods_click` VALUES ('317', '21', '1490604815');
INSERT INTO `tc_goods_click` VALUES ('318', '22', '1490604817');
INSERT INTO `tc_goods_click` VALUES ('319', '8', '1490604866');
INSERT INTO `tc_goods_click` VALUES ('320', '33', '1490605392');
INSERT INTO `tc_goods_click` VALUES ('321', '34', '1490605394');
INSERT INTO `tc_goods_click` VALUES ('322', '33', '1490605447');
INSERT INTO `tc_goods_click` VALUES ('323', '35', '1490605561');
INSERT INTO `tc_goods_click` VALUES ('324', '35', '1490605568');
INSERT INTO `tc_goods_click` VALUES ('325', '34', '1490605665');
INSERT INTO `tc_goods_click` VALUES ('326', '33', '1490605667');
INSERT INTO `tc_goods_click` VALUES ('327', '34', '1490605686');
INSERT INTO `tc_goods_click` VALUES ('328', '33', '1490605689');
INSERT INTO `tc_goods_click` VALUES ('329', '35', '1490605692');
INSERT INTO `tc_goods_click` VALUES ('330', '35', '1490605707');
INSERT INTO `tc_goods_click` VALUES ('331', '24', '1490605929');
INSERT INTO `tc_goods_click` VALUES ('332', '24', '1490605936');
INSERT INTO `tc_goods_click` VALUES ('333', '24', '1490605987');
INSERT INTO `tc_goods_click` VALUES ('334', '33', '1490605987');
INSERT INTO `tc_goods_click` VALUES ('335', '24', '1490605990');
INSERT INTO `tc_goods_click` VALUES ('336', '34', '1490605992');
INSERT INTO `tc_goods_click` VALUES ('337', '34', '1490605998');
INSERT INTO `tc_goods_click` VALUES ('338', '33', '1490606030');
INSERT INTO `tc_goods_click` VALUES ('339', '20', '1490606100');
INSERT INTO `tc_goods_click` VALUES ('340', '24', '1490606115');
INSERT INTO `tc_goods_click` VALUES ('341', '20', '1490606592');
INSERT INTO `tc_goods_click` VALUES ('342', '24', '1490606595');
INSERT INTO `tc_goods_click` VALUES ('343', '35', '1490606749');
INSERT INTO `tc_goods_click` VALUES ('344', '33', '1490606789');
INSERT INTO `tc_goods_click` VALUES ('345', '34', '1490606791');
INSERT INTO `tc_goods_click` VALUES ('346', '33', '1490606830');
INSERT INTO `tc_goods_click` VALUES ('347', '35', '1490606832');
INSERT INTO `tc_goods_click` VALUES ('348', '35', '1490607038');
INSERT INTO `tc_goods_click` VALUES ('349', '35', '1490607058');
INSERT INTO `tc_goods_click` VALUES ('350', '35', '1490607280');
INSERT INTO `tc_goods_click` VALUES ('351', '35', '1490607887');
INSERT INTO `tc_goods_click` VALUES ('352', '35', '1490607894');
INSERT INTO `tc_goods_click` VALUES ('353', '31', '1490608364');
INSERT INTO `tc_goods_click` VALUES ('354', '35', '1490608429');
INSERT INTO `tc_goods_click` VALUES ('355', '11', '1490608465');
INSERT INTO `tc_goods_click` VALUES ('356', '24', '1490608508');

-- ----------------------------
-- Table structure for `tc_goods_comment`
-- ----------------------------
DROP TABLE IF EXISTS `tc_goods_comment`;
CREATE TABLE `tc_goods_comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `goods_id` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `score` int(11) DEFAULT '0',
  `content` text,
  `intro` text COMMENT '卖家评价',
  `create_time` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tc_goods_comment
-- ----------------------------
INSERT INTO `tc_goods_comment` VALUES ('1', '17', '12', '20000315', '5', null, '', '1490333668');
INSERT INTO `tc_goods_comment` VALUES ('2', '18', '12', '20000316', '5', null, null, '1490334449');
INSERT INTO `tc_goods_comment` VALUES ('3', '20', '3', '20000313', '5', '', '', '1490335021');
INSERT INTO `tc_goods_comment` VALUES ('4', '23', '19', '20000316', '5', null, null, '1490335578');
INSERT INTO `tc_goods_comment` VALUES ('5', '26', '12', '20000316', '5', null, '', '1490336534');
INSERT INTO `tc_goods_comment` VALUES ('6', '27', '19', '20000312', '5', null, null, '1490339357');
INSERT INTO `tc_goods_comment` VALUES ('7', '29', '12', '20000315', '5', '', null, '1490341552');
INSERT INTO `tc_goods_comment` VALUES ('8', '35', '11', '20000026', '5', '', '', '1490498221');
INSERT INTO `tc_goods_comment` VALUES ('9', '36', '11', '20000026', '5', '', '', '1490499421');
INSERT INTO `tc_goods_comment` VALUES ('10', '48', '11', '20000315', '4', '', null, '1490579783');
INSERT INTO `tc_goods_comment` VALUES ('11', '49', '3', '20000313', '5', '', '', '1490580121');
INSERT INTO `tc_goods_comment` VALUES ('12', '50', '3', '20000313', '5', '', '', '1490580121');
INSERT INTO `tc_goods_comment` VALUES ('13', '51', '3', '20000313', '5', '', '', '1490580121');
INSERT INTO `tc_goods_comment` VALUES ('14', '52', '1', '20000313', '5', '', '', '1490580121');
INSERT INTO `tc_goods_comment` VALUES ('15', '53', '12', '20000315', '5', '', '', '1490580121');
INSERT INTO `tc_goods_comment` VALUES ('16', '58', '31', '20000313', '5', '', null, '1490583707');
INSERT INTO `tc_goods_comment` VALUES ('17', '58', '32', '20000313', '5', '', null, '1490583707');
INSERT INTO `tc_goods_comment` VALUES ('18', '59', '32', '20000313', '5', '', null, '1490584168');
INSERT INTO `tc_goods_comment` VALUES ('19', '59', '31', '20000313', '5', '', null, '1490584168');
INSERT INTO `tc_goods_comment` VALUES ('20', '60', '32', '20000313', '5', '', null, '1490584479');
INSERT INTO `tc_goods_comment` VALUES ('21', '60', '31', '20000313', '5', '', null, '1490584479');
INSERT INTO `tc_goods_comment` VALUES ('22', '61', '31', '20000313', '5', '', null, '1490584686');
INSERT INTO `tc_goods_comment` VALUES ('23', '61', '32', '20000313', '5', '', null, '1490584686');
INSERT INTO `tc_goods_comment` VALUES ('24', '62', '32', '20000313', '5', null, null, '1490584973');
INSERT INTO `tc_goods_comment` VALUES ('25', '62', '31', '20000313', '5', null, null, '1490584973');
INSERT INTO `tc_goods_comment` VALUES ('26', '63', '32', '20000313', '5', null, null, '1490585092');
INSERT INTO `tc_goods_comment` VALUES ('27', '63', '31', '20000313', '4', null, null, '1490585092');
INSERT INTO `tc_goods_comment` VALUES ('28', '86', '35', '20000316', '5', null, null, '1490606869');
INSERT INTO `tc_goods_comment` VALUES ('29', '88', '35', '20000316', '5', '', '', '1490607181');
INSERT INTO `tc_goods_comment` VALUES ('30', '89', '35', '20000316', '5', null, '', '1490607337');
INSERT INTO `tc_goods_comment` VALUES ('31', '92', '11', '20000315', '5', null, '', '1490608600');

-- ----------------------------
-- Table structure for `tc_goods_gallery`
-- ----------------------------
DROP TABLE IF EXISTS `tc_goods_gallery`;
CREATE TABLE `tc_goods_gallery` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `goods_id` int(11) NOT NULL,
  `smallUrl` varchar(100) NOT NULL,
  `originUrl` varchar(100) NOT NULL,
  `create_time` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tc_goods_gallery
-- ----------------------------
INSERT INTO `tc_goods_gallery` VALUES ('13', '8', '/Uploads/Picture/20170324/s_4c9a53dfde53cce8.jpg', '/Uploads/Picture/20170324/4c9a53dfde53cce8.jpg', '1490322085');
INSERT INTO `tc_goods_gallery` VALUES ('26', '19', '/Uploads/Picture/20170324/s_a84823a6340182df.jpg', '/Uploads/Picture/20170324/a84823a6340182df.jpg', '1490335298');
INSERT INTO `tc_goods_gallery` VALUES ('29', '20', '/Uploads/Picture/20170326/s_e67ad0b257218a5d.jpg', '/Uploads/Picture/20170326/e67ad0b257218a5d.jpg', '1490500069');
INSERT INTO `tc_goods_gallery` VALUES ('30', '21', '/Uploads/Picture/20170327/s_aef911d9d6af1794.jpg', '/Uploads/Picture/20170327/aef911d9d6af1794.jpg', '1490577142');
INSERT INTO `tc_goods_gallery` VALUES ('31', '22', '/Uploads/Picture/20170327/s_b3705f2671783813.jpg', '/Uploads/Picture/20170327/b3705f2671783813.jpg', '1490577171');
INSERT INTO `tc_goods_gallery` VALUES ('33', '24', '/Uploads/Picture/20170327/s_bd7631c70b309929.jpg', '/Uploads/Picture/20170327/bd7631c70b309929.jpg', '1490577620');
INSERT INTO `tc_goods_gallery` VALUES ('34', '25', '/Uploads/Picture/20170327/s_8a2b4dfc8aa043e0.jpg', '/Uploads/Picture/20170327/8a2b4dfc8aa043e0.jpg', '1490577974');
INSERT INTO `tc_goods_gallery` VALUES ('35', '26', '/Uploads/Picture/20170327/s_ca0fdb6916d64466.jpg', '/Uploads/Picture/20170327/ca0fdb6916d64466.jpg', '1490578004');
INSERT INTO `tc_goods_gallery` VALUES ('36', '27', '/Uploads/Picture/20170327/s_8b9f3634fc4ba938.jpg', '/Uploads/Picture/20170327/8b9f3634fc4ba938.jpg', '1490578298');
INSERT INTO `tc_goods_gallery` VALUES ('39', '30', '/Uploads/Picture/20170327/s_2028a6223b268eb2.jpg', '/Uploads/Picture/20170327/2028a6223b268eb2.jpg', '1490581849');
INSERT INTO `tc_goods_gallery` VALUES ('41', '11', '/Uploads/Picture/20170324/s_17a6e99b046e4420.jpg', '/Uploads/Picture/20170324/17a6e99b046e4420.jpg', '1490583089');
INSERT INTO `tc_goods_gallery` VALUES ('42', '31', '/Uploads/Picture/20170327/s_c1d34211966313e7.jpg', '/Uploads/Picture/20170327/c1d34211966313e7.jpg', '1490583313');
INSERT INTO `tc_goods_gallery` VALUES ('43', '1', '/Uploads/Picture/20170323/s_e31059b697bbf19a.jpg', '/Uploads/Picture/20170323/e31059b697bbf19a.jpg', '1490583410');
INSERT INTO `tc_goods_gallery` VALUES ('44', '32', '/Uploads/Picture/20170327/s_88efd1edb8f92673.jpg', '/Uploads/Picture/20170327/88efd1edb8f92673.jpg', '1490583440');
INSERT INTO `tc_goods_gallery` VALUES ('45', '33', '/Uploads/Picture/20170327/s_c137a0a936374bf0.jpg', '/Uploads/Picture/20170327/c137a0a936374bf0.jpg', '1490605327');
INSERT INTO `tc_goods_gallery` VALUES ('46', '34', '/Uploads/Picture/20170327/s_c908f88afc39e973.jpg', '/Uploads/Picture/20170327/c908f88afc39e973.jpg', '1490605352');
INSERT INTO `tc_goods_gallery` VALUES ('47', '35', '/Uploads/Picture/20170327/s_f6be1a1d5cac7983.jpg', '/Uploads/Picture/20170327/f6be1a1d5cac7983.jpg', '1490605501');

-- ----------------------------
-- Table structure for `tc_group`
-- ----------------------------
DROP TABLE IF EXISTS `tc_group`;
CREATE TABLE `tc_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(50) NOT NULL DEFAULT '' COMMENT '创建者',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '群名称',
  `logosmall` varchar(128) NOT NULL DEFAULT '' COMMENT '群logo',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '群描述',
  `rule` varchar(500) DEFAULT '',
  `cat_id` int(11) NOT NULL DEFAULT '0',
  `address` varchar(50) DEFAULT '',
  `lat` decimal(10,6) DEFAULT '0.000000' COMMENT '纬度',
  `lng` decimal(10,6) DEFAULT '0.000000' COMMENT '经度',
  `extend` text NOT NULL COMMENT '扩展字段',
  `createtime` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='群表';

-- ----------------------------
-- Records of tc_group
-- ----------------------------
INSERT INTO `tc_group` VALUES ('1', '20000314', '天方夜谭', '', '介少', '我饿儿童体育局坎坎坷坷急急急好吧v擦擦嘻嘻嘻吃v', '2', '四川省成都市郫县天辰路','30.740621', '103.992223', '', '1490263550');
INSERT INTO `tc_group` VALUES ('2', '20000313', '经济界', '', '借钱给我看我小心翼翼小心翼翼与兔兔兔下雨天来了句QQ图图图图咯根据具体思路更可恶t咯微信我哦lo mo yjwwwwww', 'twww借钱给我看我小心翼翼小心翼翼与兔兔兔下雨天来了句QQ图图图图咯根据具体思路更借钱给我看我小心翼翼小心翼翼与兔兔兔', '2', '成都高新技术创新服务中心','32.740621', '153.992223', '', '1490263631');
INSERT INTO `tc_group` VALUES ('3', '20000315', '科技创新', 'f0cc6fe385285058fca5cc3243f1234a', '', '', '0', '成都高新技术创新服务中心','20.740621', '13.992223', '', '1490265960');
INSERT INTO `tc_group` VALUES ('4', '20000313', '乐视', '54934b011b2f450ff3f9598212417087', '', '', '0', '四川省成都市郫县天辰路','40.740621', '103.392223', '', '1490321530');
INSERT INTO `tc_group` VALUES ('5', '20000313', '聊一聊', '', '就看看', '无', '4', '四川省成都市郫县天辰路','30.740621', '103.992223', '', '1490342874');
INSERT INTO `tc_group` VALUES ('6', '20000316', '很健康', '', '估计', '把', '3', '四川省成都市郫县天辰路', '30.740621', '103.992223','', '1490342997');
INSERT INTO `tc_group` VALUES ('7', '20000316', '额', 'd5fed4bbff7b48be0f547a5d5a451506', '', '', '0', '四川省成都市郫县天辰路','30.740621', '103.992223', '', '1490343029');
INSERT INTO `tc_group` VALUES ('8', '20000316', '额', 'b9197ef3349802ce6358442cf9564c7d', '', '', '0', '四川省成都市郫县天辰路','30.740621', '103.992223', '', '1490343060');
INSERT INTO `tc_group` VALUES ('9', '20000316', '额', '902e7f8471969416ee4eb6b85f65ca9b', '', '', '0', '四川省成都市郫县天辰路','30.740621', '103.992223', '', '1490343082');
INSERT INTO `tc_group` VALUES ('10', '20000313', '帮你', 'f7d6bc20fb71149f3256ed5bc9684ba7', '', '', '0', '四川省成都市郫县天辰路','30.740621', '103.992223', '', '1490343679');
INSERT INTO `tc_group` VALUES ('11', '20000313', '刚刚呼呼', 'a2d0b11459930317fad605237de48a9d', '', '', '0', '中国大学生创业园西部园区孵化园','60.740621', '123.992223', '', '1490343825');
INSERT INTO `tc_group` VALUES ('12', '20000313', '吃就吃', '0bcceb23ea18b38006ab1af43de2aacd', '', '', '0', '四川省成都市郫县天辰路','30.740621', '103.992223', '', '1490344362');
INSERT INTO `tc_group` VALUES ('13', '20000315', '发个刚刚', 'ebec59a09e634d8f45cbcf56fa602516', '', '', '0', '成都高新技术创新服务中心', '35.740621', '106.992223','', '1490345377');
INSERT INTO `tc_group` VALUES ('14', '20000317', '小时代', 'e299d7120a9e2bd12397ca4f8873bbee', '', '', '0', '四川省成都市郫县西芯大道4号','33.740621', '123.992223', '', '1490605016');

-- ----------------------------
-- Table structure for `tc_groups`
-- ----------------------------
DROP TABLE IF EXISTS `tc_groups`;
CREATE TABLE `tc_groups` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) unsigned DEFAULT '0' COMMENT '用户',
  `sort` char(1) NOT NULL DEFAULT '',
  `background` varchar(256) DEFAULT '' COMMENT '主图',
  `logo` varchar(128) NOT NULL DEFAULT '' COMMENT '头像',
  `number` varchar(10) NOT NULL DEFAULT '0' COMMENT '群号',
  `group_id` int(11) DEFAULT '0' COMMENT '群组id',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '名称',
  `sign` varchar(256) NOT NULL DEFAULT '' COMMENT '签名',
  `remark` varchar(1024) NOT NULL DEFAULT '' COMMENT '群规',
  `address` varchar(128) NOT NULL DEFAULT '' COMMENT '地址',
  `lat` decimal(10,6) DEFAULT '0.000000' COMMENT '纬度',
  `lng` decimal(10,6) DEFAULT '0.000000' COMMENT '经度',
  `cateid` int(11) NOT NULL DEFAULT '0' COMMENT '类别id',
  `isdefault` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1-默认',
  `createtime` int(11) NOT NULL DEFAULT '0',
  `city` varchar(50) NOT NULL DEFAULT '' COMMENT '城市',
  `isshow` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0-不显示 1-显示',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tc_groups
-- ----------------------------
INSERT INTO `tc_groups` VALUES ('1', '20000002', 's', '/Uploads/Picture/20160510/s_682ea8f7739223a0.jpg', '74df05d80f5705cdb40f12c44b3483c5', '997972887', '0', '第三眼', 'abc', '', '云南省昆明市盘龙区G56(杭瑞高速公路)', '25.106831', '102.779654', '2', '1', '1458541345', '昆明市', '1');
INSERT INTO `tc_groups` VALUES ('2', '20000000', 'h', '/Uploads/Picture/20160426/s_c817dbf69205301b.png', '1d45bdfb4a7f4c210d250c51bbb046bd', '496291812', '0', '航模5', '好', '无', '四川省成都市郫县金粮路', '30.740621', '103.992223', '16', '1', '1459299533', '成都市', '1');
INSERT INTO `tc_groups` VALUES ('3', '20000017', 'x', '', 'f279b60a2b5a48c73866fafe8fa2f011', '512277817', '0', '熊猫工作2', '急急急1', '', '四川省成都市郫县金粮路', '30.740601', '103.992271', '18', '1', '1459347150', '成都市', '0');
INSERT INTO `tc_groups` VALUES ('4', '20000010', 'c', '', '73868fa94b783110d3e875dde21d53d4', '319188135', '0', '哈哈', '乐檬', '我弟弟你你OK', '东乡镇东南卫生院', '31.357673', '107.747003', '1', '1', '1460431160', '达州市', '0');
INSERT INTO `tc_groups` VALUES ('5', '20000000', 'o', '', '1ce2b28322396974b04d9e4222092bd2', '877388088', '0', '哦啦啦啦', '恶名您明明嗯', '拖个地哦', '东乡镇东南卫生院', '31.357673', '107.747003', '1', '0', '1460637200', '达州市', '1');
INSERT INTO `tc_groups` VALUES ('6', '20000000', 'h', '/Uploads/Picture/20160506/s_06a5b61879f55eae.jpg', '51b42e108dd3c65d866776bfe339b834', '620912306', '0', '123456', 'hi all', '', '成都市', '30.739078', '103.978732', '1', '0', '1461575165', '成都市', '1');
INSERT INTO `tc_groups` VALUES ('7', '20000000', 'y', '/Uploads/Picture/20160428/s_faf56d45e65d1d0c.png', 'adb3b947316173dd9e747fd4f5295fbb', '697407232', '0', '婴儿时代', '婴儿时代', '', '羊西北加油站', '30.739308', '103.977533', '1', '0', '1461753890', '成都市', '1');
INSERT INTO `tc_groups` VALUES ('8', '20000024', 'q', '', 'dc5d3e5a777d553525a31b6542d58176', '296161218', '0', '空', 'kneel', '', '东乡镇东南卫生院', '31.357673', '107.747003', '1', '0', '1461848570', '达州市', '0');
INSERT INTO `tc_groups` VALUES ('9', '20000002', 'd', '/Uploads/Picture/20160516/s_c6f955a19df3027a.jpg', '43c9dc4c0d1d4c4ce2b1730bf3607ed1', '874826551', '0', '低烧37.5\'', '', '', '时尚家园', '25.079802', '102.731736', '13', '0', '1463385094', '昆明市', '1');
INSERT INTO `tc_groups` VALUES ('10', '20000028', 'j', '', '37723d384cd55cacc2375dcd8ee3e116', '892356801', '0', '今天', 'hi,gril', '', '成都市', '30.739162', '103.978686', '1', '1', '1463623006', '成都市', '0');
INSERT INTO `tc_groups` VALUES ('11', '20000077', '0', '/Uploads/Picture/20160728/s_5813b4d3310d7f2b.jpeg', 'd9ba7ddcbdc5507d7434be282c873c4d', '584524434', '0', ',,,,,', '', '', '广东省汕头市龙湖区广寿街21-、22-、23号', '23.376976', '116.745898', '6', '0', '1469407522', '汕头市', '0');
INSERT INTO `tc_groups` VALUES ('12', '20000089', 'z', '', '1674a548026567fb98c44cbade48bc5e', '381758373', '0', '证件照', '哈哈哈', '', '成都市', '30.739537', '103.980308', '2', '0', '1470888314', '成都市', '0');
INSERT INTO `tc_groups` VALUES ('13', '20000092', 'n', '', '8cc69952e12d56438529d7b543ea9a31', '117929805', '0', '你好', '', '', '汉中市', '33.148490', '107.324756', '1', '0', '1471009589', '汉中市', '0');
INSERT INTO `tc_groups` VALUES ('14', '20000096', 't', '', '960cb6348699e0257b46b850c9f827bd', '744295823', '0', 'test', 'testContent', '', '学林雅苑', '30.741923', '103.987837', '1', '0', '1476094838', '成都市', '0');
INSERT INTO `tc_groups` VALUES ('15', '20000177', 'd', '', '9c56e5bb02cbddf9d785058355ccb653', '160640512', '0', '等待', '', '', '山东省枣庄市滕州市S345', '35.041243', '117.221093', '1', '0', '1476949076', '枣庄市', '0');
INSERT INTO `tc_groups` VALUES ('16', '20000209', 'm', '', '351b0e663a17b16693a23c2159065533', '415089337', '0', '迷恋你的温柔', '', '', '辽宁省锦州市凌海市锦凌路', '41.186607', '121.387246', '2', '0', '1479455784', '锦州市', '0');
INSERT INTO `tc_groups` VALUES ('17', '20000229', 'y', '', 'dbd1751adae46f9a43d2dc16f86cb56a', '605277351', '0', '颖子', '不忘初心，方得始终', '', '山东省烟台市芝罘区青华街98号附3号', '37.540831', '121.376989', '13', '0', '1481568980', '烟台市', '0');
INSERT INTO `tc_groups` VALUES ('18', '20000273', '0', '', '05cacccc89190247091dd9ef528a0536', '729273509', '0', '浅浅', '吹过清风喝过烈酒爱过你', '', '江苏省淮安市金湖县X103(利农南路)', '33.015881', '119.037593', '1', '0', '1487185589', '淮安市', '0');
INSERT INTO `tc_groups` VALUES ('19', '20000315', 'k', '/Uploads/Picture/20170327/s_9cd3671a511d1753.jpg', 'f0cc6fe385285058fca5cc3243f1234a', '414591733', '3', '科技创新', '', '', '成都高新技术创新服务中心', '30.738012', '103.978423', '15', '0', '1490265960', '成都市', '1');
INSERT INTO `tc_groups` VALUES ('20', '20000313', 'l', '', '54934b011b2f450ff3f9598212417087', '976617991', '4', '乐视', '', '', '四川省成都市郫县天辰路', '30.738772', '103.978710', '13', '0', '1490321530', '成都市', '0');
INSERT INTO `tc_groups` VALUES ('21', '20000316', 'e', '', 'd5fed4bbff7b48be0f547a5d5a451506', '777016480', '7', '额', '', '', '四川省成都市郫县天辰路', '30.738687', '103.978979', '17', '0', '1490343029', '成都市', '1');
INSERT INTO `tc_groups` VALUES ('22', '20000316', 'e', '', 'b9197ef3349802ce6358442cf9564c7d', '309505520', '8', '额', '', '', '四川省成都市郫县天辰路', '30.738687', '103.978979', '17', '0', '1490343060', '成都市', '1');
INSERT INTO `tc_groups` VALUES ('23', '20000316', 'e', '', '902e7f8471969416ee4eb6b85f65ca9b', '815758220', '9', '额', '', '', '四川省成都市郫县天辰路', '30.738687', '103.978979', '17', '0', '1490343082', '成都市', '1');
INSERT INTO `tc_groups` VALUES ('24', '20000313', 'b', '', 'f7d6bc20fb71149f3256ed5bc9684ba7', '234980570', '10', '帮你', '', '', '四川省成都市郫县天辰路', '30.738718', '103.978835', '3', '0', '1490343679', '成都市', '1');
INSERT INTO `tc_groups` VALUES ('25', '20000313', 'g', '', 'a2d0b11459930317fad605237de48a9d', '323349887', '11', '刚刚呼呼', '', '', '中国大学生创业园西部园区孵化园', '30.738051', '103.978296', '3', '0', '1490343825', '成都市', '1');
INSERT INTO `tc_groups` VALUES ('26', '20000313', 'c', '', '0bcceb23ea18b38006ab1af43de2aacd', '538075834', '12', '吃就吃', '', '', '四川省成都市郫县天辰路', '30.738780', '103.979069', '5', '0', '1490344362', '成都市', '1');
INSERT INTO `tc_groups` VALUES ('27', '20000315', 'f', '', 'ebec59a09e634d8f45cbcf56fa602516', '529042746', '13', '发个刚刚', '', '', '成都高新技术创新服务中心', '30.738012', '103.978422', '10', '0', '1490345377', '成都市', '1');
INSERT INTO `tc_groups` VALUES ('28', '20000317', 'x', '', 'e299d7120a9e2bd12397ca4f8873bbee', '806131017', '14', '小时代', '', '', '四川省成都市郫县西芯大道4号', '30.738571', '103.978674', '3', '0', '1490605016', '成都市', '0');

-- ----------------------------
-- Table structure for `tc_groups_black`
-- ----------------------------
DROP TABLE IF EXISTS `tc_groups_black`;
CREATE TABLE `tc_groups_black` (
  `uid` int(11) unsigned DEFAULT '0' COMMENT '用户',
  `groupsid` int(11) unsigned DEFAULT '0' COMMENT '用户',
  `addtime` int(11) NOT NULL DEFAULT '0',
  UNIQUE KEY `uid` (`uid`,`groupsid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tc_groups_black
-- ----------------------------
INSERT INTO `tc_groups_black` VALUES ('20000000', '2', '1460635905');
INSERT INTO `tc_groups_black` VALUES ('20000313', '19', '1490596549');

-- ----------------------------
-- Table structure for `tc_groups_follow`
-- ----------------------------
DROP TABLE IF EXISTS `tc_groups_follow`;
CREATE TABLE `tc_groups_follow` (
  `uid` int(11) unsigned DEFAULT '0' COMMENT '用户',
  `groupsid` int(11) unsigned DEFAULT '0' COMMENT '用户',
  `addtime` int(11) NOT NULL DEFAULT '0',
  UNIQUE KEY `uid` (`uid`,`groupsid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tc_groups_follow
-- ----------------------------
INSERT INTO `tc_groups_follow` VALUES ('20000002', '2', '1459501996');
INSERT INTO `tc_groups_follow` VALUES ('20000002', '5', '1460696132');
INSERT INTO `tc_groups_follow` VALUES ('20000017', '2', '1462774130');
INSERT INTO `tc_groups_follow` VALUES ('20000017', '5', '1462774918');
INSERT INTO `tc_groups_follow` VALUES ('20000025', '1', '1462955508');
INSERT INTO `tc_groups_follow` VALUES ('20000000', '1', '1463504083');
INSERT INTO `tc_groups_follow` VALUES ('20000000', '4', '1463504087');
INSERT INTO `tc_groups_follow` VALUES ('20000000', '9', '1463613788');
INSERT INTO `tc_groups_follow` VALUES ('20000017', '3', '1463614680');
INSERT INTO `tc_groups_follow` VALUES ('20000010', '4', '1463645811');
INSERT INTO `tc_groups_follow` VALUES ('20000000', '2', '1463727228');
INSERT INTO `tc_groups_follow` VALUES ('20000090', '12', '1470888358');
INSERT INTO `tc_groups_follow` VALUES ('20000017', '12', '1471513711');
INSERT INTO `tc_groups_follow` VALUES ('20000096', '7', '1476237501');
INSERT INTO `tc_groups_follow` VALUES ('20000096', '14', '1476237672');
INSERT INTO `tc_groups_follow` VALUES ('20000316', '20', '1490328023');
INSERT INTO `tc_groups_follow` VALUES ('20000315', '20', '1490337847');
INSERT INTO `tc_groups_follow` VALUES ('20000312', '20', '1490337864');
INSERT INTO `tc_groups_follow` VALUES ('20000315', '26', '1490593112');
INSERT INTO `tc_groups_follow` VALUES ('20000316', '19', '1490594476');
INSERT INTO `tc_groups_follow` VALUES ('20000313', '19', '1490595225');

-- ----------------------------
-- Table structure for `tc_groups_head`
-- ----------------------------
DROP TABLE IF EXISTS `tc_groups_head`;
CREATE TABLE `tc_groups_head` (
  `id` varchar(50) NOT NULL,
  `gid` int(11) NOT NULL DEFAULT '0' COMMENT '用户',
  `originUrl` varchar(128) NOT NULL DEFAULT '' COMMENT '大图',
  `smallUrl` varchar(128) NOT NULL DEFAULT '' COMMENT '小图',
  `key` varchar(100) NOT NULL DEFAULT '' COMMENT 'key',
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='群头像表';

-- ----------------------------
-- Records of tc_groups_head
-- ----------------------------
INSERT INTO `tc_groups_head` VALUES ('096608f17af4193cb2715343a17a8844', '6', '/Uploads/Picture/20160426/3e063b769c907168.png', '/Uploads/Picture/20160426/s_3e063b769c907168.png', 'image1');
INSERT INTO `tc_groups_head` VALUES ('0bcceb23ea18b38006ab1af43de2aacd', '26', '/Uploads/Picture/20170324/3ee6fb61522add83.jpg', '/Uploads/Picture/20170324/s_3ee6fb61522add83.jpg', 'logo1');
INSERT INTO `tc_groups_head` VALUES ('0f74c6aa407c619f49149adaed18921b', '27', '/Uploads/Picture/20170327/a89d9bc73cc45ac7.png', '/Uploads/Picture/20170327/s_a89d9bc73cc45ac7.png', 'image');
INSERT INTO `tc_groups_head` VALUES ('1436a9054aef0d8a8240fc2e8c64007d', '5', '/Uploads/Picture/20160414/0bae6d49a6a10807.png', '/Uploads/Picture/20160414/s_0bae6d49a6a10807.png', 'logo3');
INSERT INTO `tc_groups_head` VALUES ('1674a548026567fb98c44cbade48bc5e', '12', '/Uploads/Picture/20160811/893d15f1c9bdbc5f.jpeg', '/Uploads/Picture/20160811/s_893d15f1c9bdbc5f.jpeg', 'logo1');
INSERT INTO `tc_groups_head` VALUES ('1910a5a3dd5daf8e36462d1981134f56', '19', '/Uploads/Picture/20170327/a0aaf78c57828bbc.png', '/Uploads/Picture/20170327/s_a0aaf78c57828bbc.png', 'image2');
INSERT INTO `tc_groups_head` VALUES ('1ce2b28322396974b04d9e4222092bd2', '5', '/Uploads/Picture/20160414/ccbccedfb349c36d.png', '/Uploads/Picture/20160414/s_ccbccedfb349c36d.png', 'logo1');
INSERT INTO `tc_groups_head` VALUES ('1d45bdfb4a7f4c210d250c51bbb046bd', '2', '/Uploads/Picture/20160428/cbea9654462f734b.png', '/Uploads/Picture/20160428/s_cbea9654462f734b.png', 'image');
INSERT INTO `tc_groups_head` VALUES ('1fb1f11f8b9fad8de29a4b6ece009f9a', '2', '/Uploads/Picture/20160428/bb0e5f85aa7e0552.png', '/Uploads/Picture/20160428/s_bb0e5f85aa7e0552.png', 'image2');
INSERT INTO `tc_groups_head` VALUES ('2033cfaff1e9d2ac573faecbfdfeeb31', '19', '/Uploads/Picture/20170327/a7463c76d49ecdc6.png', '/Uploads/Picture/20170327/s_a7463c76d49ecdc6.png', 'image');
INSERT INTO `tc_groups_head` VALUES ('2a2dae6e0544b0badba5f253774dcbfb', '2', '/Uploads/Picture/20160428/9502284dbaa06006.png', '/Uploads/Picture/20160428/s_9502284dbaa06006.png', 'image2');
INSERT INTO `tc_groups_head` VALUES ('351b0e663a17b16693a23c2159065533', '16', '/Uploads/Picture/20161118/cfc1aeb23b3896ef.jpg', '/Uploads/Picture/20161118/s_cfc1aeb23b3896ef.jpg', 'logo1');
INSERT INTO `tc_groups_head` VALUES ('36243d029787e393b7c774fe44cb38e0', '1', '/Uploads/Picture/20160519/dab87679998ef713.jpg', '/Uploads/Picture/20160519/s_dab87679998ef713.jpg', 'image1');
INSERT INTO `tc_groups_head` VALUES ('37723d384cd55cacc2375dcd8ee3e116', '10', '/Uploads/Picture/20160519/325283d6837d6f73.jpg', '/Uploads/Picture/20160519/s_325283d6837d6f73.jpg', 'logo1');
INSERT INTO `tc_groups_head` VALUES ('43c9dc4c0d1d4c4ce2b1730bf3607ed1', '9', '/Uploads/Picture/20160516/003797420a5c77b0.jpg', '/Uploads/Picture/20160516/s_003797420a5c77b0.jpg', 'logo1');
INSERT INTO `tc_groups_head` VALUES ('462b65be6c6122b62d3b74b9ac424f80', '7', '/Uploads/Picture/20160506/6761ea51a1375bc7.png', '/Uploads/Picture/20160506/s_6761ea51a1375bc7.png', 'image2');
INSERT INTO `tc_groups_head` VALUES ('54934b011b2f450ff3f9598212417087', '20', '/Uploads/Picture/20170324/4761ffbc2549cbb5.jpg', '/Uploads/Picture/20170324/s_4761ffbc2549cbb5.jpg', 'logo1');
INSERT INTO `tc_groups_head` VALUES ('6af855aae03c2dee8de0de553d8ee7b8', '21', '/Uploads/Picture/20170324/a707bf1b265067e3.jpg', '/Uploads/Picture/20170324/s_a707bf1b265067e3.jpg', 'logo2');
INSERT INTO `tc_groups_head` VALUES ('6d8387c9dfd3d779d49d4414fdd88e20', '5', '/Uploads/Picture/20160414/3014a49dbb743df5.png', '/Uploads/Picture/20160414/s_3014a49dbb743df5.png', 'logo2');
INSERT INTO `tc_groups_head` VALUES ('722101ebf7ad3c3465da35b9e9741406', '6', '/Uploads/Picture/20160426/3507fac4822c23ec.png', '/Uploads/Picture/20160426/s_3507fac4822c23ec.png', 'image3');
INSERT INTO `tc_groups_head` VALUES ('73868fa94b783110d3e875dde21d53d4', '4', '/Uploads/Picture/20160507/640372ffbc296072.png', '/Uploads/Picture/20160507/s_640372ffbc296072.png', 'image');
INSERT INTO `tc_groups_head` VALUES ('74df05d80f5705cdb40f12c44b3483c5', '1', '/Uploads/Picture/20160520/3e010b097cf206e8.jpg', '/Uploads/Picture/20160520/s_3e010b097cf206e8.jpg', 'image1');
INSERT INTO `tc_groups_head` VALUES ('8604b3be4a2f9bab95310e76ac359f54', '23', '/Uploads/Picture/20170324/2c450f9adc89b6f2.jpg', '/Uploads/Picture/20170324/s_2c450f9adc89b6f2.jpg', 'logo1');
INSERT INTO `tc_groups_head` VALUES ('8cc69952e12d56438529d7b543ea9a31', '13', '/Uploads/Picture/20160812/187042cf7d504a3c.jpg', '/Uploads/Picture/20160812/s_187042cf7d504a3c.jpg', 'logo1');
INSERT INTO `tc_groups_head` VALUES ('902e7f8471969416ee4eb6b85f65ca9b', '23', '/Uploads/Picture/20170324/93fc03877f084f6f.jpg', '/Uploads/Picture/20170324/s_93fc03877f084f6f.jpg', 'logo3');
INSERT INTO `tc_groups_head` VALUES ('95fe2a18204db0f44f4969b52409fd23', '1', '/Uploads/Picture/20160521/183ecaec28b9186a.png', '/Uploads/Picture/20160521/s_183ecaec28b9186a.png', 'image');
INSERT INTO `tc_groups_head` VALUES ('960cb6348699e0257b46b850c9f827bd', '14', '/Uploads/Picture/20161010/7fb0b1e903fa4b3b.png', '/Uploads/Picture/20161010/s_7fb0b1e903fa4b3b.png', 'logo');
INSERT INTO `tc_groups_head` VALUES ('9c56e5bb02cbddf9d785058355ccb653', '15', '/Uploads/Picture/20161020/7eb5e7522724eb85.jpg', '/Uploads/Picture/20161020/s_7eb5e7522724eb85.jpg', 'logo1');
INSERT INTO `tc_groups_head` VALUES ('a0f56aaaac267280c3fd53191ed9fb8b', '7', '/Uploads/Picture/20160506/9a26537562dc3e76.png', '/Uploads/Picture/20160506/s_9a26537562dc3e76.png', 'image2');
INSERT INTO `tc_groups_head` VALUES ('a2d0b11459930317fad605237de48a9d', '25', '/Uploads/Picture/20170324/eaeb31cad38c821e.png', '/Uploads/Picture/20170324/s_eaeb31cad38c821e.png', 'logo1');
INSERT INTO `tc_groups_head` VALUES ('b3a5394bb3b1fdffe9f344a509393201', '23', '/Uploads/Picture/20170324/5509a289231d578b.jpg', '/Uploads/Picture/20170324/s_5509a289231d578b.jpg', 'logo2');
INSERT INTO `tc_groups_head` VALUES ('b9197ef3349802ce6358442cf9564c7d', '22', '/Uploads/Picture/20170324/055f60710e63380e.jpg', '/Uploads/Picture/20170324/s_055f60710e63380e.jpg', 'logo3');
INSERT INTO `tc_groups_head` VALUES ('ba72106a19b492db7a678287ef3f3601', '3', '/Uploads/Picture/20160518/bc41ca63fb90c139.jpg', '/Uploads/Picture/20160518/s_bc41ca63fb90c139.jpg', 'image1');
INSERT INTO `tc_groups_head` VALUES ('bbff67dac79ade87caecfbe53b7569bc', '7', '/Uploads/Picture/20160506/c3688044cd3b7597.jpg', '/Uploads/Picture/20160506/s_c3688044cd3b7597.jpg', 'image1');
INSERT INTO `tc_groups_head` VALUES ('c4850f3a114d1ffaffc107683db00e4a', '22', '/Uploads/Picture/20170324/82f2fd4042b4539f.jpg', '/Uploads/Picture/20170324/s_82f2fd4042b4539f.jpg', 'logo1');
INSERT INTO `tc_groups_head` VALUES ('d5fed4bbff7b48be0f547a5d5a451506', '21', '/Uploads/Picture/20170324/c405e07dd5480d48.jpg', '/Uploads/Picture/20170324/s_c405e07dd5480d48.jpg', 'logo3');
INSERT INTO `tc_groups_head` VALUES ('d7f5f784567f6178ff8469ca958483d2', '22', '/Uploads/Picture/20170324/f1d7044bf7481798.jpg', '/Uploads/Picture/20170324/s_f1d7044bf7481798.jpg', 'logo2');
INSERT INTO `tc_groups_head` VALUES ('d9ba7ddcbdc5507d7434be282c873c4d', '11', '/Uploads/Picture/20160725/dc2b5a6f5441265d.png', '/Uploads/Picture/20160725/s_dc2b5a6f5441265d.png', 'logo1');
INSERT INTO `tc_groups_head` VALUES ('dbd1751adae46f9a43d2dc16f86cb56a', '17', '/Uploads/Picture/20161213/1d7bbf244e9ad987.jpg', '/Uploads/Picture/20161213/s_1d7bbf244e9ad987.jpg', 'logo1');
INSERT INTO `tc_groups_head` VALUES ('dc5d3e5a777d553525a31b6542d58176', '8', '/Uploads/Picture/20160428/665a168a6fb39aaf.png', '/Uploads/Picture/20160428/s_665a168a6fb39aaf.png', 'image');
INSERT INTO `tc_groups_head` VALUES ('e299d7120a9e2bd12397ca4f8873bbee', '28', '/Uploads/Picture/20170327/fca39d7319d87cd3.jpg', '/Uploads/Picture/20170327/s_fca39d7319d87cd3.jpg', 'logo1');
INSERT INTO `tc_groups_head` VALUES ('ebec59a09e634d8f45cbcf56fa602516', '27', '/Uploads/Picture/20170324/f63242c40b29e92b.jpg', '/Uploads/Picture/20170324/s_f63242c40b29e92b.jpg', 'logo1');
INSERT INTO `tc_groups_head` VALUES ('f279b60a2b5a48c73866fafe8fa2f011', '3', '/Uploads/Picture/20160509/69a92a24aeb2daa3.jpg', '/Uploads/Picture/20160509/s_69a92a24aeb2daa3.jpg', 'image1');
INSERT INTO `tc_groups_head` VALUES ('f3fc1a052c5274681df46069f2cef00c', '21', '/Uploads/Picture/20170324/6404fd5cef7d40ff.jpg', '/Uploads/Picture/20170324/s_6404fd5cef7d40ff.jpg', 'logo1');
INSERT INTO `tc_groups_head` VALUES ('f536318bff574554b9ddfcf6276a7342', '6', '/Uploads/Picture/20160426/dbaa0046853237de.png', '/Uploads/Picture/20160426/s_dbaa0046853237de.png', 'image2');
INSERT INTO `tc_groups_head` VALUES ('f7d6bc20fb71149f3256ed5bc9684ba7', '24', '/Uploads/Picture/20170324/08e60c549ca1280d.jpg', '/Uploads/Picture/20170324/s_08e60c549ca1280d.jpg', 'logo1');
INSERT INTO `tc_groups_head` VALUES ('fb0014c0e391fa5665c86be36d699564', '1', '/Uploads/Picture/20160520/3a768c8c1b4538c2.jpg', '/Uploads/Picture/20160520/s_3a768c8c1b4538c2.jpg', 'image1');
INSERT INTO `tc_groups_head` VALUES ('ff04d906f27ba5ed0ab75dab52c19473', '18', '/Uploads/Picture/20170216/88edf368cdca0dee.jpg', '/Uploads/Picture/20170216/s_88edf368cdca0dee.jpg', 'image1');

-- ----------------------------
-- Table structure for `tc_group_category`
-- ----------------------------
DROP TABLE IF EXISTS `tc_group_category`;
CREATE TABLE `tc_group_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `create_time` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tc_group_category
-- ----------------------------
INSERT INTO `tc_group_category` VALUES ('1', '美食会', '');
INSERT INTO `tc_group_category` VALUES ('2', '时尚•美妆', '');
INSERT INTO `tc_group_category` VALUES ('3', '房屋', '');
INSERT INTO `tc_group_category` VALUES ('4', '装修•家居', '');
INSERT INTO `tc_group_category` VALUES ('5', '车世界', '');
INSERT INTO `tc_group_category` VALUES ('6', '科技', '');
INSERT INTO `tc_group_category` VALUES ('7', '数码•家电', '');
INSERT INTO `tc_group_category` VALUES ('8', '财经•理财', '');
INSERT INTO `tc_group_category` VALUES ('9', '职场圈', '');
INSERT INTO `tc_group_category` VALUES ('10', '创业季', '');
INSERT INTO `tc_group_category` VALUES ('11', '旅游', '');
INSERT INTO `tc_group_category` VALUES ('12', '家乡美', '');
INSERT INTO `tc_group_category` VALUES ('13', '运动•户外', '');
INSERT INTO `tc_group_category` VALUES ('14', '球迷•控友', '');
INSERT INTO `tc_group_category` VALUES ('15', '游戏玩家', '');
INSERT INTO `tc_group_category` VALUES ('16', '健康•养生', '');
INSERT INTO `tc_group_category` VALUES ('17', '电影•音乐', '');
INSERT INTO `tc_group_category` VALUES ('18', '拍客•图片', '');
INSERT INTO `tc_group_category` VALUES ('19', '娱乐•文艺', '');
INSERT INTO `tc_group_category` VALUES ('20', '吐槽•爆料', '');
INSERT INTO `tc_group_category` VALUES ('21', '星座•风水', '');
INSERT INTO `tc_group_category` VALUES ('22', '军迷天地', '');
INSERT INTO `tc_group_category` VALUES ('23', '文史杂谈', '');
INSERT INTO `tc_group_category` VALUES ('24', '校友会', '');
INSERT INTO `tc_group_category` VALUES ('25', '老友记', '');
INSERT INTO `tc_group_category` VALUES ('26', '地方•社区', '');
INSERT INTO `tc_group_category` VALUES ('27', '情感夜话', '');
INSERT INTO `tc_group_category` VALUES ('28', '婚嫁育儿', '');
INSERT INTO `tc_group_category` VALUES ('29', '教育园', '');
INSERT INTO `tc_group_category` VALUES ('30', '百科问答', '');
INSERT INTO `tc_group_category` VALUES ('31', '宠物•园艺', '');

-- ----------------------------
-- Table structure for `tc_group_follw`
-- ----------------------------
DROP TABLE IF EXISTS `tc_group_follw`;
CREATE TABLE `tc_group_follw` (
  `uid` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `create_time` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tc_group_follw
-- ----------------------------
INSERT INTO `tc_group_follw` VALUES ('20000313', '1', '1490263649');
INSERT INTO `tc_group_follw` VALUES ('20000314', '2', '1490263900');
INSERT INTO `tc_group_follw` VALUES ('20000312', '2', '1490264186');
INSERT INTO `tc_group_follw` VALUES ('20000312', '1', '1490264194');
INSERT INTO `tc_group_follw` VALUES ('20000316', '4', '1490328023');
INSERT INTO `tc_group_follw` VALUES ('20000316', '1', '1490335023');
INSERT INTO `tc_group_follw` VALUES ('20000315', '4', '1490337847');
INSERT INTO `tc_group_follw` VALUES ('20000312', '4', '1490337864');
INSERT INTO `tc_group_follw` VALUES ('20000315', '12', '1490593112');
INSERT INTO `tc_group_follw` VALUES ('20000316', '3', '1490594476');
INSERT INTO `tc_group_follw` VALUES ('20000313', '3', '1490595225');
INSERT INTO `tc_group_follw` VALUES ('20000315', '6', '1490606876');

-- ----------------------------
-- Table structure for `tc_group_user`
-- ----------------------------
DROP TABLE IF EXISTS `tc_group_user`;
CREATE TABLE `tc_group_user` (
  `groupid` int(11) unsigned NOT NULL DEFAULT '0',
  `uid` varchar(50) NOT NULL DEFAULT '' COMMENT '用户id',
  `role` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0-成员 1-创建者',
  `getmsg` tinyint(1) DEFAULT '1' COMMENT '0-不接收 1-接收',
  `addtime` int(11) NOT NULL DEFAULT '0',
  KEY `groupid` (`groupid`,`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='群组用户表';

-- ----------------------------
-- Records of tc_group_user
-- ----------------------------
INSERT INTO `tc_group_user` VALUES ('1', '20000314', '1', '1', '1490263550');
INSERT INTO `tc_group_user` VALUES ('2', '20000313', '1', '1', '1490263631');
INSERT INTO `tc_group_user` VALUES ('1', '20000313', '0', '1', '1490263649');
INSERT INTO `tc_group_user` VALUES ('2', '20000314', '0', '1', '1490263900');
INSERT INTO `tc_group_user` VALUES ('2', '20000312', '0', '1', '1490264186');
INSERT INTO `tc_group_user` VALUES ('1', '20000312', '0', '1', '1490264194');
INSERT INTO `tc_group_user` VALUES ('3', '20000315', '1', '1', '1490265960');
INSERT INTO `tc_group_user` VALUES ('4', '20000313', '1', '1', '1490321530');
INSERT INTO `tc_group_user` VALUES ('4', '20000316', '0', '1', '1490328023');
INSERT INTO `tc_group_user` VALUES ('1', '20000316', '0', '1', '1490335023');
INSERT INTO `tc_group_user` VALUES ('4', '20000315', '0', '1', '1490337847');
INSERT INTO `tc_group_user` VALUES ('4', '20000312', '0', '1', '1490337864');
INSERT INTO `tc_group_user` VALUES ('5', '20000313', '1', '1', '1490342874');
INSERT INTO `tc_group_user` VALUES ('6', '20000316', '1', '1', '1490342997');
INSERT INTO `tc_group_user` VALUES ('7', '20000316', '1', '1', '1490343029');
INSERT INTO `tc_group_user` VALUES ('8', '20000316', '1', '1', '1490343060');
INSERT INTO `tc_group_user` VALUES ('9', '20000316', '1', '1', '1490343082');
INSERT INTO `tc_group_user` VALUES ('10', '20000313', '1', '1', '1490343679');
INSERT INTO `tc_group_user` VALUES ('11', '20000313', '1', '1', '1490343825');
INSERT INTO `tc_group_user` VALUES ('12', '20000313', '1', '1', '1490344362');
INSERT INTO `tc_group_user` VALUES ('13', '20000315', '1', '1', '1490345377');
INSERT INTO `tc_group_user` VALUES ('12', '20000315', '0', '1', '1490593112');
INSERT INTO `tc_group_user` VALUES ('3', '20000316', '0', '1', '1490594476');
INSERT INTO `tc_group_user` VALUES ('3', '20000313', '0', '1', '1490595225');
INSERT INTO `tc_group_user` VALUES ('14', '20000317', '1', '1', '1490605016');
INSERT INTO `tc_group_user` VALUES ('6', '20000315', '0', '1', '1490606876');

-- ----------------------------
-- Table structure for `tc_jubao`
-- ----------------------------
DROP TABLE IF EXISTS `tc_jubao`;
CREATE TABLE `tc_jubao` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT '举报人',
  `otherid` int(11) unsigned DEFAULT '0' COMMENT '用户id或群id',
  `content` varchar(128) NOT NULL DEFAULT '' COMMENT '内容',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0-用户 1-群号',
  `createtime` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tc_jubao
-- ----------------------------
INSERT INTO `tc_jubao` VALUES ('1', '20000000', '3', '虚假信息', '1', '1459347796');
INSERT INTO `tc_jubao` VALUES ('2', '20000002', '20000070', '广告推销', '0', '1468592397');

-- ----------------------------
-- Table structure for `tc_jubao_list`
-- ----------------------------
DROP TABLE IF EXISTS `tc_jubao_list`;
CREATE TABLE `tc_jubao_list` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `content` varchar(128) NOT NULL DEFAULT '' COMMENT '内容',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tc_jubao_list
-- ----------------------------
INSERT INTO `tc_jubao_list` VALUES ('2', '色情•暴力');
INSERT INTO `tc_jubao_list` VALUES ('3', '广告•推销');
INSERT INTO `tc_jubao_list` VALUES ('4', '攻击•骚扰');
INSERT INTO `tc_jubao_list` VALUES ('5', '虚假•诱导');
INSERT INTO `tc_jubao_list` VALUES ('6', '迷信•邪教');
INSERT INTO `tc_jubao_list` VALUES ('7', '侵权•安全');

-- ----------------------------
-- Table structure for `tc_lincense`
-- ----------------------------
DROP TABLE IF EXISTS `tc_lincense`;
CREATE TABLE `tc_lincense` (
  `id` int(11) NOT NULL,
  `default` varchar(2000) NOT NULL,
  `lincense` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='授权表';

-- ----------------------------
-- Records of tc_lincense
-- ----------------------------
INSERT INTO `tc_lincense` VALUES ('1', 'azJoeWpldTIqazJ5fnZ/MiprMn9idHVieXQyKjIhICAyPDJxc39lfmQyKjIhICAyPDJ5YDIqMj0hMjwydH99cXl+MioyPSEyPDJ/YnR1YmR5fXUyKiEkISAiIyYkIiA8MnVoYHlidWR5fXUyKiEnIiUoJSUmIiA8MmBxaX11ZHh/dDIqMiEybTwydHVmeXN1MiprMnF+dGJ/eXQyKjIhMjwyeWB4f351MioyITI8MnF+dGJ/eXRPYHF0MioyIDI8MnlgcXQyKjIgMjwyZ3VyMioyIDI8Mmd5fnR/Z2NPYHMyKjIgMm08MnZ1cWRlYnUyKmsyc3hxZDIqazJ9cWhlY3VifmV9MioyISAgMjwyfXFof358eX51ZWN1Yn5lfTIqMiEgIDJtPDJ3Yn9lYDIqazJ9cWh3Yn9lYH5lfTIqMiIgMjwyfXFod2J/ZWBgdWJjf35+ZX0yKjIhICAybTwyZWN1YjIqazJ8f3d5fn1lfGR5YHx1dHVmeXN1MioyIDI8Mn1lfGR5YHx1ZWN1YjIqMiAybW08MmBxaTIqMnhkZGAqTD9MP2dnZz5oeWpldT5zf31MP2BxaTI8MnVoYHlidX9idHVieXQyKjIyPDJmdWJjeX9+MioyIT4gPiAybW0=', null);

-- ----------------------------
-- Table structure for `tc_look_record`
-- ----------------------------
DROP TABLE IF EXISTS `tc_look_record`;
CREATE TABLE `tc_look_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(20) NOT NULL,
  `look_id` int(11) NOT NULL COMMENT '查看的信息id',
  `type` tinyint(4) NOT NULL COMMENT '1、我关注的空间号，2、群组我关注的，3、用户我关注的',
  `create` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=386 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tc_look_record
-- ----------------------------
INSERT INTO `tc_look_record` VALUES ('1', '20000314', '1', '2', '1490263556');
INSERT INTO `tc_look_record` VALUES ('2', '20000313', '1', '2', '1490263649');
INSERT INTO `tc_look_record` VALUES ('3', '20000313', '1', '2', '1490263656');
INSERT INTO `tc_look_record` VALUES ('4', '20000313', '1', '2', '1490263662');
INSERT INTO `tc_look_record` VALUES ('5', '20000313', '1', '2', '1490263673');
INSERT INTO `tc_look_record` VALUES ('6', '20000313', '1', '2', '1490263694');
INSERT INTO `tc_look_record` VALUES ('7', '20000313', '1', '2', '1490263740');
INSERT INTO `tc_look_record` VALUES ('8', '20000313', '1', '2', '1490263782');
INSERT INTO `tc_look_record` VALUES ('9', '20000313', '1', '2', '1490263788');
INSERT INTO `tc_look_record` VALUES ('10', '20000314', '1', '2', '1490263796');
INSERT INTO `tc_look_record` VALUES ('11', '20000313', '1', '2', '1490263808');
INSERT INTO `tc_look_record` VALUES ('12', '20000313', '1', '2', '1490263814');
INSERT INTO `tc_look_record` VALUES ('13', '20000313', '1', '2', '1490263834');
INSERT INTO `tc_look_record` VALUES ('14', '20000314', '1', '2', '1490263847');
INSERT INTO `tc_look_record` VALUES ('15', '20000313', '1', '2', '1490263876');
INSERT INTO `tc_look_record` VALUES ('16', '20000314', '2', '2', '1490263907');
INSERT INTO `tc_look_record` VALUES ('17', '20000314', '2', '2', '1490263913');
INSERT INTO `tc_look_record` VALUES ('18', '20000313', '2', '2', '1490263922');
INSERT INTO `tc_look_record` VALUES ('19', '20000313', '2', '2', '1490263925');
INSERT INTO `tc_look_record` VALUES ('20', '20000313', '2', '2', '1490263928');
INSERT INTO `tc_look_record` VALUES ('21', '20000313', '2', '2', '1490263935');
INSERT INTO `tc_look_record` VALUES ('22', '20000313', '2', '2', '1490263946');
INSERT INTO `tc_look_record` VALUES ('23', '20000313', '2', '2', '1490263967');
INSERT INTO `tc_look_record` VALUES ('24', '20000313', '2', '2', '1490263972');
INSERT INTO `tc_look_record` VALUES ('25', '20000314', '2', '2', '1490263992');
INSERT INTO `tc_look_record` VALUES ('26', '20000313', '1', '2', '1490264008');
INSERT INTO `tc_look_record` VALUES ('27', '20000313', '1', '2', '1490264012');
INSERT INTO `tc_look_record` VALUES ('28', '20000314', '1', '2', '1490264023');
INSERT INTO `tc_look_record` VALUES ('29', '20000314', '2', '2', '1490264044');
INSERT INTO `tc_look_record` VALUES ('30', '20000314', '2', '2', '1490264055');
INSERT INTO `tc_look_record` VALUES ('31', '20000313', '2', '2', '1490264100');
INSERT INTO `tc_look_record` VALUES ('32', '20000313', '2', '2', '1490264104');
INSERT INTO `tc_look_record` VALUES ('33', '20000313', '1', '2', '1490264107');
INSERT INTO `tc_look_record` VALUES ('34', '20000314', '1', '2', '1490264143');
INSERT INTO `tc_look_record` VALUES ('35', '20000314', '2', '2', '1490264158');
INSERT INTO `tc_look_record` VALUES ('36', '20000313', '1', '2', '1490264190');
INSERT INTO `tc_look_record` VALUES ('37', '20000313', '1', '2', '1490264204');
INSERT INTO `tc_look_record` VALUES ('38', '20000313', '1', '2', '1490264209');
INSERT INTO `tc_look_record` VALUES ('39', '20000313', '1', '2', '1490264213');
INSERT INTO `tc_look_record` VALUES ('40', '20000312', '1', '2', '1490264247');
INSERT INTO `tc_look_record` VALUES ('41', '20000314', '1', '2', '1490264253');
INSERT INTO `tc_look_record` VALUES ('42', '20000312', '1', '2', '1490264287');
INSERT INTO `tc_look_record` VALUES ('43', '20000314', '1', '2', '1490264303');
INSERT INTO `tc_look_record` VALUES ('44', '20000312', '1', '2', '1490264345');
INSERT INTO `tc_look_record` VALUES ('45', '20000313', '2', '2', '1490264365');
INSERT INTO `tc_look_record` VALUES ('46', '20000313', '1', '2', '1490264367');
INSERT INTO `tc_look_record` VALUES ('47', '20000314', '1', '2', '1490264428');
INSERT INTO `tc_look_record` VALUES ('48', '20000312', '1', '2', '1490264666');
INSERT INTO `tc_look_record` VALUES ('49', '20000314', '1', '2', '1490264682');
INSERT INTO `tc_look_record` VALUES ('50', '20000312', '1', '2', '1490264690');
INSERT INTO `tc_look_record` VALUES ('51', '20000313', '1', '2', '1490264696');
INSERT INTO `tc_look_record` VALUES ('52', '20000312', '1', '2', '1490264927');
INSERT INTO `tc_look_record` VALUES ('53', '20000313', '1', '2', '1490264930');
INSERT INTO `tc_look_record` VALUES ('54', '20000313', '1', '2', '1490264937');
INSERT INTO `tc_look_record` VALUES ('55', '20000313', '1', '2', '1490264947');
INSERT INTO `tc_look_record` VALUES ('56', '20000313', '1', '2', '1490265012');
INSERT INTO `tc_look_record` VALUES ('57', '20000314', '1', '2', '1490265031');
INSERT INTO `tc_look_record` VALUES ('58', '20000313', '2', '2', '1490265065');
INSERT INTO `tc_look_record` VALUES ('59', '20000314', '1', '2', '1490265066');
INSERT INTO `tc_look_record` VALUES ('60', '20000313', '1', '2', '1490265079');
INSERT INTO `tc_look_record` VALUES ('61', '20000314', '1', '2', '1490265081');
INSERT INTO `tc_look_record` VALUES ('62', '20000313', '1', '2', '1490265087');
INSERT INTO `tc_look_record` VALUES ('63', '20000313', '1', '2', '1490265112');
INSERT INTO `tc_look_record` VALUES ('64', '20000312', '1', '2', '1490265116');
INSERT INTO `tc_look_record` VALUES ('65', '20000315', '2', '2', '1490265186');
INSERT INTO `tc_look_record` VALUES ('66', '20000315', '2', '2', '1490265193');
INSERT INTO `tc_look_record` VALUES ('67', '20000315', '1', '2', '1490265198');
INSERT INTO `tc_look_record` VALUES ('68', '20000315', '1', '2', '1490265200');
INSERT INTO `tc_look_record` VALUES ('69', '20000315', '2', '2', '1490265202');
INSERT INTO `tc_look_record` VALUES ('70', '20000315', '2', '2', '1490265206');
INSERT INTO `tc_look_record` VALUES ('71', '20000315', '1', '2', '1490265208');
INSERT INTO `tc_look_record` VALUES ('72', '20000315', '1', '2', '1490265214');
INSERT INTO `tc_look_record` VALUES ('73', '20000315', '1', '2', '1490265229');
INSERT INTO `tc_look_record` VALUES ('74', '20000315', '1', '2', '1490265235');
INSERT INTO `tc_look_record` VALUES ('75', '20000312', '1', '2', '1490265241');
INSERT INTO `tc_look_record` VALUES ('76', '20000314', '1', '2', '1490265355');
INSERT INTO `tc_look_record` VALUES ('77', '20000314', '1', '2', '1490265356');
INSERT INTO `tc_look_record` VALUES ('78', '20000314', '1', '2', '1490265357');
INSERT INTO `tc_look_record` VALUES ('79', '20000314', '1', '2', '1490265361');
INSERT INTO `tc_look_record` VALUES ('80', '20000314', '1', '2', '1490265408');
INSERT INTO `tc_look_record` VALUES ('81', '20000313', '1', '2', '1490265415');
INSERT INTO `tc_look_record` VALUES ('82', '20000312', '1', '2', '1490265422');
INSERT INTO `tc_look_record` VALUES ('83', '20000312', '1', '2', '1490265439');
INSERT INTO `tc_look_record` VALUES ('84', '20000315', '1', '2', '1490265464');
INSERT INTO `tc_look_record` VALUES ('85', '20000313', '1', '2', '1490265505');
INSERT INTO `tc_look_record` VALUES ('86', '20000313', '1', '2', '1490265510');
INSERT INTO `tc_look_record` VALUES ('87', '20000313', '1', '2', '1490265525');
INSERT INTO `tc_look_record` VALUES ('88', '20000313', '1', '2', '1490265533');
INSERT INTO `tc_look_record` VALUES ('89', '20000314', '1', '2', '1490265601');
INSERT INTO `tc_look_record` VALUES ('90', '20000314', '1', '2', '1490265621');
INSERT INTO `tc_look_record` VALUES ('91', '20000315', '2', '2', '1490265653');
INSERT INTO `tc_look_record` VALUES ('92', '20000313', '1', '2', '1490265744');
INSERT INTO `tc_look_record` VALUES ('93', '20000312', '1', '2', '1490265812');
INSERT INTO `tc_look_record` VALUES ('94', '20000312', '1', '2', '1490265827');
INSERT INTO `tc_look_record` VALUES ('95', '20000312', '1', '2', '1490265833');
INSERT INTO `tc_look_record` VALUES ('96', '20000312', '1', '2', '1490265906');
INSERT INTO `tc_look_record` VALUES ('97', '20000313', '1', '2', '1490266183');
INSERT INTO `tc_look_record` VALUES ('98', '20000312', '1', '2', '1490266419');
INSERT INTO `tc_look_record` VALUES ('99', '20000312', '1', '2', '1490266428');
INSERT INTO `tc_look_record` VALUES ('100', '20000312', '1', '2', '1490267020');
INSERT INTO `tc_look_record` VALUES ('101', '20000315', '1', '2', '1490267140');
INSERT INTO `tc_look_record` VALUES ('102', '20000315', '1', '2', '1490267165');
INSERT INTO `tc_look_record` VALUES ('103', '20000315', '1', '2', '1490267168');
INSERT INTO `tc_look_record` VALUES ('104', '20000314', '1', '2', '1490270302');
INSERT INTO `tc_look_record` VALUES ('105', '20000312', '1', '2', '1490320408');
INSERT INTO `tc_look_record` VALUES ('106', '20000315', '1', '2', '1490320444');
INSERT INTO `tc_look_record` VALUES ('107', '20000312', '2', '2', '1490320450');
INSERT INTO `tc_look_record` VALUES ('108', '20000315', '1', '2', '1490320472');
INSERT INTO `tc_look_record` VALUES ('109', '20000315', '1', '2', '1490320477');
INSERT INTO `tc_look_record` VALUES ('110', '20000312', '1', '2', '1490320479');
INSERT INTO `tc_look_record` VALUES ('111', '20000314', '1', '2', '1490321044');
INSERT INTO `tc_look_record` VALUES ('112', '20000314', '2', '2', '1490321049');
INSERT INTO `tc_look_record` VALUES ('113', '20000314', '1', '2', '1490321052');
INSERT INTO `tc_look_record` VALUES ('114', '20000313', '2', '2', '1490321087');
INSERT INTO `tc_look_record` VALUES ('115', '20000313', '1', '2', '1490321089');
INSERT INTO `tc_look_record` VALUES ('116', '20000314', '1', '2', '1490321141');
INSERT INTO `tc_look_record` VALUES ('117', '20000314', '1', '2', '1490321146');
INSERT INTO `tc_look_record` VALUES ('118', '20000313', '2', '2', '1490321158');
INSERT INTO `tc_look_record` VALUES ('119', '20000314', '1', '2', '1490321169');
INSERT INTO `tc_look_record` VALUES ('120', '20000312', '2', '2', '1490321170');
INSERT INTO `tc_look_record` VALUES ('121', '20000314', '2', '2', '1490321172');
INSERT INTO `tc_look_record` VALUES ('122', '20000312', '2', '2', '1490321175');
INSERT INTO `tc_look_record` VALUES ('123', '20000312', '1', '2', '1490321178');
INSERT INTO `tc_look_record` VALUES ('124', '20000312', '2', '2', '1490321182');
INSERT INTO `tc_look_record` VALUES ('125', '20000314', '2', '2', '1490321185');
INSERT INTO `tc_look_record` VALUES ('126', '20000314', '2', '2', '1490321199');
INSERT INTO `tc_look_record` VALUES ('127', '20000313', '2', '2', '1490321219');
INSERT INTO `tc_look_record` VALUES ('128', '20000313', '2', '2', '1490321229');
INSERT INTO `tc_look_record` VALUES ('129', '20000314', '2', '2', '1490321305');
INSERT INTO `tc_look_record` VALUES ('130', '20000313', '2', '2', '1490321330');
INSERT INTO `tc_look_record` VALUES ('131', '20000314', '2', '2', '1490321346');
INSERT INTO `tc_look_record` VALUES ('132', '20000313', '1', '2', '1490321353');
INSERT INTO `tc_look_record` VALUES ('133', '20000314', '1', '2', '1490321379');
INSERT INTO `tc_look_record` VALUES ('134', '20000312', '1', '2', '1490321442');
INSERT INTO `tc_look_record` VALUES ('135', '20000312', '2', '2', '1490321448');
INSERT INTO `tc_look_record` VALUES ('136', '20000313', '19', '1', '1490321592');
INSERT INTO `tc_look_record` VALUES ('137', '20000313', '19', '1', '1490321594');
INSERT INTO `tc_look_record` VALUES ('138', '20000313', '3', '2', '1490321602');
INSERT INTO `tc_look_record` VALUES ('139', '20000313', '4', '2', '1490321604');
INSERT INTO `tc_look_record` VALUES ('140', '20000313', '3', '2', '1490321607');
INSERT INTO `tc_look_record` VALUES ('141', '20000315', '3', '2', '1490321622');
INSERT INTO `tc_look_record` VALUES ('142', '20000314', '2', '2', '1490325206');
INSERT INTO `tc_look_record` VALUES ('143', '20000314', '2', '2', '1490325214');
INSERT INTO `tc_look_record` VALUES ('144', '20000315', '2', '2', '1490325219');
INSERT INTO `tc_look_record` VALUES ('145', '20000313', '1', '2', '1490325276');
INSERT INTO `tc_look_record` VALUES ('146', '20000313', '2', '2', '1490325278');
INSERT INTO `tc_look_record` VALUES ('147', '20000315', '1', '2', '1490326685');
INSERT INTO `tc_look_record` VALUES ('148', '20000313', '3', '2', '1490327577');
INSERT INTO `tc_look_record` VALUES ('149', '20000315', '3', '2', '1490327617');
INSERT INTO `tc_look_record` VALUES ('150', '20000315', '3', '2', '1490327641');
INSERT INTO `tc_look_record` VALUES ('151', '20000315', '3', '2', '1490327691');
INSERT INTO `tc_look_record` VALUES ('152', '20000316', '20000314', '3', '1490327892');
INSERT INTO `tc_look_record` VALUES ('153', '20000316', '20000314', '3', '1490327967');
INSERT INTO `tc_look_record` VALUES ('154', '20000316', '4', '2', '1490328045');
INSERT INTO `tc_look_record` VALUES ('155', '20000316', '4', '2', '1490328066');
INSERT INTO `tc_look_record` VALUES ('156', '20000316', '20', '1', '1490328068');
INSERT INTO `tc_look_record` VALUES ('157', '20000316', '20', '1', '1490328069');
INSERT INTO `tc_look_record` VALUES ('158', '20000316', '4', '2', '1490328081');
INSERT INTO `tc_look_record` VALUES ('159', '20000313', '4', '2', '1490328245');
INSERT INTO `tc_look_record` VALUES ('160', '20000313', '3', '2', '1490328256');
INSERT INTO `tc_look_record` VALUES ('161', '20000313', '19', '1', '1490328281');
INSERT INTO `tc_look_record` VALUES ('162', '20000313', '19', '1', '1490328282');
INSERT INTO `tc_look_record` VALUES ('163', '20000313', '19', '1', '1490328291');
INSERT INTO `tc_look_record` VALUES ('164', '20000313', '19', '1', '1490328292');
INSERT INTO `tc_look_record` VALUES ('165', '20000313', '3', '2', '1490328303');
INSERT INTO `tc_look_record` VALUES ('166', '20000313', '3', '2', '1490328307');
INSERT INTO `tc_look_record` VALUES ('167', '20000315', '3', '2', '1490328314');
INSERT INTO `tc_look_record` VALUES ('168', '20000313', '2', '2', '1490328455');
INSERT INTO `tc_look_record` VALUES ('169', '20000313', '2', '2', '1490328456');
INSERT INTO `tc_look_record` VALUES ('170', '20000315', '1', '2', '1490328457');
INSERT INTO `tc_look_record` VALUES ('171', '20000315', '1', '2', '1490328475');
INSERT INTO `tc_look_record` VALUES ('172', '20000315', '1', '2', '1490328477');
INSERT INTO `tc_look_record` VALUES ('173', '20000313', '2', '2', '1490328491');
INSERT INTO `tc_look_record` VALUES ('174', '20000315', '2', '2', '1490328494');
INSERT INTO `tc_look_record` VALUES ('175', '20000313', '2', '2', '1490328497');
INSERT INTO `tc_look_record` VALUES ('176', '20000313', '2', '2', '1490328549');
INSERT INTO `tc_look_record` VALUES ('177', '20000313', '3', '2', '1490332094');
INSERT INTO `tc_look_record` VALUES ('178', '20000313', '19', '1', '1490332165');
INSERT INTO `tc_look_record` VALUES ('179', '20000313', '4', '2', '1490332172');
INSERT INTO `tc_look_record` VALUES ('180', '20000312', '2', '2', '1490333486');
INSERT INTO `tc_look_record` VALUES ('181', '20000313', '1', '2', '1490333559');
INSERT INTO `tc_look_record` VALUES ('182', '20000313', '1', '2', '1490333573');
INSERT INTO `tc_look_record` VALUES ('183', '20000315', '1', '2', '1490333597');
INSERT INTO `tc_look_record` VALUES ('184', '20000312', '1', '2', '1490334768');
INSERT INTO `tc_look_record` VALUES ('185', '20000316', '1', '2', '1490335018');
INSERT INTO `tc_look_record` VALUES ('186', '20000316', '1', '2', '1490335021');
INSERT INTO `tc_look_record` VALUES ('187', '20000316', '1', '2', '1490335029');
INSERT INTO `tc_look_record` VALUES ('188', '20000316', '1', '2', '1490335033');
INSERT INTO `tc_look_record` VALUES ('189', '20000316', '1', '2', '1490335049');
INSERT INTO `tc_look_record` VALUES ('190', '20000313', '1', '2', '1490335101');
INSERT INTO `tc_look_record` VALUES ('191', '20000316', '1', '2', '1490335333');
INSERT INTO `tc_look_record` VALUES ('192', '20000316', '4', '2', '1490337239');
INSERT INTO `tc_look_record` VALUES ('193', '20000316', '4', '2', '1490337250');
INSERT INTO `tc_look_record` VALUES ('194', '20000312', '4', '2', '1490337277');
INSERT INTO `tc_look_record` VALUES ('195', '20000312', '1', '2', '1490337336');
INSERT INTO `tc_look_record` VALUES ('196', '20000316', '20', '1', '1490337346');
INSERT INTO `tc_look_record` VALUES ('197', '20000315', '1', '2', '1490337651');
INSERT INTO `tc_look_record` VALUES ('198', '20000315', '1', '2', '1490337653');
INSERT INTO `tc_look_record` VALUES ('199', '20000315', '3', '2', '1490337708');
INSERT INTO `tc_look_record` VALUES ('200', '20000312', '4', '2', '1490337733');
INSERT INTO `tc_look_record` VALUES ('201', '20000312', '1', '2', '1490337748');
INSERT INTO `tc_look_record` VALUES ('202', '20000315', '1', '2', '1490337755');
INSERT INTO `tc_look_record` VALUES ('203', '20000312', '20', '1', '1490337763');
INSERT INTO `tc_look_record` VALUES ('204', '20000312', '4', '2', '1490337767');
INSERT INTO `tc_look_record` VALUES ('205', '20000315', '3', '2', '1490337769');
INSERT INTO `tc_look_record` VALUES ('206', '20000312', '1', '2', '1490337787');
INSERT INTO `tc_look_record` VALUES ('207', '20000313', '4', '2', '1490337789');
INSERT INTO `tc_look_record` VALUES ('208', '20000313', '19', '1', '1490337795');
INSERT INTO `tc_look_record` VALUES ('209', '20000313', '3', '2', '1490337797');
INSERT INTO `tc_look_record` VALUES ('210', '20000313', '19', '1', '1490337808');
INSERT INTO `tc_look_record` VALUES ('211', '20000313', '19', '1', '1490337811');
INSERT INTO `tc_look_record` VALUES ('212', '20000313', '3', '2', '1490337813');
INSERT INTO `tc_look_record` VALUES ('213', '20000312', '4', '2', '1490337821');
INSERT INTO `tc_look_record` VALUES ('214', '20000312', '20', '1', '1490337825');
INSERT INTO `tc_look_record` VALUES ('215', '20000315', '3', '2', '1490337825');
INSERT INTO `tc_look_record` VALUES ('216', '20000312', '20', '1', '1490337826');
INSERT INTO `tc_look_record` VALUES ('217', '20000315', '4', '2', '1490337857');
INSERT INTO `tc_look_record` VALUES ('218', '20000312', '4', '2', '1490337869');
INSERT INTO `tc_look_record` VALUES ('219', '20000313', '19', '1', '1490337885');
INSERT INTO `tc_look_record` VALUES ('220', '20000315', '3', '2', '1490337899');
INSERT INTO `tc_look_record` VALUES ('221', '20000312', '20', '1', '1490337901');
INSERT INTO `tc_look_record` VALUES ('222', '20000312', '20', '1', '1490337903');
INSERT INTO `tc_look_record` VALUES ('223', '20000315', '3', '2', '1490337909');
INSERT INTO `tc_look_record` VALUES ('224', '20000315', '3', '2', '1490337916');
INSERT INTO `tc_look_record` VALUES ('225', '20000312', '4', '2', '1490337917');
INSERT INTO `tc_look_record` VALUES ('226', '20000315', '20', '1', '1490337928');
INSERT INTO `tc_look_record` VALUES ('227', '20000315', '4', '2', '1490337932');
INSERT INTO `tc_look_record` VALUES ('228', '20000315', '4', '2', '1490337953');
INSERT INTO `tc_look_record` VALUES ('229', '20000313', '1', '2', '1490338026');
INSERT INTO `tc_look_record` VALUES ('230', '20000316', '1', '2', '1490338239');
INSERT INTO `tc_look_record` VALUES ('231', '20000312', '20', '1', '1490338387');
INSERT INTO `tc_look_record` VALUES ('232', '20000312', '4', '2', '1490338390');
INSERT INTO `tc_look_record` VALUES ('233', '20000312', '4', '2', '1490338415');
INSERT INTO `tc_look_record` VALUES ('234', '20000315', '4', '2', '1490338681');
INSERT INTO `tc_look_record` VALUES ('235', '20000312', '4', '2', '1490338693');
INSERT INTO `tc_look_record` VALUES ('236', '20000312', '4', '2', '1490338703');
INSERT INTO `tc_look_record` VALUES ('237', '20000315', '1', '2', '1490338708');
INSERT INTO `tc_look_record` VALUES ('238', '20000312', '1', '2', '1490338735');
INSERT INTO `tc_look_record` VALUES ('239', '20000313', '1', '2', '1490339805');
INSERT INTO `tc_look_record` VALUES ('240', '20000313', '4', '2', '1490339887');
INSERT INTO `tc_look_record` VALUES ('241', '20000313', '1', '2', '1490339943');
INSERT INTO `tc_look_record` VALUES ('242', '20000315', '20', '1', '1490340971');
INSERT INTO `tc_look_record` VALUES ('243', '20000315', '20', '1', '1490341010');
INSERT INTO `tc_look_record` VALUES ('244', '20000316', '1', '2', '1490341050');
INSERT INTO `tc_look_record` VALUES ('245', '20000316', '20', '1', '1490341054');
INSERT INTO `tc_look_record` VALUES ('246', '20000316', '20', '1', '1490341056');
INSERT INTO `tc_look_record` VALUES ('247', '20000315', '3', '2', '1490342470');
INSERT INTO `tc_look_record` VALUES ('248', '20000313', '19', '1', '1490342487');
INSERT INTO `tc_look_record` VALUES ('249', '20000313', '19', '1', '1490342579');
INSERT INTO `tc_look_record` VALUES ('250', '20000313', '3', '2', '1490342626');
INSERT INTO `tc_look_record` VALUES ('251', '20000315', '2', '2', '1490342768');
INSERT INTO `tc_look_record` VALUES ('252', '20000313', '1', '2', '1490342840');
INSERT INTO `tc_look_record` VALUES ('253', '20000313', '2', '2', '1490342842');
INSERT INTO `tc_look_record` VALUES ('254', '20000313', '2', '2', '1490342849');
INSERT INTO `tc_look_record` VALUES ('255', '20000316', '4', '2', '1490342974');
INSERT INTO `tc_look_record` VALUES ('256', '20000315', '20', '1', '1490343618');
INSERT INTO `tc_look_record` VALUES ('257', '20000315', '20', '1', '1490343619');
INSERT INTO `tc_look_record` VALUES ('258', '20000313', '19', '1', '1490343691');
INSERT INTO `tc_look_record` VALUES ('259', '20000000', '20000002', '3', '1490420982');
INSERT INTO `tc_look_record` VALUES ('260', '20000000', '20000002', '3', '1490421018');
INSERT INTO `tc_look_record` VALUES ('261', '20000002', '20000000', '3', '1490442048');
INSERT INTO `tc_look_record` VALUES ('262', '20000315', '20000316', '3', '1490586323');
INSERT INTO `tc_look_record` VALUES ('263', '20000315', '20000316', '3', '1490586375');
INSERT INTO `tc_look_record` VALUES ('264', '20000315', '20000316', '3', '1490586378');
INSERT INTO `tc_look_record` VALUES ('265', '20000316', '6', '2', '1490586474');
INSERT INTO `tc_look_record` VALUES ('266', '20000316', '6', '2', '1490586476');
INSERT INTO `tc_look_record` VALUES ('267', '20000316', '9', '2', '1490586495');
INSERT INTO `tc_look_record` VALUES ('268', '20000316', '4', '2', '1490586596');
INSERT INTO `tc_look_record` VALUES ('269', '20000316', '20', '1', '1490586598');
INSERT INTO `tc_look_record` VALUES ('270', '20000316', '20', '1', '1490586599');
INSERT INTO `tc_look_record` VALUES ('271', '20000315', '4', '2', '1490587212');
INSERT INTO `tc_look_record` VALUES ('272', '20000315', '20', '1', '1490587214');
INSERT INTO `tc_look_record` VALUES ('273', '20000315', '20', '1', '1490587217');
INSERT INTO `tc_look_record` VALUES ('274', '20000315', '20', '1', '1490587218');
INSERT INTO `tc_look_record` VALUES ('275', '20000315', '20', '1', '1490587222');
INSERT INTO `tc_look_record` VALUES ('276', '20000315', '4', '2', '1490587279');
INSERT INTO `tc_look_record` VALUES ('277', '20000313', '4', '2', '1490587321');
INSERT INTO `tc_look_record` VALUES ('278', '20000313', '4', '2', '1490587334');
INSERT INTO `tc_look_record` VALUES ('279', '20000313', '4', '2', '1490587343');
INSERT INTO `tc_look_record` VALUES ('280', '20000315', '20', '1', '1490587368');
INSERT INTO `tc_look_record` VALUES ('281', '20000315', '20', '1', '1490587374');
INSERT INTO `tc_look_record` VALUES ('282', '20000315', '4', '2', '1490587376');
INSERT INTO `tc_look_record` VALUES ('283', '20000315', '20', '1', '1490587378');
INSERT INTO `tc_look_record` VALUES ('284', '20000313', '12', '2', '1490592587');
INSERT INTO `tc_look_record` VALUES ('285', '20000315', '3', '2', '1490592628');
INSERT INTO `tc_look_record` VALUES ('286', '20000315', '3', '2', '1490592630');
INSERT INTO `tc_look_record` VALUES ('287', '20000315', '3', '2', '1490592631');
INSERT INTO `tc_look_record` VALUES ('288', '20000313', '12', '2', '1490593089');
INSERT INTO `tc_look_record` VALUES ('289', '20000315', '26', '1', '1490593114');
INSERT INTO `tc_look_record` VALUES ('290', '20000315', '26', '1', '1490593120');
INSERT INTO `tc_look_record` VALUES ('291', '20000315', '12', '2', '1490593122');
INSERT INTO `tc_look_record` VALUES ('292', '20000315', '26', '1', '1490593135');
INSERT INTO `tc_look_record` VALUES ('293', '20000315', '26', '1', '1490593140');
INSERT INTO `tc_look_record` VALUES ('294', '20000315', '26', '1', '1490593143');
INSERT INTO `tc_look_record` VALUES ('295', '20000315', '26', '1', '1490593143');
INSERT INTO `tc_look_record` VALUES ('296', '20000315', '26', '1', '1490593147');
INSERT INTO `tc_look_record` VALUES ('297', '20000315', '12', '2', '1490593169');
INSERT INTO `tc_look_record` VALUES ('298', '20000316', '20', '1', '1490594398');
INSERT INTO `tc_look_record` VALUES ('299', '20000316', '20', '1', '1490594399');
INSERT INTO `tc_look_record` VALUES ('300', '20000316', '20', '1', '1490594406');
INSERT INTO `tc_look_record` VALUES ('301', '20000316', '20', '1', '1490594407');
INSERT INTO `tc_look_record` VALUES ('302', '20000316', '20', '1', '1490594412');
INSERT INTO `tc_look_record` VALUES ('303', '20000316', '4', '2', '1490594414');
INSERT INTO `tc_look_record` VALUES ('304', '20000316', '20', '1', '1490594418');
INSERT INTO `tc_look_record` VALUES ('305', '20000313', '12', '2', '1490594676');
INSERT INTO `tc_look_record` VALUES ('306', '20000313', '19', '1', '1490594693');
INSERT INTO `tc_look_record` VALUES ('307', '20000313', '19', '1', '1490594694');
INSERT INTO `tc_look_record` VALUES ('308', '20000315', '20', '1', '1490594729');
INSERT INTO `tc_look_record` VALUES ('309', '20000315', '20', '1', '1490594731');
INSERT INTO `tc_look_record` VALUES ('310', '20000315', '20', '1', '1490594732');
INSERT INTO `tc_look_record` VALUES ('311', '20000315', '20', '1', '1490594732');
INSERT INTO `tc_look_record` VALUES ('312', '20000315', '4', '2', '1490594734');
INSERT INTO `tc_look_record` VALUES ('313', '20000313', '4', '2', '1490594740');
INSERT INTO `tc_look_record` VALUES ('314', '20000313', '19', '1', '1490594750');
INSERT INTO `tc_look_record` VALUES ('315', '20000313', '3', '2', '1490594752');
INSERT INTO `tc_look_record` VALUES ('316', '20000315', '20', '1', '1490594763');
INSERT INTO `tc_look_record` VALUES ('317', '20000313', '19', '1', '1490594770');
INSERT INTO `tc_look_record` VALUES ('318', '20000313', '3', '2', '1490594772');
INSERT INTO `tc_look_record` VALUES ('319', '20000313', '19', '1', '1490594798');
INSERT INTO `tc_look_record` VALUES ('320', '20000313', '19', '1', '1490594799');
INSERT INTO `tc_look_record` VALUES ('321', '20000315', '20', '1', '1490595064');
INSERT INTO `tc_look_record` VALUES ('322', '20000315', '20', '1', '1490595068');
INSERT INTO `tc_look_record` VALUES ('323', '20000315', '20', '1', '1490595068');
INSERT INTO `tc_look_record` VALUES ('324', '20000315', '20', '1', '1490595070');
INSERT INTO `tc_look_record` VALUES ('325', '20000313', '19', '1', '1490595229');
INSERT INTO `tc_look_record` VALUES ('326', '20000313', '19', '1', '1490595247');
INSERT INTO `tc_look_record` VALUES ('327', '20000313', '3', '2', '1490595249');
INSERT INTO `tc_look_record` VALUES ('328', '20000313', '19', '1', '1490595256');
INSERT INTO `tc_look_record` VALUES ('329', '20000315', '3', '2', '1490595695');
INSERT INTO `tc_look_record` VALUES ('330', '20000315', '3', '2', '1490595700');
INSERT INTO `tc_look_record` VALUES ('331', '20000315', '20000316', '3', '1490595710');
INSERT INTO `tc_look_record` VALUES ('332', '20000315', '26', '1', '1490595715');
INSERT INTO `tc_look_record` VALUES ('333', '20000315', '26', '1', '1490595719');
INSERT INTO `tc_look_record` VALUES ('334', '20000315', '26', '1', '1490595719');
INSERT INTO `tc_look_record` VALUES ('335', '20000315', '26', '1', '1490595745');
INSERT INTO `tc_look_record` VALUES ('336', '20000315', '26', '1', '1490595745');
INSERT INTO `tc_look_record` VALUES ('337', '20000315', '26', '1', '1490595746');
INSERT INTO `tc_look_record` VALUES ('338', '20000315', '12', '2', '1490595751');
INSERT INTO `tc_look_record` VALUES ('339', '20000313', '12', '2', '1490595767');
INSERT INTO `tc_look_record` VALUES ('340', '20000315', '20', '1', '1490595871');
INSERT INTO `tc_look_record` VALUES ('341', '20000313', '3', '2', '1490595974');
INSERT INTO `tc_look_record` VALUES ('342', '20000313', '19', '1', '1490595994');
INSERT INTO `tc_look_record` VALUES ('343', '20000313', '19', '1', '1490595995');
INSERT INTO `tc_look_record` VALUES ('344', '20000313', '19', '1', '1490596032');
INSERT INTO `tc_look_record` VALUES ('345', '20000313', '19', '1', '1490596034');
INSERT INTO `tc_look_record` VALUES ('346', '20000313', '19', '1', '1490596242');
INSERT INTO `tc_look_record` VALUES ('347', '20000313', '19', '1', '1490596244');
INSERT INTO `tc_look_record` VALUES ('348', '20000315', '13', '2', '1490596450');
INSERT INTO `tc_look_record` VALUES ('349', '20000313', '19', '1', '1490596547');
INSERT INTO `tc_look_record` VALUES ('350', '20000313', '19', '1', '1490596548');
INSERT INTO `tc_look_record` VALUES ('351', '20000315', '20', '1', '1490596777');
INSERT INTO `tc_look_record` VALUES ('352', '20000315', '20', '1', '1490596779');
INSERT INTO `tc_look_record` VALUES ('353', '20000315', '20', '1', '1490596780');
INSERT INTO `tc_look_record` VALUES ('354', '20000315', '20', '1', '1490596782');
INSERT INTO `tc_look_record` VALUES ('355', '20000315', '20', '1', '1490596896');
INSERT INTO `tc_look_record` VALUES ('356', '20000315', '20', '1', '1490596897');
INSERT INTO `tc_look_record` VALUES ('357', '20000315', '20000313', '3', '1490596903');
INSERT INTO `tc_look_record` VALUES ('358', '20000315', '20', '1', '1490596983');
INSERT INTO `tc_look_record` VALUES ('359', '20000315', '20', '1', '1490596986');
INSERT INTO `tc_look_record` VALUES ('360', '20000315', '20', '1', '1490596986');
INSERT INTO `tc_look_record` VALUES ('361', '20000315', '20', '1', '1490596988');
INSERT INTO `tc_look_record` VALUES ('362', '20000315', '20000313', '3', '1490596993');
INSERT INTO `tc_look_record` VALUES ('363', '20000315', '2', '2', '1490606251');
INSERT INTO `tc_look_record` VALUES ('364', '20000315', '2', '2', '1490606253');
INSERT INTO `tc_look_record` VALUES ('365', '20000315', '1', '2', '1490606257');
INSERT INTO `tc_look_record` VALUES ('366', '20000315', '1', '2', '1490606260');
INSERT INTO `tc_look_record` VALUES ('367', '20000315', '6', '2', '1490606883');
INSERT INTO `tc_look_record` VALUES ('368', '20000315', '20', '1', '1490607930');
INSERT INTO `tc_look_record` VALUES ('369', '20000315', '20', '1', '1490607934');
INSERT INTO `tc_look_record` VALUES ('370', '20000315', '20', '1', '1490607934');
INSERT INTO `tc_look_record` VALUES ('371', '20000315', '20000313', '3', '1490607937');
INSERT INTO `tc_look_record` VALUES ('372', '20000315', '20', '1', '1490607941');
INSERT INTO `tc_look_record` VALUES ('373', '20000315', '20', '1', '1490607942');
INSERT INTO `tc_look_record` VALUES ('374', '20000315', '20', '1', '1490607942');
INSERT INTO `tc_look_record` VALUES ('375', '20000315', '26', '1', '1490608055');
INSERT INTO `tc_look_record` VALUES ('376', '20000315', '26', '1', '1490608057');
INSERT INTO `tc_look_record` VALUES ('377', '20000315', '26', '1', '1490608057');
INSERT INTO `tc_look_record` VALUES ('378', '20000315', '26', '1', '1490608057');
INSERT INTO `tc_look_record` VALUES ('379', '20000315', '20', '1', '1490608097');
INSERT INTO `tc_look_record` VALUES ('380', '20000315', '20', '1', '1490608115');
INSERT INTO `tc_look_record` VALUES ('381', '20000315', '20', '1', '1490608119');
INSERT INTO `tc_look_record` VALUES ('382', '20000315', '20', '1', '1490608119');
INSERT INTO `tc_look_record` VALUES ('383', '20000315', '20', '1', '1490608125');
INSERT INTO `tc_look_record` VALUES ('384', '20000315', '20', '1', '1490608125');
INSERT INTO `tc_look_record` VALUES ('385', '20000315', '20', '1', '1490608125');

-- ----------------------------
-- Table structure for `tc_menu`
-- ----------------------------
DROP TABLE IF EXISTS `tc_menu`;
CREATE TABLE `tc_menu` (
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
) ENGINE=MyISAM AUTO_INCREMENT=65 DEFAULT CHARSET=utf8 COMMENT='后台菜单表';

-- ----------------------------
-- Records of tc_menu
-- ----------------------------
INSERT INTO `tc_menu` VALUES ('1', '我的面板', '0', '', 'Index', 'index', '', '1', '1');
INSERT INTO `tc_menu` VALUES ('2', '管理员', '0', '', 'Back', 'index', '', '2', '1');
INSERT INTO `tc_menu` VALUES ('3', '系统', '0', '', 'System', 'index', '', '3', '1');
INSERT INTO `tc_menu` VALUES ('4', '网站管理', '0', '', 'Website', 'index', '', '4', '1');
INSERT INTO `tc_menu` VALUES ('5', '个人信息', '1', 'Admin', 'Admin', 'personal', '', '0', '1');
INSERT INTO `tc_menu` VALUES ('8', '修改密码', '5', 'Admin', 'Admin', 'public_editPwd', '', '1', '1');
INSERT INTO `tc_menu` VALUES ('9', '修改个人信息', '5', 'Admin', 'Admin', 'public_editInfo', '', '0', '1');
INSERT INTO `tc_menu` VALUES ('7', '菜单管理', '3', 'Admin', 'Menu', 'index', '', '2', '1');
INSERT INTO `tc_menu` VALUES ('12', '菜单列表', '7', 'Admin', 'Menu', 'index', '', '1', '1');
INSERT INTO `tc_menu` VALUES ('6', '管理员管理', '2', 'Admin', 'Admin', 'index', '', '2', '1');
INSERT INTO `tc_menu` VALUES ('10', '管理员列表', '6', 'Admin', 'Admin', 'index', '', '1', '1');
INSERT INTO `tc_menu` VALUES ('11', '角色列表', '6', 'Admin', 'Admin', 'roleList', '', '2', '1');
INSERT INTO `tc_menu` VALUES ('40', '主图设置', '39', 'Admin', 'Setting', 'main', '', '0', '1');
INSERT INTO `tc_menu` VALUES ('41', '广告管理', '4', 'Messages', 'Banner', 'home', '', '0', '1');
INSERT INTO `tc_menu` VALUES ('15', '用户管理', '4', 'User', 'User', 'index', '', '1', '1');
INSERT INTO `tc_menu` VALUES ('16', '用户列表', '15', 'User', 'User', 'index', '', '0', '1');
INSERT INTO `tc_menu` VALUES ('17', '群号管理', '4', 'Share', 'Share', 'home', '', '2', '1');
INSERT INTO `tc_menu` VALUES ('18', '类别列表', '17', 'Share', 'Category', 'index', '', '0', '1');
INSERT INTO `tc_menu` VALUES ('42', '广告列表', '41', 'Messages', 'Banner', 'index', '', '0', '1');
INSERT INTO `tc_menu` VALUES ('38', '举报列表', '36', 'Admin', 'Jubao', 'jubao', '', '0', '1');
INSERT INTO `tc_menu` VALUES ('39', '设置管理', '4', 'Admin', 'Setting', 'home', '', '0', '1');
INSERT INTO `tc_menu` VALUES ('36', '举报管理', '4', 'Admin', 'Jubao', 'home', '', '0', '1');
INSERT INTO `tc_menu` VALUES ('37', '举报内容', '36', 'Admin', 'Jubao', 'index', '', '0', '1');
INSERT INTO `tc_menu` VALUES ('30', '网站设置', '3', 'Admin', 'Logs', 'index', '', '0', '1');
INSERT INTO `tc_menu` VALUES ('31', 'Logs文件列表', '30', 'Admin', 'Logs', 'index', '', '3', '1');
INSERT INTO `tc_menu` VALUES ('32', '网站模式', '30', 'Admin', 'Logs', 'debug', '', '0', '1');
INSERT INTO `tc_menu` VALUES ('34', 'IOS推送设置', '30', 'Admin', 'Push', 'index', '', '1', '1');
INSERT INTO `tc_menu` VALUES ('35', 'IOS推送证书', '30', 'Admin', 'Push', 'upload', '', '2', '1');
INSERT INTO `tc_menu` VALUES ('51', '版本管理', '4', 'Version', 'Apk', 'apk', '', '0', '1');
INSERT INTO `tc_menu` VALUES ('44', '使用说明', '39', 'Admin', 'Setting', 'usement', '', '0', '1');
INSERT INTO `tc_menu` VALUES ('45', '用户协议', '39', 'Admin', 'Setting', 'regist', '', '0', '1');
INSERT INTO `tc_menu` VALUES ('47', '会员说明', '39', 'Admin', 'Setting', 'memberment', '', '0', '1');
INSERT INTO `tc_menu` VALUES ('48', '会员管理', '4', 'User', 'Member', 'home', '', '0', '1');
INSERT INTO `tc_menu` VALUES ('49', '会员列表', '48', 'User', 'Member', 'index', '', '0', '1');
INSERT INTO `tc_menu` VALUES ('50', '反馈意见', '36', 'Admin', 'Jubao', 'feedback', '', '0', '1');
INSERT INTO `tc_menu` VALUES ('52', 'Android版本列表', '51', 'Version', 'Version', 'apk', '', '0', '1');
INSERT INTO `tc_menu` VALUES ('53', '群管理', '4', 'Group', 'Group', 'index', '', '0', '1');
INSERT INTO `tc_menu` VALUES ('54', '群类型列表', '53', 'Group', 'Category', 'index', '', '0', '1');
INSERT INTO `tc_menu` VALUES ('55', '活动资源', '4', 'Find', 'Find', 'index', '', '0', '1');
INSERT INTO `tc_menu` VALUES ('56', '闲置资源列表', '55', 'Find', 'Source', 'index', '', '0', '1');
INSERT INTO `tc_menu` VALUES ('57', '活动列表', '55', 'Find', 'Activity', 'index', '', '0', '1');
INSERT INTO `tc_menu` VALUES ('58', '店铺管理', '4', 'Shop', 'Index', 'index', '', '0', '1');
INSERT INTO `tc_menu` VALUES ('59', '店铺列表', '58', 'Shop', 'Index', 'index', '', '0', '1');
INSERT INTO `tc_menu` VALUES ('60', '商品管理', '4', 'Shop', 'Goods', 'index', '', '0', '1');
INSERT INTO `tc_menu` VALUES ('61', '商品列表', '60', 'Shop', 'Goods', 'index', '', '0', '1');
INSERT INTO `tc_menu` VALUES ('62', '订单列表', '60', 'Shop', 'Order', 'index', '', '0', '1');
INSERT INTO `tc_menu` VALUES ('63', '提现列表', '15', 'User', 'User', 'extract', '', '0', '1');
INSERT INTO `tc_menu` VALUES ('64', '账户异常用户列表', '15', 'User', 'User', 'ex_user_list', '', '0', '1');

-- ----------------------------
-- Table structure for `tc_message`
-- ----------------------------
DROP TABLE IF EXISTS `tc_message`;
CREATE TABLE `tc_message` (
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
) ENGINE=InnoDB AUTO_INCREMENT=482 DEFAULT CHARSET=utf8 COMMENT='消息表';

-- ----------------------------
-- Records of tc_message
-- ----------------------------
INSERT INTO `tc_message` VALUES ('1', '20000010', '刚', 'http://www.kmlejin.com/Uploads/Picture/20160323/s_be9ee8d7c8f02a09.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000000', '朱', '', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '刚刚好', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '28972817-3AE5-4F9F-8375-6D8E6430725D', '1458718947850');
INSERT INTO `tc_message` VALUES ('2', '20000010', '刚', 'http://www.kmlejin.com/Uploads/Picture/20160323/s_be9ee8d7c8f02a09.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000000', '朱', 'http://www.kmlejin.com/Uploads/Picture/20160317/s_a5aeb71653f9954f.jpg', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '电影节', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '135639BD-69CD-446F-9F29-D8D3B436F18A', '1458719200991');
INSERT INTO `tc_message` VALUES ('3', '20000010', '刚', 'http://www.kmlejin.com/Uploads/Picture/20160323/s_be9ee8d7c8f02a09.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000000', '朱', 'http://www.kmlejin.com/Uploads/Picture/20160317/s_a5aeb71653f9954f.jpg', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '恢复相互扶持', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '010765C6-5F78-424D-AF5B-5DA57DBEF719', '1458719223754');
INSERT INTO `tc_message` VALUES ('4', '20000010', '刚', 'http://www.kmlejin.com/Uploads/Picture/20160323/s_be9ee8d7c8f02a09.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000000', '朱', 'http://www.kmlejin.com/Uploads/Picture/20160317/s_a5aeb71653f9954f.jpg', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '坚持共产国际', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'CADA62A5-B511-4F8D-BA73-B827E4A209CE', '1458719240467');
INSERT INTO `tc_message` VALUES ('5', '20000000', '朱', 'http://www.kmlejin.com/Uploads/Picture/20160317/s_a5aeb71653f9954f.jpg', '{\"from扩展\":\"从哪儿来的?\"}', '20000010', '刚', 'http://www.kmlejin.com/Uploads/Picture/20160323/s_be9ee8d7c8f02a09.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '嘟嘟嘟', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'A4F7FB89-B448-4041-8E99-07F8C874FC1F', '1458719245512');
INSERT INTO `tc_message` VALUES ('6', '20000010', '刚', 'http://www.kmlejin.com/Uploads/Picture/20160323/s_be9ee8d7c8f02a09.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000000', '朱', 'http://www.kmlejin.com/Uploads/Picture/20160317/s_a5aeb71653f9954f.jpg', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '今天查处非法吉村久夫吹吹风经济处罚结果出国参加', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'D6D669AA-7880-4269-AAAB-1814EFDBB9E9', '1458719813270');
INSERT INTO `tc_message` VALUES ('7', '20000010', '刚', 'http://www.kmlejin.com/Uploads/Picture/20160323/s_be9ee8d7c8f02a09.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000000', '朱', 'http://www.kmlejin.com/Uploads/Picture/20160317/s_a5aeb71653f9954f.jpg', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '根据此次以她促进成果继续关心就关心减肥蔡家沟村加工厂公交车感觉', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'C00974FD-B0C4-4439-A551-B733017D5FDB', '1458719819024');
INSERT INTO `tc_message` VALUES ('8', '20000010', '刚', 'http://www.kmlejin.com/Uploads/Picture/20160323/s_be9ee8d7c8f02a09.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000000', '朱', 'http://www.kmlejin.com/Uploads/Picture/20160317/s_a5aeb71653f9954f.jpg', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '检察官工程机械加工兴奋剂发现解放新疆非常积极成果各持己见歌唱家通存通兑精诚团结加工厂歌唱家金光灿灿感觉歌词成功', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'CDBA6CB7-33C3-4F8D-B702-EB448A5868BC', '1458719826180');
INSERT INTO `tc_message` VALUES ('9', '20000010', '刚', 'http://www.kmlejin.com/Uploads/Picture/20160323/s_be9ee8d7c8f02a09.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000000', '朱', 'http://www.kmlejin.com/Uploads/Picture/20160317/s_a5aeb71653f9954f.jpg', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '客户 v 公交车公交车', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '3970B67D-45C7-42F9-9454-642129F35143', '1458719832356');
INSERT INTO `tc_message` VALUES ('10', '20000010', '刚', 'http://www.kmlejin.com/Uploads/Picture/20160323/s_be9ee8d7c8f02a09.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000000', '朱', 'http://www.kmlejin.com/Uploads/Picture/20160317/s_a5aeb71653f9954f.jpg', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '建成国际性非常国家机关出口国 v 看 v 个', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '4E9E3ABB-56EA-4AAB-8D27-D77746C4D250', '1458719842378');
INSERT INTO `tc_message` VALUES ('11', '20000010', '刚', 'http://www.kmlejin.com/Uploads/Picture/20160323/s_be9ee8d7c8f02a09.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000000', '朱', 'http://www.kmlejin.com/Uploads/Picture/20160317/s_a5aeb71653f9954f.jpg', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '开关厂 v 好快好快 v 看 v 好', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '24975D5B-8081-4119-ADD8-D05A813515A0', '1458719849538');
INSERT INTO `tc_message` VALUES ('12', '20000010', '刚', 'http://www.kmlejin.com/Uploads/Picture/20160323/s_be9ee8d7c8f02a09.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000000', '朱', 'http://www.kmlejin.com/Uploads/Picture/20160317/s_a5aeb71653f9954f.jpg', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '得知特俄关系恢复习惯性金光灿灿条件[emoji_350][emoji_350][emoji_345][emoji_345]', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '25CE3F3E-4033-4DDA-B0B1-5F28DC4DFA5A', '1458719857732');
INSERT INTO `tc_message` VALUES ('13', '20000010', '刚', 'http://www.kmlejin.com/Uploads/Picture/20160323/s_be9ee8d7c8f02a09.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000000', '朱', 'http://www.kmlejin.com/Uploads/Picture/20160317/s_a5aeb71653f9954f.jpg', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '因此检察院金城汤池添加剂厂天', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '8CC9AE57-35CC-4E66-9650-B4C2F205699E', '1458719866562');
INSERT INTO `tc_message` VALUES ('14', '20000010', '刚', 'http://www.kmlejin.com/Uploads/Picture/20160323/s_be9ee8d7c8f02a09.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000000', '朱', 'http://www.kmlejin.com/Uploads/Picture/20160317/s_a5aeb71653f9954f.jpg', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '考古成果促进肌肤财产纠纷', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '8208BA78-3F33-433F-9DD3-371B81286E70', '1458719930084');
INSERT INTO `tc_message` VALUES ('15', '20000010', '刚', 'http://www.kmlejin.com/Uploads/Picture/20160323/s_be9ee8d7c8f02a09.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000000', '朱', 'http://www.kmlejin.com/Uploads/Picture/20160317/s_a5aeb71653f9954f.jpg', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '何况 v 可以吃', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'CCB53B6F-7EC4-4B8C-BEAD-0ADC5B7D72BC', '1458719955403');
INSERT INTO `tc_message` VALUES ('16', '20000000', '朱', 'http://www.kmlejin.com/Uploads/Picture/20160317/s_a5aeb71653f9954f.jpg', '{\"from扩展\":\"从哪儿来的?\"}', '20000010', '刚', 'http://www.kmlejin.com/Uploads/Picture/20160323/s_be9ee8d7c8f02a09.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '弄MP5', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'A43C1F58-1D22-4399-8586-EC54708BF1EC', '1458720167610');
INSERT INTO `tc_message` VALUES ('20', '20000001', '朱', 'http://120.25.66.53/lejin440986fcfb1ab1dca3c43cace659bfb7', '', '20000000', '朱', 'http://120.25.66.53/lejinc1322817a9cca14af33912f86da352be', '', '', '', '', '', '谢谢反馈意见额', '', '', '100', '1', 'aa6589bb-09c3-75a2-ce4d-f4710e347445', '1459299867294');
INSERT INTO `tc_message` VALUES ('21', '20000001', '朱', 'http://www.kmlejin.com440986fcfb1ab1dca3c43cace659bfb7', '', '20000000', '朱', 'http://www.kmlejin.comc1322817a9cca14af33912f86da352be', '', '', '', '', '', '水电费', '', '', '100', '1', '59ef01c0-cbe4-17c9-bdcd-cc99b80cecab', '1459353155653');
INSERT INTO `tc_message` VALUES ('22', '20000001', '朱', 'http://www.kmlejin.com440986fcfb1ab1dca3c43cace659bfb7', '', '20000000', '朱', 'http://www.kmlejin.comc1322817a9cca14af33912f86da352be', '', '', '', '', '', '的范德萨发', '', '', '100', '1', '574affa9-2e8f-1859-4007-faf8ae3e4e91', '1459353188188');
INSERT INTO `tc_message` VALUES ('23', '20000000', '朱', 'http://120.25.66.53/lejin/Uploads/Picture/20160317/s_a5aeb71653f9954f.jpg', '', '20000001', '朱', 'http://120.25.66.53/lejin/Uploads/Picture/20160317/s_72f27ddddf5d7590.jpg', '', '', '', '', '', '他慷慨解囊', '', '', '100', '1', 'e75b347a-68d8-42cd-9352-333e1fb3e518', '1459353780670');
INSERT INTO `tc_message` VALUES ('24', '20000000', '朱', 'http://120.25.66.53/lejin/Uploads/Picture/20160317/s_a5aeb71653f9954f.jpg', '', '20000001', '朱', 'http://120.25.66.53/lejin/Uploads/Picture/20160317/s_72f27ddddf5d7590.jpg', '', '', '', '', '', '正确显示头像', '', '', '100', '1', '145c957c-57fc-4576-bfdf-11445d9f1207', '1459353818701');
INSERT INTO `tc_message` VALUES ('25', '20000001', '朱', 'http://www.kmlejin.com/Uploads/Picture/20160317/s_72f27ddddf5d7590.jpg', '', '20000000', '朱', 'http://www.kmlejin.com/Uploads/Picture/20160317/s_a5aeb71653f9954f.jpg', '', '', '', '', '', '谢谢你的反馈', '', '', '100', '1', 'aa01dfca-5328-cca1-aeec-6de80414a869', '1459354305232');
INSERT INTO `tc_message` VALUES ('26', '20000002', '普通的Alan', 'http://120.25.66.53/lejin/Uploads/Picture/20160319/s_251a799cc583f23e.jpg', '', '20000002', '普通的Alan', 'http://120.25.66.53/lejin/Uploads/Picture/20160319/s_251a799cc583f23e.jpg', '', '', '', '', '', '反馈回复，谢谢', '', '', '100', '1', '89249261-f2f1-d574-3445-77e153070491', '1459499252537');
INSERT INTO `tc_message` VALUES ('27', '20000002', '普通的Alan', 'http://120.25.66.53/lejin/Uploads/Picture/20160319/s_251a799cc583f23e.jpg', '', '20000002', '普通的Alan', 'http://120.25.66.53/lejin/Uploads/Picture/20160319/s_251a799cc583f23e.jpg', '', '', '', '', '', '谢谢！', '', '', '100', '1', 'a47632fa-9b43-a8cb-3564-1fd95c9f602d', '1459499347401');
INSERT INTO `tc_message` VALUES ('28', '20000002', 'A.L', 'http://120.25.66.53/lejin/Uploads/Picture/20160319/s_251a799cc583f23e.jpg', '', '20000002', 'A.L', 'http://120.25.66.53/lejin/Uploads/Picture/20160319/s_251a799cc583f23e.jpg', '', '', '', '', '', '收到，谢谢', '', '', '100', '1', 'cc01ab30-de6c-3bad-52b2-46daad32f2a7', '1461899901578');
INSERT INTO `tc_message` VALUES ('29', '20000026', 'test', 'http://www.kmlejin.com/Uploads/Picture/20160505/s_06a4ce61f46f1103.jpg', '', '20000000', '猪猪', 'http://www.kmlejin.com/Uploads/Picture/20160317/s_a5aeb71653f9954f.jpg', '', '', '', '', '', '[emoji_343]', '', '', '100', '1', 'dc84b16f-4ea7-4388-a09e-d8dd7b8a7fd3', '1462426659799');
INSERT INTO `tc_message` VALUES ('30', '20000002', 'A.L', 'http://120.25.66.53/lejin/Uploads/Picture/20160502/s_8e0e71199b07cb4e.jpg', '', '20000002', 'A.L', 'http://120.25.66.53/lejin/Uploads/Picture/20160502/s_8e0e71199b07cb4e.jpg', '', '', '', '', '', '收到，谢谢', '', '', '100', '1', 'fb1df6dc-c2e6-26cc-f419-8962c5ba072c', '1462847281413');
INSERT INTO `tc_message` VALUES ('31', '20000025', '小刺猬', 'http://120.25.66.53/lejin/Uploads/Picture/20160429/s_2d16ed2a55304289.png', '', '20000025', '小刺猬', 'http://120.25.66.53/lejin/Uploads/Picture/20160429/s_2d16ed2a55304289.png', '', '', '', '', '', '好的', '', '', '100', '1', '01ea01e0-3a0e-6f52-fa5d-ee099ed65e38', '1462847541903');
INSERT INTO `tc_message` VALUES ('32', '20000017', 'hhhj', 'http://www.kmlejin.com/Uploads/Picture/20160428/s_4f012674b778f7a1.jpg', '', '20000000', '猪猪', 'http://www.kmlejin.com/Uploads/Picture/20160509/s_f05cae670dba3950.png', '', '', '', '', '', '图瓦卢', '', '', '100', '1', 'cfaf2aa4-0112-4185-8f64-8392ca49543d', '1463502927096');
INSERT INTO `tc_message` VALUES ('33', '20000000', '猪猪', 'http://www.kmlejin.com/Uploads/Picture/20160509/s_f05cae670dba3950.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000017', 'hhhj', 'http://www.kmlejin.com/Uploads/Picture/20160428/s_4f012674b778f7a1.jpg', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', ' 刚好回家', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '77624C8C-5816-42E5-8131-1947DF910B1D', '1463502943747');
INSERT INTO `tc_message` VALUES ('34', '20000000', '猪猪', 'http://www.kmlejin.com/Uploads/Picture/20160509/s_f05cae670dba3950.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000017', 'hhhj', 'http://www.kmlejin.com/Uploads/Picture/20160428/s_4f012674b778f7a1.jpg', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '刚刚好', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '175464E7-9B80-42F2-B2FC-8C8BAB3E0714', '1463502951443');
INSERT INTO `tc_message` VALUES ('35', '20000017', 'hhhj', 'http://www.kmlejin.com/Uploads/Picture/20160428/s_4f012674b778f7a1.jpg', '', '20000000', '猪猪', 'http://www.kmlejin.com/Uploads/Picture/20160509/s_f05cae670dba3950.png', '', '', '', '', '', '失去了', '', '', '100', '1', '81670ebe-e3ff-40bf-885c-b2f874a72796', '1463502964711');
INSERT INTO `tc_message` VALUES ('36', '20000000', '猪猪', 'http://www.kmlejin.com/Uploads/Picture/20160509/s_f05cae670dba3950.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000017', 'hhhj', 'http://www.kmlejin.com/Uploads/Picture/20160428/s_4f012674b778f7a1.jpg', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', 'vbjj', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '895FA80E-0B61-4D11-88E2-14F49F50C81B', '1463502979860');
INSERT INTO `tc_message` VALUES ('37', '20000010', '凯子', 'http://www.kmlejin.com/Uploads/Picture/20160428/s_f4eb34241038b0a5.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000000', '猪猪', 'http://www.kmlejin.com/Uploads/Picture/20160518/s_f5747f994eaacdd9.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '回家睡觉', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '1435ABA7-3311-433B-B178-4C35A77C753B', '1463544929616');
INSERT INTO `tc_message` VALUES ('38', '20000017', 'hhhj', 'http://www.kmlejin.com/Uploads/Picture/20160428/s_4f012674b778f7a1.jpg', '', '20000000', '猪猪', 'http://www.kmlejin.com/Uploads/Picture/20160509/s_f05cae670dba3950.png', '', '', '', '', '', '藤井莉娜', '', '', '100', '1', '3ee92a63-26df-47d9-87bb-3a18ea8bb4ad', '1463613617259');
INSERT INTO `tc_message` VALUES ('39', '20000017', 'hhhj', 'http://www.kmlejin.com/Uploads/Picture/20160428/s_4f012674b778f7a1.jpg', '', '20000000', '猪猪', 'http://www.kmlejin.com/Uploads/Picture/20160509/s_f05cae670dba3950.png', '', '', '', '', '', '吞没', '', '', '100', '1', 'b1771cf3-dedd-402c-8937-112525c63d9a', '1463613620769');
INSERT INTO `tc_message` VALUES ('40', '20000017', 'nye', 'http://www.kmlejin.com/Uploads/Picture/20160428/s_4f012674b778f7a1.jpg', '', '20000000', '朱', 'http://www.kmlejin.com/Uploads/Picture/20160317/s_a5aeb71653f9954f.jpg', '', '', '', '', '', '图尽可能', '', '', '100', '1', '3c5fdb68-a69f-4054-9dae-c1858fa9cd3f', '1463614121372');
INSERT INTO `tc_message` VALUES ('41', '20000017', 'nye', 'http://www.kmlejin.com/Uploads/Picture/20160428/s_4f012674b778f7a1.jpg', '', '20000000', '朱', 'http://www.kmlejin.com/Uploads/Picture/20160317/s_a5aeb71653f9954f.jpg', '', '', '', '', '', 'all one', '', '', '100', '1', '6a72206c-0ec1-4677-b388-d0c189460f65', '1463614131846');
INSERT INTO `tc_message` VALUES ('42', '20000017', 'nye', 'http://www.kmlejin.com/Uploads/Picture/20160428/s_4f012674b778f7a1.jpg', '', '20000000', '朱', 'http://www.kmlejin.com/Uploads/Picture/20160317/s_a5aeb71653f9954f.jpg', '', '', '', '', '', '天可怜见咯', '', '', '100', '1', '9f0d9905-897b-47b3-ba97-e2bd6378d563', '1463614408982');
INSERT INTO `tc_message` VALUES ('43', '20000000', '朱', 'http://www.kmlejin.com/Uploads/Picture/20160317/s_a5aeb71653f9954f.jpg', '', '20000017', 'nye', 'http://www.kmlejin.com/Uploads/Picture/20160428/s_4f012674b778f7a1.jpg', '', '', '', '', '', '慷慨解囊哦', '', '', '100', '1', 'c3e2ecdb-a054-41dd-8ed5-de5470576ea0', '1463614473121');
INSERT INTO `tc_message` VALUES ('44', '20000024', '哈哈', 'http://www.kmlejin.com/Uploads/Picture/20160428/s_e39aa9163cbe9bb0.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000010', '凯子', 'http://www.kmlejin.com/Uploads/Picture/20160518/s_afb80c52f74e74b6.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '我们', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'A161027E-E7A5-4D29-94FE-E8E81EE9B399', '1463650546281');
INSERT INTO `tc_message` VALUES ('45', '20000010', '凯子', 'http://www.kmlejin.com/Uploads/Picture/20160518/s_afb80c52f74e74b6.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000024', '哈哈', 'http://www.kmlejin.com/Uploads/Picture/20160428/s_e39aa9163cbe9bb0.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', 'Add', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '54DD2451-4685-4F61-84DD-5ED48EB9D746', '1463651438597');
INSERT INTO `tc_message` VALUES ('46', '20000010', '凯子', 'http://www.kmlejin.com/Uploads/Picture/20160518/s_afb80c52f74e74b6.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000024', '哈哈', 'http://www.kmlejin.com/Uploads/Picture/20160428/s_e39aa9163cbe9bb0.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', 'Ada', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'E47E94AA-6056-469D-8624-62494C1DC37A', '1463651450801');
INSERT INTO `tc_message` VALUES ('47', '20000010', '凯子', 'http://www.kmlejin.com/Uploads/Picture/20160518/s_afb80c52f74e74b6.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000024', '哈哈', 'http://www.kmlejin.com/Uploads/Picture/20160428/s_e39aa9163cbe9bb0.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '123123', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '6CE7BA8C-5813-4E52-901C-D15CF2542178', '1463651494645');
INSERT INTO `tc_message` VALUES ('48', '20000017', 'nye', 'http://www.kmlejin.com/Uploads/Picture/20160428/s_0b18450ac870edb7.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000000', '朱2', 'http://www.kmlejin.com/Uploads/Picture/20160519/s_f4cb7bdd6e1a291d.jpg', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'BA44E534-8CDB-45A9-8ED9-B940059474B2', '1463727477400');
INSERT INTO `tc_message` VALUES ('49', '20000017', 'nye', 'http://www.kmlejin.com/Uploads/Picture/20160428/s_0b18450ac870edb7.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000000', '朱2', 'http://www.kmlejin.com/Uploads/Picture/20160519/s_f4cb7bdd6e1a291d.jpg', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '何厚铧', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '5A6A8800-90A9-45A7-870E-1FF8273515E7', '1463727479767');
INSERT INTO `tc_message` VALUES ('50', '20000017', 'nye', 'http://www.kmlejin.com/Uploads/Picture/20160428/s_0b18450ac870edb7.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000000', '朱2', 'http://www.kmlejin.com/Uploads/Picture/20160519/s_f4cb7bdd6e1a291d.jpg', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '好怀念你', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'C91ECCE9-89FA-475C-9894-75C9C2DB05A2', '1463727482911');
INSERT INTO `tc_message` VALUES ('51', '20000000', '朱2', 'http://www.kmlejin.com/Uploads/Picture/20160519/s_f4cb7bdd6e1a291d.jpg', '', '20000017', 'nye', 'http://www.kmlejin.com/Uploads/Picture/20160428/s_0b18450ac870edb7.png', '', '', '', '', '', '3333', '', '', '100', '1', 'f15e488d-0e96-42a4-906e-4384a74ee01e', '1463727607223');
INSERT INTO `tc_message` VALUES ('52', '20000000', '朱2', 'http://www.kmlejin.com/Uploads/Picture/20160519/s_f4cb7bdd6e1a291d.jpg', '', '20000017', 'nye', 'http://www.kmlejin.com/Uploads/Picture/20160428/s_0b18450ac870edb7.png', '', '', '', '', '', 'fgh', '', '', '100', '1', 'fc1f0c51-4bae-45b3-b49b-64efae8e760c', '1463740118077');
INSERT INTO `tc_message` VALUES ('53', '20000025', '小刺猬', 'http://www.kmlejin.com/Uploads/Picture/20160429/s_2d16ed2a55304289.png', '', '20000002', 'A.L', 'http://www.kmlejin.com/Uploads/Picture/20160502/s_8e0e71199b07cb4e.jpg', '', '', '', '', '', '你好！', '', '', '100', '1', 'f2ee7db6-b73a-4de8-9e49-68cc9f2cb944', '1463807330790');
INSERT INTO `tc_message` VALUES ('54', '20000025', '小刺猬', 'http://www.kmlejin.com/Uploads/Picture/20160429/s_2d16ed2a55304289.png', '', '20000002', 'A.L', 'http://www.kmlejin.com/Uploads/Picture/20160502/s_8e0e71199b07cb4e.jpg', '', '', '', '', '', '在吗？', '', '', '100', '1', 'fb981f22-0625-4bb4-a63d-b21287dcfc0b', '1463807383064');
INSERT INTO `tc_message` VALUES ('55', '20000025', '小刺猬', 'http://www.kmlejin.com/Uploads/Picture/20160429/s_2d16ed2a55304289.png', '', '20000002', 'A.L', 'http://www.kmlejin.com/Uploads/Picture/20160502/s_8e0e71199b07cb4e.jpg', '', '', '', '', '', '[emoji_346][emoji_346][emoji_346]', '', '', '100', '1', '1aeefdef-6952-4be7-9447-90911d3dfcb7', '1463807465409');
INSERT INTO `tc_message` VALUES ('56', '20000017', 'nye', 'http://www.kmlejin.com/Uploads/Picture/20160428/s_0b18450ac870edb7.png', '', '20000000', '朱2', 'http://www.kmlejin.com/Uploads/Picture/20160519/s_f4cb7bdd6e1a291d.jpg', '', '', '', '', '', '他娟娟妈妈', '', '', '100', '1', '1000e7c8-d3c0-488d-a448-af3ec4149d27', '1463890548942');
INSERT INTO `tc_message` VALUES ('57', '20000041', 'biggirl', 'http://www.kmlejin.com/Uploads/Picture/20160613/s_db971425bcd06999.jpg', '', '20000002', 'A.L', 'http://www.kmlejin.com/Uploads/Picture/20160502/s_8e0e71199b07cb4e.jpg', '', '', '', '', '', '你是谁', '', '', '100', '1', 'e94ee624-0f7d-42fa-83ed-81742833380b', '1465771466778');
INSERT INTO `tc_message` VALUES ('58', '20000002', 'A.L', 'http://www.kmlejin.com/Uploads/Picture/20160502/s_8e0e71199b07cb4e.jpg', '', '20000041', 'biggirl', 'http://www.kmlejin.com/Uploads/Picture/20160613/s_db971425bcd06999.jpg', '', '', '', '', '', '？', '', '', '100', '1', '793bbc7f-408b-4535-a188-2ac5ba986c3e', '1465790067484');
INSERT INTO `tc_message` VALUES ('59', '20000051', '荣', 'http://www.kmlejin.com/Uploads/Picture/20160619/s_e9463a53e1570ec6.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000045', '美女', 'http://www.kmlejin.com/Uploads/Picture/20160615/s_5c3f5e81c6a295f3.jpg', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '你好', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '9B923E33-13B6-4BB8-B215-BFA02330F39C', '1466268548702');
INSERT INTO `tc_message` VALUES ('60', '20000051', '荣', 'http://www.kmlejin.com/Uploads/Picture/20160619/s_e9463a53e1570ec6.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000045', '美女', 'http://www.kmlejin.com/Uploads/Picture/20160615/s_5c3f5e81c6a295f3.jpg', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '[emoji_85]', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '49169A3F-2D5D-4C52-AB1B-DC5CD6CE42A2', '1466269450020');
INSERT INTO `tc_message` VALUES ('61', '20000056', 'Captain', 'http://www.kmlejin.com/Uploads/Picture/20160624/s_2a2a97ea533ad41b.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000000', '朱2', 'http://www.kmlejin.com/Uploads/Picture/20160519/s_f4cb7bdd6e1a291d.jpg', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '8E6739BE-3C72-4534-B786-818E4F411D77', '1466757161713');
INSERT INTO `tc_message` VALUES ('62', '20000089', '她说', 'http://www.kmlejin.com/Uploads/Picture/20160811/s_781b3ef54e18f903.jpeg', '', '20000090', 'dl', 'http://www.kmlejin.com/Uploads/Picture/20160811/s_8c22c1e621ddddd5.png', '', '', '', '', '', '哈哈哈哈哈[emoji_341]', '', '', '100', '1', '31e3e727-3e8f-4590-87a4-ca4139494370', '1470897583853');
INSERT INTO `tc_message` VALUES ('63', '20000090', 'dl', 'http://www.kmlejin.com/Uploads/Picture/20160811/s_8c22c1e621ddddd5.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000089', '她说', 'http://www.kmlejin.com/Uploads/Picture/20160811/s_781b3ef54e18f903.jpeg', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '滔滔汩汩', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '324AF65A-5109-4876-9C05-EC78E5CC167C', '1470898609141');
INSERT INTO `tc_message` VALUES ('64', '20000090', 'dl', 'http://www.kmlejin.com/Uploads/Picture/20160811/s_8c22c1e621ddddd5.png', '', '20000089', '她说', 'http://www.kmlejin.com/Uploads/Picture/20160811/s_781b3ef54e18f903.jpeg', '', '', '', '', '', '骨头汤', '', '', '100', '1', '70ddefa3-77bb-4469-81b8-70299ef77d56', '1470898892571');
INSERT INTO `tc_message` VALUES ('65', '20000090', 'dl', 'http://www.kmlejin.com/Uploads/Picture/20160811/s_8c22c1e621ddddd5.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000089', '她说', 'http://www.kmlejin.com/Uploads/Picture/20160811/s_781b3ef54e18f903.jpeg', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', 'hi', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'CBB93F19-4864-4F53-A44C-03174B7AB11B', '1470899257868');
INSERT INTO `tc_message` VALUES ('66', '20000090', 'dl', 'http://www.kmlejin.com/Uploads/Picture/20160811/s_8c22c1e621ddddd5.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000089', '她说', 'http://www.kmlejin.com/Uploads/Picture/20160811/s_781b3ef54e18f903.jpeg', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '[emoji_344][emoji_353][emoji_352][emoji_351]1456）', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '804DAC78-CA6D-42F1-8795-8DC4A831BBD5', '1470899283684');
INSERT INTO `tc_message` VALUES ('67', '20000090', 'dl', 'http://www.kmlejin.com/Uploads/Picture/20160811/s_8c22c1e621ddddd5.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000089', '她说', 'http://www.kmlejin.com/Uploads/Picture/20160811/s_781b3ef54e18f903.jpeg', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '[emoji_86][emoji_343][emoji_351]1245', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '0ECE625F-7312-4898-A529-B10DAD04ECDB', '1470899294323');
INSERT INTO `tc_message` VALUES ('68', '20000090', 'dl', 'http://www.kmlejin.com/Uploads/Picture/20160811/s_8c22c1e621ddddd5.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000089', '她说', 'http://www.kmlejin.com/Uploads/Picture/20160811/s_781b3ef54e18f903.jpeg', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '[emoji_351][emoji_11]法国 vv', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '6441A50B-7016-4A67-9CD9-7C7348EC79C2', '1470899314997');
INSERT INTO `tc_message` VALUES ('69', '20000090', 'dl', 'http://www.kmlejin.com/Uploads/Picture/20160811/s_8c22c1e621ddddd5.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000089', '她说', 'http://www.kmlejin.com/Uploads/Picture/20160811/s_781b3ef54e18f903.jpeg', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '复古会发光[emoji_343][emoji_343][emoji_94]', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'B595BA69-C75A-4DCE-93A4-9FE2791A4F29', '1470899321834');
INSERT INTO `tc_message` VALUES ('70', '20000090', 'dl', 'http://www.kmlejin.com/Uploads/Picture/20160811/s_8c22c1e621ddddd5.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000089', '她说', 'http://www.kmlejin.com/Uploads/Picture/20160811/s_781b3ef54e18f903.jpeg', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '肉肉肉肉[emoji_87][emoji_343][emoji_344]', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'D68AD597-7F4C-4F61-926D-A12E34D4E53A', '1470899355917');
INSERT INTO `tc_message` VALUES ('71', '20000090', 'dl', 'http://www.kmlejin.com/Uploads/Picture/20160811/s_8c22c1e621ddddd5.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000089', '她说', 'http://www.kmlejin.com/Uploads/Picture/20160811/s_781b3ef54e18f903.jpeg', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '[emoji_352][emoji_353][emoji_353]以及', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'D632FF8E-3E52-40C2-B6B3-1398A81FE56C', '1470899368345');
INSERT INTO `tc_message` VALUES ('72', '20000089', '她说', 'http://www.kmlejin.com/Uploads/Picture/20160811/s_781b3ef54e18f903.jpeg', '', '20000090', 'dl', 'http://www.kmlejin.com/Uploads/Picture/20160811/s_8c22c1e621ddddd5.png', '', '', '', '', '', '[emoji_345][emoji_353][emoji_353][emoji_353]DC重新', '', '', '100', '1', '3e4d4ec5-e411-4430-9645-e8354c3462a1', '1470899403387');
INSERT INTO `tc_message` VALUES ('73', '20000090', 'dl', 'http://www.kmlejin.com/Uploads/Picture/20160811/s_8c22c1e621ddddd5.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000089', '她说', 'http://www.kmlejin.com/Uploads/Picture/20160811/s_781b3ef54e18f903.jpeg', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '[emoji_183]', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '901D586C-0A40-407B-BF13-CC2924363D1D', '1470899454448');
INSERT INTO `tc_message` VALUES ('74', '20000090', 'dl', 'http://www.kmlejin.com/Uploads/Picture/20160811/s_8c22c1e621ddddd5.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000089', '她说', 'http://www.kmlejin.com/Uploads/Picture/20160811/s_781b3ef54e18f903.jpeg', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '[emoji_47]', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'C0C5D6EB-35C8-4847-B22B-A70A3FE6968B', '1470899466753');
INSERT INTO `tc_message` VALUES ('75', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '', '', '', '', '[emoji_85][emoji_85]', '', '', '100', '1', '505b6cd6-aeda-4b1f-8f3e-7bc33b8f126e', '1471007385688');
INSERT INTO `tc_message` VALUES ('76', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '', '', '', '', '看到没', '', '', '100', '1', 'daac0197-75cc-492c-9ff5-a025b0b81c58', '1471007398420');
INSERT INTO `tc_message` VALUES ('77', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '', '', '', '', '嗯', '', '', '100', '1', '35527419-ba21-4bfc-8ac8-fc26b9ce0eea', '1471007405315');
INSERT INTO `tc_message` VALUES ('78', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '', '', '', '', '[emoji_100]', '', '', '100', '1', '2381fe5e-d652-4bef-84d0-f670d1007a0b', '1471007726015');
INSERT INTO `tc_message` VALUES ('79', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '', '', '', '', '找到了', '', '', '100', '1', 'af4683ca-717c-4a22-b6ac-44fec9a240e6', '1471007735701');
INSERT INTO `tc_message` VALUES ('80', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '', '', '', '', '关注哦', '', '', '100', '1', '15ca4d37-2175-452e-bc25-9fa864dad46c', '1471007748259');
INSERT INTO `tc_message` VALUES ('81', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '', '', '', '', '嗯', '', '', '100', '1', '4048c484-67b8-459c-8fea-98b4eb1a5215', '1471007753928');
INSERT INTO `tc_message` VALUES ('82', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '', '', '', '', '我不给你发信息你去哪找', '', '', '100', '1', '170deceb-3e07-49b9-8948-6f8732f726d5', '1471007767560');
INSERT INTO `tc_message` VALUES ('83', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '', '', '', '', '在私信里面', '', '', '100', '1', '1c8c0815-1c6c-4c41-81e0-dafa5a8c5621', '1471007783441');
INSERT INTO `tc_message` VALUES ('84', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '', '', '', '', '嗯', '', '', '100', '1', '1dfca2c5-6d3e-4ac3-8f48-6770d7c40bd2', '1471007791368');
INSERT INTO `tc_message` VALUES ('85', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '', '', '', '', '猪', '', '', '100', '1', 'ab06ab57-1984-4d00-bd0d-b60e1534469c', '1471007800620');
INSERT INTO `tc_message` VALUES ('86', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '', '', '', '', '你个猪', '', '', '100', '1', '7b5e2910-d0e4-4899-84ff-510c3f7c27b9', '1471007902910');
INSERT INTO `tc_message` VALUES ('87', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '', '', '', '', '哈哈', '', '', '100', '1', '9bfd2c93-4564-4961-8247-f316c0977fc4', '1471007912454');
INSERT INTO `tc_message` VALUES ('88', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '', '', '', '', '你有号里', '', '', '100', '1', '04fac7a8-f29b-481b-87eb-12a0ffd4ee5a', '1471007942337');
INSERT INTO `tc_message` VALUES ('89', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '', '', '', '', '20000091', '', '', '100', '1', 'b32d5aa8-8559-4ac1-b91d-d47150110ccf', '1471007970743');
INSERT INTO `tc_message` VALUES ('90', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '', '', '', '', '也是刚申请的', '', '', '100', '1', '9990a96d-9e5c-446a-b94c-58407f1860fe', '1471007980229');
INSERT INTO `tc_message` VALUES ('91', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '', '', '', '', '我有吧', '', '', '100', '1', '6fb3e09a-f5e8-4d1b-a651-29996c6117dc', '1471007991105');
INSERT INTO `tc_message` VALUES ('92', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '', '', '', '', '么得', '', '', '100', '1', 'ffb0287f-688d-4cee-975a-64739c1c816a', '1471008009871');
INSERT INTO `tc_message` VALUES ('93', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '', '', '', '', '好吧', '', '', '100', '1', '732b93a9-a68c-486b-abe9-885f8fe77bbb', '1471008018455');
INSERT INTO `tc_message` VALUES ('94', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '', '', '', '', '你长的比较好看才有里吧', '', '', '100', '1', '362bd3f8-0fb0-49cb-a2b0-ebbcd6bed07e', '1471008044304');
INSERT INTO `tc_message` VALUES ('95', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '', '', '', '', '我长的难看就\'没的', '', '', '100', '1', '59c0e910-dd25-4434-9046-ba301c238f9c', '1471008057703');
INSERT INTO `tc_message` VALUES ('96', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '', '', '', '', '可能', '', '', '100', '1', 'dc84c713-4318-4ec8-a4af-6c422c89f397', '1471008121031');
INSERT INTO `tc_message` VALUES ('97', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '', '', '', '', '得瑟', '', '', '100', '1', '8d46a6ea-40ab-4bd7-9a06-0bab295edab6', '1471008127330');
INSERT INTO `tc_message` VALUES ('98', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '', '', '', '', '哈哈，他人了', '', '', '100', '1', 'a44c3df6-c81b-41ad-aee2-0e7794c29313', '1471008158395');
INSERT INTO `tc_message` VALUES ('99', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '', '', '', '', '我弄名字里 不知道用啥呀 刚好毛看的熊出没 开始了 名叫大力士', '', '', '100', '1', 'e66d1de7-0f1c-49ed-8497-9e0d522bee00', '1471008182503');
INSERT INTO `tc_message` VALUES ('100', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '', '', '', '', '在里', '', '', '100', '1', 'e6989c6a-e136-4e5d-9a64-6bd7ba0be01c', '1471008190110');
INSERT INTO `tc_message` VALUES ('101', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '', '', '', '', '嗯嗯，猪，在看电视吗', '', '', '100', '1', '1cb6bdcb-9d22-4184-af73-1423d3a4629e', '1471008220296');
INSERT INTO `tc_message` VALUES ('102', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '', '', '', '', '是的', '', '', '100', '1', 'a4adb2a8-6e1d-49b3-831c-24feacd2ff10', '1471008227106');
INSERT INTO `tc_message` VALUES ('103', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '', '', '', '', '哦哦，那你还耍手机', '', '', '100', '1', '5df113a2-3c1d-49d7-9c57-7f2ab11a4457', '1471008269326');
INSERT INTO `tc_message` VALUES ('104', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '', '', '', '', '没事', '', '', '100', '1', '0505d5e1-cab5-4bc6-8dd0-24455aaa58e2', '1471008276774');
INSERT INTO `tc_message` VALUES ('105', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '', '', '', '', '哦', '', '', '100', '1', 'ec5173d7-0fd1-4568-b477-4513ca02d0fa', '1471008282742');
INSERT INTO `tc_message` VALUES ('106', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '', '', '', '', '我旁边坐里', '', '', '100', '1', '5ef334a5-4085-40e3-909a-fe7fdf9e8f12', '1471008284457');
INSERT INTO `tc_message` VALUES ('107', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '', '', '', '', '那等会聊', '', '', '100', '1', 'eba41194-4c2f-428c-8388-79e777c173b6', '1471008402596');
INSERT INTO `tc_message` VALUES ('108', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '', '', '', '', '没事', '', '', '100', '1', '81d0a362-582c-49d4-8bc2-ad7b890e923d', '1471008411340');
INSERT INTO `tc_message` VALUES ('109', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '', '', '', '', '他也在耍手机里', '', '', '100', '1', '1512d97a-6f10-468d-b7ef-0d1e31599377', '1471008431244');
INSERT INTO `tc_message` VALUES ('110', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '', '', '', '', '照片不能发', '', '', '100', '1', '819199f7-2061-4e54-aae7-67c03335d49b', '1471008590225');
INSERT INTO `tc_message` VALUES ('111', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '', '', '', '', '是的', '', '', '100', '1', '80e11cb1-3880-4d7e-8f98-2d9b52b33661', '1471008600957');
INSERT INTO `tc_message` VALUES ('112', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '', '', '', '', '也在聊女女', '', '', '100', '1', '9e9385d5-de4a-4f78-b997-352e43d3fcd0', '1471008614214');
INSERT INTO `tc_message` VALUES ('113', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '', '', '', '', '不知道', '', '', '100', '1', '2863892e-8008-405d-9168-5464d2d9d05e', '1471008673256');
INSERT INTO `tc_message` VALUES ('114', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '', '', '', '', '看哈去', '', '', '100', '1', '0f77a5ed-80cc-408b-aff0-5c537f0a02b3', '1471008682022');
INSERT INTO `tc_message` VALUES ('115', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '', '', '', '', '不看', '', '', '100', '1', '4178b67a-8361-463b-801b-e4a1e84624a7', '1471008686630');
INSERT INTO `tc_message` VALUES ('116', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '', '', '', '', '今一中午一会再看，一会在看', '', '', '100', '1', '97f33247-80aa-43dd-b93e-6a435f0c8553', '1471008712796');
INSERT INTO `tc_message` VALUES ('117', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '', '', '', '', '哦哦 管他的来', '', '', '100', '1', 'd44e54c3-1eed-4b51-aa9e-56c894943c95', '1471008898760');
INSERT INTO `tc_message` VALUES ('118', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '', '', '', '', '我发了几张图你看看用哪个做头像', '', '', '100', '1', '64a8de43-2736-49cd-b160-a5b9ef4f003a', '1471008919230');
INSERT INTO `tc_message` VALUES ('119', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '', '', '', '', '哪里', '', '', '100', '1', '9f53ed88-264a-4990-8fba-aad9e8353788', '1471008951391');
INSERT INTO `tc_message` VALUES ('120', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '', '', '', '', '空间', '', '', '100', '1', '4c750a72-8adc-4659-939f-95be2805d6a4', '1471008967268');
INSERT INTO `tc_message` VALUES ('121', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '', '', '', '', '好', '', '', '100', '1', 'bf287484-cd55-431a-83ec-06d389ee021a', '1471008977556');
INSERT INTO `tc_message` VALUES ('122', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '', '', '', '', '找不到', '', '', '100', '1', '1dbc9979-7708-4caa-8b49-66c76b7468a6', '1471009034589');
INSERT INTO `tc_message` VALUES ('123', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '', '', '', '', '又发了一张', '', '', '100', '1', '8e276d69-7fc7-4c19-9aa6-3ca4d9b901bf', '1471009060657');
INSERT INTO `tc_message` VALUES ('124', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '', '', '', '', '找不到', '', '', '100', '1', '83533c8b-c9fe-40ed-b34b-176d8f6416e4', '1471009069419');
INSERT INTO `tc_message` VALUES ('125', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '', '', '', '', '猪一头', '', '', '100', '1', 'c7e0f586-89ea-49ff-89aa-d4677d61acda', '1471009077137');
INSERT INTO `tc_message` VALUES ('126', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '', '', '', '', '就在  消息 空间 我的', '', '', '100', '1', '0445df17-93b4-4b43-bbb6-a38e7bfda5a7', '1471009096697');
INSERT INTO `tc_message` VALUES ('127', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '', '', '', '', '点空间', '', '', '100', '1', '36457c51-b448-43ae-89a5-eb4119540f3e', '1471009103220');
INSERT INTO `tc_message` VALUES ('128', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '', '', '', '', '嗯', '', '', '100', '1', '25f37a0a-7c01-48c5-9871-035db5818507', '1471009110891');
INSERT INTO `tc_message` VALUES ('129', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '', '', '', '', '没有', '', '', '100', '1', '226cfa4f-2f7b-4421-8001-ab1343cba12f', '1471009186443');
INSERT INTO `tc_message` VALUES ('130', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '', '', '', '', '瓜皮', '', '', '100', '1', '2334d116-0d22-4c81-93a3-859774ec66a2', '1471009261901');
INSERT INTO `tc_message` VALUES ('131', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '', '', '', '', '你才是', '', '', '100', '1', '5b6667b6-474c-4afc-92f5-9e3d70d24d62', '1471009272513');
INSERT INTO `tc_message` VALUES ('132', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '', '', '', '', '看淘宝信息', '', '', '100', '1', '11d11322-12af-4ac1-80d0-2289e1f96746', '1471009309777');
INSERT INTO `tc_message` VALUES ('133', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '', '', '', '', '看了，', '', '', '100', '1', '2ce43a1f-7958-49c0-ae9f-ee42e90ce4ca', '1471009349984');
INSERT INTO `tc_message` VALUES ('134', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '', '', '', '', '用这个挺好', '', '', '100', '1', '9be1c01c-da24-4fad-959d-9d9840849b2d', '1471009358692');
INSERT INTO `tc_message` VALUES ('135', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '', '', '', '', '好吧', '', '', '100', '1', '74f24121-bd35-45b9-a804-e0177c53c0cd', '1471009372837');
INSERT INTO `tc_message` VALUES ('136', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '', '', '', '', '刚才想说啥呀 突然给忘了', '', '', '100', '1', '5383ba2b-a326-40db-9a5b-6a02a1a0579c', '1471009412019');
INSERT INTO `tc_message` VALUES ('137', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '', '', '', '', '嗯嗯', '', '', '100', '1', 'd6a90acb-adf3-497d-a451-eeda1c830f73', '1471009415166');
INSERT INTO `tc_message` VALUES ('138', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '', '', '', '', '撒', '', '', '100', '1', '5dfd5386-9894-40a5-b696-1c2c39c08be4', '1471009421885');
INSERT INTO `tc_message` VALUES ('139', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '', '', '', '', '我也忘了', '', '', '100', '1', '92b50bfd-b489-4543-a2bf-cc8cde4b60a8', '1471009429167');
INSERT INTO `tc_message` VALUES ('140', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '', '', '', '', '猪', '', '', '100', '1', 'c382e0af-824b-476d-8d32-a83a69c92d8e', '1471009438445');
INSERT INTO `tc_message` VALUES ('141', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '', '', '', '', '这聊天记录删不了呀', '', '', '100', '1', '6be4d5ef-f4ff-43b9-a1a1-585bd8c34d2f', '1471009464695');
INSERT INTO `tc_message` VALUES ('142', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '', '', '', '', '不知道', '', '', '100', '1', 'd9137d22-f2cf-43cc-b6d5-d6839dd6b2a2', '1471009501663');
INSERT INTO `tc_message` VALUES ('143', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '', '', '', '', '不得行', '', '', '100', '1', 'e4edf64c-5a06-457e-8129-999de7d7c00e', '1471009510509');
INSERT INTO `tc_message` VALUES ('144', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '', '', '', '', '那就不删了', '', '', '100', '1', '6610fd71-d28a-4fe9-ac61-f92bcc6c2085', '1471009537628');
INSERT INTO `tc_message` VALUES ('145', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '', '', '', '', '嗯嗯', '', '', '100', '1', '27e4e8c5-ad27-4188-93d3-1dd04bd32644', '1471009601408');
INSERT INTO `tc_message` VALUES ('146', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '', '', '', '', '等会他睡了聊', '', '', '100', '1', '9ea04c53-b957-4131-bbb5-883af85364d5', '1471009660158');
INSERT INTO `tc_message` VALUES ('147', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '', '', '', '', '不', '', '', '100', '1', '8bdbe2c2-8f8f-47c5-b9b1-30e240a3098e', '1471009729775');
INSERT INTO `tc_message` VALUES ('148', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '', '', '', '', '我想你', '', '', '100', '1', '1b6ccc31-f0e8-4311-b868-65e2bcf07e8e', '1471009735022');
INSERT INTO `tc_message` VALUES ('149', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '', '', '', '', '我也想', '', '', '100', '1', 'd31a673b-8f93-43c5-85fd-20fd7eb750b1', '1471009791650');
INSERT INTO `tc_message` VALUES ('150', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '', '', '', '', '爱你的心从未停止过', '', '', '100', '1', 'b155c3f0-0ead-441d-83fc-cbdccda7bff0', '1471009870337');
INSERT INTO `tc_message` VALUES ('151', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '', '', '', '', '嗯嗯', '', '', '100', '1', 'a8249819-f8f0-4d6c-bb32-dc30dd45a130', '1471009910256');
INSERT INTO `tc_message` VALUES ('152', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '', '', '', '', '你的个性签名都没写', '', '', '100', '1', 'd870c74e-5b5c-4427-921b-792b916f0589', '1471009929760');
INSERT INTO `tc_message` VALUES ('153', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '', '', '', '', '没有', '', '', '100', '1', 'e7b6ac3e-c3bd-44ec-99aa-cdd318dfaa87', '1471010007817');
INSERT INTO `tc_message` VALUES ('154', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '', '', '', '', '嗯嗯', '', '', '100', '1', '636c235b-df09-42d6-abdc-3d7e3bdc1b4d', '1471010167652');
INSERT INTO `tc_message` VALUES ('155', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '', '', '', '', '猪一样', '', '', '100', '1', '31649e55-937c-4441-88f8-5a0482e31b1b', '1471010190050');
INSERT INTO `tc_message` VALUES ('156', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '', '', '', '', '你才是', '', '', '100', '1', 'f4aa0363-6959-4200-9332-10f7fd578cd2', '1471010199422');
INSERT INTO `tc_message` VALUES ('157', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '', '', '', '', '他中午也没问我', '', '', '100', '1', '2d3e6336-041f-4634-9eec-8a55c2941179', '1471010219470');
INSERT INTO `tc_message` VALUES ('158', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '', '', '', '', '我的头像表示是你和', '', '', '100', '1', '5e7a2dfc-ae02-4384-adb2-3ec1cee3079c', '1471010221418');
INSERT INTO `tc_message` VALUES ('159', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '', '', '', '', '嗯嗯', '', '', '100', '1', '891e2a2c-9a70-4526-a3ab-48f6ec859235', '1471010231225');
INSERT INTO `tc_message` VALUES ('160', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '', '', '', '', '心里知道了吧', '', '', '100', '1', '3652484e-81ee-4618-9025-b7a851f46dd3', '1471010232179');
INSERT INTO `tc_message` VALUES ('161', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '', '', '', '', '我不知道', '', '', '100', '1', 'dcdc5d43-add4-40f7-8a3e-e1ae08275a48', '1471010240095');
INSERT INTO `tc_message` VALUES ('162', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '', '', '', '', '说话正常里吧', '', '', '100', '1', '2747b40c-7414-44ae-a352-2e6639b0406d', '1471010280144');
INSERT INTO `tc_message` VALUES ('163', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '', '', '', '', '嗯', '', '', '100', '1', '32bc97d1-c096-4285-9f10-8ff57e2b6e88', '1471010318411');
INSERT INTO `tc_message` VALUES ('164', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '', '', '', '', '那不会怀疑你', '', '', '100', '1', '8197d12e-a707-4f28-9bca-8cf66977bfaf', '1471010365535');
INSERT INTO `tc_message` VALUES ('165', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '', '', '', '', '没事我不怕', '', '', '100', '1', 'cb2ff592-f94d-40fe-99bb-6f49997f4934', '1471010388895');
INSERT INTO `tc_message` VALUES ('166', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '', '', '', '', '这聊天记录不删有问题里', '', '', '100', '1', 'd59e65b7-1f9c-4463-a777-10813cd9de24', '1471010394585');
INSERT INTO `tc_message` VALUES ('167', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '', '', '', '', '一看就知道', '', '', '100', '1', '74c10b27-c7cf-4fa2-92c8-eae3c5f3a308', '1471010402804');
INSERT INTO `tc_message` VALUES ('168', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '', '', '', '', '是吧', '', '', '100', '1', 'af19c331-ef90-4f46-a75e-af0c5a7d21f5', '1471010404581');
INSERT INTO `tc_message` VALUES ('169', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '', '', '', '', '不怕啥', '', '', '100', '1', 'b9f7948c-464d-4a71-bfb8-c2986edb3b86', '1471010415591');
INSERT INTO `tc_message` VALUES ('170', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '', '', '', '', '那你看还有撒聊天软件', '', '', '100', '1', '58259c64-4ea8-4e62-8859-a335ce05da80', '1471010418198');
INSERT INTO `tc_message` VALUES ('171', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '', '', '', '', '就算怀疑也不怕', '', '', '100', '1', '367cd849-7297-4257-b156-dd383caf30e1', '1471010436104');
INSERT INTO `tc_message` VALUES ('172', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '', '', '', '', '万一他说出来 你们屋知道了', '', '', '100', '1', 'bf388ab8-b2a5-4385-9c24-d941c2cd2824', '1471010444822');
INSERT INTO `tc_message` VALUES ('173', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '', '', '', '', '她才闹腾呀', '', '', '100', '1', '4dd3cf31-4be4-4136-b806-13d0830490ab', '1471010465418');
INSERT INTO `tc_message` VALUES ('174', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '', '', '', '', '没事，就发个信息能证明撒', '', '', '100', '1', '05cad1b0-b5da-42df-b1bc-16713e782326', '1471010470504');
INSERT INTO `tc_message` VALUES ('175', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '', '', '', '', '嗯嗯', '', '', '100', '1', '80d34920-aded-443e-b450-f09299e60321', '1471010480256');
INSERT INTO `tc_message` VALUES ('176', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '', '', '', '', '猪一样', '', '', '100', '1', '06830632-dfe3-4c6f-a901-02b587235143', '1471010495449');
INSERT INTO `tc_message` VALUES ('177', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '', '', '', '', '易信', '', '', '100', '1', 'd5e96380-7ccf-4f80-bf3e-6f90040c6ca6', '1471010855860');
INSERT INTO `tc_message` VALUES ('178', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '', '', '', '', '好', '', '', '100', '1', 'fcb5356f-9a6e-4547-ad67-9c725b0bf141', '1471010876500');
INSERT INTO `tc_message` VALUES ('179', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '', '', '', '', '下了吧', '', '', '100', '1', '3a6ba91d-03a6-4701-b495-4418063ef039', '1471011036783');
INSERT INTO `tc_message` VALUES ('180', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '', '', '', '', '马上', '', '', '100', '1', '5c1026c6-16b1-423d-a471-32dc03ec9a16', '1471011075071');
INSERT INTO `tc_message` VALUES ('181', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '', '', '', '', '完了', '', '', '100', '1', '945b4deb-44b0-4f51-8aaf-52b1d62ca9e0', '1471011076478');
INSERT INTO `tc_message` VALUES ('182', '20000092', '大力士', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', '', '20000091', '一如既往', 'http://www.kmlejin.com/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', '', '', '', '', '', '嗯', '', '', '100', '1', '299d0891-20a9-499b-9a99-5046e5585240', '1471011081467');
INSERT INTO `tc_message` VALUES ('183', '20000000', '朱2', '', '', '20000001', '朱', 'http://www.kmlejin.com/Uploads/Picture/20160714/s_e341709f41aadecd.jpg', '', '', '', '', '', '娟娟妈妈', '', '', '100', '1', 'ae1de955-909a-4129-99a2-d5ebc2b87017', '1471858127709');
INSERT INTO `tc_message` VALUES ('184', '20000000', '朱2', '', '', '20000001', '朱', 'http://www.kmlejin.com/Uploads/Picture/20160714/s_e341709f41aadecd.jpg', '', '', '', '', '', '涂抹面膜', '', '', '100', '1', 'e64454e4-b44e-4248-bfe8-7eabe6781870', '1471858131253');
INSERT INTO `tc_message` VALUES ('185', '20000017', 'nye', 'http://www.kmlejin.com/Uploads/Picture/20160428/s_0b18450ac870edb7.png', '', '20000002', 'A≠L✨', 'http://www.kmlejin.com/Uploads/Picture/20160502/s_8e0e71199b07cb4e.jpg', '', '', '', '', '', 'hi[emoji_86]', '', '', '100', '1', '3421870f-fca5-4fb7-995f-bbf8de39709b', '1473666602789');
INSERT INTO `tc_message` VALUES ('186', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160919/s_cd07877970f7eff5.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000025', '小刺猬', 'http://www.kmlejin.com/Uploads/Picture/20160429/s_2d16ed2a55304289.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', 'n', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '418F0D31-E35F-4E05-AE9E-0AB99D49E125', '1474270002214');
INSERT INTO `tc_message` VALUES ('187', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160919/s_cd07877970f7eff5.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000025', '小刺猬', 'http://www.kmlejin.com/Uploads/Picture/20160429/s_2d16ed2a55304289.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', 'n', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'B60A0818-41D9-422B-85D3-D4A4CA4789D2', '1474270006913');
INSERT INTO `tc_message` VALUES ('188', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160919/s_cd07877970f7eff5.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000115', 'lo', 'http://www.kmlejin.com/Uploads/Picture/20160913/s_0cd0699b84ae7971.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', 'mo', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '5EBB13B5-B178-4E38-9679-5B74EC885226', '1474270099809');
INSERT INTO `tc_message` VALUES ('189', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160919/s_cd07877970f7eff5.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000115', 'lo', 'http://www.kmlejin.com/Uploads/Picture/20160913/s_0cd0699b84ae7971.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '摸噢lll', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'C2DCBAA0-B0D9-43D3-A518-DFAC2FE0578F', '1474270105889');
INSERT INTO `tc_message` VALUES ('190', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160919/s_cd07877970f7eff5.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000115', 'lo', 'http://www.kmlejin.com/Uploads/Picture/20160913/s_0cd0699b84ae7971.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '[emoji_353][emoji_345][emoji_344][emoji_351][emoji_344]', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '70540DDA-EC23-4DC5-91D8-87838F48A32C', '1474270110453');
INSERT INTO `tc_message` VALUES ('191', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160919/s_cd07877970f7eff5.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000115', 'lo', 'http://www.kmlejin.com/Uploads/Picture/20160913/s_0cd0699b84ae7971.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '这xyxxyy', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '0CEE94AE-28B7-4CE6-86F0-C2B80B8E3A4F', '1474270124683');
INSERT INTO `tc_message` VALUES ('192', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160919/s_cd07877970f7eff5.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000115', 'lo', 'http://www.kmlejin.com/Uploads/Picture/20160913/s_0cd0699b84ae7971.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '阿里l', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'AC8DB325-B0C1-4264-9264-236ABD5C11A6', '1474270151362');
INSERT INTO `tc_message` VALUES ('193', '20000115', 'lo', 'http://www.kmlejin.com/Uploads/Picture/20160913/s_0cd0699b84ae7971.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160919/s_cd07877970f7eff5.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', ' ', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '9AB1126F-875C-4992-9EC1-00DA4FA16854', '1474276754641');
INSERT INTO `tc_message` VALUES ('194', '20000115', 'lo', 'http://www.kmlejin.com/Uploads/Picture/20160913/s_0cd0699b84ae7971.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160919/s_cd07877970f7eff5.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '326284A9-D1F3-4714-832C-56F3BEE9EE4C', '1474276780012');
INSERT INTO `tc_message` VALUES ('195', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160921/s_ee13ef429e7855b0.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000115', 'lo', 'http://www.kmlejin.com/Uploads/Picture/20160913/s_0cd0699b84ae7971.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '[emoji_86][emoji_342]54', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'F81E5E67-63B2-475E-AD7B-13DAFF1C547E', '1474785176706');
INSERT INTO `tc_message` VALUES ('196', '20000115', 'lo', 'http://www.kmlejin.com/Uploads/Picture/20160913/s_0cd0699b84ae7971.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160921/s_ee13ef429e7855b0.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '123456789', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '545B5A0F-A760-4E6A-99A1-92B34EEDB890', '1475976633138');
INSERT INTO `tc_message` VALUES ('197', '20000115', 'lo', 'http://www.kmlejin.com/Uploads/Picture/20160913/s_0cd0699b84ae7971.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160921/s_ee13ef429e7855b0.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '[emoji_87]', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '92198D77-469B-482A-8608-859B1AAB9BF5', '1475976635587');
INSERT INTO `tc_message` VALUES ('198', '20000115', 'lo', 'http://www.kmlejin.com/Uploads/Picture/20160913/s_0cd0699b84ae7971.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160921/s_ee13ef429e7855b0.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '[emoji_96]', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '9E499F85-C356-4171-AA5C-0F63FF2CAC49', '1475976639102');
INSERT INTO `tc_message` VALUES ('199', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160930/s_1a8178e7a50996ec.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000090', 'dl', '', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '末', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'BA4BAD16-A833-4825-A138-5FDEC16FFA4F', '1476081681145');
INSERT INTO `tc_message` VALUES ('200', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160930/s_1a8178e7a50996ec.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000090', 'dl', '', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '[emoji_352][emoji_351][emoji_351]', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'FADE9B5A-833A-4926-89C2-73E9FB36B4BF', '1476081695985');
INSERT INTO `tc_message` VALUES ('201', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160930/s_1a8178e7a50996ec.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000090', 'dl', '', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '[emoji_352][emoji_351][emoji_350][emoji_350]', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'FD47EC63-8E23-476A-9557-8C19B7736529', '1476081701743');
INSERT INTO `tc_message` VALUES ('202', '20000090', 'dl', '', '', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160930/s_1a8178e7a50996ec.png', '', '', '', '', '', '你再写群聊了嘛', '', '', '100', '1', '21230ced-2611-480c-8514-13bc549df31a', '1476082142317');
INSERT INTO `tc_message` VALUES ('203', '20000090', 'dl', '', '', '20000089', '她说', 'http://120.24.61.200/lejin/Uploads/Picture/20160811/s_781b3ef54e18f903.jpeg', '', '', '', '', '', '不过关哈哈哈哈', '', '', '100', '1', 'f073dd29-3684-4eb9-931e-43232f15a2b6', '1476242583073');
INSERT INTO `tc_message` VALUES ('204', '20000090', 'dl', '', '', '20000089', '她说', 'http://120.24.61.200/lejin/Uploads/Picture/20160811/s_781b3ef54e18f903.jpeg', '', '', '', '', '', '哈哈哈', '', '', '100', '1', '36cc706e-4aea-43f6-a6c2-628b22622e7b', '1476244150869');
INSERT INTO `tc_message` VALUES ('205', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160930/s_1a8178e7a50996ec.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000002', 'A≠L✨', 'http://www.kmlejin.com/Uploads/Picture/20160502/s_8e0e71199b07cb4e.jpg', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '不', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '4B279E84-60BA-4DF8-A297-A433AF396942', '1476245348945');
INSERT INTO `tc_message` VALUES ('206', '20000090', 'dl', '', '', '20000001', '朱', 'http://120.24.61.200/lejin/Uploads/Picture/20160714/s_e341709f41aadecd.jpg', '', '', '', '', '', '反反复复', '', '', '100', '1', '18585be8-581b-4be1-87a6-5222e2371d18', '1476251816003');
INSERT INTO `tc_message` VALUES ('207', '20000001', '朱', 'http://120.24.61.200/lejin/Uploads/Picture/20160714/s_e341709f41aadecd.jpg', '', '20000090', 'dl', '', '', '', '', '', '', '刚刚发过火', '', '', '100', '1', 'd47ef2c2-8e98-452f-a801-6c6e1c535c90', '1476251908042');
INSERT INTO `tc_message` VALUES ('208', '20000001', '朱', 'http://120.24.61.200/lejin/Uploads/Picture/20160714/s_e341709f41aadecd.jpg', '', '20000090', 'dl', '', '', '', '', '', '', '哦哦就看看', '', '', '100', '1', '5d16d873-cc7e-4b00-9d1a-4f3825297e20', '1476252766098');
INSERT INTO `tc_message` VALUES ('209', '20000115', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160930/s_1a8178e7a50996ec.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000115', 'lo', 'http://www.kmlejin.com/Uploads/Picture/20160913/s_0cd0699b84ae7971.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '123456', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '74BBD8F5-11B2-41A4-BA7D-0BF1F5FF79D0', '1476541425494');
INSERT INTO `tc_message` VALUES ('210', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160930/s_1a8178e7a50996ec.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000115', 'lo', 'http://www.kmlejin.com/Uploads/Picture/20160913/s_0cd0699b84ae7971.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', 'Hhh ', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '4BA5F754-7380-45ED-B67C-331914AA32C4', '1476541901568');
INSERT INTO `tc_message` VALUES ('211', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160930/s_1a8178e7a50996ec.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000115', 'lo', 'http://www.kmlejin.com/Uploads/Picture/20160913/s_0cd0699b84ae7971.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', 'E ', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'B28E4D9D-0169-46FD-9403-33C3E95B8F46', '1476541906592');
INSERT INTO `tc_message` VALUES ('212', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160930/s_1a8178e7a50996ec.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000115', 'lo', 'http://www.kmlejin.com/Uploads/Picture/20160913/s_0cd0699b84ae7971.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', 'Haha ', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '0DC5D3D7-ABDC-415C-83E1-5F99762D6153', '1476541919912');
INSERT INTO `tc_message` VALUES ('213', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160930/s_1a8178e7a50996ec.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000115', 'lo', 'http://www.kmlejin.com/Uploads/Picture/20160913/s_0cd0699b84ae7971.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '33EC9877-E34C-4AA7-AE19-91618A8D78D2', '1476541948584');
INSERT INTO `tc_message` VALUES ('214', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160930/s_1a8178e7a50996ec.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000115', 'lo', 'http://www.kmlejin.com/Uploads/Picture/20160913/s_0cd0699b84ae7971.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '052F79B8-B0E1-4FE7-920E-4B4B25F4ECA1', '1476541990317');
INSERT INTO `tc_message` VALUES ('215', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160930/s_1a8178e7a50996ec.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000115', 'lo', 'http://www.kmlejin.com/Uploads/Picture/20160913/s_0cd0699b84ae7971.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '4AC45D7C-03D0-46E7-A188-7D4ACA11DE11', '1476541998258');
INSERT INTO `tc_message` VALUES ('216', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160930/s_1a8178e7a50996ec.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000115', 'lo', 'http://www.kmlejin.com/Uploads/Picture/20160913/s_0cd0699b84ae7971.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', 'Huff', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'D9ADCD3F-90B8-4381-8603-29B71EA743AF', '1476542824309');
INSERT INTO `tc_message` VALUES ('217', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160930/s_1a8178e7a50996ec.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000115', 'lo', 'http://www.kmlejin.com/Uploads/Picture/20160913/s_0cd0699b84ae7971.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '将来也许我的心里只有我一个人在一起了。我的心里只有我一', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '8A41D057-1E24-45E1-A79A-650A1674331D', '1476542859686');
INSERT INTO `tc_message` VALUES ('218', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160930/s_1a8178e7a50996ec.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000115', 'lo', 'http://www.kmlejin.com/Uploads/Picture/20160913/s_0cd0699b84ae7971.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '不过现在还是觉睡醒', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'D83E91EC-D183-4CCC-A1CB-89E380AF63CF', '1476543051628');
INSERT INTO `tc_message` VALUES ('219', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160930/s_1a8178e7a50996ec.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000115', 'lo', 'http://www.kmlejin.com/Uploads/Picture/20160913/s_0cd0699b84ae7971.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '去打球', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'D217AE27-AA85-41C5-B1B5-1A74E3B801C8', '1476543615497');
INSERT INTO `tc_message` VALUES ('220', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160930/s_1a8178e7a50996ec.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000115', 'lo', 'http://www.kmlejin.com/Uploads/Picture/20160913/s_0cd0699b84ae7971.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '恶犬', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'C41D289F-ECC9-49DD-BC11-5AF0CDB4EE02', '1476543616752');
INSERT INTO `tc_message` VALUES ('221', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160930/s_1a8178e7a50996ec.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000115', 'lo', 'http://www.kmlejin.com/Uploads/Picture/20160913/s_0cd0699b84ae7971.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '请问', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '221E3EC5-CDE5-4B54-897E-2EBE78C81F2F', '1476543617817');
INSERT INTO `tc_message` VALUES ('222', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160930/s_1a8178e7a50996ec.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000115', 'lo', 'http://www.kmlejin.com/Uploads/Picture/20160913/s_0cd0699b84ae7971.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '请问', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'E5D06373-C93C-4EA6-937F-47CE2017E554', '1476543618913');
INSERT INTO `tc_message` VALUES ('223', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160930/s_1a8178e7a50996ec.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000115', 'lo', 'http://www.kmlejin.com/Uploads/Picture/20160913/s_0cd0699b84ae7971.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', ' qwe', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '5D37264B-BF28-4BAC-BBC9-C417C0263146', '1476543620008');
INSERT INTO `tc_message` VALUES ('224', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160930/s_1a8178e7a50996ec.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000115', 'lo', 'http://www.kmlejin.com/Uploads/Picture/20160913/s_0cd0699b84ae7971.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '1', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '2B7CFB77-C471-4511-AE45-5E07B5E6DF22', '1476543621810');
INSERT INTO `tc_message` VALUES ('225', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160930/s_1a8178e7a50996ec.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000115', 'lo', 'http://www.kmlejin.com/Uploads/Picture/20160913/s_0cd0699b84ae7971.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '2', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '9817EF3D-3196-4DCA-8A66-828E3AFE51E6', '1476543622629');
INSERT INTO `tc_message` VALUES ('226', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160930/s_1a8178e7a50996ec.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000115', 'lo', 'http://www.kmlejin.com/Uploads/Picture/20160913/s_0cd0699b84ae7971.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '3', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '687F5037-FFEC-4306-A90F-E52870A17622', '1476543623674');
INSERT INTO `tc_message` VALUES ('227', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160930/s_1a8178e7a50996ec.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000115', 'lo', 'http://www.kmlejin.com/Uploads/Picture/20160913/s_0cd0699b84ae7971.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '4', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '0A219D7D-92B5-4686-9DED-B0EE8A8E997E', '1476543625671');
INSERT INTO `tc_message` VALUES ('228', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160930/s_1a8178e7a50996ec.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000115', 'lo', 'http://www.kmlejin.com/Uploads/Picture/20160913/s_0cd0699b84ae7971.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '5', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '8AFBCB2E-0D2C-4529-8FE6-46B2DF8BDA29', '1476543627309');
INSERT INTO `tc_message` VALUES ('229', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160930/s_1a8178e7a50996ec.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000115', 'lo', 'http://www.kmlejin.com/Uploads/Picture/20160913/s_0cd0699b84ae7971.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '6', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '1777372B-3912-4933-B823-99D0635B6696', '1476543628726');
INSERT INTO `tc_message` VALUES ('230', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160930/s_1a8178e7a50996ec.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000115', 'lo', 'http://www.kmlejin.com/Uploads/Picture/20160913/s_0cd0699b84ae7971.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '7', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '753E6143-DB0B-41E6-A3B2-00A8F139C96E', '1476543630196');
INSERT INTO `tc_message` VALUES ('231', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160930/s_1a8178e7a50996ec.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000115', 'lo', 'http://www.kmlejin.com/Uploads/Picture/20160913/s_0cd0699b84ae7971.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '8', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '6F69DA88-6B26-4D01-A8C7-AB18A0F5385A', '1476543632210');
INSERT INTO `tc_message` VALUES ('232', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160930/s_1a8178e7a50996ec.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000115', 'lo', 'http://www.kmlejin.com/Uploads/Picture/20160913/s_0cd0699b84ae7971.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '9', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'EAD34AB0-9FD3-401F-A3C1-ECF173356357', '1476543633565');
INSERT INTO `tc_message` VALUES ('233', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160930/s_1a8178e7a50996ec.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000115', 'lo', 'http://www.kmlejin.com/Uploads/Picture/20160913/s_0cd0699b84ae7971.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '10', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '2756EAE5-D3CE-4E15-8F2B-92A7CD5C0400', '1476543635162');
INSERT INTO `tc_message` VALUES ('234', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160930/s_1a8178e7a50996ec.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000115', 'lo', 'http://www.kmlejin.com/Uploads/Picture/20160913/s_0cd0699b84ae7971.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '11', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '8CA6873D-1AFC-4672-9DAD-AA49CB91A74E', '1476543636286');
INSERT INTO `tc_message` VALUES ('235', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160930/s_1a8178e7a50996ec.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000115', 'lo', 'http://www.kmlejin.com/Uploads/Picture/20160913/s_0cd0699b84ae7971.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '12', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '7D827C61-76F3-4F27-8041-8F2638D194D5', '1476543638578');
INSERT INTO `tc_message` VALUES ('236', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160930/s_1a8178e7a50996ec.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000115', 'lo', 'http://www.kmlejin.com/Uploads/Picture/20160913/s_0cd0699b84ae7971.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '13', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'F730480D-033C-438B-B41F-2A23BF1FBE28', '1476543639981');
INSERT INTO `tc_message` VALUES ('237', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160930/s_1a8178e7a50996ec.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000115', 'lo', 'http://www.kmlejin.com/Uploads/Picture/20160913/s_0cd0699b84ae7971.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '14', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'E0382DFA-43ED-4ACD-9913-DD23A25A2B48', '1476543641297');
INSERT INTO `tc_message` VALUES ('238', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160930/s_1a8178e7a50996ec.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000115', 'lo', 'http://www.kmlejin.com/Uploads/Picture/20160913/s_0cd0699b84ae7971.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '15', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'B20AAEBF-B5D4-4343-8F0F-D19D184C4C7C', '1476543642647');
INSERT INTO `tc_message` VALUES ('239', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160930/s_1a8178e7a50996ec.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000115', 'lo', 'http://www.kmlejin.com/Uploads/Picture/20160913/s_0cd0699b84ae7971.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '16', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '92190C44-D491-4F3F-A4F6-70D7659A3C9F', '1476543643876');
INSERT INTO `tc_message` VALUES ('240', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160930/s_1a8178e7a50996ec.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000115', 'lo', 'http://www.kmlejin.com/Uploads/Picture/20160913/s_0cd0699b84ae7971.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '17', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'F6B281C2-6565-432E-9481-3CDC6C151F3F', '1476543646599');
INSERT INTO `tc_message` VALUES ('241', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160930/s_1a8178e7a50996ec.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000115', 'lo', 'http://www.kmlejin.com/Uploads/Picture/20160913/s_0cd0699b84ae7971.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '18', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'E17732CC-F6CC-42A9-B6B5-C61A9545F59C', '1476543648219');
INSERT INTO `tc_message` VALUES ('242', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160930/s_1a8178e7a50996ec.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000115', 'lo', 'http://www.kmlejin.com/Uploads/Picture/20160913/s_0cd0699b84ae7971.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '19', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '9D0DABBF-4F54-4195-8AC6-B9F92FFAA519', '1476543649795');
INSERT INTO `tc_message` VALUES ('243', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160930/s_1a8178e7a50996ec.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000115', 'lo', 'http://www.kmlejin.com/Uploads/Picture/20160913/s_0cd0699b84ae7971.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '20', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'AE3CD10F-11A7-41F2-A59F-9D454C653A5D', '1476543651369');
INSERT INTO `tc_message` VALUES ('244', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160930/s_1a8178e7a50996ec.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000115', 'lo', 'http://www.kmlejin.com/Uploads/Picture/20160913/s_0cd0699b84ae7971.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '12315646', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '1BA0D5F4-F248-4825-AEFD-5ECE7FB7C563', '1476544035515');
INSERT INTO `tc_message` VALUES ('245', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160930/s_1a8178e7a50996ec.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000115', 'lo', 'http://www.kmlejin.com/Uploads/Picture/20160913/s_0cd0699b84ae7971.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '2156849', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'A4C69C4B-A81F-4B50-BB92-CB993E93F39F', '1476544051793');
INSERT INTO `tc_message` VALUES ('246', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160930/s_1a8178e7a50996ec.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000115', 'lo', 'http://www.kmlejin.com/Uploads/Picture/20160913/s_0cd0699b84ae7971.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '哈哈[emoji_360]', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '8595F336-4B09-4E46-A659-48CF4321C73D', '1476545923554');
INSERT INTO `tc_message` VALUES ('247', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160930/s_1a8178e7a50996ec.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000115', 'lo', 'http://www.kmlejin.com/Uploads/Picture/20160913/s_0cd0699b84ae7971.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', 'Zhengchaungziti', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '093F35A4-0F01-4EA3-9343-2107DEDAC2E9', '1476546407371');
INSERT INTO `tc_message` VALUES ('248', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160930/s_1a8178e7a50996ec.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000115', 'lo', 'http://www.kmlejin.com/Uploads/Picture/20160913/s_0cd0699b84ae7971.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '[emoji_85][emoji_85]', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '2158E74A-AF02-4114-8D7A-530FE0315C43', '1476546413258');
INSERT INTO `tc_message` VALUES ('249', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160930/s_1a8178e7a50996ec.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000115', 'lo', 'http://www.kmlejin.com/Uploads/Picture/20160913/s_0cd0699b84ae7971.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '[emoji_87][emoji_87]', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '65C7947A-7865-496F-95E1-A74F3D2DA15E', '1476546465508');
INSERT INTO `tc_message` VALUES ('250', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160930/s_1a8178e7a50996ec.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000115', 'lo', 'http://www.kmlejin.com/Uploads/Picture/20160913/s_0cd0699b84ae7971.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '2AD4F37D-94F3-4313-BF8D-F5737E641E71', '1476546578520');
INSERT INTO `tc_message` VALUES ('251', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160930/s_1a8178e7a50996ec.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000115', 'lo', 'http://www.kmlejin.com/Uploads/Picture/20160913/s_0cd0699b84ae7971.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', 'Http', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'F207F29B-31F0-4179-8086-D01B830FBB5C', '1476546651799');
INSERT INTO `tc_message` VALUES ('252', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160930/s_1a8178e7a50996ec.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000115', 'lo', 'http://www.kmlejin.com/Uploads/Picture/20160913/s_0cd0699b84ae7971.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'A1574D47-10E4-48C9-B583-96836F0DCF26', '1476546659391');
INSERT INTO `tc_message` VALUES ('253', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160930/s_1a8178e7a50996ec.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000115', 'lo', 'http://www.kmlejin.com/Uploads/Picture/20160913/s_0cd0699b84ae7971.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '  ', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'C2F93EA7-E907-4FC8-8A13-2AA34EC734CB', '1476546787596');
INSERT INTO `tc_message` VALUES ('254', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160930/s_1a8178e7a50996ec.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000115', 'lo', 'http://www.kmlejin.com/Uploads/Picture/20160913/s_0cd0699b84ae7971.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', ' ', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '8661B81C-87E6-4DF4-BAD2-BE147F928FCA', '1476547001465');
INSERT INTO `tc_message` VALUES ('255', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160930/s_1a8178e7a50996ec.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000115', 'lo', 'http://www.kmlejin.com/Uploads/Picture/20160913/s_0cd0699b84ae7971.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', ' ', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'C3ADA3B8-E1CB-423E-86C8-F5AC305EFBB1', '1476547002507');
INSERT INTO `tc_message` VALUES ('256', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160930/s_1a8178e7a50996ec.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000115', 'lo', 'http://www.kmlejin.com/Uploads/Picture/20160913/s_0cd0699b84ae7971.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', ' ', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '54497024-BFAB-46D4-B744-292ACEAF28BA', '1476547003220');
INSERT INTO `tc_message` VALUES ('257', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160930/s_1a8178e7a50996ec.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000115', 'lo', 'http://www.kmlejin.com/Uploads/Picture/20160913/s_0cd0699b84ae7971.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '哈哈问题解决了', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '43174B1C-A19F-450D-9CC3-D63A890B528E', '1476547022863');
INSERT INTO `tc_message` VALUES ('258', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160930/s_1a8178e7a50996ec.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000115', 'lo', 'http://www.kmlejin.com/Uploads/Picture/20160913/s_0cd0699b84ae7971.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', ' ', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '7E0E31CB-9F81-49F2-BA4C-380B0EEA6D7F', '1476547038621');
INSERT INTO `tc_message` VALUES ('259', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160930/s_1a8178e7a50996ec.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000115', 'lo', 'http://www.kmlejin.com/Uploads/Picture/20160913/s_0cd0699b84ae7971.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', ' ', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'DE999A91-298F-4C1A-BA12-20CB4101F37F', '1476547039325');
INSERT INTO `tc_message` VALUES ('260', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160930/s_1a8178e7a50996ec.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000115', 'lo', 'http://www.kmlejin.com/Uploads/Picture/20160913/s_0cd0699b84ae7971.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', ' ', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'A2CB64A3-96E7-4477-A04E-28A14C5BCE30', '1476547040181');
INSERT INTO `tc_message` VALUES ('261', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160930/s_1a8178e7a50996ec.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000115', 'lo', 'http://www.kmlejin.com/Uploads/Picture/20160913/s_0cd0699b84ae7971.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', ' ', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'DE682D94-425F-4272-93FB-E67A3C1132C1', '1476547040415');
INSERT INTO `tc_message` VALUES ('262', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160930/s_1a8178e7a50996ec.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000115', 'lo', 'http://www.kmlejin.com/Uploads/Picture/20160913/s_0cd0699b84ae7971.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', ' ', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '68DDE937-DB51-41B7-924D-2E3BD0D1B5E3', '1476547040670');
INSERT INTO `tc_message` VALUES ('263', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160930/s_1a8178e7a50996ec.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000115', 'lo', 'http://www.kmlejin.com/Uploads/Picture/20160913/s_0cd0699b84ae7971.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', ' ', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'D34131DC-E34E-4B8B-9B6A-6C7615F9FE67', '1476547040960');
INSERT INTO `tc_message` VALUES ('264', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160930/s_1a8178e7a50996ec.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000115', 'lo', 'http://www.kmlejin.com/Uploads/Picture/20160913/s_0cd0699b84ae7971.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', ' ', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'FB7A217E-D1D3-47A5-A833-721ECA81B33C', '1476547041030');
INSERT INTO `tc_message` VALUES ('265', '20000115', 'lo', 'http://www.kmlejin.com/Uploads/Picture/20160913/s_0cd0699b84ae7971.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160930/s_1a8178e7a50996ec.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', 'Haha\n', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'A9BFD984-E629-49CB-B710-533B99575524', '1476547222599');
INSERT INTO `tc_message` VALUES ('266', '20000115', 'lo', 'http://www.kmlejin.com/Uploads/Picture/20160913/s_0cd0699b84ae7971.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160930/s_1a8178e7a50996ec.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '这个怎么样', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'A50D4D59-7677-451F-B665-97CE80DCCC08', '1476547238538');
INSERT INTO `tc_message` VALUES ('267', '20000115', 'lo', 'http://www.kmlejin.com/Uploads/Picture/20160913/s_0cd0699b84ae7971.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160930/s_1a8178e7a50996ec.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '好丑的页面', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '34FEA809-EC09-417F-AA5C-C8905876CF08', '1476547248493');
INSERT INTO `tc_message` VALUES ('268', '20000115', 'lo', 'http://www.kmlejin.com/Uploads/Picture/20160913/s_0cd0699b84ae7971.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160930/s_1a8178e7a50996ec.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', 'test', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'CBCF6D2B-676E-45C1-9E0F-EFD06D3D0D7B', '1476547253239');
INSERT INTO `tc_message` VALUES ('269', '20000115', 'lo', 'http://www.kmlejin.com/Uploads/Picture/20160913/s_0cd0699b84ae7971.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160930/s_1a8178e7a50996ec.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', 'ok？', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '3B903A80-E4A4-46C3-86A7-BB0D830F4936', '1476547259373');
INSERT INTO `tc_message` VALUES ('270', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160930/s_1a8178e7a50996ec.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000115', 'lo', 'http://www.kmlejin.com/Uploads/Picture/20160913/s_0cd0699b84ae7971.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '123456', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '4A5F7658-8AF7-429D-8166-D96D075BAEDD', '1476615211393');
INSERT INTO `tc_message` VALUES ('271', '20000107', '大丈夫', 'http://120.24.61.200/lejin/Uploads/Picture/20161018/s_dffcac0f35b839e4.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000107', '大丈夫', 'http://120.24.61.200/lejin/Uploads/Picture/20161018/s_dffcac0f35b839e4.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '擦', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '10B4DFE3-F778-4AC4-90FB-19376E32494E', '1476780594686');
INSERT INTO `tc_message` VALUES ('272', '20000107', '大丈夫', 'http://120.24.61.200/lejin/Uploads/Picture/20161018/s_dffcac0f35b839e4.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000107', '大丈夫', 'http://120.24.61.200/lejin/Uploads/Picture/20161018/s_dffcac0f35b839e4.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', ' ', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'F61E67FD-D464-4C11-A3CC-B11BD5C54FC6', '1476780594763');
INSERT INTO `tc_message` VALUES ('273', '20000107', '大丈夫', 'http://120.24.61.200/lejin/Uploads/Picture/20161018/s_dffcac0f35b839e4.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000107', '大丈夫', 'http://120.24.61.200/lejin/Uploads/Picture/20161018/s_dffcac0f35b839e4.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', ' ', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '249D62CE-9F98-4F0B-B38E-E2D385D342C3', '1476780594844');
INSERT INTO `tc_message` VALUES ('274', '20000112', '大丈夫', 'http://120.24.61.200/lejin/Uploads/Picture/20161025/s_22b8fabec1a332ef.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000107', '大丈夫', 'http://120.24.61.200/lejin/Uploads/Picture/20161018/s_dffcac0f35b839e4.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '？？？？？？', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '16C7CCE0-96E4-4E10-8D6A-E97D93A6D073', '1477365248652');
INSERT INTO `tc_message` VALUES ('275', '20000107', '大丈夫', 'http://120.24.61.200/lejin/Uploads/Picture/20161018/s_dffcac0f35b839e4.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000112', '大丈夫', 'http://120.24.61.200/lejin/Uploads/Picture/20161025/s_22b8fabec1a332ef.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '我们都市', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'C715A111-FDFF-42CD-80C1-579DDD67D2F0', '1477365375441');
INSERT INTO `tc_message` VALUES ('276', '20000108', 'byyourside', 'http://120.24.61.200/lejin/Uploads/Picture/20161018/s_18b59ead945b57e2.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000107', '大丈夫', 'http://120.24.61.200/lejin/Uploads/Picture/20161018/s_dffcac0f35b839e4.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', 'Ausdhjiuahsjdadsa', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '5F75CD7A-E184-4F0E-87DB-FB96574EFD83', '1477365437890');
INSERT INTO `tc_message` VALUES ('277', '20000108', 'byyourside', 'http://120.24.61.200/lejin/Uploads/Picture/20161018/s_18b59ead945b57e2.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000107', '大丈夫', 'http://120.24.61.200/lejin/Uploads/Picture/20161018/s_dffcac0f35b839e4.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', 'Q56w14e56q4w68eq', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'A83A30A5-D455-4841-A8D2-DC09A864045B', '1477365438646');
INSERT INTO `tc_message` VALUES ('278', '20000108', 'byyourside', 'http://120.24.61.200/lejin/Uploads/Picture/20161018/s_18b59ead945b57e2.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000107', '大丈夫', 'http://120.24.61.200/lejin/Uploads/Picture/20161018/s_dffcac0f35b839e4.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '1236546484989sgsg', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '22D74BF4-F68D-47EB-A98E-C72021041B9C', '1477365539961');
INSERT INTO `tc_message` VALUES ('279', '20000115', 'lo', 'http://www.kmlejin.com/Uploads/Picture/20160913/s_0cd0699b84ae7971.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160930/s_1a8178e7a50996ec.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '2123467987', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'CA6691F0-1578-447A-8EC3-B1EF057C2D4D', '1477403369170');
INSERT INTO `tc_message` VALUES ('280', '20000111', '12304564', 'http://120.24.61.200/lejin/Uploads/Picture/20161024/s_5a749db83f5c5898.png', '{\"from扩展\":\"从哪儿来的?\"}', '41', '大丈夫', 'http://120.24.61.200/lejin/Uploads/Picture/20161024/s_5a749db83f5c5898.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', 'Fatty', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '173207A6-E734-46BF-B114-7A6034C93E29', '1477448379354');
INSERT INTO `tc_message` VALUES ('281', '20000111', '12304564', 'http://120.24.61.200/lejin/Uploads/Picture/20161024/s_5a749db83f5c5898.png', '{\"from扩展\":\"从哪儿来的?\"}', '41', '大丈夫', 'http://120.24.61.200/lejin/Uploads/Picture/20161024/s_5a749db83f5c5898.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', ' ', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'EAD6C307-CCE4-4A74-B89B-05FEE1E2F2C5', '1477448567856');
INSERT INTO `tc_message` VALUES ('282', '20000111', '12304564', 'http://120.24.61.200/lejin/Uploads/Picture/20161024/s_5a749db83f5c5898.png', '{\"from扩展\":\"从哪儿来的?\"}', '41', '大丈夫', 'http://120.24.61.200/lejin/Uploads/Picture/20161024/s_5a749db83f5c5898.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', 'Fujitsu', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '5C23FA67-F460-4729-8FC8-A5B195FFDAED', '1477449173501');
INSERT INTO `tc_message` VALUES ('283', '20000111', '12304564', 'http://120.24.61.200/lejin/Uploads/Picture/20161024/s_5a749db83f5c5898.png', '{\"from扩展\":\"从哪儿来的?\"}', '41', '大丈夫', 'http://120.24.61.200/lejin/Uploads/Picture/20161024/s_5a749db83f5c5898.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', 'Glee', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '84CEF026-1BE1-4D5D-A28B-459415E0DB7A', '1477449187869');
INSERT INTO `tc_message` VALUES ('284', '20000111', '12304564', 'http://120.24.61.200/lejin/Uploads/Picture/20161024/s_5a749db83f5c5898.png', '{\"from扩展\":\"从哪儿来的?\"}', '41', '大丈夫', 'http://120.24.61.200/lejin/Uploads/Picture/20161024/s_5a749db83f5c5898.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', 'Hi', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '4E7E497D-019A-4EDD-B4CD-F105C0BEEB91', '1477449191967');
INSERT INTO `tc_message` VALUES ('285', '20000111', '12304564', 'http://120.24.61.200/lejin/Uploads/Picture/20161024/s_5a749db83f5c5898.png', '{\"from扩展\":\"从哪儿来的?\"}', '41', '大丈夫', 'http://120.24.61.200/lejin/Uploads/Picture/20161024/s_5a749db83f5c5898.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', 'Gf', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '0FCAF9A5-2946-46F2-AC4E-4E54E795E82D', '1477449268756');
INSERT INTO `tc_message` VALUES ('286', '20000111', '12304564', 'http://120.24.61.200/lejin/Uploads/Picture/20161024/s_5a749db83f5c5898.png', '{\"from扩展\":\"从哪儿来的?\"}', '41', '大丈夫', 'http://120.24.61.200/lejin/Uploads/Picture/20161024/s_5a749db83f5c5898.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', 'Gif', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'A1889A56-7A44-44CF-8BBF-0D8F771755E1', '1477450331900');
INSERT INTO `tc_message` VALUES ('287', '20000111', '12304564', 'http://120.24.61.200/lejin/Uploads/Picture/20161024/s_5a749db83f5c5898.png', '{\"from扩展\":\"从哪儿来的?\"}', '41', '大丈夫', 'http://120.24.61.200/lejin/Uploads/Picture/20161024/s_5a749db83f5c5898.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', 'Gig', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '1DBA9C0C-3A22-4C15-B313-76C4C7B254A6', '1477450334536');
INSERT INTO `tc_message` VALUES ('288', '20000107', '大丈夫', 'http://120.24.61.200/lejin/Uploads/Picture/20161018/s_dffcac0f35b839e4.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000000', '朱2', 'http://120.24.61.200/lejin/Uploads/Picture/20160923/s_f018f41f6ccc9089.jpg', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', 'Tyyt ', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '7BF50ED8-9A60-457F-8309-301B3A7533FF', '1477641900173');
INSERT INTO `tc_message` VALUES ('289', '20000107', '大丈夫', 'http://120.24.61.200/lejin/Uploads/Picture/20161018/s_dffcac0f35b839e4.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000000', '朱2', 'http://120.24.61.200/lejin/Uploads/Picture/20160923/s_f018f41f6ccc9089.jpg', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '[emoji_351]', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'E370645D-B198-4293-9CEF-D919B2DFE250', '1477641954552');
INSERT INTO `tc_message` VALUES ('290', '20000108', 'byyourside', 'http://120.24.61.200/lejin/Uploads/Picture/20161018/s_18b59ead945b57e2.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000107', '大丈夫', 'http://120.24.61.200/lejin/Uploads/Picture/20161018/s_dffcac0f35b839e4.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '撒打算大', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '784740C6-43B6-4F22-87A9-BEB707F30ADC', '1477642095453');
INSERT INTO `tc_message` VALUES ('291', '20000108', 'byyourside', 'http://120.24.61.200/lejin/Uploads/Picture/20161018/s_18b59ead945b57e2.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000107', '大丈夫', 'http://120.24.61.200/lejin/Uploads/Picture/20161018/s_dffcac0f35b839e4.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '撒打算大三', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '7874155B-1F78-4A17-A708-3471E794FC58', '1477642095652');
INSERT INTO `tc_message` VALUES ('292', '20000108', 'byyourside', 'http://120.24.61.200/lejin/Uploads/Picture/20161018/s_18b59ead945b57e2.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000108', 'byyourside', 'http://120.24.61.200/lejin/Uploads/Picture/20161018/s_18b59ead945b57e2.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '56撒打算', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '815D08B7-0593-4AE1-9DCE-1BE41A0F531D', '1477642125524');
INSERT INTO `tc_message` VALUES ('293', '20000108', 'byyourside', 'http://120.24.61.200/lejin/Uploads/Picture/20161018/s_18b59ead945b57e2.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000108', 'byyourside', 'http://120.24.61.200/lejin/Uploads/Picture/20161018/s_18b59ead945b57e2.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '阿斯顿', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'F3599D29-017A-42A4-8AB8-E24C16522AFB', '1477642126755');
INSERT INTO `tc_message` VALUES ('294', '20000107', '朱2', 'http://120.24.61.200/lejin/Uploads/Picture/20160923/s_f018f41f6ccc9089.jpg', '{\"from扩展\":\"从哪儿来的?\"}', '20000108', 'byyourside', 'http://120.24.61.200/lejin/Uploads/Picture/20161018/s_18b59ead945b57e2.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '在', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '9010A7EB-AD18-443A-AFCE-CA2FCF147E32', '1477646885454');
INSERT INTO `tc_message` VALUES ('295', '20000107', '朱2', 'http://120.24.61.200/lejin/Uploads/Picture/20160923/s_f018f41f6ccc9089.jpg', '{\"from扩展\":\"从哪儿来的?\"}', '20000108', 'byyourside', 'http://120.24.61.200/lejin/Uploads/Picture/20161018/s_18b59ead945b57e2.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '在', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '32844A9D-E938-4164-87FB-7619CB15173F', '1477646888087');
INSERT INTO `tc_message` VALUES ('296', '20000107', '朱2', 'http://120.24.61.200/lejin/Uploads/Picture/20160923/s_f018f41f6ccc9089.jpg', '{\"from扩展\":\"从哪儿来的?\"}', '20000108', 'byyourside', 'http://120.24.61.200/lejin/Uploads/Picture/20161018/s_18b59ead945b57e2.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '你是一', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'FB18E348-4F76-41F7-AC78-BCAF98F77130', '1477646891636');
INSERT INTO `tc_message` VALUES ('297', '20000107', '朱2', 'http://120.24.61.200/lejin/Uploads/Picture/20160923/s_f018f41f6ccc9089.jpg', '{\"from扩展\":\"从哪儿来的?\"}', '20000108', 'byyourside', 'http://120.24.61.200/lejin/Uploads/Picture/20161018/s_18b59ead945b57e2.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '这么晚', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '507DBED5-8F40-4DCB-BE01-D2D4185BEAB9', '1477646898821');
INSERT INTO `tc_message` VALUES ('298', '20000107', '朱2', 'http://120.24.61.200/lejin/Uploads/Picture/20160923/s_f018f41f6ccc9089.jpg', '{\"from扩展\":\"从哪儿来的?\"}', '20000108', 'byyourside', 'http://120.24.61.200/lejin/Uploads/Picture/20161018/s_18b59ead945b57e2.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '你的', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '4CCE0D10-A54A-4439-B918-BA3EC60B974F', '1477646919003');
INSERT INTO `tc_message` VALUES ('299', '20000107', '朱2', 'http://120.24.61.200/lejin/Uploads/Picture/20160923/s_f018f41f6ccc9089.jpg', '{\"from扩展\":\"从哪儿来的?\"}', '20000108', 'byyourside', 'http://120.24.61.200/lejin/Uploads/Picture/20161018/s_18b59ead945b57e2.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '这样我想说了一个', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '5B36BC8D-E273-4909-A0C8-55004E9EAAD0', '1477646960107');
INSERT INTO `tc_message` VALUES ('300', '20000108', 'byyourside', 'http://120.24.61.200/lejin/Uploads/Picture/20161018/s_18b59ead945b57e2.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000108', 'byyourside', 'http://120.24.61.200/lejin/Uploads/Picture/20161018/s_18b59ead945b57e2.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', 'g h j', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '070C000E-0CB6-49A3-A4E1-5E55B9D95683', '1477646983798');
INSERT INTO `tc_message` VALUES ('301', '20000109', '测试1', 'http://120.24.61.200/lejin/Uploads/Picture/20161022/s_328c91d93136cae2.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000108', 'byyourside', 'http://120.24.61.200/lejin/Uploads/Picture/20161018/s_18b59ead945b57e2.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', 'vbhj', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '9F65D3EC-7DEB-415D-B455-80E5DAF205ED', '1477747130542');
INSERT INTO `tc_message` VALUES ('302', '20000109', '测试1', 'http://120.24.61.200/lejin/Uploads/Picture/20161022/s_328c91d93136cae2.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000108', 'byyourside', 'http://120.24.61.200/lejin/Uploads/Picture/20161018/s_18b59ead945b57e2.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '你好', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '386ED2B7-FD64-4D55-822A-6CD85AB7D4B7', '1477747138878');
INSERT INTO `tc_message` VALUES ('303', '20000107', '大丈夫', 'http://120.24.61.200/lejin/Uploads/Picture/20161018/s_dffcac0f35b839e4.png', '{\"from扩展\":\"从哪儿来的?\"}', '41', '大丈夫', '', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '一定', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '4D1CF22E-A473-44BB-B67D-A5806A180A95', '1477896988667');
INSERT INTO `tc_message` VALUES ('304', '20000107', '大丈夫', 'http://120.24.61.200/lejin/Uploads/Picture/20161018/s_dffcac0f35b839e4.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000108', 'byyourside', 'http://120.24.61.200/lejin/Uploads/Picture/20161018/s_18b59ead945b57e2.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', 'jr', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '26178C50-9B02-4E7B-86B1-1D2EB70B2092', '1477897034983');
INSERT INTO `tc_message` VALUES ('305', '20000107', '大丈夫', 'http://120.24.61.200/lejin/Uploads/Picture/20161018/s_dffcac0f35b839e4.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000108', 'byyourside', 'http://120.24.61.200/lejin/Uploads/Picture/20161018/s_18b59ead945b57e2.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', 'uuuu ', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '0841485C-EBC8-400A-A220-3258DF82C9C8', '1477897065536');
INSERT INTO `tc_message` VALUES ('306', '20000108', 'byyourside', 'http://120.24.61.200/lejin/Uploads/Picture/20161018/s_18b59ead945b57e2.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000107', '大丈夫', 'http://120.24.61.200/lejin/Uploads/Picture/20161018/s_dffcac0f35b839e4.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', 'Khoikhoi', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'B5E42A38-DD92-4675-8643-4092B20D9AA0', '1477897093379');
INSERT INTO `tc_message` VALUES ('307', '20000108', 'byyourside', 'http://120.24.61.200/lejin/Uploads/Picture/20161018/s_18b59ead945b57e2.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000107', '大丈夫', 'http://120.24.61.200/lejin/Uploads/Picture/20161018/s_dffcac0f35b839e4.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '48964', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'DF4287C3-EE4D-4D28-AC9C-EA9AFB6DC09E', '1477897094476');
INSERT INTO `tc_message` VALUES ('308', '20000108', 'byyourside', 'http://120.24.61.200/lejin/Uploads/Picture/20161018/s_18b59ead945b57e2.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000107', '大丈夫', 'http://120.24.61.200/lejin/Uploads/Picture/20161018/s_dffcac0f35b839e4.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '651496', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '3600F5CB-F3D7-41AE-9275-E3984D27246D', '1477897096837');
INSERT INTO `tc_message` VALUES ('309', '20000108', 'byyourside', 'http://120.24.61.200/lejin/Uploads/Picture/20161018/s_18b59ead945b57e2.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000107', '大丈夫', 'http://120.24.61.200/lejin/Uploads/Picture/20161018/s_dffcac0f35b839e4.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '4561648647', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'A4FE0122-3E58-4B07-9B15-C441B9B55C3F', '1477897114496');
INSERT INTO `tc_message` VALUES ('310', '20000109', '测试1', 'http://120.24.61.200/lejin/Uploads/Picture/20161022/s_328c91d93136cae2.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000108', 'byyourside', 'http://120.24.61.200/lejin/Uploads/Picture/20161018/s_18b59ead945b57e2.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '改革规划', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'D446ECB9-1991-4125-A913-956CD597FCD9', '1477899362312');
INSERT INTO `tc_message` VALUES ('311', '20000109', '测试1', 'http://120.24.61.200/lejin/Uploads/Picture/20161022/s_328c91d93136cae2.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000116', '莫默默', 'http://120.24.61.200/lejin/Uploads/Picture/20161031/s_9fb14962887a336a.jpg', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '改革规划', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'D17C470B-0305-4BEE-B466-4BA9B855D4A0', '1477899381880');
INSERT INTO `tc_message` VALUES ('312', '20000109', '测试1', 'http://120.24.61.200/lejin/Uploads/Picture/20161022/s_328c91d93136cae2.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000116', '莫默默', 'http://120.24.61.200/lejin/Uploads/Picture/20161031/s_9fb14962887a336a.jpg', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '风风光光', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '8F078F59-30CD-4234-BB59-CA1DB64F3FAA', '1477899424844');
INSERT INTO `tc_message` VALUES ('313', '20000109', '测试1', 'http://120.24.61.200/lejin/Uploads/Picture/20161022/s_328c91d93136cae2.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000116', '莫默默', 'http://120.24.61.200/lejin/Uploads/Picture/20161031/s_9fb14962887a336a.jpg', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '宝宝保暖', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'CF105AFE-1FC3-4416-B77F-76389699DBD7', '1477899449597');
INSERT INTO `tc_message` VALUES ('314', '20000107', '大丈夫', 'http://120.24.61.200/lejin/Uploads/Picture/20161018/s_dffcac0f35b839e4.png', '{\"from扩展\":\"从哪儿来的?\"}', '37', '哦哈啊绝对是稍稍dasd 啊', '', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', 're', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '9A3BAF74-918D-4F8F-86C1-946C3495F985', '1477907066744');
INSERT INTO `tc_message` VALUES ('315', '20000107', '大丈夫', 'http://120.24.61.200/lejin/Uploads/Picture/20161018/s_dffcac0f35b839e4.png', '{\"from扩展\":\"从哪儿来的?\"}', '37', '哦哈啊绝对是稍稍dasd 啊', '', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', 're ', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'B28413A3-9E64-4CFD-81D3-CAE6D4B10B36', '1477907076223');
INSERT INTO `tc_message` VALUES ('316', '20000107', '大丈夫', 'http://120.24.61.200/lejin/Uploads/Picture/20161018/s_dffcac0f35b839e4.png', '{\"from扩展\":\"从哪儿来的?\"}', '37', '哦哈啊绝对是稍稍dasd 啊', '', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', 'www ', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'E6C03372-CFDF-455F-9971-03B05232BD53', '1477907101618');
INSERT INTO `tc_message` VALUES ('317', '20000107', '大丈夫', 'http://120.24.61.200/lejin/Uploads/Picture/20161018/s_dffcac0f35b839e4.png', '{\"from扩展\":\"从哪儿来的?\"}', '37', '哦哈啊绝对是稍稍dasd 啊', '', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', 'eee ', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '6B71840A-9F20-4B13-95F0-6FB50B74D02B', '1477907114845');
INSERT INTO `tc_message` VALUES ('318', '20000107', '大丈夫', 'http://120.24.61.200/lejin/Uploads/Picture/20161018/s_dffcac0f35b839e4.png', '{\"from扩展\":\"从哪儿来的?\"}', '37', '哦哈啊绝对是稍稍dasd 啊', '', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', 'ewww ', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '7CB95B9E-DEBB-44BC-8A3E-8586C6E62265', '1477907202077');
INSERT INTO `tc_message` VALUES ('319', '20000107', '大丈夫', 'http://120.24.61.200/lejin/Uploads/Picture/20161018/s_dffcac0f35b839e4.png', '{\"from扩展\":\"从哪儿来的?\"}', '37', '哦哈啊绝对是稍稍dasd 啊', '', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', 'hhhh ', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '012A4A57-491C-4757-A3DF-0BE6E2EB0332', '1477907213540');
INSERT INTO `tc_message` VALUES ('320', '20000107', '大丈夫', 'http://120.24.61.200/lejin/Uploads/Picture/20161018/s_dffcac0f35b839e4.png', '{\"from扩展\":\"从哪儿来的?\"}', '37', '哦哈啊绝对是稍稍dasd 啊', '', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', 'eww', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '79CCD5A6-36DE-4E8B-875C-4A4CED63D01E', '1477907219593');
INSERT INTO `tc_message` VALUES ('321', '20000107', '大丈夫', 'http://120.24.61.200/lejin/Uploads/Picture/20161018/s_dffcac0f35b839e4.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000108', 'byyourside', 'http://120.24.61.200/lejin/Uploads/Picture/20161018/s_18b59ead945b57e2.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', 'huh ', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'A633FD06-A74A-4506-92ED-74E3D30E436C', '1477907230381');
INSERT INTO `tc_message` VALUES ('322', '20000107', '大丈夫', 'http://120.24.61.200/lejin/Uploads/Picture/20161018/s_dffcac0f35b839e4.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000116', '莫默默', 'http://120.24.61.200/lejin/Uploads/Picture/20161031/s_9fb14962887a336a.jpg', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', 'ghg ', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'AB305701-27F7-4A77-A1E8-42DE33EAAF92', '1477907348607');
INSERT INTO `tc_message` VALUES ('323', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20160930/s_1a8178e7a50996ec.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000115', 'lo', 'http://www.kmlejin.com/Uploads/Picture/20160913/s_0cd0699b84ae7971.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '[emoji_353][emoji_345][emoji_96][emoji_96]', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'DB98D4DF-F56B-4542-A367-9BA842AB5E6F', '1478155893654');
INSERT INTO `tc_message` VALUES ('324', '20000210', '紫', 'http://www.kmlejin.com/Uploads/Picture/20161119/s_1eeb8ff52b5e5200.jpg', '', '20000179', '有你才精彩', 'http://www.kmlejin.com/Uploads/Picture/20161021/s_ca66872a2133dd9c.jpg', '', '', '', '', '', '你好', '', '', '100', '1', '3e987588-fe51-4111-8702-97bf5d1ffdca', '1479520804612');
INSERT INTO `tc_message` VALUES ('325', '20000000', '朱2', '', '{\"from扩展\":\"从哪儿来的?\"}', '20000107', '大丈夫', 'http://120.24.61.200/lejin/Uploads/Picture/20161018/s_dffcac0f35b839e4.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '你们', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'ADCD5E90-24D0-4E89-86F6-E7C8838A0064', '1483945151291');
INSERT INTO `tc_message` VALUES ('326', '20000000', '朱2', '', '{\"from扩展\":\"从哪儿来的?\"}', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20161206/s_5752829287f74c94.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '你们为什么我', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'A3F5D691-3DFD-4609-ABC5-BEB10E9BECCB', '1483945170714');
INSERT INTO `tc_message` VALUES ('327', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20161206/s_5752829287f74c94.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000000', '朱2', '', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', 'Rrrrrr I love ', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '020A0557-88CD-4D84-AADE-5D9265768025', '1483945197730');
INSERT INTO `tc_message` VALUES ('328', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20161206/s_5752829287f74c94.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000000', '朱2', '', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', 'Rrrrrr is ', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '816F2808-9894-48AD-8A95-1F180CAF2F75', '1483945202435');
INSERT INTO `tc_message` VALUES ('329', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20161206/s_5752829287f74c94.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000000', '朱2', '', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', 'The only thing that ', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '6EE02A29-9CAA-4C85-9F3C-E832FD1F140D', '1483946495618');
INSERT INTO `tc_message` VALUES ('330', '20000000', '朱2', '', '{\"from扩展\":\"从哪儿来的?\"}', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20161206/s_5752829287f74c94.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '你们为什么要把自己弄丢', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '7D47A217-26C6-46C2-B5CD-14D9CBBE578A', '1483946539058');
INSERT INTO `tc_message` VALUES ('331', '20000000', '朱2', '', '{\"from扩展\":\"从哪儿来的?\"}', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20161206/s_5752829287f74c94.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '在一起就很', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '3C757F51-3A8C-4F09-AF4F-2015C6782636', '1483946544448');
INSERT INTO `tc_message` VALUES ('332', '20000000', '朱2', '', '{\"from扩展\":\"从哪儿来的?\"}', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20161206/s_5752829287f74c94.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '你们都会', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'D1409C96-3ED2-4E3F-AA2A-DBDD989090DA', '1483946548093');
INSERT INTO `tc_message` VALUES ('333', '20000000', '朱2', '', '{\"from扩展\":\"从哪儿来的?\"}', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20161206/s_5752829287f74c94.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '你们为什么我', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '1971FBA7-4E37-40C4-8001-11A09B583894', '1483946551638');
INSERT INTO `tc_message` VALUES ('334', '20000000', '朱2', '', '{\"from扩展\":\"从哪儿来的?\"}', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20161206/s_5752829287f74c94.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '你们的', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '908D1D98-9CA2-446A-AE57-DAD4366D6C3F', '1483946558726');
INSERT INTO `tc_message` VALUES ('335', '20000000', '朱2', '', '{\"from扩展\":\"从哪儿来的?\"}', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20161206/s_5752829287f74c94.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '好评出最爱我', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'DB8E3866-60DB-42CE-A22F-67B98398586A', '1483951050251');
INSERT INTO `tc_message` VALUES ('336', '20000000', '朱2', '', '{\"from扩展\":\"从哪儿来的?\"}', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20161206/s_5752829287f74c94.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '好评和一双翅膀了你我想去', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'C80E0997-1B7A-448B-9C4B-C0B71AB91ADC', '1483951177980');
INSERT INTO `tc_message` VALUES ('337', '20000000', '朱2', '', '{\"from扩展\":\"从哪儿来的?\"}', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20161206/s_5752829287f74c94.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '这些刺激性气味是什么时候开始', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '0C9D62AD-ED6C-4D31-965A-FAC6BA1AB7C6', '1483951181203');
INSERT INTO `tc_message` VALUES ('338', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20161206/s_5752829287f74c94.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000000', '朱2', '', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '的士都拦不住了！司机的士师傅说了我一个小时后我会在线', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'D4F3C494-6FF7-4BAA-89C1-3F355E9A8A25', '1483953446460');
INSERT INTO `tc_message` VALUES ('339', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20161206/s_5752829287f74c94.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000000', '朱2', '', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '你说过于简单的事！司机', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '3B6974D6-A131-4B7C-A2A8-AF91C793396E', '1483953450233');
INSERT INTO `tc_message` VALUES ('340', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20161206/s_5752829287f74c94.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000000', '朱2', '', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '的士上了一个月后我们还要在线观看', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '73758767-5509-4F2D-B019-D5350A16981E', '1483953770088');
INSERT INTO `tc_message` VALUES ('341', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20161206/s_5752829287f74c94.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000000', '朱2', '', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '司机的士师傅说了我一个', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '4336400E-EC86-4EA9-9939-6E593B22CA94', '1483953773351');
INSERT INTO `tc_message` VALUES ('342', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20161206/s_5752829287f74c94.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000000', '朱2', '', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '你就不过我', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'E5AEB743-01F8-4F56-9DA3-FD2A28CE880F', '1483953824431');
INSERT INTO `tc_message` VALUES ('343', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20161206/s_5752829287f74c94.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000000', '朱2', '', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '的士都拦车罚款了你就不', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '0B86912B-4879-4AC0-9CEB-03C3E3E2AE61', '1483956139713');
INSERT INTO `tc_message` VALUES ('344', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20161206/s_5752829287f74c94.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000000', '朱2', '', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '的士上了一个小时', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '0429FDEE-8699-4EF3-B015-25415065825D', '1483956142322');
INSERT INTO `tc_message` VALUES ('345', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20161206/s_5752829287f74c94.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000000', '朱2', '', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '你说了', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '38A70A07-431F-4581-BB07-7D9C00293431', '1483956144723');
INSERT INTO `tc_message` VALUES ('346', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20161206/s_5752829287f74c94.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000000', '朱2', '', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '司机的士都会说', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'FE470546-9AC2-49AD-80FF-BAE57E3A234B', '1483956539566');
INSERT INTO `tc_message` VALUES ('347', '20000017', 'nye', 'http://www.kmlejin.com/Uploads/Picture/20160428/s_0b18450ac870edb7.png', '', '20000000', '朱2', '', '', '', '', '', '', '给还回家', '', '', '100', '1', '123f8316-a9bd-4751-848a-4cd7f20c7af6', '1484291953776');
INSERT INTO `tc_message` VALUES ('348', '20000000', '朱2', '', '{\"from扩展\":\"从哪儿来的?\"}', '20000017', 'nye', 'http://www.kmlejin.com/Uploads/Picture/20160428/s_0b18450ac870edb7.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', 'vhh', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '349F1F42-F3C6-4D32-8F2E-9CFEB2A3DFF5', '1484291970894');
INSERT INTO `tc_message` VALUES ('349', '20000017', 'nye', 'http://www.kmlejin.com/Uploads/Picture/20160428/s_0b18450ac870edb7.png', '', '20000000', '朱2', '', '', '', '', '', '', '骨灰盒胡', '', '', '100', '1', '199a3c68-e02a-4595-a58b-98c706beb44a', '1484291976006');
INSERT INTO `tc_message` VALUES ('350', '20000017', 'nye', 'http://www.kmlejin.com/Uploads/Picture/20160428/s_0b18450ac870edb7.png', '', '20000000', '朱2', '', '', '', '', '', '', '帮你弄', '', '', '100', '1', 'dcf9c155-b086-4233-a2e9-f5201a7546be', '1484292407817');
INSERT INTO `tc_message` VALUES ('351', '20000096', '朱2', '', '{\"from扩展\":\"从哪儿来的?\"}', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20161206/s_5752829287f74c94.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '司机的士都会', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '0EA0D853-8AB9-45ED-8B35-39345BE1C1A0', '1485168618754');
INSERT INTO `tc_message` VALUES ('352', '20000096', '朱2', '', '{\"from扩展\":\"从哪儿来的?\"}', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20161206/s_5752829287f74c94.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '司机大哥你也', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'C889513A-8D49-43BC-9AA6-A742F2AD6C90', '1485168624030');
INSERT INTO `tc_message` VALUES ('353', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20161206/s_5752829287f74c94.png', '{\"from扩展\":\"从哪儿来的?\"}', '20000096', '大丈夫', 'http://www.kmlejin.com/Uploads/Picture/20161206/s_5752829287f74c94.png', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '的士都拦不', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '52C1D6D6-87D9-4F3D-A943-78AB69B0290A', '1485168661441');
INSERT INTO `tc_message` VALUES ('354', '20000313', '哈哈哈', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '{\"from扩展\":\"从哪儿来的?\"}', '1', '天方夜谭', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', ' 的', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '200', '1', 'BFC787A2-9375-49EE-986B-C02A48D5CAEB', '1490263658596');
INSERT INTO `tc_message` VALUES ('355', '20000313', '哈哈哈', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '{\"from扩展\":\"从哪儿来的?\"}', '1', '天方夜谭', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '抹', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '200', '1', 'F398D0A4-CA0C-4EDA-A446-FC4AF5E3C68A', '1490263666224');
INSERT INTO `tc_message` VALUES ('356', '20000313', '哈哈哈', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '{\"from扩展\":\"从哪儿来的?\"}', '1', '天方夜谭', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '{\"to扩展\":\"到哪儿去?\"}', '{\"urllarge\":\"http:\\/\\/www.kmlejin.com\\/Uploads\\/Picture\\/message\\/20000313\\/20170323\\/58d39e79c5e24.mp3\",\"urlsmall\":\"http:\\/\\/www.kmlejin.com\\/Uploads\\/Picture\\/message\\/20000313\\/20170323\\/s_58d39e79c5e24.mp3\",\"width\":180,\"height\":180}', '', '', '', '', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '200', '2', 'E2B0A8F0-A2A1-4A0A-8B17-40445C72906D', '1490263673814');
INSERT INTO `tc_message` VALUES ('357', '20000313', '哈哈哈', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '{\"from扩展\":\"从哪儿来的?\"}', '1', '天方夜谭', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '哈哈', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '200', '1', '83B111A1-82A4-4C05-A220-26DB17146668', '1490263753635');
INSERT INTO `tc_message` VALUES ('358', '20000313', '哈哈哈', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '{\"from扩展\":\"从哪儿来的?\"}', '1', '天方夜谭', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '兔', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '200', '1', '97B81FBE-551F-4527-B509-3608F501AE35', '1490263830891');
INSERT INTO `tc_message` VALUES ('359', '20000313', '哈哈哈', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '{\"from扩展\":\"从哪儿来的?\"}', '1', '天方夜谭', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '{\"to扩展\":\"到哪儿去?\"}', '{\"urllarge\":\"http:\\/\\/www.kmlejin.com\\/Uploads\\/Picture\\/message\\/20000313\\/20170323\\/58d39f1b1bf49.mp3\",\"urlsmall\":\"http:\\/\\/www.kmlejin.com\\/Uploads\\/Picture\\/message\\/20000313\\/20170323\\/s_58d39f1b1bf49.mp3\",\"width\":112,\"height\":200}', '', '', '', '', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '200', '2', 'FC96C6E4-5888-4A03-A478-CC5D18AA5978', '1490263835137');
INSERT INTO `tc_message` VALUES ('360', '20000313', '哈哈哈', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '{\"from扩展\":\"从哪儿来的?\"}', '2', '经济界', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '哈哈', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '200', '1', 'DB7ECE16-BC82-48AC-9ADB-CF43A856DC03', '1490263940781');
INSERT INTO `tc_message` VALUES ('361', '20000313', '哈哈哈', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '{\"from扩展\":\"从哪儿来的?\"}', '2', '经济界', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '{\"to扩展\":\"到哪儿去?\"}', '{\"urllarge\":\"http:\\/\\/www.kmlejin.com\\/Uploads\\/Picture\\/message\\/20000313\\/20170323\\/58d39f8abfecb.mp3\",\"urlsmall\":\"http:\\/\\/www.kmlejin.com\\/Uploads\\/Picture\\/message\\/20000313\\/20170323\\/s_58d39f8abfecb.mp3\",\"width\":200,\"height\":112}', '', '', '', '', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '200', '2', '3D133CD1-BE95-405F-BFC4-0CB5849F20B7', '1490263946809');
INSERT INTO `tc_message` VALUES ('362', '20000313', '哈哈哈', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '{\"from扩展\":\"从哪儿来的?\"}', '2', '经济界', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '{\"to扩展\":\"到哪儿去?\"}', '{\"urllarge\":\"http:\\/\\/www.kmlejin.com\\/Uploads\\/Picture\\/message\\/20000313\\/20170323\\/58d39fa449400.mp3\",\"urlsmall\":\"http:\\/\\/www.kmlejin.com\\/Uploads\\/Picture\\/message\\/20000313\\/20170323\\/s_58d39fa449400.mp3\",\"width\":200,\"height\":150}', '', '', '', '', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '200', '2', '267A420A-1CB1-4CD5-8CCF-1989C018E7EC', '1490263972332');
INSERT INTO `tc_message` VALUES ('363', '20000313', '哈哈哈', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '{\"from扩展\":\"从哪儿来的?\"}', '2', '经济界', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '[emoji_343]', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '200', '1', '043390E5-DDFD-4692-92D5-25B220D052A1', '1490263977915');
INSERT INTO `tc_message` VALUES ('364', '20000313', '哈哈哈', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '{\"from扩展\":\"从哪儿来的?\"}', '1', '天方夜谭', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '{\"to扩展\":\"到哪儿去?\"}', '{\"urllarge\":\"http:\\/\\/www.kmlejin.com\\/Uploads\\/Picture\\/message\\/20000313\\/20170323\\/58d39fcca5be7.mp3\",\"urlsmall\":\"http:\\/\\/www.kmlejin.com\\/Uploads\\/Picture\\/message\\/20000313\\/20170323\\/s_58d39fcca5be7.mp3\",\"width\":112,\"height\":200}', '', '', '', '', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '200', '2', '17A24BEE-8624-4EE6-812E-C5CEE76C7E93', '1490264012702');
INSERT INTO `tc_message` VALUES ('365', '20000313', '哈哈哈', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '{\"from扩展\":\"从哪儿来的?\"}', '1', '天方夜谭', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '{\"to扩展\":\"到哪儿去?\"}', '{\"urllarge\":\"http:\\/\\/www.kmlejin.com\\/Uploads\\/Picture\\/message\\/20000313\\/20170323\\/58d3a08c85dee.mp3\",\"urlsmall\":\"http:\\/\\/www.kmlejin.com\\/Uploads\\/Picture\\/message\\/20000313\\/20170323\\/s_58d3a08c85dee.mp3\",\"width\":200,\"height\":112}', '', '', '', '', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '200', '2', '876193EF-F404-4B7F-8893-5D904D4821CD', '1490264204572');
INSERT INTO `tc_message` VALUES ('366', '20000313', '哈哈哈', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '{\"from扩展\":\"从哪儿来的?\"}', '1', '天方夜谭', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '{\"to扩展\":\"到哪儿去?\"}', '{\"urllarge\":\"http:\\/\\/www.kmlejin.com\\/Uploads\\/Picture\\/message\\/20000313\\/20170323\\/58d3a0910e784.mp3\",\"urlsmall\":\"http:\\/\\/www.kmlejin.com\\/Uploads\\/Picture\\/message\\/20000313\\/20170323\\/s_58d3a0910e784.mp3\",\"width\":180,\"height\":180}', '', '', '', '', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '200', '2', '51E2C07C-4001-4DD7-9DA9-AC6468A4FC54', '1490264209064');
INSERT INTO `tc_message` VALUES ('367', '20000313', '哈哈哈', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '{\"from扩展\":\"从哪儿来的?\"}', '1', '天方夜谭', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '[emoji_86]', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '200', '1', 'AE9CCA92-6CD1-4238-BA93-08B337A82897', '1490264218701');
INSERT INTO `tc_message` VALUES ('368', '20000313', '哈哈哈', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '{\"from扩展\":\"从哪儿来的?\"}', '1', '天方夜谭', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '果果', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '200', '1', '48676363-EA70-402C-B07E-1C62AB8B1DD0', '1490264222608');
INSERT INTO `tc_message` VALUES ('369', '20000313', '哈哈哈', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '{\"from扩展\":\"从哪儿来的?\"}', '1', '天方夜谭', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '哈哈', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '200', '1', '17503D45-C58C-4C93-85A0-2C27784572AF', '1490264392413');
INSERT INTO `tc_message` VALUES ('370', '20000313', '哈哈哈', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '{\"from扩展\":\"从哪儿来的?\"}', '1', '天方夜谭', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '阿里', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '200', '1', '7B508152-4F8E-41BF-9D27-AA2C7D18A1AB', '1490264728435');
INSERT INTO `tc_message` VALUES ('371', '20000313', '哈哈哈', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '{\"from扩展\":\"从哪儿来的?\"}', '1', '天方夜谭', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '[emoji_86]', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '200', '1', '97545484-A716-4421-8DF0-46D0A5A3DDD2', '1490264743557');
INSERT INTO `tc_message` VALUES ('372', '20000313', '哈哈哈', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '{\"from扩展\":\"从哪儿来的?\"}', '1', '天方夜谭', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', 'o', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '200', '1', '2F684D49-3CCB-47FE-8388-E6B3CC19F695', '1490264933822');
INSERT INTO `tc_message` VALUES ('373', '20000313', '哈哈哈', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '{\"from扩展\":\"从哪儿来的?\"}', '1', '天方夜谭', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '{\"to扩展\":\"到哪儿去?\"}', '{\"urllarge\":\"http:\\/\\/www.kmlejin.com\\/Uploads\\/Picture\\/message\\/20000313\\/20170323\\/58d3a369a959c.mp3\",\"urlsmall\":\"http:\\/\\/www.kmlejin.com\\/Uploads\\/Picture\\/message\\/20000313\\/20170323\\/s_58d3a369a959c.mp3\",\"width\":180,\"height\":180}', '', '', '', '', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '200', '2', '1816EEF5-57F7-462E-AD6F-B84878FB274B', '1490264937699');
INSERT INTO `tc_message` VALUES ('374', '20000313', '哈哈哈', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '{\"from扩展\":\"从哪儿来的?\"}', '1', '天方夜谭', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '{\"to扩展\":\"到哪儿去?\"}', '{\"urllarge\":\"http:\\/\\/www.kmlejin.com\\/Uploads\\/Picture\\/message\\/20000313\\/20170323\\/58d3a3730f8b3.mp3\",\"urlsmall\":\"http:\\/\\/www.kmlejin.com\\/Uploads\\/Picture\\/message\\/20000313\\/20170323\\/s_58d3a3730f8b3.mp3\",\"width\":112,\"height\":200}', '', '', '', '', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '200', '2', '23E2B3B7-346F-457A-967A-8CE7CBDE062E', '1490264947088');
INSERT INTO `tc_message` VALUES ('375', '20000313', '哈哈哈', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '{\"from扩展\":\"从哪儿来的?\"}', '1', '天方夜谭', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '果果', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '200', '1', '4E14452B-30E4-4403-BB0B-329B6E3B3219', '1490265015564');
INSERT INTO `tc_message` VALUES ('376', '20000314', 'yYY', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_507b280d0955e992.jpg', '{\"from扩展\":\"从哪儿来的?\"}', '1', '天方夜谭', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_507b280d0955e992.jpg', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '呵呵哒', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '200', '1', '742B60FD-64B0-4BF1-9D49-FA60AD415A89', '1490265086652');
INSERT INTO `tc_message` VALUES ('377', '20000313', '哈哈哈', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '{\"from扩展\":\"从哪儿来的?\"}', '1', '天方夜谭', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '{\"to扩展\":\"到哪儿去?\"}', '{\"urllarge\":\"http:\\/\\/www.kmlejin.com\\/Uploads\\/Picture\\/message\\/20000313\\/20170323\\/58d3a3ff5e5a9.mp3\",\"urlsmall\":\"http:\\/\\/www.kmlejin.com\\/Uploads\\/Picture\\/message\\/20000313\\/20170323\\/s_58d3a3ff5e5a9.mp3\",\"width\":112,\"height\":200}', '', '', '', '', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '200', '2', '80D321AA-D54A-493E-9AA6-7D2F683A70F4', '1490265087412');
INSERT INTO `tc_message` VALUES ('378', '20000314', 'yYY', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_507b280d0955e992.jpg', '{\"from扩展\":\"从哪儿来的?\"}', '1', '天方夜谭', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_507b280d0955e992.jpg', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '呵呵哒吧', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '200', '1', '5E588BB5-F90C-43CE-A5C8-31C5C99A56C7', '1490265126957');
INSERT INTO `tc_message` VALUES ('379', '20000315', '呀呀', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_1d84cb873dfffdb7.jpg', '{\"from扩展\":\"从哪儿来的?\"}', '1', '天方夜谭', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_1d84cb873dfffdb7.jpg', '{\"to扩展\":\"到哪儿去?\"}', '{\"urllarge\":\"http:\\/\\/www.kmlejin.com\\/Uploads\\/Picture\\/message\\/20000315\\/20170323\\/58d3a493370da.mp3\",\"urlsmall\":\"http:\\/\\/www.kmlejin.com\\/Uploads\\/Picture\\/message\\/20000315\\/20170323\\/s_58d3a493370da.mp3\",\"width\":200,\"height\":112}', '', '', '', '', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '200', '2', '317FF156-CD2A-4A4A-8287-79360307B500', '1490265235249');
INSERT INTO `tc_message` VALUES ('380', '20000314', 'yYY', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_507b280d0955e992.jpg', '{\"from扩展\":\"从哪儿来的?\"}', '1', '天方夜谭', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_507b280d0955e992.jpg', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '[emoji_353][emoji_353][emoji_353]', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '200', '1', 'C887EBAF-6174-476C-ACE2-07AFFBD4EF4A', '1490265349648');
INSERT INTO `tc_message` VALUES ('381', '20000315', '呀呀', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_1d84cb873dfffdb7.jpg', '{\"from扩展\":\"从哪儿来的?\"}', '1', '天方夜谭', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_1d84cb873dfffdb7.jpg', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '哈哈', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '200', '1', '620343D5-EB19-4F11-B77A-A1AD67AFEA03', '1490265468495');
INSERT INTO `tc_message` VALUES ('382', '20000315', '呀呀', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_1d84cb873dfffdb7.jpg', '{\"from扩展\":\"从哪儿来的?\"}', '1', '天方夜谭', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_1d84cb873dfffdb7.jpg', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '好', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '200', '1', 'F777AB6A-462F-4600-B031-3E024A3DA486', '1490265558332');
INSERT INTO `tc_message` VALUES ('383', '20000314', 'yYY', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_507b280d0955e992.jpg', '{\"from扩展\":\"从哪儿来的?\"}', '1', '天方夜谭', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_507b280d0955e992.jpg', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '[emoji_165][emoji_165][emoji_165]', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '200', '1', '25DF4584-FEE0-4E20-B497-E3E427387F68', '1490265609291');
INSERT INTO `tc_message` VALUES ('384', '20000312', '铁路局', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_da8b60990cae7897.png', '', '1', '天方夜谭', '', '', '', '', '', '', 'Vvvv', '', '', '200', '1', '9f125f34-3d30-4d03-859a-9575e90881d8', '1490320411443');
INSERT INTO `tc_message` VALUES ('385', '20000312', '铁路局', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_da8b60990cae7897.png', '', '1', '天方夜谭', '', '', '{\"urllarge\":\"http:\\/\\/www.kmlejin.com\\/Uploads\\/Picture\\/message\\/20000312\\/20170324\\/58d47c2aab033.png\",\"urlsmall\":\"http:\\/\\/www.kmlejin.com\\/Uploads\\/Picture\\/message\\/20000312\\/20170324\\/s_58d47c2aab033.png\",\"width\":112,\"height\":200}', '', '', '', '', '', '', '200', '2', '52d2cff4-53fa-4900-a68b-b8a116d3c425', '1490320426743');
INSERT INTO `tc_message` VALUES ('386', '20000312', '铁路局', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_da8b60990cae7897.png', '', '1', '天方夜谭', '', '', '{\"urllarge\":\"http:\\/\\/www.kmlejin.com\\/Uploads\\/Picture\\/message\\/20000312\\/20170324\\/58d47c2e8b136.jpg\",\"urlsmall\":\"http:\\/\\/www.kmlejin.com\\/Uploads\\/Picture\\/message\\/20000312\\/20170324\\/s_58d47c2e8b136.jpg\",\"width\":112,\"height\":200}', '', '', '', '', '', '', '200', '2', 'd0c9467a-e457-438d-9bdb-f712ff76a762', '1490320430639');
INSERT INTO `tc_message` VALUES ('387', '20000312', '铁路局', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_da8b60990cae7897.png', '', '1', '天方夜谭', '', '', '', '', '', '', 'Bhbb', '', '', '200', '1', 'cb1cf3ea-1404-4569-9424-dfd727adcd7c', '1490320443250');
INSERT INTO `tc_message` VALUES ('388', '20000312', '铁路局', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_da8b60990cae7897.png', '', '1', '天方夜谭', '', '', '', '', '', '', 'Bhbnbv', '', '', '200', '1', 'a162c649-8697-4b7e-848c-ab06de32d0f7', '1490320447026');
INSERT INTO `tc_message` VALUES ('389', '20000312', '铁路局', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_da8b60990cae7897.png', '', '2', '经济界', '', '', '', '', '', '', 'Chvhhj', '', '', '200', '1', '892438aa-09ef-4fe5-8304-c7dd7b10d42b', '1490320453423');
INSERT INTO `tc_message` VALUES ('390', '20000312', '铁路局', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_da8b60990cae7897.png', '', '2', '经济界', '', '', '', '', '', '', 'Ghvbv', '', '', '200', '1', 'add252f7-53f5-420a-b459-b50b59862f4e', '1490320457386');
INSERT INTO `tc_message` VALUES ('391', '20000315', '呀呀', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_1d84cb873dfffdb7.jpg', '{\"from扩展\":\"从哪儿来的?\"}', '1', '天方夜谭', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_1d84cb873dfffdb7.jpg', '{\"to扩展\":\"到哪儿去?\"}', '{\"urllarge\":\"http:\\/\\/www.kmlejin.com\\/Uploads\\/Picture\\/message\\/20000315\\/20170324\\/58d47c4b2fee5.mp3\",\"urlsmall\":\"http:\\/\\/www.kmlejin.com\\/Uploads\\/Picture\\/message\\/20000315\\/20170324\\/s_58d47c4b2fee5.mp3\",\"width\":112,\"height\":200}', '', '', '', '', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '200', '2', '4888DE15-D6F2-49B4-B89E-BC046D98629F', '1490320459220');
INSERT INTO `tc_message` VALUES ('392', '20000315', '呀呀', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_1d84cb873dfffdb7.jpg', '{\"from扩展\":\"从哪儿来的?\"}', '1', '天方夜谭', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_1d84cb873dfffdb7.jpg', '{\"to扩展\":\"到哪儿去?\"}', '{\"urllarge\":\"http:\\/\\/www.kmlejin.com\\/Uploads\\/Picture\\/message\\/20000315\\/20170324\\/58d47c5d97578.mp3\",\"urlsmall\":\"http:\\/\\/www.kmlejin.com\\/Uploads\\/Picture\\/message\\/20000315\\/20170324\\/s_58d47c5d97578.mp3\",\"width\":200,\"height\":112}', '', '', '', '', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '200', '2', '768AB3A5-0882-43AF-9B5C-2E6DD8867570', '1490320477644');
INSERT INTO `tc_message` VALUES ('393', '20000315', '呀呀', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_1d84cb873dfffdb7.jpg', '{\"from扩展\":\"从哪儿来的?\"}', '1', '天方夜谭', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_1d84cb873dfffdb7.jpg', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '果果', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '200', '1', '67C72E74-0E5C-43F3-A476-06D031833199', '1490320483509');
INSERT INTO `tc_message` VALUES ('394', '20000314', 'yYY', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_507b280d0955e992.jpg', '', '1', '天方夜谭', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_1d84cb873dfffdb7.jpg', '', '{\"urllarge\":\"http:\\/\\/www.kmlejin.com\\/Uploads\\/Picture\\/message\\/20000314\\/20170324\\/58d47ea298c50.jpg\",\"urlsmall\":\"http:\\/\\/www.kmlejin.com\\/Uploads\\/Picture\\/message\\/20000314\\/20170324\\/s_58d47ea298c50.jpg\",\"width\":112,\"height\":200}', '', '', '', '', '', '', '200', '2', '472ea638-4b2f-42e1-92c7-31141d2a83c2', '1490321058691');
INSERT INTO `tc_message` VALUES ('395', '20000314', 'yYY', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_507b280d0955e992.jpg', '', '1', '天方夜谭', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_1d84cb873dfffdb7.jpg', '', '', '', '', '', '[emoji_85][emoji_86][emoji_346]', '', '', '200', '1', '4eabc475-3246-4214-9cb9-a4d93eea3f4a', '1490321061950');
INSERT INTO `tc_message` VALUES ('396', '20000314', 'yYY', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_507b280d0955e992.jpg', '', '1', '天方夜谭', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_1d84cb873dfffdb7.jpg', '', '', '', '', '', '抱抱你', '', '', '200', '1', 'ce27dccf-b605-47c4-b3eb-bdb255c85a43', '1490321065249');
INSERT INTO `tc_message` VALUES ('397', '20000313', '哈哈哈', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '', '2', '经济界', '', '', '', '', '', '', '那你呢', '', '', '200', '1', '303af774-d575-40d9-bba1-c95078337ace', '1490321161794');
INSERT INTO `tc_message` VALUES ('398', '20000313', '哈哈哈', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '', '2', '经济界', '', '', '', '', '', '', '[emoji_85]', '', '', '200', '1', 'f91e559d-9eb1-4c76-a65d-1032b61a3ca8', '1490321179248');
INSERT INTO `tc_message` VALUES ('399', '20000314', 'yYY', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_507b280d0955e992.jpg', '{\"from扩展\":\"从哪儿来的?\"}', '2', '经济界', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_507b280d0955e992.jpg', '{\"to扩展\":\"到哪儿去?\"}', '{\"urllarge\":\"http:\\/\\/www.kmlejin.com\\/Uploads\\/Picture\\/message\\/20000314\\/20170324\\/58d47f216ba12.mp3\",\"urlsmall\":\"http:\\/\\/www.kmlejin.com\\/Uploads\\/Picture\\/message\\/20000314\\/20170324\\/s_58d47f216ba12.mp3\",\"width\":112,\"height\":200}', '', '', '', '', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '200', '2', '34818056-B345-4FE9-865F-0A520B775E7A', '1490321185464');
INSERT INTO `tc_message` VALUES ('400', '20000314', 'yYY', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_507b280d0955e992.jpg', '{\"from扩展\":\"从哪儿来的?\"}', '2', '经济界', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_507b280d0955e992.jpg', '{\"to扩展\":\"到哪儿去?\"}', '{\"urllarge\":\"http:\\/\\/www.kmlejin.com\\/Uploads\\/Picture\\/message\\/20000314\\/20170324\\/58d47f2f3ae8c.mp3\",\"urlsmall\":\"http:\\/\\/www.kmlejin.com\\/Uploads\\/Picture\\/message\\/20000314\\/20170324\\/s_58d47f2f3ae8c.mp3\",\"width\":200,\"height\":112}', '', '', '', '', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '200', '2', '4BDB6F50-5B22-4656-B3F2-7C0A08771655', '1490321199263');
INSERT INTO `tc_message` VALUES ('401', '20000314', 'yYY', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_507b280d0955e992.jpg', '{\"from扩展\":\"从哪儿来的?\"}', '2', '经济界', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_507b280d0955e992.jpg', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '我们', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '200', '1', '7FC3EBA1-E0E6-4874-AC2C-18175E69D426', '1490321202365');
INSERT INTO `tc_message` VALUES ('402', '20000313', '哈哈哈', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '', '2', '经济界', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_507b280d0955e992.jpg', '', '', '', '', '', '那你呢', '', '', '200', '1', 'd1e33229-a209-48e3-87a5-4d9e0213a1d1', '1490321232742');
INSERT INTO `tc_message` VALUES ('403', '20000313', '哈哈哈', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '', '1', '天方夜谭', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_1d84cb873dfffdb7.jpg', '', '', '', '', '', '', '', '', '200', '1', 'c6283f65-ee54-4fe6-859f-8eff8fe4cfbc', '1490321358677');
INSERT INTO `tc_message` VALUES ('404', '20000313', '哈哈哈', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '', '1', '天方夜谭', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_1d84cb873dfffdb7.jpg', '', '{\"urllarge\":\"http:\\/\\/www.kmlejin.com\\/Uploads\\/Picture\\/message\\/20000313\\/20170324\\/58d47fd57991f.jpg\",\"urlsmall\":\"http:\\/\\/www.kmlejin.com\\/Uploads\\/Picture\\/message\\/20000313\\/20170324\\/s_58d47fd57991f.jpg\",\"width\":112,\"height\":200}', '', '', '', '', '', '', '200', '2', 'cc913a39-c011-4758-9d01-ce40c68a482f', '1490321365571');
INSERT INTO `tc_message` VALUES ('405', '20000313', '哈哈哈', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '', '3', '科技创新', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_1d175e564f0941c7.png', '{\"topicmsg\":\"1\"}', '', '', '', '', '那你呢', '', '', '200', '1', '8fe16b7b-e6bb-42b6-a63c-578f22fbe242', '1490321610102');
INSERT INTO `tc_message` VALUES ('406', '20000315', '呀呀', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_1d84cb873dfffdb7.jpg', '{}', '3', '科技创新', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_1d84cb873dfffdb7.jpg', '{\"topicmsg\":\"1\"}', '', '', '', '', '咯', '{}', '{}', '200', '1', '190DF062-DAD9-4714-B298-D007DDE2DB09', '1490321627561');
INSERT INTO `tc_message` VALUES ('407', '20000314', 'yYY', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_507b280d0955e992.jpg', '{\"from扩展\":\"从哪儿来的?\"}', '2', '经济界', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_507b280d0955e992.jpg', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '陌陌', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '200', '1', '4C9B3E51-96D7-4B66-B5CC-10E8BD6A4C89', '1490325209189');
INSERT INTO `tc_message` VALUES ('408', '20000314', 'yYY', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_507b280d0955e992.jpg', '{\"from扩展\":\"从哪儿来的?\"}', '2', '经济界', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_507b280d0955e992.jpg', '{\"to扩展\":\"到哪儿去?\"}', '{\"urllarge\":\"http:\\/\\/www.kmlejin.com\\/Uploads\\/Picture\\/message\\/20000314\\/20170324\\/58d48ede4d1f3.mp3\",\"urlsmall\":\"http:\\/\\/www.kmlejin.com\\/Uploads\\/Picture\\/message\\/20000314\\/20170324\\/s_58d48ede4d1f3.mp3\",\"width\":112,\"height\":200}', '', '', '', '', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '200', '2', '7166CD39-493C-4769-AF4D-D840CE912280', '1490325214341');
INSERT INTO `tc_message` VALUES ('409', '20000313', '哈哈哈', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '', '3', '科技创新', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_1d175e564f0941c7.png', '{\"topicmsg\":\"1\"}', '', '', '', '', '把你那', '', '', '200', '1', '44f912fe-e308-411d-b9bb-3ae4efb51da1', '1490327581081');
INSERT INTO `tc_message` VALUES ('410', '20000313', '哈哈哈', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '', '3', '科技创新', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_1d175e564f0941c7.png', '{\"topicmsg\":\"1\"}', '{\"urllarge\":\"http:\\/\\/www.kmlejin.com\\/Uploads\\/Picture\\/message\\/20000313\\/20170324\\/58d4982700e5d.jpg\",\"urlsmall\":\"http:\\/\\/www.kmlejin.com\\/Uploads\\/Picture\\/message\\/20000313\\/20170324\\/s_58d4982700e5d.jpg\",\"width\":112,\"height\":200}', '', '', '', '', '', '', '200', '2', '0851d7f5-1a9c-4471-900e-fc44a1fc2c8d', '1490327591076');
INSERT INTO `tc_message` VALUES ('411', '20000313', '哈哈哈', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '', '3', '科技创新', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_1d175e564f0941c7.png', '{\"topicmsg\":\"1\"}', '', '', '', '', '没', '', '', '200', '1', '213a2aa0-87fa-440a-b27e-5d462a53f8c6', '1490327593321');
INSERT INTO `tc_message` VALUES ('412', '20000313', '哈哈哈', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '', '3', '科技创新', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_1d175e564f0941c7.png', '{\"topicmsg\":\"1\"}', '', '', '', '', '[emoji_85]', '', '', '200', '1', '33d9688d-0506-4a50-8bd1-87460cd3d24d', '1490327596089');
INSERT INTO `tc_message` VALUES ('413', '20000315', '呀呀', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_1d84cb873dfffdb7.jpg', '', '3', '科技创新', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_1d175e564f0941c7.png', '{\"topicmsg\":\"1\"}', '', '', '', '', '你呢', '', '', '200', '1', 'c95a3778-0ed0-455f-b6f4-3040cb77961d', '1490327621416');
INSERT INTO `tc_message` VALUES ('414', '20000315', '呀呀', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_1d84cb873dfffdb7.jpg', '', '3', '科技创新', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_1d175e564f0941c7.png', '{\"topicmsg\":\"1\"}', '', '', '', '', '[emoji_85]', '', '', '200', '1', '64566de6-dc38-485a-966d-a2137b048a05', '1490327624512');
INSERT INTO `tc_message` VALUES ('415', '20000315', '呀呀', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_1d84cb873dfffdb7.jpg', '', '20000313', '哈哈哈', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '', '', '', '', '', '你呢', '', '', '100', '1', 'e00ec3f5-fe27-42cf-bb15-983c09336c10', '1490327674812');
INSERT INTO `tc_message` VALUES ('416', '20000315', '呀呀', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_1d84cb873dfffdb7.jpg', '', '20000313', '哈哈哈', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '', '{\"urllarge\":\"http:\\/\\/www.kmlejin.com\\/Uploads\\/Picture\\/message\\/20000315\\/20170324\\/58d49882a5499.jpg\",\"urlsmall\":\"http:\\/\\/www.kmlejin.com\\/Uploads\\/Picture\\/message\\/20000315\\/20170324\\/s_58d49882a5499.jpg\",\"width\":112,\"height\":200}', '', '', '', '', '', '', '100', '2', 'c2978f42-96e8-464f-8aa5-17705129af29', '1490327682748');
INSERT INTO `tc_message` VALUES ('417', '20000316', 'uu', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_d07e2674a5e4b5ce.jpg', '', '20000314', 'yYY', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_507b280d0955e992.jpg', '', '', '', '', '', '今年', '', '', '100', '1', 'b011c14d-e07d-43d8-ab26-372312016f76', '1490327791794');
INSERT INTO `tc_message` VALUES ('418', '20000314', 'yYY', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_507b280d0955e992.jpg', '', '20000316', 'uu', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_d07e2674a5e4b5ce.jpg', '', '', '', '', '', '比较', '', '', '100', '1', '450f1407-cd82-4fb6-82d4-62a31f0f05df', '1490327826275');
INSERT INTO `tc_message` VALUES ('419', '20000316', 'uu', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_d07e2674a5e4b5ce.jpg', '', '20000314', 'yYY', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_507b280d0955e992.jpg', '', '', '', '', '', '今年', '', '', '100', '1', 'f4bbbe5c-0234-48ad-9026-e77b88c8a26e', '1490327895387');
INSERT INTO `tc_message` VALUES ('420', '20000316', 'uu', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_d07e2674a5e4b5ce.jpg', '', '20000314', 'yYY', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_507b280d0955e992.jpg', '', '', '', '', '', '[emoji_85]', '', '', '100', '1', 'd5cad7a2-0b56-4845-87f8-c7adf46b0a48', '1490327897324');
INSERT INTO `tc_message` VALUES ('421', '20000316', 'uu', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_d07e2674a5e4b5ce.jpg', '', '20000314', 'yYY', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_507b280d0955e992.jpg', '', '', '', '', '', '和欧美的', '', '', '100', '1', '86f91a99-7470-4bd4-b8b5-f4fcf979ab57', '1490327902054');
INSERT INTO `tc_message` VALUES ('422', '20000316', 'uu', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_d07e2674a5e4b5ce.jpg', '', '20000314', 'yYY', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_507b280d0955e992.jpg', '', '{\"urllarge\":\"http:\\/\\/www.kmlejin.com\\/Uploads\\/Picture\\/message\\/20000316\\/20170324\\/58d49961c83b0.jpg\",\"urlsmall\":\"http:\\/\\/www.kmlejin.com\\/Uploads\\/Picture\\/message\\/20000316\\/20170324\\/s_58d49961c83b0.jpg\",\"width\":112,\"height\":200}', '', '', '', '', '', '', '100', '2', 'e328665f-b196-4093-9214-93af8ee7e160', '1490327905885');
INSERT INTO `tc_message` VALUES ('423', '20000314', 'yYY', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_507b280d0955e992.jpg', '', '20000316', 'uu', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_d07e2674a5e4b5ce.jpg', '', '', '', '', '', '那就看', '', '', '100', '1', 'f0bbdb13-2f64-4aaf-87b3-ba71cdaaac60', '1490327932592');
INSERT INTO `tc_message` VALUES ('424', '20000314', 'yYY', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_507b280d0955e992.jpg', '', '20000316', 'uu', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_d07e2674a5e4b5ce.jpg', '', '{\"urllarge\":\"http:\\/\\/www.kmlejin.com\\/Uploads\\/Picture\\/message\\/20000314\\/20170324\\/58d49981c8c09.jpg\",\"urlsmall\":\"http:\\/\\/www.kmlejin.com\\/Uploads\\/Picture\\/message\\/20000314\\/20170324\\/s_58d49981c8c09.jpg\",\"width\":112,\"height\":200}', '', '', '', '', '', '', '100', '2', '61771f96-6509-4ae0-a537-c8fd73952daf', '1490327937886');
INSERT INTO `tc_message` VALUES ('425', '20000316', 'uu', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_d07e2674a5e4b5ce.jpg', '', '4', '乐视', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_4761ffbc2549cbb5.jpg', '{\"topicmsg\":\"1\"}', '', '', '', '', '。你们', '', '', '200', '1', 'b67ac0ad-0a67-4971-b57e-711294e43a20', '1490328084215');
INSERT INTO `tc_message` VALUES ('426', '20000313', '哈哈哈', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '', '3', '科技创新', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_1d175e564f0941c7.png', '{\"topicmsg\":\"1\"}', '', '', '', '', '那你呢', '', '', '200', '1', 'b58611fd-7a3e-4a13-bc91-467598d5e081', '1490328311334');
INSERT INTO `tc_message` VALUES ('427', '20000315', '呀呀', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_1d84cb873dfffdb7.jpg', '', '3', '科技创新', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_1d175e564f0941c7.png', '{\"topicmsg\":\"1\"}', '', '', '', '', 'Guggu', '', '', '200', '1', 'd0c90649-61e9-4374-8202-f2e67858c692', '1490328317900');
INSERT INTO `tc_message` VALUES ('428', '20000313', '哈哈哈', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '', '20000315', '呀呀', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_1d84cb873dfffdb7.jpg', '', '', '', '', '', '几觉', '', '', '100', '1', 'ecf36aa6-0470-4dff-8e2e-8c1667fcfec6', '1490328370322');
INSERT INTO `tc_message` VALUES ('429', '20000315', '呀呀', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_1d84cb873dfffdb7.jpg', '', '20000313', '哈哈哈', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '', '', '', '', '', 'Vhvhc', '', '', '100', '1', '4174dfaa-cc76-4c43-8fc7-2d7914f05405', '1490328385412');
INSERT INTO `tc_message` VALUES ('430', '20000315', '呀呀', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_1d84cb873dfffdb7.jpg', '', '20000313', '哈哈哈', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '', '', '', '', '', 'Vhvfg', '', '', '100', '1', '71a15b47-f545-4df9-afea-a012981ebaa0', '1490328391645');
INSERT INTO `tc_message` VALUES ('431', '20000313', '哈哈哈', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '', '2', '经济界', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_507b280d0955e992.jpg', '', '', '', '', '', '解决吧', '', '', '200', '1', '870f0aa6-02ac-4eed-acfe-03fbdebdc6b1', '1490328494518');
INSERT INTO `tc_message` VALUES ('432', '20000313', '哈哈哈', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '', '3', '科技创新', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_1d175e564f0941c7.png', '{\"topicmsg\":\"1\"}', '', '', '', '', '你们那', '', '', '200', '1', '9ccccc85-c9c2-4118-bd39-b7834196c493', '1490332098094');
INSERT INTO `tc_message` VALUES ('433', '20000313', '哈哈哈', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '{\"from扩展\":\"从哪儿来的?\"}', '1', '天方夜谭', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '无www', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '200', '1', '10398271-F24D-4776-9991-C22CBCC0B810', '1490333565577');
INSERT INTO `tc_message` VALUES ('434', '20000313', '哈哈哈', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '{\"from扩展\":\"从哪儿来的?\"}', '1', '天方夜谭', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '磨', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '200', '1', '6ADA421F-2F34-4D6C-9EF1-607C2370E170', '1490333569057');
INSERT INTO `tc_message` VALUES ('435', '20000313', '哈哈哈', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '{\"from扩展\":\"从哪儿来的?\"}', '1', '天方夜谭', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '{\"to扩展\":\"到哪儿去?\"}', '{\"urllarge\":\"http:\\/\\/www.kmlejin.com\\/Uploads\\/Picture\\/message\\/20000313\\/20170324\\/58d4af854d5b9.mp3\",\"urlsmall\":\"http:\\/\\/www.kmlejin.com\\/Uploads\\/Picture\\/message\\/20000313\\/20170324\\/s_58d4af854d5b9.mp3\",\"width\":112,\"height\":200}', '', '', '', '', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '200', '2', 'EF664FFA-B087-4956-8733-1CCA9B9CA8B3', '1490333573341');
INSERT INTO `tc_message` VALUES ('436', '10000000', '管理员', '', '', '20000313', '', '', '', '', '', '', '', '您好，您的账户余额已不足，请及时充值，以免影响正常销售！', '', '', '100', '1', '1490334867192', '1490334867192');
INSERT INTO `tc_message` VALUES ('437', '20000316', 'uu', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_d07e2674a5e4b5ce.jpg', '', '1', '天方夜谭', '', '', '', '', '', '', '尽快', '', '', '200', '1', 'f78b8899-1740-42ec-9f4e-d62c3186b9ad', '1490335035348');
INSERT INTO `tc_message` VALUES ('438', '20000316', 'uu', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_d07e2674a5e4b5ce.jpg', '', '1', '天方夜谭', '', '', '', '', '', '', '你可能', '', '', '200', '1', 'b0c42611-7d5e-41ac-9338-58a48d378fcd', '1490335038056');
INSERT INTO `tc_message` VALUES ('439', '20000316', 'uu', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_d07e2674a5e4b5ce.jpg', '', '1', '天方夜谭', '', '', '', '', '', '', '[emoji_88][emoji_346][emoji_347][emoji_354][emoji_354]', '', '', '200', '1', '07f79a4c-3136-47a2-b4d7-5e5bf3fa47ff', '1490335041042');
INSERT INTO `tc_message` VALUES ('440', '20000316', 'uu', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_d07e2674a5e4b5ce.jpg', '', '1', '天方夜谭', '', '', '{\"urllarge\":\"http:\\/\\/www.kmlejin.com\\/Uploads\\/Picture\\/message\\/20000316\\/20170324\\/58d4b5799d1ce.jpg\",\"urlsmall\":\"http:\\/\\/www.kmlejin.com\\/Uploads\\/Picture\\/message\\/20000316\\/20170324\\/s_58d4b5799d1ce.jpg\",\"width\":112,\"height\":200}', '', '', '', '', '', '', '200', '2', '12c646a4-6171-4d31-94cf-90a630991d89', '1490335098191');
INSERT INTO `tc_message` VALUES ('441', '20000313', '哈哈哈', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '', '1', '天方夜谭', '', '', '', '', '', '', '不能', '', '', '200', '1', '2104a988-5ff7-4b57-800a-aa1b9a2387e6', '1490335108966');
INSERT INTO `tc_message` VALUES ('442', '20000316', 'uu', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_d07e2674a5e4b5ce.jpg', '', '4', '乐视', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_4761ffbc2549cbb5.jpg', '{\"topicmsg\":\"1\"}', '', '', '', '', '就看看你', '', '', '200', '1', '388f8ec8-5d4a-4635-a677-b46936c4507a', '1490337242062');
INSERT INTO `tc_message` VALUES ('443', '20000316', 'uu', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_d07e2674a5e4b5ce.jpg', '', '4', '乐视', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_4761ffbc2549cbb5.jpg', '{\"topicmsg\":\"1\"}', '', '', '', '', '看', '', '', '200', '1', 'deda4f2d-6ae0-40d0-a1af-f1745fd6d285', '1490337272136');
INSERT INTO `tc_message` VALUES ('444', '20000312', '铁路局', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_da8b60990cae7897.png', '', '4', '乐视', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_4761ffbc2549cbb5.jpg', '{\"topicmsg\":\"1\"}', '', '', '', '', 'Gyhhh', '', '', '200', '1', '270fc5dc-dd47-4588-9807-2eeb5a6c3d9f', '1490337281286');
INSERT INTO `tc_message` VALUES ('445', '20000315', '呀呀', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_1d84cb873dfffdb7.jpg', '', '3', '科技创新', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_1d175e564f0941c7.png', '{\"topicmsg\":\"1\"}', '', '', '', '', '我现在', '', '', '200', '1', '7bba4ed9-ac33-48ac-91b3-1cd9fe1c7d07', '1490337711716');
INSERT INTO `tc_message` VALUES ('446', '20000315', '呀呀', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_1d84cb873dfffdb7.jpg', '', '3', '科技创新', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_1d175e564f0941c7.png', '{\"topicmsg\":\"1\"}', '', '', '', '', '[emoji_88][emoji_340][emoji_341][emoji_341]', '', '', '200', '1', '3a50d653-1f4a-42ed-b65b-17aebe109f0c', '1490337716167');
INSERT INTO `tc_message` VALUES ('447', '20000315', '呀呀', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_1d84cb873dfffdb7.jpg', '', '3', '科技创新', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_1d175e564f0941c7.png', '{\"topicmsg\":\"1\"}', '{\"urllarge\":\"http:\\/\\/www.kmlejin.com\\/Uploads\\/Picture\\/message\\/20000315\\/20170324\\/58d4bfc7d2c1c.jpg\",\"urlsmall\":\"http:\\/\\/www.kmlejin.com\\/Uploads\\/Picture\\/message\\/20000315\\/20170324\\/s_58d4bfc7d2c1c.jpg\",\"width\":112,\"height\":200}', '', '', '', '', '', '', '200', '2', 'feafc167-662c-4550-965f-e079d09ef228', '1490337735932');
INSERT INTO `tc_message` VALUES ('448', '20000312', '铁路局', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_da8b60990cae7897.png', '', '4', '乐视', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_4761ffbc2549cbb5.jpg', '{\"topicmsg\":\"1\"}', '', '', '', '', '不会后悔', '', '', '200', '1', '9b8178f0-c410-4374-b63a-f97d2e95e9ee', '1490337736242');
INSERT INTO `tc_message` VALUES ('449', '20000312', '铁路局', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_da8b60990cae7897.png', '', '1', '天方夜谭', '', '', '', '', '', '', '不故乡', '', '', '200', '1', '9bf29006-2540-4c73-b853-909f48392eae', '1490337751147');
INSERT INTO `tc_message` VALUES ('450', '20000315', '呀呀', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_1d84cb873dfffdb7.jpg', '', '1', '天方夜谭', '', '', '', '', '', '', '我', '', '', '200', '1', 'efad47dc-5970-4c0f-b2ee-a097fcb2ea01', '1490337759195');
INSERT INTO `tc_message` VALUES ('451', '20000315', '呀呀', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_1d84cb873dfffdb7.jpg', '', '1', '天方夜谭', '', '', '', '', '', '', '图', '', '', '200', '1', 'b0ca648c-0ad9-4b79-841f-d10d248a1c62', '1490337763523');
INSERT INTO `tc_message` VALUES ('452', '20000312', '铁路局', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_da8b60990cae7897.png', '', '4', '乐视', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_4761ffbc2549cbb5.jpg', '{\"topicmsg\":\"1\"}', '', '', '', '', '吃一个刚刚', '', '', '200', '1', '9ec7c6fa-0644-477b-bb15-d06ab927c786', '1490337770205');
INSERT INTO `tc_message` VALUES ('453', '20000315', '呀呀', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_1d84cb873dfffdb7.jpg', '', '3', '科技创新', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_1d175e564f0941c7.png', '{\"topicmsg\":\"1\"}', '', '', '', '', '你消息', '', '', '200', '1', 'c8ac6fc6-5177-49f7-9729-69d6b346af71', '1490337773999');
INSERT INTO `tc_message` VALUES ('454', '20000315', '呀呀', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_1d84cb873dfffdb7.jpg', '', '3', '科技创新', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_1d175e564f0941c7.png', '{\"topicmsg\":\"1\"}', '{\"urllarge\":\"http:\\/\\/www.kmlejin.com\\/Uploads\\/Picture\\/message\\/20000315\\/20170324\\/58d4c001215d2.jpg\",\"urlsmall\":\"http:\\/\\/www.kmlejin.com\\/Uploads\\/Picture\\/message\\/20000315\\/20170324\\/s_58d4c001215d2.jpg\",\"width\":112,\"height\":200}', '', '', '', '', '', '', '200', '2', 'c9930666-8078-4e56-8172-70d67a001ca6', '1490337793206');
INSERT INTO `tc_message` VALUES ('455', '20000313', '哈哈哈', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '{}', '3', '科技创新', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '{\"topicmsg\":\"1\"}', '', '', '', '', '磨', '{}', '{}', '200', '1', '5F5DE606-8834-4A3F-8255-70B55533A1DA', '1490337806270');
INSERT INTO `tc_message` VALUES ('456', '20000312', '铁路局', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_da8b60990cae7897.png', '', '4', '乐视', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_4761ffbc2549cbb5.jpg', '{\"topicmsg\":\"1\"}', '', '', '', '', '吃一个刚刚', '', '', '200', '1', 'c472bf88-887b-4822-9da4-71385a047bef', '1490337921241');
INSERT INTO `tc_message` VALUES ('457', '20000312', '铁路局', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_da8b60990cae7897.png', '', '4', '乐视', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_4761ffbc2549cbb5.jpg', '{\"topicmsg\":\"1\"}', '', '', '', '', '国有股换个', '', '', '200', '1', '8ed42606-dcf9-4064-9a86-812c47383b94', '1490337925421');
INSERT INTO `tc_message` VALUES ('458', '20000315', '呀呀', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_1d84cb873dfffdb7.jpg', '', '4', '乐视', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_4761ffbc2549cbb5.jpg', '{\"topicmsg\":\"1\"}', '', '', '', '', '磨子', '', '', '200', '1', 'b163b882-f86f-4a9c-a343-ff132f51db47', '1490337957540');
INSERT INTO `tc_message` VALUES ('459', '20000312', '铁路局', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_da8b60990cae7897.png', '', '4', '乐视', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_4761ffbc2549cbb5.jpg', '{\"topicmsg\":\"1\"}', '', '', '', '', '回个消息啦', '', '', '200', '1', 'd53e56c6-d06f-486d-b6bd-e887235086a6', '1490338426342');
INSERT INTO `tc_message` VALUES ('460', '20000315', '呀呀', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_1d84cb873dfffdb7.jpg', '', '4', '乐视', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_4761ffbc2549cbb5.jpg', '{\"topicmsg\":\"1\"}', '', '', '', '', '我现在在', '', '', '200', '1', 'd02192b7-3f0c-4a74-9dfc-767358bacc43', '1490338685540');
INSERT INTO `tc_message` VALUES ('461', '20000315', '呀呀', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_1d84cb873dfffdb7.jpg', '', '4', '乐视', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_4761ffbc2549cbb5.jpg', '{\"topicmsg\":\"1\"}', '', '', '', '', ' 需要', '', '', '200', '1', '5de1c3bd-83d4-477f-9b7b-f7e8f8cccd5a', '1490338699395');
INSERT INTO `tc_message` VALUES ('462', '20000315', '呀呀', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_1d84cb873dfffdb7.jpg', '', '1', '天方夜谭', '', '', '', '', '', '', ' ?需要', '', '', '200', '1', '7a6af053-14d1-49de-894c-eefbe36dd9b1', '1490338713451');
INSERT INTO `tc_message` VALUES ('463', '20000315', '呀呀', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_1d84cb873dfffdb7.jpg', '', '1', '天方夜谭', '', '', '', '', '', '', '我现在', '', '', '200', '1', '70e88066-aff8-4b29-bda3-6c5266722ccb', '1490338717196');
INSERT INTO `tc_message` VALUES ('464', '20000315', '呀呀', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_1d84cb873dfffdb7.jpg', '', '1', '天方夜谭', '', '', '', '', '', '', '你', '', '', '200', '1', '42cf9206-e90c-4158-a01c-d94303f9b9bc', '1490338721973');
INSERT INTO `tc_message` VALUES ('465', '20000315', '呀呀', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_1d84cb873dfffdb7.jpg', '{}', '3', '科技创新', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_1d84cb873dfffdb7.jpg', '{\"topicmsg\":\"1\"}', '', '', '', '', '磨', '{}', '{}', '200', '1', '389EA893-6E97-4147-91D8-00FC3A717AE6', '1490342473481');
INSERT INTO `tc_message` VALUES ('466', '20000000', '朱2', '', '{\"from扩展\":\"从哪儿来的?\"}', '20000002', 'A≠L✨', 'http://www.kmlejin.com/Uploads/Picture/20160502/s_8e0e71199b07cb4e.jpg', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', ' ', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '1830A3E4-1862-4677-B658-66C2A69B5101', '1490421119966');
INSERT INTO `tc_message` VALUES ('467', '20000315', '呀呀', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_1d84cb873dfffdb7.jpg', '{\"from扩展\":\"从哪儿来的?\"}', '20000314', 'yYY', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_507b280d0955e992.jpg', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '澳门', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', 'BFAE39E9-EAA5-4566-9ACB-A230752E521F', '1490586285536');
INSERT INTO `tc_message` VALUES ('468', '20000315', '呀呀', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_1d84cb873dfffdb7.jpg', '{\"from扩展\":\"从哪儿来的?\"}', '20000316', 'uu', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_d07e2674a5e4b5ce.jpg', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', ' 磨', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '65FC2052-49B2-4091-AA27-20BA6F686452', '1490586327487');
INSERT INTO `tc_message` VALUES ('469', '20000316', 'uu', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_d07e2674a5e4b5ce.jpg', '', '20000315', '呀呀', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_1d84cb873dfffdb7.jpg', '', '', '', '', '', '好久', '', '', '100', '1', 'afbd2393-d61b-47b8-9f82-a4e03b4ddced', '1490586341105');
INSERT INTO `tc_message` VALUES ('470', '20000315', '呀呀', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_1d84cb873dfffdb7.jpg', '{\"from扩展\":\"从哪儿来的?\"}', '20000316', 'uu', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_d07e2674a5e4b5ce.jpg', '{\"to扩展\":\"到哪儿去?\"}', '', '', '', '', '哦哦哦', '{\"msg扩展\":\"消息本身的扩展\"}', '{\"body扩展\":\"消息体的扩展\"}', '100', '1', '8C98F753-7C61-4600-A5F3-55C13071E5E9', '1490586398741');
INSERT INTO `tc_message` VALUES ('471', '20000316', 'uu', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_d07e2674a5e4b5ce.jpg', '', '20000315', '呀呀', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_1d84cb873dfffdb7.jpg', '', '', '', '', '', '刚才', '', '', '100', '1', 'b9de2977-8043-48b7-b15c-3b03231e1870', '1490586407886');
INSERT INTO `tc_message` VALUES ('472', '20000315', '呀呀', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_1d84cb873dfffdb7.jpg', '{}', '4', '乐视', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_1d84cb873dfffdb7.jpg', '{\"topicmsg\":\"1\"}', '', '', '', '', '磨', '{}', '{}', '200', '1', '1575D71D-F017-492D-A8D1-674D4FBB5B72', '1490587282165');
INSERT INTO `tc_message` VALUES ('473', '20000313', '哈哈哈', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '', '4', '乐视', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_1d84cb873dfffdb7.jpg', '{\"topicmsg\":\"1\"}', '', '', '', '', '宝宝', '', '', '200', '1', '26910922-ea7e-4862-9340-867e13869293', '1490587338370');
INSERT INTO `tc_message` VALUES ('474', '20000313', '哈哈哈', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '', '12', '吃就吃', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_3ee6fb61522add83.jpg', '{\"topicmsg\":\"1\"}', '', '', '', '', '嘻嘻', '', '', '200', '1', '2f41be0c-e9ee-4ddb-9cf1-71568a9f31cb', '1490593093540');
INSERT INTO `tc_message` VALUES ('475', '20000315', '呀呀', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_1d84cb873dfffdb7.jpg', '{}', '12', '吃就吃', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_1d84cb873dfffdb7.jpg', '{\"topicmsg\":\"1\"}', '', '', '', '', '哈哈', '{}', '{}', '200', '1', 'CDAF85F5-DA91-4D26-98FB-12E74A9A8AAF', '1490593126171');
INSERT INTO `tc_message` VALUES ('476', '20000313', '哈哈哈', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '', '12', '吃就吃', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_3ee6fb61522add83.jpg', '{\"topicmsg\":\"1\"}', '', '', '', '', '乖宝宝', '', '', '200', '1', '63323081-1928-4802-aee8-8b4a8213f8eb', '1490593131190');
INSERT INTO `tc_message` VALUES ('477', '20000313', '哈哈哈', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '', '12', '吃就吃', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_3ee6fb61522add83.jpg', '{\"topicmsg\":\"1\"}', '', '', '', '', '你呢', '', '', '200', '1', 'c14ce90a-19fc-413d-82e6-708b09f256ef', '1490593151615');
INSERT INTO `tc_message` VALUES ('478', '20000315', '呀呀', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_1d84cb873dfffdb7.jpg', '{}', '4', '乐视', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_1d84cb873dfffdb7.jpg', '{\"topicmsg\":\"1\"}', '', '', '', '', '哈哈', '{}', '{}', '200', '1', 'BD3627CF-C470-43D3-AC1C-570324CBC83D', '1490594736963');
INSERT INTO `tc_message` VALUES ('479', '20000313', '哈哈哈', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '', '3', '科技创新', '', '{\"topicmsg\":\"1\"}', '', '', '', '', '你们', '', '', '200', '1', 'c866017a-8264-43af-abc7-a6e84b63ce67', '1490594755164');
INSERT INTO `tc_message` VALUES ('480', '20000313', '哈哈哈', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '{}', '3', '科技创新', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', '{\"topicmsg\":\"1\"}', '', '', '', '', '摩云', '{}', '{}', '200', '1', '2A5FB22D-1F42-4F8D-8988-D91468F80F8E', '1490595254791');
INSERT INTO `tc_message` VALUES ('481', '20000315', '呀呀', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_1d84cb873dfffdb7.jpg', '{}', '12', '吃就吃', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_1d84cb873dfffdb7.jpg', '{\"topicmsg\":\"1\"}', '', '', '', '', 'www', '{}', '{}', '200', '1', '63DA2D35-7766-4094-9714-F1FA3E044BF6', '1490595754927');

-- ----------------------------
-- Table structure for `tc_messages`
-- ----------------------------
DROP TABLE IF EXISTS `tc_messages`;
CREATE TABLE `tc_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rootid` int(11) NOT NULL DEFAULT '0',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT '用户id',
  `content` text NOT NULL COMMENT '内容',
  `images` text NOT NULL,
  `video` varchar(2048) NOT NULL DEFAULT '',
  `lat` decimal(10,6) NOT NULL DEFAULT '0.000000' COMMENT '纬度',
  `lng` decimal(10,6) NOT NULL DEFAULT '0.000000' COMMENT '经度',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0-大家帮 1-XXX',
  `praisecount` int(11) NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0-正常 1-留言',
  `city` varchar(30) NOT NULL DEFAULT '' COMMENT '城市',
  `createtime` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=169 DEFAULT CHARSET=utf8 COMMENT='留言表';

-- ----------------------------
-- Records of tc_messages
-- ----------------------------
INSERT INTO `tc_messages` VALUES ('1', '0', '20000000', '大家好才是真的好', '', '', '30.738983', '103.978868', '0', '0', '0', '成都市', '1458183343');
INSERT INTO `tc_messages` VALUES ('2', '0', '20000000', '哈哈啊', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160317/4747871696ebc5cc.png\",\"smallUrl\":\"/Uploads/Picture/20160317/s_4747871696ebc5cc.png\",\"id\":\"36cd06e20d8613d46583aaff68de8d1c\"}]', '', '30.738964', '103.978762', '0', '0', '0', '成都市', '1458183684');
INSERT INTO `tc_messages` VALUES ('3', '0', '20000000', '乐乐来了[emoji_87][emoji_88][emoji_340][emoji_340][emoji_340]', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160317/8d837ac76b956115.jpg\",\"smallUrl\":\"/Uploads/Picture/20160317/s_8d837ac76b956115.jpg\",\"id\":\"38df1cfc63e051d778487843c31be962\"}]', '', '30.738964', '103.978762', '1', '1', '0', '成都市', '1458183755');
INSERT INTO `tc_messages` VALUES ('4', '0', '20000001', '西南交大。', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160317/dc7ab9dba7dd5ae8.jpg\",\"smallUrl\":\"/Uploads/Picture/20160317/s_dc7ab9dba7dd5ae8.jpg\",\"id\":\"8346157296d54be843ae5b0d7b0f5398\"}]', '', '30.738903', '103.978841', '0', '0', '0', '成都市', '1458184128');
INSERT INTO `tc_messages` VALUES ('5', '0', '20000001', '花海。', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160317/ae8372d0da96d543.jpg\",\"smallUrl\":\"/Uploads/Picture/20160317/s_ae8372d0da96d543.jpg\",\"id\":\"50d37d9844fb9e7b83feda792e34b115\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20160317/38b4acf811a532cd.jpg\",\"smallUrl\":\"/Uploads/Picture/20160317/s_38b4acf811a532cd.jpg\",\"id\":\"9c6c916c04083611575642d5dda299fb\"},{\"key\":\"images3\",\"originUrl\":\"/Uploads/Picture/20160317/d16033487e3aae55.jpg\",\"smallUrl\":\"/Uploads/Picture/20160317/s_d16033487e3aae55.jpg\",\"id\":\"d7487c32c96c13465a7a53f1f8ce036f\"},{\"key\":\"images4\",\"originUrl\":\"/Uploads/Picture/20160317/27c195630c1c45ed.jpg\",\"smallUrl\":\"/Uploads/Picture/20160317/s_27c195630c1c45ed.jpg\",\"id\":\"ac523783d3456c187aa250e04acf8d0f\"}]', '', '30.738903', '103.978841', '1', '0', '0', '成都市', '1458184194');
INSERT INTO `tc_messages` VALUES ('6', '0', '20000001', '分享图片', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160317/bdaf44b1e78adaa3.jpg\",\"smallUrl\":\"/Uploads/Picture/20160317/s_bdaf44b1e78adaa3.jpg\",\"id\":\"e93db2480b004f26ba5e0eab4666b82d\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20160317/81ce646012e1d5f7.jpg\",\"smallUrl\":\"/Uploads/Picture/20160317/s_81ce646012e1d5f7.jpg\",\"id\":\"a8df161f16572c64789e767d1b6de824\"},{\"key\":\"images3\",\"originUrl\":\"/Uploads/Picture/20160317/3caf7e72da3d100b.jpg\",\"smallUrl\":\"/Uploads/Picture/20160317/s_3caf7e72da3d100b.jpg\",\"id\":\"218dfab8b2d6d449e11c171f560d74aa\"}]', '', '30.738903', '103.978841', '0', '0', '0', '成都市', '1458184311');
INSERT INTO `tc_messages` VALUES ('7', '0', '20000002', '看着我是歌手[emoji_59]，品着咖啡[emoji_68][emoji_124]', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160318/302bd5ca386c3143.jpg\",\"smallUrl\":\"/Uploads/Picture/20160318/s_302bd5ca386c3143.jpg\",\"id\":\"bdf0c3ceec7f8b6829c96743f305dc12\"}]', '', '25.106845', '102.779703', '1', '0', '0', '昆明市', '1458310910');
INSERT INTO `tc_messages` VALUES ('8', '0', '20000003', '我想找一个女朋友[emoji_364]', '', '', '22.571178', '114.173311', '0', '0', '0', '深圳市', '1458331901');
INSERT INTO `tc_messages` VALUES ('9', '0', '20000002', '今天一天的成绩[emoji_13][emoji_86]', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160321/12938178e3c17007.jpg\",\"smallUrl\":\"/Uploads/Picture/20160321/s_12938178e3c17007.jpg\",\"id\":\"344e8972fb8b68556061a190b31def09\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20160321/64547ffa0e29b553.jpg\",\"smallUrl\":\"/Uploads/Picture/20160321/s_64547ffa0e29b553.jpg\",\"id\":\"6c830d5b800bb0d54d3260d5045e9a8b\"},{\"key\":\"images3\",\"originUrl\":\"/Uploads/Picture/20160321/cdb776536f647d71.jpg\",\"smallUrl\":\"/Uploads/Picture/20160321/s_cdb776536f647d71.jpg\",\"id\":\"d5e46ed7c6dfd8b96fb96c8e93864523\"},{\"key\":\"images4\",\"originUrl\":\"/Uploads/Picture/20160321/0884bdf2770d354c.jpg\",\"smallUrl\":\"/Uploads/Picture/20160321/s_0884bdf2770d354c.jpg\",\"id\":\"8b558f29e9f826cb488ab5551da5b74d\"},{\"key\":\"images5\",\"originUrl\":\"/Uploads/Picture/20160321/d6028cb7f1612189.jpg\",\"smallUrl\":\"/Uploads/Picture/20160321/s_d6028cb7f1612189.jpg\",\"id\":\"2c07dcf49b5b0c427d57217c2a642311\"}]', '', '25.106877', '102.779698', '1', '0', '0', '昆明市', '1458566630');
INSERT INTO `tc_messages` VALUES ('10', '0', '20000002', '开心一下[emoji_86][emoji_86][emoji_86]', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160322/e32e8792a5316131.jpg\",\"smallUrl\":\"/Uploads/Picture/20160322/s_e32e8792a5316131.jpg\",\"id\":\"0970b5364b4fb553e35b19096183988b\"}]', '', '0.000000', '0.000000', '1', '0', '0', '', '1458610601');
INSERT INTO `tc_messages` VALUES ('11', '0', '20000002', '分享图片', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160322/d04da6663296ad30.jpg\",\"smallUrl\":\"/Uploads/Picture/20160322/s_d04da6663296ad30.jpg\",\"id\":\"e854586a9b491fe52065ea443139d507\"}]', '', '25.106861', '102.779682', '1', '0', '0', '昆明市', '1458616948');
INSERT INTO `tc_messages` VALUES ('12', '0', '20000010', '今天天气好，适合出去玩', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160324/616bc8b5c9af85c4.png\",\"smallUrl\":\"/Uploads/Picture/20160324/s_616bc8b5c9af85c4.png\",\"id\":\"06df21564bae3bad6bcfae895ddd0cb0\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20160324/d4f3d1a20a5699cc.png\",\"smallUrl\":\"/Uploads/Picture/20160324/s_d4f3d1a20a5699cc.png\",\"id\":\"2c9708bb095812ab1e1b9b777a7d50ff\"},{\"key\":\"images3\",\"originUrl\":\"/Uploads/Picture/20160324/797aed0f5da3da11.png\",\"smallUrl\":\"/Uploads/Picture/20160324/s_797aed0f5da3da11.png\",\"id\":\"25abff6d7d41b36915d05ce5cd78918e\"}]', '', '31.356311', '107.743515', '0', '0', '0', '达州市', '1458793409');
INSERT INTO `tc_messages` VALUES ('14', '0', '20000000', '现在，这家人住在巴基斯坦Quetta东部郊区，现在住的房子有12间房，总面积超过4000平方米。大叔经营着一家小诊所，每个月的薪水是955美元(约6200人民币)。他说，自己的这份薪水，养着30多个娃，足够了。', '', '', '30.739044', '103.978796', '0', '0', '0', '成都市', '1459321618');
INSERT INTO `tc_messages` VALUES ('15', '0', '20000000', '哦啦啦啦啦具体咯啊啦啦啦啦啦啦啦啦啦啦啦咯啦啦啦[emoji_87][emoji_346][emoji_347][emoji_347][emoji_346][emoji_346][emoji_346][emoji_346][emoji_346] 我哦啦啦啦啦拒绝空旅途来咯昆明啦啦啦咯啦啦啦咯图图', '', '', '30.738984', '103.978821', '0', '0', '0', '成都市', '1459329487');
INSERT INTO `tc_messages` VALUES ('16', '0', '20000000', 'gghh', '', '', '30.738701', '103.979216', '0', '0', '0', '成都市', '1459330832');
INSERT INTO `tc_messages` VALUES ('17', '0', '20000000', '333', '', '', '30.739024', '103.978802', '0', '0', '0', '成都市', '1459331620');
INSERT INTO `tc_messages` VALUES ('18', '0', '20000000', '2', '', '', '30.738631', '103.979129', '0', '0', '0', '成都市', '1459331703');
INSERT INTO `tc_messages` VALUES ('23', '0', '20000017', '3', '', '', '30.739007', '103.978790', '0', '0', '0', '成都市', '1459333342');
INSERT INTO `tc_messages` VALUES ('24', '0', '20000017', '333', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160330/cb7d5786065f977b.jpg\",\"smallUrl\":\"/Uploads/Picture/20160330/s_cb7d5786065f977b.jpg\",\"id\":\"6a8a2c92c0b043c2c2cbb75b3dcae544\"}]', '', '30.739007', '103.978790', '1', '0', '0', '成都市', '1459333383');
INSERT INTO `tc_messages` VALUES ('25', '0', '20000017', 'vbnjj', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160330/1298a251a070fbd1.jpg\",\"smallUrl\":\"/Uploads/Picture/20160330/s_1298a251a070fbd1.jpg\",\"id\":\"3f4eaf5dd3080788909cfc5ada877712\"}]', '', '30.738631', '103.979129', '1', '0', '0', '成都市', '1459333982');
INSERT INTO `tc_messages` VALUES ('27', '0', '20000002', '也就不过是个小长假，肿么就堵成这样[emoji_361][emoji_115]', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160402/d5bbd6f21f53b7d5.jpg\",\"smallUrl\":\"/Uploads/Picture/20160402/s_d5bbd6f21f53b7d5.jpg\",\"id\":\"6741b652b1bcd883e42cf3680c0e9f4c\"}]', '', '25.011041', '102.690015', '1', '0', '0', '昆明市', '1459577445');
INSERT INTO `tc_messages` VALUES ('28', '0', '20000017', '411', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160422/0d50c282b288317b.jpg\",\"smallUrl\":\"/Uploads/Picture/20160422/s_0d50c282b288317b.jpg\",\"id\":\"43f69c43f5933e4739d63cc91cfc8535\"}]', '', '32.000000', '105.000000', '1', '0', '0', '绵阳市', '1461315024');
INSERT INTO `tc_messages` VALUES ('30', '0', '20000017', '123', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160422/a2a1df4592a07047.jpg\",\"smallUrl\":\"/Uploads/Picture/20160422/s_a2a1df4592a07047.jpg\",\"id\":\"09f680fd124a3df7097ba38587cf4db7\"}]', '', '30.000000', '104.000000', '1', '0', '0', '眉山市', '1461315272');
INSERT INTO `tc_messages` VALUES ('31', '0', '20000017', '123', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160422/ec250234e5f5eeab.jpg\",\"smallUrl\":\"/Uploads/Picture/20160422/s_ec250234e5f5eeab.jpg\",\"id\":\"bac22f839204df49a2e0ac326a128c03\"}]', '', '30.000000', '104.000000', '0', '0', '0', '眉山市', '1461316362');
INSERT INTO `tc_messages` VALUES ('32', '0', '20000017', '123', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160422/ffcef6761a83cb3c.jpg\",\"smallUrl\":\"/Uploads/Picture/20160422/s_ffcef6761a83cb3c.jpg\",\"id\":\"83cba719896d3878add851b509b367ca\"}]', '', '30.000000', '104.000000', '0', '0', '0', '眉山市', '1461316392');
INSERT INTO `tc_messages` VALUES ('41', '0', '20000002', '又是摘樱桃的时节，过瘾', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160424/efbea81d6d10575e.jpg\",\"smallUrl\":\"/Uploads/Picture/20160424/s_efbea81d6d10575e.jpg\",\"id\":\"ce69b06d78a268601ada51d58974e19e\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20160424/d672639495a156fb.jpg\",\"smallUrl\":\"/Uploads/Picture/20160424/s_d672639495a156fb.jpg\",\"id\":\"bec074728366de19fff446e2b4243625\"},{\"key\":\"images3\",\"originUrl\":\"/Uploads/Picture/20160424/9050a272aa346824.jpg\",\"smallUrl\":\"/Uploads/Picture/20160424/s_9050a272aa346824.jpg\",\"id\":\"d712910394a0faf632b5820021f3b0e9\"},{\"key\":\"images4\",\"originUrl\":\"/Uploads/Picture/20160424/c19a1514d1df43bd.jpg\",\"smallUrl\":\"/Uploads/Picture/20160424/s_c19a1514d1df43bd.jpg\",\"id\":\"e34468e9cc0ab6f1f77598e2e8d83603\"},{\"key\":\"images5\",\"originUrl\":\"/Uploads/Picture/20160424/29f97024b8da97b5.jpg\",\"smallUrl\":\"/Uploads/Picture/20160424/s_29f97024b8da97b5.jpg\",\"id\":\"615b6a151140f7282756820828a24769\"}]', '', '25.355013', '102.466536', '1', '1', '0', '昆明市', '1461472916');
INSERT INTO `tc_messages` VALUES ('43', '0', '20000000', 'vv何厚铧', '[{\"key\":\"images\",\"originUrl\":\"/Uploads/Picture/20160428/fdd57bfb8c900528.png\",\"smallUrl\":\"/Uploads/Picture/20160428/s_fdd57bfb8c900528.png\",\"id\":\"9c23f56c0282b52fbcc65cbf4e002d69\"}]', '', '30.739055', '103.978444', '1', '0', '0', '成都市', '1461836496');
INSERT INTO `tc_messages` VALUES ('44', '0', '20000000', '大视频', '', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160428/ad09a3ff5ffe3340.png\",\"smallUrl\":\"/Uploads/Picture/20160428/s_ad09a3ff5ffe3340.png\",\"id\":\"f114da1e6d14f15d4ebb365a200176df\"},{\"originUrl\":\"/Uploads/Picture/20160428/cf545fc75a698079.mp4\",\"smallUrl\":\"/Uploads/Picture/20160428/cf545fc75a698079.mp4\",\"id\":\"9f29a73243d8dc61c4108034fb63e679\",\"key\":\"video\"}]', '30.739055', '103.978444', '1', '0', '0', '成都市', '1461838622');
INSERT INTO `tc_messages` VALUES ('45', '0', '20000017', '一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十一', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160428/c3a0fe782345e373.jpg\",\"smallUrl\":\"/Uploads/Picture/20160428/s_c3a0fe782345e373.jpg\",\"id\":\"4fc57e72e69e635de113d27e2151ab86\"}]', '', '30.739097', '103.978715', '1', '0', '0', '成都市', '1461842418');
INSERT INTO `tc_messages` VALUES ('46', '0', '20000017', '一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一样', '[{\"key\":\"images\",\"originUrl\":\"/Uploads/Picture/20160428/d30fbaa0cba956a0.png\",\"smallUrl\":\"/Uploads/Picture/20160428/s_d30fbaa0cba956a0.png\",\"id\":\"ef0051c79527f1900b925686ffe386f3\"}]', '', '30.665188', '104.072252', '1', '0', '0', '成都市', '1461843567');
INSERT INTO `tc_messages` VALUES ('47', '0', '20000017', '尽可能', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160428/8c0d60fedc61067e.jpg\",\"smallUrl\":\"/Uploads/Picture/20160428/s_8c0d60fedc61067e.jpg\",\"id\":\"0bf6fd4a0b36f164e9a4340c8386ca78\"}]', '', '30.739137', '103.978692', '1', '1', '0', '成都市', '1461843683');
INSERT INTO `tc_messages` VALUES ('49', '0', '20000025', '新人报道[emoji_13][emoji_13][emoji_13]', '[{\"key\":\"images\",\"originUrl\":\"/Uploads/Picture/20160429/0f4d36c8266c7461.png\",\"smallUrl\":\"/Uploads/Picture/20160429/s_0f4d36c8266c7461.png\",\"id\":\"638a25e295ee089048b0994d007fc565\"}]', '', '25.106490', '102.779735', '1', '0', '0', '昆明市', '1461908879');
INSERT INTO `tc_messages` VALUES ('50', '0', '20000002', '开启烧烤模式，喜迎五一[emoji_16]', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160430/ead8662f0d1488ab.jpg\",\"smallUrl\":\"/Uploads/Picture/20160430/s_ead8662f0d1488ab.jpg\",\"id\":\"596c4fb5afe5fbddd041f1bed0e93b80\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20160430/7e73de78874c58ac.jpg\",\"smallUrl\":\"/Uploads/Picture/20160430/s_7e73de78874c58ac.jpg\",\"id\":\"7e22e5dfe9921b20290279712dd590b2\"},{\"key\":\"images3\",\"originUrl\":\"/Uploads/Picture/20160430/5dd10bcbea91ed78.jpg\",\"smallUrl\":\"/Uploads/Picture/20160430/s_5dd10bcbea91ed78.jpg\",\"id\":\"553e38bd21299c0f5644a0b627f2f699\"},{\"key\":\"images4\",\"originUrl\":\"/Uploads/Picture/20160430/4464069fe64ce271.jpg\",\"smallUrl\":\"/Uploads/Picture/20160430/s_4464069fe64ce271.jpg\",\"id\":\"5c7de6dfb86bce612a42f0a73141f765\"}]', '', '25.083882', '102.769091', '1', '2', '0', '昆明市', '1462010246');
INSERT INTO `tc_messages` VALUES ('51', '0', '20000000', 'ggg', '', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160506/c664ccc4d80069e1.jpg\",\"smallUrl\":\"/Uploads/Picture/20160506/s_c664ccc4d80069e1.jpg\",\"id\":\"6c80ba6e91baa2400916ad1198f2432f\"},{\"originUrl\":\"/Uploads/Picture/20160506/152c4f87ddc4d070.mp4\",\"smallUrl\":\"/Uploads/Picture/20160506/152c4f87ddc4d070.mp4\",\"id\":\"15550c18c60016197d47bbb970803200\",\"key\":\"video\"}]', '30.738977', '103.978801', '1', '0', '0', '成都市', '1462526640');
INSERT INTO `tc_messages` VALUES ('52', '0', '20000027', '售云盘大片，男人都懂的，加扣2950428976，一人一号安全可靠，无需下载，在线即可观看，详情加扣2950428976进行了解', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160506/6d4a5a9de857fa4f.jpg\",\"smallUrl\":\"/Uploads/Picture/20160506/s_6d4a5a9de857fa4f.jpg\",\"id\":\"4d2199334c05a1bf974fe399e97306f1\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20160506/caea613f0149676f.png\",\"smallUrl\":\"/Uploads/Picture/20160506/s_caea613f0149676f.png\",\"id\":\"82880158eff30033e9227e252a36498e\"}]', '', '24.502371', '115.254441', '0', '0', '0', '河源市', '1462544752');
INSERT INTO `tc_messages` VALUES ('53', '0', '20000002', '奔跑吧，兄弟', '', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160506/9105eaf14ded73c3.png\",\"smallUrl\":\"/Uploads/Picture/20160506/s_9105eaf14ded73c3.png\",\"id\":\"9630877e1863f9ea72e62d1fe95e2f95\"},{\"originUrl\":\"/Uploads/Picture/20160506/c0194fe446d10b3e.mp4\",\"smallUrl\":\"/Uploads/Picture/20160506/c0194fe446d10b3e.mp4\",\"id\":\"b4033629a4571fdbf398e257a8e7331c\",\"key\":\"video\"}]', '25.106578', '102.779078', '1', '0', '0', '昆明市', '1462545134');
INSERT INTO `tc_messages` VALUES ('54', '0', '20000025', '今天网络出了很多孝子！不过记住，你妈不上网，也不会玩微信微博[emoji_353][emoji_353][emoji_346]记得去多陪陪才更有意义[emoji_13][emoji_33][emoji_49]', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160508/6ee535fbc3fe9c76.jpg\",\"smallUrl\":\"/Uploads/Picture/20160508/s_6ee535fbc3fe9c76.jpg\",\"id\":\"3f4125b4f0f6a8fd8e30fa07fc5aa41b\"}]', '', '25.106836', '102.779667', '1', '0', '0', '昆明市', '1462706899');
INSERT INTO `tc_messages` VALUES ('55', '0', '20000017', '啊啊啊啊啊[emoji_346][emoji_346][emoji_346][emoji_346][emoji_345][emoji_346][emoji_88][emoji_340]', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160509/05d9874c523252bd.jpg\",\"smallUrl\":\"/Uploads/Picture/20160509/s_05d9874c523252bd.jpg\",\"id\":\"b55e6e64b488fa95fdb01dc06f2e0975\"}]', '', '30.738992', '103.978817', '1', '0', '0', '成都市', '1462775127');
INSERT INTO `tc_messages` VALUES ('57', '0', '20000000', '换个环境', '[{\"key\":\"images\",\"originUrl\":\"/Uploads/Picture/20160509/fea26f5f7cd9bedf.png\",\"smallUrl\":\"/Uploads/Picture/20160509/s_fea26f5f7cd9bedf.png\",\"id\":\"756dcc6b7b3aa0ee27429ec2f3cd288e\"}]', '', '30.665188', '104.072252', '1', '1', '0', '成都市', '1462790097');
INSERT INTO `tc_messages` VALUES ('58', '0', '20000002', '[emoji_357][emoji_357][emoji_357]', '', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160512/13aa988c5f30c455.jpg\",\"smallUrl\":\"/Uploads/Picture/20160512/s_13aa988c5f30c455.jpg\",\"id\":\"199e347d6e8d6661c4e1f06b7b02159d\"},{\"originUrl\":\"/Uploads/Picture/20160512/fa48d208039dbc05.mp4\",\"smallUrl\":\"/Uploads/Picture/20160512/fa48d208039dbc05.mp4\",\"id\":\"db484a4c64fb8ad436855ba075519c96\",\"key\":\"video\"}]', '25.106854', '102.779702', '1', '0', '0', '昆明市', '1463056735');
INSERT INTO `tc_messages` VALUES ('60', '0', '20000017', '爸爸去哪儿', '', '', '30.740800', '103.992161', '0', '0', '0', '成都市', '1463504047');
INSERT INTO `tc_messages` VALUES ('61', '0', '20000017', '斤斤计较', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160518/974e537c6d1f3d15.jpg\",\"smallUrl\":\"/Uploads/Picture/20160518/s_974e537c6d1f3d15.jpg\",\"id\":\"80fa6ee871727d01f280c19482f38f52\"}]', '', '30.740800', '103.992161', '1', '0', '0', '成都市', '1463504111');
INSERT INTO `tc_messages` VALUES ('62', '0', '20000000', '广告', '[{\"key\":\"images\",\"originUrl\":\"/Uploads/Picture/20160518/0065cdc3bcb8f0a9.png\",\"smallUrl\":\"/Uploads/Picture/20160518/s_0065cdc3bcb8f0a9.png\",\"id\":\"fc759c963cff85463395d938d72b63be\"}]', '', '30.740892', '103.992121', '1', '0', '0', '成都市', '1463504221');
INSERT INTO `tc_messages` VALUES ('63', '0', '20000000', '呼呼', '', '', '30.740892', '103.992121', '0', '0', '0', '成都市', '1463504269');
INSERT INTO `tc_messages` VALUES ('64', '0', '20000017', '一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十啊啊啊', '', '', '30.740800', '103.992161', '0', '0', '0', '成都市', '1463505191');
INSERT INTO `tc_messages` VALUES ('65', '0', '20000024', '哈哈', '[{\"key\":\"images\",\"originUrl\":\"/Uploads/Picture/20160518/174b18bf51207f91.png\",\"smallUrl\":\"/Uploads/Picture/20160518/s_174b18bf51207f91.png\",\"id\":\"1656d40d94dfd7148f189b52be6aa1ed\"}]', '', '31.356260', '107.743439', '1', '0', '0', '达州市', '1463549774');
INSERT INTO `tc_messages` VALUES ('66', '0', '20000024', '哦可哦可哦可', '[{\"key\":\"images\",\"originUrl\":\"/Uploads/Picture/20160518/b0071de75760b3d4.png\",\"smallUrl\":\"/Uploads/Picture/20160518/s_b0071de75760b3d4.png\",\"id\":\"fef02f93a675a926e6e15217eeef839d\"}]', '', '31.356260', '107.743439', '1', '0', '0', '达州市', '1463550304');
INSERT INTO `tc_messages` VALUES ('67', '0', '20000024', '古古惑惑', '', '', '31.356260', '107.743439', '0', '0', '0', '达州市', '1463550422');
INSERT INTO `tc_messages` VALUES ('68', '0', '20000000', '111', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160518/e140196da4aa4914.jpg\",\"smallUrl\":\"/Uploads/Picture/20160518/s_e140196da4aa4914.jpg\",\"id\":\"84ce7cdcd2234f6038e6850be0b1d2dc\"}]', '', '30.739172', '103.978664', '1', '0', '0', '成都市', '1463552100');
INSERT INTO `tc_messages` VALUES ('69', '0', '20000000', '也一样', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160518/5817edf0bc939b9a.jpg\",\"smallUrl\":\"/Uploads/Picture/20160518/s_5817edf0bc939b9a.jpg\",\"id\":\"917c3078a519b978e6950d0cb9686969\"}]', '', '30.739117', '103.978692', '1', '0', '0', '成都市', '1463556984');
INSERT INTO `tc_messages` VALUES ('70', '0', '20000000', 'III', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160518/be743f94320ff249.jpg\",\"smallUrl\":\"/Uploads/Picture/20160518/s_be743f94320ff249.jpg\",\"id\":\"a29269a80132f4739b1137fc618e1961\"}]', '', '30.739117', '103.978692', '1', '1', '0', '成都市', '1463557025');
INSERT INTO `tc_messages` VALUES ('71', '0', '20000000', '123456', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160518/9001a069f8c8d3cb.jpg\",\"smallUrl\":\"/Uploads/Picture/20160518/s_9001a069f8c8d3cb.jpg\",\"id\":\"68525e5c42ebcc286e2e9eefe7090e73\"}]', '', '30.739117', '103.978692', '0', '0', '0', '成都市', '1463557118');
INSERT INTO `tc_messages` VALUES ('72', '0', '20000000', '369', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160518/0a3bd2a3f8d7893e.jpg\",\"smallUrl\":\"/Uploads/Picture/20160518/s_0a3bd2a3f8d7893e.jpg\",\"id\":\"5b9e3ceaac14efaddd01b2fd47eb3d72\"}]', '', '30.739117', '103.978692', '0', '0', '0', '成都市', '1463558658');
INSERT INTO `tc_messages` VALUES ('73', '0', '20000000', '了', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160518/63233d9f603c7db3.jpg\",\"smallUrl\":\"/Uploads/Picture/20160518/s_63233d9f603c7db3.jpg\",\"id\":\"f3840f941307302ed6d986558f99a526\"}]', '', '30.739117', '103.978692', '1', '0', '0', '成都市', '1463558821');
INSERT INTO `tc_messages` VALUES ('74', '0', '20000000', '她', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160518/4b875b0f8b10ca45.jpg\",\"smallUrl\":\"/Uploads/Picture/20160518/s_4b875b0f8b10ca45.jpg\",\"id\":\"9eb0cfea0434960bb2dfd5d03a4fcff8\"}]', '', '30.739117', '103.978692', '1', '0', '0', '成都市', '1463559008');
INSERT INTO `tc_messages` VALUES ('75', '0', '20000000', '哟', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160518/8222d5119fc17214.jpg\",\"smallUrl\":\"/Uploads/Picture/20160518/s_8222d5119fc17214.jpg\",\"id\":\"d5552576618edf5a1554629669ecdd48\"}]', '', '30.739117', '103.978692', '0', '0', '0', '成都市', '1463559058');
INSERT INTO `tc_messages` VALUES ('76', '0', '20000000', '有意义', '[{\"key\":\"images\",\"originUrl\":\"/Uploads/Picture/20160519/5ba86cdf907c5218.png\",\"smallUrl\":\"/Uploads/Picture/20160519/s_5ba86cdf907c5218.png\",\"id\":\"0bbd4a523884f46b0749315a438af863\"}]', '', '30.740955', '103.992144', '1', '1', '0', '成都市', '1463613504');
INSERT INTO `tc_messages` VALUES ('78', '0', '20000017', 'yhhh', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160519/6559e6781865f418.jpg\",\"smallUrl\":\"/Uploads/Picture/20160519/s_6559e6781865f418.jpg\",\"id\":\"a6791827f8edcb95444f1eb51712f1fc\"}]', '', '30.740714', '103.992160', '1', '0', '0', '成都市', '1463613867');
INSERT INTO `tc_messages` VALUES ('79', '0', '20000017', 'ghu', '', '', '30.740714', '103.992160', '0', '0', '0', '成都市', '1463613876');
INSERT INTO `tc_messages` VALUES ('80', '0', '20000025', '恭喜中国队荣获尤伯杯[emoji_370][emoji_370][emoji_370]', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160521/318f959834d5b934.jpg\",\"smallUrl\":\"/Uploads/Picture/20160521/s_318f959834d5b934.jpg\",\"id\":\"e93b30bc6f6ee6441a21f7487e00e323\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20160521/4d2656d8aceea223.jpg\",\"smallUrl\":\"/Uploads/Picture/20160521/s_4d2656d8aceea223.jpg\",\"id\":\"6490e4f04c28ef3b2ad138844127487d\"},{\"key\":\"images3\",\"originUrl\":\"/Uploads/Picture/20160521/90e98aecbb65c36d.jpg\",\"smallUrl\":\"/Uploads/Picture/20160521/s_90e98aecbb65c36d.jpg\",\"id\":\"c9531e4165c6bd6c136e4e16c2b896fd\"},{\"key\":\"images4\",\"originUrl\":\"/Uploads/Picture/20160521/9336bcd2aa98bb4c.jpg\",\"smallUrl\":\"/Uploads/Picture/20160521/s_9336bcd2aa98bb4c.jpg\",\"id\":\"89b65817757a1a2182316b015a909884\"}]', '', '25.106830', '102.779765', '1', '0', '0', '昆明市', '1463824929');
INSERT INTO `tc_messages` VALUES ('81', '0', '20000025', '重要通知：你的手机号用了几年了，如果用了六年以上发送短信S10G到10086可以免费送10个G的流量。如是六年以下就发送S6G到10086可免费送6个G的流量！这是真的！我10G流量抵260元话费，已到帐！绝对真实！5.31号之前有效，赶紧赶紧！(限云南省用户哟)[emoji_93][emoji_93][emoji_93]', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160528/64db094bd56f0297.jpg\",\"smallUrl\":\"/Uploads/Picture/20160528/s_64db094bd56f0297.jpg\",\"id\":\"88289434e8069486414919a843d4b8e0\"}]', '', '25.106866', '102.779798', '1', '0', '0', '昆明市', '1464366763');
INSERT INTO `tc_messages` VALUES ('82', '0', '20000002', '今天再次开启采摘水果模式[emoji_331][emoji_332][emoji_333]', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160528/6ec3a7c0250a4ba5.jpg\",\"smallUrl\":\"/Uploads/Picture/20160528/s_6ec3a7c0250a4ba5.jpg\",\"id\":\"92028f8f2497f32fb57a16a1d0dd9ee8\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20160528/6e5a0a27f6c2500b.jpg\",\"smallUrl\":\"/Uploads/Picture/20160528/s_6e5a0a27f6c2500b.jpg\",\"id\":\"aa7045749f5a8af8897786a0e5fb4696\"},{\"key\":\"images3\",\"originUrl\":\"/Uploads/Picture/20160528/f5fe3afa9691bb57.jpg\",\"smallUrl\":\"/Uploads/Picture/20160528/s_f5fe3afa9691bb57.jpg\",\"id\":\"8663e9670902965149b653da0a05b12c\"},{\"key\":\"images4\",\"originUrl\":\"/Uploads/Picture/20160528/4cda32a4192ca9cd.jpg\",\"smallUrl\":\"/Uploads/Picture/20160528/s_4cda32a4192ca9cd.jpg\",\"id\":\"8ed90bbfabcafec88dea59cbde15fb31\"}]', '', '25.106823', '102.779698', '1', '2', '0', '昆明市', '1464442677');
INSERT INTO `tc_messages` VALUES ('83', '0', '20000002', '[emoji_280][emoji_275][emoji_265][emoji_116][emoji_116][emoji_116]', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160601/9f2d71388c403426.jpg\",\"smallUrl\":\"/Uploads/Picture/20160601/s_9f2d71388c403426.jpg\",\"id\":\"6c00ca2ca0694325fe42eccc4abbf818\"}]', '', '25.106826', '102.779684', '1', '0', '0', '昆明市', '1464755618');
INSERT INTO `tc_messages` VALUES ('84', '0', '20000000', '又下雨又出太阳', '[{\"key\":\"images\",\"originUrl\":\"/Uploads/Picture/20160602/401b42076f55abd5.png\",\"smallUrl\":\"/Uploads/Picture/20160602/s_401b42076f55abd5.png\",\"id\":\"e2fb0139fabcd9173baea647b5b2494e\"}]', '', '31.355555', '107.743690', '1', '0', '0', '达州市', '1464857241');
INSERT INTO `tc_messages` VALUES ('86', '0', '20000025', '又吃到了久违的菌子，4菌1根1豆，都是平时吃不到的，过瘾', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160609/c2ed1f3ce6666ebe.jpg\",\"smallUrl\":\"/Uploads/Picture/20160609/s_c2ed1f3ce6666ebe.jpg\",\"id\":\"236cda47910398c2d3e56762113115b3\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20160609/51e4e2128c174c51.jpg\",\"smallUrl\":\"/Uploads/Picture/20160609/s_51e4e2128c174c51.jpg\",\"id\":\"6d2c1448f8c7deda958afad03172c92b\"}]', '', '22.753278', '101.041724', '1', '0', '0', '普洱市', '1465446148');
INSERT INTO `tc_messages` VALUES ('87', '0', '20000025', '这是什么黑科技[emoji_96]太阳能开锁[emoji_62]开锁就能通管道[emoji_148]求解[emoji_86][emoji_86][emoji_86][emoji_116][emoji_116][emoji_116]', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160610/1c27b8218e8a9590.jpg\",\"smallUrl\":\"/Uploads/Picture/20160610/s_1c27b8218e8a9590.jpg\",\"id\":\"ce713d73e82059e1a3bb622a9eff4a4b\"}]', '', '22.780936', '100.972287', '0', '0', '0', '普洱市', '1465525845');
INSERT INTO `tc_messages` VALUES ('88', '0', '20000025', '最后在普洱茶乡的早餐，豆浆米干[emoji_326]，一个字：爽[emoji_13]', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160612/9ff57051a0b2dd46.jpg\",\"smallUrl\":\"/Uploads/Picture/20160612/s_9ff57051a0b2dd46.jpg\",\"id\":\"7e28cb62f7607835934ade58f34a335e\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20160612/2aed1d7ad6452d47.jpg\",\"smallUrl\":\"/Uploads/Picture/20160612/s_2aed1d7ad6452d47.jpg\",\"id\":\"0db29d1719b4ca74c46887d5ccac6118\"},{\"key\":\"images3\",\"originUrl\":\"/Uploads/Picture/20160612/38d78bde9d5eb9aa.jpg\",\"smallUrl\":\"/Uploads/Picture/20160612/s_38d78bde9d5eb9aa.jpg\",\"id\":\"9fe8109c6450a355636a8920c425e427\"}]', '', '22.764737', '100.989103', '1', '1', '0', '普洱市', '1465701803');
INSERT INTO `tc_messages` VALUES ('89', '0', '20000002', '老婆：“这哪队踢哪队？”\n老公：“法国踢罗马尼亚。”\n老婆：“这是中超联赛么？”\n老公：“...欧洲杯。”\n老婆：“中国队在哪？”\n老公：“...跟你一样在看电视。”\n老婆：“为什么不上去踢？”\n老公：“国际足联不让。”\n老婆：“是因为钓鱼岛么？”\n老公：“...因为水平不行。”\n老婆：“不是有姚明吗？”\n老公：“...滚……”', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160613/d6120c705346b0f8.jpg\",\"smallUrl\":\"/Uploads/Picture/20160613/s_d6120c705346b0f8.jpg\",\"id\":\"6f50db6847face007f568bb1b2333f20\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20160613/125cf2a38088fec8.jpg\",\"smallUrl\":\"/Uploads/Picture/20160613/s_125cf2a38088fec8.jpg\",\"id\":\"507a476a65003ee0aced795607b994af\"}]', '', '25.106834', '102.779649', '1', '1', '0', '昆明市', '1465799215');
INSERT INTO `tc_messages` VALUES ('90', '0', '20000025', '山城怀旧[emoji_7]', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160617/7990da0b7d9225dd.jpg\",\"smallUrl\":\"/Uploads/Picture/20160617/s_7990da0b7d9225dd.jpg\",\"id\":\"a31861516b3749f778cba11d40290dd4\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20160617/b37307a40a04d4e3.jpg\",\"smallUrl\":\"/Uploads/Picture/20160617/s_b37307a40a04d4e3.jpg\",\"id\":\"766ca48be8d658d3117b5456235aaa4f\"},{\"key\":\"images3\",\"originUrl\":\"/Uploads/Picture/20160617/585656b73a776a5e.jpg\",\"smallUrl\":\"/Uploads/Picture/20160617/s_585656b73a776a5e.jpg\",\"id\":\"0fc5c807e0fe361e936785172749bdda\"},{\"key\":\"images4\",\"originUrl\":\"/Uploads/Picture/20160617/be26aed647766749.jpg\",\"smallUrl\":\"/Uploads/Picture/20160617/s_be26aed647766749.jpg\",\"id\":\"21bf1331d94b635c2ba78cd81e868c37\"},{\"key\":\"images5\",\"originUrl\":\"/Uploads/Picture/20160617/ba3ba05c1781d2f3.jpg\",\"smallUrl\":\"/Uploads/Picture/20160617/s_ba3ba05c1781d2f3.jpg\",\"id\":\"f9073110d699646c17d6f413211b488b\"},{\"key\":\"images6\",\"originUrl\":\"/Uploads/Picture/20160617/a7824ea4dccca867.jpg\",\"smallUrl\":\"/Uploads/Picture/20160617/s_a7824ea4dccca867.jpg\",\"id\":\"b80b4e89b4992f3bd296dc79d2853134\"}]', '', '29.564646', '106.584596', '1', '0', '0', '重庆市', '1466152483');
INSERT INTO `tc_messages` VALUES ('91', '0', '20000025', '今天侄女结婚[emoji_33]重庆是在中午办酒席[emoji_66]开启买醉节奏[emoji_70][emoji_274]', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160619/659deabfcd90ac05.jpg\",\"smallUrl\":\"/Uploads/Picture/20160619/s_659deabfcd90ac05.jpg\",\"id\":\"9c2f2b1aea73c5b8c8ebe9a22d99feed\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20160619/ef4598b8f695e83e.jpg\",\"smallUrl\":\"/Uploads/Picture/20160619/s_ef4598b8f695e83e.jpg\",\"id\":\"03c99d85dc35c205d1b9c4d902617565\"},{\"key\":\"images3\",\"originUrl\":\"/Uploads/Picture/20160619/208234c4b6996d38.jpg\",\"smallUrl\":\"/Uploads/Picture/20160619/s_208234c4b6996d38.jpg\",\"id\":\"e18dee36df3f0a26b5cd420b78ebf009\"},{\"key\":\"images4\",\"originUrl\":\"/Uploads/Picture/20160619/2257e83b8ef1adbd.jpg\",\"smallUrl\":\"/Uploads/Picture/20160619/s_2257e83b8ef1adbd.jpg\",\"id\":\"cdf1716843b2d1191669032a0708b6b7\"},{\"key\":\"images5\",\"originUrl\":\"/Uploads/Picture/20160619/5d7ebf232d2ea8b0.jpg\",\"smallUrl\":\"/Uploads/Picture/20160619/s_5d7ebf232d2ea8b0.jpg\",\"id\":\"7573210e249ff183317d1fee8f443433\"},{\"key\":\"images6\",\"originUrl\":\"/Uploads/Picture/20160619/8e658886f55e1173.jpg\",\"smallUrl\":\"/Uploads/Picture/20160619/s_8e658886f55e1173.jpg\",\"id\":\"4c23cbd7a9dcad265cbd4db4fb2ffce0\"}]', '', '29.580436', '106.536581', '1', '2', '0', '重庆市', '1466308498');
INSERT INTO `tc_messages` VALUES ('92', '0', '20000025', '红色之旅[emoji_86][emoji_86][emoji_344]', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160620/922cb01d0edfb4cb.jpg\",\"smallUrl\":\"/Uploads/Picture/20160620/s_922cb01d0edfb4cb.jpg\",\"id\":\"ad543671a02608a90c8786cf5cdc57d7\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20160620/0821c53cf14c6bc9.jpg\",\"smallUrl\":\"/Uploads/Picture/20160620/s_0821c53cf14c6bc9.jpg\",\"id\":\"8972a27287d6e8931e0d39270adeb0fa\"},{\"key\":\"images3\",\"originUrl\":\"/Uploads/Picture/20160620/d3beebeb21e2e20a.jpg\",\"smallUrl\":\"/Uploads/Picture/20160620/s_d3beebeb21e2e20a.jpg\",\"id\":\"886d6f45ee09f926f6b80dd9076ff399\"},{\"key\":\"images4\",\"originUrl\":\"/Uploads/Picture/20160620/667ba8b78a0f82ad.jpg\",\"smallUrl\":\"/Uploads/Picture/20160620/s_667ba8b78a0f82ad.jpg\",\"id\":\"e2b8f9c4f7daf74960a336871c615f0f\"}]', '', '27.694647', '106.924986', '1', '0', '0', '遵义市', '1466389062');
INSERT INTO `tc_messages` VALUES ('93', '0', '20000002', '刚才有人问我，遇到老人摔倒你会扶吗，我回答是必然不会！原因很简单，我没钱，更不敢冒险，爱莫能助！尤其在当今中国这个社会[emoji_372][emoji_372][emoji_372]', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160621/02297c086a66fb1c.jpg\",\"smallUrl\":\"/Uploads/Picture/20160621/s_02297c086a66fb1c.jpg\",\"id\":\"77525a7793cd7c214d92b750a44cbd01\"}]', '', '25.106825', '102.779646', '1', '0', '0', '昆明市', '1466484312');
INSERT INTO `tc_messages` VALUES ('94', '0', '20000002', '自家载的杨梅丰收[emoji_335][emoji_335][emoji_335]三个就有手掌大了，过瘾[emoji_360][emoji_360][emoji_360][emoji_13][emoji_13][emoji_13]', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160621/d8a37328ad1af24e.jpg\",\"smallUrl\":\"/Uploads/Picture/20160621/s_d8a37328ad1af24e.jpg\",\"id\":\"297d8c7f66a55d2aa768e271cf516e29\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20160621/cdebee4d77deb778.jpg\",\"smallUrl\":\"/Uploads/Picture/20160621/s_cdebee4d77deb778.jpg\",\"id\":\"fe1717b55455a15f8c97a814f55e4254\"},{\"key\":\"images3\",\"originUrl\":\"/Uploads/Picture/20160621/c5b4e6b71a6b7e52.jpg\",\"smallUrl\":\"/Uploads/Picture/20160621/s_c5b4e6b71a6b7e52.jpg\",\"id\":\"5d0d511a393e4324275770bb3db6f4a3\"}]', '', '25.106335', '102.780285', '1', '0', '0', '昆明市', '1466508867');
INSERT INTO `tc_messages` VALUES ('95', '0', '20000002', '[emoji_261][emoji_261][emoji_261]各位大仙求解[emoji_158][emoji_158][emoji_158]\n\n145 × 154 ÷ D2：1G', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160623/2144fc6a5d7916e7.jpg\",\"smallUrl\":\"/Uploads/Picture/20160623/s_2144fc6a5d7916e7.jpg\",\"id\":\"7aefff1eae6a1f36fcf0887f31904915\"}]', '', '25.106806', '102.779661', '0', '0', '0', '', '1466668942');
INSERT INTO `tc_messages` VALUES ('96', '0', '20000002', '小死狗[emoji_81][emoji_81][emoji_81][emoji_86][emoji_86][emoji_86]', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160623/2748cc360e04f6f5.jpg\",\"smallUrl\":\"/Uploads/Picture/20160623/s_2748cc360e04f6f5.jpg\",\"id\":\"1dfd197bc4d9157bb8d12ab27261a930\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20160623/f3e502d66559cccc.jpg\",\"smallUrl\":\"/Uploads/Picture/20160623/s_f3e502d66559cccc.jpg\",\"id\":\"7c8c744eb1c5b606f35a0a172aa68a31\"}]', '', '25.089289', '102.737620', '1', '1', '0', '昆明市', '1466688818');
INSERT INTO `tc_messages` VALUES ('97', '0', '20000025', '我这辈子最大的遗憾[emoji_155]就是没有打败阿里巴巴[emoji_97]马老头真是有钱就任性[emoji_111]装逼[emoji_108][emoji_277]', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160624/1a135ce7d227b771.jpg\",\"smallUrl\":\"/Uploads/Picture/20160624/s_1a135ce7d227b771.jpg\",\"id\":\"635d2849acb9b292ab7a378c952f71eb\"}]', '', '25.035388', '102.753384', '1', '1', '0', '昆明市', '1466767556');
INSERT INTO `tc_messages` VALUES ('98', '0', '20000025', '呈贡斗南花花世界[emoji_96]', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160625/97ab1a9ff6e4740c.jpg\",\"smallUrl\":\"/Uploads/Picture/20160625/s_97ab1a9ff6e4740c.jpg\",\"id\":\"1d933898332895ea9c3e750d0950ad99\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20160625/003d897c729ec9a6.jpg\",\"smallUrl\":\"/Uploads/Picture/20160625/s_003d897c729ec9a6.jpg\",\"id\":\"1860e27e9d4f6686b4b123c7904f9f4f\"},{\"key\":\"images3\",\"originUrl\":\"/Uploads/Picture/20160625/d0c1dde5d2f3a4a9.jpg\",\"smallUrl\":\"/Uploads/Picture/20160625/s_d0c1dde5d2f3a4a9.jpg\",\"id\":\"5520bada6a0cf387f200745939d4a8e8\"},{\"key\":\"images4\",\"originUrl\":\"/Uploads/Picture/20160625/baa52a8e9191eabc.jpg\",\"smallUrl\":\"/Uploads/Picture/20160625/s_baa52a8e9191eabc.jpg\",\"id\":\"99f9638e7bb2a2daecd34c88a19817f5\"},{\"key\":\"images5\",\"originUrl\":\"/Uploads/Picture/20160625/9b2e80c9495af31b.jpg\",\"smallUrl\":\"/Uploads/Picture/20160625/s_9b2e80c9495af31b.jpg\",\"id\":\"d8abe09f368683c4d3a1b220065c9b5b\"},{\"key\":\"images6\",\"originUrl\":\"/Uploads/Picture/20160625/bd9bc4b67c41bd46.jpg\",\"smallUrl\":\"/Uploads/Picture/20160625/s_bd9bc4b67c41bd46.jpg\",\"id\":\"5790b3d1b92dd549a3190cd51f6217b4\"}]', '', '24.907898', '102.794855', '1', '0', '0', '昆明市', '1466840756');
INSERT INTO `tc_messages` VALUES ('99', '0', '20000025', '英国脱欧，感觉全世界都炸了，可我只想说：与我有毛关系？[emoji_97]还是我有病了吗？[emoji_96][emoji_368]', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160625/60bde6b1c6bdb817.jpg\",\"smallUrl\":\"/Uploads/Picture/20160625/s_60bde6b1c6bdb817.jpg\",\"id\":\"ef0864808bde0a094dcd88173b8ffec0\"}]', '', '24.899914', '102.782862', '1', '1', '0', '昆明市', '1466844513');
INSERT INTO `tc_messages` VALUES ('100', '0', '20000002', '意大利[emoji_13][emoji_13][emoji_13]不错[emoji_370][emoji_370][emoji_370]', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160628/632b368e207fcefd.jpg\",\"smallUrl\":\"/Uploads/Picture/20160628/s_632b368e207fcefd.jpg\",\"id\":\"0bffed990c7dbc41d54d958c1745de3b\"}]', '', '25.106849', '102.779673', '1', '1', '0', '昆明市', '1467050292');
INSERT INTO `tc_messages` VALUES ('101', '0', '20000025', '到车展去看美女[emoji_26][emoji_292][emoji_296]结果很失望[emoji_180]', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160630/76af188eaeeff26d.jpg\",\"smallUrl\":\"/Uploads/Picture/20160630/s_76af188eaeeff26d.jpg\",\"id\":\"a1ecaaccf8f8fe2fc43429e4e1be2b40\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20160630/622283ffefefbfe9.jpg\",\"smallUrl\":\"/Uploads/Picture/20160630/s_622283ffefefbfe9.jpg\",\"id\":\"52d0731e2aa4a34a075eb96d91f5a921\"},{\"key\":\"images3\",\"originUrl\":\"/Uploads/Picture/20160630/4bdd7d3ed35ad4f0.jpg\",\"smallUrl\":\"/Uploads/Picture/20160630/s_4bdd7d3ed35ad4f0.jpg\",\"id\":\"56503decb871074609fcfde4d4a70765\"},{\"key\":\"images4\",\"originUrl\":\"/Uploads/Picture/20160630/ef2c1cb6be88473c.jpg\",\"smallUrl\":\"/Uploads/Picture/20160630/s_ef2c1cb6be88473c.jpg\",\"id\":\"8850bc67934cb4023283f10be0a7864a\"},{\"key\":\"images5\",\"originUrl\":\"/Uploads/Picture/20160630/9c0458b497d94383.jpg\",\"smallUrl\":\"/Uploads/Picture/20160630/s_9c0458b497d94383.jpg\",\"id\":\"287d55ef3e68d9422f0efe9c6a2348a0\"},{\"key\":\"images6\",\"originUrl\":\"/Uploads/Picture/20160630/6804ca6cc9657d47.jpg\",\"smallUrl\":\"/Uploads/Picture/20160630/s_6804ca6cc9657d47.jpg\",\"id\":\"16a475bab53b06c30b83d231d043ebc9\"}]', '', '25.106908', '102.779735', '1', '1', '0', '昆明市', '1467286474');
INSERT INTO `tc_messages` VALUES ('102', '0', '20000070', '想旅游，没钱，还是努力创业吧', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160709/c622df79e1f70896.jpg\",\"smallUrl\":\"/Uploads/Picture/20160709/s_c622df79e1f70896.jpg\",\"id\":\"b8589e2d95aa4d7daaef10bbea6ff061\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20160709/23565f1e5483f64f.jpg\",\"smallUrl\":\"/Uploads/Picture/20160709/s_23565f1e5483f64f.jpg\",\"id\":\"5ee28988e180ffded9f2f5361fb62299\"},{\"key\":\"images3\",\"originUrl\":\"/Uploads/Picture/20160709/163eab06e6d4a490.png\",\"smallUrl\":\"/Uploads/Picture/20160709/s_163eab06e6d4a490.png\",\"id\":\"90cba22577164f84d9dda7a4922f204a\"}]', '', '31.258697', '121.245271', '1', '0', '0', '上海市', '1468060406');
INSERT INTO `tc_messages` VALUES ('103', '0', '20000002', '这还是那个金童玉女吗[emoji_96][emoji_96][emoji_96]岁月是把杀猪刀呀[emoji_97][emoji_97][emoji_97]', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160710/0f843bbc7c7f8215.jpg\",\"smallUrl\":\"/Uploads/Picture/20160710/s_0f843bbc7c7f8215.jpg\",\"id\":\"24cc37c689e3b2d9f4a4b1fbba41823b\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20160710/eefb760d8d08fa32.jpg\",\"smallUrl\":\"/Uploads/Picture/20160710/s_eefb760d8d08fa32.jpg\",\"id\":\"5495a148df090b05a9fe0e0aed12f053\"},{\"key\":\"images3\",\"originUrl\":\"/Uploads/Picture/20160710/fbc98d46099b3753.jpg\",\"smallUrl\":\"/Uploads/Picture/20160710/s_fbc98d46099b3753.jpg\",\"id\":\"8c1567cc31541b04aa72e892103ef3b7\"},{\"key\":\"images4\",\"originUrl\":\"/Uploads/Picture/20160710/5bcd5eebb20d3eb8.jpg\",\"smallUrl\":\"/Uploads/Picture/20160710/s_5bcd5eebb20d3eb8.jpg\",\"id\":\"890865df77c921ca512c0bca29fcbb0c\"}]', '', '0.000000', '0.000000', '1', '0', '0', '', '1468159366');
INSERT INTO `tc_messages` VALUES ('104', '0', '20000002', '[emoji_23][emoji_23][emoji_23]熬守二十几日的欧洲杯终于落幕[emoji_368][emoji_368][emoji_368]虽不是喜欢的球队，但还是恭喜葡萄牙获得冠军[emoji_13][emoji_13][emoji_13][emoji_370][emoji_370][emoji_370]一路走过来感觉就一物降一物，癞蛤蟆克怪物[emoji_357][emoji_357][emoji_357]葡萄牙把法国克了，法国把德国克了，德国把意大利克了，意大利把西班牙克了[emoji_97][emoji_97][emoji_97][emoji_354][emoji_354][emoji_354]说明了一个道理：出来混都是要还的[emoji_101][emoji_101][emoji_101][emoji_108][emoji_108][emoji_108]', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160711/de2f982dd5da2856.jpg\",\"smallUrl\":\"/Uploads/Picture/20160711/s_de2f982dd5da2856.jpg\",\"id\":\"7035195b5055a9c4027a52624b13893a\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20160711/5033bc1ee3f3f74f.jpg\",\"smallUrl\":\"/Uploads/Picture/20160711/s_5033bc1ee3f3f74f.jpg\",\"id\":\"5e027c8b4cccda538c614ecc3eb39893\"},{\"key\":\"images3\",\"originUrl\":\"/Uploads/Picture/20160711/7bf0061d6f47f3ae.jpg\",\"smallUrl\":\"/Uploads/Picture/20160711/s_7bf0061d6f47f3ae.jpg\",\"id\":\"caf3e8a5232274a304b756e3b343e8ae\"},{\"key\":\"images4\",\"originUrl\":\"/Uploads/Picture/20160711/4213c11ceb866739.jpg\",\"smallUrl\":\"/Uploads/Picture/20160711/s_4213c11ceb866739.jpg\",\"id\":\"cba9daec746aca493163046fea3b83a1\"},{\"key\":\"images5\",\"originUrl\":\"/Uploads/Picture/20160711/b6797f861afc41e1.jpg\",\"smallUrl\":\"/Uploads/Picture/20160711/s_b6797f861afc41e1.jpg\",\"id\":\"f41697c27045fc5530ef75458e08b46b\"},{\"key\":\"images6\",\"originUrl\":\"/Uploads/Picture/20160711/619a9d8954c86576.jpg\",\"smallUrl\":\"/Uploads/Picture/20160711/s_619a9d8954c86576.jpg\",\"id\":\"0932d7835e55d815bc6c1f1b270f0a53\"}]', '', '0.000000', '0.000000', '1', '1', '0', '', '1468190208');
INSERT INTO `tc_messages` VALUES ('105', '0', '20000070', '【早安励志】成功的路上只需三步\n第一步:｛相信｝\n选择之前可以怀疑，选择之后必须相信。\n第二步:｛行动｝\n给梦想插上翅膀才能飞翔,读万卷书不如行万里路\n第三步:｛坚持｝\n任何梦想的实现都是持续努力的结果。\n一锹挖不出井来！\n相信！行动！坚持！\n生命就是这样绽放！\n与有梦想的人同行！\n把握趋势掌握未来！五元创业详情微信a15000326929\n早安！[太阳][太阳][太阳][拳头]', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160711/1bef880129ad8c5d.png\",\"smallUrl\":\"/Uploads/Picture/20160711/s_1bef880129ad8c5d.png\",\"id\":\"15b04bfa2604343b05a987130d9a1e7e\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20160711/701065f518c0ab2b.png\",\"smallUrl\":\"/Uploads/Picture/20160711/s_701065f518c0ab2b.png\",\"id\":\"bc9e0bfda30d1e4067dc469e11014201\"},{\"key\":\"images3\",\"originUrl\":\"/Uploads/Picture/20160711/b918d398261b5603.png\",\"smallUrl\":\"/Uploads/Picture/20160711/s_b918d398261b5603.png\",\"id\":\"b160359cedfec91bc3da99ec1fe8be0f\"},{\"key\":\"images4\",\"originUrl\":\"/Uploads/Picture/20160711/ad85e0967cb94541.png\",\"smallUrl\":\"/Uploads/Picture/20160711/s_ad85e0967cb94541.png\",\"id\":\"4087766d0d28b27a11e1f9f19c5e5e7f\"},{\"key\":\"images5\",\"originUrl\":\"/Uploads/Picture/20160711/8b66cf9d80752fdd.png\",\"smallUrl\":\"/Uploads/Picture/20160711/s_8b66cf9d80752fdd.png\",\"id\":\"a0305ca5be383878861c1bf606fd0a2f\"},{\"key\":\"images6\",\"originUrl\":\"/Uploads/Picture/20160711/404233b8fb69449a.png\",\"smallUrl\":\"/Uploads/Picture/20160711/s_404233b8fb69449a.png\",\"id\":\"110dcc7bd6668571f2e0c9819bdaa134\"}]', '', '31.249114', '121.228659', '1', '1', '0', '上海市', '1468205317');
INSERT INTO `tc_messages` VALUES ('106', '0', '20000070', '五元创业你亏我补，五种模式赚钱，抢红包，起床签到，会员推广，商城分销，详情微信非诚勿扰，a15665574390', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160712/3fa3b23968ef9815.jpg\",\"smallUrl\":\"/Uploads/Picture/20160712/s_3fa3b23968ef9815.jpg\",\"id\":\"6659028f0cceafe88a1c8618173cef74\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20160712/c6b5328f764edba3.png\",\"smallUrl\":\"/Uploads/Picture/20160712/s_c6b5328f764edba3.png\",\"id\":\"020a3bf99c0a72ddf354d31f03529efd\"},{\"key\":\"images3\",\"originUrl\":\"/Uploads/Picture/20160712/e874f77b2827a73a.png\",\"smallUrl\":\"/Uploads/Picture/20160712/s_e874f77b2827a73a.png\",\"id\":\"1292648c0d014d26dd56c354181dc9a4\"},{\"key\":\"images4\",\"originUrl\":\"/Uploads/Picture/20160712/0d88237fb11a377e.png\",\"smallUrl\":\"/Uploads/Picture/20160712/s_0d88237fb11a377e.png\",\"id\":\"2af1cd1c1996447f751dfc0371086bf3\"},{\"key\":\"images5\",\"originUrl\":\"/Uploads/Picture/20160712/7264db43b14442a5.jpg\",\"smallUrl\":\"/Uploads/Picture/20160712/s_7264db43b14442a5.jpg\",\"id\":\"4998d5e0b3c6afe0a9ee445330e6ad9f\"}]', '', '31.258685', '121.245338', '1', '1', '0', '上海市', '1468326745');
INSERT INTO `tc_messages` VALUES ('107', '0', '20000002', '大神无处不在[emoji_13][emoji_13][emoji_13]这样也可以[emoji_96][emoji_96][emoji_96]佩服[emoji_370][emoji_370][emoji_370]', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160713/1777c1493f11adf8.jpg\",\"smallUrl\":\"/Uploads/Picture/20160713/s_1777c1493f11adf8.jpg\",\"id\":\"324d8d60684615134665fbb70f5eaa01\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20160713/a5ee322a40ab9590.jpg\",\"smallUrl\":\"/Uploads/Picture/20160713/s_a5ee322a40ab9590.jpg\",\"id\":\"def881289e1cd76e415ed55c4067493c\"},{\"key\":\"images3\",\"originUrl\":\"/Uploads/Picture/20160713/ce18a621fdfce380.jpg\",\"smallUrl\":\"/Uploads/Picture/20160713/s_ce18a621fdfce380.jpg\",\"id\":\"5de5f0233114e42ea7379ebde7f74f35\"},{\"key\":\"images4\",\"originUrl\":\"/Uploads/Picture/20160713/189b9f7fab345199.jpg\",\"smallUrl\":\"/Uploads/Picture/20160713/s_189b9f7fab345199.jpg\",\"id\":\"e5005c9c28374f13975378ba9abf2ab8\"},{\"key\":\"images5\",\"originUrl\":\"/Uploads/Picture/20160713/0b2bb36a93dd6853.jpg\",\"smallUrl\":\"/Uploads/Picture/20160713/s_0b2bb36a93dd6853.jpg\",\"id\":\"6d7b2e35e21b2c6972a83024edd960b3\"},{\"key\":\"images6\",\"originUrl\":\"/Uploads/Picture/20160713/c652ff853154b827.jpg\",\"smallUrl\":\"/Uploads/Picture/20160713/s_c652ff853154b827.jpg\",\"id\":\"5ab548a9a2ba208e084c39f413c1b3d9\"}]', '', '25.106870', '102.779651', '1', '0', '0', '昆明市', '1468404424');
INSERT INTO `tc_messages` VALUES ('108', '0', '20000002', '南海[emoji_269][emoji_269][emoji_269]呵呵[emoji_279][emoji_279][emoji_279][emoji_108][emoji_108][emoji_108][emoji_165][emoji_165][emoji_165]', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160713/a13acd639157ad48.jpg\",\"smallUrl\":\"/Uploads/Picture/20160713/s_a13acd639157ad48.jpg\",\"id\":\"116aab4cd3cf35ec3e8853a948677547\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20160713/8fa802ea3d4008ac.jpg\",\"smallUrl\":\"/Uploads/Picture/20160713/s_8fa802ea3d4008ac.jpg\",\"id\":\"34be1f08bd86dea29c8ba6a52b2c58c4\"},{\"key\":\"images3\",\"originUrl\":\"/Uploads/Picture/20160713/a88a233924434c93.jpg\",\"smallUrl\":\"/Uploads/Picture/20160713/s_a88a233924434c93.jpg\",\"id\":\"56f66967fe3877659a83aeec2e51bc90\"}]', '', '25.106746', '102.779446', '1', '0', '0', '昆明市', '1468408567');
INSERT INTO `tc_messages` VALUES ('109', '0', '20000001', '成都！', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160714/cf56158e6d6a3ca6.jpg\",\"smallUrl\":\"/Uploads/Picture/20160714/s_cf56158e6d6a3ca6.jpg\",\"id\":\"504e19b664c21a789844021ab479dea4\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20160714/efb8005ba966c133.jpg\",\"smallUrl\":\"/Uploads/Picture/20160714/s_efb8005ba966c133.jpg\",\"id\":\"033df68345f528b2c4e7b561f7a8751e\"},{\"key\":\"images3\",\"originUrl\":\"/Uploads/Picture/20160714/d1196b6e0f4ea41c.jpg\",\"smallUrl\":\"/Uploads/Picture/20160714/s_d1196b6e0f4ea41c.jpg\",\"id\":\"50d694530f12e4c094271342d1e7f029\"},{\"key\":\"images4\",\"originUrl\":\"/Uploads/Picture/20160714/607e2f88f78c2356.jpg\",\"smallUrl\":\"/Uploads/Picture/20160714/s_607e2f88f78c2356.jpg\",\"id\":\"cd2a9dd2e1b9947fb32ea65e89def7c3\"}]', '', '30.738999', '103.978779', '1', '0', '0', '成都市', '1468481968');
INSERT INTO `tc_messages` VALUES ('110', '0', '20000001', '三月的成都。', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160714/f068e26f547eef51.jpg\",\"smallUrl\":\"/Uploads/Picture/20160714/s_f068e26f547eef51.jpg\",\"id\":\"0a6e5f6e942c0b58459bb212cd1659b8\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20160714/266447f095b9362f.jpg\",\"smallUrl\":\"/Uploads/Picture/20160714/s_266447f095b9362f.jpg\",\"id\":\"cd08a64b22f5af3c8fef10e91399407d\"},{\"key\":\"images3\",\"originUrl\":\"/Uploads/Picture/20160714/bf769ea4d29cc6e4.jpg\",\"smallUrl\":\"/Uploads/Picture/20160714/s_bf769ea4d29cc6e4.jpg\",\"id\":\"88ef9445704d147d9417a88c5a307e3b\"},{\"key\":\"images4\",\"originUrl\":\"/Uploads/Picture/20160714/3b5c23a19339ed25.jpg\",\"smallUrl\":\"/Uploads/Picture/20160714/s_3b5c23a19339ed25.jpg\",\"id\":\"fcf4b70a5295783f6257e7146108632b\"},{\"key\":\"images5\",\"originUrl\":\"/Uploads/Picture/20160714/b2e58fad1da055a5.jpg\",\"smallUrl\":\"/Uploads/Picture/20160714/s_b2e58fad1da055a5.jpg\",\"id\":\"7904a99633295f083a0bc09a859c2fac\"}]', '', '30.738999', '103.978779', '1', '0', '0', '成都市', '1468482105');
INSERT INTO `tc_messages` VALUES ('111', '0', '20000001', '时刻准备着！', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160714/35415fcf494dcebf.png\",\"smallUrl\":\"/Uploads/Picture/20160714/s_35415fcf494dcebf.png\",\"id\":\"4f27eb701178dfb58f62b88f62bd6ba0\"}]', '', '30.738999', '103.978779', '1', '1', '0', '成都市', '1468482318');
INSERT INTO `tc_messages` VALUES ('112', '0', '20000025', '外面下大雨[emoji_74]这样的灯光下坚持打个球[emoji_165][emoji_19][emoji_16]', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160714/1cf93314683422e5.jpg\",\"smallUrl\":\"/Uploads/Picture/20160714/s_1cf93314683422e5.jpg\",\"id\":\"3d42194178743d2878b02013dc3608de\"}]', '', '25.106861', '102.779694', '1', '2', '0', '昆明市', '1468506422');
INSERT INTO `tc_messages` VALUES ('113', '0', '20000070', '五元创业，一分提现，详情加我，微信a15665574390', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160715/0cb0b8177f08b79b.png\",\"smallUrl\":\"/Uploads/Picture/20160715/s_0cb0b8177f08b79b.png\",\"id\":\"ba9361111c6c9f7c0388805434894cc0\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20160715/4e9142c7853dbfc8.png\",\"smallUrl\":\"/Uploads/Picture/20160715/s_4e9142c7853dbfc8.png\",\"id\":\"b7bcab12e61f26d4e40f8279f5442ed9\"},{\"key\":\"images3\",\"originUrl\":\"/Uploads/Picture/20160715/adb04fe657855f20.png\",\"smallUrl\":\"/Uploads/Picture/20160715/s_adb04fe657855f20.png\",\"id\":\"0f45ff29aaa8e256ce72be77ae807e1b\"},{\"key\":\"images4\",\"originUrl\":\"/Uploads/Picture/20160715/26435c7668977d58.png\",\"smallUrl\":\"/Uploads/Picture/20160715/s_26435c7668977d58.png\",\"id\":\"4362dac7628d09cbce0a58c56a3708d8\"},{\"key\":\"images5\",\"originUrl\":\"/Uploads/Picture/20160715/6d1c3f3e2b7c83b0.png\",\"smallUrl\":\"/Uploads/Picture/20160715/s_6d1c3f3e2b7c83b0.png\",\"id\":\"4d230e284b380c161e71e0c2c5e20602\"},{\"key\":\"images6\",\"originUrl\":\"/Uploads/Picture/20160715/b4de37730cb64b0f.png\",\"smallUrl\":\"/Uploads/Picture/20160715/s_b4de37730cb64b0f.png\",\"id\":\"9c2f5a701f271606432dd5116f94f673\"}]', '', '31.249125', '121.228602', '1', '0', '0', '上海市', '1468550909');
INSERT INTO `tc_messages` VALUES ('114', '0', '20000070', '五元创业，一分提现，详情加我，微信a15665574390', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160715/29206b95d417f995.png\",\"smallUrl\":\"/Uploads/Picture/20160715/s_29206b95d417f995.png\",\"id\":\"78481b254bee442aa1c9f2679cda2517\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20160715/e32c025cd763f7ff.png\",\"smallUrl\":\"/Uploads/Picture/20160715/s_e32c025cd763f7ff.png\",\"id\":\"a65ed985c58e31e4417c63c35c4e61c7\"},{\"key\":\"images3\",\"originUrl\":\"/Uploads/Picture/20160715/854f493b56d72b13.png\",\"smallUrl\":\"/Uploads/Picture/20160715/s_854f493b56d72b13.png\",\"id\":\"f1fc42e7166c69079d79f9dc37fd9e69\"}]', '', '31.249125', '121.228602', '0', '0', '0', '上海市', '1468550960');
INSERT INTO `tc_messages` VALUES ('115', '0', '20000025', '来晚啦[emoji_180][emoji_354]面对的是[emoji_222]旷的大厅[emoji_149]', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160720/abaa8251eae4fbc7.jpg\",\"smallUrl\":\"/Uploads/Picture/20160720/s_abaa8251eae4fbc7.jpg\",\"id\":\"222962ab8243e3016ffb82fa801f31a2\"}]', '', '25.059623', '102.732426', '1', '0', '0', '昆明市', '1468989563');
INSERT INTO `tc_messages` VALUES ('116', '0', '20000001', '快看啊！护士都走光了[emoji_95][emoji_95][emoji_95]', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160721/7c6bd527d619e00e.png\",\"smallUrl\":\"/Uploads/Picture/20160721/s_7c6bd527d619e00e.png\",\"id\":\"4d00b1463e53a6dee4119134fda91e33\"}]', '', '30.739032', '103.978806', '1', '0', '0', '成都市', '1469071958');
INSERT INTO `tc_messages` VALUES ('117', '0', '20000001', '爱吃零食小鹿[emoji_81][emoji_81]', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160722/c1bfbfe110e9ef23.jpg\",\"smallUrl\":\"/Uploads/Picture/20160722/s_c1bfbfe110e9ef23.jpg\",\"id\":\"a750857b60b8d41f386ca86ba409ffa2\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20160722/0c54e35be763224c.jpg\",\"smallUrl\":\"/Uploads/Picture/20160722/s_0c54e35be763224c.jpg\",\"id\":\"703a361f10d7c837bc436ce583e4b9ab\"},{\"key\":\"images3\",\"originUrl\":\"/Uploads/Picture/20160722/33b0b0209043b4e2.jpg\",\"smallUrl\":\"/Uploads/Picture/20160722/s_33b0b0209043b4e2.jpg\",\"id\":\"69ad7fec38cc23b8810697aedce1e5af\"},{\"key\":\"images4\",\"originUrl\":\"/Uploads/Picture/20160722/ac8bf7ce3f6e1542.jpg\",\"smallUrl\":\"/Uploads/Picture/20160722/s_ac8bf7ce3f6e1542.jpg\",\"id\":\"12470733b0ef1109725f273770a55f6c\"}]', '', '30.739442', '103.992628', '1', '0', '0', '成都市', '1469199856');
INSERT INTO `tc_messages` VALUES ('118', '0', '20000000', '惹惹哒[emoji_352][emoji_352][emoji_357]', '', '', '28.129390', '112.998701', '0', '0', '0', '长沙市', '1469245564');
INSERT INTO `tc_messages` VALUES ('119', '0', '20000077', '怎么好看的衣服，相信每个女人都会动心吧。', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160725/43ed8699bf0e66c6.png\",\"smallUrl\":\"/Uploads/Picture/20160725/s_43ed8699bf0e66c6.png\",\"id\":\"13cbe78c7c569f96e828138103e1611f\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20160725/9d9e15dc9c4ec315.png\",\"smallUrl\":\"/Uploads/Picture/20160725/s_9d9e15dc9c4ec315.png\",\"id\":\"884605912ac331a54c30a2ee983220d1\"},{\"key\":\"images3\",\"originUrl\":\"/Uploads/Picture/20160725/2253f51b146eb13f.png\",\"smallUrl\":\"/Uploads/Picture/20160725/s_2253f51b146eb13f.png\",\"id\":\"47c0a2e3e7d0b9c621bd4acfa998c304\"},{\"key\":\"images4\",\"originUrl\":\"/Uploads/Picture/20160725/1a640d7a12daa4c6.png\",\"smallUrl\":\"/Uploads/Picture/20160725/s_1a640d7a12daa4c6.png\",\"id\":\"41845e05a16b42688a400d3883ef568f\"},{\"key\":\"images5\",\"originUrl\":\"/Uploads/Picture/20160725/e9b1684d34ff92f4.png\",\"smallUrl\":\"/Uploads/Picture/20160725/s_e9b1684d34ff92f4.png\",\"id\":\"2651fbbd26646327f840c326cec191fb\"},{\"key\":\"images6\",\"originUrl\":\"/Uploads/Picture/20160725/d5dd0e7b4e6c38d5.png\",\"smallUrl\":\"/Uploads/Picture/20160725/s_d5dd0e7b4e6c38d5.png\",\"id\":\"da2f6dc781a22d4d690bafc374d1bf9a\"}]', '', '23.376976', '116.745898', '1', '2', '0', '汕头市', '1469407649');
INSERT INTO `tc_messages` VALUES ('120', '0', '20000000', 'test', '', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160725/c7f5d6cd4f5007a9.png\",\"smallUrl\":\"/Uploads/Picture/20160725/s_c7f5d6cd4f5007a9.png\",\"id\":\"522de29dbc64fefa6ba7f19a5b98f301\"},{\"originUrl\":\"/Uploads/Picture/20160725/89daef4406a4065b.mp4\",\"smallUrl\":\"/Uploads/Picture/20160725/89daef4406a4065b.mp4\",\"id\":\"484d5559a944162b1c3d42f118fbb1ac\",\"key\":\"video\"}]', '28.129513', '112.998831', '1', '0', '0', '长沙市', '1469447653');
INSERT INTO `tc_messages` VALUES ('121', '0', '20000025', '老虎咬伤的女人是延庆部队（空军副营长的媳妇）研究生毕业，30岁，安徽人，平常总是和老公吵架，此次事件的过程是埋怨老公开车肉，自己要开让老公下车。现在她的下巴被咬没了，前胸抓的模糊不清，丈母娘当时被另一只老虎咬住脖子当场死亡。 \n针对老虎咬人事件，网络观点集中如下: \n1.不做死就不会死，动物园无责任\n2.不愧是野生动物园，保持动物野性做的不错，值得一去\n3.母老虎遭遇真老虎，最后发现自己是纸老虎\n4.低智商必须被淘汰，这智商活着也没意思\n5.肯定是亲妈，不是婆婆\n6.想当母老虎也要分地方\n7.明知山有虎，偏向虎山行\n8.近日该园猛曽区流量大增，均为中年男士携妻子和丈母娘亲密前往，并长时间停留。', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160726/b2c93c1e66e0df1e.jpg\",\"smallUrl\":\"/Uploads/Picture/20160726/s_b2c93c1e66e0df1e.jpg\",\"id\":\"34f5802b80835edb58bb05d67df99e70\"}]', '', '25.106866', '102.779641', '1', '0', '0', '昆明市', '1469517365');
INSERT INTO `tc_messages` VALUES ('122', '0', '20000025', '现在全国大部分地区进入烧烤模式[emoji_73][emoji_118][emoji_96]北方是洗澡模式[emoji_74][emoji_356]只有我们云南是野生菌模式[emoji_13][emoji_370]羡慕吧[emoji_86][emoji_301]', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160726/3cdec222d5d85089.jpg\",\"smallUrl\":\"/Uploads/Picture/20160726/s_3cdec222d5d85089.jpg\",\"id\":\"d77303d7c382555ba8cdd89230655453\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20160726/c1413b2e43533f5a.jpg\",\"smallUrl\":\"/Uploads/Picture/20160726/s_c1413b2e43533f5a.jpg\",\"id\":\"b9167cce625012f22fd43c27bd0adfeb\"}]', '', '25.106866', '102.779641', '1', '0', '0', '昆明市', '1469517768');
INSERT INTO `tc_messages` VALUES ('123', '0', '20000025', '开启出行模式[emoji_26][emoji_139][emoji_179][emoji_180]', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160803/fe72c344da4a031c.jpg\",\"smallUrl\":\"/Uploads/Picture/20160803/s_fe72c344da4a031c.jpg\",\"id\":\"8a5700055dd20b1f49c68796828ddf85\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20160803/e0d77034572c81c3.jpg\",\"smallUrl\":\"/Uploads/Picture/20160803/s_e0d77034572c81c3.jpg\",\"id\":\"6c1916d14d37c8ed1040bf4a0ea8b04f\"},{\"key\":\"images3\",\"originUrl\":\"/Uploads/Picture/20160803/a5e5f7bf71c09a5e.jpg\",\"smallUrl\":\"/Uploads/Picture/20160803/s_a5e5f7bf71c09a5e.jpg\",\"id\":\"755c835d2ede439770c2c6ab1328de6b\"}]', '', '24.869006', '102.497805', '1', '0', '0', '昆明市', '1470198423');
INSERT INTO `tc_messages` VALUES ('124', '0', '20000025', '【开心一笑】[emoji_86]\n老师问：“有钱，任性”的下联是？” 学生答：“没钱，认命”。 老师哑然！\n\n老师问：\"用一句话形容现代男人的婚后生活！” 学生：“娶了个祖宗生了个爹！” \n\n老师再问：“古代女人为什么要裹脚？” 学生大声道：“怕她们逛街”\n\n老师接着问：“那么为什么现在不裹了” 学生：“现在有了网购，裹脚也没用。‘’老师：来来你讲课…..........', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160805/25e0ebd6e3178ec5.jpg\",\"smallUrl\":\"/Uploads/Picture/20160805/s_25e0ebd6e3178ec5.jpg\",\"id\":\"ee03ec0e489cf83f686af32497ca63a9\"}]', '', '25.115871', '102.752079', '1', '0', '0', '昆明市', '1470365007');
INSERT INTO `tc_messages` VALUES ('125', '0', '20000025', '世界盛会', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160806/8feca0b47dd29f74.jpg\",\"smallUrl\":\"/Uploads/Picture/20160806/s_8feca0b47dd29f74.jpg\",\"id\":\"b1622bfb1a5894ab40309d7172ded07e\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20160806/065a94cfb9142fbb.jpg\",\"smallUrl\":\"/Uploads/Picture/20160806/s_065a94cfb9142fbb.jpg\",\"id\":\"fb4b2f6a8161e9add8477bb91cc320ff\"},{\"key\":\"images3\",\"originUrl\":\"/Uploads/Picture/20160806/922085492e8ccd4e.jpg\",\"smallUrl\":\"/Uploads/Picture/20160806/s_922085492e8ccd4e.jpg\",\"id\":\"a226eabf9c8861dc84a76d71141667f0\"},{\"key\":\"images4\",\"originUrl\":\"/Uploads/Picture/20160806/50b82bca7563e225.jpg\",\"smallUrl\":\"/Uploads/Picture/20160806/s_50b82bca7563e225.jpg\",\"id\":\"4cf6a2d5e8c4d0b423ce0bfa817c5002\"},{\"key\":\"images5\",\"originUrl\":\"/Uploads/Picture/20160806/e9b446eb6d3fe7ec.jpg\",\"smallUrl\":\"/Uploads/Picture/20160806/s_e9b446eb6d3fe7ec.jpg\",\"id\":\"8d46b528f660e403dc565ef59e29d656\"},{\"key\":\"images6\",\"originUrl\":\"/Uploads/Picture/20160806/8fe68710c85af602.jpg\",\"smallUrl\":\"/Uploads/Picture/20160806/s_8fe68710c85af602.jpg\",\"id\":\"a412babfdcbfcc2fe6cf6794c2da8296\"}]', '', '25.106885', '102.779688', '1', '0', '0', '', '1470450289');
INSERT INTO `tc_messages` VALUES ('126', '0', '20000088', '好看不', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160810/f08bee3c71e81edd.png\",\"smallUrl\":\"/Uploads/Picture/20160810/s_f08bee3c71e81edd.png\",\"id\":\"bc3328e51dd5d29c9c0ca923d54bc2b4\"}]', '', '24.801208', '118.633565', '1', '0', '0', '泉州市', '1470843978');
INSERT INTO `tc_messages` VALUES ('127', '0', '20000090', '哈哈', '[{\"key\":\"images\",\"originUrl\":\"/Uploads/Picture/20160811/a0a295c22ae71bbb.png\",\"smallUrl\":\"/Uploads/Picture/20160811/s_a0a295c22ae71bbb.png\",\"id\":\"93163ead6073ca324e7678e61a7a9cde\"}]', '', '30.738821', '103.978956', '1', '0', '0', '成都市', '1470887548');
INSERT INTO `tc_messages` VALUES ('129', '0', '20000025', '[emoji_357][emoji_357][emoji_357]', '', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160814/8dd073d5b86b015e.jpg\",\"smallUrl\":\"/Uploads/Picture/20160814/s_8dd073d5b86b015e.jpg\",\"id\":\"9fb54e31b6c5affc913c2867e177b0b5\"},{\"originUrl\":\"/Uploads/Picture/20160814/a8d92dc3f1ad971c.mp4\",\"smallUrl\":\"/Uploads/Picture/20160814/a8d92dc3f1ad971c.mp4\",\"id\":\"9c09da1fda340fd8d2e4e9759a1f0bb8\",\"key\":\"video\"}]', '25.106866', '102.779774', '1', '1', '0', '昆明市', '1471184746');
INSERT INTO `tc_messages` VALUES ('130', '0', '20000025', '什么是中文？[emoji_354][emoji_354][emoji_354]\n  一美国人来华留学4年，主攻汉语。临毕业，参加中文晋级考试，题量超少，暗喜。再仔细一看，懞了！题目如下： \n\n一、请写出下面两句话的区别在哪里？ \n 1、冬天：能穿多少穿多少；夏天：能穿多少穿多少。 \n 2、剩女产生的原因有两个，一是谁都看不上，二是谁都看不上。 \n 3、女孩给男朋友打电话：如果你到了，我还没到，你就等着吧；如果我到了，你还没到，你就等着吧。 \n 4、单身的原因：原来是喜欢一个人，现在是喜欢一个人。 \n \n 二、附加题： \n 中国足球和中国乒乓球，一是谁都赢不了，二是谁都赢不了。\n 美国佬泪流满面，交了白卷，回国了。。。。。。。。。', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160815/03dd25cdc829335b.jpg\",\"smallUrl\":\"/Uploads/Picture/20160815/s_03dd25cdc829335b.jpg\",\"id\":\"4ac85c8972470a111514ae71ae41b3dd\"}]', '', '24.989119', '102.658882', '1', '1', '0', '昆明市', '1471255925');
INSERT INTO `tc_messages` VALUES ('132', '0', '20000025', '出个门就那么难，堵[emoji_354][emoji_354][emoji_354]', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160818/b2b14cc6b2beaf5c.jpg\",\"smallUrl\":\"/Uploads/Picture/20160818/s_b2b14cc6b2beaf5c.jpg\",\"id\":\"4fe5a504a073c3ffdb1020ee48ade130\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20160818/276ab22def2e861a.jpg\",\"smallUrl\":\"/Uploads/Picture/20160818/s_276ab22def2e861a.jpg\",\"id\":\"82df5afbf2e99a4fcdf97652790ef446\"},{\"key\":\"images3\",\"originUrl\":\"/Uploads/Picture/20160818/793ddb9cea0cced5.jpg\",\"smallUrl\":\"/Uploads/Picture/20160818/s_793ddb9cea0cced5.jpg\",\"id\":\"901df8121be619d212017b32684a5c1d\"},{\"key\":\"images4\",\"originUrl\":\"/Uploads/Picture/20160818/b3d51447a02d670b.jpg\",\"smallUrl\":\"/Uploads/Picture/20160818/s_b3d51447a02d670b.jpg\",\"id\":\"29acdf40a74b577de7c4f55f51fe7a10\"}]', '', '23.098405', '101.160022', '1', '1', '0', '普洱市', '1471507840');
INSERT INTO `tc_messages` VALUES ('133', '0', '20000025', '8公里的栈道，悠哉悠哉[emoji_349][emoji_349][emoji_349]', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160820/afc847803418b9bb.jpg\",\"smallUrl\":\"/Uploads/Picture/20160820/s_afc847803418b9bb.jpg\",\"id\":\"58869d46258007caaf766e5398e90188\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20160820/afce9e1f30f6dfcd.jpg\",\"smallUrl\":\"/Uploads/Picture/20160820/s_afce9e1f30f6dfcd.jpg\",\"id\":\"cb76593e7f84a6e59b1e2fbb9ee5bd61\"},{\"key\":\"images3\",\"originUrl\":\"/Uploads/Picture/20160820/93e2a64fbec630a9.jpg\",\"smallUrl\":\"/Uploads/Picture/20160820/s_93e2a64fbec630a9.jpg\",\"id\":\"bedaa1bd13099acb64b8783c8a2a790a\"},{\"key\":\"images4\",\"originUrl\":\"/Uploads/Picture/20160820/799a41bdbce8a7e2.jpg\",\"smallUrl\":\"/Uploads/Picture/20160820/s_799a41bdbce8a7e2.jpg\",\"id\":\"acd5884dcd3169b4d5c44b650eae1e84\"},{\"key\":\"images5\",\"originUrl\":\"/Uploads/Picture/20160820/05a07dfd7884ed77.jpg\",\"smallUrl\":\"/Uploads/Picture/20160820/s_05a07dfd7884ed77.jpg\",\"id\":\"8743d96bd5b2db433999576d397814b9\"},{\"key\":\"images6\",\"originUrl\":\"/Uploads/Picture/20160820/0c46e239e3c1d3ed.jpg\",\"smallUrl\":\"/Uploads/Picture/20160820/s_0c46e239e3c1d3ed.jpg\",\"id\":\"fc161a53b16941c48c2ea03229622efa\"}]', '', '22.781066', '100.972337', '1', '1', '0', '普洱市', '1471665689');
INSERT INTO `tc_messages` VALUES ('134', '0', '20000025', '谌龙获得冠军了[emoji_13]但还是怀念林李，一个时代就此画上句号[emoji_370][emoji_368]', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160820/60cc628c8a56fe6a.jpg\",\"smallUrl\":\"/Uploads/Picture/20160820/s_60cc628c8a56fe6a.jpg\",\"id\":\"ec153fd51c4d20aa4ac53795a2302e0c\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20160820/f1896795f1686534.jpg\",\"smallUrl\":\"/Uploads/Picture/20160820/s_f1896795f1686534.jpg\",\"id\":\"6ef04e5e86d3a5d2aa47c67f9c6d712d\"},{\"key\":\"images3\",\"originUrl\":\"/Uploads/Picture/20160820/fd73e2bb50fa6252.jpg\",\"smallUrl\":\"/Uploads/Picture/20160820/s_fd73e2bb50fa6252.jpg\",\"id\":\"8baa111f35c90427671ea892ffa5b6cf\"},{\"key\":\"images4\",\"originUrl\":\"/Uploads/Picture/20160820/5b2d3c8295858981.jpg\",\"smallUrl\":\"/Uploads/Picture/20160820/s_5b2d3c8295858981.jpg\",\"id\":\"e53b82388078e561fc6cd0010116e42d\"}]', '', '22.780188', '100.972127', '1', '1', '0', '普洱市', '1471704921');
INSERT INTO `tc_messages` VALUES ('135', '0', '20000002', '面对同一件事物，心态不同结果就不一样：\n\n1.砍柴的和放羊的聊了一天，羊吃饱了，柴呢？ 砍柴的陪不起放羊的；——请放弃无效社交！\n\n2.砍柴的和放羊的聊了一天，各自学会了放羊技巧和砍柴技能；——三人行必有我师，永远保持空杯的状态\n\n3.砍柴的和放羊的聊了一天，决定羊跟柴交换，于是对方有了羊和柴；——等价交换，天生我才必有用\n\n4.砍柴的和放羊的聊了一天，把买羊的和买柴的各自客户介绍给对方，于是各自生意越做越大；——资源整合很重要\n\n5.砍柴的和放羊的，聊了一天，决定合作一起开个烤全羊店，柴烤出来的羊很美味，羊是纯天然的，几年后公司上市了；——没有完美的个人，只有完美的团队', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160830/f96d2671bf6fe4d2.jpg\",\"smallUrl\":\"/Uploads/Picture/20160830/s_f96d2671bf6fe4d2.jpg\",\"id\":\"fcfd97b1406eab26a200db07261e8acb\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20160830/6b87e312f4d8ddc5.jpg\",\"smallUrl\":\"/Uploads/Picture/20160830/s_6b87e312f4d8ddc5.jpg\",\"id\":\"9eed1815a4fc2d7e42fd076e31b4855a\"}]', '', '25.106776', '102.779763', '1', '0', '0', '昆明市', '1472558587');
INSERT INTO `tc_messages` VALUES ('136', '0', '20000025', '送侄儿报到，人多[emoji_354][emoji_346]', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160905/61cb0510658a3ec8.jpg\",\"smallUrl\":\"/Uploads/Picture/20160905/s_61cb0510658a3ec8.jpg\",\"id\":\"dcc4ee1d001c3a44acdc990a8e01c085\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20160905/8aae1b1692db2add.jpg\",\"smallUrl\":\"/Uploads/Picture/20160905/s_8aae1b1692db2add.jpg\",\"id\":\"0b80f7d845b50e69b565a3e785895422\"},{\"key\":\"images3\",\"originUrl\":\"/Uploads/Picture/20160905/d4e268d13218a8d1.jpg\",\"smallUrl\":\"/Uploads/Picture/20160905/s_d4e268d13218a8d1.jpg\",\"id\":\"af8c1822f6533133fd47f26709c77af8\"}]', '', '24.845736', '102.857197', '1', '0', '0', '昆明市', '1473047705');
INSERT INTO `tc_messages` VALUES ('137', '0', '20000025', '送完了来摘老树梨，树龄比我们还大[emoji_350][emoji_363]', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160905/9863637d0388a0f0.jpg\",\"smallUrl\":\"/Uploads/Picture/20160905/s_9863637d0388a0f0.jpg\",\"id\":\"c8de9fa36cf73447aad9e91cd0a8a621\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20160905/808f0085da442736.jpg\",\"smallUrl\":\"/Uploads/Picture/20160905/s_808f0085da442736.jpg\",\"id\":\"20007f255cbf12ef43fc70f42115d186\"},{\"key\":\"images3\",\"originUrl\":\"/Uploads/Picture/20160905/4df63b2772f642b3.jpg\",\"smallUrl\":\"/Uploads/Picture/20160905/s_4df63b2772f642b3.jpg\",\"id\":\"d8f8eec3a9e9affd8e3c6a10e4705e71\"},{\"key\":\"images4\",\"originUrl\":\"/Uploads/Picture/20160905/5df89e755ba75c9c.jpg\",\"smallUrl\":\"/Uploads/Picture/20160905/s_5df89e755ba75c9c.jpg\",\"id\":\"53874ad44997d5a98c0bb3e10fcf4350\"}]', '', '24.840505', '102.874237', '1', '2', '0', '昆明市', '1473060740');
INSERT INTO `tc_messages` VALUES ('138', '0', '20000002', '中秋快乐[emoji_86][emoji_49][emoji_121]', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160915/236fcc49091f3ee8.jpg\",\"smallUrl\":\"/Uploads/Picture/20160915/s_236fcc49091f3ee8.jpg\",\"id\":\"0ecc940f05207d75ffd326ab79f61bc0\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20160915/067b9a583f756f7c.jpg\",\"smallUrl\":\"/Uploads/Picture/20160915/s_067b9a583f756f7c.jpg\",\"id\":\"a9406e112f505c4abb6f08506bf6393d\"},{\"key\":\"images3\",\"originUrl\":\"/Uploads/Picture/20160915/72ea19dc2a533123.jpg\",\"smallUrl\":\"/Uploads/Picture/20160915/s_72ea19dc2a533123.jpg\",\"id\":\"22cfb420c2d7050d9c2918a8e35d0373\"},{\"key\":\"images4\",\"originUrl\":\"/Uploads/Picture/20160915/2a08175719271a46.jpg\",\"smallUrl\":\"/Uploads/Picture/20160915/s_2a08175719271a46.jpg\",\"id\":\"45bddd7506642586c32285241342ab7d\"},{\"key\":\"images5\",\"originUrl\":\"/Uploads/Picture/20160915/9cadb7fd53b2973a.jpg\",\"smallUrl\":\"/Uploads/Picture/20160915/s_9cadb7fd53b2973a.jpg\",\"id\":\"49ee2daff666cd1f7d805657101d93ca\"},{\"key\":\"images6\",\"originUrl\":\"/Uploads/Picture/20160915/70d31f874a39cbfc.jpg\",\"smallUrl\":\"/Uploads/Picture/20160915/s_70d31f874a39cbfc.jpg\",\"id\":\"9b102fab78f8eb3e03a1a0c82b022591\"}]', '', '25.106888', '102.779714', '1', '1', '0', '昆明市', '1473915454');
INSERT INTO `tc_messages` VALUES ('139', '0', '20000025', '再次看到女神[emoji_96]不一样的中秋夜[emoji_86]感慨女神已快60之人，却越来越有魅力[emoji_95]', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160916/4e89b7ec51d846aa.jpg\",\"smallUrl\":\"/Uploads/Picture/20160916/s_4e89b7ec51d846aa.jpg\",\"id\":\"3626127ecca03a341bbbf938e64816ab\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20160916/296ac6b0213d0dff.jpg\",\"smallUrl\":\"/Uploads/Picture/20160916/s_296ac6b0213d0dff.jpg\",\"id\":\"8cc0d50d81ab678dade1059e74d37434\"},{\"key\":\"images3\",\"originUrl\":\"/Uploads/Picture/20160916/5ca717486b20e4fb.jpg\",\"smallUrl\":\"/Uploads/Picture/20160916/s_5ca717486b20e4fb.jpg\",\"id\":\"439b1e1dd7f0a37d815929b2a93b992c\"},{\"key\":\"images4\",\"originUrl\":\"/Uploads/Picture/20160916/d59640ad76471547.jpg\",\"smallUrl\":\"/Uploads/Picture/20160916/s_d59640ad76471547.jpg\",\"id\":\"43e54960ca9737c09d8a229dc708d335\"},{\"key\":\"images5\",\"originUrl\":\"/Uploads/Picture/20160916/91584a55d89f2e12.jpg\",\"smallUrl\":\"/Uploads/Picture/20160916/s_91584a55d89f2e12.jpg\",\"id\":\"74365f6c8020aaf1b4dcfbfd3bd67bed\"},{\"key\":\"images6\",\"originUrl\":\"/Uploads/Picture/20160916/18c4a55b4b49aed1.jpg\",\"smallUrl\":\"/Uploads/Picture/20160916/s_18c4a55b4b49aed1.jpg\",\"id\":\"99a411720d12c5e6725c375c7f18ebc9\"}]', '', '25.106861', '102.779694', '1', '0', '0', '昆明市', '1474039547');
INSERT INTO `tc_messages` VALUES ('140', '0', '20000025', '[emoji_26][emoji_179][emoji_178]', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160923/bc340a24772fd5ef.jpg\",\"smallUrl\":\"/Uploads/Picture/20160923/s_bc340a24772fd5ef.jpg\",\"id\":\"1182284a403006a722fd3a863d1e3d36\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20160923/46514812ea23698e.jpg\",\"smallUrl\":\"/Uploads/Picture/20160923/s_46514812ea23698e.jpg\",\"id\":\"161c443c94b37c290662359831429074\"}]', '', '25.106846', '102.779713', '1', '1', '0', '昆明市', '1474635074');
INSERT INTO `tc_messages` VALUES ('141', '0', '20000002', '朋友开的新型生鲜店，颠覆传统[emoji_13][emoji_13][emoji_13]', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20161011/5bcf0faf8d741d57.jpg\",\"smallUrl\":\"/Uploads/Picture/20161011/s_5bcf0faf8d741d57.jpg\",\"id\":\"9645528c57defbe7a1210c9e3a68c7ca\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20161011/f0749d46055cb5f5.jpg\",\"smallUrl\":\"/Uploads/Picture/20161011/s_f0749d46055cb5f5.jpg\",\"id\":\"c608c100aa0f68121b3f24d326f776e3\"},{\"key\":\"images3\",\"originUrl\":\"/Uploads/Picture/20161011/573fdb440e08f558.jpg\",\"smallUrl\":\"/Uploads/Picture/20161011/s_573fdb440e08f558.jpg\",\"id\":\"51f89542781dc6675f3848f10cea4bec\"},{\"key\":\"images4\",\"originUrl\":\"/Uploads/Picture/20161011/07a5f0c4e20c0c27.jpg\",\"smallUrl\":\"/Uploads/Picture/20161011/s_07a5f0c4e20c0c27.jpg\",\"id\":\"046c88563f300bc9fed659a88ef6ba44\"},{\"key\":\"images5\",\"originUrl\":\"/Uploads/Picture/20161011/05dc5e92cb814d2a.jpg\",\"smallUrl\":\"/Uploads/Picture/20161011/s_05dc5e92cb814d2a.jpg\",\"id\":\"4fcf544ea40fe42614a7b19718a981e2\"},{\"key\":\"images6\",\"originUrl\":\"/Uploads/Picture/20161011/a0b1fba673ed9295.jpg\",\"smallUrl\":\"/Uploads/Picture/20161011/s_a0b1fba673ed9295.jpg\",\"id\":\"52d0cb951502a511d53da3c33f3983d9\"}]', '', '25.106824', '102.779708', '1', '2', '0', '昆明市', '1476174128');
INSERT INTO `tc_messages` VALUES ('142', '0', '20000002', '今天隆重开业，祝开业大吉[emoji_370][emoji_370][emoji_370][emoji_13][emoji_13][emoji_13]', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20161011/c6795fe11a10ffa0.jpg\",\"smallUrl\":\"/Uploads/Picture/20161011/s_c6795fe11a10ffa0.jpg\",\"id\":\"ba801667a6aa2d8b95308403861b18d9\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20161011/0811dd0f00a86d0f.jpg\",\"smallUrl\":\"/Uploads/Picture/20161011/s_0811dd0f00a86d0f.jpg\",\"id\":\"3ece1b94ddd02ace97faacc54ca7da25\"},{\"key\":\"images3\",\"originUrl\":\"/Uploads/Picture/20161011/b566955bbfa7eeaa.jpg\",\"smallUrl\":\"/Uploads/Picture/20161011/s_b566955bbfa7eeaa.jpg\",\"id\":\"ee314894026ce815b86fdda8fc9b5bbf\"},{\"key\":\"images4\",\"originUrl\":\"/Uploads/Picture/20161011/129dc6361c1e3dc4.jpg\",\"smallUrl\":\"/Uploads/Picture/20161011/s_129dc6361c1e3dc4.jpg\",\"id\":\"cbc20e83f9c943f1891d3124a2f0350f\"},{\"key\":\"images5\",\"originUrl\":\"/Uploads/Picture/20161011/44ed20ba39925ce3.jpg\",\"smallUrl\":\"/Uploads/Picture/20161011/s_44ed20ba39925ce3.jpg\",\"id\":\"3e2adef5266b4605b53acc619acb0dc7\"},{\"key\":\"images6\",\"originUrl\":\"/Uploads/Picture/20161011/b64076787cae2b0e.jpg\",\"smallUrl\":\"/Uploads/Picture/20161011/s_b64076787cae2b0e.jpg\",\"id\":\"cf90ef1eae28c3e4c7e6bf97fb1bc5e0\"}]', '', '25.106824', '102.779708', '1', '2', '0', '昆明市', '1476174306');
INSERT INTO `tc_messages` VALUES ('143', '0', '20000001', '恭贺易淘鲜超市正式营业，卖场一角，首日销售额轻松突破10W！', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20161012/55e186a9af29a6d1.png\",\"smallUrl\":\"/Uploads/Picture/20161012/s_55e186a9af29a6d1.png\",\"id\":\"8c2b3fe1260e01f62a324f270b71eff4\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20161012/5bfe35afb681f36b.png\",\"smallUrl\":\"/Uploads/Picture/20161012/s_5bfe35afb681f36b.png\",\"id\":\"6e85b990056ec4e57215e3e69259d178\"}]', '', '30.739216', '103.978589', '1', '2', '0', '成都市', '1476261558');
INSERT INTO `tc_messages` VALUES ('144', '0', '20000002', '朋友开的私人农庄[emoji_13][emoji_13][emoji_13]周末休闲好去处[emoji_16][emoji_16][emoji_16]', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20161016/518f7648b5211ed8.png\",\"smallUrl\":\"/Uploads/Picture/20161016/s_518f7648b5211ed8.png\",\"id\":\"149701ad2b8e1a802f6bbeabef8e58a3\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20161016/96fc61067047ba20.png\",\"smallUrl\":\"/Uploads/Picture/20161016/s_96fc61067047ba20.png\",\"id\":\"a75107a54fa2f0b8f06477cf7effaafa\"},{\"key\":\"images3\",\"originUrl\":\"/Uploads/Picture/20161016/53a5d817e43908fa.png\",\"smallUrl\":\"/Uploads/Picture/20161016/s_53a5d817e43908fa.png\",\"id\":\"6bbacbeb8a7d43d9db0399a10d77adce\"},{\"key\":\"images4\",\"originUrl\":\"/Uploads/Picture/20161016/71391aa354d3a5bd.png\",\"smallUrl\":\"/Uploads/Picture/20161016/s_71391aa354d3a5bd.png\",\"id\":\"41a016483fbf4bb95f424f31505bd37c\"},{\"key\":\"images5\",\"originUrl\":\"/Uploads/Picture/20161016/3964aae1f0da1ce7.png\",\"smallUrl\":\"/Uploads/Picture/20161016/s_3964aae1f0da1ce7.png\",\"id\":\"33797fe7a73204e300f07846d3fb0833\"}]', '', '25.146462', '102.838051', '1', '2', '0', '昆明市', '1476589863');
INSERT INTO `tc_messages` VALUES ('145', '134', '20000170', '江山代有才人出。', '', '', '22.058932', '113.409936', '1', '1', '1', '珠海市', '1476754512');
INSERT INTO `tc_messages` VALUES ('146', '0', '20000025', '雷锋的故事（新版）\n\n雷锋叔叔，我知道你做好事从来不留名；\n\n也知道你那200多张做好人好事的照片都是摄影师碰巧路过时拍下的；\n\n你的锦旗都是群众自发人肉找到地址给送到你的部队的；\n\n你当兵一个月工资6块，一年捐200是你省出来的；\n\n你用当年售价一毛二折合现在三十一节的电池白天打着手电看毛泽东语录是为了为国家省电；\n\n这些我们都不说啥了，我们都懂都理解，可是！！！\n\n我一直有个疑问？\n\n这汽车轱辘挡泥板上的这个位置没有螺丝啊，我想知道您在拧什么？？？\n[emoji_357][emoji_357][emoji_357]', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20161021/e809e52e155d3db3.jpg\",\"smallUrl\":\"/Uploads/Picture/20161021/s_e809e52e155d3db3.jpg\",\"id\":\"4b0d5de9d5f8e9c05b9d46f85c223411\"}]', '', '0.000000', '0.000000', '1', '2', '0', '', '1477040302');
INSERT INTO `tc_messages` VALUES ('147', '0', '20000001', '西竹加油！！', '[{\"key\":\"images\",\"originUrl\":\"/Uploads/Picture/20161027/23330ca488202043.png\",\"smallUrl\":\"/Uploads/Picture/20161027/s_23330ca488202043.png\",\"id\":\"2156d6b97f947421e2dbf424193251b6\"}]', '', '30.738910', '103.979002', '1', '1', '0', '成都市', '1477534281');
INSERT INTO `tc_messages` VALUES ('148', '0', '20000025', '这一大早的就出来爬山了', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20161029/8d8db7ec5fa0b6e9.png\",\"smallUrl\":\"/Uploads/Picture/20161029/s_8d8db7ec5fa0b6e9.png\",\"id\":\"43bd64412ea72024e1037a9d6a81c2c2\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20161029/8a8f8807318bbe28.png\",\"smallUrl\":\"/Uploads/Picture/20161029/s_8a8f8807318bbe28.png\",\"id\":\"53d464decc5986f109f163085fd9c0ac\"},{\"key\":\"images3\",\"originUrl\":\"/Uploads/Picture/20161029/a71f7efec9a15606.png\",\"smallUrl\":\"/Uploads/Picture/20161029/s_a71f7efec9a15606.png\",\"id\":\"c47ce7819c22c66c5e721a6ce9879dfd\"},{\"key\":\"images4\",\"originUrl\":\"/Uploads/Picture/20161029/b1e952a22ede7f14.png\",\"smallUrl\":\"/Uploads/Picture/20161029/s_b1e952a22ede7f14.png\",\"id\":\"b3ebbc3c83210d5b5e61bcf37db2132b\"},{\"key\":\"images5\",\"originUrl\":\"/Uploads/Picture/20161029/934551068e03500d.png\",\"smallUrl\":\"/Uploads/Picture/20161029/s_934551068e03500d.png\",\"id\":\"b9a2edc7d414ffa140c426a5bf23c892\"},{\"key\":\"images6\",\"originUrl\":\"/Uploads/Picture/20161029/c9880cb6e7ccbe7c.png\",\"smallUrl\":\"/Uploads/Picture/20161029/s_c9880cb6e7ccbe7c.png\",\"id\":\"e1c008452fbc2dc016626a9e0ff86cfb\"}]', '', '25.215515', '102.572603', '1', '1', '0', '昆明市', '1477711487');
INSERT INTO `tc_messages` VALUES ('149', '0', '20000025', '爬完山又来泡个露天温泉，这节奏巴时', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20161029/7c8244a68084a0cd.png\",\"smallUrl\":\"/Uploads/Picture/20161029/s_7c8244a68084a0cd.png\",\"id\":\"cad499513e02fa1eeca20ee476f90882\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20161029/ff43cdc5ef4a9612.png\",\"smallUrl\":\"/Uploads/Picture/20161029/s_ff43cdc5ef4a9612.png\",\"id\":\"4feaaca53247179a5e90273af15a7e21\"},{\"key\":\"images3\",\"originUrl\":\"/Uploads/Picture/20161029/007f72a86efbb297.png\",\"smallUrl\":\"/Uploads/Picture/20161029/s_007f72a86efbb297.png\",\"id\":\"a755104db7f883d11c61dc56c260d689\"},{\"key\":\"images4\",\"originUrl\":\"/Uploads/Picture/20161029/34a070705b635336.png\",\"smallUrl\":\"/Uploads/Picture/20161029/s_34a070705b635336.png\",\"id\":\"39eed7c56446d67ada4e60bc728e948c\"},{\"key\":\"images5\",\"originUrl\":\"/Uploads/Picture/20161029/339501d10df0dd87.png\",\"smallUrl\":\"/Uploads/Picture/20161029/s_339501d10df0dd87.png\",\"id\":\"8b5a119489624b8cbbea24121f4c28ba\"}]', '', '25.215515', '102.572603', '1', '1', '0', '昆明市', '1477714449');
INSERT INTO `tc_messages` VALUES ('150', '0', '20000002', '特朗普成功法则\n\n1. 永不放弃！骄傲自满容易让你一事无成\n\n2. 富有激情！热爱自己的事业，它就不会枯燥乏味\n\n3. 集中精力！排除和抗干扰是一个很值得具备的技巧\n\n4. 保持活力！倾听、领悟、前进。不要耽搁\n\n5. 把自己看成一个常胜将军！把注意力集中在正确的方向上\n\n6. 坚忍不拔！百折不挠会催生奇迹\n\n7. 享受好运！“天道酬勤”是完全正确的\n\n8. 相信自己！如果连你都不相信自己，那么没有人会相信你\n\n9. 扪心自问：我的盲区在哪里？艰难的逆境也能变成伟大的胜利\n\n10. 把注意力集中在解决之道上，而不要抱怨出现的问题！', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20161109/a72881eb3f14c468.jpg\",\"smallUrl\":\"/Uploads/Picture/20161109/s_a72881eb3f14c468.jpg\",\"id\":\"c65790e864dfbf5eaff7821b2e3ee49e\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20161109/7ab47cfb6e6c8e65.jpg\",\"smallUrl\":\"/Uploads/Picture/20161109/s_7ab47cfb6e6c8e65.jpg\",\"id\":\"5fddad9a8580c881e25fba99fd353942\"}]', '', '25.106816', '102.779584', '1', '1', '0', '昆明市', '1478702180');
INSERT INTO `tc_messages` VALUES ('151', '0', '20000002', '今年生意不好做，我现在也尝试做滴滴司机了；今早从家里出门和老婆顺路接了一个坐滴滴顺风车的漂亮女孩，一路无语；老婆到古宅菜市场先下车买菜去了，车上那个漂亮女孩随口问：“刚刚那个女的怎么没给钱呢？” 我说：“哦，她昨晚睡我家，这个星期的车费就免了”。 \n漂亮女孩沉静片刻后小声说：\n我今晚也有空……[emoji_359][emoji_359][emoji_359]\n咋整，这活接不接[emoji_97][emoji_97][emoji_97]', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20161117/66e26229b3ca5b38.jpg\",\"smallUrl\":\"/Uploads/Picture/20161117/s_66e26229b3ca5b38.jpg\",\"id\":\"8c394a11e1d5837a10d0edb54d509220\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20161117/0ae7ebcd6469472f.jpg\",\"smallUrl\":\"/Uploads/Picture/20161117/s_0ae7ebcd6469472f.jpg\",\"id\":\"b54897fcf5a13a754f0ef3188724c8f3\"},{\"key\":\"images3\",\"originUrl\":\"/Uploads/Picture/20161117/0f12b30741a03b96.jpg\",\"smallUrl\":\"/Uploads/Picture/20161117/s_0f12b30741a03b96.jpg\",\"id\":\"8f4a30c66f4b14af65ecfa7ea4cc9303\"}]', '', '25.106094', '102.779826', '1', '2', '0', '昆明市', '1479396114');
INSERT INTO `tc_messages` VALUES ('153', '0', '20000025', '《云南怎么被贵州超越》、《昆明一座死去的城市》，现实云南：烟草全国第一是中烟；航空盈利给亏损东航；三条大江专归北京人建电站；千亿兰坪铅锌矿给刘汉；铁路给成都；水务送高卢；煤气拱手中石油；电网送南方；公交给香港；云铜给中铝；昆钢赠武汉；云内动力予长安；云南机床归沈阳；昆明机床送西安；云南白药让江苏...\n\n招商引资成了被杀鸡取卵、竭泽而渔；分税制靠出卖资源产生的收益只能上交中央，地方只能靠土地财政，及对本地工商业刮地三尺；城中村改造、呈贡新城和大建地铁，昆明基本入不敷出...\n\n权力恣意吸血，财富不断外流，外来官员任性折腾，扰乱社会经济发展的内在逻辑进程。\n\n对此我就一句话：沟逼死远点！[emoji_372][emoji_372][emoji_372]', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20161118/5355ceed360b75cf.jpg\",\"smallUrl\":\"/Uploads/Picture/20161118/s_5355ceed360b75cf.jpg\",\"id\":\"ed29045db92a93fb37b94df2dccccb50\"}]', '', '0.000000', '0.000000', '1', '0', '0', '', '1479480486');
INSERT INTO `tc_messages` VALUES ('155', '0', '20000002', '某副市长竞争市长，晚上连做三梦：第一梦见自己穿雨衣打伞，第二梦见墙上一颗草，第三梦见与小姨子背对背裸睡。次日让老婆解梦，老婆说：一、穿雨衣打伞你多此一举。二、墙头草没基础群众不支持。第三个梦那是你痴心妄想！看来你提拔够呛。副市长听后当即病倒入院。岳母闻讯来看望，知情后一拍大腿说：好梦啊！穿雨衣打伞那是双保险；墙头草说明你高人一等；梦见和小姨子背对着睡，我就知道你们迟早会翻身的……副市长大笑三声当场病愈出院。\n中国梦，我的梦，有梦要往好处想！祝2017年好梦连连，美梦成真[emoji_86][emoji_86][emoji_86]', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20170105/88d606496f484158.jpg\",\"smallUrl\":\"/Uploads/Picture/20170105/s_88d606496f484158.jpg\",\"id\":\"3f5c602b667bc178647257c5b498fb7a\"}]', '', '25.106659', '102.779772', '1', '1', '0', '昆明市', '1483590539');
INSERT INTO `tc_messages` VALUES ('157', '0', '20000256', '因为深爱所以大卖！', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20170122/5a6ea243c3c5a844.jpeg\",\"smallUrl\":\"/Uploads/Picture/20170122/s_5a6ea243c3c5a844.jpeg\",\"id\":\"9b4ea57c709f4c67dbc785328f1a00e2\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20170122/342ae1a6366a4fba.jpeg\",\"smallUrl\":\"/Uploads/Picture/20170122/s_342ae1a6366a4fba.jpeg\",\"id\":\"55a514a22b2b07dc998624fd5955a3cc\"},{\"key\":\"images3\",\"originUrl\":\"/Uploads/Picture/20170122/4ae48fb982744b34.jpeg\",\"smallUrl\":\"/Uploads/Picture/20170122/s_4ae48fb982744b34.jpeg\",\"id\":\"eeedb0eebe76b61ae916b448055f47e6\"},{\"key\":\"images4\",\"originUrl\":\"/Uploads/Picture/20170122/61d468764ee9f95c.jpeg\",\"smallUrl\":\"/Uploads/Picture/20170122/s_61d468764ee9f95c.jpeg\",\"id\":\"935782b7c4017040e2bd2b00886ff3d3\"}]', '', '21.886509', '112.183408', '1', '1', '0', '阳江市', '1485057942');
INSERT INTO `tc_messages` VALUES ('158', '0', '20000002', '祝新春愉快，万事如意！恭喜发财！', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20170126/9683b94308504b60.jpg\",\"smallUrl\":\"/Uploads/Picture/20170126/s_9683b94308504b60.jpg\",\"id\":\"4c426bb47e153260aa3c69e9206844ff\"}]', '', '25.106688', '102.779768', '1', '0', '0', '昆明市', '1485442637');
INSERT INTO `tc_messages` VALUES ('159', '0', '20000002', '迎财神啦[emoji_368][emoji_368][emoji_368][emoji_33][emoji_33][emoji_33][emoji_285][emoji_285][emoji_285][emoji_275][emoji_275][emoji_275][emoji_136][emoji_136][emoji_136][emoji_52][emoji_52][emoji_52]', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20170201/849212529c7ab658.jpg\",\"smallUrl\":\"/Uploads/Picture/20170201/s_849212529c7ab658.jpg\",\"id\":\"5026d8ed752f275b99092a065332f22c\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20170201/89565296c49ee8cc.jpg\",\"smallUrl\":\"/Uploads/Picture/20170201/s_89565296c49ee8cc.jpg\",\"id\":\"69db28e7bac14ab302a16c3319f64436\"},{\"key\":\"images3\",\"originUrl\":\"/Uploads/Picture/20170201/8b9ff698f7ec334d.jpg\",\"smallUrl\":\"/Uploads/Picture/20170201/s_8b9ff698f7ec334d.jpg\",\"id\":\"39bf0e620f26d3a0a9ed1d2d1835637e\"},{\"key\":\"images4\",\"originUrl\":\"/Uploads/Picture/20170201/5ffc09487841f76a.jpg\",\"smallUrl\":\"/Uploads/Picture/20170201/s_5ffc09487841f76a.jpg\",\"id\":\"3495f32c51cfe6619d5d8969d7a42706\"},{\"key\":\"images5\",\"originUrl\":\"/Uploads/Picture/20170201/85e241e46e04a8c5.jpg\",\"smallUrl\":\"/Uploads/Picture/20170201/s_85e241e46e04a8c5.jpg\",\"id\":\"7d20028d8f4709aabc956d31bf005e4e\"},{\"key\":\"images6\",\"originUrl\":\"/Uploads/Picture/20170201/b3f0a7bbf1d1dff3.jpg\",\"smallUrl\":\"/Uploads/Picture/20170201/s_b3f0a7bbf1d1dff3.jpg\",\"id\":\"e27a0ef29264983d665727322067fb2d\"}]', '', '0.000000', '0.000000', '1', '0', '0', '', '1485918987');
INSERT INTO `tc_messages` VALUES ('160', '0', '20000002', '友情提示：\n还有十天就到情人节了！\n1.想换老婆的带去北京野生动物园；\n2.想换老公的带去宁波动物园；\n这两个地方老虎比较专业。\n北方的母女，挑战老虎失败以后，南方的爷们，又站出来挑战老虎，结果又失败了！\n数百年来，成功的只有武松一个！无人能破！\n因为，武松喝了酒，才打败老虎的。\n所以，事实告诉我们，\n酒，还是要喝的！\n喝了酒，\n别说是老虎，\n世界，\n都是属于你的！', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20170206/05101b71d0fa494d.jpg\",\"smallUrl\":\"/Uploads/Picture/20170206/s_05101b71d0fa494d.jpg\",\"id\":\"6f540e238917da7bc4a5a4fa5b13ba41\"}]', '', '25.106719', '102.779730', '1', '0', '0', '昆明市', '1486345019');
INSERT INTO `tc_messages` VALUES ('161', '0', '20000303', '卖黑大酸菜我是五常当地种地的出售自乙家产的五常稻花香大米，直销无中间环节想多挣俩儿钱需要的搜淘宝店铺号95251919进入淘宝店铺黑大乳酸菌酸菜  购买电话15734512049', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20170315/f76bc0c4e9df49e1.jpg\",\"smallUrl\":\"/Uploads/Picture/20170315/s_f76bc0c4e9df49e1.jpg\",\"id\":\"774a2a73fc6b926aebe152ebe5159506\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20170315/4f671770ee9170ac.jpg\",\"smallUrl\":\"/Uploads/Picture/20170315/s_4f671770ee9170ac.jpg\",\"id\":\"c0880c2c1e4e8d7bb7954bbc9c515ec7\"}]', '', '45.089529', '127.329238', '1', '0', '0', '哈尔滨市', '1489558319');
INSERT INTO `tc_messages` VALUES ('164', '0', '20000315', '发布', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20170323/7bfa3373a0de77b2.jpg\",\"smallUrl\":\"/Uploads/Picture/20170323/s_7bfa3373a0de77b2.jpg\",\"id\":\"25fe9b9a38a6f5d7afd05cface264451\"}]', '', '30.738713', '103.978936', '1', '0', '0', '成都市', '1490257182');
INSERT INTO `tc_messages` VALUES ('165', '164', '20000315', '发', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20170324/68eb7f33c11a4676.jpg\",\"smallUrl\":\"/Uploads/Picture/20170324/s_68eb7f33c11a4676.jpg\",\"id\":\"054df252aa7cf8e9752437696876224e\"}]', '', '30.738788', '103.978747', '1', '0', '1', '成都市', '1490322289');
INSERT INTO `tc_messages` VALUES ('166', '0', '20000315', '\\u79d1\\u6280', '[{\"key\":\"images\",\"originUrl\":\"/Uploads/Picture/20170324/9c4c3630553482c1.png\",\"smallUrl\":\"/Uploads/Picture/20170324/s_9c4c3630553482c1.png\",\"id\":\"aa709bda9d38cacf87265a333453a2a1\"}]', '', '30.738474', '103.978619', '1', '0', '0', '成都市', '1490332326');
INSERT INTO `tc_messages` VALUES ('167', '0', '20000002', '一小伙牵了一纯种藏獒出来遛弯，看路边一老头和一只毛都快要掉光的狗。藏獒一顿嚎叫，那狗却理都没理。\n　　小伙不乐意了：老头，你那狗那么大，咱俩的狗斗一下？你输了给我五百，我输了给你两千。\n　　老头说：要不赌大点？我输了给你五万，你输了给我三万。\n　　俩狗交锋没两分钟，藏獒败下来，再也不敢嚎叫。\n　　小伙拿了三万，郁闷至极：大爷，你那是什么狗？怎么能这么猛？\n　　老头边点钱边说：没掉毛以前是叫狮子！！！…\n　　任何时候都不要炫耀，保持低调再低调！你炫耀什么，说明你缺什么！\n　　你已经是狮子了，何须证明？何须炫耀？\n　　人生在世，不是和别人比较的。活出最伟大的自己才是真。', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20170326/28bea9a298de250e.jpg\",\"smallUrl\":\"/Uploads/Picture/20170326/s_28bea9a298de250e.jpg\",\"id\":\"1d410ffbadf66d9ea2a70175e4150bb5\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20170326/f249d8a142c0ed22.jpg\",\"smallUrl\":\"/Uploads/Picture/20170326/s_f249d8a142c0ed22.jpg\",\"id\":\"8fd9d122bff3b7d18fb62ce88b9b0c37\"},{\"key\":\"images3\",\"originUrl\":\"/Uploads/Picture/20170326/789d475f2d7f4074.jpg\",\"smallUrl\":\"/Uploads/Picture/20170326/s_789d475f2d7f4074.jpg\",\"id\":\"c0c1393221b07d0e07591e423e7d3cdb\"}]', '', '25.106705', '102.779728', '1', '0', '0', '昆明市', '1490528642');
INSERT INTO `tc_messages` VALUES ('168', '0', '20000313', '不能', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20170327/58681ebe710bf75d.jpg\",\"smallUrl\":\"/Uploads/Picture/20170327/s_58681ebe710bf75d.jpg\",\"id\":\"241d4829597d9afb7ebe4953812bd5ac\"}]', '', '30.738837', '103.978901', '1', '0', '0', '成都市', '1490596654');

-- ----------------------------
-- Table structure for `tc_messages_praise`
-- ----------------------------
DROP TABLE IF EXISTS `tc_messages_praise`;
CREATE TABLE `tc_messages_praise` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT '用户id',
  `msgid` int(11) NOT NULL DEFAULT '0' COMMENT '留言id',
  `createtime` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8 COMMENT='留言表';

-- ----------------------------
-- Records of tc_messages_praise
-- ----------------------------
INSERT INTO `tc_messages_praise` VALUES ('1', '20000000', '3', '1458183765');
INSERT INTO `tc_messages_praise` VALUES ('3', '20000017', '41', '1461836972');
INSERT INTO `tc_messages_praise` VALUES ('4', '20000002', '50', '1462010978');
INSERT INTO `tc_messages_praise` VALUES ('5', '20000017', '50', '1462774182');
INSERT INTO `tc_messages_praise` VALUES ('6', '20000000', '57', '1462790661');
INSERT INTO `tc_messages_praise` VALUES ('7', '20000000', '47', '1462790693');
INSERT INTO `tc_messages_praise` VALUES ('8', '20000000', '70', '1463614793');
INSERT INTO `tc_messages_praise` VALUES ('10', '20000017', '76', '1463727860');
INSERT INTO `tc_messages_praise` VALUES ('11', '20000025', '82', '1464496869');
INSERT INTO `tc_messages_praise` VALUES ('12', '20000002', '82', '1464948906');
INSERT INTO `tc_messages_praise` VALUES ('13', '20000026', '85', '1465351940');
INSERT INTO `tc_messages_praise` VALUES ('14', '20000048', '89', '1466076968');
INSERT INTO `tc_messages_praise` VALUES ('15', '20000049', '88', '1466146689');
INSERT INTO `tc_messages_praise` VALUES ('16', '20000025', '91', '1466354677');
INSERT INTO `tc_messages_praise` VALUES ('17', '20000025', '96', '1466751191');
INSERT INTO `tc_messages_praise` VALUES ('18', '20000000', '99', '1466999477');
INSERT INTO `tc_messages_praise` VALUES ('19', '20000070', '100', '1468060358');
INSERT INTO `tc_messages_praise` VALUES ('20', '20000070', '101', '1468060428');
INSERT INTO `tc_messages_praise` VALUES ('21', '20000070', '105', '1468205331');
INSERT INTO `tc_messages_praise` VALUES ('22', '20000070', '104', '1468205342');
INSERT INTO `tc_messages_praise` VALUES ('23', '20000070', '97', '1468205389');
INSERT INTO `tc_messages_praise` VALUES ('24', '20000070', '106', '1468326761');
INSERT INTO `tc_messages_praise` VALUES ('25', '20000073', '111', '1468546994');
INSERT INTO `tc_messages_praise` VALUES ('26', '20000073', '112', '1468546995');
INSERT INTO `tc_messages_praise` VALUES ('27', '20000001', '112', '1468573112');
INSERT INTO `tc_messages_praise` VALUES ('28', '20000077', '119', '1469422799');
INSERT INTO `tc_messages_praise` VALUES ('30', '20000090', '131', '1471491557');
INSERT INTO `tc_messages_praise` VALUES ('31', '20000025', '132', '1471592995');
INSERT INTO `tc_messages_praise` VALUES ('39', '20000108', '133', '1472555003');
INSERT INTO `tc_messages_praise` VALUES ('40', '20000115', '129', '1473825088');
INSERT INTO `tc_messages_praise` VALUES ('42', '20000152', '119', '1475757910');
INSERT INTO `tc_messages_praise` VALUES ('44', '20000152', '140', '1475764528');
INSERT INTO `tc_messages_praise` VALUES ('45', '20000152', '130', '1475764638');
INSERT INTO `tc_messages_praise` VALUES ('46', '20000001', '142', '1476261646');
INSERT INTO `tc_messages_praise` VALUES ('47', '20000170', '137', '1476754446');
INSERT INTO `tc_messages_praise` VALUES ('48', '20000170', '134', '1476754461');
INSERT INTO `tc_messages_praise` VALUES ('49', '20000186', '144', '1477233839');
INSERT INTO `tc_messages_praise` VALUES ('50', '20000096', '149', '1478227881');
INSERT INTO `tc_messages_praise` VALUES ('52', '20000209', '151', '1479467122');
INSERT INTO `tc_messages_praise` VALUES ('53', '20000229', '151', '1481602679');
INSERT INTO `tc_messages_praise` VALUES ('54', '20000229', '150', '1481602720');
INSERT INTO `tc_messages_praise` VALUES ('55', '20000229', '146', '1481602773');
INSERT INTO `tc_messages_praise` VALUES ('56', '20000229', '145', '1481602796');
INSERT INTO `tc_messages_praise` VALUES ('57', '20000229', '144', '1481602809');
INSERT INTO `tc_messages_praise` VALUES ('58', '20000229', '143', '1481602821');
INSERT INTO `tc_messages_praise` VALUES ('59', '20000229', '142', '1481602835');
INSERT INTO `tc_messages_praise` VALUES ('60', '20000229', '141', '1481602843');
INSERT INTO `tc_messages_praise` VALUES ('61', '20000229', '138', '1481602894');
INSERT INTO `tc_messages_praise` VALUES ('62', '20000229', '137', '1481602912');
INSERT INTO `tc_messages_praise` VALUES ('63', '20000000', '155', '1484291866');
INSERT INTO `tc_messages_praise` VALUES ('64', '20000256', '147', '1485055779');
INSERT INTO `tc_messages_praise` VALUES ('65', '20000256', '146', '1485055809');
INSERT INTO `tc_messages_praise` VALUES ('66', '20000256', '141', '1485055904');
INSERT INTO `tc_messages_praise` VALUES ('67', '20000256', '91', '1485056522');
INSERT INTO `tc_messages_praise` VALUES ('68', '20000257', '157', '1485677408');
INSERT INTO `tc_messages_praise` VALUES ('71', '20000259', '148', '1486121273');
INSERT INTO `tc_messages_praise` VALUES ('72', '20000267', '143', '1486972754');

-- ----------------------------
-- Table structure for `tc_messages_reply`
-- ----------------------------
DROP TABLE IF EXISTS `tc_messages_reply`;
CREATE TABLE `tc_messages_reply` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `msgid` int(11) NOT NULL DEFAULT '0',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT '回复人',
  `fuid` int(11) NOT NULL DEFAULT '0' COMMENT '被回复的人',
  `content` text NOT NULL COMMENT '内容',
  `parentid` int(11) NOT NULL DEFAULT '0' COMMENT '回复的评论id',
  `replyflag` int(11) DEFAULT '0' COMMENT '同一个评论(包括第一个评论和后面的回复)为相同的标识',
  `createtime` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8 COMMENT='留言回复表';

-- ----------------------------
-- Records of tc_messages_reply
-- ----------------------------
INSERT INTO `tc_messages_reply` VALUES ('1', '56', '20000000', '20000010', '[emoji_349][emoji_361][emoji_99][emoji_99][emoji_99]', '0', '0', '1462788275');
INSERT INTO `tc_messages_reply` VALUES ('2', '57', '20000000', '20000000', '好看', '0', '0', '1462790674');
INSERT INTO `tc_messages_reply` VALUES ('3', '57', '20000010', '20000000', '哈哈', '0', '0', '1462792214');
INSERT INTO `tc_messages_reply` VALUES ('4', '57', '20000010', '20000000', '呵呵', '0', '0', '1462792226');
INSERT INTO `tc_messages_reply` VALUES ('5', '56', '20000010', '20000000', '呃呃', '0', '0', '1462792461');
INSERT INTO `tc_messages_reply` VALUES ('6', '57', '20000010', '20000000', '嗯哼', '0', '0', '1462792473');
INSERT INTO `tc_messages_reply` VALUES ('7', '41', '20000017', '20000002', '很好吃', '0', '0', '1463727983');
INSERT INTO `tc_messages_reply` VALUES ('8', '0', '20000000', '20000002', '和姐姐', '0', '0', '1464857191');
INSERT INTO `tc_messages_reply` VALUES ('9', '0', '20000017', '20000000', '不得', '0', '0', '1464891488');
INSERT INTO `tc_messages_reply` VALUES ('10', '85', '20000017', '20000017', '加拿大', '0', '0', '1464891584');
INSERT INTO `tc_messages_reply` VALUES ('11', '79', '20000048', '20000017', '？？', '0', '0', '1466077002');
INSERT INTO `tc_messages_reply` VALUES ('12', '96', '20000025', '20000002', '[emoji_86]', '0', '0', '1466751184');
INSERT INTO `tc_messages_reply` VALUES ('13', '99', '20000002', '20000025', '呵呵，你走你的阳光道，我走我的独木桥[emoji_86][emoji_86][emoji_86]', '0', '0', '1466868962');
INSERT INTO `tc_messages_reply` VALUES ('14', '102', '20000025', '20000070', '什么鬼？没看懂[emoji_97]', '0', '0', '1468115919');
INSERT INTO `tc_messages_reply` VALUES ('15', '102', '20000070', '20000025', '手机赚钱的平台', '0', '0', '1468205363');
INSERT INTO `tc_messages_reply` VALUES ('16', '111', '20000025', '20000001', '[emoji_357]', '0', '0', '1468506144');
INSERT INTO `tc_messages_reply` VALUES ('17', '117', '20000002', '20000001', '还会吃瓜子，呵呵[emoji_86][emoji_86][emoji_86]', '0', '0', '1469323943');
INSERT INTO `tc_messages_reply` VALUES ('18', '119', '20000077', '20000077', '要的话，可以私聊噢', '0', '0', '1469407687');
INSERT INTO `tc_messages_reply` VALUES ('19', '119', '20000025', '20000077', '怎么[emoji_97]就好看[emoji_86]', '0', '0', '1469502572');
INSERT INTO `tc_messages_reply` VALUES ('20', '123', '20000000', '20000025', '哇', '0', '0', '1470234160');
INSERT INTO `tc_messages_reply` VALUES ('21', '123', '20000000', '20000025', '这个事？', '0', '0', '1470234170');
INSERT INTO `tc_messages_reply` VALUES ('22', '123', '20000000', '20000025', '说走就走咯', '0', '0', '1470234189');
INSERT INTO `tc_messages_reply` VALUES ('23', '123', '20000000', '20000025', '空气不能更好', '0', '0', '1470234202');
INSERT INTO `tc_messages_reply` VALUES ('24', '123', '20000025', '20000025', '天气也是阴晴不定的[emoji_86]', '0', '0', '1470309432');
INSERT INTO `tc_messages_reply` VALUES ('25', '122', '20000000', '20000025', '嗯', '0', '0', '1470710631');
INSERT INTO `tc_messages_reply` VALUES ('26', '128', '20000090', '20000090', '评论', '0', '0', '1470887654');
INSERT INTO `tc_messages_reply` VALUES ('27', '128', '20000090', '20000090', '哪里的美食地点', '0', '0', '1470887672');
INSERT INTO `tc_messages_reply` VALUES ('28', '127', '20000090', '20000090', '45555', '0', '0', '1471491297');
INSERT INTO `tc_messages_reply` VALUES ('29', '131', '20000090', '20000090', '“@*”', '0', '0', '1471491538');
INSERT INTO `tc_messages_reply` VALUES ('30', '131', '20000090', '20000090', '龙龙', '0', '0', '1471491577');
INSERT INTO `tc_messages_reply` VALUES ('31', '131', '20000090', '20000090', '龙猫', '0', '0', '1471491583');
INSERT INTO `tc_messages_reply` VALUES ('32', '131', '20000090', '20000090', '了咯了', '0', '0', '1471491597');
INSERT INTO `tc_messages_reply` VALUES ('33', '131', '20000090', '20000090', '', '0', '0', '1471491636');
INSERT INTO `tc_messages_reply` VALUES ('34', '131', '20000096', '20000090', '莫', '0', '0', '1471924096');
INSERT INTO `tc_messages_reply` VALUES ('35', '95', '20000096', '20000002', '[emoji_343]', '0', '0', '1472106782');
INSERT INTO `tc_messages_reply` VALUES ('36', '137', '20000025', '20000025', '皮厚，肉质不错', '0', '0', '1473071788');
INSERT INTO `tc_messages_reply` VALUES ('37', '131', '20000090', '20000090', '人台风饭', '0', '0', '1474340484');
INSERT INTO `tc_messages_reply` VALUES ('38', '140', '20000096', '20000025', 'dsa[emoji_85]', '0', '0', '1475655423');
INSERT INTO `tc_messages_reply` VALUES ('39', '139', '20000096', '20000025', '评论', '0', '0', '1475655549');
INSERT INTO `tc_messages_reply` VALUES ('40', '119', '20000152', '20000077', '这些衣服挺好看的，可以加微信吗', '0', '0', '1475757980');
INSERT INTO `tc_messages_reply` VALUES ('41', '119', '20000152', '20000077', '有空可以聊聊', '0', '0', '1475758645');
INSERT INTO `tc_messages_reply` VALUES ('42', '119', '20000152', '20000077', 'oyp2606469059', '0', '0', '1475758708');
INSERT INTO `tc_messages_reply` VALUES ('43', '140', '20000152', '20000025', '有才，', '0', '0', '1475764500');
INSERT INTO `tc_messages_reply` VALUES ('44', '149', '20000002', '20000025', '潇洒呢嘛[emoji_13][emoji_13][emoji_13]', '0', '0', '1477725319');
INSERT INTO `tc_messages_reply` VALUES ('45', '148', '20000096', '20000025', 'tlle', '0', '0', '1478156386');
INSERT INTO `tc_messages_reply` VALUES ('46', '149', '20000096', '20000025', '[emoji_355][emoji_355][emoji_355][emoji_355]', '0', '0', '1478227939');
INSERT INTO `tc_messages_reply` VALUES ('47', '154', '20000210', '20000210', '誰想做我男朋友', '0', '0', '1479520091');
INSERT INTO `tc_messages_reply` VALUES ('48', '139', '20000229', '20000025', '赞', '0', '0', '1481602880');
INSERT INTO `tc_messages_reply` VALUES ('49', '153', '20000096', '20000025', '优惠大酬宾正品春秋', '0', '0', '1483069566');
INSERT INTO `tc_messages_reply` VALUES ('50', '153', '20000096', '20000025', '评论员文章中指出。我', '0', '0', '1483069576');
INSERT INTO `tc_messages_reply` VALUES ('51', '153', '20000096', '20000025', '优惠大酬宾正品春秋男鞋时尚潮流休闲运动鞋透气鞋韩版单鞋女蝴蝶结的点缀？我们的', '0', '0', '1483069589');
INSERT INTO `tc_messages_reply` VALUES ('52', '149', '20000096', '20000002', '[emoji_88][emoji_88][emoji_88][emoji_88][emoji_88][emoji_88][emoji_88]', '0', '0', '1483069627');
INSERT INTO `tc_messages_reply` VALUES ('53', '149', '20000096', '20000002', '优惠大酬宾正品春秋男鞋时尚潮流休闲运动鞋透气鞋板鞋男潮男装裤子，我们的话可以理解为什么有人会说我们的话可以', '0', '0', '1483070153');
INSERT INTO `tc_messages_reply` VALUES ('54', '147', '20000256', '20000001', '加油', '0', '0', '1485055792');
INSERT INTO `tc_messages_reply` VALUES ('55', '160', '20000303', '20000002', '卖黑大酸菜我是五常当地种地的出售自乙家产的五常稻花香大米，直销无中间环节想多挣俩儿钱需要的搜淘宝店铺号95251919进入淘宝店铺黑大乳酸菌酸菜  购买电话15734512049', '0', '0', '1489558047');
INSERT INTO `tc_messages_reply` VALUES ('56', '147', '20000303', '20000001', '卖黑大酸菜我是五常当地种地的出售自乙家产的五常稻花香大米，直销无中间环节想多挣俩儿钱需要的搜淘宝店铺号95251919进入淘宝店铺黑大乳酸菌酸菜  购买电话15734512049', '0', '0', '1489558349');
INSERT INTO `tc_messages_reply` VALUES ('57', '153', '20000313', '20000096', 'v不', '49', '0', '1490256586');
INSERT INTO `tc_messages_reply` VALUES ('58', '163', '20000313', '20000313', '小猫萌', '0', '58', '1490256875');
INSERT INTO `tc_messages_reply` VALUES ('59', '163', '20000313', '20000313', '快来围观', '0', '59', '1490256887');
INSERT INTO `tc_messages_reply` VALUES ('60', '163', '20000313', '20000313', '来来来', '0', '60', '1490256893');
INSERT INTO `tc_messages_reply` VALUES ('61', '163', '20000314', '20000313', 'v比较', '58', '58', '1490256938');
INSERT INTO `tc_messages_reply` VALUES ('62', '163', '20000314', '20000313', '哈哈哈', '59', '59', '1490256949');
INSERT INTO `tc_messages_reply` VALUES ('63', '163', '20000314', '20000313', '好纠结', '59', '59', '1490256960');
INSERT INTO `tc_messages_reply` VALUES ('64', '95', '20000314', '20000096', '宝宝', '35', '0', '1490256976');
INSERT INTO `tc_messages_reply` VALUES ('65', '160', '20000314', '20000303', '宝宝', '55', '0', '1490256989');
INSERT INTO `tc_messages_reply` VALUES ('66', '149', '20000314', '20000096', '哈哈', '46', '0', '1490257005');
INSERT INTO `tc_messages_reply` VALUES ('67', '163', '20000314', '20000313', '花花', '59', '59', '1490257020');
INSERT INTO `tc_messages_reply` VALUES ('68', '95', '20000314', '20000002', '赶集', '35', '0', '1490257042');
INSERT INTO `tc_messages_reply` VALUES ('69', '95', '20000314', '20000096', '哈哈', '35', '0', '1490257046');
INSERT INTO `tc_messages_reply` VALUES ('70', '95', '20000314', '20000096', '浴', '35', '0', '1490257054');
INSERT INTO `tc_messages_reply` VALUES ('71', '163', '20000315', '20000314', '哈哈', '63', '59', '1490257086');
INSERT INTO `tc_messages_reply` VALUES ('72', '163', '20000315', '20000314', '发个', '63', '59', '1490257092');
INSERT INTO `tc_messages_reply` VALUES ('73', '163', '20000315', '20000313', '广告', '59', '59', '1490257095');
INSERT INTO `tc_messages_reply` VALUES ('74', '163', '20000315', '20000313', '同意', '59', '59', '1490257101');
INSERT INTO `tc_messages_reply` VALUES ('75', '163', '20000315', '20000313', '哈哈', '60', '60', '1490257114');
INSERT INTO `tc_messages_reply` VALUES ('76', '163', '20000315', '20000314', 'YY', '67', '59', '1490257119');
INSERT INTO `tc_messages_reply` VALUES ('77', '162', '20000315', '20000313', '不能', '0', '77', '1490257143');
INSERT INTO `tc_messages_reply` VALUES ('78', '153', '20000315', '20000096', '不能', '49', '0', '1490257155');
INSERT INTO `tc_messages_reply` VALUES ('79', '164', '20000315', '20000315', '你呢', '0', '79', '1490257188');
INSERT INTO `tc_messages_reply` VALUES ('80', '164', '20000315', '20000315', '教教我', '0', '80', '1490257202');
INSERT INTO `tc_messages_reply` VALUES ('81', '164', '20000315', '20000315', '你们', '0', '81', '1490257206');
INSERT INTO `tc_messages_reply` VALUES ('82', '164', '20000314', '20000315', '宝宝', '80', '80', '1490257229');
INSERT INTO `tc_messages_reply` VALUES ('83', '164', '20000314', '20000315', '几觉', '80', '80', '1490257238');
INSERT INTO `tc_messages_reply` VALUES ('84', '163', '20000315', '20000313', '\\u5475\\u5475', '0', '84', '1490260871');
INSERT INTO `tc_messages_reply` VALUES ('85', '161', '20000315', '20000303', '你那钱', '0', '85', '1490322349');
INSERT INTO `tc_messages_reply` VALUES ('86', '160', '20000313', '20000002', '几觉', '0', '86', '1490322717');
INSERT INTO `tc_messages_reply` VALUES ('87', '160', '20000313', '20000303', '不能', '55', '0', '1490322730');
INSERT INTO `tc_messages_reply` VALUES ('88', '165', '20000313', '20000315', '急急急', '0', '88', '1490322741');
INSERT INTO `tc_messages_reply` VALUES ('89', '165', '20000313', '20000315', '急急急卡卡卡', '0', '89', '1490322749');
INSERT INTO `tc_messages_reply` VALUES ('90', '165', '20000313', '20000315', '卡卡', '0', '90', '1490322765');
INSERT INTO `tc_messages_reply` VALUES ('91', '165', '20000314', '20000313', '不能', '88', '88', '1490322821');
INSERT INTO `tc_messages_reply` VALUES ('92', '165', '20000314', '20000313', '不能', '88', '88', '1490322826');
INSERT INTO `tc_messages_reply` VALUES ('93', '165', '20000314', '20000313', '不能好久', '88', '88', '1490322826');
INSERT INTO `tc_messages_reply` VALUES ('94', '165', '20000314', '20000313', '不能', '88', '88', '1490322831');
INSERT INTO `tc_messages_reply` VALUES ('95', '165', '20000314', '20000313', '不能好久', '88', '88', '1490322832');
INSERT INTO `tc_messages_reply` VALUES ('96', '165', '20000314', '20000313', '不能', '88', '88', '1490322841');
INSERT INTO `tc_messages_reply` VALUES ('97', '165', '20000314', '20000313', '不能好久', '88', '88', '1490322845');
INSERT INTO `tc_messages_reply` VALUES ('98', '165', '20000314', '20000315', '宝宝', '0', '98', '1490322860');
INSERT INTO `tc_messages_reply` VALUES ('99', '165', '20000314', '20000313', 'v不', '90', '90', '1490322870');
INSERT INTO `tc_messages_reply` VALUES ('100', '165', '20000314', '20000313', 'v不', '90', '90', '1490322872');
INSERT INTO `tc_messages_reply` VALUES ('101', '165', '20000314', '20000313', 'v不', '90', '90', '1490322872');
INSERT INTO `tc_messages_reply` VALUES ('102', '163', '20000315', '20000313', '\\u79d1\\u6280', '0', '102', '1490322986');
INSERT INTO `tc_messages_reply` VALUES ('103', '165', '20000315', '20000315', '赶集', '0', '103', '1490323063');
INSERT INTO `tc_messages_reply` VALUES ('104', '165', '20000313', '20000315', '赶集', '103', '103', '1490323090');

-- ----------------------------
-- Table structure for `tc_message_file`
-- ----------------------------
DROP TABLE IF EXISTS `tc_message_file`;
CREATE TABLE `tc_message_file` (
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

-- ----------------------------
-- Records of tc_message_file
-- ----------------------------

-- ----------------------------
-- Table structure for `tc_message_tip`
-- ----------------------------
DROP TABLE IF EXISTS `tc_message_tip`;
CREATE TABLE `tc_message_tip` (
  `uid` int(11) NOT NULL,
  `time1` int(11) NOT NULL DEFAULT '0' COMMENT '大家帮',
  `time2` int(11) NOT NULL DEFAULT '0' COMMENT 'xxx',
  `time3` int(11) NOT NULL DEFAULT '0' COMMENT '动态',
  `time4` int(11) NOT NULL DEFAULT '0' COMMENT '关注',
  UNIQUE KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='记录提醒';

-- ----------------------------
-- Records of tc_message_tip
-- ----------------------------
INSERT INTO `tc_message_tip` VALUES ('20000000', '1490565915', '1490565915', '1490565921', '1489670948');
INSERT INTO `tc_message_tip` VALUES ('20000001', '1490351996', '1490351996', '1490352004', '1490352004');
INSERT INTO `tc_message_tip` VALUES ('20000002', '1490600969', '1490600969', '1490600968', '1490347799');
INSERT INTO `tc_message_tip` VALUES ('20000003', '1458404418', '1458404418', '1458404418', '1458404419');
INSERT INTO `tc_message_tip` VALUES ('20000004', '1458353696', '1458353697', '1458353697', '1458353697');
INSERT INTO `tc_message_tip` VALUES ('20000005', '1458550096', '1458550096', '1458550097', '1458550097');
INSERT INTO `tc_message_tip` VALUES ('20000006', '1458550916', '1458550916', '1458552198', '1458550916');
INSERT INTO `tc_message_tip` VALUES ('20000007', '1458630784', '1458630784', '1458630784', '1458630784');
INSERT INTO `tc_message_tip` VALUES ('20000008', '1464417011', '1464417011', '1464417010', '1464417010');
INSERT INTO `tc_message_tip` VALUES ('20000009', '1458704009', '1458704009', '1458704009', '1458704010');
INSERT INTO `tc_message_tip` VALUES ('20000010', '1469262436', '1469262436', '1464862924', '1464862924');
INSERT INTO `tc_message_tip` VALUES ('20000017', '1484291937', '1484291937', '1484291936', '1484291937');
INSERT INTO `tc_message_tip` VALUES ('20000018', '1459413881', '1459413880', '1459413896', '1459413881');
INSERT INTO `tc_message_tip` VALUES ('20000019', '1468314382', '1468314382', '1468314382', '1468314382');
INSERT INTO `tc_message_tip` VALUES ('20000020', '1459504555', '1459504555', '1459504555', '1459504555');
INSERT INTO `tc_message_tip` VALUES ('20000021', '1459741693', '1459741693', '1459741693', '1459741693');
INSERT INTO `tc_message_tip` VALUES ('20000022', '1460848569', '1460848569', '1460848592', '1460848569');
INSERT INTO `tc_message_tip` VALUES ('20000023', '1461578361', '1461578361', '1461578361', '1461578362');
INSERT INTO `tc_message_tip` VALUES ('20000024', '1463894225', '1463894225', '1463737238', '1463737238');
INSERT INTO `tc_message_tip` VALUES ('20000025', '1490596623', '1490596623', '1490596621', '1480604396');
INSERT INTO `tc_message_tip` VALUES ('20000026', '1490608477', '1490608477', '1490608477', '1485052345');
INSERT INTO `tc_message_tip` VALUES ('20000027', '1462544755', '1462544720', '1462544717', '1462544717');
INSERT INTO `tc_message_tip` VALUES ('20000028', '1463623720', '1463623720', '1463623720', '1463623729');
INSERT INTO `tc_message_tip` VALUES ('20000029', '1464333977', '1464333977', '1464333976', '1464333976');
INSERT INTO `tc_message_tip` VALUES ('20000030', '1464941191', '1464941191', '1464941191', '1464941191');
INSERT INTO `tc_message_tip` VALUES ('20000031', '1464949936', '1464949936', '1464949936', '1464949936');
INSERT INTO `tc_message_tip` VALUES ('20000032', '1465044402', '1465044402', '1465044402', '1465044402');
INSERT INTO `tc_message_tip` VALUES ('20000033', '1465339531', '1465339530', '1465339530', '1465339530');
INSERT INTO `tc_message_tip` VALUES ('20000034', '1465393091', '1465393090', '1465393090', '1465393090');
INSERT INTO `tc_message_tip` VALUES ('20000035', '1465479777', '1465479777', '1465479747', '1465479674');
INSERT INTO `tc_message_tip` VALUES ('20000036', '1465711127', '1465711127', '1465711126', '1465711127');
INSERT INTO `tc_message_tip` VALUES ('20000038', '1465605732', '1465605738', '1465605734', '1465605735');
INSERT INTO `tc_message_tip` VALUES ('20000039', '1465696256', '1465696256', '1465696255', '1465696255');
INSERT INTO `tc_message_tip` VALUES ('20000040', '1465733650', '1465733650', '1465733649', '1465733649');
INSERT INTO `tc_message_tip` VALUES ('20000041', '1465771394', '1465771417', '1465771393', '1465771499');
INSERT INTO `tc_message_tip` VALUES ('20000042', '1465778282', '1465778282', '1465778270', '1465778337');
INSERT INTO `tc_message_tip` VALUES ('20000043', '1465878932', '1465878931', '1465878930', '1465878930');
INSERT INTO `tc_message_tip` VALUES ('20000044', '1465890793', '1465890798', '1465890792', '1465890792');
INSERT INTO `tc_message_tip` VALUES ('20000045', '1465957786', '1465957786', '1465957785', '1465957785');
INSERT INTO `tc_message_tip` VALUES ('20000046', '1466035204', '1466035318', '1466035318', '1466035318');
INSERT INTO `tc_message_tip` VALUES ('20000048', '1466127702', '1466076953', '1466076952', '1466076952');
INSERT INTO `tc_message_tip` VALUES ('20000049', '1466146694', '1466146698', '1466146676', '1466146676');
INSERT INTO `tc_message_tip` VALUES ('20000050', '1466257488', '1466257488', '1466257444', '1466257444');
INSERT INTO `tc_message_tip` VALUES ('20000051', '1466296601', '1466296601', '1466296636', '1466296636');
INSERT INTO `tc_message_tip` VALUES ('20000052', '1466350054', '1466350054', '1466350054', '1466350054');
INSERT INTO `tc_message_tip` VALUES ('20000053', '1466326276', '1466326276', '1466326275', '1466326275');
INSERT INTO `tc_message_tip` VALUES ('20000054', '1466360191', '1466360174', '1466360181', '1466360181');
INSERT INTO `tc_message_tip` VALUES ('20000055', '1471583444', '1471583444', '1471583445', '1471583445');
INSERT INTO `tc_message_tip` VALUES ('20000056', '1466758225', '1466758232', '1466757648', '1466757250');
INSERT INTO `tc_message_tip` VALUES ('20000058', '1466794583', '1466794583', '1466794583', '1466794583');
INSERT INTO `tc_message_tip` VALUES ('20000059', '1467005486', '1467005486', '1467005485', '1467005485');
INSERT INTO `tc_message_tip` VALUES ('20000060', '1467031278', '1467031278', '1467031257', '1467031258');
INSERT INTO `tc_message_tip` VALUES ('20000061', '1467436047', '1467436047', '1467436046', '1467436046');
INSERT INTO `tc_message_tip` VALUES ('20000062', '1467449728', '1467449727', '1467449727', '1467449727');
INSERT INTO `tc_message_tip` VALUES ('20000063', '1467562919', '1467562919', '1467563094', '1467562919');
INSERT INTO `tc_message_tip` VALUES ('20000064', '1467642866', '1467642866', '1467642865', '1467642865');
INSERT INTO `tc_message_tip` VALUES ('20000065', '1467792462', '1467792454', '1467791999', '1467791804');
INSERT INTO `tc_message_tip` VALUES ('20000066', '1467802373', '1467802373', '1467802372', '1467802373');
INSERT INTO `tc_message_tip` VALUES ('20000067', '1467810473', '1467810473', '1467810425', '1467810425');
INSERT INTO `tc_message_tip` VALUES ('20000068', '1467892276', '1467892276', '1467892276', '1467892276');
INSERT INTO `tc_message_tip` VALUES ('20000070', '1468550919', '1468550961', '1468550918', '1468550919');
INSERT INTO `tc_message_tip` VALUES ('20000071', '1468464056', '1468464056', '1468463970', '1468463970');
INSERT INTO `tc_message_tip` VALUES ('20000072', '1468311034', '1468311034', '1468311031', '1468311031');
INSERT INTO `tc_message_tip` VALUES ('20000073', '1468546991', '1468546991', '1468546991', '1468546991');
INSERT INTO `tc_message_tip` VALUES ('20000074', '1468676913', '1468676913', '1468676873', '1468676842');
INSERT INTO `tc_message_tip` VALUES ('20000075', '1469163616', '1469163621', '1469163656', '1469163617');
INSERT INTO `tc_message_tip` VALUES ('20000076', '1469103431', '1469103430', '1469103429', '1469103430');
INSERT INTO `tc_message_tip` VALUES ('20000077', '1469422794', '1469422793', '1469422793', '1469422793');
INSERT INTO `tc_message_tip` VALUES ('20000078', '1469503778', '1469503778', '1469503777', '1469503778');
INSERT INTO `tc_message_tip` VALUES ('20000079', '1469859646', '1469859646', '1469859571', '1469859571');
INSERT INTO `tc_message_tip` VALUES ('20000080', '1469886841', '1469886841', '1469886841', '1469886841');
INSERT INTO `tc_message_tip` VALUES ('20000081', '1469960005', '1469960005', '1469960004', '1469960004');
INSERT INTO `tc_message_tip` VALUES ('20000082', '1471771228', '1471771228', '1471771228', '1471771228');
INSERT INTO `tc_message_tip` VALUES ('20000083', '1470299072', '1470299096', '1470299131', '1470299044');
INSERT INTO `tc_message_tip` VALUES ('20000084', '1470338276', '1470338275', '1470338273', '1470338274');
INSERT INTO `tc_message_tip` VALUES ('20000085', '1470494486', '1470494486', '1470494486', '1470494486');
INSERT INTO `tc_message_tip` VALUES ('20000087', '1470751130', '1470751130', '1470751129', '1470751129');
INSERT INTO `tc_message_tip` VALUES ('20000088', '1471227715', '1471227715', '1471227716', '1471227718');
INSERT INTO `tc_message_tip` VALUES ('20000089', '1489477527', '1489477528', '1489477539', '1489477539');
INSERT INTO `tc_message_tip` VALUES ('20000090', '1476354312', '1476354312', '1476354312', '1476354312');
INSERT INTO `tc_message_tip` VALUES ('20000091', '1471017687', '1471017687', '1471017687', '1471017688');
INSERT INTO `tc_message_tip` VALUES ('20000092', '1472257331', '1472257331', '1472257331', '1472257331');
INSERT INTO `tc_message_tip` VALUES ('20000093', '1471264896', '1471264896', '1471264895', '1471264896');
INSERT INTO `tc_message_tip` VALUES ('20000094', '1471341173', '1471341173', '1471341170', '1471341171');
INSERT INTO `tc_message_tip` VALUES ('20000095', '1471349963', '1471349963', '1471349963', '1471349963');
INSERT INTO `tc_message_tip` VALUES ('20000096', '1485168646', '1485168646', '1485168651', '1485168536');
INSERT INTO `tc_message_tip` VALUES ('20000097', '1471960335', '1471960335', '1471850488', '1471850488');
INSERT INTO `tc_message_tip` VALUES ('20000098', '1471600758', '1471600758', '1471600758', '1471600758');
INSERT INTO `tc_message_tip` VALUES ('20000099', '1471621222', '1471621222', '1471621221', '1471621221');
INSERT INTO `tc_message_tip` VALUES ('20000100', '1471680834', '1471680833', '1471680831', '1471680830');
INSERT INTO `tc_message_tip` VALUES ('20000101', '1471681253', '1471681253', '1471681253', '1471681253');
INSERT INTO `tc_message_tip` VALUES ('20000102', '1472054487', '1472054487', '1472054409', '1472054409');
INSERT INTO `tc_message_tip` VALUES ('20000103', '1472214312', '1472214263', '1472214333', '1472214263');
INSERT INTO `tc_message_tip` VALUES ('20000104', '1472268073', '1472268073', '1472268409', '1472268409');
INSERT INTO `tc_message_tip` VALUES ('20000105', '1472392729', '1472392738', '1472392728', '1472392728');
INSERT INTO `tc_message_tip` VALUES ('20000106', '1472342321', '1472342320', '1472342320', '1472342320');
INSERT INTO `tc_message_tip` VALUES ('20000107', '1472516801', '1472516801', '1472516801', '1472516801');
INSERT INTO `tc_message_tip` VALUES ('20000108', '1472554991', '1472554991', '1472555041', '1472555008');
INSERT INTO `tc_message_tip` VALUES ('20000109', '1472734931', '1472734930', '1472734930', '1472734930');
INSERT INTO `tc_message_tip` VALUES ('20000110', '1472970884', '1472970884', '1472970872', '1472970873');
INSERT INTO `tc_message_tip` VALUES ('20000111', '1473138130', '1473138130', '1473138129', '1473138129');
INSERT INTO `tc_message_tip` VALUES ('20000112', '1473232094', '1473232094', '1473232093', '1473232093');
INSERT INTO `tc_message_tip` VALUES ('20000113', '1473253693', '1473253693', '1473253693', '1473253693');
INSERT INTO `tc_message_tip` VALUES ('20000114', '1473305287', '1473305347', '1473305223', '1473305223');
INSERT INTO `tc_message_tip` VALUES ('20000115', '1484099685', '1484099685', '1479740358', '1479740358');
INSERT INTO `tc_message_tip` VALUES ('20000117', '1474273860', '1474273859', '1474273859', '1474273859');
INSERT INTO `tc_message_tip` VALUES ('20000118', '1474335813', '1474335813', '1474335813', '1474335813');
INSERT INTO `tc_message_tip` VALUES ('20000119', '1474379572', '1474379615', '1474379572', '1474379572');
INSERT INTO `tc_message_tip` VALUES ('20000120', '1474426453', '1474426414', '1474426482', '1474426397');
INSERT INTO `tc_message_tip` VALUES ('20000121', '1474466461', '1474466460', '1474466459', '1474466460');
INSERT INTO `tc_message_tip` VALUES ('20000122', '1474529908', '1474529907', '1474529906', '1474529906');
INSERT INTO `tc_message_tip` VALUES ('20000123', '1474623865', '1474623865', '1474623864', '1474623864');
INSERT INTO `tc_message_tip` VALUES ('20000124', '1474797501', '1474817424', '1474797500', '1474797500');
INSERT INTO `tc_message_tip` VALUES ('20000125', '1474903827', '1474903827', '1474903781', '1474903781');
INSERT INTO `tc_message_tip` VALUES ('20000126', '1474974523', '1474974523', '1474974523', '1474974523');
INSERT INTO `tc_message_tip` VALUES ('20000127', '1475029966', '1475029966', '1475029956', '1475029904');
INSERT INTO `tc_message_tip` VALUES ('20000128', '1475050061', '1475050060', '1475050060', '1475050060');
INSERT INTO `tc_message_tip` VALUES ('20000130', '1475131124', '1475131124', '1475131123', '1475131123');
INSERT INTO `tc_message_tip` VALUES ('20000131', '1475162591', '1475162624', '1475162591', '1475162591');
INSERT INTO `tc_message_tip` VALUES ('20000132', '1475220898', '1475221056', '1475220708', '1475220708');
INSERT INTO `tc_message_tip` VALUES ('20000133', '1475246693', '1475246688', '1475246673', '1475246673');
INSERT INTO `tc_message_tip` VALUES ('20000134', '1475246928', '1475246937', '1475246928', '1475246928');
INSERT INTO `tc_message_tip` VALUES ('20000135', '1475253969', '1475253968', '1475253968', '1475253968');
INSERT INTO `tc_message_tip` VALUES ('20000136', '1475381811', '1475381810', '1475381798', '1475381798');
INSERT INTO `tc_message_tip` VALUES ('20000137', '1475389449', '1475389449', '1475389449', '1475389449');
INSERT INTO `tc_message_tip` VALUES ('20000138', '1475410998', '1475410997', '1475410997', '1475410997');
INSERT INTO `tc_message_tip` VALUES ('20000139', '1475453862', '1475453862', '1475453862', '1475453862');
INSERT INTO `tc_message_tip` VALUES ('20000140', '1475465519', '1475465523', '1475465518', '1475465518');
INSERT INTO `tc_message_tip` VALUES ('20000141', '1475468712', '1475468711', '1475468711', '1475468711');
INSERT INTO `tc_message_tip` VALUES ('20000142', '1475483854', '1475483854', '1475483852', '1475483852');
INSERT INTO `tc_message_tip` VALUES ('20000143', '1475571044', '1475571044', '1475571043', '1475571044');
INSERT INTO `tc_message_tip` VALUES ('20000144', '1475583860', '1475583863', '1475583816', '1475583816');
INSERT INTO `tc_message_tip` VALUES ('20000145', '1475631635', '1475631635', '1475631636', '1475631636');
INSERT INTO `tc_message_tip` VALUES ('20000146', '1475631709', '1475631709', '1475631709', '1475631709');
INSERT INTO `tc_message_tip` VALUES ('20000147', '1475664063', '1475664063', '1475664063', '1475664063');
INSERT INTO `tc_message_tip` VALUES ('20000148', '1475669993', '1475669992', '1475669992', '1475669992');
INSERT INTO `tc_message_tip` VALUES ('20000149', '1475672112', '1475672112', '1475672111', '1475672111');
INSERT INTO `tc_message_tip` VALUES ('20000150', '1475675068', '1475675067', '1475675067', '1475675067');
INSERT INTO `tc_message_tip` VALUES ('20000151', '1475680830', '1475680820', '1475680819', '1475680820');
INSERT INTO `tc_message_tip` VALUES ('20000152', '1475764676', '1475764672', '1475764345', '1475797889');
INSERT INTO `tc_message_tip` VALUES ('20000153', '1475770771', '1475770771', '1475770734', '1475770734');
INSERT INTO `tc_message_tip` VALUES ('20000154', '1475811566', '1475811615', '1475811566', '1475811566');
INSERT INTO `tc_message_tip` VALUES ('20000155', '1475814471', '1475814476', '1475814492', '1475814470');
INSERT INTO `tc_message_tip` VALUES ('20000157', '1475917717', '1475917813', '1475917717', '1475917717');
INSERT INTO `tc_message_tip` VALUES ('20000158', '1476085646', '1476085653', '1476029678', '1476029678');
INSERT INTO `tc_message_tip` VALUES ('20000159', '1476223745', '1476223745', '1476223745', '1476223745');
INSERT INTO `tc_message_tip` VALUES ('20000160', '1490255470', '1490255470', '1490255470', '1476316050');
INSERT INTO `tc_message_tip` VALUES ('20000161', '1476341534', '1476341534', '1476341533', '1476341533');
INSERT INTO `tc_message_tip` VALUES ('20000162', '1476347357', '1476347357', '1476347357', '1476347357');
INSERT INTO `tc_message_tip` VALUES ('20000163', '1476366949', '1476366949', '1476366948', '1476366949');
INSERT INTO `tc_message_tip` VALUES ('20000164', '1476411415', '1476411415', '1476411415', '1476411415');
INSERT INTO `tc_message_tip` VALUES ('20000165', '1476531741', '1476531747', '1476531741', '1476531742');
INSERT INTO `tc_message_tip` VALUES ('20000166', '1476453978', '1476453978', '1476453978', '1476453978');
INSERT INTO `tc_message_tip` VALUES ('20000167', '1476462362', '1476462362', '1476462362', '1476462362');
INSERT INTO `tc_message_tip` VALUES ('20000168', '1476617773', '1476617774', '0', '0');
INSERT INTO `tc_message_tip` VALUES ('20000169', '1476620290', '1476620290', '1476620289', '1476620289');
INSERT INTO `tc_message_tip` VALUES ('20000170', '1476759892', '1476759892', '1476759892', '1476759892');
INSERT INTO `tc_message_tip` VALUES ('20000171', '1476769648', '1476769648', '1476769647', '1476769647');
INSERT INTO `tc_message_tip` VALUES ('20000172', '1476772047', '1476772047', '1476772046', '1476772046');
INSERT INTO `tc_message_tip` VALUES ('20000173', '1476779660', '1476779660', '1476779660', '1476779660');
INSERT INTO `tc_message_tip` VALUES ('20000174', '1476855184', '1476855184', '1476855147', '1476855148');
INSERT INTO `tc_message_tip` VALUES ('20000175', '1476856585', '1476856585', '1476856585', '1476856585');
INSERT INTO `tc_message_tip` VALUES ('20000176', '1476885896', '1476885896', '1476885896', '1476885897');
INSERT INTO `tc_message_tip` VALUES ('20000177', '1476949093', '1476949090', '1476948938', '1476949105');
INSERT INTO `tc_message_tip` VALUES ('20000178', '1476965945', '1476965945', '1476965921', '1476965922');
INSERT INTO `tc_message_tip` VALUES ('20000179', '1476982870', '1476982870', '1476982869', '1476982869');
INSERT INTO `tc_message_tip` VALUES ('20000180', '1477020029', '1477020029', '1477020028', '1477020029');
INSERT INTO `tc_message_tip` VALUES ('20000181', '1477055766', '1477055766', '1477055765', '1477055765');
INSERT INTO `tc_message_tip` VALUES ('20000182', '1477062513', '1477062513', '1477062512', '1477062513');
INSERT INTO `tc_message_tip` VALUES ('20000183', '1477063628', '1477063628', '1477063658', '1477063628');
INSERT INTO `tc_message_tip` VALUES ('20000184', '1477118860', '1477118860', '1477118860', '1477118860');
INSERT INTO `tc_message_tip` VALUES ('20000185', '1477227189', '1477227206', '1477227218', '1477227188');
INSERT INTO `tc_message_tip` VALUES ('20000186', '1490607295', '1490607295', '1490607294', '1477233814');
INSERT INTO `tc_message_tip` VALUES ('20000187', '1477462440', '1477462440', '1477462439', '1477462440');
INSERT INTO `tc_message_tip` VALUES ('20000188', '1477586464', '1477586464', '1477586464', '1477586464');
INSERT INTO `tc_message_tip` VALUES ('20000189', '1477586603', '1477586603', '1477586603', '1477586603');
INSERT INTO `tc_message_tip` VALUES ('20000190', '1477882976', '1477882976', '1477882975', '1477882975');
INSERT INTO `tc_message_tip` VALUES ('20000191', '1477921710', '1477921710', '1477921719', '1477921719');
INSERT INTO `tc_message_tip` VALUES ('20000192', '1478116153', '1478116152', '1478116152', '1478116152');
INSERT INTO `tc_message_tip` VALUES ('20000193', '1477983246', '1477983412', '1477983240', '1477983240');
INSERT INTO `tc_message_tip` VALUES ('20000194', '1478044891', '1478044891', '1478044890', '1478044890');
INSERT INTO `tc_message_tip` VALUES ('20000195', '1478097026', '1478097026', '1478096875', '1478096875');
INSERT INTO `tc_message_tip` VALUES ('20000196', '1478162025', '1478162025', '1478161951', '1478161951');
INSERT INTO `tc_message_tip` VALUES ('20000197', '1478219100', '1478219100', '1478219098', '1478219099');
INSERT INTO `tc_message_tip` VALUES ('20000198', '1478519167', '1478519165', '1478519163', '1478519164');
INSERT INTO `tc_message_tip` VALUES ('20000199', '1478621735', '1478621735', '1478621658', '1478621658');
INSERT INTO `tc_message_tip` VALUES ('20000200', '1478691376', '1478691375', '1478691375', '1478691375');
INSERT INTO `tc_message_tip` VALUES ('20000201', '1478697539', '1478697539', '1478697518', '1478697519');
INSERT INTO `tc_message_tip` VALUES ('20000202', '1478830260', '1478830260', '1478830260', '1478830260');
INSERT INTO `tc_message_tip` VALUES ('20000203', '1478781949', '1478781960', '1478781948', '1478781948');
INSERT INTO `tc_message_tip` VALUES ('20000204', '1478855668', '1478855668', '1478855667', '1478855667');
INSERT INTO `tc_message_tip` VALUES ('20000205', '1478953904', '1478953903', '1478953903', '1478953903');
INSERT INTO `tc_message_tip` VALUES ('20000206', '1479425857', '1479426030', '1479426062', '1479426063');
INSERT INTO `tc_message_tip` VALUES ('20000207', '1479226258', '1479226254', '1479226247', '1479226258');
INSERT INTO `tc_message_tip` VALUES ('20000208', '1479272759', '1479272758', '1479272747', '1479272748');
INSERT INTO `tc_message_tip` VALUES ('20000209', '1479466919', '1479467131', '1479467002', '1479467138');
INSERT INTO `tc_message_tip` VALUES ('20000210', '1479520020', '1479519971', '1479520125', '1479520793');
INSERT INTO `tc_message_tip` VALUES ('20000211', '1479552502', '1479552502', '1479552501', '1479552501');
INSERT INTO `tc_message_tip` VALUES ('20000212', '1479621180', '1479622660', '1479621178', '1479621178');
INSERT INTO `tc_message_tip` VALUES ('20000213', '1479642203', '1479642190', '1479642153', '1479642163');
INSERT INTO `tc_message_tip` VALUES ('20000214', '1479971753', '1479973332', '1479971753', '1479971753');
INSERT INTO `tc_message_tip` VALUES ('20000216', '1480341962', '1480341969', '1480341890', '1480341899');
INSERT INTO `tc_message_tip` VALUES ('20000217', '1480760015', '1480760014', '1480760013', '1480760014');
INSERT INTO `tc_message_tip` VALUES ('20000218', '0', '1480773406', '1480773405', '1480773405');
INSERT INTO `tc_message_tip` VALUES ('20000219', '1480833129', '1480833129', '1480833145', '1480833145');
INSERT INTO `tc_message_tip` VALUES ('20000220', '1480837844', '1480837844', '1480837843', '1480837843');
INSERT INTO `tc_message_tip` VALUES ('20000221', '1480988533', '1480988620', '1480988495', '1480988495');
INSERT INTO `tc_message_tip` VALUES ('20000222', '1481003977', '1481003963', '1481003969', '1481003963');
INSERT INTO `tc_message_tip` VALUES ('20000223', '1481301237', '1481301237', '1481301237', '1481301237');
INSERT INTO `tc_message_tip` VALUES ('20000224', '1481266532', '1481266531', '1481266531', '1481266531');
INSERT INTO `tc_message_tip` VALUES ('20000225', '1481281881', '1481281881', '1481281904', '1481281904');
INSERT INTO `tc_message_tip` VALUES ('20000226', '1481287055', '1481287055', '1481287054', '1481287055');
INSERT INTO `tc_message_tip` VALUES ('20000227', '1481420791', '1481420912', '1481420875', '1481420790');
INSERT INTO `tc_message_tip` VALUES ('20000228', '1481509201', '1481509201', '1481509200', '1481509200');
INSERT INTO `tc_message_tip` VALUES ('20000229', '1481602646', '1481602646', '1481602644', '1481602645');
INSERT INTO `tc_message_tip` VALUES ('20000230', '1481623277', '1481623276', '1481623274', '1481623275');
INSERT INTO `tc_message_tip` VALUES ('20000231', '1481626732', '1481626732', '1481626731', '1481626731');
INSERT INTO `tc_message_tip` VALUES ('20000232', '1481631760', '1481631760', '1481631760', '1481631760');
INSERT INTO `tc_message_tip` VALUES ('20000234', '1482234096', '1482233995', '1482233956', '1482233957');
INSERT INTO `tc_message_tip` VALUES ('20000235', '1482287619', '1482287578', '1482287623', '1482287577');
INSERT INTO `tc_message_tip` VALUES ('20000236', '1482732043', '1482732047', '1482732004', '1482732004');
INSERT INTO `tc_message_tip` VALUES ('20000237', '1482824149', '1482824153', '1482824148', '1482824149');
INSERT INTO `tc_message_tip` VALUES ('20000238', '1482917464', '1482917485', '1482917463', '1482917464');
INSERT INTO `tc_message_tip` VALUES ('20000239', '1482929805', '1482929805', '1482929805', '1482929805');
INSERT INTO `tc_message_tip` VALUES ('20000240', '1483187507', '1483187507', '1483187507', '1483187507');
INSERT INTO `tc_message_tip` VALUES ('20000241', '1483207542', '1483207542', '1483207542', '1483207542');
INSERT INTO `tc_message_tip` VALUES ('20000242', '1483334202', '1483334202', '1483334204', '1483334201');
INSERT INTO `tc_message_tip` VALUES ('20000243', '1483352401', '1483352401', '1483352400', '1483352400');
INSERT INTO `tc_message_tip` VALUES ('20000244', '1483714489', '1483714489', '1483714488', '1483714488');
INSERT INTO `tc_message_tip` VALUES ('20000245', '1484042104', '1484042103', '1484042102', '1484042102');
INSERT INTO `tc_message_tip` VALUES ('20000246', '1484356429', '1484356428', '1484356428', '1484356428');
INSERT INTO `tc_message_tip` VALUES ('20000247', '0', '1484406316', '1484406315', '1484406315');
INSERT INTO `tc_message_tip` VALUES ('20000248', '1484406912', '1484406912', '1484406911', '1484406911');
INSERT INTO `tc_message_tip` VALUES ('20000249', '1484551734', '1484551734', '1484551731', '1484551731');
INSERT INTO `tc_message_tip` VALUES ('20000250', '1484567537', '1484567582', '1484567558', '1484567536');
INSERT INTO `tc_message_tip` VALUES ('20000251', '1484587768', '1484587768', '1484587767', '1484587767');
INSERT INTO `tc_message_tip` VALUES ('20000252', '1484650892', '1484650892', '1484650891', '1484650891');
INSERT INTO `tc_message_tip` VALUES ('20000253', '1484650687', '1484650687', '1484650687', '1484650687');
INSERT INTO `tc_message_tip` VALUES ('20000255', '1485004920', '1485004920', '1485004903', '1485004903');
INSERT INTO `tc_message_tip` VALUES ('20000256', '1485057927', '1485057943', '1485057879', '1485057879');
INSERT INTO `tc_message_tip` VALUES ('20000257', '1485680013', '1485680012', '1485680012', '1485680012');
INSERT INTO `tc_message_tip` VALUES ('20000258', '1485777714', '1485777713', '1485777712', '1485777713');
INSERT INTO `tc_message_tip` VALUES ('20000259', '1486121210', '1486121210', '1486121209', '1486121209');
INSERT INTO `tc_message_tip` VALUES ('20000260', '1486262101', '1486262101', '1486262100', '1486262100');
INSERT INTO `tc_message_tip` VALUES ('20000261', '1486361870', '1486361869', '1486361869', '1486361869');
INSERT INTO `tc_message_tip` VALUES ('20000262', '1486452274', '1486452274', '1486452288', '1486452273');
INSERT INTO `tc_message_tip` VALUES ('20000263', '1490242576', '1490242576', '1490242570', '1490242570');
INSERT INTO `tc_message_tip` VALUES ('20000264', '1486614046', '1486614047', '1486614028', '1486614028');
INSERT INTO `tc_message_tip` VALUES ('20000265', '1486646067', '1486646067', '1486646066', '1486646066');
INSERT INTO `tc_message_tip` VALUES ('20000266', '1486699628', '1486699628', '1486699628', '1486699628');
INSERT INTO `tc_message_tip` VALUES ('20000267', '1490607153', '1490607153', '1490607156', '1487037925');
INSERT INTO `tc_message_tip` VALUES ('20000268', '1487013817', '1487013817', '1487013817', '1487013817');
INSERT INTO `tc_message_tip` VALUES ('20000269', '1487055072', '1487055072', '1487055073', '1487055073');
INSERT INTO `tc_message_tip` VALUES ('20000271', '1487128086', '1487128087', '1487127954', '1487127954');
INSERT INTO `tc_message_tip` VALUES ('20000272', '1487143540', '1487143573', '1487143524', '1487143524');
INSERT INTO `tc_message_tip` VALUES ('20000273', '1487185389', '1487185389', '1487185778', '1487185785');
INSERT INTO `tc_message_tip` VALUES ('20000274', '1488446719', '1488446718', '1488446718', '1488446718');
INSERT INTO `tc_message_tip` VALUES ('20000275', '1487400314', '1487400312', '1487400305', '1487400305');
INSERT INTO `tc_message_tip` VALUES ('20000276', '1487556466', '1487556466', '1487556465', '1487556465');
INSERT INTO `tc_message_tip` VALUES ('20000277', '1487864489', '1487864489', '1487864488', '1487864488');
INSERT INTO `tc_message_tip` VALUES ('20000278', '1487868091', '1487868095', '1487868079', '1487868079');
INSERT INTO `tc_message_tip` VALUES ('20000279', '1487918863', '1487918863', '1487918863', '1487918863');
INSERT INTO `tc_message_tip` VALUES ('20000280', '1487921382', '1487921382', '1487921381', '1487921381');
INSERT INTO `tc_message_tip` VALUES ('20000281', '1487942374', '1487942373', '1487942373', '1487942373');
INSERT INTO `tc_message_tip` VALUES ('20000282', '1488005966', '1488005966', '1488005941', '1488005941');
INSERT INTO `tc_message_tip` VALUES ('20000283', '1488111660', '1488111660', '1488111659', '1488111659');
INSERT INTO `tc_message_tip` VALUES ('20000284', '1488116463', '1488116463', '1488116463', '1488116463');
INSERT INTO `tc_message_tip` VALUES ('20000285', '1488121407', '1488121407', '1488121406', '1488121406');
INSERT INTO `tc_message_tip` VALUES ('20000286', '1488185717', '1488185769', '1488185716', '1488185717');
INSERT INTO `tc_message_tip` VALUES ('20000287', '1488198364', '1488198364', '1488198364', '1488198364');
INSERT INTO `tc_message_tip` VALUES ('20000288', '1488277911', '1488277882', '1488277858', '1488277549');
INSERT INTO `tc_message_tip` VALUES ('20000289', '1488342957', '1488342957', '1488342886', '1488342886');
INSERT INTO `tc_message_tip` VALUES ('20000290', '1488383134', '1488383134', '1488383133', '1488383133');
INSERT INTO `tc_message_tip` VALUES ('20000291', '1488412227', '1488412227', '1488411663', '1488412284');
INSERT INTO `tc_message_tip` VALUES ('20000292', '1488619543', '1488619543', '1488619542', '1488619542');
INSERT INTO `tc_message_tip` VALUES ('20000293', '1488656592', '1488656898', '1488656898', '1488656898');
INSERT INTO `tc_message_tip` VALUES ('20000294', '1488761149', '1488761149', '1488761149', '1488761149');
INSERT INTO `tc_message_tip` VALUES ('20000295', '1488771918', '1488771918', '1488771917', '1488771917');
INSERT INTO `tc_message_tip` VALUES ('20000296', '1488891235', '1488891281', '1488891283', '1488891234');
INSERT INTO `tc_message_tip` VALUES ('20000297', '1488976963', '1488977016', '1488976962', '1488976962');
INSERT INTO `tc_message_tip` VALUES ('20000298', '1489188906', '1489188906', '1489188906', '1489188906');
INSERT INTO `tc_message_tip` VALUES ('20000299', '1489557529', '1489557529', '1489557529', '1489557529');
INSERT INTO `tc_message_tip` VALUES ('20000300', '1489631317', '1489631317', '1489631318', '1489631318');
INSERT INTO `tc_message_tip` VALUES ('20000301', '1489563538', '1489563538', '1489563517', '1489563517');
INSERT INTO `tc_message_tip` VALUES ('20000302', '1489539471', '1489539471', '1489539470', '1489539470');
INSERT INTO `tc_message_tip` VALUES ('20000303', '1489558264', '1489558327', '1489558013', '1489558013');
INSERT INTO `tc_message_tip` VALUES ('20000304', '1489665942', '1489665942', '1489665927', '1489665927');
INSERT INTO `tc_message_tip` VALUES ('20000305', '1489676420', '1489676474', '1489676419', '1489676419');
INSERT INTO `tc_message_tip` VALUES ('20000306', '1489820241', '1489820241', '1489820241', '1489820241');
INSERT INTO `tc_message_tip` VALUES ('20000307', '1489812867', '1489812957', '1489812866', '1489812866');
INSERT INTO `tc_message_tip` VALUES ('20000308', '1489819512', '1489819511', '1489819511', '1489819511');
INSERT INTO `tc_message_tip` VALUES ('20000309', '1489974423', '1489974477', '1489974435', '1489974435');
INSERT INTO `tc_message_tip` VALUES ('20000311', '1490169414', '1490169413', '1490169413', '1490169413');
INSERT INTO `tc_message_tip` VALUES ('20000312', '1490608057', '1490608057', '1490608057', '1490338387');
INSERT INTO `tc_message_tip` VALUES ('20000313', '1490608727', '1490608727', '1490608731', '1490596547');
INSERT INTO `tc_message_tip` VALUES ('20000314', '1490351972', '1490351973', '1490351978', '1490351977');
INSERT INTO `tc_message_tip` VALUES ('20000315', '1490608586', '1490608586', '1490608586', '1490608395');
INSERT INTO `tc_message_tip` VALUES ('20000316', '1490607742', '1490607742', '1490607742', '1490594473');
INSERT INTO `tc_message_tip` VALUES ('20000317', '1490608715', '1490608714', '1490608714', '0');

-- ----------------------------
-- Table structure for `tc_module`
-- ----------------------------
DROP TABLE IF EXISTS `tc_module`;
CREATE TABLE `tc_module` (
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
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='模块表';

-- ----------------------------
-- Records of tc_module
-- ----------------------------

-- ----------------------------
-- Table structure for `tc_notice`
-- ----------------------------
DROP TABLE IF EXISTS `tc_notice`;
CREATE TABLE `tc_notice` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type` smallint(6) NOT NULL,
  `uid` varchar(255) NOT NULL DEFAULT '' COMMENT '通知人',
  `toUid` varchar(255) NOT NULL DEFAULT '',
  `content` text NOT NULL,
  `createtime` varchar(10) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='通知记录表';

-- ----------------------------
-- Records of tc_notice
-- ----------------------------

-- ----------------------------
-- Table structure for `tc_order`
-- ----------------------------
DROP TABLE IF EXISTS `tc_order`;
CREATE TABLE `tc_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `sid` int(11) NOT NULL,
  `order_no` varchar(50) NOT NULL,
  `status` tinyint(4) DEFAULT '0' COMMENT '0.未支付，1.已支付待发货，2.已发货待收货，3.已收货待评价，4.待卖家评价，5.完成，6.退货，7.换货，8.投诉，9.已取消',
  `transport_method` tinyint(4) NOT NULL COMMENT '1.到付，2.快递',
  `transport_price` varchar(20) DEFAULT '0',
  `total_price` varchar(20) DEFAULT '0',
  `is_hdfk` tinyint(1) DEFAULT '0' COMMENT '是否货到付款，0否，1是',
  `coupon_id` int(11) DEFAULT '0',
  `is_coupon` tinyint(4) DEFAULT '0' COMMENT '0.未使用优惠券，1.使用优惠券',
  `coupon_price` varchar(20) DEFAULT '0',
  `is_balances` tinyint(4) DEFAULT '0' COMMENT '0.未使用余额，1.使用余额',
  `balances_price` varchar(20) DEFAULT '0',
  `actual_price` varchar(20) NOT NULL,
  `return_price` varchar(20) DEFAULT '0' COMMENT '退款金额',
  `shipping_address` varchar(100) NOT NULL,
  `shipping_name` varchar(10) NOT NULL,
  `shipping_phone` varchar(20) NOT NULL,
  `remark` varchar(100) DEFAULT '',
  `create_time` varchar(20) NOT NULL,
  `is_over` tinyint(1) DEFAULT '0' COMMENT '是否已结，0未结，1已结',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tc_order
-- ----------------------------
INSERT INTO `tc_order` VALUES ('1', '20000315', '3', '2017032497999898', '5', '1', '0', '58', '0', null, '0', '0', '1', '58', '0', '0', '不能', '太阳', '13700000000', '', '1490324746', '0');
INSERT INTO `tc_order` VALUES ('2', '20000315', '3', '2017032448525254', '5', '1', '0', '30', '0', null, '0', '0', '1', '30', '0', '0', '不能', '太阳', '13700000000', '', '1490324848', '0');
INSERT INTO `tc_order` VALUES ('3', '20000315', '3', '2017032456519850', '5', '1', '0', '28', '0', null, '0', '0', '1', '28', '0', '0', '不能', '太阳', '13700000000', '', '1490324856', '0');
INSERT INTO `tc_order` VALUES ('4', '20000315', '3', '2017032457100985', '5', '1', '0', '58', '0', null, '0', '0', '1', '58', '0', '0', '不能', '哈哈', '13422222222', '', '1490325193', '0');
INSERT INTO `tc_order` VALUES ('5', '20000313', '1', '2017032499555354', '5', '1', '0', '33', '0', null, '0', '0', '1', '33', '0', '0', '不能', '哈哈', '13422222222', '', '1490325532', '0');
INSERT INTO `tc_order` VALUES ('6', '20000313', '1', '2017032454495253', '9', '1', '0', '18', '0', '7', '1', '20', '1', '0', '0', '0', '不能', '哈哈', '13422222222', '', '1490325590', '0');
INSERT INTO `tc_order` VALUES ('7', '20000313', '1', '2017032448995752', '9', '1', '0', '30', '0', '8', '1', '30', '1', '0', '0', '0', '不能', '哈哈', '13422222222', '', '1490325616', '0');
INSERT INTO `tc_order` VALUES ('8', '20000313', '1', '2017032498571025', '9', '1', '0', '18', '0', null, '0', '0', '1', '18', '0', '0', '不能', '哈哈', '13422222222', '', '1490325627', '0');
INSERT INTO `tc_order` VALUES ('9', '20000314', '1', '2017032499509857', '9', '1', '0', '56', '0', null, '0', '0', '1', '56', '0', '0', '不能', '哈哈', '13422222222', '', '1490325676', '0');
INSERT INTO `tc_order` VALUES ('10', '20000314', '3', '2017032450495450', '9', '2', '2', '6.5', '0', null, '0', '0', '1', '6.5', '0', '0', '不能', '哈哈', '13422222222', '', '1490325714', '0');
INSERT INTO `tc_order` VALUES ('11', '20000314', '1', '2017032410057495', '9', '1', '0', '28', '0', null, '0', '0', '1', '28', '0', '0', '不能', '哈哈', '13422222222', '', '1490325741', '0');
INSERT INTO `tc_order` VALUES ('12', '20000314', '1', '2017032450489750', '5', '1', '0', '33', '0', null, '0', '0', '1', '33', '0', '0', '不能', '哈哈', '13422222222', '', '1490325858', '0');
INSERT INTO `tc_order` VALUES ('13', '20000314', '1', '2017032452495755', '5', '1', '0', '30', '0', null, '0', '0', '1', '30', '0', '0', '不能', '哈哈', '13422222222', '', '1490325876', '0');
INSERT INTO `tc_order` VALUES ('14', '20000316', '3', '2017032410097999', '5', '1', '0', '28', '0', null, '0', '0', '1', '28', '0', '0', '不能', '哈哈', '13422222222', '', '1490327053', '0');
INSERT INTO `tc_order` VALUES ('15', '20000316', '3', '2017032410197515', '5', '1', '0', '28', '0', null, '0', '0', '1', '28', '0', '0', '不能', '哈哈', '13422222222', '', '1490327150', '0');
INSERT INTO `tc_order` VALUES ('16', '20000315', '3', '2017032452100535', '5', '1', '0', '29', '0', null, '0', '0', '1', '29', '0', '0', '不能', '哈哈', '13422222222', '', '1490332692', '0');
INSERT INTO `tc_order` VALUES ('17', '20000315', '3', '2017032454511015', '5', '1', '0', '50', '0', '14', '1', '15', '1', '35', '0', '0', '不能', 'v不', '13700000000', '', '1490333622', '1');
INSERT INTO `tc_order` VALUES ('18', '20000316', '3', '2017032499999949', '6', '1', '0', '100', '0', null, '0', '0', '1', '100', '0', '0', '不能', 'v不', '13700000000', '退款', '1490334348', '1');
INSERT INTO `tc_order` VALUES ('19', '20000313', '1', '2017032456974897', '5', '1', '0', '180', '0', null, '0', '0', '1', '180', '0', '0', '不能', 'v不', '13700000000', '', '1490334776', '0');
INSERT INTO `tc_order` VALUES ('20', '20000313', '1', '2017032454575210', '5', '1', '0', '144', '0', null, '0', '0', '1', '144', '0', '0', '不能', 'v不', '13700000000', '', '1490334806', '1');
INSERT INTO `tc_order` VALUES ('21', '20000313', '1', '2017032450481015', '0', '1', '0', '18', '0', null, '0', '0', '0', '-21', '39', '0', '不能', 'v不', '13700000000', '', '1490335250', '0');
INSERT INTO `tc_order` VALUES ('22', '20000316', '3', '2017032497561001', '5', '1', '0', '11', '0', null, '0', '0', '1', '11', '0', '0', '不能', 'v不', '13700000000', '', '1490335450', '0');
INSERT INTO `tc_order` VALUES ('23', '20000316', '3', '2017032497504899', '6', '1', '0', '100', '0', null, '0', '0', '0', '0', '100', '0', '不能', 'v不', '13700000000', '图', '1490335482', '1');
INSERT INTO `tc_order` VALUES ('24', '20000316', '3', '2017032455999899', '0', '1', '0', '50', '0', null, '0', '0', '0', '0', '50', '0', '不能', 'v不', '13700000000', '', '1490336183', '0');
INSERT INTO `tc_order` VALUES ('25', '20000316', '3', '2017032456565655', '9', '1', '0', '50', '0', null, '0', '0', '0', '0', '50', '0', '不能', 'v不', '13700000000', '', '1490336248', '0');
INSERT INTO `tc_order` VALUES ('26', '20000316', '3', '2017032498519797', '6', '1', '0', '50', '0', null, '0', '0', '0', '0', '50', '0', '不能', 'v不', '13700000000', '号', '1490336411', '1');
INSERT INTO `tc_order` VALUES ('27', '20000312', '3', '2017032448501025', '5', '1', '0', '100', '0', null, '0', '0', '0', '0', '100', '0', '比较', '好久', '13400000000', '', '1490339248', '1');
INSERT INTO `tc_order` VALUES ('28', '20000315', '3', '2017032452549998', '9', '2', '2', '56.5', '0', '1', '1', '30', '1', '26.5', '0', '0', '咯', '科技', '13700000000', '', '1490340996', '0');
INSERT INTO `tc_order` VALUES ('29', '20000315', '3', '2017032451571005', '6', '1', '0', '50', '0', '4', '1', '30', '1', '20', '0', '0', '咯', '科技', '13700000000', '果果', '1490341507', '1');
INSERT INTO `tc_order` VALUES ('30', '20000026', '1', '2017032654509956', '5', '1', '0', '18', '0', null, '0', '0', '1', '18', '0', '0', '123', '123', '18254127300', '', '1490494678', '0');
INSERT INTO `tc_order` VALUES ('31', '20000026', '1', '2017032648495550', '5', '1', '0', '18', '0', null, '0', '0', '1', '18', '0', '0', '123', '123', '18254127300', '', '1490496032', '1');
INSERT INTO `tc_order` VALUES ('32', '20000026', '3', '2017032652559897', '9', '2', '2', '6.5', '0', null, '0', '0', '0', '0', '6.5', '0', '123', '123', '18254127300', '', '1490497428', '0');
INSERT INTO `tc_order` VALUES ('33', '20000026', '3', '2017032698555597', '9', '2', '2', '6.5', '0', null, '0', '0', '0', '0', '6.5', '0', '123', '123', '18254127300', '', '1490497611', '0');
INSERT INTO `tc_order` VALUES ('34', '20000026', '3', '2017032651535350', '6', '2', '2', '6.5', '0', null, '0', '0', '0', '0', '6.5', '0', '123', '123', '18254127300', '1', '1490497763', '1');
INSERT INTO `tc_order` VALUES ('35', '20000026', '3', '2017032699515254', '6', '2', '2', '6.5', '0', null, '0', '0', '0', '0', '6.5', '0', '123', '123', '18254127300', '1', '1490498060', '1');
INSERT INTO `tc_order` VALUES ('36', '20000026', '3', '2017032652501001', '6', '2', '2', '6.5', '0', null, '0', '0', '0', '0', '6.5', '0', '123', '123', '18254127300', '3', '1490499252', '1');
INSERT INTO `tc_order` VALUES ('37', '20000026', '3', '2017032654559752', '6', '2', '2', '6.5', '0', null, '0', '0', '0', '0', '6.5', '0', '123', '123', '18254127300', '2', '1490499270', '0');
INSERT INTO `tc_order` VALUES ('38', '20000026', '3', '2017032699525210', '5', '1', '0', '5', '0', null, '0', '0', '1', '5', '0', '0', '123', '123', '18254127300', '', '1490500108', '1');
INSERT INTO `tc_order` VALUES ('39', '20000026', '3', '2017032610154579', '6', '1', '0', '50', '0', '21', '1', '10', '1', '40', '0', '0', '123', '123', '18254127300', '4', '1490500126', '0');
INSERT INTO `tc_order` VALUES ('40', '20000313', '1', '2017032750101101', '5', '1', '0', '28', '0', null, '0', '0', '1', '28', '0', '0', '同意', '嘻嘻', '13422222222', '', '1490577234', '1');
INSERT INTO `tc_order` VALUES ('41', '20000313', '1', '2017032757539752', '5', '1', '0', '18', '0', null, '0', '0', '1', '18', '0', '0', '同意', '嘻嘻', '13422222222', '', '1490577273', '1');
INSERT INTO `tc_order` VALUES ('42', '20000315', '3', '2017032751505452', '5', '1', '0', '23', '0', null, '0', '0', '1', '23', '0', '0', '果果', '乐', '13700000000', '', '1490578067', '1');
INSERT INTO `tc_order` VALUES ('43', '20000315', '3', '2017032710051559', '5', '1', '0', '20', '0', null, '0', '0', '1', '20', '0', '0', '果果', '乐', '13700000000', '', '1490578381', '1');
INSERT INTO `tc_order` VALUES ('44', '20000315', '3', '2017032753535649', '5', '1', '0', '28', '0', null, '0', '0', '1', '28', '0', '0', '果果', '乐', '13700000000', '', '1490578549', '1');
INSERT INTO `tc_order` VALUES ('45', '20000315', '3', '2017032749495410', '5', '1', '0', '28', '0', null, '0', '0', '1', '28', '0', '0', '果果', '乐', '13700000000', '', '1490578593', '1');
INSERT INTO `tc_order` VALUES ('46', '20000315', '3', '2017032750491029', '9', '1', '0', '100', '0', '25', '1', '10', '1', '90', '0', '0', '果果', '乐', '13700000000', '', '1490579698', '0');
INSERT INTO `tc_order` VALUES ('47', '20000315', '3', '2017032751561021', '9', '1', '0', '50', '0', '30', '1', '10', '1', '40', '0', '0', '果果', '乐', '13700000000', '', '1490579715', '0');
INSERT INTO `tc_order` VALUES ('48', '20000315', '3', '2017032799102505', '5', '2', '2', '6.5', '0', '33', '1', '10', '1', '0', '0', '0', '果果', '乐', '13700000000', '啊', '1490579724', '1');
INSERT INTO `tc_order` VALUES ('49', '20000313', '1', '2017032798525655', '5', '1', '0', '18', '0', '22', '1', '15', '1', '3', '0', '0', '不能', '银行', '1370000000', '', '1490579915', '1');
INSERT INTO `tc_order` VALUES ('50', '20000313', '1', '2017032749529953', '5', '1', '0', '18', '0', '24', '1', '10', '1', '8', '0', '0', '不能', '银行', '1370000000', '', '1490579921', '1');
INSERT INTO `tc_order` VALUES ('51', '20000313', '1', '2017032797971025', '5', '1', '0', '18', '0', '23', '1', '10', '1', '8', '0', '0', '不能', '银行', '1370000000', '', '1490579930', '1');
INSERT INTO `tc_order` VALUES ('52', '20000313', '1', '2017032751485456', '5', '1', '0', '12', '0', '16', '1', '258', '1', '0', '0', '0', '不能', '银行', '1370000000', '', '1490579955', '1');
INSERT INTO `tc_order` VALUES ('53', '20000315', '3', '2017032750100981', '5', '1', '0', '50', '0', '26', '1', '20', '1', '30', '0', '0', '果果', '乐', '13700000000', '', '1490579986', '1');
INSERT INTO `tc_order` VALUES ('54', '20000315', '3', '2017032797549748', '5', '1', '0', '25', '0', null, '0', '0', '1', '25', '0', '0', '果果', '乐', '13700000000', '', '1490581146', '1');
INSERT INTO `tc_order` VALUES ('55', '20000313', '1', '2017032710157575', '5', '1', '0', '35', '0', null, '0', '0', '1', '35', '0', '0', '不能', '银行', '1370000000', '', '1490581246', '1');
INSERT INTO `tc_order` VALUES ('56', '20000315', '3', '2017032754545452', '5', '1', '0', '18', '0', null, '0', '0', '1', '18', '0', '0', '果果', '乐', '13700000000', '', '1490581590', '1');
INSERT INTO `tc_order` VALUES ('57', '20000313', '1', '2017032753524857', '5', '1', '0', '28', '0', null, '0', '0', '1', '28', '0', '0', '果果', '乐', '13700000000', '', '1490581909', '1');
INSERT INTO `tc_order` VALUES ('58', '20000313', '1', '2017032799995399', '6', '2', '2', '52', '0', null, '0', '0', '1', '52', '0', '0', '果果', '乐', '13700000000', '哦', '1490583660', '1');
INSERT INTO `tc_order` VALUES ('59', '20000313', '1', '2017032749484899', '6', '2', '2', '132', '0', null, '0', '0', '1', '132', '0', '0', '果果', '乐', '13700000000', 'o', '1490584112', '0');
INSERT INTO `tc_order` VALUES ('60', '20000313', '1', '2017032799495548', '6', '2', '2', '102', '0', null, '0', '0', '1', '102', '0', '0', '果果', '乐', '13700000000', '哈哈', '1490584444', '0');
INSERT INTO `tc_order` VALUES ('61', '20000313', '1', '2017032799519999', '6', '2', '2', '52', '0', null, '0', '0', '1', '52', '0', '0', '果果', '乐', '13700000000', '哦', '1490584652', '1');
INSERT INTO `tc_order` VALUES ('62', '20000313', '1', '2017032753101575', '6', '2', '2', '72', '0', null, '0', '0', '1', '72', '0', '0', '不能', '银行', '1370000000', '发', '1490584949', '0');
INSERT INTO `tc_order` VALUES ('63', '20000313', '1', '2017032797549710', '6', '2', '2', '52', '0', null, '0', '0', '1', '52', '0', '0', '不能', '银行', '1370000000', '点', '1490585066', '0');
INSERT INTO `tc_order` VALUES ('64', '20000315', '3', '2017032748985152', '5', '1', '0', '18', '0', null, '0', '0', '1', '18', '0', '0', '果果', '乐', '13700000000', '', '1490599696', '1');
INSERT INTO `tc_order` VALUES ('65', '20000315', '3', '2017032710154505', '5', '1', '0', '28', '0', null, '0', '0', '1', '28', '0', '0', '果果', '乐', '13700000000', '', '1490599726', '1');
INSERT INTO `tc_order` VALUES ('66', '20000315', '3', '2017032750569751', '9', '1', '0', '100', '0', '38', '1', '10', '1', '90', '0', '0', '果果', '乐', '13700000000', '', '1490604642', '0');
INSERT INTO `tc_order` VALUES ('67', '20000315', '3', '2017032797995753', '9', '2', '2', '7', '0', '42', '1', '10', '1', '0', '0', '0', '果果', '乐', '13700000000', '', '1490604650', '0');
INSERT INTO `tc_order` VALUES ('68', '20000315', '3', '2017032748545254', '9', '2', '2', '7', '0', '27', '1', '10', '1', '0', '0', '0', '果果', '乐', '13700000000', '', '1490604656', '0');
INSERT INTO `tc_order` VALUES ('69', '20000315', '3', '2017032752991005', '9', '2', '2', '7', '0', '45', '1', '12', '1', '0', '0', '0', '果果', '乐', '13700000000', '', '1490604660', '0');
INSERT INTO `tc_order` VALUES ('70', '20000315', '3', '2017032757100102', '9', '2', '2', '7', '0', '28', '1', '20', '1', '0', '0', '0', '果果', '乐', '13700000000', '', '1490604665', '0');
INSERT INTO `tc_order` VALUES ('71', '20000315', '3', '2017032710255549', '9', '2', '2', '7', '0', '31', '1', '20', '1', '0', '0', '0', '果果', '乐', '13700000000', '', '1490604671', '0');
INSERT INTO `tc_order` VALUES ('72', '20000315', '3', '2017032756525555', '9', '2', '2', '7', '0', '39', '1', '20', '1', '0', '0', '0', '果果', '乐', '13700000000', '', '1490604696', '0');
INSERT INTO `tc_order` VALUES ('73', '20000315', '3', '2017032798519756', '5', '1', '0', '13', '0', null, '0', '0', '1', '13', '0', '0', '果果', '乐', '13700000000', '', '1490604747', '1');
INSERT INTO `tc_order` VALUES ('74', '20000313', '1', '2017032751525497', '5', '1', '0', '28', '0', null, '0', '0', '1', '28', '0', '0', '宝宝', '喊你', '13700000000', '', '1490604835', '1');
INSERT INTO `tc_order` VALUES ('75', '20000313', '1', '2017032754521015', '9', '1', '0', '18', '0', '40', '1', '15', '1', '3', '0', '0', '宝宝', '喊你', '13700000000', '', '1490604870', '0');
INSERT INTO `tc_order` VALUES ('76', '20000316', '4', '2017032757519854', '5', '1', '0', '30', '0', null, '0', '0', '1', '30', '0', '0', '宝宝', '喊你', '13700000000', '', '1490605401', '1');
INSERT INTO `tc_order` VALUES ('77', '20000316', '4', '2017032710010149', '9', '1', '0', '20', '0', '50', '1', '20', '1', '0', '0', '0', '宝宝', '喊你', '13700000000', '', '1490605565', '0');
INSERT INTO `tc_order` VALUES ('78', '20000316', '4', '2017032751101101', '9', '1', '0', '20', '0', '51', '1', '30', '1', '0', '0', '0', '宝宝', '喊你', '13700000000', '', '1490605571', '0');
INSERT INTO `tc_order` VALUES ('79', '20000316', '4', '2017032757485253', '5', '1', '0', '30', '0', null, '0', '0', '1', '30', '0', '0', '果果', '乐', '13700000000', '', '1490605673', '1');
INSERT INTO `tc_order` VALUES ('80', '20000316', '4', '2017032748555557', '9', '1', '0', '20', '0', '53', '1', '20', '1', '0', '0', '0', '果果', '乐', '13700000000', '', '1490605696', '0');
INSERT INTO `tc_order` VALUES ('81', '20000316', '4', '2017032710297971', '9', '1', '0', '20', '0', '52', '1', '30', '1', '0', '0', '0', '果果', '乐', '13700000000', '', '1490605711', '0');
INSERT INTO `tc_order` VALUES ('82', '20000026', '3', '2017032750485610', '5', '1', '0', '36', '0', null, '0', '0', '1', '36', '0', '0', '12', '123', '18254127300', '', '1490605954', '1');
INSERT INTO `tc_order` VALUES ('83', '20000316', '4', '2017032756509855', '5', '1', '0', '30', '0', null, '0', '0', '1', '30', '0', '0', '果果', '乐', '13700000000', '', '1490606040', '1');
INSERT INTO `tc_order` VALUES ('84', '20000026', '3', '2017032751509854', '5', '1', '0', '23', '0', null, '0', '0', '1', '23', '0', '0', '12', '123', '18254127300', '', '1490606131', '1');
INSERT INTO `tc_order` VALUES ('85', '20000026', '3', '2017032757505748', '5', '1', '0', '23', '0', null, '0', '0', '1', '23', '0', '0', '12', '123', '18254127300', '', '1490606601', '1');
INSERT INTO `tc_order` VALUES ('86', '20000316', '4', '2017032748525199', '4', '1', '0', '20', '0', '56', '1', '20', '1', '0', '0', '0', '宝宝', '喊你', '13700000000', '', '1490606752', '0');
INSERT INTO `tc_order` VALUES ('87', '20000316', '4', '2017032798989799', '5', '1', '0', '30', '0', null, '0', '0', '1', '30', '0', '0', '宝宝', '喊你', '13700000000', '', '1490606795', '1');
INSERT INTO `tc_order` VALUES ('88', '20000316', '4', '2017032756989710', '5', '1', '0', '20', '0', '62', '1', '20', '1', '0', '0', '0', '宝宝', '喊你', '13700000000', '', '1490607064', '1');
INSERT INTO `tc_order` VALUES ('89', '20000316', '4', '2017032798509850', '6', '1', '0', '100', '0', '57', '1', '30', '1', '70', '0', '70', '宝宝', '喊你', '13700000000', '团', '1490607291', '1');
INSERT INTO `tc_order` VALUES ('90', '20000316', '4', '2017032751995010', '9', '1', '0', '20', '0', null, '0', '0', '1', '20', '0', '0', '宝宝', '喊你', '13700000000', '', '1490607891', '0');
INSERT INTO `tc_order` VALUES ('91', '20000026', '4', '2017032753995199', '6', '1', '0', '100', '0', null, '0', '0', '1', '100', '0', '100', '12', '123', '18254127300', '1', '1490608437', '0');
INSERT INTO `tc_order` VALUES ('92', '20000315', '3', '2017032752101101', '6', '2', '2', '7', '0', null, '0', '0', '0', '0', '7', '0', '你呢', '呼叫', '13422222222', '有', '1490608484', '1');

-- ----------------------------
-- Table structure for `tc_order_back`
-- ----------------------------
DROP TABLE IF EXISTS `tc_order_back`;
CREATE TABLE `tc_order_back` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `goods_id` int(11) NOT NULL DEFAULT '0',
  `reason` varchar(100) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0.待处理，1.同意，2.拒绝',
  `money` decimal(10,2) NOT NULL,
  `type` tinyint(4) NOT NULL COMMENT '1.退货，2.换货，3.投诉',
  `intro` varchar(100) NOT NULL COMMENT '商家备注',
  `address` varchar(100) DEFAULT NULL,
  `name` varchar(10) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `express` varchar(20) DEFAULT NULL,
  `express_no` varchar(50) DEFAULT NULL,
  `finish_time` varchar(20) DEFAULT NULL,
  `create_time` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tc_order_back
-- ----------------------------
INSERT INTO `tc_order_back` VALUES ('1', '20000316', '18', '12', '退款', '3', '100.00', '1', '', null, null, null, null, null, '1490334867', '1490334665');
INSERT INTO `tc_order_back` VALUES ('2', '20000316', '23', '19', '图', '3', '100.00', '1', '', null, null, null, null, null, '1490335824', '1490335796');
INSERT INTO `tc_order_back` VALUES ('3', '20000316', '26', '12', '号', '3', '50.00', '1', '', null, null, null, null, null, '1490336760', '1490336727');
INSERT INTO `tc_order_back` VALUES ('4', '20000315', '29', '12', '果果', '3', '50.00', '1', '', null, null, null, null, null, '1490341785', '1490341774');
INSERT INTO `tc_order_back` VALUES ('5', '20000026', '34', '11', '1', '2', '6.50', '1', '1', null, null, null, null, null, '1490497990', '1490497907');
INSERT INTO `tc_order_back` VALUES ('6', '20000026', '35', '11', '1', '3', '6.50', '1', '12', null, null, null, null, null, '1490498366', '1490498333');
INSERT INTO `tc_order_back` VALUES ('7', '20000026', '37', '11', '2', '3', '6.50', '1', '2', null, null, null, null, null, '1490499658', '1490499345');
INSERT INTO `tc_order_back` VALUES ('8', '20000026', '36', '11', '3', '3', '6.50', '1', '3', null, null, null, null, null, '1490499644', '1490499506');
INSERT INTO `tc_order_back` VALUES ('9', '20000026', '39', '12', '4', '3', '50.00', '1', '4', null, null, null, null, null, '1490500261', '1490500216');
INSERT INTO `tc_order_back` VALUES ('10', '20000315', '48', '11', '啊', '0', '6.50', '1', '', null, null, null, null, null, null, '1490579830');
INSERT INTO `tc_order_back` VALUES ('11', '20000313', '58', '31', '啊撸', '3', '52.00', '1', '', null, null, null, null, null, '1490584060', '1490584014');
INSERT INTO `tc_order_back` VALUES ('12', '20000313', '58', '32', '哦', '3', '52.00', '1', '', null, null, null, null, null, '1490584060', '1490584014');
INSERT INTO `tc_order_back` VALUES ('13', '20000313', '59', '32', '哦', '3', '132.00', '1', '', null, null, null, null, null, '1490584251', '1490584224');
INSERT INTO `tc_order_back` VALUES ('14', '20000313', '59', '31', 'o', '3', '132.00', '1', '', null, null, null, null, null, '1490584251', '1490584224');
INSERT INTO `tc_order_back` VALUES ('15', '20000313', '60', '32', '无', '3', '102.00', '1', '', null, null, null, null, null, '1490584527', '1490584513');
INSERT INTO `tc_order_back` VALUES ('16', '20000313', '60', '31', '哈哈', '3', '102.00', '1', '', null, null, null, null, null, '1490584527', '1490584513');
INSERT INTO `tc_order_back` VALUES ('17', '20000313', '61', '31', '酒', '3', '52.00', '1', '', null, null, null, null, null, '1490584821', '1490584806');
INSERT INTO `tc_order_back` VALUES ('18', '20000313', '61', '32', '哦', '3', '52.00', '1', '', null, null, null, null, null, '1490584821', '1490584806');
INSERT INTO `tc_order_back` VALUES ('19', '20000313', '62', '32', '搞', '3', '72.00', '1', '', null, null, null, null, null, '1490585010', '1490584979');
INSERT INTO `tc_order_back` VALUES ('20', '20000313', '62', '31', '发', '3', '72.00', '1', '', null, null, null, null, null, '1490585010', '1490584979');
INSERT INTO `tc_order_back` VALUES ('21', '20000313', '63', '32', '人', '3', '52.00', '1', '', null, null, null, null, null, '1490585120', '1490585103');
INSERT INTO `tc_order_back` VALUES ('22', '20000313', '63', '31', '点', '3', '52.00', '1', '', null, null, null, null, null, '1490585120', '1490585103');
INSERT INTO `tc_order_back` VALUES ('23', '20000316', '89', '35', '团', '3', '100.00', '1', '', null, null, null, null, null, null, '1490607524');
INSERT INTO `tc_order_back` VALUES ('24', '20000026', '91', '35', '1', '0', '100.00', '1', '', null, null, null, null, null, null, '1490608489');
INSERT INTO `tc_order_back` VALUES ('25', '20000315', '92', '11', '有', '0', '7.00', '1', '', null, null, null, null, null, null, '1490608763');

-- ----------------------------
-- Table structure for `tc_order_goods`
-- ----------------------------
DROP TABLE IF EXISTS `tc_order_goods`;
CREATE TABLE `tc_order_goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `goods_id` int(11) NOT NULL,
  `smallUrl` varchar(100) NOT NULL,
  `originUrl` varchar(100) NOT NULL,
  `goods_name` varchar(100) NOT NULL,
  `price` varchar(20) NOT NULL,
  `buy_count` int(11) NOT NULL,
  `is_finish` tinyint(4)  DEFAULT '0' COMMENT '0.未完成，1.已完成',
  `is_back` tinyint(4) DEFAULT '0' COMMENT '0.未退货，1.退货',
  `create_time` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=127 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tc_order_goods
-- ----------------------------
INSERT INTO `tc_order_goods` VALUES ('1', '1', '14', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_f5180e42580b7cbd.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170324/f5180e42580b7cbd.jpg', '优惠券09', '28', '1','0', '0', '1490324746');
INSERT INTO `tc_order_goods` VALUES ('2', '1', '13', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_26d7fd7186ea4de0.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170324/26d7fd7186ea4de0.jpg', '优惠券00', '30', '1','0', '0', '1490324746');
INSERT INTO `tc_order_goods` VALUES ('3', '2', '13', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_26d7fd7186ea4de0.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170324/26d7fd7186ea4de0.jpg', '优惠券00', '30', '1', '0','0', '1490324848');
INSERT INTO `tc_order_goods` VALUES ('4', '3', '14', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_f5180e42580b7cbd.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170324/f5180e42580b7cbd.jpg', '优惠券09', '28', '1', '0','0', '1490324856');
INSERT INTO `tc_order_goods` VALUES ('5', '4', '13', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_26d7fd7186ea4de0.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170324/26d7fd7186ea4de0.jpg', '优惠券00', '30', '1', '0','0', '1490325193');
INSERT INTO `tc_order_goods` VALUES ('6', '4', '14', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_f5180e42580b7cbd.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170324/f5180e42580b7cbd.jpg', '优惠券09', '28', '1', '0','0', '1490325193');
INSERT INTO `tc_order_goods` VALUES ('7', '5', '15', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_30bf86d677d49aee.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170324/30bf86d677d49aee.jpg', '优惠券1', '15', '1', '0','0', '1490325532');
INSERT INTO `tc_order_goods` VALUES ('8', '5', '16', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_1b07ca82ea2d67f7.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170324/1b07ca82ea2d67f7.jpg', '优惠券2', '18', '1', '0','0', '1490325532');
INSERT INTO `tc_order_goods` VALUES ('9', '6', '3', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_a8d774f498c039d8.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170324/a8d774f498c039d8.jpg', '花生', '18', '1', '0', '0','1490325590');
INSERT INTO `tc_order_goods` VALUES ('10', '7', '1', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_e31059b697bbf19a.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170323/e31059b697bbf19a.jpg', '小吃', '10', '3', '0','0', '1490325616');
INSERT INTO `tc_order_goods` VALUES ('11', '8', '3', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_a8d774f498c039d8.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170324/a8d774f498c039d8.jpg', '花生', '18', '1', '0', '0','1490325627');
INSERT INTO `tc_order_goods` VALUES ('12', '9', '1', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_e31059b697bbf19a.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170323/e31059b697bbf19a.jpg', '小吃', '10', '2', '0','0', '1490325676');
INSERT INTO `tc_order_goods` VALUES ('13', '9', '3', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_a8d774f498c039d8.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170324/a8d774f498c039d8.jpg', '花生', '18', '2', '0','0', '1490325676');
INSERT INTO `tc_order_goods` VALUES ('14', '10', '11', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_17a6e99b046e4420.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170324/17a6e99b046e4420.jpg', '辣条', '4.5', '1', '0','0', '1490325714');
INSERT INTO `tc_order_goods` VALUES ('15', '11', '1', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_e31059b697bbf19a.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170323/e31059b697bbf19a.jpg', '小吃', '10', '1', '0', '0','1490325741');
INSERT INTO `tc_order_goods` VALUES ('16', '11', '3', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_a8d774f498c039d8.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170324/a8d774f498c039d8.jpg', '花生', '18', '1', '0', '1490325741');
INSERT INTO `tc_order_goods` VALUES ('17', '12', '15', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_30bf86d677d49aee.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170324/30bf86d677d49aee.jpg', '优惠券1', '15', '1', '0','0', '1490325858');
INSERT INTO `tc_order_goods` VALUES ('18', '12', '16', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_1b07ca82ea2d67f7.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170324/1b07ca82ea2d67f7.jpg', '优惠券2', '18', '1', '0','0', '1490325858');
INSERT INTO `tc_order_goods` VALUES ('19', '13', '15', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_30bf86d677d49aee.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170324/30bf86d677d49aee.jpg', '优惠券1', '15', '2', '0', '0','1490325876');
INSERT INTO `tc_order_goods` VALUES ('20', '14', '14', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_f5180e42580b7cbd.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170324/f5180e42580b7cbd.jpg', '优惠券09', '28', '1', '0', '0','1490327053');
INSERT INTO `tc_order_goods` VALUES ('21', '15', '14', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_f5180e42580b7cbd.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170324/f5180e42580b7cbd.jpg', '优惠券09', '28', '1', '0', '0','1490327150');
INSERT INTO `tc_order_goods` VALUES ('22', '16', '17', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_bcee15b95b25ba15.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170324/bcee15b95b25ba15.jpg', '优惠券3', '11', '1', '0','0', '1490332692');
INSERT INTO `tc_order_goods` VALUES ('23', '16', '18', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_1267e659f4a9faee.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170324/1267e659f4a9faee.jpg', '优惠券优惠券', '18', '1', '0','0', '1490332692');
INSERT INTO `tc_order_goods` VALUES ('24', '17', '12', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_ecbff1e8a47a21fa.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170324/ecbff1e8a47a21fa.jpg', '酒', '50', '1', '0','0', '1490333622');
INSERT INTO `tc_order_goods` VALUES ('25', '18', '12', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_ecbff1e8a47a21fa.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170324/ecbff1e8a47a21fa.jpg', '酒', '50', '2', '0', '0','1490334348');
INSERT INTO `tc_order_goods` VALUES ('26', '19', '6', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_b3dc7fd18f46f1b3.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170324/b3dc7fd18f46f1b3.jpg', '嗯嗯', '36', '5', '0','0', '1490334776');
INSERT INTO `tc_order_goods` VALUES ('27', '20', '3', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_a8d774f498c039d8.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170324/a8d774f498c039d8.jpg', '花生', '18', '8', '0','0', '1490334806');
INSERT INTO `tc_order_goods` VALUES ('28', '21', '16', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_1b07ca82ea2d67f7.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170324/1b07ca82ea2d67f7.jpg', '优惠券2', '18', '1', '0','0', '1490335250');
INSERT INTO `tc_order_goods` VALUES ('29', '22', '17', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_bcee15b95b25ba15.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170324/bcee15b95b25ba15.jpg', '优惠券3', '11', '1', '0', '0','1490335450');
INSERT INTO `tc_order_goods` VALUES ('30', '23', '19', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_a84823a6340182df.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170324/a84823a6340182df.jpg', '商品2', '100', '1', '0','0', '1490335482');
INSERT INTO `tc_order_goods` VALUES ('31', '24', '12', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_ecbff1e8a47a21fa.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170324/ecbff1e8a47a21fa.jpg', '酒', '50', '1', '0','0', '1490336183');
INSERT INTO `tc_order_goods` VALUES ('32', '25', '12', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_ecbff1e8a47a21fa.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170324/ecbff1e8a47a21fa.jpg', '酒', '50', '1', '0','0', '1490336248');
INSERT INTO `tc_order_goods` VALUES ('33', '26', '12', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_ecbff1e8a47a21fa.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170324/ecbff1e8a47a21fa.jpg', '酒', '50', '1', '0','0', '1490336411');
INSERT INTO `tc_order_goods` VALUES ('34', '27', '19', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_a84823a6340182df.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170324/a84823a6340182df.jpg', '商品2', '100', '1', '0', '0','1490339248');
INSERT INTO `tc_order_goods` VALUES ('35', '28', '12', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_ecbff1e8a47a21fa.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170324/ecbff1e8a47a21fa.jpg', '酒', '50', '1', '0', '0','1490340996');
INSERT INTO `tc_order_goods` VALUES ('36', '28', '11', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_17a6e99b046e4420.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170324/17a6e99b046e4420.jpg', '辣条', '4.5', '1', '0','0', '1490340996');
INSERT INTO `tc_order_goods` VALUES ('37', '29', '12', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_ecbff1e8a47a21fa.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170324/ecbff1e8a47a21fa.jpg', '酒', '50', '1', '0','0', '1490341507');
INSERT INTO `tc_order_goods` VALUES ('38', '30', '16', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_1b07ca82ea2d67f7.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170324/1b07ca82ea2d67f7.jpg', '优惠券2', '18', '1', '0','0', '1490494678');
INSERT INTO `tc_order_goods` VALUES ('39', '31', '16', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_1b07ca82ea2d67f7.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170324/1b07ca82ea2d67f7.jpg', '优惠券2', '18', '1', '0','0', '1490496032');
INSERT INTO `tc_order_goods` VALUES ('40', '32', '11', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_17a6e99b046e4420.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170324/17a6e99b046e4420.jpg', '辣条', '4.5', '1', '0','0', '1490497428');
INSERT INTO `tc_order_goods` VALUES ('41', '33', '11', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_17a6e99b046e4420.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170324/17a6e99b046e4420.jpg', '辣条', '4.5', '1', '0','0', '1490497611');
INSERT INTO `tc_order_goods` VALUES ('42', '34', '11', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_17a6e99b046e4420.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170324/17a6e99b046e4420.jpg', '辣条', '4.5', '1', '0','0', '1490497763');
INSERT INTO `tc_order_goods` VALUES ('43', '35', '11', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_17a6e99b046e4420.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170324/17a6e99b046e4420.jpg', '辣条', '4.5', '1', '0','0', '1490498060');
INSERT INTO `tc_order_goods` VALUES ('44', '36', '11', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_17a6e99b046e4420.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170324/17a6e99b046e4420.jpg', '辣条', '4.5', '1', '0','0', '1490499252');
INSERT INTO `tc_order_goods` VALUES ('45', '37', '11', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_17a6e99b046e4420.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170324/17a6e99b046e4420.jpg', '辣条', '4.5', '1', '0','0', '1490499270');
INSERT INTO `tc_order_goods` VALUES ('46', '38', '20', 'http://www.kmlejin.com/Uploads/Picture/20170326/s_e67ad0b257218a5d.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170326/e67ad0b257218a5d.jpg', '测优惠券', '5', '1', '0', '0','1490500108');
INSERT INTO `tc_order_goods` VALUES ('47', '39', '12', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_ecbff1e8a47a21fa.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170324/ecbff1e8a47a21fa.jpg', '酒', '50', '1', '0','0', '1490500126');
INSERT INTO `tc_order_goods` VALUES ('48', '40', '22', 'http://www.kmlejin.com/Uploads/Picture/20170327/s_b3705f2671783813.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170327/b3705f2671783813.jpg', '优惠券2', '10', '1', '0','0', '1490577234');
INSERT INTO `tc_order_goods` VALUES ('49', '40', '21', 'http://www.kmlejin.com/Uploads/Picture/20170327/s_aef911d9d6af1794.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170327/aef911d9d6af1794.jpg', '优惠券1', '18', '1', '0','0', '1490577234');
INSERT INTO `tc_order_goods` VALUES ('50', '41', '21', 'http://www.kmlejin.com/Uploads/Picture/20170327/s_aef911d9d6af1794.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170327/aef911d9d6af1794.jpg', '优惠券1', '18', '1', '0','0', '1490577273');
INSERT INTO `tc_order_goods` VALUES ('51', '42', '25', 'http://www.kmlejin.com/Uploads/Picture/20170327/s_8a2b4dfc8aa043e0.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170327/8a2b4dfc8aa043e0.jpg', '优惠券一', '8', '1', '0', '0','1490578067');
INSERT INTO `tc_order_goods` VALUES ('52', '42', '26', 'http://www.kmlejin.com/Uploads/Picture/20170327/s_ca0fdb6916d64466.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170327/ca0fdb6916d64466.jpg', '优惠券二', '10', '1', '0','0', '1490578067');
INSERT INTO `tc_order_goods` VALUES ('53', '42', '20', 'http://www.kmlejin.com/Uploads/Picture/20170326/s_e67ad0b257218a5d.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170326/e67ad0b257218a5d.jpg', '测优惠券', '5', '1', '0', '0','1490578067');
INSERT INTO `tc_order_goods` VALUES ('54', '43', '26', 'http://www.kmlejin.com/Uploads/Picture/20170327/s_ca0fdb6916d64466.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170327/ca0fdb6916d64466.jpg', '优惠券二', '10', '1', '0','0', '1490578381');
INSERT INTO `tc_order_goods` VALUES ('55', '43', '27', 'http://www.kmlejin.com/Uploads/Picture/20170327/s_8b9f3634fc4ba938.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170327/8b9f3634fc4ba938.jpg', '优惠券三', '10', '1', '0','0', '1490578381');
INSERT INTO `tc_order_goods` VALUES ('56', '44', '25', 'http://www.kmlejin.com/Uploads/Picture/20170327/s_8a2b4dfc8aa043e0.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170327/8a2b4dfc8aa043e0.jpg', '优惠券一', '8', '1', '0','0', '1490578549');
INSERT INTO `tc_order_goods` VALUES ('57', '44', '26', 'http://www.kmlejin.com/Uploads/Picture/20170327/s_ca0fdb6916d64466.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170327/ca0fdb6916d64466.jpg', '优惠券二', '10', '1', '0','0', '1490578549');
INSERT INTO `tc_order_goods` VALUES ('58', '44', '27', 'http://www.kmlejin.com/Uploads/Picture/20170327/s_8b9f3634fc4ba938.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170327/8b9f3634fc4ba938.jpg', '优惠券三', '10', '1', '0','0', '1490578549');
INSERT INTO `tc_order_goods` VALUES ('59', '45', '25', 'http://www.kmlejin.com/Uploads/Picture/20170327/s_8a2b4dfc8aa043e0.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170327/8a2b4dfc8aa043e0.jpg', '优惠券一', '8', '1', '0', '0','1490578593');
INSERT INTO `tc_order_goods` VALUES ('60', '45', '26', 'http://www.kmlejin.com/Uploads/Picture/20170327/s_ca0fdb6916d64466.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170327/ca0fdb6916d64466.jpg', '优惠券二', '10', '1', '0','0', '1490578593');
INSERT INTO `tc_order_goods` VALUES ('61', '45', '27', 'http://www.kmlejin.com/Uploads/Picture/20170327/s_8b9f3634fc4ba938.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170327/8b9f3634fc4ba938.jpg', '优惠券三', '10', '1', '0', '0','1490578593');
INSERT INTO `tc_order_goods` VALUES ('62', '46', '19', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_a84823a6340182df.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170324/a84823a6340182df.jpg', '商品2', '100', '1', '0', '0','1490579698');
INSERT INTO `tc_order_goods` VALUES ('63', '47', '12', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_ecbff1e8a47a21fa.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170324/ecbff1e8a47a21fa.jpg', '酒', '50', '1', '0', '0','1490579715');
INSERT INTO `tc_order_goods` VALUES ('64', '48', '11', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_17a6e99b046e4420.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170324/17a6e99b046e4420.jpg', '辣条', '4.5', '1', '0', '0','1490579724');
INSERT INTO `tc_order_goods` VALUES ('65', '49', '3', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_a8d774f498c039d8.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170324/a8d774f498c039d8.jpg', '花生', '18', '1', '0','0', '1490579915');
INSERT INTO `tc_order_goods` VALUES ('66', '50', '3', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_a8d774f498c039d8.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170324/a8d774f498c039d8.jpg', '花生', '18', '1', '0','0', '1490579921');
INSERT INTO `tc_order_goods` VALUES ('67', '51', '3', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_a8d774f498c039d8.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170324/a8d774f498c039d8.jpg', '花生', '18', '1', '0', '0','1490579930');
INSERT INTO `tc_order_goods` VALUES ('68', '52', '1', 'http://www.kmlejin.com/Uploads/Picture/20170323/s_e31059b697bbf19a.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170323/e31059b697bbf19a.jpg', '小吃', '12', '1', '0','0', '1490579955');
INSERT INTO `tc_order_goods` VALUES ('69', '53', '12', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_ecbff1e8a47a21fa.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170324/ecbff1e8a47a21fa.jpg', '酒', '50', '1', '0', '0','1490579986');
INSERT INTO `tc_order_goods` VALUES ('70', '54', '28', 'http://www.kmlejin.com/Uploads/Picture/20170327/s_52f09e0355f7df8d.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170327/52f09e0355f7df8d.jpg', '优惠券', '25', '1', '0','0', '1490581146');
INSERT INTO `tc_order_goods` VALUES ('71', '55', '29', 'http://www.kmlejin.com/Uploads/Picture/20170327/s_c1dec48d25d40acc.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170327/c1dec48d25d40acc.jpg', '优惠券1', '35', '1', '0', '0','1490581246');
INSERT INTO `tc_order_goods` VALUES ('72', '56', '25', 'http://www.kmlejin.com/Uploads/Picture/20170327/s_8a2b4dfc8aa043e0.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170327/8a2b4dfc8aa043e0.jpg', '优惠券一', '8', '1', '0', '0','1490581590');
INSERT INTO `tc_order_goods` VALUES ('73', '56', '26', 'http://www.kmlejin.com/Uploads/Picture/20170327/s_ca0fdb6916d64466.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170327/ca0fdb6916d64466.jpg', '优惠券二', '10', '1', '0', '0','1490581590');
INSERT INTO `tc_order_goods` VALUES ('74', '57', '22', 'http://www.kmlejin.com/Uploads/Picture/20170327/s_b3705f2671783813.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170327/b3705f2671783813.jpg', '优惠券2', '10', '1', '0', '0','1490581909');
INSERT INTO `tc_order_goods` VALUES ('75', '57', '21', 'http://www.kmlejin.com/Uploads/Picture/20170327/s_aef911d9d6af1794.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170327/aef911d9d6af1794.jpg', '优惠券1', '18', '1', '0','0', '1490581909');
INSERT INTO `tc_order_goods` VALUES ('76', '58', '31', 'http://www.kmlejin.com/Uploads/Picture/20170327/s_c1d34211966313e7.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170327/c1d34211966313e7.jpg', '商品2', '20', '1', '0', '0','1490583660');
INSERT INTO `tc_order_goods` VALUES ('77', '58', '32', 'http://www.kmlejin.com/Uploads/Picture/20170327/s_88efd1edb8f92673.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170327/88efd1edb8f92673.jpg', '小馒头', '30', '1', '0','0', '1490583660');
INSERT INTO `tc_order_goods` VALUES ('78', '59', '32', 'http://www.kmlejin.com/Uploads/Picture/20170327/s_88efd1edb8f92673.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170327/88efd1edb8f92673.jpg', '小馒头', '30', '3', '0','0', '1490584112');
INSERT INTO `tc_order_goods` VALUES ('79', '59', '31', 'http://www.kmlejin.com/Uploads/Picture/20170327/s_c1d34211966313e7.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170327/c1d34211966313e7.jpg', '商品2', '20', '2', '0', '0','1490584112');
INSERT INTO `tc_order_goods` VALUES ('80', '60', '32', 'http://www.kmlejin.com/Uploads/Picture/20170327/s_88efd1edb8f92673.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170327/88efd1edb8f92673.jpg', '小馒头', '30', '2', '0','0', '1490584444');
INSERT INTO `tc_order_goods` VALUES ('81', '60', '31', 'http://www.kmlejin.com/Uploads/Picture/20170327/s_c1d34211966313e7.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170327/c1d34211966313e7.jpg', '商品2', '20', '2', '0', '0','1490584444');
INSERT INTO `tc_order_goods` VALUES ('82', '61', '31', 'http://www.kmlejin.com/Uploads/Picture/20170327/s_c1d34211966313e7.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170327/c1d34211966313e7.jpg', '商品2', '20', '1', '0', '0','1490584652');
INSERT INTO `tc_order_goods` VALUES ('83', '61', '32', 'http://www.kmlejin.com/Uploads/Picture/20170327/s_88efd1edb8f92673.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170327/88efd1edb8f92673.jpg', '小馒头', '30', '1', '0','0', '1490584652');
INSERT INTO `tc_order_goods` VALUES ('84', '62', '32', 'http://www.kmlejin.com/Uploads/Picture/20170327/s_88efd1edb8f92673.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170327/88efd1edb8f92673.jpg', '小馒头', '30', '1', '0','0', '1490584949');
INSERT INTO `tc_order_goods` VALUES ('85', '62', '31', 'http://www.kmlejin.com/Uploads/Picture/20170327/s_c1d34211966313e7.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170327/c1d34211966313e7.jpg', '商品2', '20', '2', '0','0', '1490584949');
INSERT INTO `tc_order_goods` VALUES ('86', '63', '32', 'http://www.kmlejin.com/Uploads/Picture/20170327/s_88efd1edb8f92673.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170327/88efd1edb8f92673.jpg', '小馒头', '30', '1', '0', '0','1490585066');
INSERT INTO `tc_order_goods` VALUES ('87', '63', '31', 'http://www.kmlejin.com/Uploads/Picture/20170327/s_c1d34211966313e7.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170327/c1d34211966313e7.jpg', '商品2', '20', '1', '0','0', '1490585066');
INSERT INTO `tc_order_goods` VALUES ('88', '64', '25', 'http://www.kmlejin.com/Uploads/Picture/20170327/s_8a2b4dfc8aa043e0.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170327/8a2b4dfc8aa043e0.jpg', '优惠券一', '8', '1', '0','0', '1490599696');
INSERT INTO `tc_order_goods` VALUES ('89', '64', '26', 'http://www.kmlejin.com/Uploads/Picture/20170327/s_ca0fdb6916d64466.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170327/ca0fdb6916d64466.jpg', '优惠券二', '10', '1', '0', '0','1490599696');
INSERT INTO `tc_order_goods` VALUES ('90', '65', '27', 'http://www.kmlejin.com/Uploads/Picture/20170327/s_8b9f3634fc4ba938.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170327/8b9f3634fc4ba938.jpg', '优惠券三', '10', '1', '0', '0','1490599726');
INSERT INTO `tc_order_goods` VALUES ('91', '65', '24', 'http://www.kmlejin.com/Uploads/Picture/20170327/s_bd7631c70b309929.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170327/bd7631c70b309929.jpg', '优惠券', '18', '1', '0', '0','1490599726');
INSERT INTO `tc_order_goods` VALUES ('92', '66', '19', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_a84823a6340182df.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170324/a84823a6340182df.jpg', '商品2', '100', '1', '0','0', '1490604642');
INSERT INTO `tc_order_goods` VALUES ('93', '67', '11', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_17a6e99b046e4420.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170324/17a6e99b046e4420.jpg', '辣条', '5', '1', '0', '0','1490604650');
INSERT INTO `tc_order_goods` VALUES ('94', '68', '11', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_17a6e99b046e4420.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170324/17a6e99b046e4420.jpg', '辣条', '5', '1', '0','0', '1490604656');
INSERT INTO `tc_order_goods` VALUES ('95', '69', '11', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_17a6e99b046e4420.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170324/17a6e99b046e4420.jpg', '辣条', '5', '1', '0','0', '1490604660');
INSERT INTO `tc_order_goods` VALUES ('96', '70', '11', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_17a6e99b046e4420.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170324/17a6e99b046e4420.jpg', '辣条', '5', '1', '0','0', '1490604665');
INSERT INTO `tc_order_goods` VALUES ('97', '71', '11', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_17a6e99b046e4420.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170324/17a6e99b046e4420.jpg', '辣条', '5', '1', '0','0', '1490604671');
INSERT INTO `tc_order_goods` VALUES ('98', '72', '11', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_17a6e99b046e4420.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170324/17a6e99b046e4420.jpg', '辣条', '5', '1', '0','0', '1490604696');
INSERT INTO `tc_order_goods` VALUES ('99', '73', '20', 'http://www.kmlejin.com/Uploads/Picture/20170326/s_e67ad0b257218a5d.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170326/e67ad0b257218a5d.jpg', '测优惠券', '5', '1', '0', '0','1490604747');
INSERT INTO `tc_order_goods` VALUES ('100', '73', '25', 'http://www.kmlejin.com/Uploads/Picture/20170327/s_8a2b4dfc8aa043e0.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170327/8a2b4dfc8aa043e0.jpg', '优惠券一', '8', '1', '0','0', '1490604747');
INSERT INTO `tc_order_goods` VALUES ('101', '74', '21', 'http://www.kmlejin.com/Uploads/Picture/20170327/s_aef911d9d6af1794.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170327/aef911d9d6af1794.jpg', '优惠券1', '18', '1', '0','0', '1490604835');
INSERT INTO `tc_order_goods` VALUES ('102', '74', '22', 'http://www.kmlejin.com/Uploads/Picture/20170327/s_b3705f2671783813.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170327/b3705f2671783813.jpg', '优惠券2', '10', '1', '0','0', '1490604835');
INSERT INTO `tc_order_goods` VALUES ('103', '75', '8', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_4c9a53dfde53cce8.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170324/4c9a53dfde53cce8.jpg', '商品', '18', '1', '0','0', '1490604870');
INSERT INTO `tc_order_goods` VALUES ('104', '76', '33', 'http://www.kmlejin.com/Uploads/Picture/20170327/s_c137a0a936374bf0.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170327/c137a0a936374bf0.jpg', '优惠券1', '15', '1', '0','0', '1490605401');
INSERT INTO `tc_order_goods` VALUES ('105', '76', '34', 'http://www.kmlejin.com/Uploads/Picture/20170327/s_c908f88afc39e973.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170327/c908f88afc39e973.jpg', '优惠券2', '15', '1', '0','0', '1490605401');
INSERT INTO `tc_order_goods` VALUES ('106', '77', '35', 'http://www.kmlejin.com/Uploads/Picture/20170327/s_f6be1a1d5cac7983.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170327/f6be1a1d5cac7983.jpg', '商品1', '20', '1', '0','0', '1490605565');
INSERT INTO `tc_order_goods` VALUES ('107', '78', '35', 'http://www.kmlejin.com/Uploads/Picture/20170327/s_f6be1a1d5cac7983.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170327/f6be1a1d5cac7983.jpg', '商品1', '20', '1', '0','0', '1490605571');
INSERT INTO `tc_order_goods` VALUES ('108', '79', '34', 'http://www.kmlejin.com/Uploads/Picture/20170327/s_c908f88afc39e973.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170327/c908f88afc39e973.jpg', '优惠券2', '15', '1', '0', '0','1490605673');
INSERT INTO `tc_order_goods` VALUES ('109', '79', '33', 'http://www.kmlejin.com/Uploads/Picture/20170327/s_c137a0a936374bf0.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170327/c137a0a936374bf0.jpg', '优惠券1', '15', '1', '0','0', '1490605673');
INSERT INTO `tc_order_goods` VALUES ('110', '80', '35', 'http://www.kmlejin.com/Uploads/Picture/20170327/s_f6be1a1d5cac7983.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170327/f6be1a1d5cac7983.jpg', '商品1', '20', '1', '0','0', '1490605696');
INSERT INTO `tc_order_goods` VALUES ('111', '81', '35', 'http://www.kmlejin.com/Uploads/Picture/20170327/s_f6be1a1d5cac7983.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170327/f6be1a1d5cac7983.jpg', '商品1', '20', '1', '0','0', '1490605711');
INSERT INTO `tc_order_goods` VALUES ('112', '82', '24', 'http://www.kmlejin.com/Uploads/Picture/20170327/s_bd7631c70b309929.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170327/bd7631c70b309929.jpg', '优惠券', '18', '2', '0','0', '1490605954');
INSERT INTO `tc_order_goods` VALUES ('113', '83', '33', 'http://www.kmlejin.com/Uploads/Picture/20170327/s_c137a0a936374bf0.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170327/c137a0a936374bf0.jpg', '优惠券1', '15', '1', '0','0', '1490606040');
INSERT INTO `tc_order_goods` VALUES ('114', '83', '34', 'http://www.kmlejin.com/Uploads/Picture/20170327/s_c908f88afc39e973.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170327/c908f88afc39e973.jpg', '优惠券2', '15', '1', '0','0', '1490606040');
INSERT INTO `tc_order_goods` VALUES ('115', '84', '20', 'http://www.kmlejin.com/Uploads/Picture/20170326/s_e67ad0b257218a5d.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170326/e67ad0b257218a5d.jpg', '测优惠券', '5', '1', '0','0', '1490606131');
INSERT INTO `tc_order_goods` VALUES ('116', '84', '24', 'http://www.kmlejin.com/Uploads/Picture/20170327/s_bd7631c70b309929.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170327/bd7631c70b309929.jpg', '优惠券', '18', '1', '0','0', '1490606131');
INSERT INTO `tc_order_goods` VALUES ('117', '85', '20', 'http://www.kmlejin.com/Uploads/Picture/20170326/s_e67ad0b257218a5d.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170326/e67ad0b257218a5d.jpg', '测优惠券', '5', '1', '0','0', '1490606601');
INSERT INTO `tc_order_goods` VALUES ('118', '85', '24', 'http://www.kmlejin.com/Uploads/Picture/20170327/s_bd7631c70b309929.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170327/bd7631c70b309929.jpg', '优惠券', '18', '1', '0','0', '1490606601');
INSERT INTO `tc_order_goods` VALUES ('119', '86', '35', 'http://www.kmlejin.com/Uploads/Picture/20170327/s_f6be1a1d5cac7983.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170327/f6be1a1d5cac7983.jpg', '商品1', '20', '1', '0', '0','1490606752');
INSERT INTO `tc_order_goods` VALUES ('120', '87', '33', 'http://www.kmlejin.com/Uploads/Picture/20170327/s_c137a0a936374bf0.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170327/c137a0a936374bf0.jpg', '优惠券1', '15', '1', '0','0', '1490606795');
INSERT INTO `tc_order_goods` VALUES ('121', '87', '34', 'http://www.kmlejin.com/Uploads/Picture/20170327/s_c908f88afc39e973.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170327/c908f88afc39e973.jpg', '优惠券2', '15', '1', '0','0', '1490606795');
INSERT INTO `tc_order_goods` VALUES ('122', '88', '35', 'http://www.kmlejin.com/Uploads/Picture/20170327/s_f6be1a1d5cac7983.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170327/f6be1a1d5cac7983.jpg', '商品1', '20', '1', '0','0', '1490607064');
INSERT INTO `tc_order_goods` VALUES ('123', '89', '35', 'http://www.kmlejin.com/Uploads/Picture/20170327/s_f6be1a1d5cac7983.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170327/f6be1a1d5cac7983.jpg', '商品1', '20', '5', '0','0', '1490607291');
INSERT INTO `tc_order_goods` VALUES ('124', '90', '35', 'http://www.kmlejin.com/Uploads/Picture/20170327/s_f6be1a1d5cac7983.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170327/f6be1a1d5cac7983.jpg', '商品1', '20', '1', '0','0', '1490607891');
INSERT INTO `tc_order_goods` VALUES ('125', '91', '35', 'http://www.kmlejin.com/Uploads/Picture/20170327/s_f6be1a1d5cac7983.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170327/f6be1a1d5cac7983.jpg', '商品1', '20', '5', '0', '0','1490608437');
INSERT INTO `tc_order_goods` VALUES ('126', '92', '11', 'http://www.kmlejin.com/Uploads/Picture/20170324/s_17a6e99b046e4420.jpg', 'http://www.kmlejin.com/Uploads/Picture/20170324/17a6e99b046e4420.jpg', '辣条', '5', '1', '0','0', '1490608484');

-- ----------------------------
-- Table structure for `tc_order_status`
-- ----------------------------
DROP TABLE IF EXISTS `tc_order_status`;
CREATE TABLE `tc_order_status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `type` tinyint(4) NOT NULL,
  `remark` varchar(200) DEFAULT '',
  `create_time` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=205 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tc_order_status
-- ----------------------------
INSERT INTO `tc_order_status` VALUES ('1', '6', '1', '付款', '1490325590');
INSERT INTO `tc_order_status` VALUES ('2', '7', '1', '付款', '1490325616');
INSERT INTO `tc_order_status` VALUES ('3', '8', '1', '付款', '1490325627');
INSERT INTO `tc_order_status` VALUES ('4', '6', '9', '取消', '1490325661');
INSERT INTO `tc_order_status` VALUES ('5', '9', '1', '付款', '1490325676');
INSERT INTO `tc_order_status` VALUES ('6', '10', '1', '付款', '1490325714');
INSERT INTO `tc_order_status` VALUES ('7', '7', '9', '取消', '1490325721');
INSERT INTO `tc_order_status` VALUES ('8', '8', '9', '取消', '1490325721');
INSERT INTO `tc_order_status` VALUES ('9', '11', '1', '付款', '1490325741');
INSERT INTO `tc_order_status` VALUES ('10', '9', '9', '取消', '1490325781');
INSERT INTO `tc_order_status` VALUES ('11', '10', '9', '取消', '1490325781');
INSERT INTO `tc_order_status` VALUES ('12', '11', '9', '取消', '1490325841');
INSERT INTO `tc_order_status` VALUES ('13', '17', '1', '付款', '1490333622');
INSERT INTO `tc_order_status` VALUES ('14', '17', '2', '发货', '1490333656');
INSERT INTO `tc_order_status` VALUES ('15', '17', '3', '收货', '1490333663');
INSERT INTO `tc_order_status` VALUES ('16', '18', '1', '付款', '1490334348');
INSERT INTO `tc_order_status` VALUES ('17', '18', '2', '发货', '1490334410');
INSERT INTO `tc_order_status` VALUES ('18', '18', '3', '收货', '1490334447');
INSERT INTO `tc_order_status` VALUES ('19', '18', '6', '退货', '1490334665');
INSERT INTO `tc_order_status` VALUES ('20', '20', '1', '付款', '1490334806');
INSERT INTO `tc_order_status` VALUES ('21', '20', '2', '发货', '1490334843');
INSERT INTO `tc_order_status` VALUES ('22', '20', '3', '收货', '1490335021');
INSERT INTO `tc_order_status` VALUES ('23', '23', '1', '付款', '1490335499');
INSERT INTO `tc_order_status` VALUES ('24', '23', '2', '发货', '1490335548');
INSERT INTO `tc_order_status` VALUES ('25', '23', '3', '收货', '1490335575');
INSERT INTO `tc_order_status` VALUES ('26', '23', '6', '退货', '1490335796');
INSERT INTO `tc_order_status` VALUES ('27', '25', '1', '付款', '1490336255');
INSERT INTO `tc_order_status` VALUES ('28', '25', '9', '取消', '1490336341');
INSERT INTO `tc_order_status` VALUES ('29', '26', '1', '付款', '1490336427');
INSERT INTO `tc_order_status` VALUES ('30', '26', '2', '发货', '1490336491');
INSERT INTO `tc_order_status` VALUES ('31', '26', '3', '收货', '1490336531');
INSERT INTO `tc_order_status` VALUES ('32', '26', '6', '退货', '1490336727');
INSERT INTO `tc_order_status` VALUES ('33', '27', '1', '付款', '1490339255');
INSERT INTO `tc_order_status` VALUES ('34', '27', '2', '发货', '1490339293');
INSERT INTO `tc_order_status` VALUES ('35', '27', '3', '收货', '1490339352');
INSERT INTO `tc_order_status` VALUES ('36', '28', '1', '付款', '1490340996');
INSERT INTO `tc_order_status` VALUES ('37', '28', '9', '取消', '1490341081');
INSERT INTO `tc_order_status` VALUES ('38', '29', '1', '付款', '1490341507');
INSERT INTO `tc_order_status` VALUES ('39', '29', '2', '发货', '1490341542');
INSERT INTO `tc_order_status` VALUES ('40', '29', '3', '收货', '1490341549');
INSERT INTO `tc_order_status` VALUES ('41', '29', '6', '退货', '1490341774');
INSERT INTO `tc_order_status` VALUES ('42', '31', '1', '付款', '1490496032');
INSERT INTO `tc_order_status` VALUES ('43', '31', '3', '收货', '1490496032');
INSERT INTO `tc_order_status` VALUES ('44', '32', '1', '付款', '1490497448');
INSERT INTO `tc_order_status` VALUES ('45', '32', '9', '取消', '1490497561');
INSERT INTO `tc_order_status` VALUES ('46', '33', '1', '付款', '1490497618');
INSERT INTO `tc_order_status` VALUES ('47', '33', '9', '取消', '1490497681');
INSERT INTO `tc_order_status` VALUES ('48', '34', '1', '付款', '1490497770');
INSERT INTO `tc_order_status` VALUES ('49', '34', '2', '发货', '1490497805');
INSERT INTO `tc_order_status` VALUES ('50', '34', '6', '退货', '1490497907');
INSERT INTO `tc_order_status` VALUES ('51', '35', '1', '付款', '1490498066');
INSERT INTO `tc_order_status` VALUES ('52', '35', '2', '发货', '1490498090');
INSERT INTO `tc_order_status` VALUES ('53', '35', '3', '收货', '1490498110');
INSERT INTO `tc_order_status` VALUES ('54', '35', '6', '退货', '1490498333');
INSERT INTO `tc_order_status` VALUES ('55', '36', '1', '付款', '1490499259');
INSERT INTO `tc_order_status` VALUES ('56', '37', '1', '付款', '1490499277');
INSERT INTO `tc_order_status` VALUES ('57', '37', '2', '发货', '1490499299');
INSERT INTO `tc_order_status` VALUES ('58', '36', '2', '发货', '1490499307');
INSERT INTO `tc_order_status` VALUES ('59', '36', '3', '收货', '1490499339');
INSERT INTO `tc_order_status` VALUES ('60', '37', '6', '退货', '1490499345');
INSERT INTO `tc_order_status` VALUES ('61', '36', '6', '退货', '1490499506');
INSERT INTO `tc_order_status` VALUES ('62', '38', '1', '付款', '1490500108');
INSERT INTO `tc_order_status` VALUES ('63', '38', '3', '收货', '1490500108');
INSERT INTO `tc_order_status` VALUES ('64', '39', '1', '付款', '1490500126');
INSERT INTO `tc_order_status` VALUES ('65', '39', '2', '发货', '1490500156');
INSERT INTO `tc_order_status` VALUES ('66', '39', '6', '退货', '1490500216');
INSERT INTO `tc_order_status` VALUES ('67', '40', '1', '付款', '1490577234');
INSERT INTO `tc_order_status` VALUES ('68', '40', '3', '收货', '1490577234');
INSERT INTO `tc_order_status` VALUES ('69', '41', '1', '付款', '1490577273');
INSERT INTO `tc_order_status` VALUES ('70', '41', '3', '收货', '1490577273');
INSERT INTO `tc_order_status` VALUES ('71', '42', '1', '付款', '1490578067');
INSERT INTO `tc_order_status` VALUES ('72', '42', '3', '收货', '1490578067');
INSERT INTO `tc_order_status` VALUES ('73', '43', '1', '付款', '1490578381');
INSERT INTO `tc_order_status` VALUES ('74', '43', '3', '收货', '1490578381');
INSERT INTO `tc_order_status` VALUES ('75', '44', '1', '付款', '1490578549');
INSERT INTO `tc_order_status` VALUES ('76', '44', '3', '收货', '1490578549');
INSERT INTO `tc_order_status` VALUES ('77', '45', '1', '付款', '1490578593');
INSERT INTO `tc_order_status` VALUES ('78', '45', '3', '收货', '1490578593');
INSERT INTO `tc_order_status` VALUES ('79', '46', '1', '付款', '1490579698');
INSERT INTO `tc_order_status` VALUES ('80', '47', '1', '付款', '1490579715');
INSERT INTO `tc_order_status` VALUES ('81', '48', '1', '付款', '1490579724');
INSERT INTO `tc_order_status` VALUES ('82', '48', '2', '发货', '1490579743');
INSERT INTO `tc_order_status` VALUES ('83', '46', '9', '取消', '1490579761');
INSERT INTO `tc_order_status` VALUES ('84', '48', '3', '收货', '1490579779');
INSERT INTO `tc_order_status` VALUES ('85', '47', '9', '取消', '1490579821');
INSERT INTO `tc_order_status` VALUES ('86', '48', '6', '退货', '1490579830');
INSERT INTO `tc_order_status` VALUES ('87', '49', '1', '付款', '1490579915');
INSERT INTO `tc_order_status` VALUES ('88', '50', '1', '付款', '1490579921');
INSERT INTO `tc_order_status` VALUES ('89', '51', '1', '付款', '1490579930');
INSERT INTO `tc_order_status` VALUES ('90', '52', '1', '付款', '1490579955');
INSERT INTO `tc_order_status` VALUES ('91', '52', '2', '发货', '1490579966');
INSERT INTO `tc_order_status` VALUES ('92', '50', '2', '发货', '1490579968');
INSERT INTO `tc_order_status` VALUES ('93', '49', '2', '发货', '1490579971');
INSERT INTO `tc_order_status` VALUES ('94', '51', '2', '发货', '1490579973');
INSERT INTO `tc_order_status` VALUES ('95', '53', '1', '付款', '1490579986');
INSERT INTO `tc_order_status` VALUES ('96', '53', '2', '发货', '1490579996');
INSERT INTO `tc_order_status` VALUES ('97', '49', '3', '收货', '1490580121');
INSERT INTO `tc_order_status` VALUES ('98', '50', '3', '收货', '1490580121');
INSERT INTO `tc_order_status` VALUES ('99', '51', '3', '收货', '1490580121');
INSERT INTO `tc_order_status` VALUES ('100', '52', '3', '收货', '1490580121');
INSERT INTO `tc_order_status` VALUES ('101', '53', '3', '收货', '1490580121');
INSERT INTO `tc_order_status` VALUES ('102', '54', '1', '付款', '1490581146');
INSERT INTO `tc_order_status` VALUES ('103', '54', '3', '收货', '1490581146');
INSERT INTO `tc_order_status` VALUES ('104', '55', '1', '付款', '1490581246');
INSERT INTO `tc_order_status` VALUES ('105', '55', '3', '收货', '1490581246');
INSERT INTO `tc_order_status` VALUES ('106', '56', '1', '付款', '1490581590');
INSERT INTO `tc_order_status` VALUES ('107', '56', '3', '收货', '1490581590');
INSERT INTO `tc_order_status` VALUES ('108', '57', '1', '付款', '1490581909');
INSERT INTO `tc_order_status` VALUES ('109', '57', '3', '收货', '1490581909');
INSERT INTO `tc_order_status` VALUES ('110', '58', '1', '付款', '1490583660');
INSERT INTO `tc_order_status` VALUES ('111', '58', '2', '发货', '1490583682');
INSERT INTO `tc_order_status` VALUES ('112', '58', '3', '收货', '1490583700');
INSERT INTO `tc_order_status` VALUES ('113', '58', '6', '退货', '1490584014');
INSERT INTO `tc_order_status` VALUES ('114', '58', '6', '退货', '1490584014');
INSERT INTO `tc_order_status` VALUES ('115', '59', '1', '付款', '1490584112');
INSERT INTO `tc_order_status` VALUES ('116', '59', '2', '发货', '1490584127');
INSERT INTO `tc_order_status` VALUES ('117', '59', '3', '收货', '1490584161');
INSERT INTO `tc_order_status` VALUES ('118', '59', '6', '退货', '1490584224');
INSERT INTO `tc_order_status` VALUES ('119', '59', '6', '退货', '1490584224');
INSERT INTO `tc_order_status` VALUES ('120', '60', '1', '付款', '1490584444');
INSERT INTO `tc_order_status` VALUES ('121', '60', '2', '发货', '1490584462');
INSERT INTO `tc_order_status` VALUES ('122', '60', '3', '收货', '1490584472');
INSERT INTO `tc_order_status` VALUES ('123', '60', '6', '退货', '1490584513');
INSERT INTO `tc_order_status` VALUES ('124', '60', '6', '退货', '1490584513');
INSERT INTO `tc_order_status` VALUES ('125', '61', '1', '付款', '1490584652');
INSERT INTO `tc_order_status` VALUES ('126', '61', '2', '发货', '1490584668');
INSERT INTO `tc_order_status` VALUES ('127', '61', '3', '收货', '1490584681');
INSERT INTO `tc_order_status` VALUES ('128', '61', '6', '退货', '1490584806');
INSERT INTO `tc_order_status` VALUES ('129', '61', '6', '退货', '1490584806');
INSERT INTO `tc_order_status` VALUES ('130', '62', '1', '付款', '1490584949');
INSERT INTO `tc_order_status` VALUES ('131', '62', '2', '发货', '1490584962');
INSERT INTO `tc_order_status` VALUES ('132', '62', '3', '收货', '1490584969');
INSERT INTO `tc_order_status` VALUES ('133', '62', '6', '退货', '1490584979');
INSERT INTO `tc_order_status` VALUES ('134', '62', '6', '退货', '1490584979');
INSERT INTO `tc_order_status` VALUES ('135', '63', '1', '付款', '1490585066');
INSERT INTO `tc_order_status` VALUES ('136', '63', '2', '发货', '1490585080');
INSERT INTO `tc_order_status` VALUES ('137', '63', '3', '收货', '1490585088');
INSERT INTO `tc_order_status` VALUES ('138', '63', '6', '退货', '1490585103');
INSERT INTO `tc_order_status` VALUES ('139', '63', '6', '退货', '1490585103');
INSERT INTO `tc_order_status` VALUES ('140', '64', '1', '付款', '1490599696');
INSERT INTO `tc_order_status` VALUES ('141', '64', '3', '收货', '1490599696');
INSERT INTO `tc_order_status` VALUES ('142', '65', '1', '付款', '1490599726');
INSERT INTO `tc_order_status` VALUES ('143', '65', '3', '收货', '1490599726');
INSERT INTO `tc_order_status` VALUES ('144', '66', '1', '付款', '1490604642');
INSERT INTO `tc_order_status` VALUES ('145', '67', '1', '付款', '1490604650');
INSERT INTO `tc_order_status` VALUES ('146', '68', '1', '付款', '1490604656');
INSERT INTO `tc_order_status` VALUES ('147', '69', '1', '付款', '1490604660');
INSERT INTO `tc_order_status` VALUES ('148', '70', '1', '付款', '1490604665');
INSERT INTO `tc_order_status` VALUES ('149', '71', '1', '付款', '1490604671');
INSERT INTO `tc_order_status` VALUES ('150', '72', '1', '付款', '1490604696');
INSERT INTO `tc_order_status` VALUES ('151', '66', '9', '取消', '1490604721');
INSERT INTO `tc_order_status` VALUES ('152', '67', '9', '取消', '1490604721');
INSERT INTO `tc_order_status` VALUES ('153', '68', '9', '取消', '1490604721');
INSERT INTO `tc_order_status` VALUES ('154', '69', '9', '取消', '1490604721');
INSERT INTO `tc_order_status` VALUES ('155', '73', '1', '付款', '1490604747');
INSERT INTO `tc_order_status` VALUES ('156', '73', '3', '收货', '1490604747');
INSERT INTO `tc_order_status` VALUES ('157', '70', '9', '取消', '1490604781');
INSERT INTO `tc_order_status` VALUES ('158', '71', '9', '取消', '1490604781');
INSERT INTO `tc_order_status` VALUES ('159', '72', '9', '取消', '1490604781');
INSERT INTO `tc_order_status` VALUES ('160', '74', '1', '付款', '1490604835');
INSERT INTO `tc_order_status` VALUES ('161', '74', '3', '收货', '1490604835');
INSERT INTO `tc_order_status` VALUES ('162', '75', '1', '付款', '1490604870');
INSERT INTO `tc_order_status` VALUES ('163', '75', '9', '取消', '1490604961');
INSERT INTO `tc_order_status` VALUES ('164', '76', '1', '付款', '1490605401');
INSERT INTO `tc_order_status` VALUES ('165', '76', '3', '收货', '1490605401');
INSERT INTO `tc_order_status` VALUES ('166', '77', '1', '付款', '1490605565');
INSERT INTO `tc_order_status` VALUES ('167', '78', '1', '付款', '1490605571');
INSERT INTO `tc_order_status` VALUES ('168', '79', '1', '付款', '1490605673');
INSERT INTO `tc_order_status` VALUES ('169', '79', '3', '收货', '1490605673');
INSERT INTO `tc_order_status` VALUES ('170', '77', '9', '取消', '1490605681');
INSERT INTO `tc_order_status` VALUES ('171', '78', '9', '取消', '1490605681');
INSERT INTO `tc_order_status` VALUES ('172', '80', '1', '付款', '1490605696');
INSERT INTO `tc_order_status` VALUES ('173', '81', '1', '付款', '1490605711');
INSERT INTO `tc_order_status` VALUES ('174', '80', '9', '取消', '1490605801');
INSERT INTO `tc_order_status` VALUES ('175', '81', '9', '取消', '1490605801');
INSERT INTO `tc_order_status` VALUES ('176', '82', '1', '付款', '1490605954');
INSERT INTO `tc_order_status` VALUES ('177', '82', '3', '收货', '1490605954');
INSERT INTO `tc_order_status` VALUES ('178', '83', '1', '付款', '1490606040');
INSERT INTO `tc_order_status` VALUES ('179', '83', '3', '收货', '1490606040');
INSERT INTO `tc_order_status` VALUES ('180', '84', '1', '付款', '1490606131');
INSERT INTO `tc_order_status` VALUES ('181', '84', '3', '收货', '1490606131');
INSERT INTO `tc_order_status` VALUES ('182', '85', '1', '付款', '1490606601');
INSERT INTO `tc_order_status` VALUES ('183', '85', '3', '收货', '1490606601');
INSERT INTO `tc_order_status` VALUES ('184', '86', '1', '付款', '1490606752');
INSERT INTO `tc_order_status` VALUES ('185', '86', '2', '发货', '1490606774');
INSERT INTO `tc_order_status` VALUES ('186', '87', '1', '付款', '1490606795');
INSERT INTO `tc_order_status` VALUES ('187', '87', '3', '收货', '1490606795');
INSERT INTO `tc_order_status` VALUES ('188', '86', '3', '收货', '1490606860');
INSERT INTO `tc_order_status` VALUES ('189', '88', '1', '付款', '1490607064');
INSERT INTO `tc_order_status` VALUES ('190', '88', '2', '发货', '1490607079');
INSERT INTO `tc_order_status` VALUES ('191', '88', '3', '收货', '1490607093');
INSERT INTO `tc_order_status` VALUES ('192', '89', '1', '付款', '1490607291');
INSERT INTO `tc_order_status` VALUES ('193', '89', '2', '发货', '1490607327');
INSERT INTO `tc_order_status` VALUES ('194', '89', '3', '收货', '1490607334');
INSERT INTO `tc_order_status` VALUES ('195', '89', '6', '退货', '1490607524');
INSERT INTO `tc_order_status` VALUES ('196', '90', '1', '付款', '1490607891');
INSERT INTO `tc_order_status` VALUES ('197', '90', '9', '取消', '1490607961');
INSERT INTO `tc_order_status` VALUES ('198', '91', '1', '付款', '1490608437');
INSERT INTO `tc_order_status` VALUES ('199', '91', '2', '发货', '1490608464');
INSERT INTO `tc_order_status` VALUES ('200', '91', '6', '退货', '1490608489');
INSERT INTO `tc_order_status` VALUES ('201', '92', '1', '付款', '1490608504');
INSERT INTO `tc_order_status` VALUES ('202', '92', '2', '发货', '1490608540');
INSERT INTO `tc_order_status` VALUES ('203', '92', '3', '收货', '1490608597');
INSERT INTO `tc_order_status` VALUES ('204', '92', '6', '退货', '1490608763');

-- ----------------------------
-- Table structure for `tc_recharge`
-- ----------------------------
DROP TABLE IF EXISTS `tc_recharge`;
CREATE TABLE `tc_recharge` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `price` varchar(20) NOT NULL,
  `create_time` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tc_recharge
-- ----------------------------

-- ----------------------------
-- Table structure for `tc_session`
-- ----------------------------
DROP TABLE IF EXISTS `tc_session`;
CREATE TABLE `tc_session` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(50) NOT NULL DEFAULT '' COMMENT '用户id',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '会话名称',
  `createtime` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='临时会话表';

-- ----------------------------
-- Records of tc_session
-- ----------------------------

-- ----------------------------
-- Table structure for `tc_session_user`
-- ----------------------------
DROP TABLE IF EXISTS `tc_session_user`;
CREATE TABLE `tc_session_user` (
  `sessionid` int(11) unsigned NOT NULL DEFAULT '0',
  `uid` varchar(50) NOT NULL DEFAULT '' COMMENT '用户id',
  `role` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0-成员 1-创建者',
  `getmsg` tinyint(1) DEFAULT '1' COMMENT '0-不接收 1-接收',
  `addtime` int(11) NOT NULL DEFAULT '0',
  KEY `sessionid` (`sessionid`,`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='临时会话用户表';

-- ----------------------------
-- Records of tc_session_user
-- ----------------------------

-- ----------------------------
-- Table structure for `tc_share`
-- ----------------------------
DROP TABLE IF EXISTS `tc_share`;
CREATE TABLE `tc_share` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `rootid` int(11) NOT NULL DEFAULT '0' COMMENT '被转发的原始的id',
  `uid` int(11) unsigned DEFAULT '0' COMMENT '用户',
  `cateid` int(11) NOT NULL DEFAULT '0' COMMENT '类别id',
  `groupids` varchar(128) NOT NULL DEFAULT '' COMMENT '群',
  `title` varchar(30) NOT NULL DEFAULT '',
  `content` text NOT NULL COMMENT '内容',
  `images` varchar(2048) NOT NULL DEFAULT '' COMMENT '图片',
  `video` varchar(2048) NOT NULL DEFAULT '',
  `address` varchar(128) NOT NULL DEFAULT '' COMMENT '地址',
  `lat` decimal(10,6) DEFAULT '0.000000' COMMENT '纬度',
  `lng` decimal(10,6) DEFAULT '0.000000' COMMENT '经度',
  `praisecount` int(11) NOT NULL DEFAULT '0',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0-正常 1-转发',
  `province` varchar(20) NOT NULL DEFAULT '',
  `city` varchar(20) NOT NULL DEFAULT '',
  `createtime` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=130 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tc_share
-- ----------------------------
INSERT INTO `tc_share` VALUES ('1', '0', '20000002', '2', '', '', '在都市的高楼中，难得还可以看到一片绿地[emoji_13]有很多人还不知道[emoji_269][emoji_68]', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160319/e540776073c6f22c.jpg\",\"smallUrl\":\"/Uploads/Picture/20160319/s_e540776073c6f22c.jpg\",\"id\":\"22eb404ba0ecfcc2dbf6d4e36ca58f9e\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20160319/a5285c23c64e31de.jpg\",\"smallUrl\":\"/Uploads/Picture/20160319/s_a5285c23c64e31de.jpg\",\"id\":\"77ff16cfb89dfe0061fa75bb6e5f1dfd\"},{\"key\":\"images3\",\"originUrl\":\"/Uploads/Picture/20160319/c2a91d423f6a50d4.jpg\",\"smallUrl\":\"/Uploads/Picture/20160319/s_c2a91d423f6a50d4.jpg\",\"id\":\"cbd0eeaf3224d6ebc1b21c83b0076857\"}]', '', '云南省昆明市盘龙区G56(杭瑞高速公路)', '25.106845', '102.779703', '1', '0', '', '全国', '1458385744');
INSERT INTO `tc_share` VALUES ('2', '0', '20000002', '8', '', '', '今天陪老婆一口气看了两部电影，《荒野猎人》和《神战：权利之眼》，这完全就是两种风格的对撞，一个现实、血腥、冷酷、残暴……，一个虚幻、宏大、充满想象……，直看得我大呼过瘾[emoji_256]。不过我所看到的可能与其他人有点不同，这两部片子都是透过故事来展示人性，及思想观点的对撞，和人类发展各种文明的交集冲突，没有对与错，只是展现出来让观众自己评判[emoji_96][emoji_353]。既呈现出不同风格的视觉震撼，又能巧妙于其中，不无需去说教，还是不得不佩服好莱坞的导演们，值得一看[emoji_13][emoji_13][emoji_13]', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160320/85440e025012d75d.jpg\",\"smallUrl\":\"/Uploads/Picture/20160320/s_85440e025012d75d.jpg\",\"id\":\"4242b51bcda5e220d760eaded1419ed0\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20160320/d8e03d212d29566f.jpg\",\"smallUrl\":\"/Uploads/Picture/20160320/s_d8e03d212d29566f.jpg\",\"id\":\"5f6854f7122a4b759ffce1e20d3a5843\"},{\"key\":\"images3\",\"originUrl\":\"/Uploads/Picture/20160320/38fd375b733b6a7f.jpg\",\"smallUrl\":\"/Uploads/Picture/20160320/s_38fd375b733b6a7f.jpg\",\"id\":\"b6ea9e79d5e83c5196d2907ec6753c1d\"},{\"key\":\"images4\",\"originUrl\":\"/Uploads/Picture/20160320/94d65db0f617fc16.jpg\",\"smallUrl\":\"/Uploads/Picture/20160320/s_94d65db0f617fc16.jpg\",\"id\":\"3fffeb62006cc3bddbfc1faca20a01fb\"},{\"key\":\"images5\",\"originUrl\":\"/Uploads/Picture/20160320/2f194feb42557afe.jpg\",\"smallUrl\":\"/Uploads/Picture/20160320/s_2f194feb42557afe.jpg\",\"id\":\"ab41c1209b86419104e885de40de1a88\"}]', '', '云南省昆明市盘龙区G56(杭瑞高速公路)', '25.106830', '102.779652', '1', '0', '', '全国', '1458475617');
INSERT INTO `tc_share` VALUES ('3', '0', '20000002', '2', '', '', '[emoji_86][emoji_86][emoji_86]', '', '', '云南省昆明市盘龙区G56(杭瑞高速公路)', '25.106842', '102.779663', '0', '0', '', '全国', '1458735631');
INSERT INTO `tc_share` VALUES ('4', '0', '20000002', '0', '1', '', '好听', '', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160324/3589d4e706601cf0.jpg\",\"smallUrl\":\"/Uploads/Picture/20160324/s_3589d4e706601cf0.jpg\",\"id\":\"5ba4effdf51a91a67623e7f0176cfaef\"},{\"originUrl\":\"/Uploads/Picture/20160324/0c552852b7c16b99.mp4\",\"smallUrl\":\"/Uploads/Picture/20160324/0c552852b7c16b99.mp4\",\"id\":\"6c27e932cbbbf87981901a716dfcf61e\",\"key\":\"video\"}]', '云南省昆明市盘龙区G56(杭瑞高速公路)', '25.106842', '102.779663', '0', '0', '', '全国', '1458787702');
INSERT INTO `tc_share` VALUES ('5', '0', '20000002', '0', '1', '', '研究表明，汉字的序顺并不定一能影阅响读，比如当你看这完句话后，才发这现里的子全是都乱的[emoji_86]', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160328/9fa4184b91e45232.jpg\",\"smallUrl\":\"/Uploads/Picture/20160328/s_9fa4184b91e45232.jpg\",\"id\":\"441312285cfffaf33bc2b0cdc8e9ea88\"}]', '', '云南省昆明市盘龙区G56(杭瑞高速公路)', '25.106772', '102.779626', '1', '0', '', '全国', '1459176500');
INSERT INTO `tc_share` VALUES ('6', '0', '20000000', '1', '', '', '今天磕头女的托福今天磕头女的托今天磕头女的托福今天磕头女的托福今天磕头女的托福。。。。。。。。。。。', '', '', '四川省成都市郫县天辰路39', '30.739059', '103.978800', '0', '0', '', '全国', '1459304683');
INSERT INTO `tc_share` VALUES ('7', '0', '20000000', '3', '', '', '现在，这家人住在巴基斯坦Quetta东部郊区，现在住的房子有12间房，总面积超过4000平方米。大叔经营着一家小诊所，每个月的薪水是955美元(约6200人民币)。他说，自己的这份薪水，养着30多个娃，足够了。[emoji_340][emoji_340][emoji_340][emoji_340]', '', '', '四川省成都市郫县天辰路39', '30.739059', '103.978800', '0', '0', '', '全国', '1459304830');
INSERT INTO `tc_share` VALUES ('8', '0', '20000000', '5', '', '', '现在，这家人住在巴基斯坦Quetta东部郊区，现在住的房子有12间房，总面积超过4000平方米。大叔经营着一家小诊所，每个月的薪水是955美元(约6200人民币)。他说，自己的这份薪水，养着30多个娃，足够了。', '', '', '四川省成都市郫县天辰路39', '30.739059', '103.978800', '0', '0', '', '全国', '1459304850');
INSERT INTO `tc_share` VALUES ('9', '0', '20000000', '2', '', '', '现在，这家人住在巴基斯坦Quetta东部郊区，现在住的房子有12间房，总面积超过4000平方米。大叔经营着一家小诊所，每个月的薪水是955美元(约6200人民币)。他说，自己的这份薪水，养着30多个娃，足够了。[emoji_340][emoji_340][emoji_340][emoji_340][emoji_340][emoji_340][emoji_340][emoji_340][emoji_340]', '', '', '四川省成都市郫县天辰路39', '30.739043', '103.978798', '0', '0', '', '全国', '1459306242');
INSERT INTO `tc_share` VALUES ('10', '0', '20000000', '1', '', '', '现在，这家人住在巴基斯坦Quetta东部郊区，现在住的房子有12间房，总面积超过4000平方米。大叔经营着一家小诊[emoji_340][emoji_340][emoji_340][emoji_340][emoji_340]', '', '', '四川省成都市郫县天辰路39', '30.739045', '103.978795', '0', '0', '', '全国', '1459306662');
INSERT INTO `tc_share` VALUES ('11', '0', '20000000', '1', '', '', '你好[emoji_88][emoji_88][emoji_88][emoji_88][emoji_88][emoji_88][emoji_346][emoji_346][emoji_347][emoji_340][emoji_88][emoji_88][emoji_345][emoji_346][emoji_347]', '', '', '四川省成都市郫县天辰路39', '30.739021', '103.978796', '0', '0', '', '全国', '1459308956');
INSERT INTO `tc_share` VALUES ('12', '0', '20000000', '1', '', '', '现在，这家人住在巴基斯坦Quetta东部郊区，现在住的房子有12间房，总面积超过4000平方米。大叔经营着一家小诊所，每个月的薪水是955美元(约6200人民币)。他说，自己的这份薪水，养着30多个娃，足够了。现在，这家人住在巴基斯坦Quetta东部郊区，现在住的房子有12间房，总面积超过4000平方米。大叔经营着一家小诊所，每个月的薪水是955美元(约6200人民币)。他说，自己的这份薪水，养着30多个娃，足够了。', '', '', '四川省成都市郫县天辰路39', '30.739044', '103.978796', '0', '0', '', '全国', '1459321646');
INSERT INTO `tc_share` VALUES ('13', '0', '20000000', '1', '', '', '[emoji_340]\n\n\n\n\n\n\n\n\n[emoji_88]', '', '', '四川省成都市郫县天辰路', '30.738939', '103.978869', '0', '0', '', '全国', '1459321910');
INSERT INTO `tc_share` VALUES ('14', '0', '20000000', '2', '', '', '[emoji_88][emoji_88][emoji_88]人\n\n\n\n\n\n\n[emoji_340][emoji_340][emoji_340][emoji_340]什么情况', '', '', '四川省成都市郫县天辰路', '30.738939', '103.978869', '0', '0', '', '全国', '1459322048');
INSERT INTO `tc_share` VALUES ('15', '0', '20000002', '2', '', '', '有意思[emoji_13]', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160330/365435c4c92ad94d.jpg\",\"smallUrl\":\"/Uploads/Picture/20160330/s_365435c4c92ad94d.jpg\",\"id\":\"e9e673bc9ad7b0466fe19137a1804e74\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20160330/d33da133ab9654f4.jpg\",\"smallUrl\":\"/Uploads/Picture/20160330/s_d33da133ab9654f4.jpg\",\"id\":\"5fd763068cb58088302334dfd00b745c\"},{\"key\":\"images3\",\"originUrl\":\"/Uploads/Picture/20160330/4f87f663b38ee80e.jpg\",\"smallUrl\":\"/Uploads/Picture/20160330/s_4f87f663b38ee80e.jpg\",\"id\":\"ce2d056aac5dd0f751d5a9560da75047\"},{\"key\":\"images4\",\"originUrl\":\"/Uploads/Picture/20160330/ec9487f759487988.jpg\",\"smallUrl\":\"/Uploads/Picture/20160330/s_ec9487f759487988.jpg\",\"id\":\"8da61b5197192c22f0df40de52632009\"},{\"key\":\"images5\",\"originUrl\":\"/Uploads/Picture/20160330/e0b88908a79f1d2d.jpg\",\"smallUrl\":\"/Uploads/Picture/20160330/s_e0b88908a79f1d2d.jpg\",\"id\":\"4def49116662fcc0d43639ce02f8c087\"},{\"key\":\"images6\",\"originUrl\":\"/Uploads/Picture/20160330/5b885c324ab551eb.jpg\",\"smallUrl\":\"/Uploads/Picture/20160330/s_5b885c324ab551eb.jpg\",\"id\":\"c3cc5352cd918333eb67083d9babf269\"}]', '', '云南省昆明市盘龙区G56(杭瑞高速公路)', '25.106872', '102.779694', '0', '0', '', '全国', '1459346397');
INSERT INTO `tc_share` VALUES ('16', '0', '20000002', '2', '', '', '分享图片', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160330/1616cb91eee36f13.jpg\",\"smallUrl\":\"/Uploads/Picture/20160330/s_1616cb91eee36f13.jpg\",\"id\":\"3818b5206e5190b6261384b98212b9d2\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20160330/327ae5120af1bd8e.jpg\",\"smallUrl\":\"/Uploads/Picture/20160330/s_327ae5120af1bd8e.jpg\",\"id\":\"83ad2f8a994d589df681043b6e35ae4d\"},{\"key\":\"images3\",\"originUrl\":\"/Uploads/Picture/20160330/f0f1ffd2d80cf3da.jpg\",\"smallUrl\":\"/Uploads/Picture/20160330/s_f0f1ffd2d80cf3da.jpg\",\"id\":\"49429510458dcfe1a46bac71c2fc6976\"}]', '', '云南省昆明市盘龙区G56(杭瑞高速公路)', '25.106872', '102.779694', '1', '0', '', '全国', '1459346420');
INSERT INTO `tc_share` VALUES ('18', '0', '20000002', '0', '1', '', '先不要看答案哦！测测你是什么性格的人！真的太准了！！！有一棵很高很高的椰树，下面有分别有四种动物，猩猩、人猿、猴子、金刚，爬到树上摘香蕉，你认为哪个先摘到？你是哪种性格的人呢！。选好再看答案！！很准的！！\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n.\n 答案是：          \n1、选猴子是最典型的250；         \n2、选猩猩是少根筋的弱智；          \n3、选人猿是老年痴呆前兆；          \n4、选金刚是脑袋被门夹了的蠢蛋；          \n别问为什么！          你见过椰子树长香蕉么？..真傻！中招的转！！继续挖坑！愚人节快乐！！嘿嘿', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160401/a4ffb187a15441ec.jpg\",\"smallUrl\":\"/Uploads/Picture/20160401/s_a4ffb187a15441ec.jpg\",\"id\":\"e5646a27626b8b12ea27943cae605c1b\"}]', '', '云南省昆明市盘龙区G56(杭瑞高速公路)', '25.106859', '102.779681', '0', '0', '', '全国', '1459521061');
INSERT INTO `tc_share` VALUES ('19', '18', '20000000', '1', '', '', '不错', '', '', '草街子', '31.355484', '107.741802', '1', '1', '', '全国', '1459836807');
INSERT INTO `tc_share` VALUES ('20', '0', '20000002', '1', '', '', '昨天〈中国好歌曲〉和〈我是歌手〉同时总决赛，〈我是歌手〉年年都会被吐槽，我是真不想再说什么了，商业味是越来越浓，歌手就在那矫情卖弄......[emoji_346][emoji_346][emoji_346]。还是对〈中国好歌曲〉的中国原创赞一个，愿越走越好，这才是希望所在[emoji_13][emoji_13][emoji_13]', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160409/b527c9e00232d770.jpg\",\"smallUrl\":\"/Uploads/Picture/20160409/s_b527c9e00232d770.jpg\",\"id\":\"18576b859e4e1f23485c50b6f5c5313b\"}]', '', '云南省昆明市盘龙区G56(杭瑞高速公路)', '25.106859', '102.779667', '1', '0', '', '全国', '1460206271');
INSERT INTO `tc_share` VALUES ('21', '0', '20000002', '0', '1', '', '也来点鸡汤吧——\n\n你若成功了，放屁都有道理；你若失败了，再有道理都是放屁。\n\n不要随便的把自己心里的伤口给别人看，因为这个社会上你根本就分不清~哪些人给你撒的是云南白药，哪些人给你撒的是盐。\n\n狼若回头，必有缘由，不是报恩，就是报仇。\n\n事不三思终有败，人能百忍则无忧。\n\n越牛逼的人越谦虚，越没本事的人越装逼。\n\n记住，可以哭，可以恨，但是不可以不坚强，你必须非常努力，因为后面有一群人在等着看你的笑话。\n\n要想人前显贵，就得背后遭罪。\n\n最穷不过要饭，不死终会出头！', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160410/287c242ff7a94085.jpg\",\"smallUrl\":\"/Uploads/Picture/20160410/s_287c242ff7a94085.jpg\",\"id\":\"17319183089407df21b3d5e9b3f133a4\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20160410/32f06cc1b3eaf3ea.jpg\",\"smallUrl\":\"/Uploads/Picture/20160410/s_32f06cc1b3eaf3ea.jpg\",\"id\":\"d0de618b109c2d7fde11bcbfae6b9c23\"}]', '', '云南省昆明市盘龙区G56(杭瑞高速公路)', '25.106866', '102.779654', '0', '0', '', '全国', '1460287850');
INSERT INTO `tc_share` VALUES ('22', '0', '20000002', '0', '1', '', '能数出有多少个3吗', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160417/c2aceb9e1111d130.jpg\",\"smallUrl\":\"/Uploads/Picture/20160417/s_c2aceb9e1111d130.jpg\",\"id\":\"bdc6a8e2035a664c9a78cebbb4d32397\"}]', '', '云南省昆明市五华区小康南路69号', '25.101396', '102.742109', '2', '0', '', '全国', '1460887332');
INSERT INTO `tc_share` VALUES ('23', '0', '20000002', '0', '1', '', '这么说，我还是中年人[emoji_86][emoji_86][emoji_86]——\n\n总部设于瑞士日内瓦的联合国世界卫生组织，经过对全球人体素质和平均寿命进行测定，对年龄划分标准作出了新的规定。\n\n该规定将人的一生分为五个年龄段，即：\n\n未成年人：0至17岁；\n青年人：18岁至65岁；\n中年人：66岁至79岁；\n老年人：80岁至99岁；\n长寿老人：100岁以上。', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160417/cd4a7ff4782796de.jpg\",\"smallUrl\":\"/Uploads/Picture/20160417/s_cd4a7ff4782796de.jpg\",\"id\":\"8a028b690ec6602d5c74803bb4cf5ea2\"}]', '', '云南省昆明市五华区霖雨路288', '25.101066', '102.742450', '0', '0', '', '全国', '1460890815');
INSERT INTO `tc_share` VALUES ('27', '0', '20000017', '0', '3', '', '今天', '', '', '成都市', '30.739021', '103.978744', '0', '0', '', '成都市', '1461570859');
INSERT INTO `tc_share` VALUES ('29', '0', '20000017', '16', '', '', '3333', '', '', '成都市', '30.739021', '103.978744', '1', '0', '', '成都市', '1461570921');
INSERT INTO `tc_share` VALUES ('32', '0', '20000002', '2', '', '', '年度最佳微小说《宽容》，72字\n\n娃儿拿回成绩单。\n老爸：数学0分，语文1分？\n娃儿点点头，颤抖中...…\n空气凝结，气氛无比恐怖，\n感觉大事不妙\n老爸深吸一口旱烟，\n说道：崽，你有点偏文科哟！', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160425/433007d379cf6009.jpg\",\"smallUrl\":\"/Uploads/Picture/20160425/s_433007d379cf6009.jpg\",\"id\":\"648a701481e05b56b42fc92f6f211812\"}]', '', '云南省昆明市盘龙区G56(杭瑞高速公路)', '25.106841', '102.779650', '2', '0', '', '全国', '1461593047');
INSERT INTO `tc_share` VALUES ('36', '0', '20000010', '0', '4', '', '车上OMG你哦', '', '', '东乡镇东南卫生院', '31.357673', '107.747003', '2', '0', '', '达州市', '1461639797');
INSERT INTO `tc_share` VALUES ('39', '32', '20000000', '1', '', '', '的', '', '', '东乡镇东南卫生院', '31.357673', '107.747003', '0', '1', '', '全国', '1461829900');
INSERT INTO `tc_share` VALUES ('40', '0', '20000000', '0', '7', '', '你好', '', '', '羊西北加油站', '30.739308', '103.977533', '1', '0', '', '全国', '1461836628');
INSERT INTO `tc_share` VALUES ('41', '12', '20000002', '2', '', '', '呵呵[emoji_85][emoji_85][emoji_85]', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160429/f40d58dbde020409.jpg\",\"smallUrl\":\"/Uploads/Picture/20160429/s_f40d58dbde020409.jpg\",\"id\":\"f34e7fedb7093bb8ed2c42bd4afdf723\"}]', '', '全国', '25.106838', '102.779721', '0', '1', '', '全国', '1461895664');
INSERT INTO `tc_share` VALUES ('42', '0', '20000025', '1', '', '', '蒜你狠卷土重来：各地蒜价猛涨 \n\n早在2010年，蔬菜市场上的新名词流行起来：“姜你军”“蒜你狠”“糖高宗”“向前葱”和“豆你玩”之类，时隔6年后，“蒜你狠”再现江湖，各地叫苦不迭。\n\n北京新发地蔬菜批发市场大蒜批发价格达到了每斤6.7元，而在去年7月大蒜入库之时，每斤仅2.5元。而在上海，很多摊主已经将蒜头的最高售价提高至12元/斤，突破6年前10元/斤的最高价位。\n\n最离谱的山东，目前大蒜价格已达到20元一斤。顾客在一家小店吃饭，无论是吃包子还是饺子，都不再有免费的大蒜可吃。您非要吃不可？好，到服务台买，一元钱一头。问店家为何不送？答案是一头蒜一块多，实在是送不起了。\n\n另外吉林长春，江西南昌、广州番禹等地，也有曝出“蒜你狠”的消息，大蒜价格普遍上涨了2至3倍。\n\n市民这边叹蒜价太高，而大蒜商人这边则是笑容满面。“去年囤大蒜的，今年都赚到了钱，每吨最少也能净赚4000多块钱。”北京新发地市场，第一年囤大蒜就赚到钱的小李在记者面前难掩自己的得意，“我第一次进入蒜市，去年只存了1000吨，春节前全部出清，那时最高1万多出的，你自己算吧。”[emoji_96][emoji_96][emoji_96]', '[{\"key\":\"images\",\"originUrl\":\"/Uploads/Picture/20160429/21d37b3034bb63d4.png\",\"smallUrl\":\"/Uploads/Picture/20160429/s_21d37b3034bb63d4.png\",\"id\":\"1792400cedffe10de2fc3c0741ec95c4\"}]', '', '清水木华', '25.106692', '102.773840', '0', '0', '', '昆明市', '1461906824');
INSERT INTO `tc_share` VALUES ('43', '0', '20000000', '3', '', '', '哦考虑考虑啦啦啦咯哦哦哦考虑考虑啦啦啦咯哦哦哦考虑考虑啦啦啦咯哦哦哦考虑考虑啦啦啦咯哦哦哦考虑考虑啦啦啦咯哦哦哦考虑考虑啦啦啦咯哦哦哦考虑考虑啦啦啦咯哦哦哦考虑考虑啦啦啦咯哦哦哦考虑考虑哦考虑考虑啦啦啦咯哦哦哦考虑考虑啦啦啦咯哦哦哦考虑考虑啦啦啦咯哦哦啦啦咯哦哦哦考虑考虑啦啦啦咯哦哦哦考虑考虑啦啦啦咯哦哦哦考虑考虑啦啦啦咯哦哦', '', '', '全国', '30.739108', '103.978697', '0', '0', '', '全国', '1462533018');
INSERT INTO `tc_share` VALUES ('44', '41', '20000000', '1', '', '', '哦考虑考虑啦啦啦咯哦哦哦考虑考虑啦啦啦咯哦哦哦考虑考虑啦啦啦咯哦哦哦考虑考虑啦啦啦咯哦哦哦考虑考虑啦啦啦咯哦哦哦考虑考虑啦啦啦咯哦哦哦考虑考虑啦啦啦咯哦哦哦考虑考虑啦啦啦咯哦哦哦考虑考哦考虑考虑啦啦啦咯哦哦哦考虑考虑啦啦啦咯哦哦哦考虑考虑啦啦啦咯哦哦啦啦啦咯哦哦哦考虑考虑啦啦啦咯哦哦哦考虑考虑啦啦啦咯哦哦哦考虑考虑啦啦啦咯哦哦哦考虑考虑啦啦啦咯哦哦哦考虑考虑啦啦啦咯哦哦哦考虑考虑啦啦啦咯哦哦考虑考虑啦啦啦咯哦哦哦考虑考虑啦啦啦咯哦哦哦考虑考虑啦啦啦咯哦哦哦考虑考虑啦啦啦咯哦哦哦考虑考虑啦啦啦咯哦哦哦考虑考虑啦啦啦咯哦哦', '', '', '全国', '30.739108', '103.978697', '0', '1', '', '全国', '1462533051');
INSERT INTO `tc_share` VALUES ('45', '44', '20000000', '2', '', '', '哦扣扣悟空哦扣扣悟空哦哦扣扣悟空哦扣扣悟空哦扣扣悟空哦扣扣悟空扣哦扣扣悟空哦扣扣悟空哦扣扣悟空哦扣扣悟空空哦扣扣悟空哦扣扣悟空哦扣扣悟空哦扣扣悟空扣哦扣扣悟空哦扣扣悟空哦哦扣扣悟空哦扣扣悟空哦扣扣悟空哦扣扣悟空扣哦扣扣悟空哦扣扣悟空哦扣扣悟空哦扣扣悟空空哦扣扣悟空哦扣哦扣扣悟空哦扣扣悟空哦哦扣扣悟空哦扣扣悟空哦扣扣悟空哦扣扣悟空扣哦扣扣悟空哦扣扣悟空哦扣扣悟空哦扣扣悟空空哦扣扣悟空哦扣扣悟空哦扣扣悟空哦扣扣悟空扣扣悟空悟空哦扣扣悟空哦扣扣悟空扣扣悟空悟空哦扣扣悟空哦扣扣悟空哦哦扣扣悟空哦扣扣悟空哦扣扣悟空哦扣扣悟空扣哦扣扣悟空哦扣扣悟空哦扣扣悟空哦扣扣悟空空哦扣扣悟空哦扣扣悟空哦扣扣悟空哦扣扣悟空扣哦扣扣悟空哦扣扣悟空哦哦扣扣悟空哦扣扣悟空哦扣扣悟空哦扣扣悟空扣哦扣扣悟空哦扣扣悟空哦扣扣悟空哦扣扣悟空空哦扣扣悟空哦扣哦扣扣悟空哦扣扣悟空哦哦扣扣悟空哦扣扣悟空哦扣扣悟空哦扣扣悟空扣哦扣扣悟空哦扣扣悟空哦扣扣悟空哦扣扣悟空空哦扣扣悟空哦扣扣悟空哦扣扣悟空哦扣哦扣扣悟空哦扣扣悟空哦哦扣扣悟空哦扣扣悟空哦扣扣悟空哦扣扣悟空扣哦扣扣悟空哦扣扣悟空哦扣扣悟空哦扣扣悟空空哦扣扣悟空哦扣扣悟空哦扣扣悟空哦扣扣悟空扣哦扣扣悟空哦扣扣悟空哦哦扣扣悟空哦扣扣悟空哦扣扣悟空哦扣扣悟空扣哦扣扣悟空哦扣扣悟空哦扣扣悟空哦扣扣悟空空哦扣扣悟空哦扣哦扣扣悟空哦扣扣悟空哦哦扣扣悟空哦扣扣悟空哦扣扣悟空哦扣扣悟空扣哦扣扣悟空哦扣扣悟空哦扣扣悟空哦扣扣悟空空哦扣扣悟空哦扣扣悟空哦扣扣悟空哦扣扣悟空扣扣悟空悟空哦扣扣悟空哦扣哦扣扣悟空哦扣扣悟空哦哦扣扣悟空哦扣扣悟空哦扣扣悟空哦扣扣悟空扣哦扣扣悟空哦扣扣悟空哦扣扣悟空哦扣扣悟空空哦扣扣悟空哦扣扣悟空哦扣扣悟空哦扣扣悟空扣哦扣扣悟空哦扣扣悟空哦哦扣扣悟空哦扣扣悟空哦扣扣悟空哦扣扣悟空扣哦扣扣悟空哦扣扣悟空哦扣扣悟空哦扣扣悟空空哦扣扣悟空哦扣哦扣扣悟空哦扣扣悟空哦哦扣扣悟空哦扣扣悟空哦扣扣悟空哦扣扣悟空扣哦扣扣悟空哦扣扣悟空哦扣扣悟空哦扣扣悟空空哦扣扣悟空哦扣扣悟空哦扣扣悟空哦扣扣悟空扣扣悟空悟空哦扣扣悟空哦扣扣悟空扣扣悟空悟空悟空扣扣悟空悟空悟空扣扣悟空悟空哦扣扣悟空哦扣扣悟空扣扣悟空悟空', '', '', '全国', '30.739079', '103.978738', '0', '1', '', '全国', '1462533347');
INSERT INTO `tc_share` VALUES ('46', '0', '20000002', '13', '', '', '[emoji_96][emoji_96][emoji_96]', '', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160506/c440ec716cae3cf9.jpg\",\"smallUrl\":\"/Uploads/Picture/20160506/s_c440ec716cae3cf9.jpg\",\"id\":\"fe803b9198457b2cdf7cc241b7024090\"},{\"originUrl\":\"/Uploads/Picture/20160506/4b2b44ba8f8ab2c0.mp4\",\"smallUrl\":\"/Uploads/Picture/20160506/4b2b44ba8f8ab2c0.mp4\",\"id\":\"002738a20148b9407adfb7e7cc9c06a5\",\"key\":\"video\"}]', '云南省昆明市盘龙区G56(杭瑞高速公路)', '25.106847', '102.779670', '1', '0', '', '全国', '1462546553');
INSERT INTO `tc_share` VALUES ('47', '0', '20000010', '0', '4', '', '在魏泽西事件发生之后，我们有必要探讨下民营医疗所面临的发展困境。据新京报记者梳理，2015年，34家挂牌民营医疗企业的企业平均毛利率为49.79%，同年A股医药行业企业毛利率为46.35%，这34家企业实现2.743亿元净利润，同期广告费支出高达2.738亿元，可以说是为他人打工。2014年，民营医院的诊疗人数为3.25亿人次，较2005年增长近5倍。但同年公立医院的诊疗人数超过25亿人次；公立医院一号难求新闻屡见报端，民营医院则以过半体量仅占总诊疗数比重一成。\n\n这几组数据充分说明了问题所在：目前民营医疗在行业中仍然处于相对弱势位置，广大患者的第一选择往往是公立医院。民营医院依赖于广告营销所主导的引流模式，这又造成了广告费用的高支出。尤其是在百度的竞价排名模式下，民营医院的经营净利大部分被用来支付广告费，一些民营医院靠捞偏门、过度医疗等方式提高盈利，导致声誉更加受损，形成行业日渐污名化的恶性循环。\n\n因此，破解民营医院的发展困境，需要更为严厉到位的制度监管。对于那些明显违背法律法规、严重损害消费者权益的“老鼠屎”，监管部门必须予以零容忍。不如此，就无法改变劣币淘汰良币的酱缸生态。\n\n而容易被监管部门所忽视的，是对民营医院的制度激励也要强化。与中国不同，在美国，民营医院数量占医院总数的比例从1975年的57.49%上升到2005年的66.47%，提供了全美82.42%的住院服务和72.39%的门诊服务，成为整个医疗体系的主流。\n\n美国民营医疗之所以发展迅猛，离不开政府的支持。美国营利性医院享受部分税收优惠，非营利性医院则能够享受全额免税政策。税收杠杆激发了美国民营医疗的发展潜能。\n\n而在我国，民营医院只能在一段时间内享受免税政策，目前虽然营利性医院的营业税免了，但所得税仍高达25%。与此形成反差的是，公立医院还享受着国家的科研资金补助，民营医院却很难分上一杯羹。', '', '', '东乡镇东南卫生院', '31.357673', '107.747003', '1', '0', '', '达州市', '1462772003');
INSERT INTO `tc_share` VALUES ('48', '0', '20000000', '0', '2', '', '大家好', '', '', '羊西北加油站', '30.739308', '103.977533', '2', '0', '', '全国', '1462774342');
INSERT INTO `tc_share` VALUES ('49', '48', '20000017', '2', '', '', 'ghhh', '', '', '全国', '30.738992', '103.978817', '0', '1', '', '全国', '1462774420');
INSERT INTO `tc_share` VALUES ('50', '0', '20000017', '0', '3', '', '一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十啊啊啊慷慨解囊', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160509/64748cab3c6f5c10.jpg\",\"smallUrl\":\"/Uploads/Picture/20160509/s_64748cab3c6f5c10.jpg\",\"id\":\"0a81a5593e8daa963c3160369e219637\"}]', '', '全国', '30.738992', '103.978817', '1', '0', '', '全国', '1462774693');
INSERT INTO `tc_share` VALUES ('51', '0', '20000017', '0', '3', '', '一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十 一二三四五六七八九十', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160509/9b48009835037100.jpg\",\"smallUrl\":\"/Uploads/Picture/20160509/s_9b48009835037100.jpg\",\"id\":\"83d10a37bf2e570fa6c8fdb799c10ac5\"}]', '', '全国', '30.738992', '103.978817', '1', '0', '', '全国', '1462774736');
INSERT INTO `tc_share` VALUES ('52', '0', '20000010', '0', '4', '', '在魏泽西事件发生之后，我们有必要探讨下民营医疗所面临的发展困境。据新京报记者梳理，2015年，34家挂牌民营医疗企业的企业平均毛利率为49.79%，同年A股医药行业企业毛利率为46.35%，这34家企业实现2.743亿元净利润，同期广告费支出高达2.738亿元，可以说是为他人打工。2014年，民营医院的诊疗人数为3.25亿人次，较2005年增长近5倍。但同年公立医院的诊疗人数超过25亿人次；公立医院一号难求新闻屡见报端，民营医院则以过半体量仅占总诊疗数比重一成。\n\n这几组数据充分说明了问题所在：目前民营医疗在行业中仍然处于相对弱势位置，广大患者的第一选择往往是公立医院。民营医院依赖于广告营销所主导的引流模式，这又造成了广告费用的高支出。尤其是在百度的竞价排名模式下，民营医院的经营净利大部分被用来支付广告费，一些民营医院靠捞偏门、过度医疗等方式提高盈利，导致声誉更加受损，形成行业日渐污名化的恶性循环。\n\n因此，破解民营医院的发展困境，需要更为严厉到位的制度监管。对于那些明显违背法律法规、严重损害消费者权益的“老鼠屎”，监管部门必须予以零容忍。不如此，就无法改变劣币淘汰良币的酱缸生态。\n\n而容易被监管部门所忽视的，是对民营医院的制度激励也要强化。与中国不同，在美国，民营医院数量占医院总数的比例从1975年的57.49%上升到2005年的66.47%，提供了全美82.42%的住院服务和72.39%的门诊服务，成为整个医疗体系的主流。\n\n美国民营医疗之所以发展迅猛，离不开政府的支持。美国营利性医院享受部分税收优惠，非营利性医院则能够享受全额免税政策。税收杠杆激发了美国民营医疗的发展潜能。\n\n而在我国，民营医院只能在一段时间内享受免税政策，目前虽然营利性医院的营业税免了，但所得税仍高达25%。与此形成反差的是，公立医院还享受着国家的科研资金补助，民营医院却很难分上一杯羹。', '', '', '东乡镇东南卫生院', '31.357673', '107.747003', '0', '0', '', '达州市', '1462775243');
INSERT INTO `tc_share` VALUES ('53', '0', '20000000', '1', '', '', '特勒925hhjhhcgghjjjjjhghjjujjj[emoji_86][emoji_86][emoji_86][emoji_86][emoji_86][emoji_86][emoji_86][emoji_86][emoji_86][emoji_86]', '', '', '全国', '30.739130', '103.978689', '0', '0', '', '全国', '1462775882');
INSERT INTO `tc_share` VALUES ('54', '0', '20000000', '3', '', '', 'jjjhgggghhggfgggggggjjjhgggghhggfgggggggjjjhgggghhggfgggggggjjjhgggghhggfgggggggjjjhgggghhggfgggggggjjjhgggghhggfggggggg[emoji_87][emoji_87][emoji_87][emoji_87][emoji_87][emoji_87]', '', '', '全国', '30.739130', '103.978689', '0', '0', '', '全国', '1462775915');
INSERT INTO `tc_share` VALUES ('55', '0', '20000000', '2', '', '', '[emoji_88][emoji_88][emoji_88][emoji_88][emoji_88][emoji_88][emoji_88][emoji_88][emoji_88]', '', '', '全国', '30.739066', '103.978739', '0', '0', '', '全国', '1462781273');
INSERT INTO `tc_share` VALUES ('56', '0', '20000000', '0', '2', '', '一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十和姐姐七八九十', '', '', '羊西北加油站', '30.739308', '103.977533', '1', '0', '', '全国', '1462790185');
INSERT INTO `tc_share` VALUES ('57', '0', '20000025', '2', '', '', '15个爆笑经济学段子，也让你涨涨财识！\n\n        1、交易学与择偶观\n\n　　假如把男人、女人分为ABCD四种优秀程度，那现在的现状就是，A男想找B女，B男想找C女，C男找D女，所以D男就剩了。反之，女人方面却不同，即是，ABCD女都想找A男。最后结果是剩下A女和D男。\n\n　　经济学里有个案例：两个人在森林里遇到一只熊，那么对手不会是熊！只要比另一个人快一步就胜利。\n\n　　2、博弈论与追女生\n\n　　如四个男生都去追一个漂亮女生，那她一定会摆足架子，谁也不答理；这时男生再去追别的女孩，别人也不会接受，因为没人愿当次品。但是，如果他们四个先追其她女生，那个漂亮女孩就会被孤立，这时再追她就简单多了。\n\n　　这就是数学家纳什，关于博弈论最简单表述。\n\n　　3、“天下没有免费的午餐”由来\n\n　　这句话最早由经济学家弗里德曼提出来。它的本义是即使您不用付钱吃饭，可您还是要付出代价的。因为您吃这顿饭的时间，可以用来做其他事情，比如谈一笔100万的生意，您把时间用于吃这顿饭，就失去了这些本来能有的价值。\n\n　　这，就是对于机会成本朴素的概念。\n\n　　4、笑话经济学\n\n　　课堂上，教授讲授经济学：“何谓第一产业？喂牛，养羊。何谓第二产业？杀牛，宰羊。何谓第三产业？吃牛肉，喝羊汤。”有学生问：“那么，文化产业呢？”\n\n　　教授眼睛一亮：“问得好！不愧是俺的好学生。”然后回答：“所谓文化产业，就是吹牛皮，出羊相！＂5、有个说法叫“穷人税”\n\n　　最典型的是买彩票的人大多都是穷人(经常买彩票的人请不要介意)，这是他们承受能力和支付能力范围以内能够实现财富剧增的少有机会，但中奖毕竟是小概率，长期以往，细水长流(不过是往外流)，出得多、进得少，就权当缴税了。\n\n　　6、帕累托分布\n\n　　把全世界每个人拥有的财富从大到小排起来，一边是一个纤细但高耸入云的头，另一边是漫长的一望无际，低矮的让人绝望的尾。\n\n　　这样的分布，在经济学里被灌名为“帕累托分布”。\n\n　　7、无利润投资\n\n　　请举例说明什么叫无利润投资，经济学教授提问。\n\n　　“带自己的妹妹出去玩！”，一个男学生抢答道。\n\n　　8、幸福公式\n\n　　经济学中有个公式：幸福=效用：期望值。如果您男友发奖金，拿到1000块，可您期望他给自己买10000块的LV包，1000除以10000，幸福感只有0.1。但如果您的期望是让男友请自己吃顿200块的西餐，1000除以200，幸福感是5。\n\n　　要获得爱情中的幸福，最好不要让欲望影响您的生活。\n\n　　9、长线投资\n\n　　一小女孩拿着三角钱来到瓜园买瓜，瓜农见她钱太少，便想糊弄小姑娘离开，指着一个未长大的小瓜说：“三角钱只能买到那个小瓜”，小女孩答应了，兴高采烈的把钱递给瓜农，瓜农很惊讶：“这个瓜还没熟，您要它怎么吃呢？”小女孩：“交上钱这瓜就属于我了，等瓜长大熟了我再来取吧。”\n\n　　10、快乐VS痛苦\n\n　　一次捡￥75，和先捡￥50后捡￥25，选哪个？一次丢￥75，和先丢￥50再丢￥25，选哪个？实验证明，绝大多数人选分开捡￥75，一起丢￥75。\n\n　　这，就是经济学的快乐痛苦的原则：n个好消息要分开发布；n个坏消息要一起发布；一个大的坏消息和一个小的好消息，分别公布；一个大的好消息和一个小的坏消息，一起公布。\n\n　　11、什么是投行？\n\n　　有一个投行菜鸟问，什么是投行？前辈拿了一些烂水果问他：“您打算怎么把这些水果卖出去？”菜鸟想了半天说：“我按照市场价打折处理掉。”\n\n　　这位前辈立刻把头摇得像拨浪鼓一样，然后拿起一把水果刀，把烂水果去皮切块，弄个漂亮的水果拼盘：“这样，按照几十倍的价格卖掉”。\n\n　　12、泡沫经济是如何形成的？\n\n　　当您决定上网聊天，这叫创业；上来一看MM真多，这叫市场潜力大；但GG也不少，这叫竞争激烈；您决定吸引美女眼球，这叫定位；您说您又帅又有钱，这叫炒作；您问“谁想和我聊天”，这叫广告；您又问“有美女吗”，这叫市场调查；有200人同时答“我是美女”，这叫泡沫经济。\n\n　　13、经济学笑话：如果您有2头母牛……\n\n　　美国：卖掉1头母，买回1头公，牛群增长，效益增加，最后卖掉退休。\n\n　　法国：继续罢工，因为您想要得到另外的3头母牛。\n\n　　日本：创造卡通母牛，卖到全世界。\n\n　　德国：基因改造，使母牛能活100岁，日产10桶牛奶。\n\n　　英国：后来都疯了。\n\n　　俄罗斯：数一遍，5头；再数一遍，10头。烦！打开第3瓶伏特加……14、超低价停车\n\n　　富豪到华尔街银行借了5000元贷款，借期为两周，银行贷款须有抵押，他用停在门口的劳斯莱斯做抵押。银行职员将他的劳斯莱斯停在地下车库里，然后借给富豪5000元。\n\n　　两周后富豪来还钱，利息共15元，银行突然职员发现富豪帐上有几百万，问为啥还要借钱？富豪说：停车费15元两周的停车场，在华尔街是永远找不到的！\n\n　　15、人傻、钱多，速去！\n\n　　地球村居民马哈蒂尔找到小区片警格林斯潘报案，说家里东西被偷了，小偷可能是惯犯索罗斯。片警格林斯潘嘿嘿一笑，说：“也不能全怪小偷嘛，应该多从自己身上找原因。谁让您们家的锁好撬呢？”居民马哈蒂尔不满地说：“那小偷怎么不去偷中国和印度呢？”片警格林斯潘叹了一口气，说：“中国和印度的院墙太高了，索罗斯爬进爬出的不方便，要是再摔下来出了人命，不还是我的事吗？”\n\n　　小偷索罗斯在旁边听了之后，冷笑一声：“在他们的院墙上掏几个洞不就解决问题了吗？”片警格林斯潘赶紧看看四周，小声说：“我们已经派保尔森去中国了，听说二零一八年底就可以挖开几个大窟窿。”小偷索罗斯听了大喜，拿出手机就开始给同伴们发短信：“人傻、钱多，速去！', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160510/0fd088082cc20d5c.jpg\",\"smallUrl\":\"/Uploads/Picture/20160510/s_0fd088082cc20d5c.jpg\",\"id\":\"4c37d78c9d78eac86bfc92ace3891539\"}]', '', '云南省昆明市盘龙区G56(杭瑞高速公路)', '25.106853', '102.779685', '1', '0', '', '昆明市', '1462845214');
INSERT INTO `tc_share` VALUES ('58', '0', '20000002', '0', '1', '', '（一） 记者：医生，你说感冒会死人吗？ 医生津津乐道：有可能的。感冒往往是很多危重病的早期表现，多是由于病毒感染所致。而所感染的病毒有嗜心肌的，也有嗜神经的。确实有可能因为病毒感染导致病毒性心肌炎继而发生死亡的。 新闻第二天见报《造谣者何止度娘？庸医蓄意散布恐慌称：感冒只有死路一条》 \n\n（二） 记者：医生，你说感冒会死人吗？ 医生谨小慎微：要看具体病情，有没有诱发肺炎、病毒性心肌炎等并发症，跟个人自身体质，抗病能力这些也有关系，当然如何辅助检查到位，病情诊断明确，治疗措施及时的话，感冒导致死亡的几率很小。 新闻第二天登报《小小感冒成“绝”症：过度医疗贯穿检查、诊断、治疗全过程，不交钱就交命！》 \n\n（三） 记者：医生，你说感冒会死人吗？ 医生深谋远虑：对不起！作为医生，我不能在病历资料不完全的情况下发表个人意见！ 新闻第二天登报《无故剥夺患者知情权，医生守口如瓶为哪般？》 \n\n（四） 记者：医生，你说感冒会死人吗？ 医生诚惶诚恐：按照医院规定，媒体采访要事先联系医院宣传科。 新闻第二天登报《面对舆论监督，医生百般推诿，医疗圈究竟暗藏何种乾坤？》 \n\n（五） 记者：医生，你说感冒会死人吗？ 医生闭口不言：…… 新闻第二天登报《透视医疗乱象：普通感冒诊断，医生竟然一问三不知！》 \n\n（六） 记者：医生，你说感冒会死人吗？ 医生气急怒喷：你们不懂不要乱写，你要是再这么乱写，我就去法院告你！ 新闻第二天登报《唯恐圈内潜规则被曝，医生恼羞成怒威胁媒体!》 \n\n（七） 记者：医生，你说感冒会死人吗？ 医生直接跪了：我求求你别再写了！只要你别再写了，我什么都答应你！ 新闻第二天登报《公然贿赂媒体，医生究竟想隐瞒什么？》 \n\n（八） 记者：医生，你说感冒会死人吗？ 医生彻底被逼疯了。 新闻第二天登报《人在做，天在看！医疗圈内黑幕重重，医生不堪良心谴责精神失常》\n\n[emoji_117][emoji_117][emoji_117]', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160511/29e37fa366d63cf2.jpg\",\"smallUrl\":\"/Uploads/Picture/20160511/s_29e37fa366d63cf2.jpg\",\"id\":\"0c32b785647ddcfae339202141a9f29c\"}]', '', '云南省昆明市盘龙区G56(杭瑞高速公路)', '25.106859', '102.779674', '1', '0', '', '全国', '1462941200');
INSERT INTO `tc_share` VALUES ('59', '0', '20000002', '0', '1', '', '北京中考零分作文，请大家过目！什么仇什么怨！\n\n材料作文：小鸟飞越太平洋\n\n阅读下面的材料，根据要求作文。\n\n有一种鸟，它能够飞行几万公里，飞越太平洋，而它需要的只是一小截树枝。\n\n在飞行中，它把树枝衔在嘴里，累了就把那截树枝扔到水面上，然后飞落到树枝上休息一会儿，饿了就站在树枝上捕鱼，困了就站在树枝上睡觉。谁能想到，小鸟成功地飞越了太平洋，靠的却仅是一小截的树枝。\n\n试想，如果小鸟衔的不是树枝，而是把鸟窝和食物等所有的用品，一股脑儿全带在身上，那小鸟还飞的起来么？\n\n根据上述材料作文，要求自定立意，自拟题目，自选文体（诗歌除外）；不要脱离材料的内容及做含意范围作文，不少于800字。\n\n《我不相信傻鸟的道理》\n\n作为一个理科生，我看到这个题目的时候，立刻石化了。\n\n我很想抽人！很想狠狠地抽命题老师一巴掌——代表我的物理老师。\n\n让一只鸟，叼着树枝飞太平洋——什么样的极品智商才能编出这样的故事呢？\n\n我不知道命题老师的鸟，是如何威猛，是如何神奇。一个正常人的思维却让我不得不怀疑一些东西。我不跟你计较，一个叼着树枝的鸟，如何跟同伴打情骂俏；\n\n我不跟你计较，一个不会游泳的鸟，如何踩着树枝捕鱼;也不跟你计较，太平洋的海浪会不会打翻树枝。我只问你一个问题：\n\n你知道，究竟多大的一根树枝，才可以让一只鸟浮在水面上？\n\n铁丝一样粗的？筷子那样粗的？\n\n找抽的命题老师，请允许我教给你一个关于浮力的公式，如果你想让一块木头能载动一只鸟，那么需要符合如下条件（出于对您智商的尊重，我不使用各种字母）：\n\n木头产生的浮力-木头本身的重力+鸟的重力\n\n为了能让木头发挥最大的作用，我们假设木头恰好被完全踩到水面以下。\n\n那么可以得出这样的结论：\n\n水的密度×木头的体积×重力加速度-木头的密度×木头的体积×重力加速度+鸟的重量×重力加速度\n\n合并同类项并简化之，得出：\n\n木头的体积×(水的密度-木头的密度-鸟的重量\n\n水的密度约为1000千克/立方米，而木头的密度在400-750千克/立方米之间，我们权且当这个鸟很聪明，找了比较轻的一种，木头的密度按500千克/立方米算。\n\n可得出：鸟的重量/木头的体积-500千克/立方米\n\n简单来说，就是这样的结论：\n\n如果鸟是1公斤重，那么，木头的体积-1/500立方米-0。002立方米-2立方分米\n\n2立方分米什么概念呢？——我们常见的砖头，大约两块！！！\n\n一公斤中的鸟什么概念呢?这么说吧，普通的母鸡一般三四斤重，一公斤重的，也就是只小雏鸡。\n\n一只小鸡那样大小的鸟，衔得动两块砖头大小的木块或者说是一个胳膊粗细的木棒吗？就算可以，风对木块的阻力，也会让鸟儿飞到大西洋，而不是太平洋的。\n\n命题老师可能会说他的鸟大，鸟大分量也重啊！那可能要衔的就不是胳膊粗的木棒了，而是一根柱子了。\n\n总之，科学告诉我。不管是什么鸟，都不会选择叼着树枝飞太平洋。如果一定要这么干，肯定是只傻鸟——淹死在太平洋里喂鱼的傻鸟。对于建立在这个傻鸟故事上的傻鸟道理，只有傻鸟才会信。\n\n零分理由：\n第一，此生不按题目要求写作，却举了这么多歪理，态度极不端正；\n第二，对出题老师不尊重，我不知道你的语文老师是谁，我如果知道他是谁，我一定会到他那儿给你说坏话，还有，如果让你的语文老师看到你写的这篇作文，他一定会气得吐血；\n第三，从你的文章可以看出，你是一名很优秀的理科生，所以，我给你零分你也不会少什么，我相信你在数理化考试中完全可以弥补回来。\n\n物理老师表示必须给满分！！！', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160513/358e695fa19655ba.jpg\",\"smallUrl\":\"/Uploads/Picture/20160513/s_358e695fa19655ba.jpg\",\"id\":\"0cabf2ec623ed0b63b9e730c39e9b67d\"}]', '', '云南省昆明市盘龙区G56(杭瑞高速公路)', '25.106958', '102.779742', '0', '0', '', '全国', '1463151112');
INSERT INTO `tc_share` VALUES ('60', '0', '20000025', '3', '', '', '昆明最新一批老赖企业名单大曝光，跟这些人做生意千万要小心！[emoji_96][emoji_96][emoji_96]\n\n昆明高原明珠房地产开发有限公司\n昆明市空宇加油站\n昆明顺达房地产开发有限公司\n昆明高原明珠房地产开发有限公司\n昆明通鑫达经贸有限责任公司\n昆明银健茶业有限公司\n昆明洛羊汽车综合性能检测有限公司\n昆明柱海木业有限公司\n昆明盈捷机动车安全检测有限公司\n昆明晓安拆迁经营有限责任公司\n\n昆明山前有路汽车租赁有限公司\n昆明颐华国际商务酒店有限公司\n昆明金澜财务管理有限公司\n昆明安宁永昌物资经贸集团有限公司\n昆明互映食品有限公司\n昆明碧春食品有限公司\n昆明富维劳务分包有限公司\n昆明俊宏建筑劳务有限公司\n昆明浩磊石材销售有限公司\n昆明甲虫彩印有限公司\n\n昆明源泉甲和传媒有限公司\n昆明恒金寄售行\n昆明佳弼廉良友商贸有限公司\n昆明羽音商贸有限公司\n昆明乐水国际旅行社有限公司\n昆明市宏垅茂商贸有限公司\n昆明汇宝隆酒店有限公司\n昆明迅吉科技有限公司\n昆明华禾酒店管理有限公司\n昆明佳达利房地产开发经营有限公司\n\n昆明世纪华丰基础建设投资有限公司\n昆明安钡佳房地产开发有限公司\n昆明中亘经贸有限公司\n昆明大千运输有限公司\n昆明润威经贸有限公司\n昆明维美房地产经纪有限公司\n昆明上德广告有限公司\n昆明大山土畜产品有限公司\n昆明倬诚保洁服务有限公司\n昆明炳瑞商贸有限公司\n\n昆明环禹物业管理有限公司\n昆明高富旅游度假有限公司\n昆明俊逸物业服务有限公司\n昆明博赢建筑安装工程有限公司\n昆明拓东房地产开发有限公司\n昆明煤炭设计研究院\n昆明新铜城房地产开发有限公司\n昆明融霞炉具有限公司\n昆明筑能建材有限公司\n\n昆明大千运输有限公司驾驶员培训站\n昆明永吴宁日健身有限公司\n昆明市俊杰辉经贸有限责任公司\n昆明翔威泵业制造有限责任公司\n昆明五华玉雕工艺厂\n昆明叁斗家私有限公司\n昆明市东川天荣冶炼有限公司\n昆明好麟景房地产开发经营有限公司\n昆明普南特商贸有限公司\n昆明六合盛塑钢门窗工程有限公司\n\n昆明实干水利工程劳务有限公司\n昆明云祥商业管理有限公司\n昆明图典园林科技有限公司\n昆明粮鼎食品有限公司\n昆明星河地基工程有限公司\n昆明建轩数控机械设备有限公司\n昆明远建房地产开发有限公司\n昆明西山云峰加油站\n昆明同心矿业有限责任公司\n昆明仁维建设集团有限公司\n\n昆明经开区洛羊庆林热镀锌厂\n昆明银汉商贸有限公司\n昆明德联贸易有限公司\n昆明生福包装有限公司\n昆明侨联自平商贸学校\n昆明诺派贸易有限公司\n昆明市官渡区关上镇日新村股份合作社\n昆明市东川区东环采选厂\n昆明千益丰房地产开发经营有限公司\n昆明富坤钻探有限公司\n\n昆明兰博面包工坊食品有限公司\n昆明进荣印务有限公司\n昆明小松制版印刷有限公司\n昆明华卿亿安生物科技有限公司\n昆明勇铭建筑设备租赁有限公司\n昆明市溪嘻山泉有限公司\n昆明博耐商贸有限公司\n昆明长青融资担保有限公司\n昆明豪辉置业有限公司\n昆明市保宇建筑有限公司\n\n昆明市基邦商贸有限公司\n昆明拜迪餐饮服务有限公司\n昆明伊天园饮食服务有限公司\n昆明市建筑安装工程有限责任公司\n昆明博奥融资担保有限公司\n昆明富达房地产开发经营有限公司\n昆明阳光基业股份有限公司\n昆明市宇欧商贸有限公司\n昆明诚赢钢结构制造有限公司\n昆明鼎加物资贸易有限公司\n\n昆明市新河民房地产北市区有限公司\n昆明福比邻酒店管理有限公司\n昆明奥巍工贸有限公司\n昆明和信屋业开发有限责任公司\n昆明市煌达实验学校\n昆明圣堡绿医院\n昆明海兴经贸有限公司\n昆明向日葵房地产营销策划有限公司龙江分公司\n昆明向日葵地产营销策划有限公司\n昆明市阳光基业股份有限公司\n\n昆明龙城办公家具制造有限公司\n昆明嘉悦经贸有限公司\n昆明市鲁化农资有限公司\n昆明凡洲电气工程有限公司\n昆明医科大学海源学院\n昆明摩摩餐饮管理有限公司\n昆明龙海服饰有限公司\n昆明市福保大酒店有限公司\n昆明友家酒店管理有限公司\n\n昆明市华昌饲料有限公司\n昆明食品（集团）金宅房地产开发有限公司\n昆明市西山区欣农小额贷款有限公司\n昆明畅享装饰工程有限公司\n昆明嘉恒房地产开发有限公司\n昆明平商融资担保有限公司\n昆明联航投资有限公司\n昆明荆楚汽贸有限公司\n昆明多乐惠企业管理有限公司\n昆明万腾商贸有限公司\n\n昆明金锦都房地产开发有限公司\n昆明中天世纪房地产经纪有限公司\n昆明市浙江丽水商会\n昆明龙业标准件有限公司\n昆明溢彩印刷有限公司\n昆明市官渡区刚强体育用品经营部\n昆明车都商贸有限公司\n昆明东燃科技开发有限公司\n昆明冠通机电设备安装工程有限公司\n昆明市继洪汽车维修有限责任公司\n\n昆明麒翔思福商贸有限公司\n昆明大森经贸有限公司\n昆明龙恒置地有限公司\n昆明格林科技有限责任公司\n昆明友盟房地产开发有限公司\n昆明荣耀木业有限公司\n昆明奔沃经贸有限公司\n昆明伟昆包装材料有限公司\n昆明圣都娱乐中心\n昆明翰驿商贸有限公司\n\n昆明海龙王泵业电器有限公司\n昆明市官渡区成达建材经营部\n昆明莲华豪源建筑工程有限公司\n昆明隆升科工贸有限公司\n昆明链成金属结构有限公司\n昆明俊地商贸有限公司\n昆明市官渡区雄泰木业制造厂\n昆明赣滇商贸有限公司\n昆明港鑫汽车维修有限公司\n昆明利顺德经贸有限公司\n\n昆明桂美轩食品有限公司\n昆明成宁贸易有限公司\n昆明盈阔金属材料有限公司\n昆明西南广商城有限公司\n昆明双东贸易有限公司\n昆明绍衡物资有限公司\n昆明品锋金属材料有限公司\n昆明林境金属材料有限公司\n昆明红川有色金属冶炼有限公司\n昆明福林堂药业有限公司\n\n昆明思妍丽美容美发有限公司\n昆明思研丽美容美发有限公司\n昆明佳兴泰科技开发有限公司\n昆明天兵建筑劳务分包有限公司\n昆明圣维科技有限公司\n昆明金辉建筑构件工程有限公司\n昆明顺益贸易有限公司\n昆明美格文化传播有限公司\n昆明香水港洗浴服务有限公司\n昆明碧磷矿业有限责任公司\n\n昆明嵩晟达经贸有限公司\n昆明揽得快经济信息咨询有限公司\n昆明南联商贸有限公司\n昆明明丰房地产开发有限公司\n昆明宝农饲料有限公司\n昆明华曼消防设备有限公司\n昆明港麟矿业有限公司\n昆明企联彗星会议会展服务有限公司\n昆明易鼎建材有限公司\n昆明正辰商贸有限责任公司\n\n昆明恒昇运输有限公司\n昆明锦德林业资源开发有限公司\n昆明凤舞文化传播有限公司\n昆明泰中房地产开发经营有限公司\n昆明明睿劳动保障事务代理有限公司\n昆明骏翰钢结构工程有限公司\n昆明五华艾能培训学校\n昆明翰荣轩艺术有限责任公司\n昆明联创世纪企业管理咨询有限公司\n昆明才融寄售行\n\n昆明族驴餐饮管理有限公司\n昆明忠聚科技有限公司\n昆明蓝印广告有限公司\n昆明财兴盛房地产开发有限公司\n昆明东海房地产开发有限公司\n昆明同馨花卉有限公司\n昆明市西山区排灌总站\n昆明兆鑫矿业有限公司\n昆明祥泽商贸有限公司\n昆明钰滇工艺美术品有限公司\n\n昆明洪发房地产开发有限公司\n昆明苏菲雅婚纱时尚摄影有限公司\n昆明宝树飞腾汽车贸易有限公司\n昆明中林恒基建筑装饰工程有限公司\n昆明竞大经贸有限公司\n昆明阳坤物资有限公司\n昆明尊宇房地产开发有限公司\n昆明誉林木金商贸有限公司\n昆明驰华经贸有限公司\n昆明市禄劝矿业有限公司\n\n昆明福立木业有限公司\n昆明维峰电气技术开发有限公司\n昆明林海云霄房地产开发有限公司\n昆明美盈彩印包装有限公司\n昆明绍齐商贸有限公司\n昆明前卫军安危房地产开发有限公司\n昆明丽健康体健身有限公司\n昆明上谷文化传播有限公司\n昆明驰名科技开发有限公司\n昆明森工集团有限公司\n\n昆明碧洁玉商贸有限公司\n昆明鸿乙名业房地产开发经营有限公司\n昆明易正化工有限公司\n昆明瑞飞商贸有限公司\n昆明腾隆寄售行\n昆明双禹经贸有限公司\n昆明市土产日用杂品有限公司\n昆明市市级机关事务管理局\n昆明叁斗商贸有限公司\n\n昆明金色亿佰健身娱乐有限公司\n昆明江泉源建筑劳务有限公司\n昆明全拓房地产开发有限公司\n昆明青旅国际旅游有限公司\n昆明正基房地产有限公司曲靖分公司\n昆明天和实业发展公司\n昆明美丝美容美发有限责任公司\n昆明勒弗尔经贸有限公司\n昆明市基邦希商贸有限公司\n昆明正杰经贸有限公司\n\n昆明芊卉园艺有限公司\n昆明捷通汽车维修服务有限公司\n昆明港昌航经贸有限公司\n昆明福恒建筑工程有限公司\n昆明森虎铝业有限公司\n昆明和谐房地产开发有限公司\n昆明元茂经济信息咨询有限公司\n昆明市诚浩工贸有限公司\n昆明博兰特生物科技有限公司\n昆明豪原特自控有限公司\n昆明昊颐房地产开发有限公司\n\n昆明市宜良进霆房地产有限公司\n昆明市安钡佳房地产开发有限公司\n昆明泰隆华瑞实业有限公司\n昆明科华矿业有限公司\n昆明饰尚装饰工程有限公司\n昆明安城汽车租赁有限公司\n昆明东景园林绿化有限公司\n昆明锦誉房地产经纪有限公司\n昆明学斌商贸有限公司\n昆明金建昆科技有限公司\n\n昆明雄苑经贸有限公司\n昆明泰隆华瑞房地产开发有限公司\n昆明华敏房地产开发有限公司\n昆明潘氏生佳物资贸易有限公司\n昆明淘客科技有限公司\n昆明山创电子有限公司\n昆明市盘龙区苏斯幼儿园\n昆明亚联恒经贸有限公司\n昆明司邦达投资管理有限公司\n昆明江阳建筑劳务有限公司\n昆明宾亚经贸有限公司\n昆明多宇实业有限公司\n\n昆明黄奇教育咨询有限公司\n昆明鹏博网络工程有限公司\n昆明雅比汽车销售有限公司\n昆明千锋汽车服务有限公司\n昆明涌宝工贸有限公司\n昆明瑞箐农业科技开发有限公司\n昆明青鸟餐饮有限公司\n昆明洪棋物业管理有限公司\n昆明市官渡区民政福利印刷厂\n昆明市麟凤通信有限责任公司\n昆明颖洲商贸有限公司\n\n昆明雄基装饰工程有限公司\n昆明市富申农业科技开发有限责任公司\n昆明三恒机械制造有限公司\n昆明扎根商贸有限公司\n昆明市呈贡区龙城街道办事处龙街社区居民委员会\n昆明轿子雪山玛卡生物科技开发有限公司\n昆明闽锡贸易有限公司\n昆明玛诚经贸有限公司\n昆明恩图商贸有限公司\n昆明协鼎商贸有限公司\n\n昆明明投钢材有限公司\n昆明尚宫酒店管理有限公司\n昆明市盘龙区恒兴棕制品厂\n昆明百瑞尔饲料科技有限公司\n昆明纳洋科技有限公司\n昆明德亨房地产开发经营有限公司\n昆明昆汽房地产开发有限公司\n昆明轩群商贸有限公司\n昆明唯雅娱乐有限公司\n昆明天恒歌剧城娱乐有限公司\n\n昆明市白龙山矿业有限公司\n昆明盛世龙吟娱乐有限公司\n昆明盛世金樽娱乐有限公司\n昆明大高挺化妆品销售有限公司\n昆明兴万家商贸有限公司\n昆明一条龙经贸有限责任公司\n昆明恒禧商贸有限公司\n昆明银杰商贸有限公司\n昆明斯尔迪商贸有限公司\n昆明德祥商贸有限公司\n\n昆明千益丰房地产开发有限公司\n昆明煤钢经贸有限公司\n昆明志远国际商贸城经营管理有限公司\n昆明志远国际高贸城经营管理有限公司\n昆明市永坚商品混凝土有限公司\n昆明市泰隆装饰工程有限公司\n昆明兆鼎建材有限公司\n昆明房地产开发有限公司\n昆明广园饭店\n昆明四杰机电有限公司\n昆明振兴业物资贸易有限公司\n昆明芬萌商贸有限公司\n昆明酷悠经贸有限公司\n\n昆明酷悠悠经贸有限公司\n昆明增义广告有限公司\n昆明焦点贸易有限公司\n昆明宜之佳科技有限公司\n昆明玉福汽配有限公司\n昆明贝叶傣医药研究所\n昆明工业制粉有限公司\n昆明汇东电器有限公司\n昆明隆隆科技有限公司\n昆明意中境装饰工程有限公司\n\n昆明郎禾科技有限公司\n昆明茂功光学仪器有限公司\n昆明冉东装饰工程有限公司\n昆明龙桥钢模板有限公司\n昆明志鑫经贸有限公司\n昆明龙之杰实业有限公司\n昆明志弘诚经贸有限公司\n昆明驰飞扬建筑劳务分包有限公司\n昆明鑫实利化工有限责任公司\n昆明龙凯农业科技有限公司\n\n昆明展翅奥海教育信息咨询有限公司\n昆明泽利建筑劳务有限公司\n昆明艾沙科技有限公司\n昆明浩泉商贸有限公司\n昆明德享房地产开发经营有限公司\n昆明大明酒店\n昆明商贸信息学校\n昆明青淼餐饮有限公司\n昆明强润商贸有限公司\n昆明后街娱乐有限公司\n\n昆明俊升装饰设计工程有限公司\n昆明西山明波金城石材工具辅料经营部\n昆明久福商贸有限公司\n昆明畅游国际旅行社有限公司\n昆明昆禄经贸有限责任公司\n昆明达邻商贸有限公司\n昆明逸鉴商贸有限公司\n昆明云程机械设备租赁有限公司\n昆明盛和装饰工程有限公司\n昆明景君经贸有限责任公司\n昆明海边影视文化有限公司\n\n昆明威旺商贸有限公司\n昆明恒誉基础工程有限公司\n昆明市喜乐多商贸有限公司\n昆明市嵩明县人民政府滇源街道办事处\n昆明恒梦商贸有限公司\n昆明宁塑管业制造有限公司\n昆明加鑫农业科技开发有限公司\n昆明市恒畹商贸有限公司\n昆明欧诺矿业有限公司\n昆明滕建商贸有限公司\n昆明聚锋管理咨询有限责任公司\n\n昆明鑫茂工贸有限公司\n昆明亚森教育咨询有限公司\n昆明五华亚森教育培训学校\n昆明椰利家政服务有限公司\n昆明宏嘉数码科技有限公司\n昆明龙盘再生资源实业有限公司\n昆明世好环保工程有限公司\n昆明玉菩堤珠宝有限公司\n昆明群艺建筑工程劳务有限公司\n\n昆明鸿宇鑫颐房地产开发有限公司\n昆明韵涛娱乐服务部\n昆明合力建筑工程有限责任公司\n昆明健盟商务咨询有限公司\n昆明凝水节能环保技术有限公司\n昆明维帝威电控设备有限公司\n昆明凯宏地基工程有限公司\n昆明贝克欧商贸有限公司\n昆明优普饲料有限公司\n\n昆明市嵩明东风水泥厂\n昆明京顺达工贸有限公司\n昆明凯歌生物技术有限公司\n昆明京顺达工贸有限公司和康分公司\n昆明立达物业管理有限公司\n昆明浙瑞商贸有限公司\n昆明沛鑫商贸有限公司\n昆明十良娱乐有限责任公司\n昆明市福昆工贸有限公司\n昆明瑞木环境工程有限公司\n\n昆明福之木业有限公司\n昆明东风之春建筑有限责任公司\n昆明升平建筑劳务有限公司\n昆明财兴盛商贸（集团）有限公司\n昆明英盛机电设备有限公司\n昆明盘通屋业有限公司\n昆明州荣投资有限公司\n昆明乐置业传媒有限公司\n昆明哈喽酒店管理有限公司\n昆明五华易之源教育培训学校\n昆明荣远商贸有限公司\n\n昆明理工峰潮科技有限公司\n昆明晶金科技有限公司\n昆明玻璃股份有限公司\n昆明锦华石化有限责任公司\n昆明双传广告有限公司\n昆明市搬家服务公司\n昆明钢泰钢结构工程有限公司\n昆明市春瑞源工贸有限公司\n昆明青少年活动中心\n昆明永春经贸有限公司\n\n昆明壹嘉陆汽车维修服务有限责任公司\n昆明达州商贸有限公司\n昆明方控自动化工程有限公司\n昆明汇流融资担保有限公司\n昆明盈豪娱乐有限公司\n昆明环球阀门有限公司\n昆明金碧鑫旅游文化资源开发有限公司\n昆明省药材公司\n昆明夜色娱乐有限公司\n昆明鑫沙工贸有限公司\n昆明德展投资有限责任公司\n\n昆明昆南胜利机械化工程有限公司\n昆明西山公路工程有限公司\n昆明市盘龙区楚天实验学校\n昆明奇莹物流有限责任公司\n昆明市滇和典当有限公司\n昆明嘉视电子技术有限公司\n昆明中德秦通科技有限公司\n昆明创意方程式房地产营销策划有限公司\n昆明新煮意餐饮有限公司\n昆明茂裕汇水泥粉磨有限公司\n昆明新乾鑫汽车租赁有限公司\n昆明超润商贸有限公司\n\n昆明国联重科科技有限公司\n昆明志福餐饮有限公司\n昆明诚金万禾企业管理有限公司\n昆明瑞格文化传播有限公司\n昆明巧汇钢结构工程有限公司\n昆明宇乾科贸有限公司\n昆明渝滇娱乐有限公司\n昆明顺善经贸有限公司\n昆明盛湖经贸有限公司\n昆明丽之港洗浴有限公司\n\n昆明兴杰房地产开发有限公司\n昆明凯比斯装饰工程有限公司\n昆明科尔普建筑劳务有限公司\n昆明零点装饰有限公司\n昆明名座娱乐有限公司\n昆明源林湿地项目管理有限公司\n昆明云溪机械制造有限公司\n昆明楷强矿业开发有限公司\n昆明通发实业有限公司\n昆明鑫南标准件有限公司\n\n昆明星月明珠餐饮管理有限公司\n昆明市五华区蒙秦舞台艺术设计工作室\n昆明元鼎建设发展有限公司\n昆明鹏天经贸有限公司\n昆明东方毅拓展文化传播有限公司\n昆明连波建材有限责任公司\n昆明金领经济信息咨询有限公司\n昆明五湖建设工程有限公司\n昆明凯正建筑工程有限公司\n昆明振天环境工程有限公司\n昆明城珍科技有限公司\n\n昆明燕莎餐饮服务有限公司\n昆明凯龙医药有限公司\n昆明云泉汽车服务有限公司\n昆明银燕包装制品有限公司\n昆明雅月阁餐饮有限责任公司\n昆明京瓷建材有限公司\n昆明新榕峰门业有限公司\n昆明满天星花卉有限责任公司\n昆明世华媒讯广告有限公司\n\n昆明城金万禾企业管理有限公司\n昆明立足宇商贸有限公司\n昆明志乙建筑劳务有限公司\n昆明鑫实利化工有责任公司\n昆明大开元商贸有限公司\n昆明世君建材租赁部\n昆明重友建筑机械租赁有限公司\n昆明市富民稀贵金属提炼厂\n昆明普济企业管理有限公司\n昆明云峰公路建设开发有限公司', '', '', '全国', '25.089631', '102.736270', '1', '0', '', '昆明市', '1463276434');
INSERT INTO `tc_share` VALUES ('61', '0', '20000002', '0', '9', '', '终于完工[emoji_370][emoji_370][emoji_370][emoji_13][emoji_13][emoji_13]', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160516/4918a9b2681bada2.jpg\",\"smallUrl\":\"/Uploads/Picture/20160516/s_4918a9b2681bada2.jpg\",\"id\":\"cf59ee74b842bfa10ad3502047b8f5e5\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20160516/eeff5f7aff2b91cf.jpg\",\"smallUrl\":\"/Uploads/Picture/20160516/s_eeff5f7aff2b91cf.jpg\",\"id\":\"28af96ae7d958e40de109628d78ac5a3\"},{\"key\":\"images3\",\"originUrl\":\"/Uploads/Picture/20160516/bccaeb0034cdb3a2.jpg\",\"smallUrl\":\"/Uploads/Picture/20160516/s_bccaeb0034cdb3a2.jpg\",\"id\":\"8c27cd52a922f4b32c939f5edb08002f\"},{\"key\":\"images4\",\"originUrl\":\"/Uploads/Picture/20160516/9df04709a9808076.jpg\",\"smallUrl\":\"/Uploads/Picture/20160516/s_9df04709a9808076.jpg\",\"id\":\"fff851dee34b14cee09592b0c927ffe2\"},{\"key\":\"images5\",\"originUrl\":\"/Uploads/Picture/20160516/ee5d44f7dd8a73c9.jpg\",\"smallUrl\":\"/Uploads/Picture/20160516/s_ee5d44f7dd8a73c9.jpg\",\"id\":\"f19f8c74934e0b130d7e509b7b8380d6\"},{\"key\":\"images6\",\"originUrl\":\"/Uploads/Picture/20160516/54743468963c208e.jpg\",\"smallUrl\":\"/Uploads/Picture/20160516/s_54743468963c208e.jpg\",\"id\":\"c9080fd8384b7c33e5ed0db8c738b03f\"}]', '', '全国', '25.044414', '102.727183', '2', '0', '', '全国', '1463385184');
INSERT INTO `tc_share` VALUES ('62', '0', '20000024', '0', '8', '', '测试', '', '', '草街子', '31.355484', '107.741802', '0', '0', '', '达州市', '1463550449');
INSERT INTO `tc_share` VALUES ('63', '0', '20000010', '0', '4', '', '测试', '', '', '东乡镇东南卫生院', '31.357673', '107.747003', '0', '0', '', '达州市', '1463551280');
INSERT INTO `tc_share` VALUES ('64', '0', '20000010', '0', '4', '', '的', '', '', '东乡镇东南卫生院', '31.357673', '107.747003', '0', '0', '', '达州市', '1463551309');
INSERT INTO `tc_share` VALUES ('65', '0', '20000024', '0', '8', '', '测试', '', '', '东乡镇东南卫生院', '31.357673', '107.747003', '0', '0', '', '达州市', '1463551459');
INSERT INTO `tc_share` VALUES ('66', '0', '20000024', '0', '8', '', '哈哈', '', '', '东乡镇东南卫生院', '31.357673', '107.747003', '0', '0', '', '达州市', '1463552201');
INSERT INTO `tc_share` VALUES ('67', '0', '20000002', '2', '', '', '笑死了[emoji_357][emoji_357][emoji_357]这是个高一孩子的周记，绝的是班主任的回复，更绝的是他母亲的神回复[emoji_13][emoji_13][emoji_13]\n        学生周记：\n        语文是朕的皇后，虽然朕几乎从来不翻她的牌子，可她的地位依然是那么的稳固，英语是朕的华妃，朕其实并不真正爱她，只是因为外戚的缘故总要给她家几分面子，数学是朕的嬛嬛，那年杏花微雨，也许一开始就是错的，体育是朕的纯元皇后，那才是心中的挚爱，至于政治，历史，地理，生物这些卑微的官女子，朕理都懒得理她，到底是谁让她们入宫的！[emoji_354][emoji_354][emoji_354]\n        班主任的回复：\n        老奴三年来战战兢兢、夜不思寐，只为圣上即日面对高考来袭时不至于措手不及，失了往日威风。皇后乃是一宫之主，虽说自幼便与皇上相识，仍需日日沾顾，不可与之疏远；华妃虽是外戚，但时下举国内外以华妃为尊，请圣上务必思忖为善；甄妃敏锐聪颖，若能日日眷顾必能助圣上一臂之力；政治，历史，地理，生物这几位贵妃贵人，圣上更需雨露均沾，高考一战，须靠得这几位主子出力…至于纯元皇后，请圣上听老奴一言，斯人已矣，留于心中有个念想即可～～[emoji_368][emoji_368][emoji_368]\n        母亲回复：\n        汝若继续沉迷追剧穿越宫斗，动摇安身立命之分数，休怪母后断尔wifi，毁尔ipad，追生二胎，动尔储位！[emoji_115][emoji_115][emoji_115]', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160519/ad07118ad052e097.jpg\",\"smallUrl\":\"/Uploads/Picture/20160519/s_ad07118ad052e097.jpg\",\"id\":\"4c5842639017510bc7a77bf7f3fd8811\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20160519/d13517f85df40702.jpg\",\"smallUrl\":\"/Uploads/Picture/20160519/s_d13517f85df40702.jpg\",\"id\":\"e251939406f4aec51f30c291fb63cf5e\"}]', '', '云南省昆明市盘龙区G56(杭瑞高速公路)', '25.106878', '102.779709', '3', '0', '', '全国', '1463620246');
INSERT INTO `tc_share` VALUES ('68', '0', '20000017', '1', '', '', '哩哩啦啦', '', '', '四川省成都市郫县天辰路39', '30.739121', '103.978696', '0', '0', '', '全国', '1463726225');
INSERT INTO `tc_share` VALUES ('69', '0', '20000002', '2', '', '', '老师：为什么520除以3除不尽？\n学生甲：因为爱情是容不下小三的。\n小明说：错，因为小三是永远除不尽的。\n老师说:都给我滚出去！\n[emoji_86][emoji_86][emoji_86][emoji_116][emoji_116][emoji_116]', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160520/6c50db87d2d89bfd.jpg\",\"smallUrl\":\"/Uploads/Picture/20160520/s_6c50db87d2d89bfd.jpg\",\"id\":\"c24811f43553f6055ba7fecd2fd0a7df\"}]', '', '云南省昆明市盘龙区G56(杭瑞高速公路)', '25.106828', '102.779762', '1', '0', '', '全国', '1463754210');
INSERT INTO `tc_share` VALUES ('71', '0', '20000002', '0', '9', '', '外面下了一天的雨[emoji_74]，没事就在家里继续DIY[emoji_154]，其乐无穷[emoji_13][emoji_13][emoji_13]', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160521/ae67f05b97fddd9c.jpg\",\"smallUrl\":\"/Uploads/Picture/20160521/s_ae67f05b97fddd9c.jpg\",\"id\":\"fd99948d4ea238f7a057af3571a41e23\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20160521/a3f7a81bb740cb8d.jpg\",\"smallUrl\":\"/Uploads/Picture/20160521/s_a3f7a81bb740cb8d.jpg\",\"id\":\"9c222b275872a1665068e1eb12468551\"},{\"key\":\"images3\",\"originUrl\":\"/Uploads/Picture/20160521/ba78311c92556bfd.jpg\",\"smallUrl\":\"/Uploads/Picture/20160521/s_ba78311c92556bfd.jpg\",\"id\":\"756273a5b7d7b947b8eed209e9a710c9\"},{\"key\":\"images4\",\"originUrl\":\"/Uploads/Picture/20160521/e685170eb30d02e1.jpg\",\"smallUrl\":\"/Uploads/Picture/20160521/s_e685170eb30d02e1.jpg\",\"id\":\"67e55be291c57f5e5c89d89945133375\"}]', '', '昆明市', '25.106830', '102.779765', '2', '0', '', '全国', '1463839916');
INSERT INTO `tc_share` VALUES ('73', '0', '20000002', '0', '1', '', '好文分享———\n\n胡适、鲁迅、柏杨对中国人的40大批判！\n\n20世纪对中国社会和中国人国民性批判最为猛烈和深刻的，当数胡适、鲁迅、柏杨三人。过去了这么久，回头再看这些批判，会发现依旧让人寒意彻骨、一身冷汗，不仅完全没有过时，而且就像针对当下现实猛烈投出的标枪。\n\n这些批判很刺耳，而逆耳的往往是忠言。让我们再重温一下吧，不是为了别的，只是为了反思和深思。批判永远不是目的而是手段，是为了能够改变、向好。相信这就是三位大家的初心，也是中国社会的方向！\n\n胡适对中国人的10大批判\n\n1、不讲规则\n一个肮脏的国家，如果人人讲规则而不是空谈道德，最终会变成一个有人味儿的正常国家，道德自然会逐渐回归；反之，一个干净的国家，如果人人都不讲规则却大谈道德、谈高尚，天天没事儿就谈道德规范，人人大公无私，最终这个国家会堕落成为一个伪君子遍布的肮脏国家。\n\n2、雅量小，喷子多\n我受了十年的骂，从来不怨恨骂我的人。有时他们骂的不中肯，我反替他们着急。有时他们骂得太过火，反而损害骂者自己的人格，我更替他们不安。如果骂我而使骂者有益，便是我间接于他有恩了，我自然很愿挨骂。\n\n3、堕落\n堕落的方式很多，总括起来，约有这两大类：第一条是容易抛弃学生时代的求知识的欲望。第二条是容易抛弃学生时代的理想的人生的追求。\n\n4、虚伪\n—中国人死了父母，发出讣书，人人都说“泣血稽颡”“苫块昏迷”。其实他们何尝泣血？又何尝“寝苫枕块”？\n—这种自欺欺人的事，人人都以为是“道德”，人人都不以为羞耻。为什么呢？因为社会的习惯如此，所以不道德的也觉得道德了。\n—这种不道德的道德，在社会上，造出一种诈伪不自然的伪君子。面子上都是仁义道德，骨子里都是男盗女娼。\n\n5、畸形的拜金主义\n简单说来，拜金主义只有三个信条：第一，要自己能挣饭吃。第二，不可抢别人的饭吃。第三，要能想出法子来，开出路来，叫别人有挣饭吃的机会。\n\n6、假大空\n多谈些问题，少谈些主义。\n\n7、不敢直面\n明明是男盗女娼的社会，我们偏说是圣贤礼义之邦；明明是赃官污吏的社会，我们偏要歌功颂德；明明是不可救药的大病，我们偏说一点病都没有！却不知道：若要病好，须先认有病；若要政治好，须先认现今的政治实在不好；若要改良社会，须先知道现今的社会实在是男盗女娼的社会。\n\n8、野蛮浅薄\n你要看一个国家的文明，只需考察三件事：第一看他们怎样待小孩子；第二看他们怎样待女人；第三看他们怎样利用闲暇的时间。\n\n9、教育失败\n中国的教育，不但不能救亡，简直可以亡国。中国并不是完全没有进步，不过惰性太大，向前三步又退回两步，所以到如今还是这个样子。\n\n10、没人格\n把自己铸造成器，方才可以希望有益于社会。真实的为我，便是最有益的为人，把自己铸造成了自由独立的人格，你自然会不知足，不满意现状，敢说老实话。\n\n鲁迅对中国人的20大批判\n\n1、冷漠\n在中国，尤其是在都市里，倘使路上有暴病倒地，或翻车捽摔伤的人，路人围观或甚至高兴的人尽有，有肯伸手来扶助一下的人却是极少的。\n\n2、自私自利\n我的经验，是人来要我帮忙的，他用“互助论”；一到不用，或要攻击我了，就用“进化论的生存竞争论”；取去我的衣服，倘向他索还，他就说我是“个人主义”，自私自利，吝啬得很。\n\n3、不尊重女性\n我一向不相信昭君出塞会安汉，木兰从军就可以保隋；也不信妲己亡殷，西施沼吴，杨妃乱唐的那些古老话。我以为在男权社会里，女人是决不会有这种大力量的，兴亡的责任，都应该男的负。但向来的男性的作者，大抵将败亡的大罪，推在女性身上，这真是一钱不值的没有出息的男人。\n\n4、民族主义\n—中国现在的假吉诃德们……他们何尝不知道“国货运动”振兴不了什么民族工业。\n—他们何尝不知道什么“中国固有文化”咒不死帝国主义，无论念几千万遍“不仁不义”或者金光明咒，也不会引发日本地震，使它陆沉大海。然而他们故意高喊恢复“民族精神”，仿佛得了什么祖传秘诀。\n\n5、欺软怕硬\n—可惜中国人但对于羊显凶兽相，而对于凶兽则显羊相，所以即使显凶兽相，也还是卑怯的国民。这样下去，一定要完结的。\n—我想，要中国得救，也不必添甚么东西进去，只要青年们将这两种性质的古传用法，反过来一用就够了：对手如凶兽时就如凶兽，对手如羊时就如羊！\n\n6、不知耻\n战士死了的时候，苍蝇所首先发见的是他的缺点和伤痕，嘬，营营地叫，以为得意，以为比死了的战士更英雄。但是战士已经死了，不再来挥去他们。于是乎苍蝇们即更其营营地叫，自以为倒是不朽的声音，因为他们的完全，远在战士之上。的确的，谁也没有发见过苍蝇们的缺点和创伤。然而，有缺点的战士终竟是战士，完美的苍蝇也终竟不过是苍蝇。\n\n7、国粹主义\n即使无名肿毒，倘若生在中国人身上，也便“红肿之处，艳若桃花；溃烂之时，美如奶酪。”国粹所在，妙不可言。\n\n8、世故\n—耳闻目睹的不算，单是看看报章，也就可以知道社会上有多少不平，人们有多少冤抑。\n—但对于这些事，除了有时或有同业、同乡、同族的人们来说几句呼吁的话之外，利害无关的人的义愤的声音，我们是很少听到的。这很分明，是大家不开口；或者以为和自己不相干；或者连“以为和自己不相干”的意思也全没有。\n—“世故”深到不自觉其“深于世故”，这才真是“深于世故”的了。这是中国处世法的精义中的精义。\n\n9、迂腐折中\n中国人的性情是总喜欢调和折中的，譬如你说，这屋子太暗，须在这里开一个窗，大家一定不允许的。但如果你主张拆掉屋顶他们就来调和，愿意开窗了。\n\n10、没出息\n—中国大约太老了，社会上事无大小，都恶劣不堪，像一只黑色的染缸，无论加进甚么新东西去，都变成漆黑。\n—可是除了再想法子来改革之外，也再没有别的路。\n—我看一切理想家，不是怀念“过去”，就是“希望将来”，而对于“现在”这一个题目，都缴了白卷，因为谁也开不出药方。\n—所有最好的药方即所谓“希望将来”的就是。\n\n11、漠然\n凡有一人的主张，得了赞和，是促其前进的；得了反对，是促其奋斗的；独有叫喊于生人中，而生人并无反应，既非赞同，也无反对，如置身毫无边际的荒原，无可措手的了，这是怎样的悲哀呵……\n\n12、冷血\n中国人自己诚然不善于战争，却并没有诅咒战争；自己诚然不愿出战，却并未同情于不愿出战的他人；虽然想到自己，却没有想到他人的自己。\n\n13、怯弱、懒惰、巧滑\n—中国人的不敢正视各方面，用瞒和骗，造出奇妙的逃路来，而自以为正路。在这路上，就证明着国民性的怯弱、懒惰而又巧滑。一天一天的满足，即一天一天的堕落，但却又觉得日见其光荣。\n—在事实上，亡国一次，即添加几个殉难的忠臣，后来每不想光复旧物，而只去赞美那几个忠臣；遭劫一次，即造成一群不辱的烈女，事过之后，也每每不思惩凶、自卫，却只顾歌咏那一群烈女。\n\n14、麻木者是胜利者\n中国各处是壁，像“鬼打墙”一般，使你随时能“碰”。能打这墙的，能碰而不感到痛苦的，是胜利者。\n\n15、拒绝改变\n我独不解中国人何以于旧状况那么心平气和，于较新的机运就这么疾首蹙额；于已成之局那么委曲求全，于初兴之事就这么求全责备？\n\n16、多疑\n中国人不疑自己的多疑。\n\n17、看热闹\n群众，尤其是中国的──永远是戏剧的看客。牺牲上场，如果显得慷慨，他们就看了悲壮剧；如果显得觳觫（即恐惧颤抖），他们就看了滑稽剧。北京的羊肉铺常有几个人张嘴看剥羊，仿佛颇为愉快，人的牺牲能给他们的益处，也不过如此。而况事后走不几步，他们并这一点也就忘了。\n\n18、懦弱\n中国一向就少有失败的英雄，少有韧性的反抗，少有敢单身鏖战的武人，少有敢抚哭叛徒的吊客；见胜兆则纷纷聚集，见败兆则纷纷逃亡。\n\n19、阴暗\n我们中国人对于不是自己的东西，或者将不为自己所有的东西，总要破坏了才快活的。\n\n20、个人主义\n从生活窘迫过来的人，一到了有钱，容易变成两种情形：一种是理想世界，替处同一境遇的人着想，便成为人道主义；一种是甚么都是自己挣起来，从前的遭遇，使他觉得甚么都是冷酷，便流为个人主义。我们中国大概是变成个人主义者多。\n\n柏杨对中国人的10大批判\n\n1、热衷内斗\n—中国人最拿手的是内斗。有中国人的地方就有内斗，中国人永远不团结，似乎中国人身上缺少团结的细胞。\n—各位在美国更容易体会到这一点：凡是整中国人最厉害的人，不是外国人，而是中国人；凡是出卖中国人的，也不是外国人，而是中国人；凡是陷害中国人的，不是外国人，而是中国人。\n\n2、取媚权势\n呜呼，由于对权势入骨的崇拜，中国同胞是把权势放在第一位，而把伦理放到第二位的。\n\n3、笑贫不笑娼\n在酱缸文化中，只有富贵功名才是“正路”，凡是不能猎取富贵功名的行为，全是“不肯正干”，全是“不走正路”。\n\n4、死不认错\n—中国人不习惯认错，反而有一万个理由，掩盖自己的错误。\n—有一句俗话：“闭门思过。”思谁的过？思对方的过！\n\n5、没有是非\n—中国人最缺乏的，就是社会是非观念。\n—中国人讲的“义”，是用来要求别人而设的，人人都觉得自己是例外，可以不必遵守。\n—也就是说，中国人的“义”是双重标准。\n\n6、好面子\n中国人讲“礼”，却只是虚礼———面子。而“理”则受到压抑，不能伸张。\n\n7、没有心胸\n—中国的面积这么大，文化这么久远，泱泱大国，中国人应该有一个什么样的心胸？应该是泱泱大国的心胸。\n—可是我们泱泱大国民的心胸只能在书上看到，只能在电视上看到。\n—你们看过哪一个中国人有泱泱大国民的胸襟？只要瞪他一眼，马上动刀子。你和他意见不同试一试？\n—洋人可以打一架之后回来握握手，中国人打一架可是一百年的仇恨，三代都报不完的仇恨！为什么我们缺少海洋般的包容性？\n\n8、混子\n不认真，不敬业，悠悠忽忽，吊儿郎当地“混”，是大多数中国人的生活特征。他在人性上形成的畸形心理，令人泪流满面。盖不认真不敬业的结果，必然产生强大的文字魔术欺诈。\n\n9、不敢说真话\n中华民族最大的危机在于做坏事的人多，而肯说直话的人太少。\n\n10、不为别人着想\n我们盼望的是，每个中国人都应有设身处地为别人想一想的教养。珍惜友情，爱护自己所爱的人。……呜呼，别把自己的面子，建立在困扰别人的行为上。', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160527/a91eda5c4854ddd0.jpg\",\"smallUrl\":\"/Uploads/Picture/20160527/s_a91eda5c4854ddd0.jpg\",\"id\":\"5626cf3e73e07a6c53abdb6d44806c7c\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20160527/367d4aba6b82649f.jpg\",\"smallUrl\":\"/Uploads/Picture/20160527/s_367d4aba6b82649f.jpg\",\"id\":\"029f72e5bd0849751fe1ef73ac12a81c\"},{\"key\":\"images3\",\"originUrl\":\"/Uploads/Picture/20160527/78783bf6c3a00990.jpg\",\"smallUrl\":\"/Uploads/Picture/20160527/s_78783bf6c3a00990.jpg\",\"id\":\"1b32ecaa2dd8704967e856b00589afa6\"}]', '', '云南省昆明市盘龙区G56(杭瑞高速公路)', '25.106140', '102.780091', '0', '0', '', '全国', '1464282229');
INSERT INTO `tc_share` VALUES ('74', '0', '20000025', '3', '', '', '又是拉白标的！[emoji_117][emoji_117][emoji_117][emoji_314][emoji_314][emoji_314]', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160604/a19d23d429f8675e.jpg\",\"smallUrl\":\"/Uploads/Picture/20160604/s_a19d23d429f8675e.jpg\",\"id\":\"ad457147e79c124698777042859fc3f8\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20160604/c31a61055905f91e.jpg\",\"smallUrl\":\"/Uploads/Picture/20160604/s_c31a61055905f91e.jpg\",\"id\":\"32c95f3d4d07293395b3554f071d0ffc\"},{\"key\":\"images3\",\"originUrl\":\"/Uploads/Picture/20160604/029080ef501692d0.jpg\",\"smallUrl\":\"/Uploads/Picture/20160604/s_029080ef501692d0.jpg\",\"id\":\"15cf7afd60162cb8ba642f7de9cb5152\"},{\"key\":\"images4\",\"originUrl\":\"/Uploads/Picture/20160604/4ace6d64bda6bae3.jpg\",\"smallUrl\":\"/Uploads/Picture/20160604/s_4ace6d64bda6bae3.jpg\",\"id\":\"f87fca70833bf41490aa7797a60e3cbb\"}]', '', '云南省昆明市盘龙区北京路960', '25.074453', '102.730288', '0', '0', '', '昆明市', '1465026786');
INSERT INTO `tc_share` VALUES ('75', '0', '20000002', '0', '1', '', '那些原本是中国的，被误以为是日本的东西\n\n一、樱花\n是爱情与希望的象征，日本的代表物之一。樱花，起源于中国，原产于中国喜马拉雅山脉。被人工栽培后，这一物种逐步传入中国长江流域、中国西南地区以及台湾岛。\n秦汉时期，宫廷皇族就已种植樱花，距今已有2000多年的栽培历史。当时万国来朝，日本深慕中华文化之璀璨以及樱花的种植和鉴赏，樱花随着建筑、服饰、茶道、剑道等一并被日本朝拜者带回了东瀛。\n\n二、和服\n在19世纪末期以前称作吴服。吴服这个称谓源于中国三国时期，东吴与日本的商贸活动将纺织品及衣服缝制方法经传入日本的缘故。昔日吴服与和服两种概念是有区别的，但今天这两种概念已几乎重叠。很多卖和服的商店，招牌上会写着“吴服屋”（吴服屋），可见两词已经基本上同义化。\n\n三、相扑\n相扑在中国很早就有记载，无需多说。\n\n四、木屐\n在中国，是汉服足衣的一种，是最古老的足衣。尧舜禹以后始服木屐。晋朝时，木屐有男方女圆的区别。木屐是汉人在清代以前，特别是汉晋隋唐时期的普遍服饰。汉代汉女出嫁的时候会穿上彩色系带的木屐。南朝宋之时，贵族为了节俭也着木屐。江南以桐木为底，用蒲为鞋，麻穿其鼻。随着木屐在日本服饰里面的地位，多数人会以为这是日本的传统服饰。\n\n五、茶道\n从唐代开始，中国的饮茶习俗就传入日本，到了宋代，日本开始种植茶树，制造茶叶。到明代，真正形成独具特色的日本茶道。\n\n六、花道\n日本花道最早来源于中国隋朝时代的神堂供花，传到日本后，其天时、地理、国情使之发展到如今的规模，先后产生了各种流派，并成为女子教育的一个重要环节。\n\n七、榻榻米\n一种起源于中国汉朝，发展并盛行于隋唐的中国式家具。于盛唐时期传播至日韩等地。我国西安的皇室古墓里就有榻榻米系列产品的使用。唐后，凳子及高脚床盛行，榻榻米逐渐在中国衰落。榻榻米起源于中国汉代，是从中国盛唐时期传入的日本的，至今已有近两千年的历史。\n\n八、艺伎\n以“侍酒筵业歌舞”为职业的艺伎，在历史上本来并不是日本所特有。中国的唐宋时代，士大夫携妓吟唱，是当时普遍的习俗，在中国浩瀚的诗词曲赋中，留下了不少咏唱歌姬的佳句。当时中国的官妓，以及朝鲜的妓生，和日本的艺伎都有相类之处。随历史的发展，只有日本的艺伎一直延续到现代，成为日本传统文化的载体，成为了日本传统文化的象征之一。\n\n九、生鱼片\n中国最古老的传统食物之一，有文字记录的历史可上溯到周宣王五年，即公元前823年，叫“鲙”或“脍”，先秦之时的生鱼脍当用加葱、芥的酱来调味，脍炙人口也是来源于此，后传至日本、朝鲜半岛等地，在日本是很受欢迎的食物。\n\n中华文明源远流长，对世界历史文化有重要影响，这些源自于中国的文化习俗，作为中国人更应该了解，不要连自己的东西都不知道，反而以为是别国的文化，那就要让人笑话了。[emoji_364][emoji_364][emoji_364][emoji_12][emoji_12][emoji_12]', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160605/e4dcbf6aec211280.jpg\",\"smallUrl\":\"/Uploads/Picture/20160605/s_e4dcbf6aec211280.jpg\",\"id\":\"1600402557fa24f55933ff080b069951\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20160605/2431d1f8284cc149.jpg\",\"smallUrl\":\"/Uploads/Picture/20160605/s_2431d1f8284cc149.jpg\",\"id\":\"b11d3c39d9200216ea395e7100082739\"},{\"key\":\"images3\",\"originUrl\":\"/Uploads/Picture/20160605/41dfa94a8a7f412b.jpg\",\"smallUrl\":\"/Uploads/Picture/20160605/s_41dfa94a8a7f412b.jpg\",\"id\":\"6e4498090b87ad3ee59744c491208fd0\"},{\"key\":\"images4\",\"originUrl\":\"/Uploads/Picture/20160605/f00ef1e462944c5a.jpg\",\"smallUrl\":\"/Uploads/Picture/20160605/s_f00ef1e462944c5a.jpg\",\"id\":\"75d4b91360464035350a081d48e6f09b\"},{\"key\":\"images5\",\"originUrl\":\"/Uploads/Picture/20160605/f126afe3d997551d.jpg\",\"smallUrl\":\"/Uploads/Picture/20160605/s_f126afe3d997551d.jpg\",\"id\":\"777ca791b4e7eca736edce4d95897237\"},{\"key\":\"images6\",\"originUrl\":\"/Uploads/Picture/20160605/31b3a40d225629fa.jpg\",\"smallUrl\":\"/Uploads/Picture/20160605/s_31b3a40d225629fa.jpg\",\"id\":\"964c026579129cbd13bcb60d6e07f075\"}]', '', '全国', '25.106842', '102.779641', '0', '0', '', '全国', '1465056564');
INSERT INTO `tc_share` VALUES ('76', '0', '20000002', '0', '1', '', '人到中年，在撕裂中前行\n\n人到中年，总在撕扯中前行。撕扯他们的，一边是入世的成功，一边是出世的向往。不过看着这些对比，总觉得离自己很近。\n\n1、一边是马云，一边是星云\n一边是马云、马化腾、扎克伯格们的创业故事，财富、梦想、活着就是要改变世界的热血燃烧。如果没有事业，人生的价值如何体现？而另一面又是星云大师、净空法师们的劝世恒言，人生本修行，万般皆身外，何必苦苦相争？\n\n2、一边是位子，一边是孩子\n无数的文章在提醒：陪孩子一起成长吧，一生只有这一次。可是又有无数文章在提示，人生需要定位，更需要上位，想要老婆孩子热炕头，就腾出你的位置吧。\n\n3、一边是超人，一边是老人\n你会在夜里梦到老人离你而去，惊醒过来，泪湿枕巾。你恨不得从此陪伴他们身边，陪伴他们最后的旅程。可是，擦干眼泪，对着梳妆台你又想起今天要安排的一件件任务，你得做个超人，向上下证明你的能力。问候的电话，还是晚上再打吧。\n\n4、一边是上流，一边是逐流\n你痛恨腐败、藐视权威、嘲讽马屁，你心里住着一位清高上流的你。但每当机会来临，你立即苦思可以利用的关系、向握着权力的人表达由衷的敬意、想方设法用最安全的办法把它“搞定”。你发现，此时那位上流的你，正在闭目养神，不闻不问。\n\n5、一边是同学会，一边是追悼会\n同学会的真正意义并非“拆散一对是一对”，而是人生比较和刺激。当年并排坐的小伙伴，如今己经分出了三六九等，有的春风得意，有的落寞失意。好在比赛尚未结束，赶紧迎头努上，下次一定要锦衣豪车，把那些钱多人贱的土豪比下去。只有到追悼会，才惊觉生命脆弱，万贯身家终究黄土一抔。活着的意义又在心中翻腾，还要这么拼吗？\n\n6、一边是养老，一边是怕老\n你总是描绘美好的退休生活，种花养鱼周游世界。但你又时时担心，货币会不会巨贬？资产会不会缩水？冬天三亚夏天新西兰的计划是不是有保证？　更重要的是，如果真的老了，是不是就讨人嫌了？被别人说老，很痛苦吧？那么，为了美好的养老，还得再拼一拼。表现出精力充沛的样子，至少要看上去很年青！\n\n7、一边是庭院，一边是田园\n你向往蓝天白云的田园，总想像个农民一样过一回纯天然、原生态的人生。包括“舌尖上的中国”在内，每当看到或明或暗讲述回归自然的故事，都会让你怦然心动。但你又向往花园和别墅，庭院深深，明星作邻，也不枉此生。所以，还得拼。\n\n8、一边是“路上”，一边是“故乡”\n中国的创业人，最喜欢的歌曲一定包括“在路上”、“爱拼才会赢”、“飞得更高”，它们总能让“一颗不安分的心”澎湃沸腾。但下一曲，可能就是许巍的“故乡”或者李健的《心升明月》，有些伤感，有些迷茫，有些心生倦意。但是，故乡在哪里，什么时候能归去？\n\n一不小心到中年，向左，入世，走向人生巅峰；向右出世，田园将芜胡不归。这就是30岁以后人生的真实写照啊！[emoji_97][emoji_97][emoji_97]', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160605/4222b5cc6a346da9.jpg\",\"smallUrl\":\"/Uploads/Picture/20160605/s_4222b5cc6a346da9.jpg\",\"id\":\"161706d6cbba75c73430e2b9f12b5ad7\"}]', '', '全国', '25.106834', '102.779662', '0', '0', '', '全国', '1465138676');
INSERT INTO `tc_share` VALUES ('77', '0', '20000002', '0', '9', '', '本来只是刷一下音箱[emoji_154]结果顺便又刷一下院子[emoji_53]累死个人[emoji_97]也算是趁雨季来临之前完成[emoji_13][emoji_370][emoji_370][emoji_370]', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160609/4a80089ad3267532.jpg\",\"smallUrl\":\"/Uploads/Picture/20160609/s_4a80089ad3267532.jpg\",\"id\":\"adc150fff424726bb4ff4693e36fbd54\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20160609/9ef1664ac0e36232.jpg\",\"smallUrl\":\"/Uploads/Picture/20160609/s_9ef1664ac0e36232.jpg\",\"id\":\"e4080ede5187819cb7dd31a5f114c462\"},{\"key\":\"images3\",\"originUrl\":\"/Uploads/Picture/20160609/be3132f658c508c1.jpg\",\"smallUrl\":\"/Uploads/Picture/20160609/s_be3132f658c508c1.jpg\",\"id\":\"94840fd1bc98a41d098df4a513dd5da4\"},{\"key\":\"images4\",\"originUrl\":\"/Uploads/Picture/20160609/3660cc4926163541.jpg\",\"smallUrl\":\"/Uploads/Picture/20160609/s_3660cc4926163541.jpg\",\"id\":\"be08b3c9869fe345565f6e9aada50c10\"},{\"key\":\"images5\",\"originUrl\":\"/Uploads/Picture/20160609/bcbb0eb3a134811d.jpg\",\"smallUrl\":\"/Uploads/Picture/20160609/s_bcbb0eb3a134811d.jpg\",\"id\":\"f4ea2e9ac1c5d3d1461194bd41603ec1\"},{\"key\":\"images6\",\"originUrl\":\"/Uploads/Picture/20160609/ec937dee393c89e3.jpg\",\"smallUrl\":\"/Uploads/Picture/20160609/s_ec937dee393c89e3.jpg\",\"id\":\"df5080e3e7f22a736972f8173bbda7a8\"}]', '', '云南省普洱市思茅区学苑路', '22.771587', '101.002062', '1', '0', '', '全国', '1465439587');
INSERT INTO `tc_share` VALUES ('78', '0', '20000025', '5', '', '', '领略一下根文化，据说全国只此，端午特吃[emoji_13][emoji_16][emoji_301]', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160609/3cafc26ac65d0321.jpg\",\"smallUrl\":\"/Uploads/Picture/20160609/s_3cafc26ac65d0321.jpg\",\"id\":\"7170857ced7544e35cecd315b3b24436\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20160609/14361e1dd0ab837e.jpg\",\"smallUrl\":\"/Uploads/Picture/20160609/s_14361e1dd0ab837e.jpg\",\"id\":\"f7f36c131485ee70763071be66973dd9\"},{\"key\":\"images3\",\"originUrl\":\"/Uploads/Picture/20160609/71907b94ef3ff1f6.jpg\",\"smallUrl\":\"/Uploads/Picture/20160609/s_71907b94ef3ff1f6.jpg\",\"id\":\"1dd4ac5e7e8b0ebcf9f216a7b1c521ed\"},{\"key\":\"images4\",\"originUrl\":\"/Uploads/Picture/20160609/41704835cae3453b.jpg\",\"smallUrl\":\"/Uploads/Picture/20160609/s_41704835cae3453b.jpg\",\"id\":\"c902c5cab4973da929a34d8a399a7a42\"},{\"key\":\"images5\",\"originUrl\":\"/Uploads/Picture/20160609/7208d2134d844b15.jpg\",\"smallUrl\":\"/Uploads/Picture/20160609/s_7208d2134d844b15.jpg\",\"id\":\"67298023f4c4b89a50f16decf580768d\"},{\"key\":\"images6\",\"originUrl\":\"/Uploads/Picture/20160609/33b96a980fa53ea4.jpg\",\"smallUrl\":\"/Uploads/Picture/20160609/s_33b96a980fa53ea4.jpg\",\"id\":\"6d5d3346627bc72fc152ff91d2ed4488\"}]', '', '普洱市', '22.785569', '100.972352', '1', '0', '', '普洱市', '1465471500');
INSERT INTO `tc_share` VALUES ('79', '78', '20000002', '5', '', '', '这么多的根，叹为观止[emoji_96][emoji_96][emoji_96]', '', '', '昆明市', '22.780193', '100.972191', '0', '1', '', '全国', '1465579973');
INSERT INTO `tc_share` VALUES ('80', '0', '20000002', '1', '', '', '麻将与人品，太准了！[emoji_357][emoji_357][emoji_357][emoji_96][emoji_96][emoji_96]\n\n1 、出牌很快，不假思索的人——性情耿直，喜欢直来直去。\n2 、每出一张牌，犹豫不决的人——办事老练，任何事要求尽善尽美。\n3 、一会儿不胡牌，就发脾气的人——性格急躁，做事喜欢怨天尤人。\n4 、十有八九要“放炮”也要出牌的人——生活之中敢闯敢干，只重结果不管过程。\n5 、出错牌总要找个理由的人——面子思想严重，对人对事刚愎自用。\n6、老爱背牌经的人——做任何事拖泥带水，婆婆妈妈。\n7 、一局麻将结束一言不发的人——城府较深，待人对事总给人以“只缘身在此山中，云深不知处”的感觉。\n8、麻将局中，有钱老是欠账的人——金钱利益意识较强，与此人最好不要成为生意场上的伙伴。\n9 、麻将娱乐结束，输赢从不过问的人—对朋友很重感情，事业上重大体，在他的潜意识里不会为了生活中的小节而得罪朋友。\n10 、总怨别人出错牌的人——生活中总是“斤斤计较，小题大作 ，吹毛求疵”。\n11 、杠上花总爱大叫的人——对朋友热情似火，性格外向，爱憎分明，嫉恶如仇，他的表情就是情感变化的晴雨表。\n12 、手气不顺爱甩牌的人——身遇逆境老是怨天尤人，怀才不遇。\n13 、不按顺序齐牌的人——生活中很阳光，记忆力惊人，做事不拘一格。\n14 、整整齐齐按顺序齐牌的人——做事严谨，循规蹈矩，古板，不灵活。\n15 、先摸后出牌的人——害怕失败，对过程结果都很看重。\n16 、先出牌后摸的人——不管对错绝不后悔，相信命运的安排，信念坚定。\n17 、老是算不清帐的人——做事马虎草率。\n18 、关键时候不知道咋出牌的人——做事优柔寡断，无主见。\n19 、別人还没有出牌就提前摸牌的人——爱偷奸耍滑，为人不诚实，少接触为妙。\n\n麻将是中国传统娱乐节目，各地有各地的玩法。我了解的只有长沙麻将，简称长麻。长麻很有意思，可吃可碰，有清一色、大对胡、将将胡、七小对、杠上花、海捞、全求人，没胡牌之前可以缺色胡、缺将胡、双三胡、四子胡，胡牌后还要看鸟，瞬间翻倍。有时候我很佩服那个发明麻将的人，居然能定出这么多好玩的规则。\n\n麻将桌上，四人各据一方，从言谈到表情，从出牌到胡牌，有这么多规则，加上有金钱的刺激，打牌确实很容易看出来一个人的性格，话说牌品如人品。\n\n有一种人，从摸第一张牌开始，就抱怨牌不好，要么是上家没有给牌吃，要么是总摸不到好牌，就算胡了，还觉得胡得太小，胡得太慢。这种人，一上桌就愁眉苦脸，只有胡了大牌的时候，才难得露出点笑容。这种人生活中也是属于那种悲观的，不只是悲观，还怨天尤人。这种人做事业，也不会有什么成就，生活一定过得不顺。\n\n有一种人，只要摸了一个好子，就会说牌不错，吃了一个难得的子，也会开玩笑感谢，整场都乐呵乐呵的。这种人生活中属于善于发现乐趣，性格开朗型的。无论是否有事业，这种人生活过得都不错。\n\n有一种人，打牌特别较真儿，别人打错一张牌，他会大声制止，经常利用别人失误，并不给别人改过的机会，输了牌脾气大，赢了牌很得意。这种人心胸狭窄，也比较精明；有一种人，虽然强调规则，但就算你犯错了，他只是指出，告诉你下不为例，或者偶尔拿这个事情取笑一下你。这种人天性豁达，生活中也不会太过斤斤计较。\n\n有一种人，自己出错牌，点了人家的炮，别人还没怎么说话，他会强调自己没有出错，说按照道理应该这么打。他其实是不够自信，担心别人说他技术不好，生活中一定也是如此。相反有一种人，打错牌了不会放在心上，可能会承认自己技术不行，或者开玩笑说是想照顾一下对方，这种反而是自信的表现，内心很强大。\n\n有一种人，打牌比较专注，完全沉浸在里面，身边手机、电视、聊天完全不顾，只专心打牌。另外一种人，一边打牌一边玩手机，偶尔还是眼观六路耳听八方，和别人一起聊天，但丝毫不影响打牌。前者生活中对事情容易投入，后者则相反。\n\n有一种人，打牌时犹豫不决，患得患失，就算确定某个子要打下去，牌握在手里半天才放。另外一种人，干净利落，出手干脆，快速打出牌以后，再观察牌场局势。前者生活中也是优柔寡断，性格保守，后者则相反。\n\n有一种人，打牌求稳，求不出错，求不输，求快速胡牌。有一种人，打牌冒险，能打大胡打大胡，有杠的机会绝不错过。前者生活平淡，后者生活起伏。\n\n写了这么多，都只是我的想法。大家可以试着观察一下每个人打牌的风格，同时观察一下自己的风格。只是一个人观察别人容易，观察自己很难。因为当你玩牌时，你就被牌带走了，你想不起观察。等你想起观察的时候，牌局已经结束了，你不会记得那些细微的表现。如果能做到时刻观察自己，无论是在做什么，这个人时刻都在修行。\n[emoji_357][emoji_357][emoji_357][emoji_357][emoji_357][emoji_357]', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160613/d70dfb75c99e5817.jpg\",\"smallUrl\":\"/Uploads/Picture/20160613/s_d70dfb75c99e5817.jpg\",\"id\":\"3f2fd7881dbda4ab0a95259b7ad376b5\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20160613/ea555b4afa67d694.jpg\",\"smallUrl\":\"/Uploads/Picture/20160613/s_ea555b4afa67d694.jpg\",\"id\":\"89874f97ff80251cff276a78abb3cfa1\"},{\"key\":\"images3\",\"originUrl\":\"/Uploads/Picture/20160613/78d12eb89f976ff7.jpg\",\"smallUrl\":\"/Uploads/Picture/20160613/s_78d12eb89f976ff7.jpg\",\"id\":\"4c7550d10939619bb3222610c34214f3\"}]', '', '全国', '25.106822', '102.779683', '0', '0', '', '全国', '1465820887');
INSERT INTO `tc_share` VALUES ('81', '0', '20000002', '0', '1', '', '10句话写尽整个中国历史！\n\n1、天下之事，分合交替，分久必合，合久必分\n\n夏一统，商周继之，春秋战国乱之;秦一统，两汉继之，三国魏晋南北朝乱之；\n\n隋一统，大唐继之，五代十国宋辽金乱之；元一统，明清继之，民国乱之。\n\n\n2、红颜祸水，倾国倾城\n\n夏亡于妹喜；商亡于妲己；西周亡于褒姒；吴亡于西施；秦以吕易嬴，赵姬之功;\n\n晋牛继马后，光姬之力；唐衰于杨玉环；明亡于陈圆圆；清败于太后慈禧。\n\n\n3、历史有无数的选择，选择在某个人手里\n\n秦之李斯，助纣为虐，焚书坑儒;汉之王莽，书生治国，一塌糊涂；\n\n唐之安禄山，安史之乱，由盛转衰;宋之王安石，变法维新，由治而乱；\n\n明之吴三桂，一己之私，引狼入室;清之袁世凯，卖友求荣，反复无常。\n\n\n4、内忧小人干政，外戚、宦官、后宫；中忧官场腐败，官逼必然民反；外忧民族矛盾，异族虎视耽耽\n\n历朝历代之灭亡，无不由此三者起。\n\n\n5、胜者王侯败者贼，历史即是：为胜者歌功颂德、败者落井下石的虚假陈述\n\n胜即是刘邦，败即是项羽；胜即是李世民，败即是窦建德；\n\n胜即是朱元璋，败即是张士诚；胜是一国之君，败是流贼草寇。\n\n\n6、矫枉总是过正，其实过犹不及\n\n秦尚法，汉即尚儒；\n\n唐重武轻文，宋即重文轻武；\n\n唐宋尚诗词，明清即尚八股。\n\n\n7、越是四分五裂，政治混乱，思想越光辉灿烂\n\n越是大一统，政治稳定，思想越停滞不前\n\n前者如春秋战国之百家争鸣，魏晋南北朝之三教合融；\n\n后者如秦之焚书坑儒，汉之独尊儒术，明之八股，清之文字狱。\n\n\n8、地域环境左右命运\n\n中国自古东临太平洋，北接荒芜人烟的西伯利亚，西北是塔克拉玛干大沙漠，西南为喜马拉雅山，在这样一个封闭的环境之内生存，养成了国人含蓄内敛、保守中庸、消极忍耐的农耕性格。\n\n故历朝政府皆重农抑商，重伦理文采，轻科技实用；\n\n如夏政权在陕西、商政权在河南;西周政权在陕西、东周政权在河南；\n\n秦、西汉政权在陕西、东汉政权在河南;\n\n隋、唐政权在陕西、北宋政权在河南。五千年文明，有四千年历史皆在农耕最发达的中原地区上演，由此可见，中国一直都是以农耕为主的黄色文明。\n\n直到异族蒙古入主中原，定都北京，明清政权才随之坐落于此，中国的农耕地位才逐渐为之动摇。\n\n当政权东西对峙时，西强而东弱;南北对峙时，北强而南弱。\n\n原因也正是在于西和北更接近于游牧民族，两种文化的交融，自然比东南单纯的农耕文化多了一些强悍。\n\n然而，每一次异族依靠武力的入侵，又都会被汉文化迅速的同化。\n\n\n9、朝代之初，君强臣强；朝代之中，君强臣弱，朝代之末，君弱臣强\n\n如唐之初，君有太宗，臣有房、杜;唐之中，君有玄宗，臣则为李林甫、杨国忠之流;\n\n唐末之君不足道也，臣却为虎狼之臣，如朱温之辈。历朝历代，莫不如此，岂有他哉!\n\n10、单以武治，刚且易折；单以文治，软弱可欺；文武结合，刚柔兼济，方能长治久安\n\n如秦、元所向披靡，却迅速灰飞湮灭，两宋文化鼎盛，却屡被异族欺凌。\n\n惟汉、唐重文韬武略，方绵延三四百载，号称盛世，今已不再矣。', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160615/84c95a4379fc4982.jpg\",\"smallUrl\":\"/Uploads/Picture/20160615/s_84c95a4379fc4982.jpg\",\"id\":\"4a0cc22745172de2b0ceef84755281e4\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20160615/4192e20099f22cf4.jpg\",\"smallUrl\":\"/Uploads/Picture/20160615/s_4192e20099f22cf4.jpg\",\"id\":\"83f78271237f47951cd1dbcc8313d235\"},{\"key\":\"images3\",\"originUrl\":\"/Uploads/Picture/20160615/d475d62d63c693d2.jpg\",\"smallUrl\":\"/Uploads/Picture/20160615/s_d475d62d63c693d2.jpg\",\"id\":\"cdccc408e489f53ad177d6cb107b98c8\"},{\"key\":\"images4\",\"originUrl\":\"/Uploads/Picture/20160615/c547fbcf83dc0e15.jpg\",\"smallUrl\":\"/Uploads/Picture/20160615/s_c547fbcf83dc0e15.jpg\",\"id\":\"18407980c3aa600b56415998a06af095\"},{\"key\":\"images5\",\"originUrl\":\"/Uploads/Picture/20160615/7955bd2bc0986d7c.jpg\",\"smallUrl\":\"/Uploads/Picture/20160615/s_7955bd2bc0986d7c.jpg\",\"id\":\"90ec675cb4a5aa4254d046825e3e92e9\"}]', '', '全国', '25.106911', '102.779723', '0', '0', '', '全国', '1465923491');
INSERT INTO `tc_share` VALUES ('82', '0', '20000002', '10', '', '', '破解绕晕大家的云南普洱茶的六大产区[emoji_13][emoji_13][emoji_13][emoji_318][emoji_318][emoji_318]\n\n        普洱是最复杂的一类茶，排除工艺、历史、包装、品牌不说，就单单是普洱产区这一点就够你晕了！\n\n第一产区为易武茶区：包括攸乐、革登、莽枝、蛮砖、倚邦、易武这六大山头，也叫做六大古茶山。易武茶区的茶具有蜜味兰香，其古树茶具有木味兰香，存放久之后，逐渐出现樟香、松木香、檀香、沉香等气息。它属于甜茶区，其古树茶茶品是从淡雅、柔和向茶气强烈沉稳，汤质醇厚、细柔转变。前期微涩，从淡到厚的过程。\n\n第二产区为勐海茶区：它包括南糯、班章、布朗、勐宋、巴达、景洪等山头。勐海茶区的茶的特点是具有野菊花香，它属于甜苦茶区，其茶品的变化是从浓烈、苦涩转化为汤质饱满，香气高扬，茶气浓烈，微苦，长期存放从浓到平和的过程。其古树茶存放之后，茶品是从野菊花香转化为樟香、木味的过程。长期以来，勐海茶厂主要采用该产区的茶进行拼配。\n\n第三产区为思茅茶区：它包括景迈、景谷、景东、邦威、南桥、无量山南、哀牢山、苦竹山等山头。思茅茶区的茶具有稻谷花香，为甜苦茶区，其茶品一开始很香，有蜜味，茶气高扬，茶清甜。茶底多为苦底，存放久了茶水易淡薄。\n\n第四产区为临沧茶：它包括勐库、冰岛、昔归、凤庆、双江、永德等山头。临沧茶区的茶的香味不是很稳定，以板栗香为主，属于苦茶区，其茶品性烈，厚重，香气杨。其基调为苦底，存放久了，香气丰富，但茶底多为苦而不化。\n\n第五产区为大理茶区：它包括无量山东、无量山西、黑龙潭、德安、南涧等山头。大理茶区大部分是新茶园，主要为下关茶厂提供制茶原料。大理茶区的茶属果香型，为苦茶区。下关茶厂研究出一套有效制茶工艺，对该产区的茶品有着提升的作用。\n\n第六产区为保山茶区：它包括保山、腾冲、龙陵、昌宁等地方的一些山头。保山茶区比较靠北，大部分茶原料被制成滇红、滇绿以及一些普洱散茶，只有少部分做成普洱饼茶。保山茶区的茶属果香型，为苦茶区。', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160615/158d11179e9bac9c.jpg\",\"smallUrl\":\"/Uploads/Picture/20160615/s_158d11179e9bac9c.jpg\",\"id\":\"445586013a7a70c0d4ded277e272b8c6\"}]', '', '全国', '25.106828', '102.779690', '1', '0', '', '全国', '1465992915');
INSERT INTO `tc_share` VALUES ('83', '0', '20000002', '0', '1', '', '     当我们在传统的思维里苦苦挣扎，别人已经开始了用分享经济学+倍增学原理+大数据+移动互联网+的思维在奔跑了！改变思维模式是当下所有人需要努力的方向！\n\n什么叫分享经济模式？先分享个小故事：\n\n有个开面馆的老郑，他做的面很好吃!有个经常来面馆吃面的食客小陈！小陈几乎每个月都会来老郑的面馆吃面！\n\n突然有一天老郑对小陈说：小陈同学我叫老郑，是这家面馆的老板！那么我想问你觉得我家面馆的面好不好吃呢？小陈说：好吃啊！我很喜欢！老郑：那么既然好吃，我想和你谈一个合作计划！你愿意跟我合作吗？小陈说：先听听看是怎样的合作呢？\n\n老郑：合作计划是这样的--你既然这么喜欢吃我家的面，那么从今天开始我正式邀请你成为我老郑面馆的合伙人，合伙人呢，有以下几点：\n\n你和你以前一样，照例来吃面就可以了，以前你来我的面馆吃面都不打折，再好吃也没有打过折！现在你成为我的合伙人，你来吃面我给你打七折；如果有朋友问你小陈那里的面店好吃啊？你要记得帮我讲一句话就好了：\"老郑面店最好吃，你报我小陈的名字可以打七折\"；报你名字来吃面的朋友，每吃一碗，我奖励你1元，他们再推荐的朋友来吃面，每吃一碗，我奖励你0.5元。\n\n小陈说：好啊！好啊！\n\n于是小陈下月就介绍了一些朋友来吃面!到了月底，老郑对小陈说：因为你这个月的介绍本店生意兴隆，他们一共来本店吃了2000碗面！这是按约定给你的1800元！小陈觉得好棒，平时我只是来吃吃面的，现在能吃到这么好吃的面条的同时还能赚外快，真的好赞。\n\n过了段日子，小陈要准备考试了，这个月他很忙，没有时间去帮老郑介绍人来面馆了，但是忙里偷闲他还是会来面馆吃面，和大家聊聊天。有一天，老郑拉着小陈，递给他6000块，小陈很诧异，坚决不收这钱，这时老郑说到：\"你上次介绍的那些朋友啊，他们吃了面后，感觉味道确实不同于其他面馆，从那以后他们经常会来光临，并且他们也介绍他们的朋友来吃，我同样也给他们奖励了，这些是你应得的，当初多亏你介绍，我的面馆才会有现在这么兴隆的生意啊。\"小陈竟说不出感激的话来，从此之后，小陈就和老郑的面馆，长长久久地合作下去。\n\n这就是分享经济模式\n\n一般人思维：1元X1元＝1元\n\n老板思维：1元X1元＝10角X10角＝100角＝10元\n\n互联网＋思维：1元X1元＝10角X10角＝100分X100分＝10000分＝100元\n\n当我们在传统的思维里苦苦挣扎，别人已经开始了用分享经济学+倍增学原理+大数据+移动互联网+的思维在奔跑了！\n\n改变思维模式是当下所有人需要努力的方向！\n[emoji_16][emoji_16][emoji_16][emoji_370][emoji_370][emoji_370]', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160621/62c91d109c895e0e.jpg\",\"smallUrl\":\"/Uploads/Picture/20160621/s_62c91d109c895e0e.jpg\",\"id\":\"440cf35e4b4b5f14470186508837dc75\"}]', '', '全国', '25.106335', '102.780285', '0', '0', '', '全国', '1466510626');
INSERT INTO `tc_share` VALUES ('84', '0', '20000002', '0', '1', '', '美国的人生观念[emoji_13][emoji_13][emoji_13]\n1、带病坚持工作是一种不负责任的行为\n2、汽车洋房是生活必须品．不是富人才有\n3、政要没有什么了不起的\n4、家庭第一，哪怕金钱和工作都要给家庭让路\n5、“富”不等于“贵”\n6、有钱不等于会生活\n7、读大学是一种个人养成．而不是为了出路和提高身价\n8．离婚的男人像根草', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160623/f4095d8da29e7c58.jpg\",\"smallUrl\":\"/Uploads/Picture/20160623/s_f4095d8da29e7c58.jpg\",\"id\":\"c070433ca3953914260c046cf37b3bd2\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20160623/9be18b450a6dd372.jpg\",\"smallUrl\":\"/Uploads/Picture/20160623/s_9be18b450a6dd372.jpg\",\"id\":\"31cf25cd9523d69323f666909185e9db\"},{\"key\":\"images3\",\"originUrl\":\"/Uploads/Picture/20160623/e1ffde67791c75bc.jpg\",\"smallUrl\":\"/Uploads/Picture/20160623/s_e1ffde67791c75bc.jpg\",\"id\":\"2c8c84812cd37a05008edbac91652c55\"},{\"key\":\"images4\",\"originUrl\":\"/Uploads/Picture/20160623/01db8e6d8501ab1a.jpg\",\"smallUrl\":\"/Uploads/Picture/20160623/s_01db8e6d8501ab1a.jpg\",\"id\":\"6018e035c912b7581bf31c7eba30c85a\"}]', '', '全国', '25.106812', '102.779650', '0', '0', '', '全国', '1466695237');
INSERT INTO `tc_share` VALUES ('85', '0', '20000000', '0', '6', '', '111', '', '', '四川省成都市郫县天辰路', '30.738865', '103.979067', '1', '0', '', '全国', '1467007721');
INSERT INTO `tc_share` VALUES ('86', '0', '20000000', '0', '2', '', '啦啦操', '', '', '四川省成都市郫县天辰路', '30.738865', '103.979067', '0', '0', '', '全国', '1467007744');
INSERT INTO `tc_share` VALUES ('87', '0', '20000000', '1', '', '', '啦啦啦', '', '', '四川省成都市郫县天辰路', '30.738865', '103.979067', '0', '0', '', '全国', '1467007757');
INSERT INTO `tc_share` VALUES ('88', '0', '20000002', '0', '1', '', '中国人，从生到死急个啥？\n\n中国人生孩子急，纷纷剖腹产；\n\n中国人教育急，唯恐输在起跑线；\n\n中国人看病急，为了快点好，大把吃消炎药、成瓶打点滴；\n\n中国人办事急，小事儿想插队，大事儿走后门；\n\n中国人开车急，前面一犹豫后面就按嘀嘀；\n\n中国人坐公交车也急，从来不排队，全靠钻和挤；\n\n中国人旅游急，上车睡觉、下车拍照，四大名楼、名山大川恨不得全都装上索道电梯；\n\n中国人写文章急，博客变微博，三行两病句；\n\n中国人看文章急，扫一半标题就扣帽子、猜动机、发脾气;\n\n中国人发财急，坑蒙拐骗、贪赃枉法恨不得一把整他几个亿；\n\n中国人升官急，40岁前赶紧多多升几级；\n\n中国人搞课题急，既要课题费又要出成绩，不抄袭来不及；\n\n中国人破案急，一顿毒打谁还敢说“想不起”；\n\n中国人建设急，超英赶美只争朝夕；\n\n中国人破坏急，一二十年的建筑转眼变瓦砾；\n\n中国人喝酒急，红酒不闻就下肚，白酒喝光再来啤；\n\n中国人沟通急，开车走路吃饭睡觉随时划手机；\n\n中国人恋爱急，不想结婚就是耍流氓；\n\n中国人结婚急，婚礼开宴十分钟，看看新娘尝尝菜色就离席；\n\n中国人葬礼也急，悼词刚开头，没到默哀毕，手机铃声已响起；\n\n中国人乘机急，飞机没停稳就都站起，争先恐后拿行李……\n\n人生是长跑，何必累死在起跑线上？\n人生是人参果，像猪八戒那样一口吞下有何味道？\n人生只有一次，何必匆忙赶去投胎？\n人生需要品味、社会需要秩序，真正的贵族从来都温文尔雅、慢条斯理……', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160629/7e914514b8d38d03.jpg\",\"smallUrl\":\"/Uploads/Picture/20160629/s_7e914514b8d38d03.jpg\",\"id\":\"452ef72424bb2195df85402e39948c34\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20160629/7896baae693c9234.jpg\",\"smallUrl\":\"/Uploads/Picture/20160629/s_7896baae693c9234.jpg\",\"id\":\"599cfeef88ab48dcb11e6675a6e587f8\"},{\"key\":\"images3\",\"originUrl\":\"/Uploads/Picture/20160629/4bcd2bab887f96c0.jpg\",\"smallUrl\":\"/Uploads/Picture/20160629/s_4bcd2bab887f96c0.jpg\",\"id\":\"de4f26a20642094d24de0ace7219f4ca\"}]', '', '云南省昆明市盘龙区九龙湾公路', '25.106853', '102.779679', '0', '0', '', '全国', '1467204397');
INSERT INTO `tc_share` VALUES ('89', '0', '20000002', '10', '', '', '中国城市名称掌故大全\n\n天津——意为“天子的津渡”，明代永乐帝朱棣在这里率领大军渡过海河南下推翻建文帝\n\n邯郸——邯郸意为“邯山之端”，郸同单，“单”意思是山脉尽头，邯郸是中国沿用最古老的地名之一\n\n秦皇岛——秦始皇求仙入海之岛，秦皇岛是唯一用古代帝王称号来命名的中国城市\n\n太原——取“广大的平原”之意\n\n大同——取自“天下大同之地”，这里传统上是农耕区的北端，毗邻牧区。“大同”寓意族群和谐，也是最高的政治理想\n\n长治——长治古称上党，明代在此地设置长治县，取“长治久安”之意\n\n赤峰——得名于城东北的褐色孤峰\n\n包头——源于蒙古语“包克图”，意思是“有鹿的地方”，包头别称为鹿城\n\n乌海——乌达与海勃湾的合称\n\n大连——大连旧称青泥洼，青泥洼居民大部分由山东迁入。大连是由山东褡裢演变而来，另一说大连来自俄语“达里尼”\n\n阜新——取“物阜民丰，焕然一新”之意\n\n盘锦——盘山和锦州各取一字而成，也取“盘根错节，锦上添花”之意\n\n本溪——本溪得名于境内的本溪湖，本溪湖古称杯犀湖，杯犀湖因“湖底上阔下窄，状如犀牛之角”而得名，清代雍正年间因杯犀湖名称过雅又难写难辨，故取其谐音改称为本溪湖\n\n长春——意为“长年春色的城市”\n\n吉林——吉林全称吉林乌拉，满语意思是“沿江的城市”，吉林市是中国唯一省市同名的城市\n\n佳木斯——佳木斯清代又称“嘉木寺”，在满语是“驿丞”的意思，因为佳木斯在古代地处松花江通往黑龙江江口的驿道\n\n烟台——意为“狼烟升起的炮台”\n\n青岛——因岛上“山岩耸秀，林木蓊郁”而得名，且与“琴岛”谐音\n\n威海——明代在此地设威海卫，取“威震东海”之意\n\n日照——取“日出初光先照”之意\n\n淄博——淄川与博山的合称\n\n莱芜——莱是植物名，俗称灰菜，芜指田野荒芜，古时这里是一片荒凉的地方，故名莱芜菏泽——菏泽也是中国沿用最古老的地名之一\n\n合肥——因东淝河与南淝河在此汇合而得名\n\n蚌埠——意为“盛产蚌珠的港埠”，蚌埠由此别称为珠城\n\n宿迁——春秋时为钟吾子国，后宿国迁都于此，宿迁由此得名\n\n连云港——意为“在连岛与云台山之间的港湾”，云台山是江苏省的最高峰\n\n镇江——唐代为镇海军节度使的驻地，到了宋代因地理环境的变化，此地距大海较远，故而更名为镇江，取“镇守长江”之意\n\n无锡——先秦锡山产锡，至汉朝锡尽，故名无锡\n\n上海——得名于松江（即苏州河）的一条支流上海浦，上海意为“通向大海的地方”\n\n金华——意为“金星与婺女争华之地”\n\n宁波——宁波古称明州，宁波得名于“海定则波宁”\n\n莆田——取“莆口成桑田”之意，莆田是极具闽越特色的地名，莆是由蒲字演化而来\n\n厦门——明代筑厦门城，原作“下门”，意为\"位于下方的海峡\"\n\n龙岩——因城南的翠屏山麓有一龙岩洞而得名，龙岩是中国唯一用洞穴名称来命名的地级市\n\n鹰潭——因信江南岸龙头山下有一深潭，“急流漩其中、雄鹰舞其上”，故名鹰潭\n\n上饶——上饶之名得于“山郁珍奇，上乘富饶”，在古代这里是物产丰饶之地\n\n九江——九江名称来源于“刘歆以为湖汉九水入彭蠡泽也”，九是古代中国人认为的最大数字，因而九江也有“众水汇集的地方”之意\n\n宜春——宜春之名源于城西美泉，以其“夏冷冬暖，莹媚如春，饮之宜人”而得名\n\n商丘——商丘是商王朝的发祥地，传说远古时期这里有一座叫“阏伯台”的土丘，后来帝喾把阏伯的封地号为商，商丘由此而得名\n\n开封——开封古称汴梁，开封二字取“开土封疆”之意\n\n鹤壁——因相传“仙鹤栖于南山峭壁”而得名\n\n焦作——焦作的名称来自焦作村，作指的是作坊，其村民以姓焦的为主\n\n武汉——武昌、汉口、汉阳三镇相连而得名，武昌取“以武治国而昌”之意\n\n襄樊——襄阳与樊城的合称，襄阳以地处襄水之阳而得名，樊城因周宣王封樊穆仲于此而得名\n\n孝感——因“东汉孝子董永卖身葬父，行孝感天动地”而得名\n\n黄石——黄石港与石灰窑的合称，黄石港得名于长江岸边的黄石矶，矶是指长江岸边突出的岩石，因“石色皆黄”故名黄石矶\n\n十堰——古代此地农民为了饮水灌溉，就在这里的百二河和张湾河上修建了十个小水库，分别取名为一堰至十堰，久而久之十堰就成了这里的地名\n\n长沙——因长沙星而得名，长沙由此别称为星城，另一说长沙得名于湘江中的橘子洲，取“绵长的沙洲”之意，《路史》记载曰“少昊氏始于云阳，胙土长沙”\n\n株洲——洲字取自古人以湘水两岸为洲，株洲即出产槠木的岸洲，株是由槠字演变而来\n\n娄底——因相传是天上28个星宿中的“娄星”和“氐星”交相辉映之处而得名\n\n汕头——汕头得名于海滨泥沙积聚而成的沙脊，由于韩江泥沙在海滨地带的不断冲积并在潮汐风浪的作用下，在今天汕头老市区一带形成一条自然的沙堤，这种沙堤就叫做汕，开端处称为汕头\n\n深圳——客家话意为“深邃的水沟”\n\n东莞——因境内盛产一种叫莞草的水草而得名\n\n清远——意为“香清溢远之地”\n\n珠海——意为“出产珍珠的海湾”，另一说珠海得名于“珠江入海”\n\n茂名——名称来源于西晋道士潘茂名，后人为了纪念潘茂名用丹药扑灭了此地的瘟疫，茂名是中国唯一以古代道士名字来命名的城市\n\n湛江——古代曾在湛江境内的东海岛设立椹川巡检司，湛江即由椹川演变而来，也取“湛蓝的江水”之意\n\n香港——意为“盛产香料的海港”，另一说古时此地有一条小溪被称为香江，香江入海冲积成的港湾即为香港\n\n澳门——澳在古代是泊口的意思，门是中国内河通往海洋的海峡总称，澳门是因本地内港的妈阁庙隔海同湾仔的银坑相望，形成的海峡像门\n\n桂林——取“桂树成林”之意\n\n百色——由壮语中原始村落“博涩寨”的名称演变而来，意思是“洗衣服的好地方”\n\n河池——古时这里是一片平原，缺少大海和水，壮族的祖先莫一神就在此地修筑一座山坝，并日夜灌水，终因操劳过度而逝，此地最终还是没有形成大海，只形成了几条河与池塘，后人为了纪念莫一神就把此地命名为河池\n\n玉林——玉林是由郁林演变而来，郁林取“郁江两岸森林繁茂”之意\n\n来宾——取“来者上宾”之意，一看地名就知道这里是个热情好客的地方\n\n重庆——意为“双重喜庆”，宋光宗先封恭王后即帝位，自诩“双重喜庆”，因而升恭州为重庆府，重庆由此得名\n\n成都——得名于“一年成聚，二年成邑，三年成都”\n\n安龙——南明最后的都城，龙象征皇帝，取安定皇帝，北伐成功之意\n\n宜宾——意为“适宜四方宾客之地”\n\n自贡——自流井与贡井的合称，自贡自古以来盛产井盐\n\n攀枝花——在金沙江渡口发现一株上百年的攀枝花大树而得名\n\n六盘水——六枝、盘县、水城各取一字而成\n\n昆明——昆明之名取自“云南洪水退除，昆仑山南方有黎明景象”，另一说昆代表万物生长的春天，昆明即“春光明媚”之意，昆明由此别称为春城\n\n曲靖——曲靖是唐代曲州和靖州的合称，也取蛮夷“屈服平定”之意\n\n玉溪——得名于珠江源头之一的玉溪河，玉溪河因“河水澄碧透亮，如玉带潺潺流淌在万亩田畴之中”而得名\n\n昭通——昭通旧称乌蒙，清代云贵总督鄂尔泰望文生义曲解乌蒙为“乌暗蒙敝”，因而在请示雍正皇帝改乌蒙府为昭通府的奏章中写到“举前之乌暗者，易而昭明，前之蒙敝者，易而宣通”，昭通由此得名\n\n丽江——因元代金沙江称作丽江而得名，丽江古城全城为世界文化遗产\n\n宝鸡——宝鸡古称陈仓，因唐代城东南的鸡峰山有“石鸡啼鸣”之祥兆而改称宝鸡\n\n商洛——因境内有商山和洛水而得名\n\n榆林——因古代此地“榆树成林”而得名\n\n平凉——意为“平定凉国”，前秦皇帝苻坚曾率军经此地攻灭前凉国\n\n白银——早在汉代这里的采矿业就非常兴盛，明代在今天白银境内的凤凰山和火焰山专设矿业机构“白银厂”，白银由此得名，白银市也是中国唯一以金属名称来命名的地级市\n\n武威——汉武帝征服河西走廊后设置武威郡，以彰显大汉帝国的武力军威\n\n张掖——取“张国臂掖，以通西域”之意\n\n酒泉——酒泉以“城下有泉，其水若酒”而得名\n\n吴忠——得名于古代镇守边关的将士吴忠之姓名，宁夏有很多以边关将士来命名的村镇，但一个堂堂地级市的名称也是出自一位历史小人物的姓名，这在中国仅吴忠一例', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160702/f059c65a09c3f11a.jpg\",\"smallUrl\":\"/Uploads/Picture/20160702/s_f059c65a09c3f11a.jpg\",\"id\":\"8c7737f52988c4368f71b73322337856\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20160702/cc01b49bb6efff75.jpg\",\"smallUrl\":\"/Uploads/Picture/20160702/s_cc01b49bb6efff75.jpg\",\"id\":\"195c1ab76d246c11d57af1eec72466e0\"},{\"key\":\"images3\",\"originUrl\":\"/Uploads/Picture/20160702/5cc9cff898968774.jpg\",\"smallUrl\":\"/Uploads/Picture/20160702/s_5cc9cff898968774.jpg\",\"id\":\"c150f020213e4dfd565c216394fc3c4b\"}]', '', '云南省昆明市盘龙区九龙湾公路', '25.106857', '102.779647', '0', '0', '', '全国', '1467472438');
INSERT INTO `tc_share` VALUES ('90', '0', '20000002', '3', '', '', '任志强事件的来龙去脉\n\n近期任志强事件在中国社会引起极大反响，刚开始是暴风骤雨、电闪雷鸣；突然之间又偃旗息鼓、悄无声息了。那么任志强是何许人？整个事件又是怎么回事呢？让我们来梳理一下来龙去脉。\n\n1、任志强是何方神圣？\n\n任志强，1951年生，籍贯山东莱州，出生于高干家庭，父亲任泉生曾任商业部副部长，母亲李秀亨，在“文革”后期担任北京市二商局领导，主管北京的烟酒副食品供应。因此，任志强被认为是“红二代”和“官二代”。\n\n1964年，任志强就读北京市第三十五中学。初二时，认识了王岐山，任志强在他的自传《野心优雅》中说：“上初一时班上的辅导员是姚明伟、姚依林的大儿子（王岐山夫人的哥哥），高三后他去了越南学习，中间由蒋小泉接手过一段时间。再接下来就是王岐山了，当时他上高二，他是陪伴我们时间最长的辅导员，从在校学习到上山下乡，再到北京工作，我都跟他保持各种各样的联系。至今他还会偶尔在半夜打来电话，我们经常一聊就聊很久。”\n随后“文化大革命”爆发。初始，任志强被狂热的政治气氛带动，加入“批斗”队伍。第一个死于女红卫兵手下的中学女校长是他最好朋友的母亲。“这就是革命吗？”他开始疑惑。很快，他的父母成为“走资派”，被下放到干校。\n\n1969年，任志强加入了38军某步兵团。在38军时，任志强认识了现在习近平的经济智囊刘鹤。\n\n1971年的“林彪事件”后，他开始怀疑中共：“为什么前一天还是接班人，第二天就变成反革命了呢？”\n\n1981年后任志强步入商界。\n\n1984年年初，任志强进入国企华远公司。1985年任志强曾被以“贪污罪”关进看守所，被关了14个月。1986年无罪释放。\n从1984年至2011年4月，任志强逐步成为中国知名房产商，任职华远集团董事长。\n2014年11月24日，任志强通过微博发表声明宣布正式退休。\n\n任志强政商“”非常强大，中纪委书记王岐山是其“初中辅导员”，关系熟到“半夜三更可以直接打电话”，与副总理汪洋是“想见就见”，中财办主任刘鹤在任志强心目中“不是什么官，私下里以朋友相交”。\n\n有这么多高官朋友，任志强在大陆舆论界“非常牛”，经常言他人不敢之言。卸任华远集团董事长一职后也不休息，继续在微博中谱写着他的“炮轰进行曲”。 2010年到2013年末，任的言论多涉“中国怎么走”，作为在微博拥有3,700多万粉丝大V，近几年来，任志强言论越来越惊人，其“敢言”吸引大批网友眼球，人送外号“任大炮”。\n\n二、任志强事件的起因\n\n事件的起因是2月19日上午，习近平年后首次调研，分别视察了中共三大官媒人民日报社、新华社、央视。下午，习近平主持召开新闻舆论工作座谈会并讲话，要求文宣官员要维护“中央权威”，“与中央保持一致”等。据多家官方报导，“党媒姓党”也是这次会议的说法之一。\n\n19日晚上，任志强在微博发贴炮轰：“政府啥时候改党政府了？花的是党费吗？”还称“这个不能随便改”！“别用纳税人的钱去办不为纳税人提供服务的事”。紧接着，任志强又说道：“彻底地分为对立的两个阵营了？当所有的媒体有了姓，并且不代表人民的利益时，人民就被抛弃到被遗忘的角落了！”\n\n任志强的言论立即掀起轩然大波。\n2月22日，由北京市委旗下的千龙网首先发表题为“网友为何要给任志强上党课”、“谁给了任志强反党的底气”的两篇评论。用文革式的语言称“简直就是党性的泯灭、人性的猖狂”。并把质疑指向任志强背后的领导：一个半夜三更喜欢给领导打电话的任志强，究竟谁给了他跳出来推墙的“勇气”？\n22日近中午时分，任志强发表微博称：“董事会受股东的委托代表股东管理、经营公司。但公司是属于股东的，不是属于董事会的。这是常识！”\n\n随后，任志强被媒体戴上“反党”高帽，新华网以《乱放炮的任志强“党性”去哪儿了》，人民网以《任志强同志，你正在演出一场机会主义闹剧》加入围攻的队伍。上海市的东方网指任是“8,000多万党员的耻辱”、对党“忘恩负义”、“处处抹黑、污蔑党”；共青团的中青网称他“用心险恶”、“妄议中央”、“违反‘国安法’”；《广州日报》谩骂任“甚至禽兽不如”；光明网称其为“颠覆势力代言人”；还有自称民间“爱国网民网站”的察网发表署名“崔紫剑”的文章，呼吁对任志强“依纪处理”，如有违法就移送司法。\n\n2月24日，任志强在微博上发了《吕氏春秋》的一句话。25日早上他透过腾讯微博，宣布他的新浪微博被封杀：“早上起来新浪的微博已经被关闭了。在这打个招呼！”\n\n事件并未就此打住，炮轰任志强继续升级。\n\n2月26日，中宣部主管的党建网刊文《党要管党任志强不能例外》称：“党内的任志强们，吃共产党的饭，砸共产党的碗，中央必须狠下决心，依照党章和纪律处分条例把那些在党反党的人剔除出去。”\n\n28日，网信办责令新浪、腾讯等有关网站“依法关闭”任志强微博账号，并表示绝不允许被关闭账号的用户改头换面再次注册。此举意味任此后难在网上再发声。\n\n2月29日，北京西城区委下发《关于正确认识任志强严重违纪问题的通知》。通知称，要对任志强作出“严肃处理”。\n\n2月25日，中央党校教授蔡霞三篇替任辩护的文章同样遭到封杀。\n\n三、为何突然寂静消声？\n\n任志强的事件在社会引起极大反响，尤其是提到任志强深夜给‘领导’打电话，质疑是‘谁’给了他反党推墙的勇气，尽管没直接点出‘领导’及‘谁’的名字，已经是呼之欲出。\n3月1日，中纪委网站载《中国纪检监察报》署名文章《千人之诺诺，不如一士之谔谔》。该文引述习近平在河北的讲话，其中提到“小问题没人提醒，大问题无人批评，以致酿成大错，正所谓‘千人之诺诺，不如一士之谔谔’啊！” 文章引述唐太宗李世民和魏徵的关系等历史典故进一步阐述，并称能否广开言路，接受建议，常常决定一个朝代的盛衰。\n\n继中纪委官网之后，3月3日，《人民日报》发表文章《有的领导怕丢面子，不愿听群众逆耳之言》。文章中称，有的领导怕掉架子，不愿和群众坐一条板凳；有的怕丢面子，不愿听群众的逆耳之言；还有的怕出乱子，不愿让群众知道太多的信息。这样的想法和做法都是不对的。\n\n紧接着，3月3日下午，政协会议开幕式上，政协主席俞正声作了政协常委会工作报告。在讲话中，俞正声多次强调要包容不同意见，称坚持求同存异、包容多样等，并支持“讲真话、道实情”。\n\n3月4日，习近平参加民建工商联组的讨论时首度发声，强调了“讲真话、说实情”，习近平表示：“对民营企业家来说，就是讲真话说实情建诤言，遵纪守法办企业”\n安徽出版集团董事长王亚非最近公开发声，在提到《谁给了任志强反党的底气》的文章时表示，作者是醉翁之意不在酒。他的矛头不是指向任志强的，而是指向这个“谁”。\n\n3月2日，连续8年出席两会的政协委员、上海财经大学教授蒋洪在接受财新网采访时直言：“受某些事件的影响，现在公众也都有点迷茫，希望少讲些话，气氛是这样。”接着他明确表态说：作为公民，表达的权利有必要保障，因为“表达的权利是宪法上划定的”，而且“公众各抒己见是一个国家兴旺发达协调的标志，也是社会自信的标志”。“我如今唯一担心的是，两会代表和委员的概念是否能够充分通过媒体展现出来。”\n\n3月3日，财新网以“蒋洪委员：公民表达的权利必须要保障”为题报导了对蒋洪教授的访问。 很快，蒋洪的担心就成为现实。第二天，当他在微信平台上浏览自己之前在里的这篇采访时，却被提醒：“该网页包含违法或违规内容，被多人举报，为维护绿色上网环境，已停止访问。”\n\n3月5日，蒋洪再次接受财新网采访，他表示：“我左看右看，看不出什么违法违规的内容。”他说，所谓违法违规的内容，恰恰是宪法赋予公民的权利，“太可怕了，太让人惊奇了。”\n\n当天，财新网再以“蒋洪委员：我的两会言论被指违法违规‘太可怕’”为题做了报导，结果该报导再被删除。\n\n3月7日，财新旗下英语网站发表文章，就这两篇报导遭当局删除表示异议，直指中共国家互联网信息办公室是“政府新闻审查机构”，结果这篇英文文章也被删除了。\n\n有评论指出“试想，蒋洪尚是中共的全国政协委员，在体制中也算是有身份的人，连这样的人的表达权利都得不到保障，何况一般百姓呢？ ”但是，也有评论认为，蒋洪会不知道自己的言论触犯了某些敏感事件的边界？恐怕也是明知原因却不敢点透吧。\n\n四、近年来任志强“反党”言论盘点（2010年开始到2013年末）：\n\n2011年1月6 任志强在谈到“普世价值”的时候说，嘴上不承认，不等于事实不存在。普世价值是人内心中的共识。\n\n2011年7月2 “坚持不搞私有化，不是从经济学和市场化的角度谈其科学性，而是从领导和执政的角度看其政治性的。”\n2011年9月23 “如果农民的土地私有化了，不再被政府低征高卖，何来贫民窟？如果取消了户籍差别，何来农民工？？？”\n\n2011年10月27 “中国革命的成功靠的是私有化。把土豪的土地抢过来分给农民。如果当初说要把土地抢过来归公，大概就没有农民会支持了！”\n\n2012年2月12 “宪政的五要素：一，竞争型的多党制；二，代表民意的代议机构；三，分权制衡的政治结构；四，独立的司法系统;五，人权先于宪法和法律。人权不优先又何来自由？”\n\n2012年3月2 任志强在回应贺卫方提出的“雷锋问题”时说，“（雷锋是）一剂麻醉剂？”同日，任还说，“雷锋是阶级斗争，是驯服工具，只是被文革的需要而塑造的形象。”\n\n2012年6月8 在回答如何看待“三权分立”的时候，任志强说，（三权分立）是民主的基础和保障。\n\n2013年1 任志强在北大光华新年论坛上发言，号召学生联合起来推倒面前这堵墙，建立社会民主制度\n\n2013年5月11 “今司法独立已成多国制约公权泛滥之必备条件。无司法独立又用什么维护宪政？\n\n2013年6月8 在评论当局“中国梦和美国梦是相通的”说法时，任志强说，（中国梦与美国梦）都是宪政梦啊！\n\n2013年8月24 对“普世价值”，任志强说：“可以有内容不同的争论，但不能没有普世价值。你可以不吃鱼翅，你可以不吃肉，但你不能连吃饭都否定了。”\n\n2013年10月2 任志强对“三年大饥荒饿死几千万人的说法”评论道，“（三年大饥荒饿死人数）远超八年抗战。”\n\n2013年10月21 任志强在对外经贸大学参加“个人命运与家国时代”的读书沙龙时发言说：“在这个社会上最缺的不是谎言而是实话，当我们的社会被无数谎言填满所有空间时，不管是这代人还是下一代人都生活在谎言中。”\n\n2013年11月7 在新地产年会上，任志强被问到“三中”你最希望听到什么？任说，“我最想听到的是政治体制的改革。如宪政，民主，司法独立，完全的市场经济制度，官员财产公布，产权制度平等保护等。也许改革仍停留在政府管理层面。只要改就是进步，民众都希望改革的步伐再大些。但政体的改革还需时日。仍需努力。”\n\n2014年2月1 对于朝鲜战争的歌曲《英雄歌》，任志强说，“许多人是听着这首歌长大的。也一直以英雄为学习的榜样。只是从抗美援朝战争变成朝鲜战争之后，许多历史的真相打破了文艺作品的神话。”\n\n2014年6月13 凤凰财经报导了华远地产董事长任志强在清华大学做了主题为“改革必须面对的几个问题”的演讲： 任志强称：“几乎所有的公有制企业都是效率最低的。而民营企业、私营经济占用最少的资源，却创造了巨大的国家财富，创造了更多税收，创造了更多的劳动就业。”“很多腐败行为都是因为公有制，谁看到私有企业中有那么多腐败？”“过去三十年，我们没看到公有制的好。如果公有制好，国企就不会搞混合所有制了。”“60多年来，我不知道国有企业到底给了我们什么好处。”\n\n2014年8月19 任志强说：“独立的司法是行使民主权利的保障。权力的相互制约是法治的必备条件。”\n\n2014年10月21 “历史上每次通过不合法的暴力行为所拥有的权力都是极权的，而非民主的。”\n\n2015年2月7 任志强撰写文章《一党独大》，阅读量超过100万。该文声称：“如果民众不相信中国共产党要实现这个伟大的梦想时，一定会有新的政党领导人民实现这个目标。”\n\n2015年9月13 在中共再次宣称“搞中国特色的社会主义是为了实现共产主义”之后，任志强在微博质疑“民大于党还是党大于民？”\n2015年9月22 中共共青团重提了“共产主义信仰”的口号，同日，任志强发表了一条长微博。文中对中共的“实现共产主义”口号，说它完全是“欺骗”、“愚弄”人的，说自己“曾经被这个口号骗了十几年”。 他还说：“公私合营之后的公有制经济被打破了。计划经济体制彻底宣告失败了。战无不胜的毛泽东思想饿死了几千万人，文革也不知冤死了多少人。”\n\n2015年10月2 任志强罕见撰文“新国家还是新政权”？他在微博上发文说：“这个节日不是新的国家产生的节日，而是一个新的政府产生的节日。”任志强此言被广泛诠释为“中共不等于中国”。\n\n2016年1月在讨论大陆房地产去库存的问题时，任志强表示，中国目前房地产的库存已经接近7亿平方米，大量库存不会因为任何政策而消化掉，只能炸掉。\n\n2016年2月 “党所有的媒体都有了姓，并且不代表人民的利益时，人民就被抛弃到遗忘的角落了！”任志强谈到社会责任时说：“真正的社会责任是你要生活在一个什么样的社会之中为之付出努力的责任。”\n他表示自己这个概念是从龙应台那里来的。他进一步分析：“台湾的民主制度建设，不仅仅是因为有一个蒋经国，更重要的是他们的思想、他们的梦想要有一个民主的社会、要有自己的权利。所以龙应台鼓励所有的人承担你们的社会责任，把你们面前的墙推倒。在中国现状情况下，我们唯一的社会责任，所有各位你们努力的站起来把我们面前的墙推倒，建立我们社会民主制度。”\n\n演讲中，他认为现在面对的首先是制度问题，并毫不掩饰地表示：“这个制度已经烂透了。', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160704/1b3d0ba25ee77701.jpg\",\"smallUrl\":\"/Uploads/Picture/20160704/s_1b3d0ba25ee77701.jpg\",\"id\":\"8db4830605b4caa5e476736d0d56ee51\"}]', '', '云南省昆明市盘龙区北京路延长线1083号', '25.086002', '102.739714', '0', '0', '', '全国', '1467609430');
INSERT INTO `tc_share` VALUES ('91', '0', '20000002', '13', '', '', '烟锅巴盖碗茶[emoji_357][emoji_357][emoji_357]', '', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160705/febe79c53b396ea8.jpg\",\"smallUrl\":\"/Uploads/Picture/20160705/s_febe79c53b396ea8.jpg\",\"id\":\"93d99c73e7eadce5bf274200527daeef\"},{\"originUrl\":\"/Uploads/Picture/20160705/162e146075ac046f.mp4\",\"smallUrl\":\"/Uploads/Picture/20160705/162e146075ac046f.mp4\",\"id\":\"fb8e626cf2a46a8014ba84fc9ecc4e48\",\"key\":\"video\"}]', '云南省昆明市盘龙区九龙湾公路', '25.106831', '102.779654', '1', '0', '', '全国', '1467729856');
INSERT INTO `tc_share` VALUES ('92', '0', '20000002', '0', '1', '', '揭秘万科事件真正内幕\n\n关于“万科王石”大战“宝能姚振华”的文章有无数，但我发现，多数文章都没写到点上。本文将回答你如下几个看似奇怪，其实说穿了又很简单的问题：\n\n1，为什么姚振华要花如此大的代价收购万科？\n2，为什么万科的股票长期不涨？\n3，为什么说好的100亿回购就只花掉一亿多？\n4，面对宝能系的收购，为什么王石的表现如此激动？\n5，万科的管理层真的不想要股权吗？\n6，万科的股票，现在还能买吗？\n\n在继续下面的文章之前，我还想告诉你一个简单的道理，明白了这个道理，你就能看清很多事情。这个简单的道理是：我们每个人最关心的都是自己的利益，但是在维护自身利益的时候，我们会用一套冠冕堂皇的话来包装，这样就可以让自己看起来很有情怀，就可以装逼。所以，你不要把时间浪费在这些废话上面，而是搞清楚他们的利益点在哪里。\n\n万科是不是一个优秀的企业？当然是！但是这个企业的管理层只拥有很小一部分股权，你以为他们不着急吗？但由于大股东华润是个甩手掌柜，因此万科管理层并不太担心自己的位置会被替代。于是，他们就设计了一个长期的变相MBO（管理层收购）方案。\n\n这个方案的要点是：压低股价（比如隐藏利润），多多给自己发奖金发工资。拿了奖金就可以参与两个资管计划（金鹏计划和德赢计划），用来购买自家低估的股票。等买的差不多了，就把隐藏的利润拿出来，股价一涨大家都爽歪歪。\n\n现在你就明白了为啥万科不愿意大力回购自家股票了吧，因为人家还没买够啊，他还要想办法压低股价呢。用公司赚的钱给自己发高额奖金，用奖金买公司股票，这样一来就可以空手套白狼，不需要付出什么代价即可实现管理层控股。\n\n截至2015年12月15日，“金鹏计划”与“德赢计划”合计持有万科股票860,668.839股，占万科总股本比例为7.79%。这个数量按理说已经不小了。这距离“万科事业合伙人计划”推出才仅仅过了一年多的时间。如果再给几年时间，买到第一大股东的位置也不奇怪。\n\n本来这一切都是那么的完美，可是野蛮人姚振华的到来打破了他们的美梦。野蛮人一来就大手笔狂买万科A，一下就变成了万科第一大股东。这样一来，他们的变相MBO计划还能进行吗？万一大股东要求对财务报表进行重新审计，那些被隐藏的利润怎么处理？现在你就明白为啥王石会那么激动了吧，一会儿说人家是卖菜的不够格，一会儿说人家信用不够，其实这些都是借口，真正的原因是姚振华直接触动了他们的核心利益！其实要论出身的话，王石真的没法跟人比，姚老板好歹是正牌大学的双学士，王石你只是个文革推荐的工农兵大学生。\n\n对于小股民来说，姚老板一来就猛拉股票，股票涨了大家都高兴，姚老板简直是大善人。但对万科管理层来说，你现在猛拉股票，可是我们还没买够啊，我们这么长时间压低股价，竟然是给你做嫁衣。你已经变成了第一大股东，我们的小算盘还怎么玩下去？王石不希望姚振华继续买股票，就随便找了个借口停牌半年，然后再找人来重组。最好是找一个像华润一样的甩手掌柜来当第一大股东。不求他能帮上多大忙，只求别管我们就行了。\n\n让王石没想到的是，他引入深圳地铁的行为触怒了华润。华润心想：我这么多年来一直不说话，你还真把我当吉祥物了。王石硬把华润赶到了宝能的战线。如果华润和宝能联手，就有接近40%的股份，深圳地铁肯定是进不来的。这下王石是真的慌了，所以才在股东大会上服软认怂，说要跟姚振华道歉，还说“恶意收购”是个中性词。但是现在才认怂，真的是太晚了。\n\n现在我们就可以回答本文开头的6个问题了：\n\n1，为什么姚振华要花如此大的代价收购万科？\n答：姚振华认准了万科被低估，因此才敢用高杠杆狂买万科股票。\n\n2，为什么万科的股票长期不涨？\n答：管理层故意压制，在他们买够数量之前就上涨，不符合他们的利益。\n\n3，为什么说好的100亿回购就只花掉一亿多？\n答：因为不想股价涨太快呗。\n\n4，面对宝能系的收购，为什么王石的表现如此激动？\n答：野蛮人触动了你的核心利益，你能不着急嘛？\n\n5，万科的管理层真的不想要股权吗？\n答：想，做梦也想。\n\n6，万科的股票，现在还能买吗？\n答：你说呢？', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160708/d243b6e5405c2d9f.jpg\",\"smallUrl\":\"/Uploads/Picture/20160708/s_d243b6e5405c2d9f.jpg\",\"id\":\"76931214cda02c0c7a1f6321126c57cb\"}]', '', '云南省昆明市盘龙区九龙湾公路', '25.106833', '102.779673', '0', '0', '', '全国', '1467986842');
INSERT INTO `tc_share` VALUES ('93', '0', '20000025', '1', '', '', '[emoji_357]  女人有两个优点，但有一个漏洞； 男人虽然没有优点，却有一个长处； 男人经常抓住女人的两个优点，用自己的长处去弥补女人的漏洞，这叫天衣无缝。\n[emoji_357]  男人为何聪明？是男人有两个头。女人为何爱吃？是女人有两张嘴。\n[emoji_357]  男女为何结婚？男人想通了，女人想开了。又为何离婚？男人知道深浅了，女人知道长短了。\n[emoji_357]  营养学家研究婚后男人瘦而女人发胖的原因： 男人每晚有两袋鲜奶，一个燕窝，两个鲍鱼片；而女人每晚只有一根火腿肠，两个鹌鹑蛋。 \n[emoji_357]  男人是牛，女人是地，没有耕坏的地，只有累死的牛； 牛越耕越瘦，地越耕越熟 ！。\n[emoji_357]  男人就应该像自己的小弟弟，第一：从不外露炫耀;第二：关键时刻硬的起撑的住;第三：能培育出接班人;第四：善于攻击而又使对方感到愉悦;第五：既能制造摩擦又能使大家同感快乐;第六：胜利后能谦虚的缩小自己。\n[emoji_357]  总结：低调、有骨气、有能力！20岁女人没贼心无贼胆，30岁女人有贼心无贼胆，40岁女人贼心贼胆都有了，回头一看贼没了。\n[emoji_357]  晚上，和女朋友准备啪啪啪，这时电视里正在直播世界田联田径短跑比赛，突然听到发令员的枪声响起，老婆顺手按了遥控一下，把电视关了，我也顺势翻身上马了………激情过后，我打开了电视，点了根烟，这时听到播音员激动的大喊着：新的世界记录诞生了，8秒97！8秒97……大哭  大哭然后大笑 大笑', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160718/5bec609ccd94c6eb.jpg\",\"smallUrl\":\"/Uploads/Picture/20160718/s_5bec609ccd94c6eb.jpg\",\"id\":\"683e86ae80b2a7f8fd9f32ab29d72b7f\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20160718/d6013acda4620788.jpg\",\"smallUrl\":\"/Uploads/Picture/20160718/s_d6013acda4620788.jpg\",\"id\":\"2e5380ade56342bf5443ada6d31619cc\"},{\"key\":\"images3\",\"originUrl\":\"/Uploads/Picture/20160718/fea51854fa5c30dc.jpg\",\"smallUrl\":\"/Uploads/Picture/20160718/s_fea51854fa5c30dc.jpg\",\"id\":\"dc0558a9e70e8c78734ff014f3e6b2e0\"}]', '', '云南省昆明市盘龙区九龙湾公路', '25.106894', '102.779729', '2', '0', '', '昆明市', '1468799079');
INSERT INTO `tc_share` VALUES ('94', '0', '20000002', '0', '1', '', '2016年麻将职称考试理论试题（总分100分） \n[emoji_86][emoji_86][emoji_86]\n一、选择题（本大题共有10小题，总分20分，每小题2分）\n1. 麻将一共有多少张牌？（ ）\nA．108 B.120 C.148\n2.下列选项中，颗数最多的是（ ）\nA..混一色 B.大对子 C.小七对\n3.色子一颗是3，一颗是5，请问应从哪方抓牌（ ）\nA.下家 B.对家 C.上家\n4.卡七条的意思是手里有（ ）\nA.一个六条和一个八条 B.一个八条和一个九条 C.一个七条\n5.如果一个牌友一直不说话，且脸色通红，还时不时将牌乱摔说明他（ ）\nA.不会打麻将 B.嬴钱 C.输钱\n6.清大对金钩吊杠上花最少可以算到多少颗（ ）\nA.24颗 B.25颗 C.20颗\n7.纯清比清一色最少多几颗（ ）\nA.4颗 B.5颗 C.6颗\n8.下列几组牌形，哪组牌的叫最多？\nA.9998 B.8887 C.7766\n9.十八学士下叫手里面还有几张牌（ ）\nA.一张 B 四张 C七张\n10.一手牌最多可以下几个叫（ ）\nA . 5个 B. 6个 C. 9个\n\n二、判断题（判断本大题共有5小题，总分10分，每小题2分）\n1.小明最后剩了四只牌在手：五万、七万、八万、九万。后来再摸了个六万，打掉九万就是五八万的叫。（ ）\n2.小明碰了四坎条字出来，手中还有个幺鸡，如果胡牌，那么他这把牌算清一色。（ ）\n3.七条是王孝勇的小名（ ）\n4.打定缺的时候，如果明小得别人要自己缺的牌，可以适当留一手。（ ）\n5.麻将中的“大对子”是不可以碰牌的。（ ） \n\n三、问答题（本大题共有3小题，总分40分）\n1. 名词解释：A.黄牌. B.包牌（10分）\n2.同时下2条和3条的叫，那你手上的牌有4种可能：1条1条1条3条；2条4条4条4条；2条2条3条3条……请问，第四种可能是？（10分）\n3.案例分析：小明在一次麻将中，第二圈后龙七对就下叫了，而且只有两张牌的花色不一样。第三圈的时候，上手打了只幺鸡，他手上有三只幺鸡，于是他杠了幺鸡，请问小明的这种打法对吗？为什么？（需从多方面来分析）（20分） \n\n四、作文(30分) \n每个人在打麻将中都会有很多难忘的经历……请你写一篇关于你的亲身经历或所见所闻的最离奇的一件事。要求：1.字数不得低于100字；2.不得提及别人真名；3.不能有错别字。', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160727/59c2d8ba8840a6a2.jpg\",\"smallUrl\":\"/Uploads/Picture/20160727/s_59c2d8ba8840a6a2.jpg\",\"id\":\"636a2d2f7d873180d2d01b2456720b98\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20160727/b0a1d55b6960551e.jpg\",\"smallUrl\":\"/Uploads/Picture/20160727/s_b0a1d55b6960551e.jpg\",\"id\":\"2d2992b3d44ab0dacab56c0968444aa8\"},{\"key\":\"images3\",\"originUrl\":\"/Uploads/Picture/20160727/7e2e969003425fa4.jpg\",\"smallUrl\":\"/Uploads/Picture/20160727/s_7e2e969003425fa4.jpg\",\"id\":\"90850dbb259d806a354b268df9072ece\"}]', '', '云南省昆明市盘龙区九龙湾公路', '25.106880', '102.779597', '0', '0', '', '全国', '1469581307');
INSERT INTO `tc_share` VALUES ('95', '93', '20000002', '0', '1', '', '[emoji_86][emoji_86][emoji_86]', '', '', '云南省昆明市盘龙区九龙湾公路', '25.106865', '102.779651', '0', '1', '', '全国', '1469665578');
INSERT INTO `tc_share` VALUES ('96', '0', '20000002', '10', '', '', '这个必须分享[emoji_13][emoji_16][emoji_371]', '', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160728/eb39a1f46defbbc8.jpg\",\"smallUrl\":\"/Uploads/Picture/20160728/s_eb39a1f46defbbc8.jpg\",\"id\":\"281628a03538d526a9d31e3a2f5d0eec\"},{\"originUrl\":\"/Uploads/Picture/20160728/f80b413e8a0f7271.mp4\",\"smallUrl\":\"/Uploads/Picture/20160728/f80b413e8a0f7271.mp4\",\"id\":\"41c99818a5e4af7ebebec27dda4758d9\",\"key\":\"video\"}]', '云南省昆明市盘龙区九龙湾公路', '25.107190', '102.779837', '0', '0', '', '全国', '1469688246');
INSERT INTO `tc_share` VALUES ('97', '91', '20000000', '1', '', '', '哈哈哈', '', '', '满庭芳', '28.128402', '112.998254', '0', '1', '', '全国', '1469968484');
INSERT INTO `tc_share` VALUES ('98', '0', '20000002', '0', '1', '', '我只想说：同床异梦[emoji_97][emoji_97][emoji_97]没有节操[emoji_101][emoji_101][emoji_101]丧失底线[emoji_372][emoji_372][emoji_372]', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160804/79e6f6cb878cb486.jpg\",\"smallUrl\":\"/Uploads/Picture/20160804/s_79e6f6cb878cb486.jpg\",\"id\":\"cd0574017dc35fe00657c0f8bab95e83\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20160804/138fe6b637ad3397.jpg\",\"smallUrl\":\"/Uploads/Picture/20160804/s_138fe6b637ad3397.jpg\",\"id\":\"1f1f0c97da5da21cbed3ee78ba8c9754\"},{\"key\":\"images3\",\"originUrl\":\"/Uploads/Picture/20160804/c5c137abf63ebdf0.jpg\",\"smallUrl\":\"/Uploads/Picture/20160804/s_c5c137abf63ebdf0.jpg\",\"id\":\"894906ab236914fe46af3afb43db7fec\"},{\"key\":\"images4\",\"originUrl\":\"/Uploads/Picture/20160804/4bd9e8d11da5bc1e.jpg\",\"smallUrl\":\"/Uploads/Picture/20160804/s_4bd9e8d11da5bc1e.jpg\",\"id\":\"c86c93e048d070a87bc470baab074bad\"},{\"key\":\"images5\",\"originUrl\":\"/Uploads/Picture/20160804/de7f684b655bb25e.jpg\",\"smallUrl\":\"/Uploads/Picture/20160804/s_de7f684b655bb25e.jpg\",\"id\":\"24f36e8d5247a69d24be8999173d4bfb\"},{\"key\":\"images6\",\"originUrl\":\"/Uploads/Picture/20160804/f0de8fdfd0b379ef.jpg\",\"smallUrl\":\"/Uploads/Picture/20160804/s_f0de8fdfd0b379ef.jpg\",\"id\":\"0b88f0b83e6a67b590127da71f22a9fb\"}]', '', '云南省昆明市盘龙区九龙湾公路', '25.106818', '102.780093', '1', '0', '', '全国', '1470283269');
INSERT INTO `tc_share` VALUES ('99', '0', '20000002', '0', '1', '', '原来一直都很困惑[emoji_354][emoji_354][emoji_354]这次终于找到答案了[emoji_96][emoji_96][emoji_96]虽然还[emoji_314][emoji_314][emoji_314]\n\n易中天：我们为什么不爱认错？\n\n1.认错曾经要资格\n\n不知从什么时候开始，认错这事，越来越难了。而且，越是地位高、名气大、粉丝多，就越难。要么矢口否认，要么一声不吭，要么倒打一耙，要么把水搅混，甚至把质疑他的人统统说成是“文化杀手”。痛痛快快说声“对不起，我错了”的，几乎没有。就算有，也凤毛麟角，屈指可数。\n\n于是国人感叹：这究竟是怎么了？\n\n感慨也很自然。因为我们的文化传统，似乎很鼓励认错。谁不知道“君子之过也，如日月之食（蚀）焉”（《论语·子张》）？但不知是否有人想过，这其实要有资格。资格，就是“君子”。在孔夫子的时代，君子首先是贵族，即“君之子”。其中地位高的，是“王子”（天王之子）和“公子”（公侯之子）。最低一等，也是家君（大夫）之子。这就是“士”，也叫“士君子”。这样的人，犯了错误，当然都看得见（人皆见之）；改正错误，当然都崇敬他（人皆仰之）。如果是“小人”（庶人、平民、普通老百姓），犯了错误，有可能“人皆见之”吗？不可能。改正错误，有可能“人皆仰之”吗？更不可能。认错，是不是要有资格？\n\n所以，认错曾经是一种贵族待遇，也是一种贵族精神。那时，一个真正的贵族，如果有错，要么自己辞职，绝不等别人弹劾；要么自己去死，绝不等别人动手。这就叫“刑不上大夫”，也叫“士可杀不可辱”。至于“小人”，则根本就不存在认不认错的问题。他们只有一条出路，就是“伏法受刑”，没资格“自裁免辱”。这就叫“礼不下庶人”。\n\n秦汉以后，贵族慢慢地没有了。最后只剩下两个等级：皇帝和臣民。于是，皇帝以外，包括官员，所有人都没资格认错，只能“认罪伏法”。甚至没有罪，也要声称有罪，比如上奏时口称“诚惶诚恐，死罪死罪”。无罪而称死罪，哪有真实可言？不过是一种“姿态”。真正的错误，也就不会有人去认。结果，认罪也好，认错也好，便都变成了“表演”。\n\n2.认错曾经是表演\n\n表演最“出色”的，是皇帝。因为只有皇帝，才有资格认错。方式之一，则是在遭遇自然灾害时下“罪己诏”。这看起来是“严以律己”，实际上是“自欺欺人”。你想啊，闹地震发洪水，是因为皇帝“失德”吗？那他岂不是神？这就正如他们的“称孤道寡”，你说是谦虚还是自夸？\n\n然而效果却极佳。天下臣民，感激涕零；颂圣之声，不绝于耳。可见所谓“罪己”，名为认错，实为表功；名为自责，实为标榜。实际上圣贤们讲得很清楚：君子之所以要知错就改，固然因为瞒不住（人皆见之），也因为有红利（人皆仰之）。那么，没人看见，或者没人捧场，还认错吗？多半不会。就算儒家主张“慎独”，做到的也没几个。道理很简单：既然是表演，没人喝彩，谁肯粉墨登场？\n\n有趣的是，这样一种表演，到了四十年前“斗私批修”的时候，就成了全民性的。因为所谓“斗私批修”，乃是一场全民的“道德运动”。目的，则旨在把所有人都打造成道德意义上的“君子”。于是，每个人都在“灵魂深处闹革 命”，每个人都在“狠斗私字一闪念”。当然，每个人也都要检讨自己，批判自己，甚至痛骂自己。那些把自己骂得最凶的，往往能得到领导表扬、群众肯定，在掌声中体面地下台，甚至成为帮助别人的“先进分子”。那可能是中国人最肯“认错”的时期。只不过，事后想起，却是惊恐莫名和羞愧难言。许多人今天的不肯认错，就源于对那场运动的“心有余悸”。\n\n3.认错曾经很危险\n\n事实上，任何事情都有两面性。批判自己固然是自我救赎的途径，逼人检讨也是搞垮别人的手段。因为一旦检讨，承认错误，就意味着“有了污点”，在气势上就“落了下风”。就算这会儿不整你，把柄却落到别人手里了，随时随地都可以翻出来，老账新账一起算。我们毕竟不是皇帝，谁都担不起这风险。\n\n其实就连皇帝也不敢。要知道，皇帝之所以能“君临天下”，是因为“奉天承运”。这就不能犯错误。犯错误，就不是“天之骄子”了。也因此，皇帝决不能认错，更不能忏悔，最多只能后悔，比如“悔不该酒醉错斩了郑贤弟”。表面上看，这似乎是检讨自己。但那责任，却全在酒。说到底，还是不负责任，因为他根本就负不起。\n\n皇帝都担不起的，官员也担不起。何况“受命”的是皇帝，“亲政”的也是皇帝，怎么能向官员问责？不能问责，就只能“问罪”。罪责不明，就只能“诛心”。诛心，就是问动机，比如问官员“是诚何心”，也就是问他“居心何在”的意思。这其实也是问不得的。什么叫“居心不良”？最起码也是“谋私”，弄不好就是“谋逆”，谁担得起？也只好极力洗刷自己，设法栽赃于人。大家都标榜自己“动机纯正”，指责政敌“居心不良”，也就非搞阴谋不可。最后，阴谋论和动机论，就成了派别斗争的常规手段。这时，还有人敢认错吗？\n\n历史的经验值得注意，过去的苦难记忆犹新。这就使许多人成为“惊弓之鸟”，十年怕井绳。所以，我虽然坚决反对“阴谋论”和“动机论”，但对怀疑他人动机的被批评者，还是留有一份理解和同情。\n\n4.不会认错又如何\n\n这，大约就是中国人的“认错史”。由于这样一种历史，我们已经不肯认错，不敢认错，也不会认错。比方说，不知道自己错在哪里，该向谁认错。曾经有某官员私生活出了问题，检讨的话却是“对不起人民对不起党”。其实他那档子事，顶多对不起老婆，跟党和人民有什么关系？这样“大而无当”的认错，一听就是“言不由衷”。\n\n不会认错，也就不会道歉。曾经有某媒体，因“报道失实”向某机关道歉，其实这个机关，或者部门，或者单位，是靠纳税人的钱来维持的。纳税人的钱怎么花，有没有铺张浪费，媒体当然可以质疑，可以监督。就算报道不够准确，有误差，更正即可。即便要道歉，那也该对读者，哪有向监督对象道歉的道理？这是典型的不知道自己错在哪里。\n\n不会认错，也就不会批评，甚至不会提问。比方说，开口就问人家的动机，甚至预设一个“道德污名”，问人家是不是。同样，要为自己或自己人辩护，也是拿对方的动机做文章。其实动机这事，往往无法证明。既不能证实，也不能证伪，毫无意义。有分量的批评，都是摆事实、讲道理，或者看事实有没有出入，或者看逻辑有没有漏洞，然后“以子之矛，攻子之盾”。可惜，这种方法，我们常常不会。\n\n实际上，对自己缺乏反省的人，也很难真正地了解别人。自己的错误都不能发现，又岂能抓住别人的要害？也只能纠缠于表面现象和枝节问题。大家都不讲事实，不讲道理，思维能力和国民素质的提高，恐怕就成了永无期日的事。认错，是不是很重要？\n\n5.学会认错待何时\n\n那么，我们何时才能学会认错？恕我直言，恐怕任重而道远。别的不说，面子这关，就多半过不去。\n\n中国人的心理很奇怪。一方面，大家都知道“瓜无滚圆，人无十全”；另一方面，又往往不能容忍别人出错，更不能容忍别人挑错。在我们看来，犯错误是丢人的。犯了错误又被“揪出来”，就更丢人。这人如果还是政要、名流，是商海巨鳄、江湖大佬、学界领袖，那就丢死人了。不但自己丢人，还会连带亲朋好友、哥们姐们、徒子徒孙，一起没有脸面。\n\n因此，不但自己不能认账，粉丝拥趸们也要一哄而上，百般抵赖，誓死捍卫。哪怕说得漏洞百出、逻辑不通，也得死扛着。死扛着也振振有词：对社会名流和成功人士的追究，会导致斯文扫地、体面无存，打击我们民族的自信心。\n\n这可真是奇谈怪论！难道我们民族的脸面是纸糊的，一捅就破？难道我们民族的自信是塑料的，一烤就化？真金不怕火炼，事实就是事实。认不认，事实都不会变。不认，只能显得心虚；认账，则至少像条汉子。比较一下，哪个更体面，哪个更丢人？\n\n我同意凡事不可过头，更反对“全民扒粪”，那将变成第二次“文革”，第二次“斗私批修”。但宽容的前提是认账。认账不等于认错。认错是承认错误，认账是承认事实。认账之后，错与非错，还可以讨论商量。但如果连事实都不承认，那就什么都谈不上。因此第一步，是要先学会认账，即弄清事实。这是“真伪判断”。然后，才能讨论是对是错。这是“是非判断”。至于“价值判断”和“道德判断”，只能放在最后，甚至未必一定要有。\n\n可惜中国人的思维习惯，往往是反着的。事情还没有弄清楚，道德批判就先开始了。这样一来，谁还敢认错？只怕连账，都不敢认。“事实判断”都难如蜀道，“纠错机制”岂非侈谈？我们前面的路，还真不知道有多长。', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160810/df70fceef7e28ca7.jpg\",\"smallUrl\":\"/Uploads/Picture/20160810/s_df70fceef7e28ca7.jpg\",\"id\":\"fe253ee189db3f49b90f3c01bfedb61b\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20160810/fe89f96ade3c4dda.jpg\",\"smallUrl\":\"/Uploads/Picture/20160810/s_fe89f96ade3c4dda.jpg\",\"id\":\"bde4693469b0cff4b1a9d301d145a6db\"},{\"key\":\"images3\",\"originUrl\":\"/Uploads/Picture/20160810/3be41170e4c60939.jpg\",\"smallUrl\":\"/Uploads/Picture/20160810/s_3be41170e4c60939.jpg\",\"id\":\"d58701a4a587d615dbfc1307061303aa\"}]', '', '云南省昆明市盘龙区九龙湾公路', '25.106947', '102.779759', '1', '0', '', '全国', '1470761051');
INSERT INTO `tc_share` VALUES ('100', '0', '20000088', '25', '', '', '美不', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160810/7f7e0bae95c72e1a.jpg\",\"smallUrl\":\"/Uploads/Picture/20160810/s_7f7e0bae95c72e1a.jpg\",\"id\":\"c185108f54d22db4ca28b00c7d8b9d4a\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20160810/3beef7ef4f8f6e27.jpg\",\"smallUrl\":\"/Uploads/Picture/20160810/s_3beef7ef4f8f6e27.jpg\",\"id\":\"badb5c67a132bd37b53b8a69ad7fc630\"},{\"key\":\"images3\",\"originUrl\":\"/Uploads/Picture/20160810/20db9e7f930584ea.jpg\",\"smallUrl\":\"/Uploads/Picture/20160810/s_20db9e7f930584ea.jpg\",\"id\":\"77967601f1d9574a28f344f0d34c0fa9\"},{\"key\":\"images4\",\"originUrl\":\"/Uploads/Picture/20160810/e0cdbc5d265d735c.jpg\",\"smallUrl\":\"/Uploads/Picture/20160810/s_e0cdbc5d265d735c.jpg\",\"id\":\"589150e0a7fe1e394ca9ac5c4ae14805\"}]', '', '福建省泉州市晋江市海丰路', '24.800606', '118.633108', '0', '0', '', '泉州市', '1470829539');
INSERT INTO `tc_share` VALUES ('102', '0', '20000092', '1', '', '', '分享图片', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160812/e1fe85b63252071b.jpg\",\"smallUrl\":\"/Uploads/Picture/20160812/s_e1fe85b63252071b.jpg\",\"id\":\"fd5dfc1222d92d9d8a3cd62142471f0a\"}]', '', '汉中市', '33.148256', '107.324613', '0', '0', '', '汉中市', '1471009049');
INSERT INTO `tc_share` VALUES ('103', '98', '20000090', '1', '', '', '这是', '', '', '成都市', '30.739013', '103.978854', '1', '1', '', '成都市', '1471493901');
INSERT INTO `tc_share` VALUES ('104', '0', '20000092', '2', '', '', '真的不知道要把内心说给谁听 我只能告诉自己 等血流干了 心就不会再疼了 加油吧 赶快流～～', '', '', '汉中市', '33.148086', '107.324730', '0', '0', '', '汉中市', '1472168245');
INSERT INTO `tc_share` VALUES ('105', '0', '20000092', '25', '', '', '第一次这么认真的爱一个人 却让我如此伤心 终于体会什么叫痛彻心屝 歇斯底里 早知道是这样的结果为什么让我认识你', '', '', '汉中市', '33.148086', '107.324730', '0', '0', '', '汉中市', '1472168643');
INSERT INTO `tc_share` VALUES ('106', '0', '20000092', '25', '', '', '拼命的让自己不要想  可是心不由我 血还在继续的流着 感觉快没力气了 可能快了吧 能不能再快点 让我解脱了 真的很痛苦啊', '', '', '汉中市', '33.148086', '107.324730', '0', '0', '', '汉中市', '1472168931');
INSERT INTO `tc_share` VALUES ('107', '0', '20000002', '0', '1', '', '西游记的境界极高，鲜有人深入理解\n\n相信大家都喜欢《西游记》中悟空的72般变化，唐僧的执着，八戒的随性，沙僧的任劳任怨，白龙马的意念；钟情于作者的场景设置与人物刻画，敬佩制作团队的水平与努力，还有带给大家对于商业上的启发与思考。但作者吴承恩在开篇写到“欲知造化会元功，须看西游释厄传。”，意思就是“要想知道人生的真谛，那就必须看西游记！”。可惜，看懂《西游记》的人实在太少！\n\n羡慕悟空的72般变化，唐僧的执着，八戒的随性，沙僧的任劳任怨，白龙马的意念。当你有一天真正读懂了《西游记》，你也就懂得了世间所有苦难的真谛，也就懂得了整个人生的真谛！小孩子是根本读不懂西游记的。个人认为，《西游记》可排在四大名著之首！而且它还是世间最伟大的一部成功学！看似是打妖怪的故事，其实是告诉人们如何战胜心魔的成功学。吴承恩通过西天取经的神话故事，引领我们在人生路上不断地去克服内心、战胜心魔，最终取得真经、成就人生。\n\n《西游记》中，孙悟空、唐僧、猪八戒、沙和尚、白龙马这师徒五人只是一个人！孙悟空是人的心，唐僧是人的身，猪八戒是人的情欲，沙和尚是人的本性，白龙马是人的意志力。\n\n孙悟空是斜月三星洞中菩提祖师的弟子，“斜月三星”就是个心字（斜月不就是那一勾吗？三星不就是那三点吗？），所以孙悟空是心的弟子，也是心。这一颗骚动不安的心，于天堂地狱善恶之间自由穿梭。《楞严经》上说心有七十二相，悟空也就有72变，世人的心非常善变，瞬息间七十二变。金箍棒一万三千五百斤，《黄帝八十一难经》上说“人昼夜呼吸一万三千五百息”，所以金箍棒是气。什么东西能够上至三十三天，下至十八层地狱；大能通天，小之则如绣花针呢？不就是人的气度吗？\n\n炼心能使人的心眼明亮，灼亮心眼，所以八卦炉烧不死反而能让孙悟空炼成火眼金睛（悟空的眼睛明亮了，象征着心眼明亮了）。孙悟空一个筋斗十万八千里，也逃不出如来佛的手掌心。五行山压住悟空，象征着世俗世界的金木水火土那样强大地压住了那颗上天入地的心。五行山也象征着佛学中的“贪、嗔、痴、慢、疑”，佛祖说这五个字概括了一切人的身行心念，即便是孙悟空，依旧逃不出这五个字。闹天宫时的孙悟空正是被这五毒所困。现实中，又有多少佛门弟子，自以为有所悟，精心力修“戒、定、慧”，到头来依旧不离“贪、嗔、痴”，只因不了解“贪、嗔、痴”的本质。五行山后为两界山，过了这一山，曾经那颗骚动不安的心终于跳出三界了。\n\n 孙悟空一个筋斗就十万八千里，正好是灵山的距离，什么意思呢？意思就是：灵山再远也就是心的一个念头就到了！善恶只在一念之间，一念就可成佛，一念也可成魔。师徒五人在西天路上打妖怪，其实指的就是一个人在人生路上除心魔，取经就是一个修心的过程。真正的灵山，就在我们的心中。这也就是孙悟空常常对唐僧说的那句话：“只要你见性志成，念念回首处，即是灵山！”，还有唐僧刚开始踏上取经路时，乌巢禅师传授他一部《心经》，并且也对他说：“佛在灵山莫远求，灵山只在汝心头。”但是唐僧听不懂啥意思，最后直到抵达灵山，由孙悟空点醒了他之后，他才明白。因为要靠心来点醒自己，才能明白，而且那时候心魔全都除掉了，也就领悟了。\n\n“定心真言”紧箍咒能定心、约束心，让心疼了又疼。收伏悟空之后，也就归正了那颗七十二变的心。孙悟空一上路就打死了六个强盗，在原著中，六个强盗的名字分别是“眼看喜、耳听怒、鼻嗅爱、舌尝思、身本忧、意见欲”，这就是六根。孙悟空打死了六根，说明六根清净乃取经之本。白龙马是意志力，人的意志起初就像野马，只有确定了前进的目标，才能专心专意的取得真经。收伏小白龙，达到心意合一，只要心意合一，志向坚定，没有到不了的西天。后来又收了八戒和沙僧，“身、心、情、性、意”这个最完美的团队就组成了。\n\n西天路上，悟空化斋前经常在地上划一个圈，这是心给人定的界限，但人的身体（唐僧）总是会被欲望（猪八戒）牵着走！于是人（师徒几个）就容易离开内心（悟空）设定的界限（划的圈），于是一出界限便遇上种种心魔（妖怪）。\n\n心（悟空）引领着人（师徒几个）不断前进，一路上悟空降妖，说的就是心去降心魔。西天路上的每一个妖怪都是有含义的！所有的妖怪全都是一个比喻！全都是心魔的幻化。每一个妖怪所代表的都是世间那些牵绊人的东西，都是一个人自己的心魔！西天取经的过程就是一个人去除心魔的过程。师徒五人在取经路上不断的去除妖怪，指的就是一个人在人生路上不断的战胜心魔！\n\n例如，黑熊怪是心魔，悟空的嗔念使他催火烧了观音禅院，于是出现了阻碍他成佛的心魔，于是黑熊怪就来了。\n\n牛魔王也是悟空心魔所变，红孩儿、牛魔王、火焰山都是心头上的火焰。牛魔王与悟空为结拜兄弟，又势均力敌，所以发火就是自己跟自己较劲。火焰山形成原因是早年孙悟空踢下一块火砖，火焰山大火正是悟空出八卦炉后为出一口恶气而放的，到头来却烧伤了自己。火焰山这一难是由孙悟空早年顽空之心所生，所以说“牛王本是心猿变”，要“打破顽空参佛面”，在这里孙悟空剪除了顽空之心。\n\n红孩儿象征着仇恨之火，一个人活在仇恨中，到头来只会烧伤自己的心（红孩儿烧伤了悟空）。此外，红孩儿还象征着“赤子”，我们要保住赤子之心。“大人者，不失其赤子之心也”，在人生路上保住赤子之心，不要被自己的“三昧真火”烧毁了，要保住那份童心（赤子被菩萨保住了）。\n\n黄风怪会吹三昧神风，他代表社会风气，社会风气能使人心（悟空）迷失方向。\n\n白骨精的三个形象分别代表了一个人的情、爱、欲，心将它们全部打死，说明在人生的路上我们一定要控制好自己的情、爱、欲，不要让其成为我们前进的障碍。此外，白骨精也象征人皮面具，人皮面具（白骨精）能引出人的本能欲望（所以猪八戒开始挑拨离间），使人迷失了自己的内心（所以唐僧把孙悟空赶走了），人总是会被世间种种美丽表象所迷。\n\n金钱（金角大王、银角大王）能把人心捆住、封住，难以逃脱。作者将这个道理比喻成了金角大王和银角大王用幌金绳把孙悟空捆住了，用紫金葫芦把孙悟空封住了。后面在小西天，冒充佛祖的那个黄眉怪用金铙把孙悟空封住了，金铙这个法宝也象征金钱，金钱能把心困住。\n\n七个蜘蛛精代表人的七情六欲，七情六欲就像蜘蛛结的网一样，能把人困住。世人因思（丝）生情，被情丝缠绕。蜈蚣精身上有千只眼睛，乃是人眼所见的各种物质欲望的象征。\n\n蝎子精代表美色，美色就像蝎子一样会勾人，所以师徒几个都敌不过她。\n\n真假美猴王，一个真心向佛的悟空击败了一个不真心向佛的悟空，其实是自己的两种意志互斗，是一个人的两颗心。书中很明确的说到这一难是由师徒四人的心魔所生，孙悟空的“神狂之心”，唐僧不辨真假的“道昧之心”，猪八戒沙僧不肯说情的“嫉妒之心”，师徒师兄弟之间的“猜忌之心”。生出了“二心”，就必须除掉第二颗心，只有打消二心，一心一意，才能取得成功！所以假孙悟空被打死了，师徒几人才得以继续上路。\n\n在比丘国，鹿精要吃一千个小孩的心，象征“多心”。孙悟空变做假唐僧，比喻这时的唐僧和悟空合二为一，他剖开自己的肚皮滚出了一堆心来，也是象征“多心”。我们常说“心头鹿撞”，人有“二心”就会生出灾祸，更何况这多心。收服了这个鹿精，心头也就没有鹿撞，“多心”就会变成“一心”，只有一心一意才能成功。\n\n悟空三兄弟好为人师，在玉华州收了国王的三个儿子为徒弟，教他们习武。好为人师，不谦虚，因此惹出一窝狮子精。狮者，师也。\n\n九灵元圣是西天路上最厉害的妖怪之一，是一只九头狮子，可妙擒孙悟空。九头狮子象征“九思”，孔子曰：“君子有九思。”，一个人如果做到了九思就可以成圣，九思成圣，所以叫九灵元圣。\n\n九思分别指的是:\n\n1）视思明：当我们看事物时，要看清事物的真相，不要被事物的假像所蒙蔽。\n\n2）耳思聪：如果我们能管住我们的耳朵，辨别出真假是非，那我们将不再被外物所伤。\n\n3）色思温：色代表情绪，温代表喜怒哀乐皆不发。成大事，情绪控制要达到喜怒哀乐皆不发。\n\n4）貌思恭：貌代表形为，恭代表恭敬心，做任何事都应有一份恭敬心去对待。\n\n5）言思忠：言代表言语，此句意为不说谎话。\n\n6）事思敬：敬代表全力以赴，做任何事都应全心全意的去做。\n\n7）疑思问：“君子不耻下问”就为此理。\n\n8）忿思难：忿代表忿忿不平，生气的时候要想到后果灾难，不可以意气用事。当我们遇到别人对自己发火时，也应该换位思考一下他的难处，可能就不再生气了。\n\n9）见得思义：君子看到的都是义，小人看到的都是利。无论别人给予了我们多少，我们都要滴水之恩当涌泉相报。做到了这九思，就可成圣了。孙悟空代表的只是世人之心，怎么可能打得过已成圣的九灵元圣？\n\n师徒在寇员外家里借宿，遭遇打劫，寇员外被强盗打死，唐僧被冤枉入狱。寇员外姓寇而被寇，唐僧求道而得盗，因为善恶不过是一念间。\n\n最后的玉兔精，真假公主，求真去假之后，离真理也就不远了。\n\n对唐僧师徒而言，历经磨难，去除了一路上的妖魔鬼怪，终于到达灵山了，也就成佛了。对一个人而言，克服了自身的种种习气，魔障消灭，即见灵山。\n\n最后心（孙悟空）被封为斗战圣佛，无论我们从事什么，只要懂得约束自己的内心，终可成功。身体（唐僧）被封为旃檀功德佛，做人要心身合一，才能得真经。情欲（猪八戒）被封为净坛使者，情欲是戒不掉的，所以最终只被封为使者。本性（沙和尚）被封为金身罗汉，因为本性像金一样珍贵。意志力（白龙马）被封为八部天龙护法，我们要时刻捍卫自己的意念，所以被封为护法。\n\n至于书中那些形形色色的国 家里所发生的荒诞怪事则是对当时社会的辛辣讽刺。狮驼城是一个巨大的妖精王国，也是黑暗时代的一个巨大折射。\n\n最后佛祖之所以给师徒无字经，是因为无字经才是真经，无字经的“经”是“经历”的意思，这一路上的“经历”才是更重要的“经”，远远胜过那些个文字。一个人，若在经历世间一切事之后，依然能保持一颗真心，即使未到西天，而心中早已成佛。坚定不移，寓为金刚，既然心已成金刚，那么心头（悟空的头）上的金刚箍便不必存在了。佛之经典，正为《金刚经》。\n\n同一个人在不同的时期读同一段文字，他的体会是不一样的。比如《西游记》，同一个人在几岁时读和二十几岁读，他的体会是完全不同的！再过二十年再读，体会又会不同！\n\n吴承恩在开篇写到“欲知造化会元功，须看西游释厄传。”，意思就是“要想知道人生的真谛，那就必须看西游记！”。\n\n可惜，看懂《西游记》的人实在太少。', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160902/40d4d53944ecc4d7.jpg\",\"smallUrl\":\"/Uploads/Picture/20160902/s_40d4d53944ecc4d7.jpg\",\"id\":\"d7013f49243e0fc9148b97b861ee2e12\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20160902/9522f1e8880fc499.jpg\",\"smallUrl\":\"/Uploads/Picture/20160902/s_9522f1e8880fc499.jpg\",\"id\":\"1faa0024297774366bb356f5898962d6\"},{\"key\":\"images3\",\"originUrl\":\"/Uploads/Picture/20160902/6ba9e38b120ffd20.jpg\",\"smallUrl\":\"/Uploads/Picture/20160902/s_6ba9e38b120ffd20.jpg\",\"id\":\"8fa6843e92b89dd7f25d5622c12c2f2a\"},{\"key\":\"images4\",\"originUrl\":\"/Uploads/Picture/20160902/06431e87d5b29636.jpg\",\"smallUrl\":\"/Uploads/Picture/20160902/s_06431e87d5b29636.jpg\",\"id\":\"3cbee4d91f49ed9d31654202f3b23049\"}]', '', '全国', '25.106851', '102.779696', '1', '0', '', '全国', '1472804421');
INSERT INTO `tc_share` VALUES ('108', '0', '20000002', '0', '1', '', '常被人问文化常识，以备不时之需~\n\n【五脏】心、肝、脾、肺、肾\n\n【六腑】胃、胆、三焦、膀胱、大肠、小肠\n\n【七情】喜、怒、哀、乐、爱、恶、欲\n\n【五常】仁、义、礼、智、信\n\n【五伦】君臣、父子、兄弟、夫妇、朋友\n\n【三姑】尼姑、道姑、卦姑\n\n【六婆】牙婆、媒婆、师婆、虔婆、药婆、稳婆\n\n【九属】玄孙、曾孙、孙、子、身、父、祖父、曾祖父、高祖父\n\n【五谷】稻、黍、稷、麦、豆\n\n【中国八大菜系】四川菜、湖南菜、山东菜、江苏菜、浙江菜、广东菜、福建菜、安徽菜\n\n【五毒】石胆、丹砂、雄黄、矾石、慈石\n\n【配药七方】大方、小方、缓方、急方、奇方、偶方、复方\n\n【五彩】青、黄、赤、白、黑\n\n【五音】宫、商、角、徵、羽\n\n【七宝】金、银、琉璃、珊瑚、砗磲、珍珠、玛瑙\n\n【九宫】正宫、中吕宫、南吕宫、仙吕宫、黄钟宫、大面调、双调、商调、越调\n\n【七大艺术】绘画、音乐、雕塑、戏剧、文学、建筑、电影\n\n【四大名瓷窑】河北的瓷州窑、浙江的龙泉窑、江西的景德镇窑、福建的德化窑\n\n【四大名旦】梅兰芳、程砚秋、尚小云、荀慧生\n\n【六礼】冠、婚、丧、祭、乡饮酒、相见\n\n【六艺】礼、乐、射、御、书、数\n\n【六义】风、赋、比、兴、雅、颂\n\n【八旗】镶黄、正黄、镶白、正白、镶红、正红、镶蓝、正蓝\n\n【十恶】谋反、谋大逆、谋叛、谋恶逆、不道、大不敬、不孝、不睦、不义、内乱\n\n【九流】儒家、道家、阴阳家、法家、名家、墨家、纵横家、杂家、农家\n\n【三山】安徽黄山、江西庐山、浙江雁荡山\n\n【五岭】越城岭、都庞岭、萌诸岭、骑田岭、大庾岭\n\n【五岳】〖中岳〗河南嵩山、〖东岳〗山东泰山、〖西岳〗陕西华山、〖南岳〗湖南衡山、〖北岳〗山西恒山\n\n【五湖】鄱阳湖〖江西〗、洞庭湖〖湖南〗、太湖〖江苏〗、洪泽湖〖江苏〗、巢湖〖安徽〗\n\n【四海】渤海、黄海、东海、南海\n\n【四大名桥】广济桥、赵州桥、洛阳桥、卢沟桥\n\n【四大名园】颐和园〖北京〗、避暑山庄〖河北承德〗、拙政园〖江苏苏州〗、留园〖江苏苏州〗\n\n【四大名刹】灵岩寺〖山东长清〗、国清寺〖浙江天台〗、玉泉寺〖湖北江陵〗、栖霞寺〖江苏南京〗\n\n【四大名楼】岳阳楼〖湖南岳阳〗、黄鹤楼〖湖北武汉〗、滕王阁〖江西南昌〗、大观楼〖云南昆明〗\n\n【四大名亭】醉翁亭〖安徽滁县〗、陶然亭〖北京先农坛〗、爱晚亭〖湖南长沙〗、湖心亭〖杭州西湖〗\n\n【四大古镇】景德镇〖江西〗、佛山镇〖广东〗、汉口镇〖湖北〗、朱仙镇〖河南〗\n\n【四大碑林】西安碑林〖陕西西安〗、孔庙碑林〖山东曲阜〗、地震碑林〖四川西昌〗、南门碑林〖台湾高雄〗\n\n【四大名塔】嵩岳寺塔〖河南登封嵩岳寺〗、飞虹塔〖山西洪洞广胜寺〗、释迦塔〖山西应县佛宫寺〗、千寻塔〖云南大理崇圣寺〗\n\n【四大石窟】莫高窟〖甘肃敦煌〗、云岗石窟〖山西大同〗、龙门石窟〖河南洛阳〗、麦积山石窟〖甘肃天水〗\n\n【四大书院】白鹿洞书院〖江西庐山〗、岳麓书院〖湖南长沙〗、嵩阳书院〖河南嵩山〗、应天书院〖河南商丘〗\n\n【四大佛教名山】浙江普陀山〖观音菩萨〗、山西五台山〖文殊菩萨〗、四川峨眉山〖普贤菩萨〗、安徽九华山〖地藏王菩萨〗\n\n【四大道教名山】湖北武当山、江西龙虎山、安徽齐云山、四川青城山\n\n【五行】金、木、水、火、土\n\n【八卦】乾〖天〗、坤〖地〗、震〖雷〗、巽〖风〗、坎〖水〗、离〖火〗、艮〖山〗、兑〖沼〗\n\n【三皇】伏羲、女娲、神农\n\n【五帝】五帝有五种说法\n①黄帝、颛顼、帝喾、尧、舜\n②宓戏（伏羲）、神农、黄帝、尧、舜\n③太昊、炎帝、黄帝、少昊、颛顼\n④少昊、颛顼、帝喾、尧、舜\n⑤黄帝、少昊、颛顼、喾、尧\n其中第三种说法最为流行，意指东西南北中五个方位的天神，东方太昊，南方炎帝，西方少昊，北方颛顼，中央黄帝。\n\n【三教】儒教、道教、佛教\n\n【三清】元始天尊〖清微天玉清境〗、灵宝天尊〖禹余天上清境〗、道德天尊〖大赤天太清境〗\n\n【四御】昊天金阙无上至尊玉皇大帝、中天紫微北极大帝、勾陈上宫天后皇大帝、承天效法土皇地祗\n\n【八仙】铁拐李、钟离权、张果老、吕洞宾、何仙姑、蓝采和、韩湘子、曹国舅\n\n【十八罗汉】布袋罗汉、长眉罗汉、芭蕉罗汉、沉思罗汉、伏虎罗汉、过江罗汉、欢喜罗汉、降龙罗汉、静坐罗汉、举钵罗汉、开心罗汉、看门罗汉、骑象罗汉、探手罗汉、托塔罗汉、挖耳罗汉、笑狮罗汉、坐鹿罗汉\n\n【十八层地狱】[第一层]泥犁地狱、[第二层]刀山地狱、[第三层]沸沙地狱、[第四层]沸屎地狱、[第五层]黑身地狱、[第六层]火车地狱、[第七层]镬汤地狱、[第八层]铁床地狱、[第九层]盖山地狱、[第十层]寒冰地狱、[第十一层]剥皮地狱、[第十二层]畜生地狱、[第十三层]刀兵地狱、[第十四层]铁磨地狱、[第十五层]寒冰地狱、[第十六层]铁册地狱、[第十七层]蛆虫地狱、[第十八层]烊铜地狱\n\n【四大名绣】苏绣〖苏州〗、湘绣〖湖南〗、蜀绣〖四川〗、广绣〖广东〗\n\n【四大名扇】檀香扇〖江苏〗、火画扇〖广东〗、竹丝扇〖四川〗、绫绢扇〖浙江〗\n\n【四大名花】牡丹〖山东菏泽〗、水仙〖福建漳州〗、菊花〖浙江杭州〗、山茶〖云南昆明〗\n\n【十大名茶】\n西湖龙井〖浙江杭州西湖区〗\n碧螺春〖江苏吴县太湖的洞庭山碧螺峰〗\n信阳毛尖〖河南信阳车云山〗\n君山银针〖湖南岳阳君山〗\n六安瓜片〖安徽六安和金寨两县的齐云山〗\n黄山毛峰〖安徽歙县黄山〗\n祁门红茶〖安徽祁门县〗\n都匀毛尖〖贵州都匀县〗\n铁观音〖福建安溪县〗\n武夷岩茶〖福建崇安县〗\n\n【年龄称谓】\n襁褓：未满周岁的婴儿\n孩提：指2——3岁的儿童\n垂髫：指幼年儿童（又叫“总角”）\n豆蔻：指女子十三岁\n及笄：指女子十五岁\n加冠：指男子二十岁（又“弱冠”）\n而立之年：指三十岁\n不惑之年：指四十岁\n知命之年：指五十岁（又“知天命”、“半百”）\n花甲之年：指六十岁\n古稀之年：指七十岁\n耄耋之年：指八、九十岁\n期颐之年：一百岁\n\n【古代主要节日】\n元日：正月初一，一年开始。\n人日：正月初七，主小孩。\n上元：正月十五，张灯为戏，又叫“灯节”\n社日：春分前后，祭祀祈祷农事。\n寒食：清明前两日，禁火三日（介子推）\n清明：四月初，扫墓、祭祀。\n端午：五月初五，吃粽子，划龙（屈原）\n七夕：七月初七，妇女乞巧（牛郎织女）\n中元：七月十五，祭祀鬼神，又叫“鬼节”\n中秋：八月十五，赏月，思乡\n重阳：九月初九，登高，插茱萸免灾\n冬至：又叫“至日”，节气的起点。\n腊日：腊月初八，喝“腊八粥”\n除夕：一年的最后一天的晚上，初旧迎新\n\n【婚姻周年】第1年纸婚、第2年棉婚、第3年皮革婚、第4年水果婚、第5年木婚、第6年铁婚、第7年铜婚、第8年陶婚、第9年柳婚、第10年铝婚、第11年钢婚、第12年丝婚、第13年丝带婚、第14年象牙婚、第15年水晶婚、第20年瓷婚、第25年银婚、第30年珍珠婚、第35年珊瑚婚、第40年红宝石婚、第45年蓝宝石婚、第50年金婚、第55年绿宝石婚、第60年钻石婚、第70年白金婚\n\n【科举职官】〖乡试〗：录取者称为\"举人\"，第一名称为\"解元\"、〖会试〗：录取者称为\"贡生\"，第一名称为\"会元\"、〖殿试〗：录取者称为\"进士\"，第一名称为\"状元\"，第二名为\"榜眼\"，第三名为\"探花\"\n\n【四书】《论语》、《中庸》、《大学》、《孟子》\n\n【五经】《诗经》、《尚书》、《礼记》、《易经》、《春秋》\n\n【八股文】破题、承题、起讲、入手、起股、中股、后股、束股\n\n【六子全书】《老子》、《庄子》、《列子》、《荀子》、《扬子法言》、《文中子中说》\n\n【汉字六书】象形、指事、形声、会意、转注、假借\n\n【书法九势】落笔、转笔、藏峰、藏头、护尾、疾势、掠笔、涩势、横鳞竖勒\n\n【竹林七贤】嵇康、刘伶、阮籍、山涛、阮咸、向秀、王戎\n\n【饮中八仙】李白、贺知章、李适之、李琎、崔宗之、苏晋、张旭、焦遂\n\n【蜀之八仙】容成公、李耳、董促舒、张道陵、严君平、李八百、范长生、尔朱先生\n\n【扬州八怪】郑板桥、汪士慎、李鱓、黄慎、金农、高翔、李方鹰、罗聘\n\n【北宋诗文四大家】黄庭坚、欧阳修、苏轼、王安石\n\n【唐宋古文八大家】韩愈、柳宗元、欧阳修、苏洵、苏轼、苏辙、王安石、曾巩\n\n【十三经】《易经》、《诗经》、《尚书》、《礼记》、《仪礼》、《公羊传》、《榖梁传》、《左传》、《孝经》、《论语》、《尔雅》、《孟子》\n\n【四大民间传说】《牛郎织女》、《孟姜女》、《梁山伯与祝英台》、《白蛇与许仙》\n\n【四大文化遗产】《明清档案》、《殷墟甲骨》、《居延汉简》、《敦煌经卷》\n\n【元代四大戏剧】关汉卿《窦娥冤》、王实甫《西厢记》、汤显祖《牡丹亭》、洪升《长生殿》\n\n【晚清四大谴责小说】李宝嘉《官场现形记》、吴沃尧《二十年目睹之怪现状》、刘鹗《老残游记》、曾朴《孽海花》\n\n常用三叠字\n三个田念畾（lěi）\n三个马念骉（biāo）\n三个羊念羴（shān）\n三个犬念猋（biāo）\n三个鹿念麤（cū）\n三个鱼念鱻（xiān）\n三个贝念赑（bì）\n三个力念劦（lie）\n三个毛念毳（cuì）\n三个耳念聶（niè）\n三个车念轟（hōng）\n三个直念矗（chù）\n三个龙念龘（tà、dá）\n三个原念厵（yuán）\n三个雷念靐（bìng）\n三个飞念飝（fēi）\n三个刀念刕（lí）\n三个又念叒（ruò）\n三个士念壵（zhuàng）\n三个小念尛（mó）\n三个子念孨（zhuǎn）\n三个止念歮（sè）\n三个风念飍（xiū）\n三个隼念雥（zá）\n三个吉念嚞（zhé）\n三个言念譶（tà）\n三个舌念舙（qì）\n三个香念馫（xīn）\n三个泉念灥（xún）\n三个心念惢（suǒ）\n三个白念皛（xiǎo）', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20160925/fb355cc837e713ab.jpg\",\"smallUrl\":\"/Uploads/Picture/20160925/s_fb355cc837e713ab.jpg\",\"id\":\"ee5c0d988a0556538c70db60f771db94\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20160925/058038f8288839dc.jpg\",\"smallUrl\":\"/Uploads/Picture/20160925/s_058038f8288839dc.jpg\",\"id\":\"e4f8209c7d50140eb8101d1808b207a6\"},{\"key\":\"images3\",\"originUrl\":\"/Uploads/Picture/20160925/5544667b183d93f4.jpg\",\"smallUrl\":\"/Uploads/Picture/20160925/s_5544667b183d93f4.jpg\",\"id\":\"5e206f0fcf5a53393fbf5544dc5fd9e8\"}]', '', '全国', '25.106774', '102.779693', '1', '0', '', '全国', '1474782585');
INSERT INTO `tc_share` VALUES ('109', '0', '20000115', '1', '', '', '西天取经，六耳猕猴混来进来，真假美猴王只有唐僧能分辨出来。 唐僧说:“为师想吃桃子。” 两猴犹豫了一下，都变成了桃子。 突然唐僧大喊:“八戒，给我\n\n拿下那只猕猴桃！”', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20161015/c5f10fc7817d65ca.png\",\"smallUrl\":\"/Uploads/Picture/20161015/s_c5f10fc7817d65ca.png\",\"id\":\"1012876951dbc94aba90234316526a79\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20161015/b71cbc23026108ef.png\",\"smallUrl\":\"/Uploads/Picture/20161015/s_b71cbc23026108ef.png\",\"id\":\"99bd5372e1dd4c06406c257b55b4d9f3\"}]', '', '学林雅苑', '30.741923', '103.987837', '0', '0', '', '成都市', '1476541355');
INSERT INTO `tc_share` VALUES ('110', '0', '20000198', '25', '', '', '无聊', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20161106/201c817629be76ff.jpg\",\"smallUrl\":\"/Uploads/Picture/20161106/s_201c817629be76ff.jpg\",\"id\":\"035e74211e44f30b7fe368d980ef7f95\"}]', '', '河北省邯郸市邱县', '36.855903', '115.266001', '0', '0', '', '邯郸市', '1478444369');
INSERT INTO `tc_share` VALUES ('111', '109', '20000096', '1', '', '', '这[emoji_94]', '', '', '成都高新技术创新服务中心', '30.738012', '103.978423', '1', '1', '', '成都市', '1479437620');
INSERT INTO `tc_share` VALUES ('112', '0', '20000209', '2', '', '', '俺不会玩[emoji_87]！', '', '', '锦州市', '41.186643', '121.387231', '0', '0', '', '锦州市', '1479467002');
INSERT INTO `tc_share` VALUES ('113', '0', '20000025', '2', '', '', '云南32批次食品不合格！这种知名面包菌落总数超标186倍！\n\n　　日前，云南省食药监局公布了2016年第40期食品抽检情况，有32批次不合格食品上榜。其中云南达利食品有限公司生产的“达利园”法式软面包（360克/包，生产日期/批号2016/6/30）被检出菌落总数超标，超过国家标准186倍！\n\n　　本期公告的食品安全监督抽检产品为饼干、饮料等。抽检按照食品安全标准及产品明示标准和指标进行检验。完成样品检验265批次，公告抽检合格样品233批次、抽检不合格样品32批次。\n\n　　不合格样品涉及的标称生产单位、产品和不合格指标为：\n\n　　云南普洱市宁洱县东龙山泉水厂生产的饮用山泉水（东龙山泉水）、宁洱阳光山泉饮用水厂生产的天然饮用山泉水（阳光山泉）、云南恒阳实业有限公司物业管理分公司生产的恒阳纯净水均铜绿假单胞菌不合格；\n\n　　昆明乡仔王食品有限公司生产的综合蔬果干、昆明乡仔王食品有限公司生产的菠萝蜜薯干果、云南连宸食品有限公司生产的傣家寨（菠萝丁）、通海佳洲蓝莓专业合作社生产的佳洲高原蓝莓红酒均环己基氨基磺酸钠（甜蜜素）不合格；\n\n　　昆明古凤食品有限公司生产的菠萝蜜、弥勒市竹园镇德伟清真食品厂生产的蛋清饼（烘烤类糕点）、云南大不同民族工艺品制造有限公司生产的映象杏仁酥、昌宁县田园镇春意蛋糕城生产的金钱酥和桃酥、云南省宣威市宣特火腿有限公司生产的原味鲜花饼、云南达利食品有限公司生产的达利园法式软面包、昆明进旺晶贸易有限公司生产的金牌园派蛋黄派、云南唛淇啉食品有限公司生产的巧克力冰淇淋（半乳脂清型冰淇淋）均菌落总数超标；\n\n　　曲靖市文火饮食文化有限公司生产的曲靖小粑粑（地道伍仁饼）和曲靖小粑粑（满口香苏子饼）、会泽佳心食品有限公司生产的宝鹤食品（酥麻花）、大理市佳欣糕点厂生产的乳扇萨其马、易门口口佳乐食品有限公司生产的三香荞饼（月饼）、曲靖市文火饮食文化有限公司生产的经典红豆沙饼、昆明进旺晶贸易有限公司生产的金牌园派蛋黄派均铝的残留量不合格；\n\n　　昆明进旺晶贸易有限公司生产的金牌园派蛋黄派、上郑园蛋黄味蛋黄派、金牌香芋派（注心蛋类芯饼）均防腐剂各自用量占其最大使用量比例之和不合格；\n\n　　云南唛淇啉食品有限公司生产的巧克力冰淇淋（半乳脂清型冰淇淋）大肠菌群超标；\n\n　　云南连宸食品有限公司生产的傣家寨（菠萝丁）二氧化硫残留量超标；\n\n　　昆明涵硕工贸有限公司生产的白砂糖色值不合格；\n\n　　杨艳琼生产的火腿肉三甲胺氮不合格；\n\n　　昆明山苗食品有限公司生产的香酥猪蹄商业无菌不合格；\n\n　　荆州市德力兴食品有限公司生产的猴菇饼干二丁基羟基甲苯不合格；\n\n　　红河州碗碗香粮油贸易有限公司生产的（碗碗香）大米镉超标；\n\n　　云南一条龙企业集团生物科技有限公司生产的香辣酱氨基酸态氮不合格；\n\n　　昆明市宜良县金麦园食品厂生产的金牌蛋糕脱氢乙酸及其钠盐和防腐剂各自用量占其最大使用量比例之和不合格。\n\n　　公开资料显示，造成菌落总数超标的原因较多，如环境不清洁、操作人员不规范操作及保存不当等。消费者食用菌落总数超标严重的食品很容易患痢疾等肠道疾病，引起呕吐、腹泻等症状。', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20161201/eb968a11ba0a1dd1.jpg\",\"smallUrl\":\"/Uploads/Picture/20161201/s_eb968a11ba0a1dd1.jpg\",\"id\":\"46ff5d0b42b01fd9e6176383dc00b363\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20161201/15a8d8622b787e34.jpg\",\"smallUrl\":\"/Uploads/Picture/20161201/s_15a8d8622b787e34.jpg\",\"id\":\"ef12e09e47acc30005c8ec4d26480d8d\"}]', '', '云南省昆明市盘龙区九龙湾公路', '25.106813', '102.779578', '0', '0', '', '昆明市', '1480604699');
INSERT INTO `tc_share` VALUES ('114', '0', '20000002', '0', '1', '', '第一次十六岁，看大话西游，笑的不能自已。\n第二次十八岁，看紫霞流下那滴泪，原来爱一个人那么痛，痛的我久久不能释怀。\n第三次二十二岁，至尊宝拉着紫霞的手，原来在现实面前无能为力是那么撕心裂肺，流着泪笑自己。\n第四次二十六岁，他好像一条狗…隐隐作痛的心，深呼一口气，苦笑着自嘲，爱情里没有对错，过去的人只不过好像条狗。\n第五次看28岁，结尾一行人远去，哪怕她生命中的盖世英雄，因为责任也无能为力，不得不放弃不愿放弃的…\n\n你在看大话西游的时候，如果笑得腹背抽筋，龇牙咧嘴，那么你很有幽默感。\n如果你看完了大话西游，你还笑得满地打滚，那么你其实什么都没看懂。\n如果你看完了大话，你忽然发现脸上不知什么时候已经有泪水，你总算看懂了大话的第一层了。\n如果你看完大话，笑也笑过了，泪也流过了，忽然怔在那里，忽然觉得不知是该哭还是该笑，那么你看懂第二层了。\n如果你看完了大话，默默的坐在那里，你感到无处可去，你感到一种深入骨髓的悲哀和无奈,你看懂第三层了。 \n\n大话西游是个寓言，躲在古老神话的背壳里，似乎很搞笑很爱情很世俗很感伤地讲述一个因为时间的渺茫和个体的彷徨所构筑的问题和它不确定的答案。 \n\n\"那个人样子好怪。\" \"我也看到了，他好像一条狗。\" 大话西游的最后一句对白你还记得么。其实这一句，就是整个电影的主题。用男人的思想就是：一个男人的无奈。 你喜欢至尊宝，还是喜欢孙悟空？答案不言自明。至尊宝放荡不羁，无拘无绊，但敢爱敢恨，纯真可爱。那么你又仰慕谁？谁是英雄？ 其实从至尊宝到孙悟空的蜕变，正是反应了一个从男孩到男人的心路历程。 \"等你明白了舍生取义的道理，你自然会回来和我唱这首歌的。\" 唐僧是谁？我们是不是想起了我们的父母，我们的老师，我们的前辈。哪一个男人没有经历过他们的谆谆教导，又有哪一个人没有产生过一种强烈的逆反心理，没有反抗。但是，当每一个人成熟起来后，成为了男人，都会由衷地感谢他们的教诲，或者后悔没有听他们的话。 \"我知道有一天他会在一个万众瞩目的情况下出现，身披金甲圣衣，脚踏七色云彩来娶我。\"紫霞仙子是那种令每一个男孩子倾心的女性，她对自己的意中人要求不高，仅此而已，但是试问，你能做到吗？至尊宝做到了吗？他做到了，不过代价却是......其实，紫霞仙子就是我们心目中的女性形象，她的要求就代表了女性对男人的要求。 牛魔王又是谁？他代表了这世界上一种无形的力量，他夺走了紫霞，夺走了晶晶，也夺走了至尊宝的快乐。这种力量使至尊宝和他代表的男孩子们失去了往日的伊甸园，要想找回昔日的快乐，就必须战胜它。 \n\n说到这里，先整理一下思路，看看我们发现了什么。随着牛魔王的出现，至尊宝再也不能享受往日无忧的时光。他要找回心爱的晶晶，也要夺回更加深爱的紫霞。他曾一度寄望于月光宝盒转自，是的，月光宝盒。它有一种神奇的力量，可以使至尊宝避开同牛魔王直接交锋而获得自己想要的东东。其实，每一个男孩子在成长的过程中都曾经有过这样的幻想，但是，面对无情的现实，幻想一次又一次地破灭。直到最后的关头，至尊宝终于醒悟，靠月光宝盒不行，至尊宝更是没有那个本事，只有成为孙悟空，只有戴上那个金刚圈，他才有能力同牛魔王一较高下。 这真是一个极大的讽刺。你想要得到吗？那么好吧，你先放弃吧。你必须做出选择，作至尊宝，那么快乐总是很短暂，作孙悟空，你就要忍受无尽的痛苦。这个世界的规则好象是牛魔王制定的，那么恶毒，在它面前，那段经典的台词显得多么的苍白无力，只能成为一个男孩子蜕变成男人的时候留在心底最深的伤痛。 唐僧说话的方式从来就没有变过，只是在至尊宝醒悟的前后听来有完全不同的感受。那么至尊宝是自觉自愿的醒悟吗？不，他并不愿意，但是他必须拯救紫霞，必须化解人间的恨，他别无选择。虽然成为了孙悟空，成了大英雄，但他对自己的生存状态极度不满。\n\n片子的最后，孙悟空将他心中残存的至尊宝的影子幻化作一位夕阳武士，在对现实世界彻底失望后，只能构造一个虚幻的想象来了却这桩心愿，并借武士的口中表达了对自己生存状态的不满，活得好象是一条狗一样。唉，一个男人的 悲怆和无奈。 \"生又何哀，死又何苦。\" 很早就听说过，如果你能理解大话中，\"他好象一条狗\"那么你才是真正理解了《大话》 也许我还不能完全明白..............\n\n喜欢大话喜欢那种明明相爱却又不能死守终生的遗憾和悲哀。我只能这样骗自己，也许他也有他的苦衷。发现自己真的的接近于疯狂。大概是太过于同情怜悯自己了，才深深地喜欢着这个故事。《大话西游》是最有深度的电影，没有之一！再配合这首《一生所爱》真的是一座无法跨越的巅峰！神作！没有之一！送给曾经爱过和被爱的人！', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20170125/8706c8ca2b744708.jpg\",\"smallUrl\":\"/Uploads/Picture/20170125/s_8706c8ca2b744708.jpg\",\"id\":\"942011009f58366c6040b30a47df365a\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20170125/dd2d31244ed06cf3.jpg\",\"smallUrl\":\"/Uploads/Picture/20170125/s_dd2d31244ed06cf3.jpg\",\"id\":\"859dc9a0081f19b6aac1449dfda80e26\"},{\"key\":\"images3\",\"originUrl\":\"/Uploads/Picture/20170125/8afc5b963fbbf1d3.jpg\",\"smallUrl\":\"/Uploads/Picture/20170125/s_8afc5b963fbbf1d3.jpg\",\"id\":\"1d1f5742afa2647e9e8567ce10fd2a7c\"}]', '', '云南省昆明市盘龙区九龙湾公路', '25.106690', '102.779801', '0', '0', '', '全国', '1485275908');
INSERT INTO `tc_share` VALUES ('115', '0', '20000002', '0', '9', '', '分享视频', '', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20170127/a624cbff4e1581c6.jpg\",\"smallUrl\":\"/Uploads/Picture/20170127/s_a624cbff4e1581c6.jpg\",\"id\":\"50b8bd65564200d0f7b13cab7c858b79\"},{\"originUrl\":\"/Uploads/Picture/20170127/a5275f408b88be17.mp4\",\"smallUrl\":\"/Uploads/Picture/20170127/a5275f408b88be17.mp4\",\"id\":\"ba7f9d9dd6cfbaa08b054402f368d1f5\",\"key\":\"video\"}]', '云南省昆明市盘龙区九龙湾公路', '25.106282', '102.780080', '1', '0', '', '全国', '1485484561');
INSERT INTO `tc_share` VALUES ('116', '0', '20000264', '15', '', '', '好了！你说过了[emoji_94][emoji_95][emoji_95][emoji_95][emoji_95]', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20170209/7674e300dc21aa4c.png\",\"smallUrl\":\"/Uploads/Picture/20170209/s_7674e300dc21aa4c.png\",\"id\":\"b2b47371c14c067a149d02965dee3768\"},{\"key\":\"images2\",\"originUrl\":\"/Uploads/Picture/20170209/48a9abbbae454d96.png\",\"smallUrl\":\"/Uploads/Picture/20170209/s_48a9abbbae454d96.png\",\"id\":\"769a88c952d7992635cdced36cd650f9\"}]', '', '浪度家私(华阳旗舰店)', '30.516396', '104.075691', '0', '0', '', '成都市', '1486613973');
INSERT INTO `tc_share` VALUES ('117', '115', '20000264', '5', '', '', '试试', '', '', '正中中医馆', '30.515408', '104.077802', '1', '1', '', '成都市', '1486614026');
INSERT INTO `tc_share` VALUES ('118', '0', '20000273', '0', '18', '', '女孩子破处会不会很疼啊？', '[{\"key\":\"images1\",\"originUrl\":\"/Uploads/Picture/20170216/24713c6612cc4440.jpg\",\"smallUrl\":\"/Uploads/Picture/20170216/s_24713c6612cc4440.jpg\",\"id\":\"cb460809705b46d28051241b939dd52b\"}]', '', '江苏省淮安市金湖县X103(利农南路)', '33.015881', '119.037593', '0', '0', '', '淮安市', '1487185778');
INSERT INTO `tc_share` VALUES ('119', '0', '20000312', '1', '', 'Cjvbh', 'Chvnjb', '[{\"key\":\"content1_file\",\"originUrl\":\"/Uploads/Picture/20170324/f616602418116add.jpg\",\"smallUrl\":\"/Uploads/Picture/20170324/s_f616602418116add.jpg\",\"id\":\"c904a3ba47d759ef81fdfd544a3c4690\",\"isVideo\":false}]', '', '四川省成都市郫县西芯大道4号', '30.738711', '103.978760', '0', '0', '', '成都市', '1490327727');
INSERT INTO `tc_share` VALUES ('120', '0', '20000313', '5', '', 'YY', '无', '[{\"key\":\"content1_file\",\"originUrl\":\"/Uploads/Picture/20170324/a745871f78f792ed.jpg\",\"smallUrl\":\"/Uploads/Picture/20170324/s_a745871f78f792ed.jpg\",\"id\":\"af0765fe3fea3c9ea995f2acb216ba47\",\"isVideo\":false}]', '', '四川省成都市郫县天辰路', '30.738792', '103.978703', '0', '0', '', '成都市', '1490332206');
INSERT INTO `tc_share` VALUES ('121', '120', '20000316', '2', '', 'we', '', '', '', '四川省成都市郫县天辰路', '30.738793', '103.978699', '0', '1', '', '四川省', '1490334479');
INSERT INTO `tc_share` VALUES ('122', '120', '20000313', '2', '', '磨', '\\u8bf7\\u52ff\\u53d1\\u5e03\\u4efb\\u4f55\\u5f62\\u5f0f\\u5e7f\\u544a\\u5ba3\\u4f20\\uff0c\\u88ab\\u4e3e\\u62a5\\u540e\\u53ef\\u80fd\\u88ab\\u5c01\\u53f7', '', '', '成都高新技术创新服务中心', '30.738012', '103.978423', '0', '1', '', '成都市', '1490336997');
INSERT INTO `tc_share` VALUES ('123', '0', '20000002', '0', '1', '蒙古帝国属于中国还是蒙古？', '由于最近经常在网上看到有朋友们说如果我们还是元朝那么大地盘怎么怎么样，我们当年蒙古帝国是地跨欧亚两大州的4000万平方公里的帝国等种种言论，今天我想在此澄清一个问题，就是什么是元朝，什么是蒙古帝国。帮助大家理清那段历史，希望大家不要被那些民族虚无主义的言论蒙蔽，做到理性爱国。', '[{\"key\":\"content1_file\",\"originUrl\":\"/Uploads/Picture/20170325/dbc836d0d6b6b220.jpg\",\"smallUrl\":\"/Uploads/Picture/20170325/s_dbc836d0d6b6b220.jpg\",\"id\":\"d4bb32346cad07ae78fba9aaa8525f12\",\"isVideo\":false}]', '', '云南省昆明市盘龙区九龙湾公路', '25.106812', '102.779722', '0', '0', '', '昆明市', '1490442574');
INSERT INTO `tc_share` VALUES ('126', '0', '20000002', '0', '1', '为什么中国人发明麻将？而西方却发明扑克？', '中国有句老话，“天下熙熙皆为利来，天下攘攘皆为利往”。麻将正包含这中国人价值观念中的现实功利特色。\n\n麻将中的筒是铜钱，条索是穿铜钱的线，万是铜钱的数量。希望的钱不是百也不是千而是万，正表达国人对财富的最大渴望。\n\n东西南北风代表四方，出门打拼的游子远走四方，不正是为了让家人过上好日子吗？\n\n中发白也寄托着国人最朴素的愿望：过年了，大家拜年的话就是恭喜发财，要么祝愿亲朋早日升迁发达。“发”当然是发财，“中”就是中状元，就是考试及第，希望孩子能高考个好学校，也希望亲朋能如古人一样中举人，仕途得到升迁，是对将来的美好愿望。“白”代表清白，在当官发财的时候要清清白白，这样才能把日子过得幸福和安稳。', '[{\"key\":\"content1_file\",\"originUrl\":\"/Uploads/Picture/20170327/463e810f0e20a6e5.jpg\",\"smallUrl\":\"/Uploads/Picture/20170327/s_463e810f0e20a6e5.jpg\",\"id\":\"18db53d423ed3f2648fdaf0f28bf8a41\",\"isVideo\":false}]', '', '云南省昆明市盘龙区九龙湾公路', '25.106740', '102.779727', '0', '0', '', '昆明市', '1490586966');
INSERT INTO `tc_share` VALUES ('127', '0', '20000315', '0', '19', '科技', '', '[{\"key\":\"content1_file\",\"originUrl\":\"/Uploads/Picture/20170327/d11021a9ee870e5a.png\",\"smallUrl\":\"/Uploads/Picture/20170327/s_d11021a9ee870e5a.png\",\"id\":\"f22b41c26e1c540570fd7a70bc07a886\",\"isVideo\":false}]', '', '成都高新技术创新服务中心', '30.738012', '103.978423', '0', '0', '', '四川省', '1490596125');
INSERT INTO `tc_share` VALUES ('128', '0', '20000315', '0', '27', '咯', '', '[{\"key\":\"content1_file\",\"originUrl\":\"/Uploads/Picture/20170327/3ab1ca4c9e377682.png\",\"smallUrl\":\"/Uploads/Picture/20170327/s_3ab1ca4c9e377682.png\",\"id\":\"9b2b2c7c356c9abe7cf96318a16e7e2f\",\"isVideo\":false}]', '', '成都高新技术创新服务中心', '30.738012', '103.978423', '0', '0', '', '四川省', '1490596349');
INSERT INTO `tc_share` VALUES ('129', '0', '20000313', '0', '20', '二', '', '[{\"key\":\"content1_file\",\"originUrl\":\"/Uploads/Picture/20170327/79cd898e3e8d1c76.jpg\",\"smallUrl\":\"/Uploads/Picture/20170327/s_79cd898e3e8d1c76.jpg\",\"id\":\"0f0fe2152ac3214f9668c643c96ef2d2\",\"isVideo\":false}]', '', '四川省成都市郫县天辰路', '30.738837', '103.978901', '0', '0', '', '全国', '1490596751');

-- ----------------------------
-- Table structure for `tc_share_category`
-- ----------------------------
DROP TABLE IF EXISTS `tc_share_category`;
CREATE TABLE `tc_share_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL DEFAULT '' COMMENT '名称',
  `alias` varchar(20) DEFAULT '' COMMENT '别名',
  `logo` varchar(128) NOT NULL DEFAULT '',
  `press_logo` varchar(128) DEFAULT '' COMMENT '点击时logo',
  `vieworder` smallint(6) NOT NULL DEFAULT '0' COMMENT '排序',
  `is_show` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否显示，0显示，1不显示',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8 COMMENT='分享类别表';

-- ----------------------------
-- Records of tc_share_category
-- ----------------------------
INSERT INTO `tc_share_category` VALUES ('1', '社区•生活', '社区', '/Uploads/Picture/20170327/s_b5b4edc378af696e.png', '/Uploads/Picture/20170327/s_af727f26aee3a9b7.png', '0', '0');
INSERT INTO `tc_share_category` VALUES ('2', '乐吧', '乐吧', '/Uploads/Picture/20170126/s_64d1f05be99c4bd5.png', '', '0', '1');
INSERT INTO `tc_share_category` VALUES ('3', '美食汇', '美食', '/Uploads/Picture/20170206/s_93a1243cc4e971ce.png', '/Uploads/Picture/20170327/s_2f6a083fb393fae3.png', '0', '0');
INSERT INTO `tc_share_category` VALUES ('5', '时尚•丽人', '时尚', '/Uploads/Picture/20170327/s_9478a296e464a643.png', '/Uploads/Picture/20170327/s_42eba2b9d991491f.png', '0', '0');
INSERT INTO `tc_share_category` VALUES ('7', '家居•杂百', '家居', '/Uploads/Picture/20170206/s_b45b937828e4d969.png', '/Uploads/Picture/20170327/s_a2435b39930c2919.png', '0', '0');
INSERT INTO `tc_share_category` VALUES ('8', '房子那事', '房子', '/Uploads/Picture/20170127/s_76eaaaaafd9865db.png', '/Uploads/Picture/20170327/s_b2e6a0fc9a391c01.png', '0', '0');
INSERT INTO `tc_share_category` VALUES ('10', '车生活', '汽车', '/Uploads/Picture/20170203/s_3f6f7c30fbe63aa1.png', '/Uploads/Picture/20170327/s_86d02495e97eb31f.png', '0', '0');
INSERT INTO `tc_share_category` VALUES ('12', '旅游•特产', '旅游', '/Uploads/Picture/20170327/s_04ee0fc1ab709561.png', '/Uploads/Picture/20170327/s_426139f1e59388a5.png', '0', '0');
INSERT INTO `tc_share_category` VALUES ('13', '娱乐•影音', '娱乐', '/Uploads/Picture/20170127/s_24acf58d05226c36.png', '/Uploads/Picture/20170327/s_e718ed09cb5b5fbc.png', '0', '0');
INSERT INTO `tc_share_category` VALUES ('15', '数码•电器', '数码', '/Uploads/Picture/20170327/s_6d451d6f079cb775.png', '/Uploads/Picture/20170327/s_4d71e391297273ff.png', '0', '0');
INSERT INTO `tc_share_category` VALUES ('16', '运动•户外', '运动', '/Uploads/Picture/20170206/s_7aa7006bab575e05.png', '/Uploads/Picture/20170327/s_c059ff4b220eeed9.png', '0', '0');
INSERT INTO `tc_share_category` VALUES ('17', '健康•保健', '健康', '/Uploads/Picture/20170127/s_153f91c0119680c4.png', '/Uploads/Picture/20170327/s_b5288d5925d8521c.png', '0', '0');
INSERT INTO `tc_share_category` VALUES ('19', '婚庆•母婴', '婚庆', '/Uploads/Picture/20170327/s_79900fe7a67d06ee.png', '/Uploads/Picture/20170327/s_3c32a573cd59cb5b.png', '0', '0');
INSERT INTO `tc_share_category` VALUES ('20', '商界•职场', '职场', '/Uploads/Picture/20170327/s_aaab2986120c4965.png', '/Uploads/Picture/20170327/s_7661e820d6611584.png', '0', '0');
INSERT INTO `tc_share_category` VALUES ('22', '校园•教育', '校园', '/Uploads/Picture/20170206/s_c67bcc6cfc47e9d8.png', '/Uploads/Picture/20170327/s_3e1ea8e1af3665ae.png', '0', '0');
INSERT INTO `tc_share_category` VALUES ('25', '其它', '其它', '/Uploads/Picture/20170203/s_02f1c7a335987d52.png', '/Uploads/Picture/20170327/s_6345d1b3aab197d6.png', '0', '0');

-- ----------------------------
-- Table structure for `tc_share_gallery`
-- ----------------------------
DROP TABLE IF EXISTS `tc_share_gallery`;
CREATE TABLE `tc_share_gallery` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `share_id` int(11) NOT NULL,
  `content` text NOT NULL,
  `images` varchar(2048) NOT NULL DEFAULT '',
  `video` varchar(2048) NOT NULL DEFAULT '',
  `create_time` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tc_share_gallery
-- ----------------------------
INSERT INTO `tc_share_gallery` VALUES ('13', '119', 'Chvnjb', '[{\"key\":\"content1_file\",\"originUrl\":\"/Uploads/Picture/20170324/f616602418116add.jpg\",\"smallUrl\":\"/Uploads/Picture/20170324/s_f616602418116add.jpg\",\"id\":\"c904a3ba47d759ef81fdfd544a3c4690\",\"isVideo\":false}]', '', '1490327727');
INSERT INTO `tc_share_gallery` VALUES ('14', '120', '无', '[{\"key\":\"content1_file\",\"originUrl\":\"/Uploads/Picture/20170324/a745871f78f792ed.jpg\",\"smallUrl\":\"/Uploads/Picture/20170324/s_a745871f78f792ed.jpg\",\"id\":\"af0765fe3fea3c9ea995f2acb216ba47\",\"isVideo\":false}]', '', '1490332206');
INSERT INTO `tc_share_gallery` VALUES ('15', '122', '\\u8bf7\\u52ff\\u53d1\\u5e03\\u4efb\\u4f55\\u5f62\\u5f0f\\u5e7f\\u544a\\u5ba3\\u4f20\\uff0c\\u88ab\\u4e3e\\u62a5\\u540e\\u53ef\\u80fd\\u88ab\\u5c01\\u53f7', '', '', '1490336997');
INSERT INTO `tc_share_gallery` VALUES ('16', '123', '由于最近经常在网上看到有朋友们说如果我们还是元朝那么大地盘怎么怎么样，我们当年蒙古帝国是地跨欧亚两大州的4000万平方公里的帝国等种种言论，今天我想在此澄清一个问题，就是什么是元朝，什么是蒙古帝国。帮助大家理清那段历史，希望大家不要被那些民族虚无主义的言论蒙蔽，做到理性爱国。', '[{\"key\":\"content1_file\",\"originUrl\":\"/Uploads/Picture/20170325/dbc836d0d6b6b220.jpg\",\"smallUrl\":\"/Uploads/Picture/20170325/s_dbc836d0d6b6b220.jpg\",\"id\":\"d4bb32346cad07ae78fba9aaa8525f12\",\"isVideo\":false}]', '', '1490442574');
INSERT INTO `tc_share_gallery` VALUES ('17', '123', '明确元朝和蒙古帝国\n\n首先确定这两个概念，成吉思汗是绝对的蒙古人，这个是民族问题，其次他建立的帝国叫蒙古帝国，1206年春天，蒙古贵族们在斡难河（今鄂嫩河）源头召开大会，诸王和群臣为铁木真上尊号“成吉思汗”，这个封号是蒙古自己的文化产生的，我们中原文化中是没有这个称号的。所以明确蒙古帝国是成吉思汗建立的，所以他是蒙古人，现在有蒙古这个国家，所以蒙古人尊成吉思汗为祖先是正常的。', '[{\"key\":\"content2_file\",\"originUrl\":\"/Uploads/Picture/20170325/4a904c84b77bf8bd.jpg\",\"smallUrl\":\"/Uploads/Picture/20170325/s_4a904c84b77bf8bd.jpg\",\"id\":\"35d007f01eda7becea3f2e17b9e356b8\",\"isVideo\":false}]', '', '1490442574');
INSERT INTO `tc_share_gallery` VALUES ('18', '123', '其次说一下元朝，元朝时由忽必烈在1271年建立的，元朝时我国封建王朝中的一个朝代，他占领的地域也是现在我国的大部分地区，至于元朝时没有对其他欧亚地区进行统治的，因为那些地区属于蒙古帝国，这个概念我们接下来说。', '[{\"key\":\"content3_file\",\"originUrl\":\"/Uploads/Picture/20170325/1fadf1ad61baced2.jpg\",\"smallUrl\":\"/Uploads/Picture/20170325/s_1fadf1ad61baced2.jpg\",\"id\":\"95c8960c55af1cdab5925e9683a05f23\",\"isVideo\":false}]', '', '1490442574');
INSERT INTO `tc_share_gallery` VALUES ('19', '123', '蒙古大帝国的概念\n\n蒙古帝国的概念是铁木真提出的，他活着的时候南征北战，大家没有时间谈论领土封地问题，后来成吉思汗死后，窝阔台继位，拖雷监国。后来拖雷的儿子蒙哥继承汗位，后来蒙哥死在了钓鱼城，导致各路大军回来争夺汗位，忽必烈在战斗中胜利，成为大汗。由于蒙古实行的是分封制，在忽必烈之前就有他的父辈的几大封国和忽必烈爷爷辈们也就是铁木真兄弟的封国，所以在这个时候依然是蒙古帝国，那时候我们中国人只是被侵犯了领地。后来忽必烈在他的大汗领地的基础上沿袭我们的制度建立了元朝，这个时候元朝才出现，实际上现在中国大陆只是元朝的一部分，但是元朝时以我们中国人为主体的。', '[{\"key\":\"content4_file\",\"originUrl\":\"/Uploads/Picture/20170325/0f3ccfee7a624681.jpg\",\"smallUrl\":\"/Uploads/Picture/20170325/s_0f3ccfee7a624681.jpg\",\"id\":\"10c6d5d66f91253b071f1202f9c5fc00\",\"isVideo\":false}]', '', '1490442574');
INSERT INTO `tc_share_gallery` VALUES ('20', '123', '几大分封国是以元朝为宗主的，元朝皇帝在元朝时皇帝，在整个欧亚大陆是一个大汗，这是分封制度，四大汗国，又称“兀鲁思”，分别是钦察汗国（又称金帐汗国）、察合台汗国、窝阔台汗国、伊利汗国。这个大家有想法的请自己去查阅典籍。', '[{\"key\":\"content5_file\",\"originUrl\":\"/Uploads/Picture/20170325/92b6e8111567c84c.jpg\",\"smallUrl\":\"/Uploads/Picture/20170325/s_92b6e8111567c84c.jpg\",\"id\":\"156a8ed41813ade1b89f639b4036089c\",\"isVideo\":false}]', '', '1490442574');
INSERT INTO `tc_share_gallery` VALUES ('21', '123', '经过以上的普及我们可以得出结果，元朝时中国的，但是蒙古帝国不是，蒙古帝国是人家蒙古国的骄傲。由于蒙古地区特别是外蒙古在清朝也不属于中国，和清朝政府是附属国或者说是合作关系，所以蒙古独立是有依据的。至此，我们要清楚的知道，内蒙古是中国的固有领土，这个地区是当时的战略缓冲地带，属于中国。但是现在的蒙古国真的不是我们的民族和国家。其次蒙古帝国也是人家的，但是元王朝本质上是中国的，虽然明王朝一直没有承认，认为人家是蛮夷。现在我们的国家版图已经定型，就不要说其他的历史什么的了，但是记住一点，现在的960万，都是我们的，一寸也不能少。', '', '', '1490442574');
INSERT INTO `tc_share_gallery` VALUES ('22', '124', '', '[{\"key\":\"content1_file\",\"originUrl\":\"/Uploads/Picture/20170327/14aacedaed9e3bf1.jpg\",\"smallUrl\":\"/Uploads/Picture/20170327/s_14aacedaed9e3bf1.jpg\",\"id\":\"1b224ea06961455e747303addb48230f\",\"isVideo\":false}]', '', '1490579895');
INSERT INTO `tc_share_gallery` VALUES ('23', '124', '而扑克的花色代表着什么呢？\n\n        4种花色代表中世纪时欧洲社会的 4 种主要行业，其中黑桃代表长矛，象征军人；红桃代表红心，象征牧师；梅花代表三叶草，象征农业；方块代表砖瓦，象征工匠。\n\n        这点反映了当时的西方中世纪社会结构。\n\n        现在的西方人也把追求价值观念赋予这四个花色之中：黑桃代表橄榄叶，象征和平；红桃为红心型，象征智慧和爱情；梅花为三叶草，意味着幸运；方块呈钻石形状，象征财富。', '[{\"key\":\"content2_file\",\"originUrl\":\"/Uploads/Picture/20170327/f943e80994e9a782.jpg\",\"smallUrl\":\"/Uploads/Picture/20170327/s_f943e80994e9a782.jpg\",\"id\":\"2ab72a27bdd1cd3639958a3ca75dba77\",\"isVideo\":false}]', '', '1490579895');
INSERT INTO `tc_share_gallery` VALUES ('24', '124', '', '[{\"key\":\"content3_file\",\"originUrl\":\"/Uploads/Picture/20170327/6bd42a8e49348d54.jpg\",\"smallUrl\":\"/Uploads/Picture/20170327/s_6bd42a8e49348d54.jpg\",\"id\":\"69e9ffac1760a51fb0703cdada56bb4e\",\"isVideo\":false}]', '', '1490579895');
INSERT INTO `tc_share_gallery` VALUES ('25', '124', '', '[{\"key\":\"content4_file\",\"originUrl\":\"/Uploads/Picture/20170327/669cfc2bc0ffcd6a.jpg\",\"smallUrl\":\"/Uploads/Picture/20170327/s_669cfc2bc0ffcd6a.jpg\",\"id\":\"d27fe9289f2740f74364bb50fdb01d24\",\"isVideo\":false}]', '', '1490579895');
INSERT INTO `tc_share_gallery` VALUES ('26', '124', '在扑克54 张牌中，有 52 张是正牌，表示一年里有 52 个星期。两张是副牌，大王代表太阳，小王代表月亮。一年四季的春、夏、秋、冬、分别用黑桃、红桃、梅花、方块来表示。其中红桃、方块是代表白昼，黑桃、梅花是代表黑夜。每一季度是13个星期，扑克牌中每一种花色正好是 13 张；如果我们计算一下扑克牌的总点数，把 J 当 11 点，Q 当 12 点，K 当 13点， 13张牌的点数之和正好有91点，等于每一季度的91天；4种花色的点数加起来，然后加上小王的一点，是365点，正好等于一年的天数，如果再加上大王的那一点，是366天，恰好是闰年的天数。原来扑克中隐藏着含西方的历法知识。', '[{\"key\":\"content5_file\",\"originUrl\":\"/Uploads/Picture/20170327/23f6c1b873abb1cc.jpg\",\"smallUrl\":\"/Uploads/Picture/20170327/s_23f6c1b873abb1cc.jpg\",\"id\":\"9ec14383ddb7d494c67d530a6ac6c242\",\"isVideo\":false}]', '', '1490579895');
INSERT INTO `tc_share_gallery` VALUES ('27', '125', '', '[{\"key\":\"content1_file\",\"originUrl\":\"/Uploads/Picture/20170327/ee496e01daa881fd.jpg\",\"smallUrl\":\"/Uploads/Picture/20170327/s_ee496e01daa881fd.jpg\",\"id\":\"7438e6fbb63936885c83c70769e69951\",\"isVideo\":false}]', '', '1490580640');
INSERT INTO `tc_share_gallery` VALUES ('28', '125', '所以，我们中国老百姓，过年休闲的时候，当然喜欢打麻将了，里面包含着我们对将来新的一年希望。\n\n而扑克的花色代表着什么呢？\n\n4种花色代表中世纪时欧洲社会的 4 种主要行业，其中黑桃代表长矛，象征军人；红桃代表红心，象征牧师；梅花代表三叶草，象征农业；方块代表砖瓦，象征工匠。\n\n\n这点反映了当时的西方中世纪社会结构。\n\n现在的西方人也把追求价值观念赋予这四个花色之中：黑桃代表橄榄叶，象征和平；红桃为红心型，象征智慧和爱情；梅花为三叶草，意味着幸运；方块呈钻石形状，象征财富。', '[{\"key\":\"content2_file\",\"originUrl\":\"/Uploads/Picture/20170327/2244a963192ba90c.jpg\",\"smallUrl\":\"/Uploads/Picture/20170327/s_2244a963192ba90c.jpg\",\"id\":\"56c1657088b1d0f94fc4b1995102c98e\",\"isVideo\":false}]', '', '1490580640');
INSERT INTO `tc_share_gallery` VALUES ('29', '125', '', '[{\"key\":\"content3_file\",\"originUrl\":\"/Uploads/Picture/20170327/857fdc3fa8cad366.jpg\",\"smallUrl\":\"/Uploads/Picture/20170327/s_857fdc3fa8cad366.jpg\",\"id\":\"11557a3283821a199630c94f3cc2432d\",\"isVideo\":false}]', '', '1490580640');
INSERT INTO `tc_share_gallery` VALUES ('30', '125', '', '[{\"key\":\"content4_file\",\"originUrl\":\"/Uploads/Picture/20170327/583209456084a4d3.jpg\",\"smallUrl\":\"/Uploads/Picture/20170327/s_583209456084a4d3.jpg\",\"id\":\"313dedfb635ffca2fe0a988c63b32ebb\",\"isVideo\":false}]', '', '1490580640');
INSERT INTO `tc_share_gallery` VALUES ('31', '125', '', '[{\"key\":\"content5_file\",\"originUrl\":\"/Uploads/Picture/20170327/b436d190e5573955.jpg\",\"smallUrl\":\"/Uploads/Picture/20170327/s_b436d190e5573955.jpg\",\"id\":\"01bb815fa0071125489eb077a0ebabb4\",\"isVideo\":false}]', '', '1490580640');
INSERT INTO `tc_share_gallery` VALUES ('32', '125', '', '[{\"key\":\"content6_file\",\"originUrl\":\"/Uploads/Picture/20170327/875315de17ac1a10.jpg\",\"smallUrl\":\"/Uploads/Picture/20170327/s_875315de17ac1a10.jpg\",\"id\":\"400792a9965348b05f319b36a8601b9c\",\"isVideo\":false}]', '', '1490580640');
INSERT INTO `tc_share_gallery` VALUES ('33', '126', '中国有句老话，“天下熙熙皆为利来，天下攘攘皆为利往”。麻将正包含这中国人价值观念中的现实功利特色。\n\n麻将中的筒是铜钱，条索是穿铜钱的线，万是铜钱的数量。希望的钱不是百也不是千而是万，正表达国人对财富的最大渴望。\n\n东西南北风代表四方，出门打拼的游子远走四方，不正是为了让家人过上好日子吗？\n\n中发白也寄托着国人最朴素的愿望：过年了，大家拜年的话就是恭喜发财，要么祝愿亲朋早日升迁发达。“发”当然是发财，“中”就是中状元，就是考试及第，希望孩子能高考个好学校，也希望亲朋能如古人一样中举人，仕途得到升迁，是对将来的美好愿望。“白”代表清白，在当官发财的时候要清清白白，这样才能把日子过得幸福和安稳。', '[{\"key\":\"content1_file\",\"originUrl\":\"/Uploads/Picture/20170327/463e810f0e20a6e5.jpg\",\"smallUrl\":\"/Uploads/Picture/20170327/s_463e810f0e20a6e5.jpg\",\"id\":\"18db53d423ed3f2648fdaf0f28bf8a41\",\"isVideo\":false}]', '', '1490586966');
INSERT INTO `tc_share_gallery` VALUES ('34', '126', '麻将与扑克中包含着中西方人们不同的价值观念。\n\n所以在中国老百姓里，过年或休闲的时候，当然喜欢打麻将，里面包含着美好期望。\n\n而扑克的四种花色代表中世纪欧洲社会的4种主要行业：黑桃代表长矛，象征军人；红桃代表红心，象征牧师；梅花代表三叶草，象征农业；方块代表砖瓦，象征工匠。反映了当时西方中世纪社会结构。\n\n现在的西方人也把追求价值观念赋予这四个花色中：黑桃代表橄榄叶，象征和平；红桃为心型，象征智慧与爱情；梅花为三叶草，象征幸运；方块呈钻石形状，象征财富。', '[{\"key\":\"content2_file\",\"originUrl\":\"/Uploads/Picture/20170327/cd16c7933b3f940c.jpg\",\"smallUrl\":\"/Uploads/Picture/20170327/s_cd16c7933b3f940c.jpg\",\"id\":\"234db075a7cbce28323962ac2384bb54\",\"isVideo\":false}]', '', '1490586966');
INSERT INTO `tc_share_gallery` VALUES ('35', '126', '扑克与麻将的玩法也体现着中西方人们不同的性格特征。\n\n扑克是大牌压制小牌，一切靠实力说话。抓到一副好牌，就有很大赢的几率，就是命中注定的了。可以看出西方人更注重传统出身。\n\n而麻将一开始通过扔骰子决定如何抓牌，说明开始抓什么牌不是绝对重要，是三分天注定，七分靠打拼。麻将常常“歪打歪有理”，即使开始抓牌时牌不好，说不定反而能成牌。正所谓“某事在人，成事在天”。我们不看出身，看以后的发展。\n\n在扑克中每张牌的大小不一样，作用也不一样。所有的人希望抓到牌越大越好。所以扑克牌每张是不平等的，如果抓到一手烂牌，那基本上无翻身的希望了。讲究的是规则，拼的是实力，这能反映出西方社会崇尚实力，崇拜强者。', '[{\"key\":\"content3_file\",\"originUrl\":\"/Uploads/Picture/20170327/6cd9a7f2a7faede5.jpg\",\"smallUrl\":\"/Uploads/Picture/20170327/s_6cd9a7f2a7faede5.jpg\",\"id\":\"5f20ec046e233b7854882384d759774b\",\"isVideo\":false}]', '', '1490586966');
INSERT INTO `tc_share_gallery` VALUES ('36', '126', '麻将并不会以牌面的大小为实力，而是讲究在群体中的价值，只有和别的牌配合了，才能发挥作用，一张牌的实力作用是相对的，不是绝对的。只要合用，绝无大小之分。加上“吃”和“碰”，也许对别人没有价值的牌，对自己却是很有用的。中国人更注重整体，强调我们是团队中的一员，从不搞个人英雄主义。\n\n打扑克的过程充满火药味，是你死我活的斗争，是对手之间智慧算计的对抗。西方人喜欢竞争。\n\n打麻将过程是谈笑风生，不是要以吃掉杀伤对方为代价。大路朝天，各走半边，你等你的，我要我的。表面上一团和气，好像与他人无争，但暗地里算计着别人。我们追求表面的和谐，最后以“和”为终局，以和为贵，和气生财！', '[{\"key\":\"content4_file\",\"originUrl\":\"/Uploads/Picture/20170327/5fd12c6dfe3ab7f7.jpg\",\"smallUrl\":\"/Uploads/Picture/20170327/s_5fd12c6dfe3ab7f7.jpg\",\"id\":\"69b953334c977ec374c4a9f5e02043bd\",\"isVideo\":false}]', '', '1490586966');
INSERT INTO `tc_share_gallery` VALUES ('37', '126', '打扑克开始的牌好坏很重要，出牌的技巧也很重要，如果具备二者，不赢都难。所以一开始见到自己手里的牌和对手实力，就知道自己的输赢了，不确定因素较少。\n\n打麻将的过程是13张牌不断与外界进行交换，增加了很多偶然性和不确定因素，打牌最难的就是面对将来的未知，打牌过程也是取舍的过程，我们喜欢权衡得失，考虑问题时想得比西方人多。\n\n麻将与扑克体现着中西方人们对生活的不同态度。\n\n扑克54张牌中，有52张是正牌，表示一年52周。两张王牌代表太阳和月亮。黑红梅方代表一年四季都春夏秋冬。红牌代表白天，黑牌代表黑夜。每一花色13张牌代表一季中的13周。', '[{\"key\":\"content5_file\",\"originUrl\":\"/Uploads/Picture/20170327/84a1086a35fa3723.jpg\",\"smallUrl\":\"/Uploads/Picture/20170327/s_84a1086a35fa3723.jpg\",\"id\":\"9a454a36abf9db8d58a4a3a77c9c86e6\",\"isVideo\":false}]', '', '1490586966');
INSERT INTO `tc_share_gallery` VALUES ('38', '126', '13张牌之和为91点，代表一季的91天；全部花色加小王正好365天，加大王366天代表闰年。扑克中隐含着西方的历法知识。\n\n麻将则包含中国古代朴素宇宙观和哲学思想。3为基数，9为极数，所以就有3种花色和各9张牌。3也代表天地人三才。东西南北中代表“五行”方位，“白”代表地，“发”代表天，“中”既代表中土，也代表人。五行方位和天地人三才共同组成宇宙形态。\n\n麻将中的144张牌，正好是12但平方；而主牌108张，也是12的倍数，暗合了中国的12地支、12生肖、12时辰和12个月。每人13张牌也是一季13周，4个人合起来就是一年。', '[{\"key\":\"content6_file\",\"originUrl\":\"/Uploads/Picture/20170327/02ac8e2c64beae16.jpg\",\"smallUrl\":\"/Uploads/Picture/20170327/s_02ac8e2c64beae16.jpg\",\"id\":\"b4e533f055120d43ef9e2ea8b31df5eb\",\"isVideo\":false}]', '', '1490586966');
INSERT INTO `tc_share_gallery` VALUES ('39', '127', '', '[{\"key\":\"content1_file\",\"originUrl\":\"/Uploads/Picture/20170327/d11021a9ee870e5a.png\",\"smallUrl\":\"/Uploads/Picture/20170327/s_d11021a9ee870e5a.png\",\"id\":\"f22b41c26e1c540570fd7a70bc07a886\",\"isVideo\":false}]', '', '1490596125');
INSERT INTO `tc_share_gallery` VALUES ('40', '128', '', '[{\"key\":\"content1_file\",\"originUrl\":\"/Uploads/Picture/20170327/3ab1ca4c9e377682.png\",\"smallUrl\":\"/Uploads/Picture/20170327/s_3ab1ca4c9e377682.png\",\"id\":\"9b2b2c7c356c9abe7cf96318a16e7e2f\",\"isVideo\":false}]', '', '1490596349');
INSERT INTO `tc_share_gallery` VALUES ('41', '129', '', '[{\"key\":\"content1_file\",\"originUrl\":\"/Uploads/Picture/20170327/79cd898e3e8d1c76.jpg\",\"smallUrl\":\"/Uploads/Picture/20170327/s_79cd898e3e8d1c76.jpg\",\"id\":\"0f0fe2152ac3214f9668c643c96ef2d2\",\"isVideo\":false}]', '', '1490596751');

-- ----------------------------
-- Table structure for `tc_share_praise`
-- ----------------------------
DROP TABLE IF EXISTS `tc_share_praise`;
CREATE TABLE `tc_share_praise` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT '用户id',
  `shareid` int(11) NOT NULL DEFAULT '0' COMMENT '留言id',
  `createtime` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8 COMMENT='分享表赞';

-- ----------------------------
-- Records of tc_share_praise
-- ----------------------------
INSERT INTO `tc_share_praise` VALUES ('2', '20000000', '2', '1458717171');
INSERT INTO `tc_share_praise` VALUES ('3', '20000000', '1', '1458717172');
INSERT INTO `tc_share_praise` VALUES ('4', '20000000', '20', '1460554780');
INSERT INTO `tc_share_praise` VALUES ('5', '20000000', '29', '1461575918');
INSERT INTO `tc_share_praise` VALUES ('6', '20000000', '19', '1461754117');
INSERT INTO `tc_share_praise` VALUES ('7', '20000000', '32', '1461828834');
INSERT INTO `tc_share_praise` VALUES ('8', '20000000', '16', '1461828836');
INSERT INTO `tc_share_praise` VALUES ('9', '20000000', '40', '1461836691');
INSERT INTO `tc_share_praise` VALUES ('10', '20000000', '36', '1461836696');
INSERT INTO `tc_share_praise` VALUES ('12', '20000025', '32', '1462027371');
INSERT INTO `tc_share_praise` VALUES ('13', '20000010', '36', '1462766392');
INSERT INTO `tc_share_praise` VALUES ('14', '20000000', '22', '1462767109');
INSERT INTO `tc_share_praise` VALUES ('15', '20000000', '48', '1462774364');
INSERT INTO `tc_share_praise` VALUES ('16', '20000017', '48', '1462774404');
INSERT INTO `tc_share_praise` VALUES ('17', '20000017', '22', '1462774978');
INSERT INTO `tc_share_praise` VALUES ('18', '20000017', '50', '1462775274');
INSERT INTO `tc_share_praise` VALUES ('19', '20000010', '47', '1462786316');
INSERT INTO `tc_share_praise` VALUES ('20', '20000000', '51', '1462790415');
INSERT INTO `tc_share_praise` VALUES ('23', '20000002', '56', '1462809017');
INSERT INTO `tc_share_praise` VALUES ('24', '20000025', '57', '1462857124');
INSERT INTO `tc_share_praise` VALUES ('25', '20000025', '58', '1462955384');
INSERT INTO `tc_share_praise` VALUES ('26', '20000002', '61', '1463391266');
INSERT INTO `tc_share_praise` VALUES ('27', '20000025', '61', '1463391403');
INSERT INTO `tc_share_praise` VALUES ('28', '20000002', '60', '1463655593');
INSERT INTO `tc_share_praise` VALUES ('29', '20000000', '67', '1463726852');
INSERT INTO `tc_share_praise` VALUES ('30', '20000002', '67', '1463754015');
INSERT INTO `tc_share_praise` VALUES ('31', '20000025', '69', '1463755220');
INSERT INTO `tc_share_praise` VALUES ('32', '20000002', '71', '1463878022');
INSERT INTO `tc_share_praise` VALUES ('33', '20000025', '71', '1463879882');
INSERT INTO `tc_share_praise` VALUES ('34', '20000010', '67', '1463915967');
INSERT INTO `tc_share_praise` VALUES ('35', '20000025', '77', '1465440889');
INSERT INTO `tc_share_praise` VALUES ('37', '20000025', '78', '1465892252');
INSERT INTO `tc_share_praise` VALUES ('38', '20000025', '91', '1467817852');
INSERT INTO `tc_share_praise` VALUES ('39', '20000025', '46', '1467906614');
INSERT INTO `tc_share_praise` VALUES ('41', '20000002', '93', '1468825319');
INSERT INTO `tc_share_praise` VALUES ('42', '20000025', '93', '1468914907');
INSERT INTO `tc_share_praise` VALUES ('45', '20000091', '99', '1471009164');
INSERT INTO `tc_share_praise` VALUES ('55', '20000090', '5', '1472111729');
INSERT INTO `tc_share_praise` VALUES ('56', '20000090', '98', '1472111745');
INSERT INTO `tc_share_praise` VALUES ('59', '20000090', '103', '1473405629');
INSERT INTO `tc_share_praise` VALUES ('75', '20000115', '107', '1474183727');
INSERT INTO `tc_share_praise` VALUES ('78', '20000025', '82', '1475050873');
INSERT INTO `tc_share_praise` VALUES ('79', '20000096', '85', '1476070311');
INSERT INTO `tc_share_praise` VALUES ('80', '20000210', '108', '1479520100');
INSERT INTO `tc_share_praise` VALUES ('82', '20000267', '117', '1486968529');
INSERT INTO `tc_share_praise` VALUES ('83', '20000002', '115', '1489047193');
INSERT INTO `tc_share_praise` VALUES ('84', '20000315', '111', '1490260825');

-- ----------------------------
-- Table structure for `tc_share_reply`
-- ----------------------------
DROP TABLE IF EXISTS `tc_share_reply`;
CREATE TABLE `tc_share_reply` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `shareid` int(11) NOT NULL DEFAULT '0',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT '回复人',
  `fuid` int(11) NOT NULL DEFAULT '0' COMMENT '被回复的人',
  `content` text NOT NULL COMMENT '内容',
  `createtime` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8 COMMENT='分享回复表';

-- ----------------------------
-- Records of tc_share_reply
-- ----------------------------
INSERT INTO `tc_share_reply` VALUES ('1', '2', '20000000', '20000002', '你好', '1458716191');
INSERT INTO `tc_share_reply` VALUES ('2', '2', '20000002', '20000000', '[emoji_86][emoji_86][emoji_86][emoji_13]', '1458723977');
INSERT INTO `tc_share_reply` VALUES ('3', '23', '20000002', '20000002', '青年[emoji_354][emoji_354][emoji_354]', '1460890858');
INSERT INTO `tc_share_reply` VALUES ('4', '31', '20000000', '20000000', '222', '1461575652');
INSERT INTO `tc_share_reply` VALUES ('5', '22', '20000023', '20000002', '15', '1461578655');
INSERT INTO `tc_share_reply` VALUES ('6', '39', '20000000', '20000000', 'log您', '1461829921');
INSERT INTO `tc_share_reply` VALUES ('7', '36', '20000000', '20000010', '来咯弄', '1461830789');
INSERT INTO `tc_share_reply` VALUES ('8', '36', '20000000', '20000010', '哦您工作', '1461830796');
INSERT INTO `tc_share_reply` VALUES ('9', '23', '20000000', '20000002', '1和446[emoji_86]', '1461830809');
INSERT INTO `tc_share_reply` VALUES ('10', '36', '20000000', '20000010', '呵呵', '1461836701');
INSERT INTO `tc_share_reply` VALUES ('11', '22', '20000025', '20000002', '19个[emoji_16]', '1462027495');
INSERT INTO `tc_share_reply` VALUES ('12', '36', '20000010', '20000010', '摸', '1462767849');
INSERT INTO `tc_share_reply` VALUES ('13', '50', '20000017', '20000017', '涂抹', '1462775281');
INSERT INTO `tc_share_reply` VALUES ('14', '36', '20000010', '20000010', '男人', '1462786309');
INSERT INTO `tc_share_reply` VALUES ('15', '52', '20000000', '20000010', 'uuu', '1462787090');
INSERT INTO `tc_share_reply` VALUES ('16', '48', '20000000', '20000000', 'tty', '1462787150');
INSERT INTO `tc_share_reply` VALUES ('17', '48', '20000000', '20000000', 'qqq', '1462787502');
INSERT INTO `tc_share_reply` VALUES ('18', '49', '20000010', '20000017', '噢噢噢哦哦', '1462788168');
INSERT INTO `tc_share_reply` VALUES ('19', '54', '20000010', '20000000', '粉末', '1462788186');
INSERT INTO `tc_share_reply` VALUES ('20', '55', '20000010', '20000000', '呃呃呃', '1462788193');
INSERT INTO `tc_share_reply` VALUES ('21', '48', '20000017', '20000000', '急急急', '1462789881');
INSERT INTO `tc_share_reply` VALUES ('22', '51', '20000000', '20000017', '何厚铧', '1462790419');
INSERT INTO `tc_share_reply` VALUES ('23', '48', '20000010', '20000000', '呵呵', '1462792089');
INSERT INTO `tc_share_reply` VALUES ('24', '48', '20000010', '20000017', '嗯', '1462792099');
INSERT INTO `tc_share_reply` VALUES ('25', '48', '20000010', '20000017', '嗯', '1462792434');
INSERT INTO `tc_share_reply` VALUES ('26', '36', '20000010', '20000000', '嗯', '1462792448');
INSERT INTO `tc_share_reply` VALUES ('27', '58', '20000025', '20000002', '都不知道究竟是谁的悲哀了[emoji_97]', '1462955488');
INSERT INTO `tc_share_reply` VALUES ('28', '67', '20000000', '20000002', '给哈哈', '1463726858');
INSERT INTO `tc_share_reply` VALUES ('29', '77', '20000025', '20000002', '开始打算买单车，最后买了劳斯莱斯[emoji_86][emoji_360]', '1465441071');
INSERT INTO `tc_share_reply` VALUES ('30', '88', '20000025', '20000002', '我今天又碰到开车急的，一直被加塞插队，过了6个红灯都还没过[emoji_97][emoji_97][emoji_97][emoji_101][emoji_101][emoji_101]', '1467368098');
INSERT INTO `tc_share_reply` VALUES ('31', '93', '20000025', '20000025', '[emoji_357]  再来一弹：出差在外，住在旅馆。遂一小姐发来消息: 天津 安徽 江西 ？机智如我，马上领会了她的意思，很想回复:湖南 江西！但是一摸兜，只能回复: 海南！她回了一个白眼: 山东！', '1468799318');
INSERT INTO `tc_share_reply` VALUES ('32', '98', '20000025', '20000002', '这种人就是该懆[emoji_12]', '1470365141');
INSERT INTO `tc_share_reply` VALUES ('33', '97', '20000090', '20000000', '[emoji_86][emoji_85]123', '1471493776');
INSERT INTO `tc_share_reply` VALUES ('34', '107', '20000096', '20000002', 'yup', '1473235239');
INSERT INTO `tc_share_reply` VALUES ('35', '98', '20000115', '20000002', 'Chugging', '1474270208');
INSERT INTO `tc_share_reply` VALUES ('36', '107', '20000115', '20000096', 'd', '1474270238');
INSERT INTO `tc_share_reply` VALUES ('37', '107', '20000115', '20000096', '回复[emoji_85]', '1474272929');
INSERT INTO `tc_share_reply` VALUES ('38', '108', '20000209', '20000002', '喜欢小狗', '1479467087');
INSERT INTO `tc_share_reply` VALUES ('39', '107', '20000096', '20000115', '回复了我的生活方式。我们都江堰水利工程建设和社会发展计划委员会主任医师协会会长汪道菜都江堰水利工程建设和', '1483957172');
INSERT INTO `tc_share_reply` VALUES ('40', '115', '20000264', '20000002', '用户的手机游戏无尽模式了吗、不', '1486613991');
INSERT INTO `tc_share_reply` VALUES ('41', '85', '20000267', '20000000', '评论', '1486978991');
INSERT INTO `tc_share_reply` VALUES ('42', '115', '20000303', '20000002', '卖黑大酸菜我是五常当地种地的出售自乙家产的五常稻花香大米，直销无中间环节想多挣俩儿钱需要的搜淘宝店铺号95251919进入淘宝店铺黑大乳酸菌酸菜  购买电话15734512049', '1489558140');
INSERT INTO `tc_share_reply` VALUES ('43', '99', '20000315', '20000002', '\\u54e5\\u4eec', '1490260891');
INSERT INTO `tc_share_reply` VALUES ('44', '122', '20000315', '20000313', '\\u54af', '1490342802');

-- ----------------------------
-- Table structure for `tc_supplier`
-- ----------------------------
DROP TABLE IF EXISTS `tc_supplier`;
CREATE TABLE `tc_supplier` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `groups_id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT '',
  `shop_name` varchar(100) DEFAULT '',
  `phone` varchar(20) NOT NULL,
  `address` varchar(100) DEFAULT '',
  `cat_id` int(11) NOT NULL,
  `score` varchar(20) DEFAULT '0',
  `hot` int(11) DEFAULT '0',
  `lng` varchar(20) DEFAULT '',
  `lat` varchar(20) DEFAULT '',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0.申请中，1.已通过，2.未通过',
  `last_time` varchar(20) DEFAULT '',
  `create_time` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tc_supplier
-- ----------------------------
INSERT INTO `tc_supplier` VALUES ('1', '20000315', '19', 'www', '科技创新', '13700000000', '成都高新技术创新服务中心', '15', '5', '0', '103.978423', '30.738012', '1', '1490565918', '1490266042');
INSERT INTO `tc_supplier` VALUES ('3', '20000313', '20', '果果', '乐视', '13422222222', '四川省成都市郫县天辰路', '13', '5', '0', '103.978710', '30.738772', '1', '1490565918', '1490324143');
INSERT INTO `tc_supplier` VALUES ('4', '20000317', '28', '呵呵', '小时代', '15800000000', '四川省成都市郫县西芯大道4号', '3', '0', '0', '103.978674', '30.738571', '1', '1490605290', '1490605076');

-- ----------------------------
-- Table structure for `tc_supplier_gallery`
-- ----------------------------
DROP TABLE IF EXISTS `tc_supplier_gallery`;
CREATE TABLE `tc_supplier_gallery` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sid` int(11) NOT NULL,
  `smallUrl` varchar(100) NOT NULL,
  `originUrl` varchar(100) NOT NULL,
  `create_time` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tc_supplier_gallery
-- ----------------------------
INSERT INTO `tc_supplier_gallery` VALUES ('1', '1', '/Uploads/Picture/20170323/s_f9ceeaf891c87c6f.jpg', '/Uploads/Picture/20170323/f9ceeaf891c87c6f.jpg', '1490266042');
INSERT INTO `tc_supplier_gallery` VALUES ('2', '2', '/Uploads/Picture/20170324/s_6528cdfa585cbb86.jpg', '/Uploads/Picture/20170324/6528cdfa585cbb86.jpg', '1490323996');
INSERT INTO `tc_supplier_gallery` VALUES ('3', '3', '/Uploads/Picture/20170324/s_c14b3baabaaba57d.jpg', '/Uploads/Picture/20170324/c14b3baabaaba57d.jpg', '1490324143');
INSERT INTO `tc_supplier_gallery` VALUES ('4', '4', '/Uploads/Picture/20170327/s_a587ba06f05095e5.jpg', '/Uploads/Picture/20170327/a587ba06f05095e5.jpg', '1490605076');

-- ----------------------------
-- Table structure for `tc_times`
-- ----------------------------
DROP TABLE IF EXISTS `tc_times`;
CREATE TABLE `tc_times` (
  `username` char(40) NOT NULL,
  `ip` char(15) NOT NULL,
  `logintime` int(10) unsigned NOT NULL DEFAULT '0',
  `isadmin` tinyint(1) NOT NULL DEFAULT '0',
  `times` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`username`,`isadmin`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='后台管理员登录次数限制';

-- ----------------------------
-- Records of tc_times
-- ----------------------------

-- ----------------------------
-- Table structure for `tc_user`
-- ----------------------------
DROP TABLE IF EXISTS `tc_user`;
CREATE TABLE `tc_user` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `phone` varchar(12) NOT NULL DEFAULT '',
  `name` varchar(50) NOT NULL DEFAULT '',
  `head` varchar(100) NOT NULL DEFAULT '',
  `background` varchar(128) NOT NULL DEFAULT '',
  `password` varchar(100) NOT NULL DEFAULT '' COMMENT '密码',
  `sign` varchar(128) NOT NULL DEFAULT '' COMMENT '用户签名',
  `ismember` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0-普通用户 1-会员',
  `lng` varchar(20) DEFAULT NULL,
  `lat` varchar(20) DEFAULT NULL,
  `extend` text NOT NULL,
  `balance` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '余额',
  `integral` int(11) DEFAULT '0' COMMENT '积分',
  `is_supplier` tinyint(4) DEFAULT '0' COMMENT '0不是，1是',
  `isshield` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0-正常 1-屏蔽',
  `last_time` varchar(20) DEFAULT '' COMMENT '最后登录时间',
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=20000318 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of tc_user
-- ----------------------------
INSERT INTO `tc_user` VALUES ('20000000', '18084839200', '朱2', '98057bdef256507ff0f819573d8ef840', '', 'e10adc3949ba59abbe56e057f20f883e', '热得很22', '0', '-122.0416030883788', '37.39366910675608', '', '856.00', '2', '0', '0', '1490565912');
INSERT INTO `tc_user` VALUES ('20000001', '18069266759', '朱', '448da7519ad1d978d5b3fdc863e300dd', '', 'e10adc3949ba59abbe56e057f20f883e', '', '0', '103.9789173728967', '30.73859027530654', '', '0.00', '1', '0', '0', '1490351950');
INSERT INTO `tc_user` VALUES ('20000002', '13888375633', 'A≠L✨', '1579bc65e26b87986572f6dd8d7d66d6', '/Uploads/Picture/20160318/s_808ca7e029c6fd11.jpg', 'db8cf146f7f889185303385225ef616c', '闲人一个', '0', null, null, '', '1136.00', '7', '0', '0', '1490355642');
INSERT INTO `tc_user` VALUES ('20000003', '13128978113', '阿武', '6a1434cdabd0307ded8413fa47e9541a', '', '408098d9c4a6b279af859672436b6b26', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000004', '13559107544', '233', 'a69bccb2f8cc906ddd8c051d97aa5208', '', 'e10adc3949ba59abbe56e057f20f883e', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000005', '15953691319', '东邪西毒', '04fd639081216e5e9dc9e0841a817c7c', '', 'cf5b705a26c396e4d18e3b90c6bd57de', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000006', '18124238713', '失去再多又有何妨', '5e419f01d14ae9aebba8386079ec4550', '', 'e348d7c70286ef903c727b3959775123', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000007', '13547875489', 'hi', '039355624d4f9a5e760c32bf7c491fa7', '', 'c59f47736b1c5e08d60832556ab2703d', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000008', '15014141037', '崆流', '773d0ff475d9e5e62f2fecd9312e7f18', '', 'e9f5c5240c0bb39488e6dbfbdb1517e0', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000009', '17096689955', '朋哥', '07436261626b47228d470b9f7f7fdaf3', '', '2be0f050286c747c56aaa942f59e8f69', '结交朋友', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000010', '18581898815', '凯子', 'cfb675ca8aa8debe8462300abcf8099f', '', 'e10adc3949ba59abbe56e057f20f883e', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000017', '18702843514', 'nye', '913a7d86eefd732fc4a9f0662bc96cc8', '', 'e10adc3949ba59abbe56e057f20f883e', '娟娟妈妈', '0', null, null, '', '1008.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000018', '13075836662', 'Dddd', 'f22e384ea69645799c996d169bf67a15', '', '25d55ad283aa400af464c76d713c07ad', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000019', '18046104156', '哈哈', 'af365ac06f579766eead987791120019', '', 'e10adc3949ba59abbe56e057f20f883e', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000020', '13051581958', 'ocean123', '69d38e3671311c4e2e8b761cadbd6609', '', '9ae0147d65724f72f74804af4aac6f13', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000021', '18688004691', 'agfe', 'bfc592ecb594e6469e47ab478ab35a36', '', '25f9e794323b453885f5181f1b624d0b', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000022', '15734718360', '好幸运', '8985e15a49c52b8f6a44e1ba41ddb6b0', '', '9dc8ec9fdb17efb55b35c749a649b30c', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000023', '18334794054', '啊了就呢与', 'f1c1f71fd677e1134676959a10614c26', '', '1476f61d4c2aaabf7eac1ae3b359b64a', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000024', '13518127517', '哈哈', '0afa9c3a60f5a0b97ed6ab80e870e787', '', 'e10adc3949ba59abbe56e057f20f883e', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000025', '18388161128', '小刺猬', 'dc0feedf1cd49c6bd6de14a7fb330763', '/Uploads/Picture/20160805/s_e4ddfb7cf33a67ef.jpg', '724ee6cce0a9ff90a6de3dd492e2fa88', '', '0', null, null, '', '276.00', '2', '0', '0', '1490596620');
INSERT INTO `tc_user` VALUES ('20000026', '18254127300', 'test', 'd4b3bc19cae58f5d99a4cd200e443d81', '', 'e10adc3949ba59abbe56e057f20f883e', '', '0', null, null, '', '940.50', '36', '0', '0', '1490605916');
INSERT INTO `tc_user` VALUES ('20000027', '18420237858', '恐龙妹', 'db92a53e0d964f7c5fc490562caae990', '', 'bd11a2e315a76ed10a56117e3daac94a', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000028', '15982274873', '小飞', '1e1dfc11fdedf3a67880884256a94e60', '', 'e10adc3949ba59abbe56e057f20f883e', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000029', '15260783761', 'As', 'ebf55a80070d8befd89409863a0e0445', '', 'e10adc3949ba59abbe56e057f20f883e', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000030', '15041462526', '杀手', '88e0b5a2356f54ca47f0d54ec4e85ee6', '', '8cbb04a4e55bdcad877837bc239e54a4', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000031', '17787109551', '乐酷吧', 'e45cfd52a28627c9898d5b1054759d91', '', 'd0970714757783e6cf17b26fb8e2298f', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000032', '15658595752', '蕊', 'f2d2c8c2433ade1262370e01b3f80b4e', '', '7cc9f0f1d7e27e27434b06a473c37021', '看电影   诚招代理', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000033', '15059360298', '阳光', '03a944f9bb9cb2307a288da307c980b0', '', 'bbf2dead374654cbb32a917afd236656', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000034', '18007730738', '金金', 'a7dfbce108b084fd19d2be9a17310e19', '', '36e1a5072c78359066ed7715f5ff3da8', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000035', '13768203685', '薯片', 'e28e20bcfc33a7dea1d9169a5082febd', '', '80d805ffdbae4b08991ce93394687635', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000036', '15909173694', '初夏', 'fbce3e27356dea93bccd6d5c62c42ac8', '', '4858b209b1b9e66f35499a1557376c1f', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000037', '18206177218', '亮亮', 'a6a5d1ebe4ebe29bff6dd86ad15a27f2', '', '8a1ee2023212a250e293513c2004c222', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000038', '15679421020', '爱了不该爱的人', '0af16fe234441ef9554da3d21689c722', '', '6a8aeab493a8b080519746b5cf8c267c', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000039', '18507465843', '男神', '4a1079c93b3b22a387887dcb32e9ff9a', '', 'e1fb306ee612bb7c4e12541b88f88802', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000040', '15348540177', '学霸', '81576b7d524101730a85c174999c1d0c', '', 'c4293162cef3f60914080e584ffe8de8', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000041', '17854177493', 'biggirl', '9175932d56f796c942d2434601a28d14', '', '257b0ad7ff3f32a5eec2ea4cf2244c3c', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000042', '13997511240', '天赐', '79059d3a1f3faba6f6fc77b5a101b9f4', '', '728511292f31efb1c4f390647c985f3c', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000043', '13307359888', '向往', '473305bce95b61f9977d560f73ee82a7', '', '5957bf5f1cbba783c7520459f7056c4a', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000044', '18072152665', '爱的追求', '1f8427922427b377761fd243f560da34', '', '8ecefd008abefa0864fddfb22d4b7e05', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000045', '13998601875', '美女', '4a48d105d49c7a326b1b3ab3e319733c', '', '6962c167246e05db65b5a3bf1208072d', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000046', '13729920131', 'yanga', '395a303330bcbcd886e163ba7be0cc9f', '', 'c90dc3309380c89c666005a6db9e7cda', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000047', '13624294356', '缘', 'd2e213af72ac63c613bd0dbb27bfc7bd', '', '4297f44b13955235245b2497399d7a93', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000048', '18382841769', '爱无悔', '5ded53267329446a2ab8f4c16927ca0d', '', 'eb820cd8637649aca13bb36bbc800ef5', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000049', '13331177163', '小马哥哥i', '761655df2999f84408a80ecb4aee3de2', '', '769d09f4a4aaa351a684f4b9583c3494', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000050', '13858630915', '后来', '1c70de301120e24cc374b22c2e20c71f', '', 'acdf9418b742de549e64a47af8c1c1a3', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000051', '15812572183', '荣', '5c38c42dba42ce1ca33a73612b077bc3', '', '6328d6698c887e84a7ae9ee8f62fa161', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000052', '13328336197', '夏允', 'f49a6d9bf330f7bd94c999f6a2daaa32', '', 'f32e711d909f8bd8f0babe0456afd92b', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000053', '15199191826', '青春叛逆中', '09d9ce34546c7b51b9470fed55910c9d', '', 'f2194262f2cf932db514f01cbbea573e', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000054', '13944148014', '我', '6d146ef0d1c097ea690ec69e7838ad37', '', 'c5dfc6c462c35e310db5bded97bc824c', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000055', '13802965517', '周大', '174fbbc3540775caa4008e92cc1fef92', '', '04b508ee1c744f55791fbfd248617df7', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000056', '13302308881', 'Captain', 'da670a7d661695e63faccb6057889c4e', '', '776a595d77e4f3508c0522da689c8b58', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000057', '18121198052', '想', '64e75accba20ca105d7cf23706733c49', '', '76dfc8345eec84cc1d5cd818022ac7fe', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000058', '13566516752', '走走', 'a9ff543426582bb4493c4ea48ce10753', '', '51069fa0148e2dd5aedf26cda9a8a7ee', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000059', '13049578383', '梦语妮儿', '84455d7de041bb070b5bfff7a432e67e', '', 'a0ca2f802fd4ec24840ac19e016c290b', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000060', '13550200825', '虎虎', '27481e639401db412f85f78e36702c10', '', '870b744c430dad55e74f440e32e10db7', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000061', '18226333534', '123321', '76f3e9d3a9c7e7038c1e41e163599d19', '', '9bb70eaa73454a77e3d692938eadf17c', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000062', '13019172959', '群山', '52d894558baa308b25e8c2fb81700007', '', '8f75cb2afa28d699aeeea871efda73c1', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000063', '13697512431', '没有啊', '8d4d72cd2b1648cb9786d9b6c936980d', '', '6a5c771a1b0135abfcb6609066b88f84', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000064', '15690181700', '鬼火', '1004f1cd1dfe66b7a100960d2f5d3907', '', '75d41b4db8414845aabed4865730b1f8', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000065', '13984544146', '我是坏人i', '13e6156c74b5b46d5ce6f9772eb9e32f', '', 'd6614ca70d1eed57ffeee920b8d4204e', '失心疯！', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000066', '13714176150', '干嘛', '563474dcfb86251bb85ca95ad668a037', '', 'fcea920f7412b5da7be0cf42b8c93759', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000067', '18202633136', '奋斗', 'c7c6d54c9e7bd6928169304a1314a22e', '', 'e91edc794b625c95c5ee4c6f4c571fc4', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000068', '13946188779', '明天会更好', '18fcec3bde661050bbd5604ac89630e4', '', '8ace0b0e79ef44772b6a2f59480ba5ae', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000069', '15994490854', 'fyfdf', '8d916a719f796db2f805ae5fdc72a2b5', '', '98dae0e08c01f9e64dc3f9650eb5a714', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000070', '15000326929', '五元创业你亏我补', '127f14a84e4a3c6f7b894094b929103a', '', 'e31bbee6da4067fd443baf3a0d0af256', '五元创业你亏我补，详情微信a15000326929', '0', null, null, '', '0.00', '0', '0', '1', '');
INSERT INTO `tc_user` VALUES ('20000071', '18060741473', '玉米', '288942490c5756799573d3512c4df7a7', '', 'fdc7d5fda30a0f0b775a559da51c33ce', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000072', '18600161952', '哈尼吸纳', '8a5005c880917a984ce20132f0628665', '', 'a2a13fe1c218c3aed0187cf64e05d659', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000073', '18018764223', '宇宙第一', 'a45f020a06605f93b5b4b453923c0d68', '', 'e10adc3949ba59abbe56e057f20f883e', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000074', '18091556965', '予感', '8ca571e61be35a14bfeb910384d8a44c', '', '9a45aacc5375b18221c83bbedac2d204', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000075', '15818197621', '人生若只如初见', 'c14d682a7a221f72dec5a6d65f8903ec', '', '6b4ff07bf66021341d519fae77b1cdd4', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000076', '18688280442', '易枫', '201b23524ec3e12ea13d5c94cc31cb68', '', '1912e5e85d7991cbacebe653c464e93a', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000077', '15013962592', '', 'f44bb97068c7d13c7bd6ab367acfa5d2', '', '52cea4a6c4d29ced8666d07dd1250990', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000078', '15051319242', '空白', '745a6a7f899b45d38ac734351adba871', '', '89a271db0785084b28b87442adc9fa11', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000079', '15201787280', '姨妈基地', '891517ad644f5fb05f7ccfeb59ee7a24', '', '9722b3e5b6406fb72c121a99dc699c76', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000080', '18637361383', '幸福', 'ce70188740635b2f53e41094d73bb58f', '', 'e10adc3949ba59abbe56e057f20f883e', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000081', '15857176183', '婵', 'ac697c7cced9c463f23cbfb9743d00f4', '', 'e10adc3949ba59abbe56e057f20f883e', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000082', '18636610362', '00', '4c057f12062d0b85070fb70d738848be', '', '2eef15bc5342bc8baaca9bd7f0172882', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000083', '15885680634', '紫', '32821ea65f80aa79f767f6c4b843c665', '', '7bd05f15c6ea267c8c06ef10465851f9', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000084', '13685677217', '赵赵', '0a89809bf899f92bea0660bf83d4c3aa', '', 'bbbd0590916279d3cfb4bcaf03135233', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000085', '15287976950', '小三三', 'a6f0a9343ac2eb10b281462621820be0', '', '44927ab952d92b206bc37e695dea13af', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000086', '15729547834', '伤不起', '994d14daf06c884f50e266107cbfdfcf', '', '5e8144c745a64e773c45116ae5d8d0e4', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000087', '17769249262', 'π過客π', 'f5046da771cdf7e98d35fac5f7fcf450', '', '46e2cae0d0652dbbbaa26f2249997b91', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000088', '15060475958', '永不言弃', '330de6d7c7209832738fd8a6edad95dd', '', '57e615ce10a9ea0b69e566ad65ddc4df', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000089', '18202855968', '她说', '7e7211deb4d4762727dc35671e8df7cc', '', '25f9e794323b453885f5181f1b624d0b', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000090', '13689084790', 'dl', '27ce650e312d9ac119057dfa8c3a4584', '', '25f9e794323b453885f5181f1b624d0b', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000091', '15691626309', '一如既往', '609c2319c0a0e352a305fe8098e4012a', '', 'ac0c8d3a07ef4de9570cbf8dffa9fd34', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000092', '15399353553', '大力士', '069ace9ada2a431dc1161c15f3c839c0', '', '686cdad7f76a7b9e3ec75ee02195e105', '你的前几十年我没有参与 今后的每一年我都要陪你一起走过！', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000093', '18316871098', 'Xixi', 'fb2c703981147105c3da3dbf06a0ff21', '', 'b531acbca917de8f3a251b1d8e51b91f', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000094', '18748551479', '倾城伴你一生', 'bc1c5566573ce4d5d94a652e418b3cd7', '', '35314df2291a7ba05851ec60beef5a35', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000095', '13111707719', '爱&  太 傻', '07ca283aea309279d60bf24e214acce4', '', 'e85c3574e66a9be6cc14240743ba353a', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000096', '15228889962', '大丈夫', 'b9f9fcd2282f6bda933dc32a59ed6f49', '', 'e10adc3949ba59abbe56e057f20f883e', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000097', '18782929227', 'Ty', '05cbfbdd323e7d4dd0eb8b75540b4f18', '', '3952eaff80767a1c2c29dd2e875d6766', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000098', '13971331736', '路', 'a4ca22c336443c46945aa4cc9567dc1d', '', '9dc1fec1dd93f187ad7f2c6b954b7fb1', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000099', '13790270463', '恺恺', '2771c87398c01d73a221dcdbfa8561ca', '', '8a190181bad05527a7e288d1f94cb488', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000100', '18868643883', '玉泉酒坊', '37321838b7ed61401b40e606adb490e6', '', 'fca791b00186d55c6a2cbc3698c03a34', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000101', '18958946891', '空城&旧梦', '70d198b60e55e7ca5d23f38a7bee7eb4', '', '39efe67822d247520e20a1475d99434f', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000102', '18733080827', '一个人的天', '7c268d55e0015171681796b907132ed9', '', 'ce69eeb8ec97e9a8ec3faa0b02ac1545', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000103', '13652894911', '刚刚', '7989e07f0c9d7008063a6243795a2ea9', '', 'e10adc3949ba59abbe56e057f20f883e', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000104', '18185980777', '薇薇小雨', '444048efc3d32b8f621e8a1173e2690a', '', '14c5fabf1a4b67f24faac0ddf7f142be', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000105', '15049402293', '缘', '1e783f5d83dac6aa5902a85d9ac6698f', '', 'e10adc3949ba59abbe56e057f20f883e', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000106', '15537354892', '培', '9795876dc8d5f1b02f03044fa144ba3e', '', '2f96f84a42ec09012ea774f8db92ed8e', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000107', '15270764572', '。。。。', '75c77842226c13038bc13e13a0710e5f', '', '4c51beabd29e26d2e44ff79d7ee43729', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000108', '15093242634', '约', '4f07ca232d28e683d049e7dc235d7322', '', 'beb1b98c298fdfdfb76ee3d3f7b73dd1', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000109', '13534690697', '珊儿', '8e656f4d9a177a5fb66a810116ede93b', '', 'f53a3653ec870c1f0755606a9dc36f9a', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000110', '18565366121', 'alys', 'c8ff95ec26afe0183116314f61752ae3', '', 'd8d5ec8c900588805d3fa9d69a1082a1', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000111', '15140392339', '相遇', '053aeb5db19bfb64b0fe09b6f50c7a86', '', '7de2ea187d9bb13af2ef53ec78a909f7', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000112', '15270090435', '乐乐', 'fc803c17397b20ccdede343055dd8fc7', '', '70d2667e67d1eef0cf51acedc3a3ef31', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000113', '18668992259', '紫藤', '2418a522b5e9f2abad4b93d918b4fe42', '', 'a01b40fe474f86e1f9f534d0e217a54a', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000114', '15517652119', '小明童鞋', '4d0746b5ed9caec6c6b9443396e05cc2', '', '48f4eb5ca5c594d87225926134c51bb0', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000115', '18010666207', 'lo', '4b54306f499358aa667c2ef2d197de2b', '', 'e10adc3949ba59abbe56e057f20f883e', '儿童节快乐！', '1', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000116', '15135472920', '呀', '27587efd77f93948545796a25634143a', '', 'b8debfd49c631cb9b0b625c7249bee4e', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000117', '13822298631', '一壶酒', '0074f815354f504838c745eba11e17e3', '', 'df10ef8509dc176d733d59549e7dbfaf', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000118', '15851608921', '阿兰呀', 'b17640ea2f7b63650c9ed58cfe05e58b', '', '429ee3737580b8363a7932c9e6f9e5ce', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000119', '15186402993', '倩宝', '8be03d00c87e13307da9cd189da4a06e', '', '2ee4746a6292524cf7e33319d27c2fd6', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000120', '15534807517', 'a', '8b33f54271da725ee1c48ede2475c74a', '', '09fbad2c7b5d9897c5971b58e5a1b0e2', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000121', '18902356771', '永远', 'beb04b4fc0db86ac27c21e336441fa8f', '', '094a8b8298baa9080f8b19d6de08dd2c', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000122', '13529374436', '呆呆', 'f318bdba8ab8631e95f0a5d935283fd4', '', 'c7e22a8638038d9826bdc4417d50b860', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000123', '15712757701', 'Macro', '96808885ad729023f8dc3e0a0761c04a', '', '0192023a7bbd73250516f069df18b500', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000124', '15610505957', '甜甜', 'cf32410899f232268fb3c03f2bc06fe8', '', '4297f44b13955235245b2497399d7a93', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000125', '15100897261', '乔婷', '94535c1c45518ff836385e7549bb67b8', '', '3875ae440d8593321ac09977403201cd', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000126', '13934120437', '你好', '240af72ca7e90c3d99c72dae8dc0a938', '', '5f087d72357ecd8930b7fc5f94c1492b', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000127', '18718566843', '哈哈', '8659eb7f5bcfbcb37aa63e7de72ea607', '', 'a906449d5769fa7361d7ecc6aa3f6d28', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000128', '15951470016', '612star', '3816963327456faad641a84c3bef8105', '', '6a673aeac4a3d5109b2fd9884f05da47', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000129', '15267816395', '大渔海棠', '5e3354e0e3b68eeec203ce2d52bd0582', '', '37af2a9d883282322af429d7080ffa12', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000130', '18690933758', '云朵', 'edfebed9dde9390fd324fa02926c7dcb', '', '7416227f0f76cf31e3e2b5eaa412bf7b', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000131', '15870671806', '忧伤', '74cd34be25dd128652c98d9f226aa96e', '', 'b4703c4326db4ce8060c3a10ab42f41d', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000132', '13255179437', '谢谢让我', '50ba11bb26a74bb10974b571bcf51266', '', '25f9e794323b453885f5181f1b624d0b', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000133', '17756736162', 'WANG 子xuan', 'efddfe94a27c71a68b51b15395add0aa', '', '7520c4ec707663af66418eafc3090a71', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000134', '13555654075', '97轩轩', '13b247ef81da843cd1150dc4f4912126', '', 'ba831da4608667cabcf292b8df22d05e', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000135', '13785955931', '伟子', 'a7c7f0bf17d33808c66b3360f0267170', '', '5bac8939e9c71e5569fea56ee00d2ab5', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000136', '15266101430', '微微', '2e8c411b39ae0c2d98d886cbc4d0943b', '', '6fcd2693a3151bf8d6dacc8ff0e8531e', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000137', '15837462228', '平常心', '10720183c926e96b9ae2363bcd4a11ea', '', 'fbee81ea7a8267797be045f9cb8540ae', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000138', '15958754611', '已成过去', '934a4f54bf3552641a8035082a800272', '', 'c481b2edf2732b60e23574e2d599edd4', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000139', '18638077330', '瘾', '1d47686b086def048c8732bbd7436aad', '', 'ffa81b4e1775544109829bd2a78c9ae5', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000140', '15018522959', '云', 'b1ec67f8ce954320bc4a424460a69666', '', 'c0d1aadabd8269670332cd1d7f7380eb', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000141', '15946654040', '雪儿', 'b079d4f8ad200656664aaa7c4bd2e0ee', '', '827c0c301c445285dcd1933e7169ac5a', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000142', '18216590861', '江剑', '30466ffdf8f166820ad111353b61a860', '', '288339ec02f78cd3790ac765a97371c5', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000143', '15979100937', '夜夜', '0b0e129ecf40d0b466899ebffcff1f03', '', '3a715498b51a468e87e07820b3e72734', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000144', '15029512881', '洋哥范er', 'd12b731031bfb1982fa5d9fcdaad23c0', '', 'c0975636d70c0c9109bf331e9688dda2', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000145', '18064620082', '开心每一天', '10bf10d2e590ff9da9284193e630d2a9', '', '30dc5df7912f3c19fa92dfc2884e321b', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000146', '17785809629', '我靠', '57c3f0fae8838d24aeb13d87d91dc71e', '', '559f862b8abad2903458db976b36dd5f', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000147', '18735569166', '你爹', 'fb9fd0f69ff1a3b4cb11bff394aea442', '', 'ebffd2397be049f71ee069d80a829996', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000148', '18294657713', '阿绵', '485f9c4a37be7d645a6058dcaabb847b', '', '736d14c37d745a7f78b96829515553c0', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000149', '15776998712', '凤凰小妹', '3dd27b5f0d1c63b4e55c323b2d83906b', '', 'e10adc3949ba59abbe56e057f20f883e', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000150', '18288799154', '諾', 'e28e9e65a55122db04bf77d865b038ad', '', '2cd42bb60440316183fdf76e00ea0220', '分开时难过不要说……其实', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000151', '15821915484', 'tp991122', 'bb4e46b71e20ceabcddf1577e6fffb81', '', 'ee1cd70b1e91ecc00772200e8dc499ab', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000152', '13560601404', '焰焰', '14caae6bd320c10a7b6f85d134b81542', '', 'd219d7d1d65f74890555990751c16fb9', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000153', '15108688145', 'aini', '32d4952e328dc6a8d7030871d8037f4d', '', 'f0acf0fa7450dddd33f1efeccbf58a02', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000154', '15942901629', '爱的港湾☞家', '8760b7c2262675a37d36203f45925b07', '', '6b5d952c2c8644844b2090c75395940c', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000155', '13663617829', '懂你', '17aad6e5a9344dc7411fe1a10c1459c2', '', '009e2ea88a590c7510be105d97c47fbe', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000156', '13531048327', '，，', '9bc4ac50c037cd793a865d832ef6b0b3', '', '33654afac0918223d968604b9bb092bf', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000157', '13908426903', '感慨', 'c58d072a400bf925268f4cf8b5cd31fa', '', 'b5be656a7060dd3525027d6763c33ca0', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000158', '18083316531', 'hai', '06289aef53276db6edd05138d4c7bea8', '', 'b5311d386a4c78d0356dc9e84128f49d', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000159', '18739601072', '我', '327690cdb8e9e522b5365c6a28a35a5e', '', '6f13b7fe2a7f949ba77d07f258fa3c19', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000160', '18895424262', 'A~di', 'fc50156558d0e3b6c5a7293223c272c7', '', 'c3121c8be75683aadbafe01aa0805e35', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000161', '13662992974', '爱你❤', '773e07ff663c1c79662a258c4e93f7b4', '', '23bf90c5fd64d39732162a5dbc4132a7', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000162', '18739376788', '顺其自然', '18935c2993842e106be54d1acfc5da69', '', '60cb8de828df71c4201c491f0b0f361b', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000163', '15843004006', '木瓜', 'f358aaefae1d5890cc44233598d718e5', '', 'a4360009a51aee32237848d8d8280124', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000164', '15855850612', '*安然^', '158db328670b39be18925c0881382045', '', '37c22b5e3f9920bc5d85808d4319de24', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000165', '18751657462', '明天会更好', 'eed78ab2acc16cea023cb763e5d4731f', '', 'fc625b4004961c463d7aa97fec3684a3', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000166', '15121250942', '大叔', '70bbbaa97b73c29c8e91f3d575733443', '', '46fcb47844846b5b055f2b8d1e63f8e5', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000167', '13664978296', '老衲夜疯狂', '1508cc3ebd2817b7f5e57f39631e7b01', '', 'e7a1878fb11c0373dc646ae5ae18e43b', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000168', '13958300656', '波仔', '9975f3b5f402d514047ba57474b3f8cd', '', '64c7028169d195f63924eb73f0ed1db3', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000169', '18360022795', 'wangxiao', '146ec9cdcd5a0f00ea916ef800c0bfc6', '', '12b626535d7f2ec9bd7f9d43de4033b2', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000170', '18320530453', '苏', '662604ec4be7c0174f7089497c788fd2', '', 'e10adc3949ba59abbe56e057f20f883e', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000171', '13674832342', '新华保险', 'b0f08e7b4ddd8d85299059f3882f5348', '', '25f9e794323b453885f5181f1b624d0b', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000172', '15802040125', '小', '0b489d98dd0a17e6ff9d98bd40605c1e', '', 'e10adc3949ba59abbe56e057f20f883e', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000173', '13729658180', 'abc', '0f7abca38adedcfdfb142608c249ce3b', '', '25f9e794323b453885f5181f1b624d0b', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000174', '15271379067', '丽丽', 'de79eab0adbac09b1433780bf612c777', '', '421e096a76d883362d88e169b39d3c76', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000175', '13848024465', '彩虹', 'a6fcbce92674800447827333230fbb3c', '', '9d88823e0534bc00b049bd2f0c5d5bca', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000176', '15911906232', '人', 'cd06206673b005ae9de50a76b8ab051a', '', '20917c851c4a54f2a054390dac9085b7', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000177', '13863217583', '等待', '06bbfd030e311d0ee80a867cebdfbe82', '', '04945c79fd5d7171d972213429612dfc', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000178', '18273666379', '夏日荷花', 'b72a28bf574639214a2b661607a8378c', '', 'fdc0bde8afa5e528cd91c102a149fe93', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000179', '18029183885', '有你才精彩', '7e7fdfd37572a6b9c43e5044ebc6d49c', '', 'e4066c73c5cb4882e9a1ecdaa82d3ecd', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000180', '15829512975', '妳旳笑魅惑了涐旳瞳', '67d243ddd08c61301a2cbbee9e436a9f', '', '9c06c6b4e16d275dacd03ce1b32b4cde', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000181', '15098701780', '龙游天下', '65d395e67781b99b31556075c3737dc8', '', '4aa086ad9722c9401f32031b2f73ea6a', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000182', '18738307666', '北漂', 'c7cf8289af5e21cf9c629a2b8294ce2e', '', '0bec133c9379eda38f801beb3dc5a89c', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000183', '13957338146', '野狼', 'b0c6eef9fee18fb676be55d7362a4c8b', '', '647eaa58f56544e6dff29ad2838b7383', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000184', '18381397958', '不知道', '4d37380fb948a15ea02022defcd3d09b', '', '12bd41038119a3ebabd4ae6ca50ba515', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000185', '18386704286', 'yayyaya', '8e6a9997ac682c8e2782ed2a7956f81b', '', '0504ff811c5101e93354a9577a359b9e', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000186', '13003695842', '我来了', '11c179f31e53bd95a3aea56ebc3eadba', '', '25d687e2c7e715b2f1c9bc30a47b0863', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000187', '15843214749', '男人，范儿', 'c91f00acf2825d29a5a25d0da918a3e0', '', 'debfe1930d49c19b8ba07895fa226254', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000188', '13018511813', '猫小咪', 'f416d3b16a2b6b260f1f3a0e7ebc1e2a', '', '4f73b093a80dc4647951dc2675f901a2', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000189', '15219909839', '猫小咪', 'b6b5b0c702b0cf1685392619a757c59f', '', '3b9e30d430fe7a00903b0d8f6cf067b5', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000190', '15969080707', '章章', 'a8dcd25d06b281211113a61e09ccd00a', '', '99c5123c604437ba1eafd8a0e6425c8a', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000191', '13029267203', '王福林', 'a1197a7c8ddb98bb2e1dc12911dd5742', '', 'aa7e5c55b6789501b4c713f240df09dc', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000192', '18328820183', '杨丽', 'b5c8a599c1b4113c61ab30a8839b9462', '', '49b46a8a46614243c1883f572550f303', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000193', '18291735777', '柠檬草', 'd99d52e0ad193a7689fd2b00087d3486', '', '0116103674b765d5ffdf6e04b53b3144', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000194', '18236586831', '酷比魔方', '28b04f6dede734340ee43d4928986b19', '', 'd7eba8a2977c65d1532097e4eb76984e', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000195', '13414992786', '。。。', '8b6c8276d85b5238fdd7dd074af79e68', '', 'bbecfaaebabc4936cf436a42501b8598', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000196', '15059637108', '神技', '8247fcb9d2ca6d11d77701c0e127c836', '', '333830a9c059f2af7495c30ade972a63', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000197', '15363226566', '老乐头', '4ebb3a68d5fe5bc1186e8659c69ad2b3', '', 'aef80632885c902732e05eda97fd3f33', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000198', '13483049538', '卟镶棟', 'b533811f347c26ba88afe1f6b7385cc3', '', '18259c3e488cc90ac28739b7b8c4ad5d', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000199', '13195390203', '半醉半醒半浮生', '05d4484bd1ff9d65e7489f15c05f5a77', '', 'cdf854c12dd3de2771347524ce221f3e', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000200', '18221063573', '马', 'cb81c08d9d2670df332fdd5adf6fa311', '', 'e10adc3949ba59abbe56e057f20f883e', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000201', '18853557565', '秘密', '6597c3afd6214c74961d436916a0d516', '', 'b9cfaa80baeeafa5fc4cb578ba72d836', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000202', '15100436636', '我', '41da54da6a7e53fd66319cbb54f3234f', '', '9d55248c06ed18d08cd5c32125f87051', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000203', '13515740735', '想你', '4873ed61707c7d944594ffd3b5e80a97', '', 'dfe5a347d5092244ba8a1e980fa6577c', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000204', '18714781617', '小雪', 'a5c1064a8eb0c776e5da61c66f3b2785', '', '18fed11e1d4f2a6198484104964f1d8f', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000205', '15166645328', '任性也会被人宠', '2fb5ab03e73260e600f67bda2751802f', '', '246d24c240c59c5a2de970be181b7cf7', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000206', '15703039256', '妹儿', '3073d73c87e909eb4e856370ac235f12', '', 'b346d002a43f8d89e9980a9ec3bf44a7', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000207', '15205496111', '天少', '13b51e24f1546e3de55f4c03beb6ee34', '', 'ea53a5087a087641f7122ec338400660', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000208', '13768638806', '莫默', '271ca5f8e78a65f5f9004314278a3953', '', 'e10adc3949ba59abbe56e057f20f883e', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000209', '15724443677', '迷恋祢的溫柔', '8c17694c53ba4b168dbdd1b55245dfcf', '', '9c6498be1bddaf3ef337d364b3f6c66d', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000210', '18818476853', '紫', '16a9b7f9051d781b1581600d5f64edb6', '', '255bc8ef1892b658a19717312cfd9367', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000211', '13803547665', 'ミ指尖的烟味残留び', '1f33dbfd9948552eb73ae95ca4c207d2', '', '0f7b28ce5de245763723f5844c5d1ecf', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000212', '13645110845', '花儿', '8ac55f098a58571d5787bf265060a8ed', '', 'bc1e97bd35e6af7e3e8072494ae5f669', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000213', '18265223464', '今生今世陪伴你', 'c28add8d00f651f93d126f2d19538427', '', '8b564f041d5da9a03caf011aa262c27e', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000214', '15109918523', '一根烟的世界', '6727759b9640d6daaaf1a0ab7f90838f', '', 'ae9cee733048e7093cff75cc01813926', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000215', '18192189598', '伤心的梦', '0364d3e4b4664d2fbb432d4e400b7a79', '', '5af766601e8db7a3de53e8a987c03e27', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000216', '15538227068', '我', '44cf9759c2f8bfe35d081e5e8dcbdc31', '', '2297d0b3db0bb7c745c02a2068b1bd5a', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000217', '13758825947', '男', 'cb2c64e13403c10332c7509b8e87fc31', '', 'e10adc3949ba59abbe56e057f20f883e', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000218', '18850066452', '你的名字', '747cf620c9a2a6be4e6082312b04dddd', '', '30338de60d7690901b720bcceb4e1194', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000219', '13844626770', '小志', '0630c38bada0876b9e7e5c736df5a02e', '', 'c3969e93d73a312ae1d279a4b9a7ad07', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000220', '15870148060', 'Annie', '9d8f60113e2de9a35345886dab5506ee', '', 'f928e92f473635de7ee5511277caf33b', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000221', '13983108692', '兰', '76e54bd1e41d389ec104d97626869ce2', '', '34a0d98a92940b7a8af8ef8b4f0a60f6', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000222', '17052655520', '雪少。', '251163721e1e17829d782cc7e9d50265', '', '01b9d9a14a4a8780ed6420541676d8ef', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000223', '13612241705', '你们不要我孤独哦！', '355c3f3737d8aaf4240ae223276956a3', '', 'ba8ea54215235bf067d77277790d6e07', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000224', '13991492593', '梦', '6e4337135209d37cc5abb040f9953a91', '', 'c551a16f4e2edda2d5b8de203cd3cfa6', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000225', '13761588392', '心心', '35ed1e211456e382eb1c2d7302f38f98', '', 'a58807012b696762d6b9ef182e7fee9a', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000226', '18501560969', 'flora', 'a176cf824b556070bfa784df37751d1f', '', '643741d296e15732eb6d72d419a1be5f', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000227', '15146908423', '酷爱', '3cb60cd80b4e2031d42b525536fb2b70', '', 'e10adc3949ba59abbe56e057f20f883e', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000228', '13568040636', '绝恋', '9d47130b33bc9b3168e6f460f1b9a82c', '', '21a770e85effa28f1190ae0688aba9bf', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000229', '18615932227', '颖子', '1a5bceae17953cc12186003d87c391ec', '', '4c91b2d6beedda042a4b240d6a903c9a', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000230', '13557103104', '火水木金土', '3df83adcf0051c5df6874b816ca86df7', '', 'a84d0d73774e79d5e8dd2fd3394ad7cc', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000231', '13411147051', '琪宝', 'f310f4cecfb07fa853220d026f48be53', '', '44d42f008df6dd8a24e12a9a4b05f460', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000232', '13006616220', '無限月讀', 'fde781b12a2e8cb00eec7455baaf9785', '', '57989ad8cbc1226816ab823109845833', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000233', '18232461797', '回忆', '1116f588f9bf55e5d32e7b0b50617a0b', '', '11c9719affff7a3af77f426ad165c70d', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000234', '15715868845', '我的真诚', '1082042d40c71736bbbcf7d645fdedba', '', 'e10adc3949ba59abbe56e057f20f883e', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000235', '17714376125', '甜甜啊啊', '2bbdc15d48c2a11c0442915b618923cf', '', 'c7658044a84b2fce2061a2afc07c42da', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000236', '13798635584', '厌', '7d786aaa912cb5280643661898dfd358', '', '25f9e794323b453885f5181f1b624d0b', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000237', '15036552769', '我的秀发', '5e014d594fa93f5459c03d6b67391bd6', '', 'fc0111f67636612cec1d217843e2d496', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000238', '13176995238', '悠悠我心', 'bd4b39663d6d209cb7e489a5a366d458', '', '9dc718ce51caebe8cbbb809853a4fec4', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000239', '15950900955', '至尊', '04cd261e876d1c910fc7a9387492d807', '', '9e0cc0207cda16f4c05909e1194e6e93', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000240', '15296548355', '熙雯', 'a5381eed6a1a09fe183543760e721530', '', '7ab7bf91bf8fed51869d31121caa6c6a', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000241', '15607746960', '我想牵着你的手', '406892ff7862b2df7a4f5d97790dca1c', '', '763b8787dced9a10709069b9e5f5911b', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000242', '13765474100', '从头再来', '157c1cc9224dad173914bf1b5290b92b', '', 'a8be9c995520a592c401354d4df34813', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000243', '15998090117', '轩轩', '0d2c8245d3e41b5500c5fc4ba8dd9e49', '', '62ea0c7e63656ad2dabece8b61a90452', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000244', '13170392822', '枫叶', 'd1e0ed848e7f5c25ab33d97e6d8b8a8b', '', '6b20fbf3b89d248684be64f20f771586', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000245', '18606200729', '霹雳唱功', 'cf227c30295b4f749e7e04eed9455c38', '', '1b1022d35e0786e10e5d91e89820842b', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000246', '15143781528', 'me梦想xiao成真', 'b502a4291359ee596cddb14b7f16d59e', '', 'b2ed2bef897b0a15c3bcc3fc4e610d0c', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000247', '15008832969', '雨欣', 'ade4a685a7c918da2805c3272a20df1f', '', '90ed35b00f62786423767e24deaaae97', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000248', '13718772770', '安晶', '6267cecce7ba37c43ddf269e5b509dc6', '', 'd6a8aabf8e2d91e998979b3146446bfc', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000249', '13637981545', '落雪', '2f7ecce907b8332d06c3b39c7dc44db4', '', '6d503e2d60dfef744f799efcbffdceb1', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000250', '13525357044', '开心', 'a602c949d9291930aba17c51a4961c68', '', 'deb863ab3850c27260e5255cfb668ff7', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000251', '18212690919', '三辈子', '73285f772046f0419b7cc95e38f3e23e', '', '5de4c6846cbae2f68ac21331d7318457', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000252', '18868659978', '酷我喜欢', '97e2db890da9ea7658de60cbf75e2825', '', '61a65fe8b289194ddd55f4ca20d79bf5', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000253', '15816160394', 'zzw', '1e2ecc0fd2384e128c43ffbd766c13c6', '', '065cd98c73abbb4850979cc5d41f3c41', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000254', '15815118981', '许多多', 'a56f14f3c197b92cfc07e20dedab4c3f', '', '21c3ac035a531a25c38f4cf8fc0cb9ba', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000255', '18129807539', 'AL', 'ad8ea6238a4aedfb3828a13220975314', '', 'fe6cbcf07e5737a1331b0aff53dae3dd', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000256', '13421204547', '娇姐', 'fe7b6f3e837f4ec370773579a2863c34', '', '82a649881a80271ac572f69a1a5b8c49', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000257', '13931480502', '卢龄嫒', '6d9b86d5f833f274d5e7d00c5d3aeb1f', '', 'c44882fd412d26623daa018227c377ab', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000258', '13761524300', '不死鸟', 'f760fd07e725bb4761f2175b8c8a9231', '', '40b62b9c86826d559d916751ddd6eeaf', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000259', '15025021888', '九哥', '8c1f4eca3cdba8dd8697597b3de95526', '', '2e5eea1a6969b694c8a791dd863f4ae7', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000260', '15978408248', '开心', '1c3e2aaddad65a9596bf3ca1db7d2489', '', '1cffc4d3e7e6f3b30cf1cd8ca3ad907b', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000261', '15897329885', '果果', 'ab3b92e39f9965282f54f389e8fa8ffa', '', '91abbc90817f03e0d75db5fe7f33b361', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000262', '17759081011', '天狼', 'd3516181970fbf0ba6fc9871403c1c27', '', 'd6d77e5429aaafeda5e092c2af5c8611', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000263', '15098087736', 'kevin', '7157df76efb7af05715ab10de8bd9879', '', 'c05b12136d25264df822880c52d006a4', '', '0', null, null, '', '0.00', '1', '0', '0', '1490242528');
INSERT INTO `tc_user` VALUES ('20000264', '15708486676', '刘村', '006ecbcf674be316a87543a70afcf48b', '', '96e79218965eb72c92a549dd5a330112', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000265', '13841643729', 'VLOOKUP', '09ddf948c97c84441f2e22cd6c8b2385', '', 'e98d333a19295b3cb5cc649502ec9cd1', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000266', '15084122445', '大明', '8c7a45c27cdb144f29f907f6cd1cb3b5', '', '93f2a06602c2b3b4574592e65de7803f', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000267', '18681316172', 'kipp', '4f966d28eac0dd98e4f7cadd31d35db7', '', 'e10adc3949ba59abbe56e057f20f883e', '', '0', '103.9788409671471', '30.73863273682892', '', '0.00', '1', '0', '0', '1490604400');
INSERT INTO `tc_user` VALUES ('20000268', '13876813574', '立', 'ecb4dabbfc96b21e6145ceb33346907b', '', 'd7a4ae2ae8754694cb82ec1a6e0a3d1a', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000269', '15940850335', '温柔小公主', '708eea5a712991d35bfc9755782014c2', '', '6176340cb5d4f7325ce37c6774cf4b5c', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000270', '17508724455', '一生有你', 'b23fd9856d02979bdebf2d42b2fda3d2', '', '53d7283c694b6f7baa387296eeeeb2b5', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000271', '13802976171', '狼族石头', '7b19834e8183cc5113ace500670191a7', '', 'd029ce616bd210060de8c2c74dbabae7', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000272', '18810521035', '浪尖', 'a33ae34e574f81dbed1f144735fd5f74', '', '8952e12ac7057f82a888e948c2e40a2d', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000273', '13770422043', '浅浅', '6da8069ed7bd0827746e4dfb8f030afa', '', '1ddc4064ccda43dc5d155dae7f7b0315', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000274', '13157188232', '孙悟空', '9d6fcdb5f42095ab14fc6a85f93670a3', '', '16f438a97f0193bcebe998d3e63ba440', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000275', '18739775421', '123', 'aaedf31f077b7ec61e872fe892b36d02', '', '7abcd741ad0eabaa65a806d3780323be', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000276', '15935105819', '秋风', 'd72d28e2732178cc89b0c373cabcd1e3', '', 'd983611b42cfcd28ce3be419ea5dae9a', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000277', '13950179553', '野狼', 'd6a23528088630b4560e7affb7e37f80', '', 'c6ecc58775fa730e94126fb3a458e1b8', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000278', '17300145101', '毛元元', '08134dc3b6e7757c55be06c0f37a1db6', '', '6a0a84e283405218254cb632cb462cb1', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000279', '13697501140', '小酷哥', 'e3e2cb51bb2fc5dec0099a765ee3df47', '', '80c37f5516047bd12a6175e9f9828911', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000280', '18313791605', '兮兮糖果', '1b4d4188333a59319c7ff504350cfebe', '', 'a135b892456b0636d3ca99c322520626', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000281', '13824845690', '呵呵呵', '8a2d3532806a2a001a47d1d37268d704', '', '4ffce161750bb6a5c55f78bcc1183a92', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000282', '15169858485', '嗯', '14e3165f3cbb428c51d74e6349a30928', '', '257f949327516704118eae32dbec22b6', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000283', '18789237984', '刚好遇见你', '4ed8753fed5ed622c427de627d4ad521', '', '3b376155f0654b31c00ed8133f3c1ea1', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000284', '18313063143', '不健康', '68b1ab59c50668835d94e08c17f95845', '', '7b6a3801cf52b9d696f325ebce0a61bc', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000285', '18016579389', '魑魅', 'e625e9d2ee5adb065c8b92fe498cdad1', '', '4df9143bb1328730a177fa5135e09981', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000286', '15946815306', '珍', '274c9aaa0f3362b612b5597193630ae3', '', 'b591ba7e150c377011197e1a4abe109b', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000287', '13504032403', '略略略', 'dea5f97700e4045addde56d43d1f25f8', '', '08d78c2c5ab34067bd2fe417934e1e98', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000288', '15296430115', '黎明', '38309cc8bf1319d76ee188bfa28cf3a3', '', '72b5b6198e73f9f633f7d1290398f469', '越来越美好', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000289', '15040354090', '金牌男怪', '7d6ab100c467e062cbbd24b27a0364e1', '', 'c8a25c2f9ce8f5ffea79aa127cda5014', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000290', '13944145809', '真爱', 'ee138fd86b0a4b9391ca5c641397839e', '', '00e4daa851880b7d4f7a8c119b5797f0', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000291', '15582355122', '孤独何惧', 'da20a3877b7a75234a23409450a004f0', '', 'dc5ce62675297d1d13f8761322e601b2', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000292', '13595376507', '空白格', '72338f33b3fd4ff9b366fc49230ddf05', '', '8bbd24fc600d0aef65e3471004242dc9', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000293', '15052581393', '春暖花开', '7f80b4788acae12ebb3dace7cc1095ba', '', 'cd8510850ed24ab0d9469769e5aff7b1', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000294', '15351953737', '丫头520', 'a41133ab431a7a0f6cf25020ba791a45', '', '5061eb03c1a44285fa663d849d12edd8', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000295', '15970085271', '豪', 'ffdf95ca1bbee06f97ab9f8d5c4078b3', '', 'e10adc3949ba59abbe56e057f20f883e', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000296', '15736842697', '融景城广场', '8ab206b03b0aad5f6e88ba57b45fc616', '', '1d7b8188c31ca5045a3c711b36e52b3c', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000297', '17758902262', '二楼上图', '6b56f0f600dc17b61760f0b4afd1b5a6', '', '8edbf46521a91fd1849e907ffabfa257', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000298', '18317078265', '回忆是殇', '795d426a35f1ae7208ce21c5519fcf1a', '', '7e694fc626c994854b6e035e274159e0', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000299', '15885201217', '离别愁绪', 'abd18dd0df20dd2cdc8ae2b6d3094f95', '', '305593e4236432a35343468d725a1068', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000300', '15678610518', '沙', '6a1bb9841c7ea124046d75cfc983177a', '', 'e10adc3949ba59abbe56e057f20f883e', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000301', '13822509869', '糊涂虫', '6c58d137aac94d021495584cf7a64bde', '', '7907c65d6e9a4afdcb9474bff675fa05', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000302', '15237522078', '王海', '7ad74db057345d3b3387a35a209a5b3c', '', '72a34ac6edbd30597930c28725a8b17f', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000303', '15734512049', '李亭亭', 'eac9a6e7130dcf9571919a71496a6b48', '', '720133c7afc66071f76aab2c36f728d3', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000304', '13999958344', '平安', '903d95b29eb12ecbd212cd073e47c6dc', '', '0a84551d8af102a68b6ecb09f0e0f0b7', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000305', '13577348083', 'w', 'fe36e940a60dba2550e3297542429b69', '', 'e206a7612c07892cfb3b7a2feaf22d1c', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000306', '13292106916', '文文', '5e0abe10a09565a07a485abfd396873d', '', 'c83a943e158dc1013985df73aa8572e1', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000307', '13280313128', '一二三四五五', '02d19e01ef6bd4d7f8ff1ac5faef881e', '', '295eb5b0eb296de9bcb4ded7a2df7d36', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000308', '13644193686', '小露珠', '7757fcb17713cff12f4ac2e5e35585eb', '', '470667378329f8a255902c6e00bd02ca', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000309', '15832367167', '秋天', '04a732d00bc3d9748077ee913aa4bf65', '', '3d24b838770ee90773804e8599e549ff', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000310', '15041396518', 'qwetjv', '5382fe4fa89b131106676dc21b184191', '', '02c75fb22c75b23dc963c7eb91a062cc', '', '0', null, null, '', '0.00', '0', '0', '0', '');
INSERT INTO `tc_user` VALUES ('20000311', '15685386262', '向往未来', 'f0de9cda876390eb220d74d5e8b746d7', '', '590c77d029fa6e4dcfa0fbbda9eff737', '', '0', null, null, '', '0.00', '1', '0', '0', '1490169381');
INSERT INTO `tc_user` VALUES ('20000312', '13888888888', '铁路局', 'bc0341cfd39a16f0fbee0324d87a3d13', '', 'e10adc3949ba59abbe56e057f20f883e', '', '0', '103.9787798810099', '30.73871707495711', '', '100.00', '14', '0', '0', '1490581578');
INSERT INTO `tc_user` VALUES ('20000313', '13422222222', '哈哈哈', '5b839eb96af564c4740bb957bfc9fa1f', '', 'e10adc3949ba59abbe56e057f20f883e', '', '0', '103.9789938268127', '30.73861077545288', '', '398.64', '108', '0', '0', '1490577194');
INSERT INTO `tc_user` VALUES ('20000314', '13500000000', 'yYY', 'f7397a1ad4f4d465592d04be10f7be10', '', 'e10adc3949ba59abbe56e057f20f883e', '', '0', '103.9788409791359', '30.73864799914874', '', '100.00', '12', '0', '0', '1490321039');
INSERT INTO `tc_user` VALUES ('20000315', '13700000000', '呀呀', 'add232eb775eba2fe6603be1d85c17a8', '', 'e10adc3949ba59abbe56e057f20f883e', '', '0', '103.9788180262594', '30.73862143801883', '', '86.42', '87', '0', '0', '1490576668');
INSERT INTO `tc_user` VALUES ('20000316', '13400000000', 'uu', '756022a5ae0b04bb17de8fb813ff20be', '', 'e10adc3949ba59abbe56e057f20f883e', '', '0', '103.9787721696098', '30.73863127406619', '', '194.00', '69', '0', '0', '1490582944');
INSERT INTO `tc_user` VALUES ('20000317', '15800000000', 'uuu', '2c41bdc62ffd0599e3697ca78f4ac18c', '', 'e10adc3949ba59abbe56e057f20f883e', '', '1', '103.9788639153993', '30.7386535749983', '', '120.00', '1', '0', '0', '1490604979');

-- ----------------------------
-- Table structure for `tc_user_account_log`
-- ----------------------------
DROP TABLE IF EXISTS `tc_user_account_log`;
CREATE TABLE `tc_user_account_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL COMMENT '用户id',
  `content` varchar(100) NOT NULL COMMENT '备注',
  `price` varchar(50) NOT NULL COMMENT '变动金额',
  `current_balance` varchar(50) NOT NULL DEFAULT '0' COMMENT '当前余额',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '变动类型，0增加，1减少',
  `create_time` varchar(20) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=189 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tc_user_account_log
-- ----------------------------
INSERT INTO `tc_user_account_log` VALUES ('1', '20000315', '后台充值100元', '100', '100.00', '0', '1490265899');
INSERT INTO `tc_user_account_log` VALUES ('2', '20000314', '后台充值100元', '100', '100.00', '0', '1490265910');
INSERT INTO `tc_user_account_log` VALUES ('3', '20000313', '后台充值100元', '100', '100.00', '0', '1490265912');
INSERT INTO `tc_user_account_log` VALUES ('4', '20000315', '发现活动报名扣除余额，订单No：2017032454999898', '10', '66.00', '1', '1490323638');
INSERT INTO `tc_user_account_log` VALUES ('5', '20000313', '发现活动报名扣除余额，订单No：', '10', '90.00', '1', '1490323719');
INSERT INTO `tc_user_account_log` VALUES ('6', '20000313', '提交订单，使用余额，扣除余额，订单No：2017032454495253', '0', '90.00', '1', '1490325590');
INSERT INTO `tc_user_account_log` VALUES ('7', '20000313', '提交订单，使用余额，扣除余额，订单No：2017032448995752', '0', '90.00', '1', '1490325616');
INSERT INTO `tc_user_account_log` VALUES ('8', '20000313', '提交订单，使用余额，扣除余额，订单No：2017032498571025', '18', '72.00', '1', '1490325627');
INSERT INTO `tc_user_account_log` VALUES ('9', '20000313', '定时任务取消订单，订单退款，订单No：2017032454495253', '-2', '70.00', '0', '1490325661');
INSERT INTO `tc_user_account_log` VALUES ('10', '20000314', '提交订单，使用余额，扣除余额，订单No：2017032499509857', '56', '44.00', '1', '1490325676');
INSERT INTO `tc_user_account_log` VALUES ('11', '20000314', '提交订单，使用余额，扣除余额，订单No：2017032450495450', '6.5', '37.50', '1', '1490325714');
INSERT INTO `tc_user_account_log` VALUES ('12', '20000313', '定时任务取消订单，订单退款，订单No：2017032448995752', '0', '70.00', '0', '1490325721');
INSERT INTO `tc_user_account_log` VALUES ('13', '20000313', '定时任务取消订单，订单退款，订单No：2017032498571025', '18', '88.00', '0', '1490325721');
INSERT INTO `tc_user_account_log` VALUES ('14', '20000314', '提交订单，使用余额，扣除余额，订单No：2017032410057495', '28', '9.50', '1', '1490325741');
INSERT INTO `tc_user_account_log` VALUES ('15', '20000314', '定时任务取消订单，订单退款，订单No：2017032499509857', '56', '65.50', '0', '1490325781');
INSERT INTO `tc_user_account_log` VALUES ('16', '20000314', '定时任务取消订单，订单退款，订单No：2017032450495450', '6.5', '72.00', '0', '1490325781');
INSERT INTO `tc_user_account_log` VALUES ('17', '20000314', '定时任务取消订单，订单退款，订单No：2017032410057495', '28', '100.00', '0', '1490325841');
INSERT INTO `tc_user_account_log` VALUES ('18', '20000316', '后台充值100元', '100', '100.00', '0', '1490326391');
INSERT INTO `tc_user_account_log` VALUES ('19', '20000316', '后台充值100元', '100', '134.00', '0', '1490326811');
INSERT INTO `tc_user_account_log` VALUES ('20', '20000315', '提交订单，使用余额，扣除余额，订单No：2017032454511015', '35', '31.00', '1', '1490333622');
INSERT INTO `tc_user_account_log` VALUES ('21', '20000313', '定时任务，10天之前的订单打款给卖家，订单No：2017032454511015', '35', '123.00', '0', '1490334121');
INSERT INTO `tc_user_account_log` VALUES ('22', '20000316', '提交订单，使用余额，扣除余额，订单No：2017032499999949', '100', '34.00', '1', '1490334348');
INSERT INTO `tc_user_account_log` VALUES ('23', '20000313', '定时任务，10天之前的订单打款给卖家，订单No：2017032499999949', '100', '223.00', '0', '1490334601');
INSERT INTO `tc_user_account_log` VALUES ('24', '20000313', '提交订单，使用余额，扣除余额，订单No：2017032454575210', '144', '79.00', '1', '1490334806');
INSERT INTO `tc_user_account_log` VALUES ('25', '20000313', '卖家同意售后，直接扣除余额，订单No：2017032499999949', '100', '-21.00', '1', '1490334867');
INSERT INTO `tc_user_account_log` VALUES ('26', '20000316', '卖家同意售后，退给买家，订单No：2017032499999949', '100', '134.00', '0', '1490334867');
INSERT INTO `tc_user_account_log` VALUES ('27', '20000315', '定时任务，10天之前的订单打款给卖家，订单No：2017032454575210', '144', '175.00', '0', '1490335141');
INSERT INTO `tc_user_account_log` VALUES ('28', '20000313', '定时任务，10天之前的订单打款给卖家，订单No：2017032497504899', '100', '79.00', '0', '1490335741');
INSERT INTO `tc_user_account_log` VALUES ('29', '20000316', '卖家同意售后，退给买家，订单No：2017032497504899', '100', '234.00', '0', '1490335824');
INSERT INTO `tc_user_account_log` VALUES ('30', '20000316', '定时任务取消订单，订单退款，订单No：2017032456565655', '50', '284.00', '0', '1490336341');
INSERT INTO `tc_user_account_log` VALUES ('31', '20000313', '定时任务，10天之前的订单打款给卖家，订单No：2017032498519797', '50', '129.00', '0', '1490336701');
INSERT INTO `tc_user_account_log` VALUES ('32', '20000316', '卖家同意售后，退给买家，订单No：2017032498519797', '50', '334.00', '0', '1490336760');
INSERT INTO `tc_user_account_log` VALUES ('33', '20000312', '后台充值100元', '100', '100.00', '0', '1490339211');
INSERT INTO `tc_user_account_log` VALUES ('34', '20000313', '定时任务，10天之前的订单打款给卖家，订单No：2017032448501025', '100', '229.00', '0', '1490339881');
INSERT INTO `tc_user_account_log` VALUES ('35', '20000315', '提交订单，使用余额，扣除余额，订单No：2017032452549998', '26.5', '48.50', '1', '1490340996');
INSERT INTO `tc_user_account_log` VALUES ('36', '20000315', '定时任务取消订单，订单退款，订单No：2017032452549998', '26.5', '75.00', '0', '1490341081');
INSERT INTO `tc_user_account_log` VALUES ('37', '20000315', '提交订单，使用余额，扣除余额，订单No：2017032451571005', '20', '55.00', '1', '1490341507');
INSERT INTO `tc_user_account_log` VALUES ('38', '20000313', '定时任务，10天之前的订单打款给卖家，订单No：2017032451571005', '20', '249.00', '0', '1490341681');
INSERT INTO `tc_user_account_log` VALUES ('39', '20000313', '卖家同意售后，直接扣除余额，订单No：2017032451571005', '50', '199.00', '1', '1490341785');
INSERT INTO `tc_user_account_log` VALUES ('40', '20000315', '卖家同意售后，退给买家，订单No：2017032451571005', '50', '105.00', '0', '1490341785');
INSERT INTO `tc_user_account_log` VALUES ('41', '20000315', '后台充值100元', '100', '169.00', '0', '1490345910');
INSERT INTO `tc_user_account_log` VALUES ('42', '20000315', '后台充值100元', '100', '269.00', '0', '1490345922');
INSERT INTO `tc_user_account_log` VALUES ('43', '20000315', '后台充值100元', '100', '369.00', '0', '1490345924');
INSERT INTO `tc_user_account_log` VALUES ('44', '20000315', '后台充值100元', '100', '469.00', '0', '1490345924');
INSERT INTO `tc_user_account_log` VALUES ('45', '20000315', '后台充值100元', '100', '569.00', '0', '1490345924');
INSERT INTO `tc_user_account_log` VALUES ('46', '20000315', '后台充值100元', '100', '669.00', '0', '1490345924');
INSERT INTO `tc_user_account_log` VALUES ('47', '20000315', '后台充值100元', '100', '769.00', '0', '1490345924');
INSERT INTO `tc_user_account_log` VALUES ('48', '20000026', '提交订单，使用余额，扣除余额，订单No：2017032648495550', '18', '982.00', '1', '1490496032');
INSERT INTO `tc_user_account_log` VALUES ('49', '20000315', '定时任务，10天之前的订单打款给卖家，订单No：2017032648495550', '18', '787.00', '0', '1490496181');
INSERT INTO `tc_user_account_log` VALUES ('50', '20000026', '定时任务取消订单，订单退款，订单No：2017032652559897', '6.5', '988.50', '0', '1490497561');
INSERT INTO `tc_user_account_log` VALUES ('51', '20000026', '定时任务取消订单，订单退款，订单No：2017032698555597', '6.5', '995.00', '0', '1490497681');
INSERT INTO `tc_user_account_log` VALUES ('52', '20000313', '定时任务，10天之前的订单，有售后但为拒绝退货，打款给卖家，订单No：2017032651535350', '4.5', '106.64', '0', '1490498041');
INSERT INTO `tc_user_account_log` VALUES ('53', '20000313', '定时任务，10天之前的订单打款给卖家，订单No：2017032699515254', '6.5', '113.14', '0', '1490498281');
INSERT INTO `tc_user_account_log` VALUES ('54', '20000026', '卖家同意售后，退给买家，订单No：2017032699515254', '4.5', '999.50', '0', '1490498366');
INSERT INTO `tc_user_account_log` VALUES ('55', '20000026', '卖家同意售后，退给买家，订单No：2017032654559752', '4.5', '1004.00', '0', '1490499414');
INSERT INTO `tc_user_account_log` VALUES ('56', '20000313', '定时任务，10天之前的订单打款给卖家，订单No：2017032652501001', '6.5', '119.64', '0', '1490499481');
INSERT INTO `tc_user_account_log` VALUES ('57', '20000026', '卖家同意售后，退给买家，订单No：2017032652501001', '4.5', '1008.50', '0', '1490499537');
INSERT INTO `tc_user_account_log` VALUES ('58', '20000313', '卖家同意售后，直接扣除余额，订单No：2017032652501001', '4.5', '115.14', '1', '1490499644');
INSERT INTO `tc_user_account_log` VALUES ('59', '20000026', '卖家同意售后，退给买家，订单No：2017032652501001', '4.5', '1013.00', '0', '1490499644');
INSERT INTO `tc_user_account_log` VALUES ('60', '20000026', '卖家同意售后，退给买家，订单No：2017032654559752', '4.5', '1017.50', '0', '1490499658');
INSERT INTO `tc_user_account_log` VALUES ('61', '20000026', '提交订单，使用余额，扣除余额，订单No：2017032699525210', '5', '1012.50', '1', '1490500108');
INSERT INTO `tc_user_account_log` VALUES ('62', '20000026', '提交订单，使用余额，扣除余额，订单No：2017032610154579', '40', '972.50', '1', '1490500126');
INSERT INTO `tc_user_account_log` VALUES ('63', '20000026', '卖家同意售后，退给买家，订单No：2017032610154579', '50', '1022.50', '0', '1490500261');
INSERT INTO `tc_user_account_log` VALUES ('64', '20000313', '定时任务，10天之前的订单打款给卖家，订单No：2017032699525210', '5', '120.14', '0', '1490500261');
INSERT INTO `tc_user_account_log` VALUES ('65', '20000313', '提交订单，使用余额，扣除余额，订单No：2017032750101101', '28', '92.14', '1', '1490577234');
INSERT INTO `tc_user_account_log` VALUES ('66', '20000313', '提交订单，使用余额，扣除余额，订单No：2017032757539752', '18', '74.14', '1', '1490577273');
INSERT INTO `tc_user_account_log` VALUES ('67', '20000315', '定时任务，10天之前的订单打款给卖家，订单No：2017032750101101', '28', '815.00', '0', '1490577361');
INSERT INTO `tc_user_account_log` VALUES ('68', '20000315', '定时任务，10天之前的订单打款给卖家，订单No：2017032757539752', '18', '833.00', '0', '1490577421');
INSERT INTO `tc_user_account_log` VALUES ('69', '20000315', '提交订单，使用余额，扣除余额，订单No：2017032751505452', '23', '810.00', '1', '1490578067');
INSERT INTO `tc_user_account_log` VALUES ('70', '20000313', '定时任务，10天之前的订单打款给卖家，订单No：2017032751505452', '23', '97.14', '0', '1490578201');
INSERT INTO `tc_user_account_log` VALUES ('71', '20000315', '提交订单，使用余额，扣除余额，订单No：2017032710051559', '20', '790.00', '1', '1490578381');
INSERT INTO `tc_user_account_log` VALUES ('72', '20000313', '定时任务，10天之前的订单打款给卖家，订单No：2017032710051559', '20', '117.14', '0', '1490578501');
INSERT INTO `tc_user_account_log` VALUES ('73', '20000315', '提交订单，使用余额，扣除余额，订单No：2017032753535649', '28', '762.00', '1', '1490578549');
INSERT INTO `tc_user_account_log` VALUES ('74', '20000315', '提交订单，使用余额，扣除余额，订单No：2017032749495410', '28', '734.00', '1', '1490578593');
INSERT INTO `tc_user_account_log` VALUES ('75', '20000313', '定时任务，10天之前的订单打款给卖家，订单No：2017032753535649', '28', '145.14', '0', '1490578681');
INSERT INTO `tc_user_account_log` VALUES ('76', '20000313', '定时任务，10天之前的订单打款给卖家，订单No：2017032749495410', '28', '173.14', '0', '1490578741');
INSERT INTO `tc_user_account_log` VALUES ('77', '20000315', '提交订单，使用余额，扣除余额，订单No：2017032750491029', '90', '644.00', '1', '1490579698');
INSERT INTO `tc_user_account_log` VALUES ('78', '20000315', '提交订单，使用余额，扣除余额，订单No：2017032751561021', '40', '604.00', '1', '1490579715');
INSERT INTO `tc_user_account_log` VALUES ('79', '20000315', '提交订单，使用余额，扣除余额，订单No：2017032799102505', '0', '604.00', '1', '1490579724');
INSERT INTO `tc_user_account_log` VALUES ('80', '20000315', '定时任务取消订单，订单退款，订单No：2017032750491029', '90', '694.00', '0', '1490579761');
INSERT INTO `tc_user_account_log` VALUES ('81', '20000315', '定时任务取消订单，订单退款，订单No：2017032751561021', '40', '734.00', '0', '1490579821');
INSERT INTO `tc_user_account_log` VALUES ('82', '20000313', '提交订单，使用余额，扣除余额，订单No：2017032798525655', '3', '170.14', '1', '1490579915');
INSERT INTO `tc_user_account_log` VALUES ('83', '20000313', '提交订单，使用余额，扣除余额，订单No：2017032749529953', '8', '162.14', '1', '1490579921');
INSERT INTO `tc_user_account_log` VALUES ('84', '20000313', '提交订单，使用余额，扣除余额，订单No：2017032797971025', '8', '154.14', '1', '1490579930');
INSERT INTO `tc_user_account_log` VALUES ('85', '20000313', '定时任务，10天之前的订单打款给卖家，订单No：2017032799102505', '-3.5', '150.64', '0', '1490579941');
INSERT INTO `tc_user_account_log` VALUES ('86', '20000313', '提交订单，使用余额，扣除余额，订单No：2017032751485456', '0', '150.64', '1', '1490579955');
INSERT INTO `tc_user_account_log` VALUES ('87', '20000315', '提交订单，使用余额，扣除余额，订单No：2017032750100981', '30', '704.00', '1', '1490579986');
INSERT INTO `tc_user_account_log` VALUES ('88', '20000315', '定时任务，10天之前的订单打款给卖家，订单No：2017032798525655', '3', '707.00', '0', '1490580241');
INSERT INTO `tc_user_account_log` VALUES ('89', '20000315', '定时任务，10天之前的订单打款给卖家，订单No：2017032749529953', '8', '715.00', '0', '1490580241');
INSERT INTO `tc_user_account_log` VALUES ('90', '20000315', '定时任务，10天之前的订单打款给卖家，订单No：2017032797971025', '8', '723.00', '0', '1490580241');
INSERT INTO `tc_user_account_log` VALUES ('91', '20000315', '定时任务，10天之前的订单打款给卖家，订单No：2017032751485456', '-246', '477.00', '0', '1490580241');
INSERT INTO `tc_user_account_log` VALUES ('92', '20000313', '定时任务，10天之前的订单打款给卖家，订单No：2017032750100981', '30', '180.64', '0', '1490580241');
INSERT INTO `tc_user_account_log` VALUES ('93', '20000315', '提交订单，使用余额，扣除余额，订单No：2017032797549748', '25', '452.00', '1', '1490581146');
INSERT INTO `tc_user_account_log` VALUES ('94', '20000313', '提交订单，使用余额，扣除余额，订单No：2017032710157575', '35', '145.64', '1', '1490581246');
INSERT INTO `tc_user_account_log` VALUES ('95', '20000313', '定时任务，10天之前的订单打款给卖家，订单No：2017032797549748', '25', '170.64', '0', '1490581321');
INSERT INTO `tc_user_account_log` VALUES ('96', '20000315', '定时任务，10天之前的订单打款给卖家，订单No：2017032710157575', '35', '487.00', '0', '1490581381');
INSERT INTO `tc_user_account_log` VALUES ('97', '20000315', '提交订单，使用余额，扣除余额，订单No：2017032754545452', '18', '469.00', '1', '1490581590');
INSERT INTO `tc_user_account_log` VALUES ('98', '20000313', '定时任务，10天之前的订单打款给卖家，订单No：2017032754545452', '18', '188.64', '0', '1490581741');
INSERT INTO `tc_user_account_log` VALUES ('99', '20000313', '提交订单，使用余额，扣除余额，订单No：2017032753524857', '28', '160.64', '1', '1490581909');
INSERT INTO `tc_user_account_log` VALUES ('100', '20000315', '定时任务，10天之前的订单打款给卖家，订单No：2017032753524857', '28', '497.00', '0', '1490582041');
INSERT INTO `tc_user_account_log` VALUES ('101', '20000315', '后台充值100元', '100', '597.00', '0', '1490583551');
INSERT INTO `tc_user_account_log` VALUES ('102', '20000315', '后台充值100元', '100', '697.00', '0', '1490583562');
INSERT INTO `tc_user_account_log` VALUES ('103', '20000315', '后台充值100元', '100', '797.00', '0', '1490583564');
INSERT INTO `tc_user_account_log` VALUES ('104', '20000313', '提交订单，使用余额，扣除余额，订单No：2017032799995399', '52', '108.64', '1', '1490583660');
INSERT INTO `tc_user_account_log` VALUES ('105', '20000315', '定时任务，10天之前的订单打款给卖家，订单No：2017032799995399', '52', '215.42', '0', '1490583841');
INSERT INTO `tc_user_account_log` VALUES ('106', '20000315', '卖家同意售后，直接扣除余额，订单No：2017032799995399', '20', '195.42', '1', '1490584060');
INSERT INTO `tc_user_account_log` VALUES ('107', '20000313', '卖家同意售后，退给买家，订单No：2017032799995399', '20', '128.64', '0', '1490584060');
INSERT INTO `tc_user_account_log` VALUES ('108', '20000315', '卖家同意售后，直接扣除余额，订单No：2017032799995399', '30', '165.42', '1', '1490584060');
INSERT INTO `tc_user_account_log` VALUES ('109', '20000313', '卖家同意售后，退给买家，订单No：2017032799995399', '30', '158.64', '0', '1490584060');
INSERT INTO `tc_user_account_log` VALUES ('110', '20000313', '提交订单，使用余额，扣除余额，订单No：2017032749484899', '132', '26.64', '1', '1490584112');
INSERT INTO `tc_user_account_log` VALUES ('111', '20000313', '卖家同意售后，退给买家，订单No：2017032749484899', '90', '116.64', '0', '1490584238');
INSERT INTO `tc_user_account_log` VALUES ('112', '20000313', '卖家同意售后，退给买家，订单No：2017032749484899', '40', '156.64', '0', '1490584238');
INSERT INTO `tc_user_account_log` VALUES ('113', '20000313', '卖家同意售后，退给买家，订单No：2017032749484899', '90', '246.64', '0', '1490584251');
INSERT INTO `tc_user_account_log` VALUES ('114', '20000313', '卖家同意售后，退给买家，订单No：2017032749484899', '40', '286.64', '0', '1490584251');
INSERT INTO `tc_user_account_log` VALUES ('115', '20000313', '提交订单，使用余额，扣除余额，订单No：2017032799495548', '102', '184.64', '1', '1490584444');
INSERT INTO `tc_user_account_log` VALUES ('116', '20000313', '卖家同意售后，退给买家，订单No：2017032799495548', '60', '244.64', '0', '1490584527');
INSERT INTO `tc_user_account_log` VALUES ('117', '20000313', '卖家同意售后，退给买家，订单No：2017032799495548', '40', '284.64', '0', '1490584527');
INSERT INTO `tc_user_account_log` VALUES ('118', '20000313', '提交订单，使用余额，扣除余额，订单No：2017032799519999', '52', '232.64', '1', '1490584652');
INSERT INTO `tc_user_account_log` VALUES ('119', '20000315', '定时任务，10天之前的订单打款给卖家，订单No：2017032799519999', '52', '217.42', '0', '1490584801');
INSERT INTO `tc_user_account_log` VALUES ('120', '20000315', '卖家同意售后，直接扣除余额，订单No：2017032799519999', '20', '197.42', '1', '1490584821');
INSERT INTO `tc_user_account_log` VALUES ('121', '20000313', '卖家同意售后，退给买家，订单No：2017032799519999', '20', '252.64', '0', '1490584821');
INSERT INTO `tc_user_account_log` VALUES ('122', '20000315', '卖家同意售后，直接扣除余额，订单No：2017032799519999', '30', '167.42', '1', '1490584821');
INSERT INTO `tc_user_account_log` VALUES ('123', '20000313', '卖家同意售后，退给买家，订单No：2017032799519999', '30', '282.64', '0', '1490584821');
INSERT INTO `tc_user_account_log` VALUES ('124', '20000313', '提交订单，使用余额，扣除余额，订单No：2017032753101575', '72', '210.64', '1', '1490584949');
INSERT INTO `tc_user_account_log` VALUES ('125', '20000313', '卖家同意售后，退给买家，订单No：2017032753101575', '30', '240.64', '0', '1490585010');
INSERT INTO `tc_user_account_log` VALUES ('126', '20000313', '卖家同意售后，退给买家，订单No：2017032753101575', '40', '280.64', '0', '1490585010');
INSERT INTO `tc_user_account_log` VALUES ('127', '20000313', '提交订单，使用余额，扣除余额，订单No：2017032797549710', '52', '228.64', '1', '1490585066');
INSERT INTO `tc_user_account_log` VALUES ('128', '20000313', '卖家同意售后，退给买家，订单No：2017032797549710', '30', '258.64', '0', '1490585120');
INSERT INTO `tc_user_account_log` VALUES ('129', '20000313', '卖家同意售后，退给买家，订单No：2017032797549710', '20', '278.64', '0', '1490585120');
INSERT INTO `tc_user_account_log` VALUES ('130', '20000315', '提交订单，使用余额，扣除余额，订单No：2017032748985152', '18', '149.42', '1', '1490599696');
INSERT INTO `tc_user_account_log` VALUES ('131', '20000315', '提交订单，使用余额，扣除余额，订单No：2017032710154505', '28', '121.42', '1', '1490599726');
INSERT INTO `tc_user_account_log` VALUES ('132', '20000313', '定时任务，10天之前的订单打款给卖家，订单No：2017032748985152', '18', '296.64', '0', '1490599861');
INSERT INTO `tc_user_account_log` VALUES ('133', '20000313', '定时任务，10天之前的订单打款给卖家，订单No：2017032710154505', '28', '324.64', '0', '1490599861');
INSERT INTO `tc_user_account_log` VALUES ('134', '20000315', '提交订单，使用余额，扣除余额，订单No：2017032750569751', '90', '31.42', '1', '1490604642');
INSERT INTO `tc_user_account_log` VALUES ('135', '20000315', '提交订单，使用余额，扣除余额，订单No：2017032797995753', '0', '31.42', '1', '1490604650');
INSERT INTO `tc_user_account_log` VALUES ('136', '20000315', '提交订单，使用余额，扣除余额，订单No：2017032748545254', '0', '31.42', '1', '1490604656');
INSERT INTO `tc_user_account_log` VALUES ('137', '20000315', '提交订单，使用余额，扣除余额，订单No：2017032752991005', '0', '31.42', '1', '1490604660');
INSERT INTO `tc_user_account_log` VALUES ('138', '20000315', '提交订单，使用余额，扣除余额，订单No：2017032757100102', '0', '31.42', '1', '1490604665');
INSERT INTO `tc_user_account_log` VALUES ('139', '20000315', '提交订单，使用余额，扣除余额，订单No：2017032710255549', '0', '31.42', '1', '1490604671');
INSERT INTO `tc_user_account_log` VALUES ('140', '20000315', '提交订单，使用余额，扣除余额，订单No：2017032756525555', '0', '31.42', '1', '1490604696');
INSERT INTO `tc_user_account_log` VALUES ('141', '20000315', '定时任务取消订单，订单退款，订单No：2017032750569751', '90', '121.42', '0', '1490604721');
INSERT INTO `tc_user_account_log` VALUES ('142', '20000315', '定时任务取消订单，订单退款，订单No：2017032797995753', '-3', '118.42', '0', '1490604721');
INSERT INTO `tc_user_account_log` VALUES ('143', '20000315', '定时任务取消订单，订单退款，订单No：2017032748545254', '-3', '115.42', '0', '1490604721');
INSERT INTO `tc_user_account_log` VALUES ('144', '20000315', '定时任务取消订单，订单退款，订单No：2017032752991005', '-5', '110.42', '0', '1490604721');
INSERT INTO `tc_user_account_log` VALUES ('145', '20000315', '提交订单，使用余额，扣除余额，订单No：2017032798519756', '13', '97.42', '1', '1490604747');
INSERT INTO `tc_user_account_log` VALUES ('146', '20000315', '定时任务取消订单，订单退款，订单No：2017032757100102', '-13', '84.42', '0', '1490604781');
INSERT INTO `tc_user_account_log` VALUES ('147', '20000315', '定时任务取消订单，订单退款，订单No：2017032710255549', '-13', '71.42', '0', '1490604781');
INSERT INTO `tc_user_account_log` VALUES ('148', '20000315', '定时任务取消订单，订单退款，订单No：2017032756525555', '-13', '58.42', '0', '1490604781');
INSERT INTO `tc_user_account_log` VALUES ('149', '20000313', '提交订单，使用余额，扣除余额，订单No：2017032751525497', '28', '296.64', '1', '1490604835');
INSERT INTO `tc_user_account_log` VALUES ('150', '20000313', '提交订单，使用余额，扣除余额，订单No：2017032754521015', '3', '293.64', '1', '1490604870');
INSERT INTO `tc_user_account_log` VALUES ('151', '20000313', '定时任务，10天之前的订单打款给卖家，订单No：2017032798519756', '13', '306.64', '0', '1490604901');
INSERT INTO `tc_user_account_log` VALUES ('152', '20000313', '定时任务取消订单，订单退款，订单No：2017032754521015', '3', '309.64', '0', '1490604961');
INSERT INTO `tc_user_account_log` VALUES ('153', '20000315', '定时任务，10天之前的订单打款给卖家，订单No：2017032751525497', '28', '86.42', '0', '1490604961');
INSERT INTO `tc_user_account_log` VALUES ('154', '20000316', '提交订单，使用余额，扣除余额，订单No：2017032757519854', '30', '304.00', '1', '1490605401');
INSERT INTO `tc_user_account_log` VALUES ('155', '20000317', '定时任务，10天之前的订单打款给卖家，订单No：2017032757519854', '30', '30.00', '0', '1490605561');
INSERT INTO `tc_user_account_log` VALUES ('156', '20000316', '提交订单，使用余额，扣除余额，订单No：2017032710010149', '0', '304.00', '1', '1490605565');
INSERT INTO `tc_user_account_log` VALUES ('157', '20000316', '提交订单，使用余额，扣除余额，订单No：2017032751101101', '0', '304.00', '1', '1490605571');
INSERT INTO `tc_user_account_log` VALUES ('158', '20000316', '提交订单，使用余额，扣除余额，订单No：2017032757485253', '30', '274.00', '1', '1490605673');
INSERT INTO `tc_user_account_log` VALUES ('159', '20000316', '定时任务取消订单，订单退款，订单No：2017032710010149', '0', '274.00', '0', '1490605681');
INSERT INTO `tc_user_account_log` VALUES ('160', '20000316', '定时任务取消订单，订单退款，订单No：2017032751101101', '-10', '264.00', '0', '1490605681');
INSERT INTO `tc_user_account_log` VALUES ('161', '20000316', '提交订单，使用余额，扣除余额，订单No：2017032748555557', '0', '264.00', '1', '1490605696');
INSERT INTO `tc_user_account_log` VALUES ('162', '20000316', '提交订单，使用余额，扣除余额，订单No：2017032710297971', '0', '264.00', '1', '1490605711');
INSERT INTO `tc_user_account_log` VALUES ('163', '20000316', '定时任务取消订单，订单退款，订单No：2017032748555557', '0', '264.00', '0', '1490605801');
INSERT INTO `tc_user_account_log` VALUES ('164', '20000316', '定时任务取消订单，订单退款，订单No：2017032710297971', '-10', '254.00', '0', '1490605801');
INSERT INTO `tc_user_account_log` VALUES ('165', '20000317', '定时任务，10天之前的订单打款给卖家，订单No：2017032757485253', '30', '60.00', '0', '1490605801');
INSERT INTO `tc_user_account_log` VALUES ('166', '20000026', '提交订单，使用余额，扣除余额，订单No：2017032750485610', '36', '986.50', '1', '1490605954');
INSERT INTO `tc_user_account_log` VALUES ('167', '20000316', '提交订单，使用余额，扣除余额，订单No：2017032756509855', '30', '224.00', '1', '1490606040');
INSERT INTO `tc_user_account_log` VALUES ('168', '20000313', '定时任务，10天之前的订单打款给卖家，订单No：2017032750485610', '36', '345.64', '0', '1490606101');
INSERT INTO `tc_user_account_log` VALUES ('169', '20000026', '提交订单，使用余额，扣除余额，订单No：2017032751509854', '23', '963.50', '1', '1490606131');
INSERT INTO `tc_user_account_log` VALUES ('170', '20000317', '定时任务，10天之前的订单打款给卖家，订单No：2017032756509855', '30', '90.00', '0', '1490606161');
INSERT INTO `tc_user_account_log` VALUES ('171', '20000313', '定时任务，10天之前的订单打款给卖家，订单No：2017032751509854', '23', '368.64', '0', '1490606281');
INSERT INTO `tc_user_account_log` VALUES ('172', '20000026', '提交订单，使用余额，扣除余额，订单No：2017032757505748', '23', '940.50', '1', '1490606601');
INSERT INTO `tc_user_account_log` VALUES ('173', '20000316', '提交订单，使用余额，扣除余额，订单No：2017032748525199', '0', '224.00', '1', '1490606752');
INSERT INTO `tc_user_account_log` VALUES ('174', '20000313', '定时任务，10天之前的订单打款给卖家，订单No：2017032757505748', '23', '391.64', '0', '1490606761');
INSERT INTO `tc_user_account_log` VALUES ('175', '20000316', '提交订单，使用余额，扣除余额，订单No：2017032798989799', '30', '194.00', '1', '1490606795');
INSERT INTO `tc_user_account_log` VALUES ('176', '20000317', '定时任务，10天之前的订单打款给卖家，订单No：2017032798989799', '30', '120.00', '0', '1490606941');
INSERT INTO `tc_user_account_log` VALUES ('177', '20000316', '提交订单，使用余额，扣除余额，订单No：2017032756989710', '0', '194.00', '1', '1490607064');
INSERT INTO `tc_user_account_log` VALUES ('178', '20000317', '定时任务，10天之前的订单打款给卖家，订单No：2017032756989710', '0', '120.00', '0', '1490607241');
INSERT INTO `tc_user_account_log` VALUES ('179', '20000316', '提交订单，使用余额，扣除余额，订单No：2017032798509850', '70', '124.00', '1', '1490607291');
INSERT INTO `tc_user_account_log` VALUES ('180', '20000317', '定时任务，10天之前的订单打款给卖家，订单No：2017032798509850', '70', '190.00', '0', '1490607481');
INSERT INTO `tc_user_account_log` VALUES ('181', '20000317', '定时任务，15天未处理退款，自动退款，订单No：2017032798509850', '70', '120.00', '1', '1490607721');
INSERT INTO `tc_user_account_log` VALUES ('182', '20000316', '定时任务，15天未处理退款，自动退款给买家，订单No：2017032798509850', '70', '194.00', '0', '1490607721');
INSERT INTO `tc_user_account_log` VALUES ('183', '20000316', '提交订单，使用余额，扣除余额，订单No：2017032751995010', '20', '174.00', '1', '1490607891');
INSERT INTO `tc_user_account_log` VALUES ('184', '20000316', '定时任务取消订单，订单退款，订单No：2017032751995010', '20', '194.00', '0', '1490607961');
INSERT INTO `tc_user_account_log` VALUES ('185', '20000026', '提交订单，使用余额，扣除余额，订单No：2017032753995199', '100', '840.50', '1', '1490608437');
INSERT INTO `tc_user_account_log` VALUES ('186', '20000026', '定时任务，15天未处理退款，自动退款给买家，订单No：2017032753995199', '100', '940.50', '0', '1490608681');
INSERT INTO `tc_user_account_log` VALUES ('187', '20000313', '定时任务，10天之前的订单打款给卖家，订单No：2017032752101101', '7', '398.64', '0', '1490608741');
INSERT INTO `tc_user_account_log` VALUES ('188', '20000026', '定时任务，15天未处理退款，自动退款给买家，订单No：2017032753995199', '0', '940.50', '0', '1490608741');

-- ----------------------------
-- Table structure for `tc_user_black`
-- ----------------------------
DROP TABLE IF EXISTS `tc_user_black`;
CREATE TABLE `tc_user_black` (
  `uid` int(11) unsigned DEFAULT '0' COMMENT '用户',
  `fuid` int(11) unsigned DEFAULT '0' COMMENT '用户',
  `addtime` int(11) NOT NULL DEFAULT '0',
  UNIQUE KEY `uid` (`uid`,`fuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tc_user_black
-- ----------------------------
INSERT INTO `tc_user_black` VALUES ('20000010', '20000002', '1460434319');
INSERT INTO `tc_user_black` VALUES ('20000217', '20000044', '1480760093');
INSERT INTO `tc_user_black` VALUES ('20000000', '20000002', '1490421113');
INSERT INTO `tc_user_black` VALUES ('20000315', '20000316', '1490586377');

-- ----------------------------
-- Table structure for `tc_user_coupon`
-- ----------------------------
DROP TABLE IF EXISTS `tc_user_coupon`;
CREATE TABLE `tc_user_coupon` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `sid` int(11) NOT NULL,
  `order_no` varchar(50) NOT NULL DEFAULT '',
  `goods_id` int(11) NOT NULL COMMENT '优惠券id',
  `is_use` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0.未使用，1.已使用',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0不可用，1可用',
  `create_time` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tc_user_coupon
-- ----------------------------
INSERT INTO `tc_user_coupon` VALUES ('1', '20000315', '3', '2017032497999898', '14', '1', '1', '1490324746');
INSERT INTO `tc_user_coupon` VALUES ('2', '20000315', '3', '2017032497999898', '13', '0', '0', '1490324746');
INSERT INTO `tc_user_coupon` VALUES ('3', '20000315', '3', '2017032448525254', '13', '0', '1', '1490324848');
INSERT INTO `tc_user_coupon` VALUES ('4', '20000315', '3', '2017032456519850', '14', '1', '1', '1490324856');
INSERT INTO `tc_user_coupon` VALUES ('5', '20000315', '3', '2017032457100985', '13', '0', '1', '1490325193');
INSERT INTO `tc_user_coupon` VALUES ('6', '20000315', '3', '2017032457100985', '14', '0', '0', '1490325193');
INSERT INTO `tc_user_coupon` VALUES ('7', '20000313', '1', '2017032499555354', '15', '1', '1', '1490325532');
INSERT INTO `tc_user_coupon` VALUES ('8', '20000313', '1', '2017032499555354', '16', '1', '0', '1490325532');
INSERT INTO `tc_user_coupon` VALUES ('9', '20000314', '1', '2017032450489750', '15', '0', '1', '1490325858');
INSERT INTO `tc_user_coupon` VALUES ('10', '20000314', '1', '2017032450489750', '16', '0', '0', '1490325858');
INSERT INTO `tc_user_coupon` VALUES ('11', '20000314', '1', '2017032452495755', '15', '0', '1', '1490325876');
INSERT INTO `tc_user_coupon` VALUES ('12', '20000316', '3', '2017032410097999', '14', '0', '1', '1490327053');
INSERT INTO `tc_user_coupon` VALUES ('13', '20000316', '3', '2017032410197515', '14', '0', '1', '1490327150');
INSERT INTO `tc_user_coupon` VALUES ('14', '20000315', '3', '2017032452100535', '17', '1', '1', '1490332692');
INSERT INTO `tc_user_coupon` VALUES ('15', '20000315', '3', '2017032452100535', '18', '0', '0', '1490332692');
INSERT INTO `tc_user_coupon` VALUES ('16', '20000313', '1', '2017032456974897', '6', '1', '1', '1490334776');
INSERT INTO `tc_user_coupon` VALUES ('17', '20000313', '1', '2017032450481015', '16', '0', '0', '1490335250');
INSERT INTO `tc_user_coupon` VALUES ('18', '20000316', '3', '2017032497561001', '17', '0', '1', '1490335450');
INSERT INTO `tc_user_coupon` VALUES ('19', '20000026', '1', '2017032654509956', '16', '0', '1', '1490494678');
INSERT INTO `tc_user_coupon` VALUES ('20', '20000026', '1', '2017032648495550', '16', '0', '1', '1490496032');
INSERT INTO `tc_user_coupon` VALUES ('21', '20000026', '3', '2017032699525210', '20', '1', '1', '1490500108');
INSERT INTO `tc_user_coupon` VALUES ('22', '20000313', '1', '2017032750101101', '22', '1', '1', '1490577234');
INSERT INTO `tc_user_coupon` VALUES ('23', '20000313', '1', '2017032750101101', '21', '1', '0', '1490577234');
INSERT INTO `tc_user_coupon` VALUES ('24', '20000313', '1', '2017032757539752', '21', '1', '1', '1490577273');
INSERT INTO `tc_user_coupon` VALUES ('25', '20000315', '3', '2017032751505452', '25', '1', '1', '1490578067');
INSERT INTO `tc_user_coupon` VALUES ('26', '20000315', '3', '2017032751505452', '26', '1', '0', '1490578067');
INSERT INTO `tc_user_coupon` VALUES ('27', '20000315', '3', '2017032751505452', '20', '1', '0', '1490578067');
INSERT INTO `tc_user_coupon` VALUES ('28', '20000315', '3', '2017032710051559', '26', '1', '1', '1490578381');
INSERT INTO `tc_user_coupon` VALUES ('29', '20000315', '3', '2017032710051559', '27', '0', '0', '1490578381');
INSERT INTO `tc_user_coupon` VALUES ('30', '20000315', '3', '2017032753535649', '25', '1', '1', '1490578549');
INSERT INTO `tc_user_coupon` VALUES ('31', '20000315', '3', '2017032753535649', '26', '1', '0', '1490578549');
INSERT INTO `tc_user_coupon` VALUES ('32', '20000315', '3', '2017032753535649', '27', '0', '0', '1490578549');
INSERT INTO `tc_user_coupon` VALUES ('33', '20000315', '3', '2017032749495410', '25', '1', '1', '1490578593');
INSERT INTO `tc_user_coupon` VALUES ('34', '20000315', '3', '2017032749495410', '26', '0', '0', '1490578593');
INSERT INTO `tc_user_coupon` VALUES ('35', '20000315', '3', '2017032749495410', '27', '0', '0', '1490578593');
INSERT INTO `tc_user_coupon` VALUES ('36', '20000315', '3', '2017032797549748', '28', '0', '1', '1490581146');
INSERT INTO `tc_user_coupon` VALUES ('37', '20000313', '1', '2017032710157575', '29', '0', '1', '1490581246');
INSERT INTO `tc_user_coupon` VALUES ('38', '20000315', '3', '2017032754545452', '25', '1', '1', '1490581590');
INSERT INTO `tc_user_coupon` VALUES ('39', '20000315', '3', '2017032754545452', '26', '1', '0', '1490581590');
INSERT INTO `tc_user_coupon` VALUES ('40', '20000313', '1', '2017032753524857', '22', '1', '1', '1490581909');
INSERT INTO `tc_user_coupon` VALUES ('41', '20000313', '1', '2017032753524857', '21', '0', '0', '1490581909');
INSERT INTO `tc_user_coupon` VALUES ('42', '20000315', '3', '2017032748985152', '25', '1', '1', '1490599696');
INSERT INTO `tc_user_coupon` VALUES ('43', '20000315', '3', '2017032748985152', '26', '0', '0', '1490599696');
INSERT INTO `tc_user_coupon` VALUES ('44', '20000315', '3', '2017032710154505', '27', '0', '1', '1490599726');
INSERT INTO `tc_user_coupon` VALUES ('45', '20000315', '3', '2017032710154505', '24', '1', '0', '1490599726');
INSERT INTO `tc_user_coupon` VALUES ('46', '20000315', '3', '2017032798519756', '20', '0', '1', '1490604747');
INSERT INTO `tc_user_coupon` VALUES ('47', '20000315', '3', '2017032798519756', '25', '0', '0', '1490604747');
INSERT INTO `tc_user_coupon` VALUES ('48', '20000313', '1', '2017032751525497', '21', '0', '1', '1490604835');
INSERT INTO `tc_user_coupon` VALUES ('49', '20000313', '1', '2017032751525497', '22', '0', '0', '1490604835');
INSERT INTO `tc_user_coupon` VALUES ('50', '20000316', '4', '2017032757519854', '33', '1', '1', '1490605401');
INSERT INTO `tc_user_coupon` VALUES ('51', '20000316', '4', '2017032757519854', '34', '1', '0', '1490605401');
INSERT INTO `tc_user_coupon` VALUES ('52', '20000316', '4', '2017032757485253', '34', '1', '1', '1490605673');
INSERT INTO `tc_user_coupon` VALUES ('53', '20000316', '4', '2017032757485253', '33', '1', '0', '1490605673');
INSERT INTO `tc_user_coupon` VALUES ('54', '20000026', '3', '2017032750485610', '24', '0', '1', '1490605954');
INSERT INTO `tc_user_coupon` VALUES ('55', '20000026', '3', '2017032750485610', '24', '0', '1', '1490605954');
INSERT INTO `tc_user_coupon` VALUES ('56', '20000316', '4', '2017032756509855', '33', '1', '1', '1490606040');
INSERT INTO `tc_user_coupon` VALUES ('57', '20000316', '4', '2017032756509855', '34', '1', '0', '1490606040');
INSERT INTO `tc_user_coupon` VALUES ('58', '20000026', '3', '2017032751509854', '20', '0', '1', '1490606131');
INSERT INTO `tc_user_coupon` VALUES ('59', '20000026', '3', '2017032751509854', '24', '0', '1', '1490606131');
INSERT INTO `tc_user_coupon` VALUES ('60', '20000026', '3', '2017032757505748', '20', '0', '1', '1490606601');
INSERT INTO `tc_user_coupon` VALUES ('61', '20000026', '3', '2017032757505748', '24', '0', '1', '1490606601');
INSERT INTO `tc_user_coupon` VALUES ('62', '20000316', '4', '2017032798989799', '33', '1', '1', '1490606795');
INSERT INTO `tc_user_coupon` VALUES ('63', '20000316', '4', '2017032798989799', '34', '0', '1', '1490606795');

-- ----------------------------
-- Table structure for `tc_user_follow`
-- ----------------------------
DROP TABLE IF EXISTS `tc_user_follow`;
CREATE TABLE `tc_user_follow` (
  `uid` int(11) unsigned DEFAULT '0' COMMENT '用户',
  `fuid` int(11) unsigned DEFAULT '0' COMMENT '用户',
  `addtime` int(11) NOT NULL DEFAULT '0',
  UNIQUE KEY `uid` (`uid`,`fuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tc_user_follow
-- ----------------------------
INSERT INTO `tc_user_follow` VALUES ('20000002', '20000001', '1458377374');
INSERT INTO `tc_user_follow` VALUES ('20000002', '20000000', '1458377380');
INSERT INTO `tc_user_follow` VALUES ('20000002', '20000003', '1458537202');
INSERT INTO `tc_user_follow` VALUES ('20000002', '20000004', '1458537208');
INSERT INTO `tc_user_follow` VALUES ('20000002', '20000006', '1458617058');
INSERT INTO `tc_user_follow` VALUES ('20000002', '20000005', '1458617097');
INSERT INTO `tc_user_follow` VALUES ('20000019', '20000002', '1459490882');
INSERT INTO `tc_user_follow` VALUES ('20000000', '20000010', '1460609180');
INSERT INTO `tc_user_follow` VALUES ('20000000', '20000017', '1461753763');
INSERT INTO `tc_user_follow` VALUES ('20000000', '20000001', '1461839568');
INSERT INTO `tc_user_follow` VALUES ('20000017', '20000000', '1461841652');
INSERT INTO `tc_user_follow` VALUES ('20000025', '20000002', '1462027568');
INSERT INTO `tc_user_follow` VALUES ('20000002', '20000017', '1462807199');
INSERT INTO `tc_user_follow` VALUES ('20000025', '20000000', '1463796509');
INSERT INTO `tc_user_follow` VALUES ('20000025', '20000017', '1463796531');
INSERT INTO `tc_user_follow` VALUES ('20000025', '20000024', '1463796546');
INSERT INTO `tc_user_follow` VALUES ('20000041', '20000002', '1465771471');
INSERT INTO `tc_user_follow` VALUES ('20000090', '20000090', '1470887687');
INSERT INTO `tc_user_follow` VALUES ('20000089', '20000090', '1470897614');
INSERT INTO `tc_user_follow` VALUES ('20000090', '20000089', '1470898921');
INSERT INTO `tc_user_follow` VALUES ('20000092', '20000091', '1471007321');
INSERT INTO `tc_user_follow` VALUES ('20000017', '20000002', '1473667260');
INSERT INTO `tc_user_follow` VALUES ('20000096', '20000002', '1476237722');
INSERT INTO `tc_user_follow` VALUES ('20000096', '20000115', '1476541434');
INSERT INTO `tc_user_follow` VALUES ('20000198', '20000000', '1478444832');
INSERT INTO `tc_user_follow` VALUES ('20000198', '20000017', '1478444842');
INSERT INTO `tc_user_follow` VALUES ('20000198', '20000002', '1478444852');
INSERT INTO `tc_user_follow` VALUES ('20000210', '20000179', '1479520793');
INSERT INTO `tc_user_follow` VALUES ('20000229', '20000025', '1481569074');
INSERT INTO `tc_user_follow` VALUES ('20000229', '20000002', '1481569094');
INSERT INTO `tc_user_follow` VALUES ('20000229', '20000000', '1481569111');
INSERT INTO `tc_user_follow` VALUES ('20000229', '20000001', '1481569411');
INSERT INTO `tc_user_follow` VALUES ('20000316', '20000314', '1490327890');
INSERT INTO `tc_user_follow` VALUES ('20000315', '20000316', '1490586320');
INSERT INTO `tc_user_follow` VALUES ('20000315', '20000313', '1490596692');

-- ----------------------------
-- Table structure for `tc_user_head`
-- ----------------------------
DROP TABLE IF EXISTS `tc_user_head`;
CREATE TABLE `tc_user_head` (
  `id` varchar(50) NOT NULL,
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT '用户',
  `originUrl` varchar(128) NOT NULL DEFAULT '' COMMENT '用户名称',
  `smallUrl` varchar(128) NOT NULL DEFAULT '' COMMENT '用户头像',
  `key` varchar(100) NOT NULL DEFAULT '' COMMENT 'key',
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户表对像表';

-- ----------------------------
-- Records of tc_user_head
-- ----------------------------
INSERT INTO `tc_user_head` VALUES ('006ecbcf674be316a87543a70afcf48b', '20000264', '/Uploads/Picture/20170209/74ea6c35477457de.png', '/Uploads/Picture/20170209/s_74ea6c35477457de.png', 'images');
INSERT INTO `tc_user_head` VALUES ('0074f815354f504838c745eba11e17e3', '20000117', '/Uploads/Picture/20160919/6510124e742cd29d.jpg', '/Uploads/Picture/20160919/s_6510124e742cd29d.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('02d19e01ef6bd4d7f8ff1ac5faef881e', '20000307', '/Uploads/Picture/20170318/1236482be7cab5ad.jpg', '/Uploads/Picture/20170318/s_1236482be7cab5ad.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('0364d3e4b4664d2fbb432d4e400b7a79', '20000215', '/Uploads/Picture/20161124/c2e824ffd6ce1295.jpg', '/Uploads/Picture/20161124/s_c2e824ffd6ce1295.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('039355624d4f9a5e760c32bf7c491fa7', '20000007', '/Uploads/Picture/20160322/5b9f5cc8905315a3.jpg', '/Uploads/Picture/20160322/s_5b9f5cc8905315a3.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('03a944f9bb9cb2307a288da307c980b0', '20000033', '/Uploads/Picture/20160608/72c8c66b8c794154.jpg', '/Uploads/Picture/20160608/s_72c8c66b8c794154.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('04a732d00bc3d9748077ee913aa4bf65', '20000309', '/Uploads/Picture/20170320/66ed8dadd6901f0b.png', '/Uploads/Picture/20170320/s_66ed8dadd6901f0b.png', 'images');
INSERT INTO `tc_user_head` VALUES ('04cd261e876d1c910fc7a9387492d807', '20000239', '/Uploads/Picture/20161228/d65df6daf6a0da03.png', '/Uploads/Picture/20161228/s_d65df6daf6a0da03.png', 'head');
INSERT INTO `tc_user_head` VALUES ('04fd639081216e5e9dc9e0841a817c7c', '20000005', '/Uploads/Picture/20160321/5c869f411e0f0db4.jpg', '/Uploads/Picture/20160321/s_5c869f411e0f0db4.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('053aeb5db19bfb64b0fe09b6f50c7a86', '20000111', '/Uploads/Picture/20160906/81191eddd3827d08.jpg', '/Uploads/Picture/20160906/s_81191eddd3827d08.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('05cbfbdd323e7d4dd0eb8b75540b4f18', '20000097', '/Uploads/Picture/20160819/f20412337a28f805.png', '/Uploads/Picture/20160819/s_f20412337a28f805.png', 'images');
INSERT INTO `tc_user_head` VALUES ('05d4484bd1ff9d65e7489f15c05f5a77', '20000199', '/Uploads/Picture/20161109/235b65c04e4a70a1.jpg', '/Uploads/Picture/20161109/s_235b65c04e4a70a1.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('06289aef53276db6edd05138d4c7bea8', '20000158', '/Uploads/Picture/20161009/cae4a9b806258831.jpg', '/Uploads/Picture/20161009/s_cae4a9b806258831.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('0630c38bada0876b9e7e5c736df5a02e', '20000219', '/Uploads/Picture/20161204/fd26c997a07aa2cf.png', '/Uploads/Picture/20161204/s_fd26c997a07aa2cf.png', 'images');
INSERT INTO `tc_user_head` VALUES ('069ace9ada2a431dc1161c15f3c839c0', '20000092', '/Uploads/Picture/20160812/6bdd5c97ab326566.jpeg', '/Uploads/Picture/20160812/s_6bdd5c97ab326566.jpeg', 'head');
INSERT INTO `tc_user_head` VALUES ('06bbfd030e311d0ee80a867cebdfbe82', '20000177', '/Uploads/Picture/20161020/fc6bdd755836a7cf.jpg', '/Uploads/Picture/20161020/s_fc6bdd755836a7cf.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('07436261626b47228d470b9f7f7fdaf3', '20000009', '/Uploads/Picture/20160323/71898872ad51af4e.jpg', '/Uploads/Picture/20160323/s_71898872ad51af4e.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('07ca283aea309279d60bf24e214acce4', '20000095', '/Uploads/Picture/20160816/a4a146dd4cdafaed.jpg', '/Uploads/Picture/20160816/s_a4a146dd4cdafaed.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('08134dc3b6e7757c55be06c0f37a1db6', '20000278', '/Uploads/Picture/20170224/378228710d59c8b8.jpg', '/Uploads/Picture/20170224/s_378228710d59c8b8.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('0867b982094384a3fc74f8679cf5e1de', '20000000', '/Uploads/Picture/20160518/f5747f994eaacdd9.png', '/Uploads/Picture/20160518/s_f5747f994eaacdd9.png', 'image');
INSERT INTO `tc_user_head` VALUES ('09d9ce34546c7b51b9470fed55910c9d', '20000053', '/Uploads/Picture/20160619/938fbe420d285404.jpg', '/Uploads/Picture/20160619/s_938fbe420d285404.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('09ddf948c97c84441f2e22cd6c8b2385', '20000265', '/Uploads/Picture/20170209/37858710c09b0027.jpg', '/Uploads/Picture/20170209/s_37858710c09b0027.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('0a89809bf899f92bea0660bf83d4c3aa', '20000084', '/Uploads/Picture/20160805/281331db505f7874.jpg', '/Uploads/Picture/20160805/s_281331db505f7874.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('0af16fe234441ef9554da3d21689c722', '20000038', '/Uploads/Picture/20160611/53aa2673d5d7251c.jpg', '/Uploads/Picture/20160611/s_53aa2673d5d7251c.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('0afa9c3a60f5a0b97ed6ab80e870e787', '20000024', '/Uploads/Picture/20160428/e39aa9163cbe9bb0.png', '/Uploads/Picture/20160428/s_e39aa9163cbe9bb0.png', 'images');
INSERT INTO `tc_user_head` VALUES ('0b0e129ecf40d0b466899ebffcff1f03', '20000143', '/Uploads/Picture/20161004/c67a1ec3b45fd088.jpg', '/Uploads/Picture/20161004/s_c67a1ec3b45fd088.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('0b489d98dd0a17e6ff9d98bd40605c1e', '20000172', '/Uploads/Picture/20161018/f87aa3e7a5bdefa7.png', '/Uploads/Picture/20161018/s_f87aa3e7a5bdefa7.png', 'head');
INSERT INTO `tc_user_head` VALUES ('0d2c8245d3e41b5500c5fc4ba8dd9e49', '20000243', '/Uploads/Picture/20170102/ce8bc3aa84c73044.jpg', '/Uploads/Picture/20170102/s_ce8bc3aa84c73044.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('0f7abca38adedcfdfb142608c249ce3b', '20000173', '/Uploads/Picture/20161018/c5a4d67f4b1eaaa7.jpg', '/Uploads/Picture/20161018/s_c5a4d67f4b1eaaa7.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('1004f1cd1dfe66b7a100960d2f5d3907', '20000064', '/Uploads/Picture/20160704/f41da464d29cba64.jpg', '/Uploads/Picture/20160704/s_f41da464d29cba64.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('10720183c926e96b9ae2363bcd4a11ea', '20000137', '/Uploads/Picture/20161002/fd4661f135d4754f.jpg', '/Uploads/Picture/20161002/s_fd4661f135d4754f.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('1082042d40c71736bbbcf7d645fdedba', '20000234', '/Uploads/Picture/20161220/8c781cc2c8be283e.jpg', '/Uploads/Picture/20161220/s_8c781cc2c8be283e.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('10bf10d2e590ff9da9284193e630d2a9', '20000145', '/Uploads/Picture/20161005/fdfa1a83e1537a29.jpg', '/Uploads/Picture/20161005/s_fdfa1a83e1537a29.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('1116f588f9bf55e5d32e7b0b50617a0b', '20000233', '/Uploads/Picture/20161220/306200b61403743e.jpg', '/Uploads/Picture/20161220/s_306200b61403743e.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('11c179f31e53bd95a3aea56ebc3eadba', '20000186', '/Uploads/Picture/20161023/cb1c44c1c123c64e.jpeg', '/Uploads/Picture/20161023/s_cb1c44c1c123c64e.jpeg', 'head');
INSERT INTO `tc_user_head` VALUES ('127f14a84e4a3c6f7b894094b929103a', '20000070', '/Uploads/Picture/20160709/326f623c25e29d15.jpg', '/Uploads/Picture/20160709/s_326f623c25e29d15.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('13b247ef81da843cd1150dc4f4912126', '20000134', '/Uploads/Picture/20160930/259d7eb61ebb0810.jpg', '/Uploads/Picture/20160930/s_259d7eb61ebb0810.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('13b51e24f1546e3de55f4c03beb6ee34', '20000207', '/Uploads/Picture/20161116/8d65ff68e693d6ec.jpg', '/Uploads/Picture/20161116/s_8d65ff68e693d6ec.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('13e6156c74b5b46d5ce6f9772eb9e32f', '20000065', '/Uploads/Picture/20160706/43ff6774a05138b9.jpg', '/Uploads/Picture/20160706/s_43ff6774a05138b9.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('146ec9cdcd5a0f00ea916ef800c0bfc6', '20000169', '/Uploads/Picture/20161016/f50ebe7177cd8089.jpg', '/Uploads/Picture/20161016/s_f50ebe7177cd8089.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('14caae6bd320c10a7b6f85d134b81542', '20000152', '/Uploads/Picture/20161006/d64ede31e3db049e.png', '/Uploads/Picture/20161006/s_d64ede31e3db049e.png', 'head');
INSERT INTO `tc_user_head` VALUES ('14e3165f3cbb428c51d74e6349a30928', '20000282', '/Uploads/Picture/20170225/98404e574c460556.jpg', '/Uploads/Picture/20170225/s_98404e574c460556.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('1508cc3ebd2817b7f5e57f39631e7b01', '20000167', '/Uploads/Picture/20161015/8e41f12a62a0d8ea.jpg', '/Uploads/Picture/20161015/s_8e41f12a62a0d8ea.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('1579bc65e26b87986572f6dd8d7d66d6', '20000002', '/Uploads/Picture/20160502/8e0e71199b07cb4e.jpg', '/Uploads/Picture/20160502/s_8e0e71199b07cb4e.jpg', 'image1');
INSERT INTO `tc_user_head` VALUES ('157c1cc9224dad173914bf1b5290b92b', '20000242', '/Uploads/Picture/20170102/cae5f216d8a5728c.jpg', '/Uploads/Picture/20170102/s_cae5f216d8a5728c.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('158db328670b39be18925c0881382045', '20000164', '/Uploads/Picture/20161014/7f018e3f84e11472.jpg', '/Uploads/Picture/20161014/s_7f018e3f84e11472.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('16a9b7f9051d781b1581600d5f64edb6', '20000210', '/Uploads/Picture/20161119/1eeb8ff52b5e5200.jpg', '/Uploads/Picture/20161119/s_1eeb8ff52b5e5200.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('1713dbfa1a7256e37fa7eecbbda42bcb', '20000002', '/Uploads/Picture/20160319/81c2f03ae59909bc.jpg', '/Uploads/Picture/20160319/s_81c2f03ae59909bc.jpg', 'image3');
INSERT INTO `tc_user_head` VALUES ('174fbbc3540775caa4008e92cc1fef92', '20000055', '/Uploads/Picture/20160622/d31d32befde53ed0.jpg', '/Uploads/Picture/20160622/s_d31d32befde53ed0.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('17aad6e5a9344dc7411fe1a10c1459c2', '20000155', '/Uploads/Picture/20161007/e6d8bb1c9696fa5a.png', '/Uploads/Picture/20161007/s_e6d8bb1c9696fa5a.png', 'head');
INSERT INTO `tc_user_head` VALUES ('18935c2993842e106be54d1acfc5da69', '20000162', '/Uploads/Picture/20161013/e88bef0a7c1a6a07.jpg', '/Uploads/Picture/20161013/s_e88bef0a7c1a6a07.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('18fcec3bde661050bbd5604ac89630e4', '20000068', '/Uploads/Picture/20160707/b301112f70cf4cd6.jpg', '/Uploads/Picture/20160707/s_b301112f70cf4cd6.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('1a5bceae17953cc12186003d87c391ec', '20000229', '/Uploads/Picture/20161213/9612f075a1c60ab1.jpg', '/Uploads/Picture/20161213/s_9612f075a1c60ab1.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('1b4d4188333a59319c7ff504350cfebe', '20000280', '/Uploads/Picture/20170224/4a8ecc093a2e64bf.jpg', '/Uploads/Picture/20170224/s_4a8ecc093a2e64bf.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('1c3e2aaddad65a9596bf3ca1db7d2489', '20000260', '/Uploads/Picture/20170205/5ad834dda7e0610a.jpg', '/Uploads/Picture/20170205/s_5ad834dda7e0610a.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('1c70de301120e24cc374b22c2e20c71f', '20000050', '/Uploads/Picture/20160618/17671e1910a3e6b9.jpg', '/Uploads/Picture/20160618/s_17671e1910a3e6b9.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('1d47686b086def048c8732bbd7436aad', '20000139', '/Uploads/Picture/20161003/ecb8f22f9102b3bd.jpg', '/Uploads/Picture/20161003/s_ecb8f22f9102b3bd.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('1e1dfc11fdedf3a67880884256a94e60', '20000028', '/Uploads/Picture/20160518/df10e3a6e254e8b5.jpg', '/Uploads/Picture/20160518/s_df10e3a6e254e8b5.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('1e2ecc0fd2384e128c43ffbd766c13c6', '20000253', '/Uploads/Picture/20170117/7e23927ed6024eb0.jpg', '/Uploads/Picture/20170117/s_7e23927ed6024eb0.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('1e783f5d83dac6aa5902a85d9ac6698f', '20000105', '/Uploads/Picture/20160828/42707c6ffbe7bf8b.jpeg', '/Uploads/Picture/20160828/s_42707c6ffbe7bf8b.jpeg', 'head');
INSERT INTO `tc_user_head` VALUES ('1f33dbfd9948552eb73ae95ca4c207d2', '20000211', '/Uploads/Picture/20161119/099e8794a4f7e1d4.jpg', '/Uploads/Picture/20161119/s_099e8794a4f7e1d4.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('1f8427922427b377761fd243f560da34', '20000044', '/Uploads/Picture/20160614/7d913176ca7a817b.jpg', '/Uploads/Picture/20160614/s_7d913176ca7a817b.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('201b23524ec3e12ea13d5c94cc31cb68', '20000076', '/Uploads/Picture/20160721/9f0834528479a051.jpg', '/Uploads/Picture/20160721/s_9f0834528479a051.jpg', 'image1');
INSERT INTO `tc_user_head` VALUES ('240af72ca7e90c3d99c72dae8dc0a938', '20000126', '/Uploads/Picture/20160927/b49f8e487288d0c9.jpg', '/Uploads/Picture/20160927/s_b49f8e487288d0c9.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('2418a522b5e9f2abad4b93d918b4fe42', '20000113', '/Uploads/Picture/20160907/912b94bae9bebf07.jpg', '/Uploads/Picture/20160907/s_912b94bae9bebf07.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('251163721e1e17829d782cc7e9d50265', '20000222', '/Uploads/Picture/20161206/f4a8cec49359719f.png', '/Uploads/Picture/20161206/s_f4a8cec49359719f.png', 'head');
INSERT INTO `tc_user_head` VALUES ('271ca5f8e78a65f5f9004314278a3953', '20000208', '/Uploads/Picture/20161116/f37311c392a11256.jpg', '/Uploads/Picture/20161116/s_f37311c392a11256.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('27481e639401db412f85f78e36702c10', '20000060', '/Uploads/Picture/20160627/850d75a87fcc0fdd.jpg', '/Uploads/Picture/20160627/s_850d75a87fcc0fdd.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('274c9aaa0f3362b612b5597193630ae3', '20000286', '/Uploads/Picture/20170227/03904f8e67b7b645.jpg', '/Uploads/Picture/20170227/s_03904f8e67b7b645.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('27587efd77f93948545796a25634143a', '20000116', '/Uploads/Picture/20160917/8c00b4bd399fb491.jpg', '/Uploads/Picture/20160917/s_8c00b4bd399fb491.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('288942490c5756799573d3512c4df7a7', '20000071', '/Uploads/Picture/20160711/ab6bc1470621c3e5.jpeg', '/Uploads/Picture/20160711/s_ab6bc1470621c3e5.jpeg', 'head');
INSERT INTO `tc_user_head` VALUES ('28b04f6dede734340ee43d4928986b19', '20000194', '/Uploads/Picture/20161102/1bcd0214ff81dfb7.jpg', '/Uploads/Picture/20161102/s_1bcd0214ff81dfb7.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('2bbdc15d48c2a11c0442915b618923cf', '20000235', '/Uploads/Picture/20161221/2843cb6449fe1d20.jpeg', '/Uploads/Picture/20161221/s_2843cb6449fe1d20.jpeg', 'head');
INSERT INTO `tc_user_head` VALUES ('2c41bdc62ffd0599e3697ca78f4ac18c', '20000317', '/Uploads/Picture/20170327/cd16e44611313f55.jpg', '/Uploads/Picture/20170327/s_cd16e44611313f55.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('2e8c411b39ae0c2d98d886cbc4d0943b', '20000136', '/Uploads/Picture/20161002/a828ccb54e34f886.jpg', '/Uploads/Picture/20161002/s_a828ccb54e34f886.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('2f7ecce907b8332d06c3b39c7dc44db4', '20000249', '/Uploads/Picture/20170116/e8912c6a607b26e1.jpg', '/Uploads/Picture/20170116/s_e8912c6a607b26e1.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('2fb5ab03e73260e600f67bda2751802f', '20000205', '/Uploads/Picture/20161112/c51f249f05f624fe.jpg', '/Uploads/Picture/20161112/s_c51f249f05f624fe.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('30466ffdf8f166820ad111353b61a860', '20000142', '/Uploads/Picture/20161003/42b6338a803fca8a.jpg', '/Uploads/Picture/20161003/s_42b6338a803fca8a.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('3073d73c87e909eb4e856370ac235f12', '20000206', '/Uploads/Picture/20161113/83fc321b2d65bf72.png', '/Uploads/Picture/20161113/s_83fc321b2d65bf72.png', 'images');
INSERT INTO `tc_user_head` VALUES ('31866a5029ebcaebe2efa44701ab351e', '20000000', '/Uploads/Picture/20160818/e3e578664abe550b.jpg', '/Uploads/Picture/20160818/s_e3e578664abe550b.jpg', 'image1');
INSERT INTO `tc_user_head` VALUES ('327690cdb8e9e522b5365c6a28a35a5e', '20000159', '/Uploads/Picture/20161012/7bd39a24f232fae3.jpeg', '/Uploads/Picture/20161012/s_7bd39a24f232fae3.jpeg', 'head');
INSERT INTO `tc_user_head` VALUES ('32821ea65f80aa79f767f6c4b843c665', '20000083', '/Uploads/Picture/20160804/317f9b2cae714a7f.jpg', '/Uploads/Picture/20160804/s_317f9b2cae714a7f.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('32d4952e328dc6a8d7030871d8037f4d', '20000153', '/Uploads/Picture/20161007/e0d149bb18605a8b.jpg', '/Uploads/Picture/20161007/s_e0d149bb18605a8b.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('330de6d7c7209832738fd8a6edad95dd', '20000088', '/Uploads/Picture/20160810/f38c76e8a4f795d9.jpg', '/Uploads/Picture/20160810/s_f38c76e8a4f795d9.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('355c3f3737d8aaf4240ae223276956a3', '20000223', '/Uploads/Picture/20161209/d8669153d229f4c3.jpg', '/Uploads/Picture/20161209/s_d8669153d229f4c3.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('35ed1e211456e382eb1c2d7302f38f98', '20000225', '/Uploads/Picture/20161209/057b1f52a8f390a0.png', '/Uploads/Picture/20161209/s_057b1f52a8f390a0.png', 'images');
INSERT INTO `tc_user_head` VALUES ('37321838b7ed61401b40e606adb490e6', '20000100', '/Uploads/Picture/20160820/8bf650ce21674b39.jpg', '/Uploads/Picture/20160820/s_8bf650ce21674b39.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('3816963327456faad641a84c3bef8105', '20000128', '/Uploads/Picture/20160928/0257620dd643b890.jpg', '/Uploads/Picture/20160928/s_0257620dd643b890.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('38309cc8bf1319d76ee188bfa28cf3a3', '20000288', '/Uploads/Picture/20170228/e9f31980275ba7fa.jpg', '/Uploads/Picture/20170228/s_e9f31980275ba7fa.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('395a303330bcbcd886e163ba7be0cc9f', '20000046', '/Uploads/Picture/20160616/674c63d086a646b4.jpg', '/Uploads/Picture/20160616/s_674c63d086a646b4.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('3cb60cd80b4e2031d42b525536fb2b70', '20000227', '/Uploads/Picture/20161211/ad57908f2bf499ea.jpg', '/Uploads/Picture/20161211/s_ad57908f2bf499ea.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('3dd27b5f0d1c63b4e55c323b2d83906b', '20000149', '/Uploads/Picture/20161005/322940a5f8d00ca2.jpg', '/Uploads/Picture/20161005/s_322940a5f8d00ca2.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('3df83adcf0051c5df6874b816ca86df7', '20000230', '/Uploads/Picture/20161213/c3673413698a9fc2.jpg', '/Uploads/Picture/20161213/s_c3673413698a9fc2.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('406892ff7862b2df7a4f5d97790dca1c', '20000241', '/Uploads/Picture/20170101/3afc6ad78be87412.jpg', '/Uploads/Picture/20170101/s_3afc6ad78be87412.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('41da54da6a7e53fd66319cbb54f3234f', '20000202', '/Uploads/Picture/20161110/6a70f27c2731f70c.jpg', '/Uploads/Picture/20161110/s_6a70f27c2731f70c.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('444048efc3d32b8f621e8a1173e2690a', '20000104', '/Uploads/Picture/20160827/7e9f31326b402573.png', '/Uploads/Picture/20160827/s_7e9f31326b402573.png', 'images');
INSERT INTO `tc_user_head` VALUES ('448da7519ad1d978d5b3fdc863e300dd', '20000001', '/Uploads/Picture/20160714/e341709f41aadecd.jpg', '/Uploads/Picture/20160714/s_e341709f41aadecd.jpg', 'image1');
INSERT INTO `tc_user_head` VALUES ('44cf9759c2f8bfe35d081e5e8dcbdc31', '20000216', '/Uploads/Picture/20161125/0a5610a6e044b8c9.png', '/Uploads/Picture/20161125/s_0a5610a6e044b8c9.png', 'images');
INSERT INTO `tc_user_head` VALUES ('473305bce95b61f9977d560f73ee82a7', '20000043', '/Uploads/Picture/20160614/5dbcdbb4d3b6495d.jpg', '/Uploads/Picture/20160614/s_5dbcdbb4d3b6495d.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('485f9c4a37be7d645a6058dcaabb847b', '20000148', '/Uploads/Picture/20161005/0a73a23deb0d4c3f.jpg', '/Uploads/Picture/20161005/s_0a73a23deb0d4c3f.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('4873ed61707c7d944594ffd3b5e80a97', '20000203', '/Uploads/Picture/20161110/569fcac803227df3.jpg', '/Uploads/Picture/20161110/s_569fcac803227df3.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('4a1079c93b3b22a387887dcb32e9ff9a', '20000039', '/Uploads/Picture/20160612/dc6cff4e06155b12.jpg', '/Uploads/Picture/20160612/s_dc6cff4e06155b12.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('4a48d105d49c7a326b1b3ab3e319733c', '20000045', '/Uploads/Picture/20160615/5c3f5e81c6a295f3.jpg', '/Uploads/Picture/20160615/s_5c3f5e81c6a295f3.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('4b54306f499358aa667c2ef2d197de2b', '20000115', '/Uploads/Picture/20160913/0cd0699b84ae7971.png', '/Uploads/Picture/20160913/s_0cd0699b84ae7971.png', 'images');
INSERT INTO `tc_user_head` VALUES ('4c057f12062d0b85070fb70d738848be', '20000082', '/Uploads/Picture/20160801/03989014311093a5.jpg', '/Uploads/Picture/20160801/s_03989014311093a5.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('4c1e8691f974bcfb76ffa83e59499fbe', '20000002', '/Uploads/Picture/20160319/5647b67ee48739b5.jpg', '/Uploads/Picture/20160319/s_5647b67ee48739b5.jpg', 'image4');
INSERT INTO `tc_user_head` VALUES ('4d0746b5ed9caec6c6b9443396e05cc2', '20000114', '/Uploads/Picture/20160908/39d6d14f8df4ff98.png', '/Uploads/Picture/20160908/s_39d6d14f8df4ff98.png', 'head');
INSERT INTO `tc_user_head` VALUES ('4d37380fb948a15ea02022defcd3d09b', '20000184', '/Uploads/Picture/20161022/624769277bae77b5.jpg', '/Uploads/Picture/20161022/s_624769277bae77b5.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('4ebb3a68d5fe5bc1186e8659c69ad2b3', '20000197', '/Uploads/Picture/20161104/120eef4e8f3cac27.jpg', '/Uploads/Picture/20161104/s_120eef4e8f3cac27.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('4ed8753fed5ed622c427de627d4ad521', '20000283', '/Uploads/Picture/20170226/046cbcf88e5ec606.jpg', '/Uploads/Picture/20170226/s_046cbcf88e5ec606.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('4f07ca232d28e683d049e7dc235d7322', '20000108', '/Uploads/Picture/20160830/a67ff4bb681e270e.png', '/Uploads/Picture/20160830/s_a67ff4bb681e270e.png', 'images');
INSERT INTO `tc_user_head` VALUES ('4f966d28eac0dd98e4f7cadd31d35db7', '20000267', '/Uploads/Picture/20170327/90e1fbdaa2cb3c5f.png', '/Uploads/Picture/20170327/s_90e1fbdaa2cb3c5f.png', 'image');
INSERT INTO `tc_user_head` VALUES ('4ff6776828366a48286727f81a878832', '20000002', '/Uploads/Picture/20160319/1685312543c4852b.jpg', '/Uploads/Picture/20160319/s_1685312543c4852b.jpg', 'image5');
INSERT INTO `tc_user_head` VALUES ('50ba11bb26a74bb10974b571bcf51266', '20000132', '/Uploads/Picture/20160930/4a7b0c94bab4382a.jpg', '/Uploads/Picture/20160930/s_4a7b0c94bab4382a.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('52d894558baa308b25e8c2fb81700007', '20000062', '/Uploads/Picture/20160702/f8ea4c263ea95d13.jpg', '/Uploads/Picture/20160702/s_f8ea4c263ea95d13.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('5382fe4fa89b131106676dc21b184191', '20000310', '/Uploads/Picture/20170321/e68051cee7fb1d60.png', '/Uploads/Picture/20170321/s_e68051cee7fb1d60.png', 'head');
INSERT INTO `tc_user_head` VALUES ('563474dcfb86251bb85ca95ad668a037', '20000066', '/Uploads/Picture/20160706/b523522fb1c81c29.jpg', '/Uploads/Picture/20160706/s_b523522fb1c81c29.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('57c3f0fae8838d24aeb13d87d91dc71e', '20000146', '/Uploads/Picture/20161005/372633fd95b0134a.png', '/Uploads/Picture/20161005/s_372633fd95b0134a.png', 'head');
INSERT INTO `tc_user_head` VALUES ('5b839eb96af564c4740bb957bfc9fa1f', '20000313', '/Uploads/Picture/20170323/36421aacda9e2e7e.jpg', '/Uploads/Picture/20170323/s_36421aacda9e2e7e.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('5c38c42dba42ce1ca33a73612b077bc3', '20000051', '/Uploads/Picture/20160619/e9463a53e1570ec6.png', '/Uploads/Picture/20160619/s_e9463a53e1570ec6.png', 'images');
INSERT INTO `tc_user_head` VALUES ('5ded53267329446a2ab8f4c16927ca0d', '20000048', '/Uploads/Picture/20160616/c1c7ec3ed657d07d.png', '/Uploads/Picture/20160616/s_c1c7ec3ed657d07d.png', 'head');
INSERT INTO `tc_user_head` VALUES ('5e014d594fa93f5459c03d6b67391bd6', '20000237', '/Uploads/Picture/20161227/84602071ea8b715d.jpg', '/Uploads/Picture/20161227/s_84602071ea8b715d.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('5e0abe10a09565a07a485abfd396873d', '20000306', '/Uploads/Picture/20170318/98b5465f6ff80787.jpg', '/Uploads/Picture/20170318/s_98b5465f6ff80787.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('5e3354e0e3b68eeec203ce2d52bd0582', '20000129', '/Uploads/Picture/20160928/93d21e31ddaf8e3c.jpg', '/Uploads/Picture/20160928/s_93d21e31ddaf8e3c.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('5e419f01d14ae9aebba8386079ec4550', '20000006', '/Uploads/Picture/20160321/59a3a11582f029a9.jpg', '/Uploads/Picture/20160321/s_59a3a11582f029a9.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('609c2319c0a0e352a305fe8098e4012a', '20000091', '/Uploads/Picture/20160812/20f6b7c705330780.jpg', '/Uploads/Picture/20160812/s_20f6b7c705330780.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('611fef98f5c3103cb32f1efa50bfc049', '20000002', '/Uploads/Picture/20160716/a2f016d132c07797.jpg', '/Uploads/Picture/20160716/s_a2f016d132c07797.jpg', 'image1');
INSERT INTO `tc_user_head` VALUES ('6267cecce7ba37c43ddf269e5b509dc6', '20000248', '/Uploads/Picture/20170114/975a1bd56144e6b6.jpg', '/Uploads/Picture/20170114/s_975a1bd56144e6b6.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('64e75accba20ca105d7cf23706733c49', '20000057', '/Uploads/Picture/20160624/99707fa24cdbcce1.jpg', '/Uploads/Picture/20160624/s_99707fa24cdbcce1.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('6597c3afd6214c74961d436916a0d516', '20000201', '/Uploads/Picture/20161109/e1f635c0ee578fbc.jpg', '/Uploads/Picture/20161109/s_e1f635c0ee578fbc.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('65d395e67781b99b31556075c3737dc8', '20000181', '/Uploads/Picture/20161021/7efe2247e5091e48.jpg', '/Uploads/Picture/20161021/s_7efe2247e5091e48.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('662604ec4be7c0174f7089497c788fd2', '20000170', '/Uploads/Picture/20161018/8df9ca82897dba3a.jpg', '/Uploads/Picture/20161018/s_8df9ca82897dba3a.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('6727759b9640d6daaaf1a0ab7f90838f', '20000214', '/Uploads/Picture/20161124/7e46a7a2c1b13655.jpeg', '/Uploads/Picture/20161124/s_7e46a7a2c1b13655.jpeg', 'head');
INSERT INTO `tc_user_head` VALUES ('67d243ddd08c61301a2cbbee9e436a9f', '20000180', '/Uploads/Picture/20161021/cfff0d015f53c0a8.jpeg', '/Uploads/Picture/20161021/s_cfff0d015f53c0a8.jpeg', 'head');
INSERT INTO `tc_user_head` VALUES ('68b1ab59c50668835d94e08c17f95845', '20000284', '/Uploads/Picture/20170226/90462759d2c62870.jpg', '/Uploads/Picture/20170226/s_90462759d2c62870.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('69d38e3671311c4e2e8b761cadbd6609', '20000020', '/Uploads/Picture/20160401/6394288ad32794bc.png', '/Uploads/Picture/20160401/s_6394288ad32794bc.png', 'head');
INSERT INTO `tc_user_head` VALUES ('6a1434cdabd0307ded8413fa47e9541a', '20000003', '/Uploads/Picture/20160318/48a3976e5306f1ca.jpg', '/Uploads/Picture/20160318/s_48a3976e5306f1ca.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('6a1bb9841c7ea124046d75cfc983177a', '20000300', '/Uploads/Picture/20170314/1a7137551f299995.jpeg', '/Uploads/Picture/20170314/s_1a7137551f299995.jpeg', 'head');
INSERT INTO `tc_user_head` VALUES ('6b56f0f600dc17b61760f0b4afd1b5a6', '20000297', '/Uploads/Picture/20170308/d7d85afc6ff43a75.jpg', '/Uploads/Picture/20170308/s_d7d85afc6ff43a75.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('6baa1cecad2c7a2974e14dbe6e1dc81b', '20000315', '/Uploads/Picture/20170327/5bb4fe624092f520.png', '/Uploads/Picture/20170327/s_5bb4fe624092f520.png', 'image');
INSERT INTO `tc_user_head` VALUES ('6c58d137aac94d021495584cf7a64bde', '20000301', '/Uploads/Picture/20170315/4b5dec3ea71eef7c.jpg', '/Uploads/Picture/20170315/s_4b5dec3ea71eef7c.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('6d146ef0d1c097ea690ec69e7838ad37', '20000054', '/Uploads/Picture/20160620/49618e3b2b72209c.png', '/Uploads/Picture/20160620/s_49618e3b2b72209c.png', 'images');
INSERT INTO `tc_user_head` VALUES ('6d9b86d5f833f274d5e7d00c5d3aeb1f', '20000257', '/Uploads/Picture/20170129/c4f7bd70802b1d8b.jpg', '/Uploads/Picture/20170129/s_c4f7bd70802b1d8b.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('6da8069ed7bd0827746e4dfb8f030afa', '20000273', '/Uploads/Picture/20170216/3aab9a61ee910fb2.jpg', '/Uploads/Picture/20170216/s_3aab9a61ee910fb2.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('6e4337135209d37cc5abb040f9953a91', '20000224', '/Uploads/Picture/20161209/39c4d3931c5f6600.jpg', '/Uploads/Picture/20161209/s_39c4d3931c5f6600.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('708eea5a712991d35bfc9755782014c2', '20000269', '/Uploads/Picture/20170214/79d30a1c5b501f28.jpg', '/Uploads/Picture/20170214/s_79d30a1c5b501f28.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('70bbbaa97b73c29c8e91f3d575733443', '20000166', '/Uploads/Picture/20161014/d1f6567d55e598c4.jpg', '/Uploads/Picture/20161014/s_d1f6567d55e598c4.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('70d198b60e55e7ca5d23f38a7bee7eb4', '20000101', '/Uploads/Picture/20160820/3fbe847a41ad48b5.jpg', '/Uploads/Picture/20160820/s_3fbe847a41ad48b5.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('7157df76efb7af05715ab10de8bd9879', '20000263', '/Uploads/Picture/20170209/3daa783682364876.png', '/Uploads/Picture/20170209/s_3daa783682364876.png', 'images');
INSERT INTO `tc_user_head` VALUES ('72338f33b3fd4ff9b366fc49230ddf05', '20000292', '/Uploads/Picture/20170304/c678ec751a7a50af.jpg', '/Uploads/Picture/20170304/s_c678ec751a7a50af.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('73285f772046f0419b7cc95e38f3e23e', '20000251', '/Uploads/Picture/20170117/2c7179e64ff12f7b.jpg', '/Uploads/Picture/20170117/s_2c7179e64ff12f7b.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('745a6a7f899b45d38ac734351adba871', '20000078', '/Uploads/Picture/20160726/c5722eaf8a5236a5.jpg', '/Uploads/Picture/20160726/s_c5722eaf8a5236a5.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('747cf620c9a2a6be4e6082312b04dddd', '20000218', '/Uploads/Picture/20161203/78644891e73f2e03.jpeg', '/Uploads/Picture/20161203/s_78644891e73f2e03.jpeg', 'head');
INSERT INTO `tc_user_head` VALUES ('74cd34be25dd128652c98d9f226aa96e', '20000131', '/Uploads/Picture/20160929/12522133a1326891.jpg', '/Uploads/Picture/20160929/s_12522133a1326891.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('756022a5ae0b04bb17de8fb813ff20be', '20000316', '/Uploads/Picture/20170324/d07e2674a5e4b5ce.jpg', '/Uploads/Picture/20170324/s_d07e2674a5e4b5ce.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('75c77842226c13038bc13e13a0710e5f', '20000107', '/Uploads/Picture/20160829/5dbc4a8bfab74828.jpeg', '/Uploads/Picture/20160829/s_5dbc4a8bfab74828.jpeg', 'head');
INSERT INTO `tc_user_head` VALUES ('761655df2999f84408a80ecb4aee3de2', '20000049', '/Uploads/Picture/20160617/bbe72ef7fdfc67fd.jpg', '/Uploads/Picture/20160617/s_bbe72ef7fdfc67fd.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('76e54bd1e41d389ec104d97626869ce2', '20000221', '/Uploads/Picture/20161206/b0b93b43c6fdcc80.jpg', '/Uploads/Picture/20161206/s_b0b93b43c6fdcc80.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('76f3e9d3a9c7e7038c1e41e163599d19', '20000061', '/Uploads/Picture/20160702/22223818731cdec5.jpg', '/Uploads/Picture/20160702/s_22223818731cdec5.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('773d0ff475d9e5e62f2fecd9312e7f18', '20000008', '/Uploads/Picture/20160323/5e2125d365a7f817.jpg', '/Uploads/Picture/20160323/s_5e2125d365a7f817.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('773e07ff663c1c79662a258c4e93f7b4', '20000161', '/Uploads/Picture/20161013/265e2ba839938a80.jpg', '/Uploads/Picture/20161013/s_265e2ba839938a80.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('7757fcb17713cff12f4ac2e5e35585eb', '20000308', '/Uploads/Picture/20170318/8ec6dc7f03f8afb6.jpg', '/Uploads/Picture/20170318/s_8ec6dc7f03f8afb6.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('79059d3a1f3faba6f6fc77b5a101b9f4', '20000042', '/Uploads/Picture/20160613/dae51d39392005e3.jpg', '/Uploads/Picture/20160613/s_dae51d39392005e3.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('795d426a35f1ae7208ce21c5519fcf1a', '20000298', '/Uploads/Picture/20170311/3d8700fe1f176848.jpg', '/Uploads/Picture/20170311/s_3d8700fe1f176848.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('7989e07f0c9d7008063a6243795a2ea9', '20000103', '/Uploads/Picture/20160826/fe4f45bf36385cd7.jpg', '/Uploads/Picture/20160826/s_fe4f45bf36385cd7.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('7ad74db057345d3b3387a35a209a5b3c', '20000302', '/Uploads/Picture/20170315/8599dcca2f30719d.jpg', '/Uploads/Picture/20170315/s_8599dcca2f30719d.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('7b19834e8183cc5113ace500670191a7', '20000271', '/Uploads/Picture/20170215/fe07f682c3ac4594.png', '/Uploads/Picture/20170215/s_fe07f682c3ac4594.png', 'images');
INSERT INTO `tc_user_head` VALUES ('7bc056f4e7f46ebc1591962f2293a6ed', '20000115', '/Uploads/Picture/20161206/a384424b7aa8b942.png', '/Uploads/Picture/20161206/s_a384424b7aa8b942.png', 'image');
INSERT INTO `tc_user_head` VALUES ('7c268d55e0015171681796b907132ed9', '20000102', '/Uploads/Picture/20160824/b351d27db6d22ec6.jpg', '/Uploads/Picture/20160824/s_b351d27db6d22ec6.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('7d6ab100c467e062cbbd24b27a0364e1', '20000289', '/Uploads/Picture/20170301/c7f4e9a03a7295e9.jpg', '/Uploads/Picture/20170301/s_c7f4e9a03a7295e9.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('7d786aaa912cb5280643661898dfd358', '20000236', '/Uploads/Picture/20161226/d50aa2a6d3263efa.jpg', '/Uploads/Picture/20161226/s_d50aa2a6d3263efa.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('7e7211deb4d4762727dc35671e8df7cc', '20000089', '/Uploads/Picture/20160811/781b3ef54e18f903.jpeg', '/Uploads/Picture/20160811/s_781b3ef54e18f903.jpeg', 'head');
INSERT INTO `tc_user_head` VALUES ('7e7fdfd37572a6b9c43e5044ebc6d49c', '20000179', '/Uploads/Picture/20161021/ca66872a2133dd9c.jpg', '/Uploads/Picture/20161021/s_ca66872a2133dd9c.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('7f80b4788acae12ebb3dace7cc1095ba', '20000293', '/Uploads/Picture/20170305/6359de1eff868f60.jpg', '/Uploads/Picture/20170305/s_6359de1eff868f60.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('81576b7d524101730a85c174999c1d0c', '20000040', '/Uploads/Picture/20160612/1784de02dafacf3f.jpg', '/Uploads/Picture/20160612/s_1784de02dafacf3f.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('8247fcb9d2ca6d11d77701c0e127c836', '20000196', '/Uploads/Picture/20161103/9231877c6187ead1.jpg', '/Uploads/Picture/20161103/s_9231877c6187ead1.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('8659eb7f5bcfbcb37aa63e7de72ea607', '20000127', '/Uploads/Picture/20160928/d7d3d47eedbfbf12.png', '/Uploads/Picture/20160928/s_d7d3d47eedbfbf12.png', 'head');
INSERT INTO `tc_user_head` VALUES ('8760b7c2262675a37d36203f45925b07', '20000154', '/Uploads/Picture/20161007/17e2ff8fe10d637e.jpg', '/Uploads/Picture/20161007/s_17e2ff8fe10d637e.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('88e0b5a2356f54ca47f0d54ec4e85ee6', '20000030', '/Uploads/Picture/20160603/3a6bb4a4f32fe146.jpg', '/Uploads/Picture/20160603/s_3a6bb4a4f32fe146.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('891517ad644f5fb05f7ccfeb59ee7a24', '20000079', '/Uploads/Picture/20160730/370d987bc7d49d75.jpg', '/Uploads/Picture/20160730/s_370d987bc7d49d75.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('8985e15a49c52b8f6a44e1ba41ddb6b0', '20000022', '/Uploads/Picture/20160415/890027f700e809be.jpg', '/Uploads/Picture/20160415/s_890027f700e809be.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('8a2d3532806a2a001a47d1d37268d704', '20000281', '/Uploads/Picture/20170224/5619e4c1b61ef50b.jpg', '/Uploads/Picture/20170224/s_5619e4c1b61ef50b.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('8a5005c880917a984ce20132f0628665', '20000072', '/Uploads/Picture/20160712/2ef003b7052ed333.jpg', '/Uploads/Picture/20160712/s_2ef003b7052ed333.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('8ab206b03b0aad5f6e88ba57b45fc616', '20000296', '/Uploads/Picture/20170307/3df9e4d930c533d6.jpg', '/Uploads/Picture/20170307/s_3df9e4d930c533d6.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('8ac55f098a58571d5787bf265060a8ed', '20000212', '/Uploads/Picture/20161120/dcfdc4ae6b50ff1c.jpg', '/Uploads/Picture/20161120/s_dcfdc4ae6b50ff1c.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('8b33f54271da725ee1c48ede2475c74a', '20000120', '/Uploads/Picture/20160921/a3845b2e58a8f650.jpg', '/Uploads/Picture/20160921/s_a3845b2e58a8f650.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('8b6c8276d85b5238fdd7dd074af79e68', '20000195', '/Uploads/Picture/20161102/6c62e9a62f423533.jpg', '/Uploads/Picture/20161102/s_6c62e9a62f423533.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('8be03d00c87e13307da9cd189da4a06e', '20000119', '/Uploads/Picture/20160920/635011363b5ab69e.jpg', '/Uploads/Picture/20160920/s_635011363b5ab69e.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('8c17694c53ba4b168dbdd1b55245dfcf', '20000209', '/Uploads/Picture/20161118/3056fdab7d7f4266.jpg', '/Uploads/Picture/20161118/s_3056fdab7d7f4266.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('8c1f4eca3cdba8dd8697597b3de95526', '20000259', '/Uploads/Picture/20170203/6ed715bda0186c02.jpg', '/Uploads/Picture/20170203/s_6ed715bda0186c02.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('8c7a45c27cdb144f29f907f6cd1cb3b5', '20000266', '/Uploads/Picture/20170210/030f1ced24614626.jpg', '/Uploads/Picture/20170210/s_030f1ced24614626.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('8ca571e61be35a14bfeb910384d8a44c', '20000074', '/Uploads/Picture/20160716/ce3970a2ebea2624.jpg', '/Uploads/Picture/20160716/s_ce3970a2ebea2624.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('8d4d72cd2b1648cb9786d9b6c936980d', '20000063', '/Uploads/Picture/20160704/6d18f40da56d011c.JPEG', '/Uploads/Picture/20160704/s_6d18f40da56d011c.JPEG', 'head');
INSERT INTO `tc_user_head` VALUES ('8d916a719f796db2f805ae5fdc72a2b5', '20000069', '/Uploads/Picture/20160708/38ad53a005dbf6c8.png', '/Uploads/Picture/20160708/s_38ad53a005dbf6c8.png', 'head');
INSERT INTO `tc_user_head` VALUES ('8e656f4d9a177a5fb66a810116ede93b', '20000109', '/Uploads/Picture/20160901/38375a0662675b51.jpg', '/Uploads/Picture/20160901/s_38375a0662675b51.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('8e6a9997ac682c8e2782ed2a7956f81b', '20000185', '/Uploads/Picture/20161023/7645718a0cc88732.jpeg', '/Uploads/Picture/20161023/s_7645718a0cc88732.jpeg', 'head');
INSERT INTO `tc_user_head` VALUES ('903d95b29eb12ecbd212cd073e47c6dc', '20000304', '/Uploads/Picture/20170316/147679db345728bf.jpg', '/Uploads/Picture/20170316/s_147679db345728bf.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('913a7d86eefd732fc4a9f0662bc96cc8', '20000017', '/Uploads/Picture/20160428/0b18450ac870edb7.png', '/Uploads/Picture/20160428/s_0b18450ac870edb7.png', 'image');
INSERT INTO `tc_user_head` VALUES ('9175932d56f796c942d2434601a28d14', '20000041', '/Uploads/Picture/20160613/db971425bcd06999.jpg', '/Uploads/Picture/20160613/s_db971425bcd06999.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('934a4f54bf3552641a8035082a800272', '20000138', '/Uploads/Picture/20161002/2da8347e99b98ad7.png', '/Uploads/Picture/20161002/s_2da8347e99b98ad7.png', 'head');
INSERT INTO `tc_user_head` VALUES ('94535c1c45518ff836385e7549bb67b8', '20000125', '/Uploads/Picture/20160926/4e4b3bc3b9918474.jpeg', '/Uploads/Picture/20160926/s_4e4b3bc3b9918474.jpeg', 'head');
INSERT INTO `tc_user_head` VALUES ('96808885ad729023f8dc3e0a0761c04a', '20000123', '/Uploads/Picture/20160923/e2a5eec8eb6b89e5.png', '/Uploads/Picture/20160923/s_e2a5eec8eb6b89e5.png', 'head');
INSERT INTO `tc_user_head` VALUES ('9795876dc8d5f1b02f03044fa144ba3e', '20000106', '/Uploads/Picture/20160828/847ed0319dc1d355.jpg', '/Uploads/Picture/20160828/s_847ed0319dc1d355.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('97e2db890da9ea7658de60cbf75e2825', '20000252', '/Uploads/Picture/20170117/2880881b019819cc.png', '/Uploads/Picture/20170117/s_2880881b019819cc.png', 'head');
INSERT INTO `tc_user_head` VALUES ('994d14daf06c884f50e266107cbfdfcf', '20000086', '/Uploads/Picture/20160807/7f11661c4d228e9e.jpg', '/Uploads/Picture/20160807/s_7f11661c4d228e9e.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('9975f3b5f402d514047ba57474b3f8cd', '20000168', '/Uploads/Picture/20161016/3b9c8729ecfbb7ee.png', '/Uploads/Picture/20161016/s_3b9c8729ecfbb7ee.png', 'images');
INSERT INTO `tc_user_head` VALUES ('9bc4ac50c037cd793a865d832ef6b0b3', '20000156', '/Uploads/Picture/20161007/98e52eb6b2b9148f.jpeg', '/Uploads/Picture/20161007/s_98e52eb6b2b9148f.jpeg', 'head');
INSERT INTO `tc_user_head` VALUES ('9d47130b33bc9b3168e6f460f1b9a82c', '20000228', '/Uploads/Picture/20161212/29497b2cf41100c5.jpg', '/Uploads/Picture/20161212/s_29497b2cf41100c5.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('9d6fcdb5f42095ab14fc6a85f93670a3', '20000274', '/Uploads/Picture/20170216/07799ad26f615007.jpg', '/Uploads/Picture/20170216/s_07799ad26f615007.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('9d8f60113e2de9a35345886dab5506ee', '20000220', '/Uploads/Picture/20161204/e1d3a19020ab983c.jpg', '/Uploads/Picture/20161204/s_e1d3a19020ab983c.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('a1197a7c8ddb98bb2e1dc12911dd5742', '20000191', '/Uploads/Picture/20161031/969a8759f72bae8c.png', '/Uploads/Picture/20161031/s_969a8759f72bae8c.png', 'images');
INSERT INTO `tc_user_head` VALUES ('a176cf824b556070bfa784df37751d1f', '20000226', '/Uploads/Picture/20161209/af48a319df5c8cce.jpg', '/Uploads/Picture/20161209/s_af48a319df5c8cce.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('a33ae34e574f81dbed1f144735fd5f74', '20000272', '/Uploads/Picture/20170215/8dc9484c22e1657d.jpg', '/Uploads/Picture/20170215/s_8dc9484c22e1657d.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('a41133ab431a7a0f6cf25020ba791a45', '20000294', '/Uploads/Picture/20170306/2989640bbcb3dbc4.jpg', '/Uploads/Picture/20170306/s_2989640bbcb3dbc4.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('a45f020a06605f93b5b4b453923c0d68', '20000073', '/Uploads/Picture/20160715/ba7ed3557f6f174e.jpg', '/Uploads/Picture/20160715/s_ba7ed3557f6f174e.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('a4ca22c336443c46945aa4cc9567dc1d', '20000098', '/Uploads/Picture/20160819/dcb2d37267663df1.jpg', '/Uploads/Picture/20160819/s_dcb2d37267663df1.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('a56f14f3c197b92cfc07e20dedab4c3f', '20000254', '/Uploads/Picture/20170119/b448d201eabd2bf8.jpg', '/Uploads/Picture/20170119/s_b448d201eabd2bf8.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('a5c1064a8eb0c776e5da61c66f3b2785', '20000204', '/Uploads/Picture/20161111/0827a21b92557d88.jpg', '/Uploads/Picture/20161111/s_0827a21b92557d88.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('a602c949d9291930aba17c51a4961c68', '20000250', '/Uploads/Picture/20170116/315992fbe55a4f15.jpg', '/Uploads/Picture/20170116/s_315992fbe55a4f15.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('a69bccb2f8cc906ddd8c051d97aa5208', '20000004', '/Uploads/Picture/20160319/7b5b33e43c76b4c3.jpg', '/Uploads/Picture/20160319/s_7b5b33e43c76b4c3.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('a6a5d1ebe4ebe29bff6dd86ad15a27f2', '20000037', '/Uploads/Picture/20160611/53ea1ad9846a0614.jpg', '/Uploads/Picture/20160611/s_53ea1ad9846a0614.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('a6f0a9343ac2eb10b281462621820be0', '20000085', '/Uploads/Picture/20160806/b7cf72b86b8816f1.jpg', '/Uploads/Picture/20160806/s_b7cf72b86b8816f1.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('a6fcbce92674800447827333230fbb3c', '20000175', '/Uploads/Picture/20161019/e75d85a4d75e6d02.png', '/Uploads/Picture/20161019/s_e75d85a4d75e6d02.png', 'head');
INSERT INTO `tc_user_head` VALUES ('a7c7f0bf17d33808c66b3360f0267170', '20000135', '/Uploads/Picture/20161001/b43465069503f7d7.jpg', '/Uploads/Picture/20161001/s_b43465069503f7d7.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('a7dfbce108b084fd19d2be9a17310e19', '20000034', '/Uploads/Picture/20160608/35b860c0972d4546.jpg', '/Uploads/Picture/20160608/s_35b860c0972d4546.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('a8dcd25d06b281211113a61e09ccd00a', '20000190', '/Uploads/Picture/20161031/2f53aaeb88bae924.jpg', '/Uploads/Picture/20161031/s_2f53aaeb88bae924.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('a9ff543426582bb4493c4ea48ce10753', '20000058', '/Uploads/Picture/20160625/02b105cb5a4738e1.jpeg', '/Uploads/Picture/20160625/s_02b105cb5a4738e1.jpeg', 'head');
INSERT INTO `tc_user_head` VALUES ('aaedf31f077b7ec61e872fe892b36d02', '20000275', '/Uploads/Picture/20170218/1f56da1128800c06.jpg', '/Uploads/Picture/20170218/s_1f56da1128800c06.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('ab3b92e39f9965282f54f389e8fa8ffa', '20000261', '/Uploads/Picture/20170206/8b829a9110da03b6.jpg', '/Uploads/Picture/20170206/s_8b829a9110da03b6.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('abd18dd0df20dd2cdc8ae2b6d3094f95', '20000299', '/Uploads/Picture/20170313/8995c1630e7f908e.jpg', '/Uploads/Picture/20170313/s_8995c1630e7f908e.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('ac697c7cced9c463f23cbfb9743d00f4', '20000081', '/Uploads/Picture/20160731/401e29dc552ee1a1.jpeg', '/Uploads/Picture/20160731/s_401e29dc552ee1a1.jpeg', 'head');
INSERT INTO `tc_user_head` VALUES ('ad8ea6238a4aedfb3828a13220975314', '20000255', '/Uploads/Picture/20170121/dce0842ab534bcec.jpg', '/Uploads/Picture/20170121/s_dce0842ab534bcec.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('add232eb775eba2fe6603be1d85c17a8', '20000315', '/Uploads/Picture/20170323/1d84cb873dfffdb7.jpg', '/Uploads/Picture/20170323/s_1d84cb873dfffdb7.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('ade4a685a7c918da2805c3272a20df1f', '20000247', '/Uploads/Picture/20170114/c589e4c6de54788a.jpg', '/Uploads/Picture/20170114/s_c589e4c6de54788a.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('af365ac06f579766eead987791120019', '20000019', '/Uploads/Picture/20160401/ad4b15bb081f6316.jpg', '/Uploads/Picture/20160401/s_ad4b15bb081f6316.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('b079d4f8ad200656664aaa7c4bd2e0ee', '20000141', '/Uploads/Picture/20161003/3e49b4ea46a5766b.jpg', '/Uploads/Picture/20161003/s_3e49b4ea46a5766b.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('b0c6eef9fee18fb676be55d7362a4c8b', '20000183', '/Uploads/Picture/20161021/ea5e4d7d7aca6284.jpeg', '/Uploads/Picture/20161021/s_ea5e4d7d7aca6284.jpeg', 'head');
INSERT INTO `tc_user_head` VALUES ('b0f08e7b4ddd8d85299059f3882f5348', '20000171', '/Uploads/Picture/20161018/5877a174efefe47e.jpg', '/Uploads/Picture/20161018/s_5877a174efefe47e.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('b17640ea2f7b63650c9ed58cfe05e58b', '20000118', '/Uploads/Picture/20160920/e990eceec4a3b3cf.jpeg', '/Uploads/Picture/20160920/s_e990eceec4a3b3cf.jpeg', 'head');
INSERT INTO `tc_user_head` VALUES ('b1ec67f8ce954320bc4a424460a69666', '20000140', '/Uploads/Picture/20161003/5d491604b5ff4f40.jpg', '/Uploads/Picture/20161003/s_5d491604b5ff4f40.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('b23fd9856d02979bdebf2d42b2fda3d2', '20000270', '/Uploads/Picture/20170215/efea464d280d4b72.jpg', '/Uploads/Picture/20170215/s_efea464d280d4b72.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('b502a4291359ee596cddb14b7f16d59e', '20000246', '/Uploads/Picture/20170114/f88a252029c78b8f.jpeg', '/Uploads/Picture/20170114/s_f88a252029c78b8f.jpeg', 'head');
INSERT INTO `tc_user_head` VALUES ('b533811f347c26ba88afe1f6b7385cc3', '20000198', '/Uploads/Picture/20161106/fedac2c8e7bff3b0.jpg', '/Uploads/Picture/20161106/s_fedac2c8e7bff3b0.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('b5c8a599c1b4113c61ab30a8839b9462', '20000192', '/Uploads/Picture/20161101/1ba91373b474cd38.jpg', '/Uploads/Picture/20161101/s_1ba91373b474cd38.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('b6b5b0c702b0cf1685392619a757c59f', '20000189', '/Uploads/Picture/20161028/6ba787654b0ab505.jpg', '/Uploads/Picture/20161028/s_6ba787654b0ab505.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('b72a28bf574639214a2b661607a8378c', '20000178', '/Uploads/Picture/20161020/de2b08ceded3a82d.jpg', '/Uploads/Picture/20161020/s_de2b08ceded3a82d.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('b9f9fcd2282f6bda933dc32a59ed6f49', '20000096', '/Uploads/Picture/20161206/5752829287f74c94.png', '/Uploads/Picture/20161206/s_5752829287f74c94.png', 'image');
INSERT INTO `tc_user_head` VALUES ('bb4e46b71e20ceabcddf1577e6fffb81', '20000151', '/Uploads/Picture/20161005/bae208a0963118d4.jpg', '/Uploads/Picture/20161005/s_bae208a0963118d4.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('bc0341cfd39a16f0fbee0324d87a3d13', '20000312', '/Uploads/Picture/20170323/da8b60990cae7897.png', '/Uploads/Picture/20170323/s_da8b60990cae7897.png', 'head');
INSERT INTO `tc_user_head` VALUES ('bc1c5566573ce4d5d94a652e418b3cd7', '20000094', '/Uploads/Picture/20160816/011419fcbc2de50e.jpg', '/Uploads/Picture/20160816/s_011419fcbc2de50e.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('bd4b39663d6d209cb7e489a5a366d458', '20000238', '/Uploads/Picture/20161228/1e527e077f812a91.jpg', '/Uploads/Picture/20161228/s_1e527e077f812a91.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('beb04b4fc0db86ac27c21e336441fa8f', '20000121', '/Uploads/Picture/20160921/99763bc3b48c39d1.jpeg', '/Uploads/Picture/20160921/s_99763bc3b48c39d1.jpeg', 'head');
INSERT INTO `tc_user_head` VALUES ('bfc592ecb594e6469e47ab478ab35a36', '20000021', '/Uploads/Picture/20160404/040222f193e87726.jpg', '/Uploads/Picture/20160404/s_040222f193e87726.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('c1322817a9cca14af33912f86da352be', '20000000', '/Uploads/Picture/20160317/a5aeb71653f9954f.jpg', '/Uploads/Picture/20160317/s_a5aeb71653f9954f.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('c14d682a7a221f72dec5a6d65f8903ec', '20000075', '/Uploads/Picture/20160721/20c90bba4f67e16c.jpg', '/Uploads/Picture/20160721/s_20c90bba4f67e16c.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('c28add8d00f651f93d126f2d19538427', '20000213', '/Uploads/Picture/20161120/fb204edfc7e00a2b.jpeg', '/Uploads/Picture/20161120/s_fb204edfc7e00a2b.jpeg', 'head');
INSERT INTO `tc_user_head` VALUES ('c58d072a400bf925268f4cf8b5cd31fa', '20000157', '/Uploads/Picture/20161008/e2052afb6e6fc8ad.jpg', '/Uploads/Picture/20161008/s_e2052afb6e6fc8ad.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('c7c6d54c9e7bd6928169304a1314a22e', '20000067', '/Uploads/Picture/20160706/d7257b9ad3332455.jpg', '/Uploads/Picture/20160706/s_d7257b9ad3332455.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('c7cf8289af5e21cf9c629a2b8294ce2e', '20000182', '/Uploads/Picture/20161021/2d670db34ecfcd61.jpeg', '/Uploads/Picture/20161021/s_2d670db34ecfcd61.jpeg', 'head');
INSERT INTO `tc_user_head` VALUES ('c8ff95ec26afe0183116314f61752ae3', '20000110', '/Uploads/Picture/20160904/845fbc9c1af59d45.jpg', '/Uploads/Picture/20160904/s_845fbc9c1af59d45.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('c91f00acf2825d29a5a25d0da918a3e0', '20000187', '/Uploads/Picture/20161026/863e11d8a5cc5ba2.jpg', '/Uploads/Picture/20161026/s_863e11d8a5cc5ba2.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('cb2c64e13403c10332c7509b8e87fc31', '20000217', '/Uploads/Picture/20161203/d6b1abb959ed3411.png', '/Uploads/Picture/20161203/s_d6b1abb959ed3411.png', 'head');
INSERT INTO `tc_user_head` VALUES ('cb81c08d9d2670df332fdd5adf6fa311', '20000200', '/Uploads/Picture/20161109/883ef98d344e0cbd.jpg', '/Uploads/Picture/20161109/s_883ef98d344e0cbd.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('cb87c62554a2876f374b9cbddcb7836a', '20000002', '/Uploads/Picture/20160319/3158ac11e10ed6de.jpg', '/Uploads/Picture/20160319/s_3158ac11e10ed6de.jpg', 'image2');
INSERT INTO `tc_user_head` VALUES ('cd06206673b005ae9de50a76b8ab051a', '20000176', '/Uploads/Picture/20161019/d26b47dc46b1e43d.jpg', '/Uploads/Picture/20161019/s_d26b47dc46b1e43d.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('ce70188740635b2f53e41094d73bb58f', '20000080', '/Uploads/Picture/20160730/39c80ddf315eddb8.jpg', '/Uploads/Picture/20160730/s_39c80ddf315eddb8.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('cf227c30295b4f749e7e04eed9455c38', '20000245', '/Uploads/Picture/20170110/66d5f26475ed1b7b.jpg', '/Uploads/Picture/20170110/s_66d5f26475ed1b7b.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('cf32410899f232268fb3c03f2bc06fe8', '20000124', '/Uploads/Picture/20160925/a80253e9a2855ff6.jpg', '/Uploads/Picture/20160925/s_a80253e9a2855ff6.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('cfb675ca8aa8debe8462300abcf8099f', '20000010', '/Uploads/Picture/20160523/48aa3831356c7368.png', '/Uploads/Picture/20160523/s_48aa3831356c7368.png', 'image');
INSERT INTO `tc_user_head` VALUES ('d12b731031bfb1982fa5d9fcdaad23c0', '20000144', '/Uploads/Picture/20161004/878affba7d5a5316.jpg', '/Uploads/Picture/20161004/s_878affba7d5a5316.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('d1e0ed848e7f5c25ab33d97e6d8b8a8b', '20000244', '/Uploads/Picture/20170106/7455231c33540d54.jpg', '/Uploads/Picture/20170106/s_7455231c33540d54.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('d24cf955d217305c6e138095483eba90', '20000059', '/Uploads/Picture/20160627/8fac8b7afbc38a7a.jpeg', '/Uploads/Picture/20160627/s_8fac8b7afbc38a7a.jpeg', 'image1');
INSERT INTO `tc_user_head` VALUES ('d2e213af72ac63c613bd0dbb27bfc7bd', '20000047', '/Uploads/Picture/20160616/c99b575bac97da8f.jpg', '/Uploads/Picture/20160616/s_c99b575bac97da8f.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('d3516181970fbf0ba6fc9871403c1c27', '20000262', '/Uploads/Picture/20170207/c6399a84e23f3945.jpg', '/Uploads/Picture/20170207/s_c6399a84e23f3945.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('d39d13ee41355c86fb1e0592500fb741', '20000017', '/Uploads/Picture/20160428/4f012674b778f7a1.jpg', '/Uploads/Picture/20160428/s_4f012674b778f7a1.jpg', 'image1');
INSERT INTO `tc_user_head` VALUES ('d4b3bc19cae58f5d99a4cd200e443d81', '20000026', '/Uploads/Picture/20160505/06a4ce61f46f1103.jpg', '/Uploads/Picture/20160505/s_06a4ce61f46f1103.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('d6a23528088630b4560e7affb7e37f80', '20000277', '/Uploads/Picture/20170223/fd55a22f413e8626.jpg', '/Uploads/Picture/20170223/s_fd55a22f413e8626.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('d72d28e2732178cc89b0c373cabcd1e3', '20000276', '/Uploads/Picture/20170220/742c926546c5c05f.jpg', '/Uploads/Picture/20170220/s_742c926546c5c05f.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('d99d52e0ad193a7689fd2b00087d3486', '20000193', '/Uploads/Picture/20161101/be92fe64ea961c55.jpg', '/Uploads/Picture/20161101/s_be92fe64ea961c55.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('da20a3877b7a75234a23409450a004f0', '20000291', '/Uploads/Picture/20170302/8e128cf85ffdedc6.jpg', '/Uploads/Picture/20170302/s_8e128cf85ffdedc6.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('da670a7d661695e63faccb6057889c4e', '20000056', '/Uploads/Picture/20160624/2a2a97ea533ad41b.png', '/Uploads/Picture/20160624/s_2a2a97ea533ad41b.png', 'images');
INSERT INTO `tc_user_head` VALUES ('db92a53e0d964f7c5fc490562caae990', '20000027', '/Uploads/Picture/20160506/15230af2c063c689.jpg', '/Uploads/Picture/20160506/s_15230af2c063c689.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('dc0feedf1cd49c6bd6de14a7fb330763', '20000025', '/Uploads/Picture/20160429/2d16ed2a55304289.png', '/Uploads/Picture/20160429/s_2d16ed2a55304289.png', 'images');
INSERT INTO `tc_user_head` VALUES ('de79eab0adbac09b1433780bf612c777', '20000174', '/Uploads/Picture/20161019/964edd2cc400684d.jpg', '/Uploads/Picture/20161019/s_964edd2cc400684d.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('dea5f97700e4045addde56d43d1f25f8', '20000287', '/Uploads/Picture/20170227/35576efd810df34e.jpg', '/Uploads/Picture/20170227/s_35576efd810df34e.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('e28e20bcfc33a7dea1d9169a5082febd', '20000035', '/Uploads/Picture/20160609/011e0d79ae0e521b.jpg', '/Uploads/Picture/20160609/s_011e0d79ae0e521b.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('e28e9e65a55122db04bf77d865b038ad', '20000150', '/Uploads/Picture/20161005/3253c94e33d615e5.jpg', '/Uploads/Picture/20161005/s_3253c94e33d615e5.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('e3e2cb51bb2fc5dec0099a765ee3df47', '20000279', '/Uploads/Picture/20170224/346969172c39b864.jpg', '/Uploads/Picture/20170224/s_346969172c39b864.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('e45cfd52a28627c9898d5b1054759d91', '20000031', '/Uploads/Picture/20160603/5e77ac9929293df1.jpg', '/Uploads/Picture/20160603/s_5e77ac9929293df1.jpg', 'image1');
INSERT INTO `tc_user_head` VALUES ('e625e9d2ee5adb065c8b92fe498cdad1', '20000285', '/Uploads/Picture/20170226/f75177f90d20659f.png', '/Uploads/Picture/20170226/s_f75177f90d20659f.png', 'head');
INSERT INTO `tc_user_head` VALUES ('eac9a6e7130dcf9571919a71496a6b48', '20000303', '/Uploads/Picture/20170315/195132a6bf1c0d8e.jpg', '/Uploads/Picture/20170315/s_195132a6bf1c0d8e.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('ebf55a80070d8befd89409863a0e0445', '20000029', '/Uploads/Picture/20160527/43396e5e801630b4.jpg', '/Uploads/Picture/20160527/s_43396e5e801630b4.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('ecb4dabbfc96b21e6145ceb33346907b', '20000268', '/Uploads/Picture/20170214/a92a30a187872674.jpg', '/Uploads/Picture/20170214/s_a92a30a187872674.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('edfebed9dde9390fd324fa02926c7dcb', '20000130', '/Uploads/Picture/20160929/1ee392e290b3004b.jpg', '/Uploads/Picture/20160929/s_1ee392e290b3004b.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('ee138fd86b0a4b9391ca5c641397839e', '20000290', '/Uploads/Picture/20170301/519800af2bf0cfab.jpg', '/Uploads/Picture/20170301/s_519800af2bf0cfab.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('eed78ab2acc16cea023cb763e5d4731f', '20000165', '/Uploads/Picture/20161014/d306d596b385cac6.jpg', '/Uploads/Picture/20161014/s_d306d596b385cac6.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('efddfe94a27c71a68b51b15395add0aa', '20000133', '/Uploads/Picture/20160930/7626e8c52cc2ee64.jpg', '/Uploads/Picture/20160930/s_7626e8c52cc2ee64.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('f0de9cda876390eb220d74d5e8b746d7', '20000311', '/Uploads/Picture/20170322/79c34540dd80eca7.jpg', '/Uploads/Picture/20170322/s_79c34540dd80eca7.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('f1c1f71fd677e1134676959a10614c26', '20000023', '/Uploads/Picture/20160425/d61a47c9a8ab5937.jpg', '/Uploads/Picture/20160425/s_d61a47c9a8ab5937.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('f22e384ea69645799c996d169bf67a15', '20000018', '/Uploads/Picture/20160331/267a1b5a98fa1032.png', '/Uploads/Picture/20160331/s_267a1b5a98fa1032.png', 'head');
INSERT INTO `tc_user_head` VALUES ('f2d2c8c2433ade1262370e01b3f80b4e', '20000032', '/Uploads/Picture/20160604/5bcabd493569a33d.jpg', '/Uploads/Picture/20160604/s_5bcabd493569a33d.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('f310f4cecfb07fa853220d026f48be53', '20000231', '/Uploads/Picture/20161213/6bf34a59e82098f0.jpg', '/Uploads/Picture/20161213/s_6bf34a59e82098f0.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('f318bdba8ab8631e95f0a5d935283fd4', '20000122', '/Uploads/Picture/20160922/70ec2ee83aa01d02.jpeg', '/Uploads/Picture/20160922/s_70ec2ee83aa01d02.jpeg', 'head');
INSERT INTO `tc_user_head` VALUES ('f358aaefae1d5890cc44233598d718e5', '20000163', '/Uploads/Picture/20161013/353e3bb091a82867.jpg', '/Uploads/Picture/20161013/s_353e3bb091a82867.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('f416d3b16a2b6b260f1f3a0e7ebc1e2a', '20000188', '/Uploads/Picture/20161028/11e44aad98f17966.jpg', '/Uploads/Picture/20161028/s_11e44aad98f17966.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('f44bb97068c7d13c7bd6ab367acfa5d2', '20000077', '/Uploads/Picture/20160725/f9ba848a5d36b978.png', '/Uploads/Picture/20160725/s_f9ba848a5d36b978.png', 'head');
INSERT INTO `tc_user_head` VALUES ('f49a6d9bf330f7bd94c999f6a2daaa32', '20000052', '/Uploads/Picture/20160619/91b06cdd9dc95e47.jpg', '/Uploads/Picture/20160619/s_91b06cdd9dc95e47.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('f5046da771cdf7e98d35fac5f7fcf450', '20000087', '/Uploads/Picture/20160809/af89c3081402cd5a.jpg', '/Uploads/Picture/20160809/s_af89c3081402cd5a.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('f7397a1ad4f4d465592d04be10f7be10', '20000314', '/Uploads/Picture/20170323/507b280d0955e992.jpg', '/Uploads/Picture/20170323/s_507b280d0955e992.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('f760fd07e725bb4761f2175b8c8a9231', '20000258', '/Uploads/Picture/20170130/ad4e8fce259a00d0.jpg', '/Uploads/Picture/20170130/s_ad4e8fce259a00d0.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('fb2c703981147105c3da3dbf06a0ff21', '20000093', '/Uploads/Picture/20160815/3ec9829679bb9934.jpg', '/Uploads/Picture/20160815/s_3ec9829679bb9934.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('fb9fd0f69ff1a3b4cb11bff394aea442', '20000147', '/Uploads/Picture/20161005/a33ee8946fece72f.png', '/Uploads/Picture/20161005/s_a33ee8946fece72f.png', 'head');
INSERT INTO `tc_user_head` VALUES ('fbce3e27356dea93bccd6d5c62c42ac8', '20000036', '/Uploads/Picture/20160610/0c3ba1ef0dffc25a.jpeg', '/Uploads/Picture/20160610/s_0c3ba1ef0dffc25a.jpeg', 'head');
INSERT INTO `tc_user_head` VALUES ('fc50156558d0e3b6c5a7293223c272c7', '20000160', '/Uploads/Picture/20161013/15c66a46b49b12d9.jpg', '/Uploads/Picture/20161013/s_15c66a46b49b12d9.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('fc803c17397b20ccdede343055dd8fc7', '20000112', '/Uploads/Picture/20160907/537e064ad42dee9d.jpg', '/Uploads/Picture/20160907/s_537e064ad42dee9d.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('fde781b12a2e8cb00eec7455baaf9785', '20000232', '/Uploads/Picture/20161213/812ab025fcaf750c.jpg', '/Uploads/Picture/20161213/s_812ab025fcaf750c.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('fe36e940a60dba2550e3297542429b69', '20000305', '/Uploads/Picture/20170316/93929942bccad10a.jpg', '/Uploads/Picture/20170316/s_93929942bccad10a.jpg', 'head');
INSERT INTO `tc_user_head` VALUES ('fe7b6f3e837f4ec370773579a2863c34', '20000256', '/Uploads/Picture/20170122/882ad2b88c4d6ac0.jpeg', '/Uploads/Picture/20170122/s_882ad2b88c4d6ac0.jpeg', 'head');
INSERT INTO `tc_user_head` VALUES ('ffdf95ca1bbee06f97ab9f8d5c4078b3', '20000295', '/Uploads/Picture/20170306/c8d33b329c064cc0.jpg', '/Uploads/Picture/20170306/s_c8d33b329c064cc0.jpg', 'head');

-- ----------------------------
-- Table structure for `tc_user_member`
-- ----------------------------
DROP TABLE IF EXISTS `tc_user_member`;
CREATE TABLE `tc_user_member` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL DEFAULT '' COMMENT '会员名称',
  `userimage` tinyint(1) NOT NULL DEFAULT '0' COMMENT '个人资料主图 0-不可改 1-可改',
  `headcount` int(11) NOT NULL DEFAULT '0' COMMENT '头像张数',
  `groupimage` tinyint(1) NOT NULL DEFAULT '0' COMMENT '号主图 0-不可 1-可以',
  `groupheadcount` int(11) NOT NULL DEFAULT '0' COMMENT '群头像数量',
  `groupcount` int(11) NOT NULL DEFAULT '0' COMMENT '可建群数量',
  `groupshow` tinyint(1) NOT NULL DEFAULT '0' COMMENT '群位置信息 0-不显示 1-显示',
  `messagecount` int(11) NOT NULL DEFAULT '0' COMMENT '每天可发布的信息数量',
  `isvisible` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0-当地 1-全省 2-全国',
  `logo` varchar(128) NOT NULL DEFAULT '' COMMENT '会员标识',
  `namecolor` varchar(50) NOT NULL DEFAULT '' COMMENT '昵称颜色',
  `monthfee` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '会费/月',
  `goods_count` int(11) NOT NULL DEFAULT '0',
  `goods_img_count` int(11) NOT NULL DEFAULT '0',
  `activity_count` int(11) NOT NULL DEFAULT '0',
  `source_count` int(11) NOT NULL DEFAULT '0',
  `activity_img_count` int(11) NOT NULL DEFAULT '0',
  `source_img_count` int(11) NOT NULL DEFAULT '0',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0-非会员 1-会员',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='会员列表';

-- ----------------------------
-- Records of tc_user_member
-- ----------------------------
INSERT INTO `tc_user_member` VALUES ('1', '非会员', '0', '1', '0', '1', '1', '0', '3', '0', '', '黑', '0.00', '2', '3', '1', '1', '3', '3', '0');
INSERT INTO `tc_user_member` VALUES ('2', '一般会员', '1', '3', '1', '2', '2', '1', '5', '0', '/Uploads/Lv/lv1.png', '绿', '2.50', '8', '4', '3', '3', '4', '4', '1');
INSERT INTO `tc_user_member` VALUES ('3', '中级会员', '1', '5', '1', '3', '3', '1', '7', '1', '/Uploads/Lv/lv2.png', '蓝', '5.00', '16', '5', '5', '5', '5', '5', '1');
INSERT INTO `tc_user_member` VALUES ('4', '高级会员', '1', '7', '1', '4', '4', '1', '9', '2', '/Uploads/Lv/lv3.png', '红', '8.00', '30', '6', '7', '7', '6', '6', '1');

-- ----------------------------
-- Table structure for `tc_user_member_time`
-- ----------------------------
DROP TABLE IF EXISTS `tc_user_member_time`;
CREATE TABLE `tc_user_member_time` (
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT '用户Id',
  `time` int(11) NOT NULL DEFAULT '0' COMMENT '到期时间',
  `memberid` int(11) NOT NULL DEFAULT '0' COMMENT '会员类型id',
  UNIQUE KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员列表';

-- ----------------------------
-- Records of tc_user_member_time
-- ----------------------------
INSERT INTO `tc_user_member_time` VALUES ('20000000', '1490253544', '4');
INSERT INTO `tc_user_member_time` VALUES ('20000002', '1489846339', '4');
INSERT INTO `tc_user_member_time` VALUES ('20000017', '2147483647', '4');
INSERT INTO `tc_user_member_time` VALUES ('20000025', '1499261466', '2');
INSERT INTO `tc_user_member_time` VALUES ('20000115', '1499261466', '2');
INSERT INTO `tc_user_member_time` VALUES ('20000313', '1521879661', '4');
INSERT INTO `tc_user_member_time` VALUES ('20000315', '2147483647', '3');
INSERT INTO `tc_user_member_time` VALUES ('20000316', '1521862415', '3');
INSERT INTO `tc_user_member_time` VALUES ('20000317', '1522146345', '4');

-- ----------------------------
-- Table structure for `tc_user_push`
-- ----------------------------
DROP TABLE IF EXISTS `tc_user_push`;
CREATE TABLE `tc_user_push` (
  `uid` varchar(50) NOT NULL COMMENT '用户',
  `udid` varchar(100) NOT NULL COMMENT '设备号',
  `bnotice` tinyint(1) NOT NULL DEFAULT '1' COMMENT '0-不接收 1-接收',
  KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户ios消息推送表';

-- ----------------------------
-- Records of tc_user_push
-- ----------------------------
INSERT INTO `tc_user_push` VALUES ('20000024', '3935c8a3784c991c3a45a42f90e7aa5280f4075059928d6a4db1cfe6faad9aae', '1');
INSERT INTO `tc_user_push` VALUES ('20000051', '3f1732cd7c4ca61bb4f415fa466a3f87afe140c3c9a59ff4d90eb0ff6284b7ca', '1');
INSERT INTO `tc_user_push` VALUES ('20000054', 'bef33789d7eafeb02faf84ede2c9af907fbaeb2544a223b65fe94a49e6ba45a2', '1');
INSERT INTO `tc_user_push` VALUES ('20000056', '0dc0e94b04f9c9d43b37cb327d973d6040a27a2be8ce32052e8c1dcf328d8d9b', '1');
INSERT INTO `tc_user_push` VALUES ('20000010', 'e08d9113e2b98b7cb9cb458b3040ecd2d3b69d18190539753c00a8c657fdb743', '1');
INSERT INTO `tc_user_push` VALUES ('20000090', 'ad4e738fd8d9a981227a27d76680c6b90fe2bb95c5effe58c96de67daaff4f0d', '1');
INSERT INTO `tc_user_push` VALUES ('20000168', '53a7ad904630315fc1d0ded549516eda21c41219e6bcf0ffeebe3c32792cd5ac', '1');
INSERT INTO `tc_user_push` VALUES ('20000017', '37735be0d2eb45881740372ecb475d0db0d2241387383d8ad6d52bcaf2ead449', '1');
INSERT INTO `tc_user_push` VALUES ('20000107', 'ae7b1e8304472d4e603d56ff849863e77e02a94d49f2da7a8548c7ab5c88dab7', '1');
INSERT INTO `tc_user_push` VALUES ('20000025', '1c8bf1a564be99cc98907920062610ffeab9754176e4313c19350f1480c79c8d', '1');
INSERT INTO `tc_user_push` VALUES ('20000206', '7475754637a489d6eb52f4cf67e9f3b8afe2edf6e5b52de1f9ab3d06fb6d7d9c', '1');
INSERT INTO `tc_user_push` VALUES ('20000216', '5964ddfd47e22d62b598c2bc5a8d3590f302834238286d0ce19e0d4587741e83', '1');
INSERT INTO `tc_user_push` VALUES ('20000001', 'f2903a4010ba0073bb3844d52b26750cbfef8b7b3e538fee12fce34eb253afe8', '1');
INSERT INTO `tc_user_push` VALUES ('20000115', '7f815db5ef2ab14f9a599291bbf55b5968b31f9a83b70e9fe508b804be75d3af', '1');
INSERT INTO `tc_user_push` VALUES ('20000264', '321094320d4968ca6a8fb5c95f088903e367e7fa8e5bd42ae51df7ab2214b545', '1');
INSERT INTO `tc_user_push` VALUES ('20000271', 'be35edada319439003638092e0c14657f8a253d20c74a5944108897b6a7a5111', '1');
INSERT INTO `tc_user_push` VALUES ('20000000', '24a798c1e3eafe433440fc0a3a32a885a13f021dea47aed601bfa3728c023deb', '1');
INSERT INTO `tc_user_push` VALUES ('20000309', '5ff456c515feed92d84b15cd3c6d7cc4506e6f402baf538f46baf22e0a31df1e', '1');
INSERT INTO `tc_user_push` VALUES ('20000263', '2b8a497244226fea0556ba326545896be1e016d7022661974361148a1e5628b9', '1');
INSERT INTO `tc_user_push` VALUES ('20000312', '4f6a87ca44a435a74d017b0852601f7647d78cc5027902c8667a6ee256e72a0f', '1');
INSERT INTO `tc_user_push` VALUES ('20000314', '5154dad857cec82377d0f573ac3a8e650d0ff035056b41cc844df2053f4d6e30', '1');
INSERT INTO `tc_user_push` VALUES ('20000315', '51cec87f79d29f19dc3af411e2b81cf74c6cb117b8dbaac54fd52ad503bfa582', '1');
INSERT INTO `tc_user_push` VALUES ('20000313', '2851556061be3dee16086013b364bd04bfcb9adfa13baca2321db62ec618bd04', '1');

-- ----------------------------
-- Table structure for `tc_user_recharge`
-- ----------------------------
DROP TABLE IF EXISTS `tc_user_recharge`;
CREATE TABLE `tc_user_recharge` (
  `id` varchar(32) NOT NULL,
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT '用户',
  `fee` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '价格',
  `createtime` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0-写入表 1-充值成功',
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户充值';

-- ----------------------------
-- Records of tc_user_recharge
-- ----------------------------
INSERT INTO `tc_user_recharge` VALUES ('2016031810049101', '20000002', '60.00', '1458310317', '1');
INSERT INTO `tc_user_recharge` VALUES ('2016031856495450', '20000002', '100.00', '1458310280', '1');
INSERT INTO `tc_user_recharge` VALUES ('2016032154564857', '20000000', '100.00', '1458558358', '0');
INSERT INTO `tc_user_recharge` VALUES ('2016041510152491', '20000022', '3.00', '1460726430', '0');
INSERT INTO `tc_user_recharge` VALUES ('2016051953501001', '20000000', '3.00', '1463627237', '0');
INSERT INTO `tc_user_recharge` VALUES ('2016070510157539', '20000025', '30.00', '1467725390', '1');
INSERT INTO `tc_user_recharge` VALUES ('2016070549539810', '20000025', '3.00', '1467711697', '0');
INSERT INTO `tc_user_recharge` VALUES ('2016070551101100', '20000025', '6.00', '1467725443', '1');
INSERT INTO `tc_user_recharge` VALUES ('2016072310256100', '20000010', '3.00', '1469262495', '0');
INSERT INTO `tc_user_recharge` VALUES ('2016081110298999', '20000017', '3.00', '1470898351', '0');
INSERT INTO `tc_user_recharge` VALUES ('2016081153541025', '20000090', '3.00', '1470886565', '0');
INSERT INTO `tc_user_recharge` VALUES ('2016081153561019', '20000026', '3.00', '1470928629', '0');
INSERT INTO `tc_user_recharge` VALUES ('2016081155564850', '20000026', '3.00', '1470928295', '0');
INSERT INTO `tc_user_recharge` VALUES ('2016081157995210', '20000026', '3.00', '1470928393', '0');
INSERT INTO `tc_user_recharge` VALUES ('2016081199575797', '20000026', '3.00', '1470928284', '0');
INSERT INTO `tc_user_recharge` VALUES ('2016082157501021', '20000096', '3.00', '1471769881', '0');
INSERT INTO `tc_user_recharge` VALUES ('2016082310049519', '20000096', '3.00', '1471923549', '0');
INSERT INTO `tc_user_recharge` VALUES ('2016091948100515', '20000096', '3.00', '1474269488', '0');
INSERT INTO `tc_user_recharge` VALUES ('2016091953102481', '20000096', '3.00', '1474269493', '0');
INSERT INTO `tc_user_recharge` VALUES ('2016091997485010', '20000096', '6.00', '1474269498', '0');
INSERT INTO `tc_user_recharge` VALUES ('2016092055984854', '20000115', '3.00', '1474353719', '0');
INSERT INTO `tc_user_recharge` VALUES ('2016092099551015', '20000115', '3.00', '1474353740', '0');
INSERT INTO `tc_user_recharge` VALUES ('2016092155989949', '20000096', '100.00', '1474422039', '0');
INSERT INTO `tc_user_recharge` VALUES ('2016092910010249', '20000131', '100.00', '1475162621', '0');
INSERT INTO `tc_user_recharge` VALUES ('2016092910048565', '20000131', '100.00', '1475162557', '0');
INSERT INTO `tc_user_recharge` VALUES ('2016092910253102', '20000131', '1.00', '1475162527', '0');
INSERT INTO `tc_user_recharge` VALUES ('2016092950535757', '20000131', '100.00', '1475162546', '0');
INSERT INTO `tc_user_recharge` VALUES ('2016092951521025', '20000131', '100.00', '1475162563', '0');
INSERT INTO `tc_user_recharge` VALUES ('2016092951575651', '20000131', '100.00', '1475162579', '0');
INSERT INTO `tc_user_recharge` VALUES ('2016092952555710', '20000131', '100.00', '1475162532', '0');
INSERT INTO `tc_user_recharge` VALUES ('2016092956101505', '20000131', '100.00', '1475162536', '0');
INSERT INTO `tc_user_recharge` VALUES ('2016100899529710', '20000096', '3.00', '1475922636', '0');
INSERT INTO `tc_user_recharge` VALUES ('2016100910257544', '20000096', '26.00', '1476005551', '0');
INSERT INTO `tc_user_recharge` VALUES ('2016100910298521', '20000096', '18.00', '1476007519', '0');
INSERT INTO `tc_user_recharge` VALUES ('2016100951100100', '20000096', '18.00', '1476007107', '0');
INSERT INTO `tc_user_recharge` VALUES ('2016100953995110', '20000096', '18.00', '1476007237', '0');
INSERT INTO `tc_user_recharge` VALUES ('2016100954995397', '20000096', '3.00', '1475999846', '0');
INSERT INTO `tc_user_recharge` VALUES ('2016100955549710', '20000096', '3.00', '1475987127', '0');
INSERT INTO `tc_user_recharge` VALUES ('2016100955975452', '20000096', '3.00', '1475976871', '0');
INSERT INTO `tc_user_recharge` VALUES ('2016100956509998', '20000096', '10.00', '1476007784', '0');
INSERT INTO `tc_user_recharge` VALUES ('2016100956529749', '20000096', '26.00', '1476005480', '0');
INSERT INTO `tc_user_recharge` VALUES ('2016100997544810', '20000096', '10.00', '1476007690', '0');
INSERT INTO `tc_user_recharge` VALUES ('2016100998495798', '20000096', '18.00', '1476008811', '0');
INSERT INTO `tc_user_recharge` VALUES ('2016101049569752', '20000096', '10.00', '1476072305', '0');
INSERT INTO `tc_user_recharge` VALUES ('2016101052514953', '20000096', '10.00', '1476072164', '0');
INSERT INTO `tc_user_recharge` VALUES ('2016101055569810', '20000096', '8.00', '1476072615', '0');
INSERT INTO `tc_user_recharge` VALUES ('2016101057494848', '20000096', '8.00', '1476070361', '0');
INSERT INTO `tc_user_recharge` VALUES ('2016101099100985', '20000096', '10.00', '1476070332', '0');
INSERT INTO `tc_user_recharge` VALUES ('2016101099494951', '20000096', '10.00', '1476063708', '0');
INSERT INTO `tc_user_recharge` VALUES ('2016101248535610', '20000001', '14.00', '1476263264', '0');
INSERT INTO `tc_user_recharge` VALUES ('2016101256484999', '20000096', '14.00', '1476237031', '0');
INSERT INTO `tc_user_recharge` VALUES ('2016101410055971', '20000096', '1.00', '1476439917', '0');
INSERT INTO `tc_user_recharge` VALUES ('2016101448571015', '20000096', '1.00', '1476440128', '0');
INSERT INTO `tc_user_recharge` VALUES ('2016101450975752', '20000096', '1.00', '1476440034', '0');
INSERT INTO `tc_user_recharge` VALUES ('2016101453971025', '20000096', '1.00', '1476440629', '0');
INSERT INTO `tc_user_recharge` VALUES ('2016101497535457', '20000096', '1.00', '1476440554', '0');
INSERT INTO `tc_user_recharge` VALUES ('2016101498971025', '20000096', '3.00', '1476435339', '0');
INSERT INTO `tc_user_recharge` VALUES ('2016101499101531', '20000096', '3.00', '1476436988', '0');
INSERT INTO `tc_user_recharge` VALUES ('2016101499559710', '20000096', '0.01', '1476439244', '0');
INSERT INTO `tc_user_recharge` VALUES ('2016101552549848', '20000096', '1.00', '1476511892', '0');
INSERT INTO `tc_user_recharge` VALUES ('2016101553985110', '20000096', '444.00', '1476525285', '0');
INSERT INTO `tc_user_recharge` VALUES ('2016101556994910', '20000096', '1.00', '1476511800', '0');
INSERT INTO `tc_user_recharge` VALUES ('2016101597100509', '20000096', '1.00', '1476511850', '0');
INSERT INTO `tc_user_recharge` VALUES ('2016102751534910', '20000025', '3.00', '1477552067', '0');
INSERT INTO `tc_user_recharge` VALUES ('2016102752995355', '20000002', '3.00', '1477551780', '0');
INSERT INTO `tc_user_recharge` VALUES ('2016102753101561', '20000025', '3.00', '1477557685', '1');
INSERT INTO `tc_user_recharge` VALUES ('2016102754529810', '20000017', '3.00', '1477550934', '0');
INSERT INTO `tc_user_recharge` VALUES ('2016102757505010', '20000017', '3.00', '1477557609', '0');
INSERT INTO `tc_user_recharge` VALUES ('2016102797975048', '20000025', '3.00', '1477552378', '0');
INSERT INTO `tc_user_recharge` VALUES ('2016102798504910', '20000002', '3.00', '1477551899', '0');
INSERT INTO `tc_user_recharge` VALUES ('2016110448485054', '20000096', '3.00', '1478250000', '0');
INSERT INTO `tc_user_recharge` VALUES ('2016111899545648', '20000209', '3.00', '1479467164', '0');
INSERT INTO `tc_user_recharge` VALUES ('2016112157995454', '20000115', '3.00', '1479740745', '0');
INSERT INTO `tc_user_recharge` VALUES ('2016112210054102', '20000096', '100.00', '1479779981', '0');
INSERT INTO `tc_user_recharge` VALUES ('2016112852555210', '20000216', '3.00', '1480341940', '0');
INSERT INTO `tc_user_recharge` VALUES ('2017020910048579', '20000264', '3.00', '1486613917', '0');
INSERT INTO `tc_user_recharge` VALUES ('2017020957100571', '20000263', '3.00', '1486579593', '0');
INSERT INTO `tc_user_recharge` VALUES ('2017021353494997', '20000267', '3.00', '1486973317', '0');

-- ----------------------------
-- Table structure for `tc_version`
-- ----------------------------
DROP TABLE IF EXISTS `tc_version`;
CREATE TABLE `tc_version` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` varchar(16) NOT NULL,
  `description` text NOT NULL,
  `updatetype` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0-正常（用户可以暂不升级）,1—警告升级（用户可以暂不升级），2—强制升级，用户不升级退出软件',
  `url` varchar(255) NOT NULL DEFAULT '',
  `createtime` varchar(20) NOT NULL DEFAULT '',
  `type` varchar(10) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tc_version
-- ----------------------------

-- ----------------------------
-- Table structure for `tc_withdraw`
-- ----------------------------
DROP TABLE IF EXISTS `tc_withdraw`;
CREATE TABLE `tc_withdraw` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `price` varchar(20) NOT NULL,
  `account_name` varchar(10) NOT NULL,
  `account_number` varchar(50) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0.未审核，1.通过，2.不通过',
  `create_time` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tc_withdraw
-- ----------------------------
INSERT INTO `tc_withdraw` VALUES ('1', '20000315', '100.0', '八宝', '13700000000', '0', '1490337701');

-- ----------------------------
-- Function structure for `getDistance`
-- ----------------------------
DROP FUNCTION IF EXISTS `getDistance`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `getDistance`(
     lon1 float(10,7) 
    ,lat1 float(10,7)
    ,lon2 float(10,7) 
    ,lat2 float(10,7)
) RETURNS double
begin
    declare d double;
    declare radius int;
    set radius = 6378140; #假设地球为正球形，直径为6378140米
    set d = (2*ATAN2(SQRT(SIN((lat1-lat2)*PI()/180/2)   
        *SIN((lat1-lat2)*PI()/180/2)+   
        COS(lat2*PI()/180)*COS(lat1*PI()/180)   
        *SIN((lon1-lon2)*PI()/180/2)   
        *SIN((lon1-lon2)*PI()/180/2)),   
        SQRT(1-SIN((lat1-lat2)*PI()/180/2)   
        *SIN((lat1-lat2)*PI()/180/2)   
        +COS(lat2*PI()/180)*COS(lat1*PI()/180)   
        *SIN((lon1-lon2)*PI()/180/2)   
        *SIN((lon1-lon2)*PI()/180/2))))*radius;
    return d;
end
;;
DELIMITER ;
