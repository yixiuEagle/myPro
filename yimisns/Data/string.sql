use yimi;
DROP TABLE IF EXISTS `tc_service_category`;
CREATE TABLE IF NOT EXISTS `tc_service_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  `img` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;
INSERT INTO `tc_service_category` (`id`, `name`, `img`) VALUES
(1, '美食', '/Uploads/Picture/avatar/200009/s_7e2f7dbf8a1ed138d0376a43e1281c02.jpg'),
(2, '景点', '/Uploads/Picture/avatar/200009/s_7e2f7dbf8a1ed138d0376a43e1281c02.jpg'),
(3, '酒店', '/Uploads/Picture/avatar/200009/s_7e2f7dbf8a1ed138d0376a43e1281c02.jpg'),
(4, '超市', '/Uploads/Picture/avatar/200009/s_7e2f7dbf8a1ed138d0376a43e1281c02.jpg'),
(5, '厕所', '/Uploads/Picture/avatar/200009/s_7e2f7dbf8a1ed138d0376a43e1281c02.jpg'),
(6, '公交站', '/Uploads/Picture/avatar/200009/s_7e2f7dbf8a1ed138d0376a43e1281c02.jpg');