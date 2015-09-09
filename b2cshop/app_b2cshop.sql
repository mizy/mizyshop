-- phpMyAdmin SQL Dump
-- version 3.3.8.1
-- http://www.phpmyadmin.net
--
-- 主机: w.rdc.sae.sina.com.cn:3307
-- 生成日期: 2015 年 09 月 09 日 16:12
-- 服务器版本: 5.5.23
-- PHP 版本: 5.3.3

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- 数据库: `app_b2cshop`
--

-- --------------------------------------------------------

--
-- 表的结构 `mz_brand`
--

CREATE TABLE IF NOT EXISTS `mz_brand` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` text NOT NULL COMMENT 'brand名称',
  `order` int(11) NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- 转存表中的数据 `mz_brand`
--

INSERT INTO `mz_brand` (`id`, `title`, `order`, `create_time`) VALUES
(1, 'J.Crew', 1, '2014-10-07 20:48:21'),
(2, 'Uniqlo', 2, '2014-10-08 16:12:21'),
(3, 'Zara', 3, '2014-11-14 14:47:16'),
(4, 'Prada', 4, '2014-11-14 14:49:12');

-- --------------------------------------------------------

--
-- 表的结构 `mz_buynow`
--

CREATE TABLE IF NOT EXISTS `mz_buynow` (
  `user` int(11) NOT NULL COMMENT '用户id',
  `chima` text NOT NULL COMMENT '尺码或者类别',
  `color` text NOT NULL,
  `item` int(11) NOT NULL,
  `num` int(11) NOT NULL,
  PRIMARY KEY (`user`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `mz_buynow`
--

INSERT INTO `mz_buynow` (`user`, `chima`, `color`, `item`, `num`) VALUES
(13, '服务1', '', 6, 1);

-- --------------------------------------------------------

--
-- 表的结构 `mz_cart`
--

CREATE TABLE IF NOT EXISTS `mz_cart` (
  `item` int(16) NOT NULL,
  `user` int(16) NOT NULL,
  `id` int(32) NOT NULL AUTO_INCREMENT,
  `num` int(8) NOT NULL,
  `color` text NOT NULL,
  `chima` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=16 ;

--
-- 转存表中的数据 `mz_cart`
--


-- --------------------------------------------------------

--
-- 表的结构 `mz_class`
--

CREATE TABLE IF NOT EXISTS `mz_class` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `title` text NOT NULL,
  `father` int(11) NOT NULL DEFAULT '0',
  `num` int(12) NOT NULL DEFAULT '0',
  `order` int(6) NOT NULL DEFAULT '0',
  `layer` int(2) NOT NULL DEFAULT '1',
  `desc` text NOT NULL COMMENT '描述',
  `hot` int(1) NOT NULL DEFAULT '0',
  `module` int(5) NOT NULL COMMENT '类型｛搭配，单品｝',
  `alias` text NOT NULL COMMENT '别名',
  PRIMARY KEY (`id`),
  KEY `order` (`order`),
  KEY `father` (`father`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='类目表' AUTO_INCREMENT=40 ;

--
-- 转存表中的数据 `mz_class`
--

INSERT INTO `mz_class` (`id`, `title`, `father`, `num`, `order`, `layer`, `desc`, `hot`, `module`, `alias`) VALUES
(0, '导航栏', -1, 2, -1, 0, '', 0, 0, ''),
(18, '健康生活', 0, 0, 18, 1, '模范行装', 1, 0, '模范行装'),
(13, '配件', 12, 0, 1, 2, '配件', 0, 0, ''),
(15, '美丽也是技术活', 0, 0, 15, 1, '单品', 1, 0, '必备经典'),
(16, '朝九晚五', 10, 0, 1, 2, '', 0, 0, ''),
(17, '假日', 10, 0, 2, 2, '', 0, 0, ''),
(25, '潮流生活方式', 0, 0, 25, 1, '都市女战士潮流', 1, 0, '都市女战士潮流'),
(28, '休闲生活', 0, 0, 20, 1, '风格推荐', 1, 0, '风格永存'),
(38, '精油', 28, 0, 0, 2, 'none', 0, 0, 'spa'),
(39, '美女照我去运动', 0, 0, 20, 1, '运动', 0, 0, '运动');

-- --------------------------------------------------------

--
-- 表的结构 `mz_class_info`
--

CREATE TABLE IF NOT EXISTS `mz_class_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` text NOT NULL,
  `url` text NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `class` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `class` (`class`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=38 ;

--
-- 转存表中的数据 `mz_class_info`
--

INSERT INTO `mz_class_info` (`id`, `title`, `url`, `create_time`, `class`) VALUES
(3, '', 'http://b2cshop-img.stor.sinaapp.com/./class/20141022/54478836084a1.png', '2014-10-22 18:34:59', 10),
(26, '', 'http://b2cshop-img.stor.sinaapp.com/./class/20141115/546754bd13a6f.jpg', '2014-11-15 21:27:30', 18),
(33, '', 'http://b2cshop-img.stor.sinaapp.com/./class/20141115/5467592504316.jpg', '2014-11-15 21:46:39', 25),
(34, '', 'http://b2cshop-img.stor.sinaapp.com/./class/20141115/5467592f7090a.jpg', '2014-11-15 21:46:39', 25),
(32, '', 'http://b2cshop-img.stor.sinaapp.com/./class/20141115/5467591840533.jpg', '2014-11-15 21:46:39', 25),
(31, '', 'http://b2cshop-img.stor.sinaapp.com/./class/20141115/5467582ebf9c9.png', '2014-11-15 21:42:12', 15),
(30, '', 'http://b2cshop-img.stor.sinaapp.com/./class/20141115/546757f10d631.png', '2014-11-15 21:42:12', 15),
(29, '', 'http://b2cshop-img.stor.sinaapp.com/./class/20141115/54675818d3016.png', '2014-11-15 21:42:12', 15),
(25, '', 'http://b2cshop-img.stor.sinaapp.com/./class/20141115/546754add91c9.jpg', '2014-11-15 21:27:30', 18),
(28, '', 'http://b2cshop-img.stor.sinaapp.com/./class/20141115/5467559358eca.jpg', '2014-11-15 21:31:03', 18),
(37, '', 'http://b2cshop-img.stor.sinaapp.com/./class/20141115/54675995487f4.jpg', '2014-11-15 21:48:09', 28),
(36, '', 'http://b2cshop-img.stor.sinaapp.com/./class/20141115/5467598e19a89.jpg', '2014-11-15 21:48:09', 28),
(35, '', 'http://b2cshop-img.stor.sinaapp.com/./class/20141115/54675985024d1.jpg', '2014-11-15 21:48:09', 28);

-- --------------------------------------------------------

--
-- 表的结构 `mz_comments`
--

CREATE TABLE IF NOT EXISTS `mz_comments` (
  `id` int(32) NOT NULL AUTO_INCREMENT,
  `time` varchar(32) NOT NULL,
  `content` text NOT NULL,
  `user_id` int(16) NOT NULL,
  `item_id` int(16) NOT NULL,
  `last_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- 转存表中的数据 `mz_comments`
--


-- --------------------------------------------------------

--
-- 表的结构 `mz_designer`
--

CREATE TABLE IF NOT EXISTS `mz_designer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  `desc` text NOT NULL,
  `visit_times` int(11) NOT NULL DEFAULT '0',
  `zan` int(11) NOT NULL,
  `fuwu` text NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0',
  `zizhi` text NOT NULL,
  `address` text NOT NULL,
  `idCard` text NOT NULL,
  `zuoping` text NOT NULL,
  `phone` varchar(32) NOT NULL,
  `user` int(11) NOT NULL,
  `apply_status` int(11) NOT NULL DEFAULT '0' COMMENT '0:审核中 1:审核通过',
  `module` int(11) NOT NULL DEFAULT '1',
  `price` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=28 ;

--
-- 转存表中的数据 `mz_designer`
--

INSERT INTO `mz_designer` (`id`, `name`, `desc`, `visit_times`, `zan`, `fuwu`, `status`, `zizhi`, `address`, `idCard`, `zuoping`, `phone`, `user`, `apply_status`, `module`, `price`) VALUES
(22, '晓宇', '<p>我们是一群玩音乐的人，我们不喜欢刻板教条，根据你的意愿，定制属于你的教学计划</p>', 60, 0, '吉他_尤克里里_钢琴', 1, '111111111111111111', '北京朝阳酒仙桥', '111111111111111111', 'livehouse', '15210344759', 0, 1, 1, 150),
(26, '傅老师', '', 74, 0, '油画_美术作品鉴赏_西方艺术史', 1, '111111111111111111', '北京天通苑北三区', '111111111111111111', '北京傅大力画室', '15210344759', 0, 1, 1, 150),
(18, 'Aeterna', '<p>法语文学硕士、曾留学法国，在法语联盟工作，有丰富的教学经验。</p>', 82, 0, '法语', 1, '111111111111111111', '北京法语联盟', '111111111111111111', '法语文学硕士、曾留学法国，在法语联盟工作，有丰富的教学经验。', '15210344759', 0, 1, 1, 200),
(21, 'saxo', '<p>留法六年硕士毕业，认真负责，耐心讲解，因材施教，保证质量，教学经验丰富，尤其在免签辅导方面具备专门经验、并从事法语相关工作。</p>', 70, 0, '法语', 1, '111111111111111111111', '北京朝阳三里屯', '111111111111111111111', '留法六年硕士毕业，认真负责，耐心讲解，因材施教，保证质量，教学经验丰富，尤其在免签辅导方面具备专门经验、并从事法语相关工作。', '15210344759', 0, 1, 1, 180),
(27, 'Momo', '<p><span style="color: rgb(255, 255, 255); font-family: Helvetica, STHeiti; font-size: 12px; line-height: 18px; text-align: center; background-color: rgb(180, 218, 240);"><span id="_baidu_bookmark_start_1" style="display: none; line-height: 0px;">‍</span></span><span id="_baidu_bookmark_start_3" style="display: none; line-height: 0px;">‍</span>YA瑜伽联盟RYT200注册瑜伽师 美国YogaWorks200瑜伽教练<span id="_baidu_bookmark_end_4" style="display: none; line-height: 0px;">‍</span><span style="color: rgb(255, 255, 255); font-family: Helvetica, STHeiti; font-size: 12px; line-height: 18px; text-align: center; background-color: rgb(180, 218, 240);"><span id="_baidu_bookmark_end_2" style="display: none; line-height: 0px;">‍</span></span></p>', 70, 0, '瑜伽_', 1, '111111111111111111', '北京东城', '111111111111111111', 'YA瑜伽联盟RYT注册瑜伽师，yogaworks 200国际注册瑜伽师', '15210344759', 0, 1, 1, 200);

-- --------------------------------------------------------

--
-- 表的结构 `mz_designer_fuwu`
--

CREATE TABLE IF NOT EXISTS `mz_designer_fuwu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- 转存表中的数据 `mz_designer_fuwu`
--

INSERT INTO `mz_designer_fuwu` (`id`, `title`) VALUES
(1, '法语_钢琴_吉他_尤克里里_服装造型_妆发造型_美容顾问_瑜伽教练_芳疗师_护肤顾问_摄影师_油画_');

-- --------------------------------------------------------

--
-- 表的结构 `mz_designer_fuwu_info`
--

CREATE TABLE IF NOT EXISTS `mz_designer_fuwu_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fuwu` text NOT NULL,
  `designer` text NOT NULL,
  `price` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- 转存表中的数据 `mz_designer_fuwu_info`
--


-- --------------------------------------------------------

--
-- 表的结构 `mz_designer_info`
--

CREATE TABLE IF NOT EXISTS `mz_designer_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `designer` text NOT NULL,
  `url` text NOT NULL,
  `title` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=27 ;

--
-- 转存表中的数据 `mz_designer_info`
--

INSERT INTO `mz_designer_info` (`id`, `designer`, `url`, `title`) VALUES
(20, '22', 'http://b2cshop-img.stor.sinaapp.com/./class/20141225/549baeb5247a5.png', ''),
(19, '22', 'http://b2cshop-img.stor.sinaapp.com/./class/20141225/549bae95081dc.png', ''),
(16, '21', 'http://b2cshop-img.stor.sinaapp.com/./class/20141222/5497a0c12d939.png', ''),
(17, '21', 'http://b2cshop-img.stor.sinaapp.com/./class/20141222/5497a0cbc73c7.png', ''),
(18, '22', 'http://b2cshop-img.stor.sinaapp.com/./class/20141225/549bae6d45601.png', ''),
(15, '18', 'http://b2cshop-img.stor.sinaapp.com/./class/20141222/5497992e16be7.png', ''),
(14, '18', 'http://b2cshop-img.stor.sinaapp.com/./class/20141222/54979895f2aad.png', ''),
(9, '7', 'http://b2cshop-img.stor.sinaapp.com/./class/20141116/5468a05779202.jpg', 'l2'),
(10, '7', 'http://b2cshop-img.stor.sinaapp.com/./class/20141116/5468a05f9a542.jpg', '造型'),
(11, '7', 'http://b2cshop-img.stor.sinaapp.com/./class/20141116/5468a06e19e78.jpg', '造型2'),
(12, '7', 'http://b2cshop-img.stor.sinaapp.com/./class/20141116/5468a076519b5.jpg', '造型3'),
(21, '26', 'http://b2cshop-img.stor.sinaapp.com/./class/20141225/549bb2219b815.png', ''),
(22, '26', 'http://b2cshop-img.stor.sinaapp.com/./class/20141225/549bb23d01016.png', ''),
(23, '26', 'http://b2cshop-img.stor.sinaapp.com/./class/20141225/549bb26177c3b.png', ''),
(24, '27', 'http://b2cshop-img.stor.sinaapp.com/./class/20141225/549bc61695d93.jpg', ''),
(25, '27', 'http://b2cshop-img.stor.sinaapp.com/./class/20141225/549bc6209288e.jpg', ''),
(26, '27', 'http://b2cshop-img.stor.sinaapp.com/./class/20141225/549bc62dc31be.jpg', '');

-- --------------------------------------------------------

--
-- 表的结构 `mz_info`
--

CREATE TABLE IF NOT EXISTS `mz_info` (
  `id` int(5) NOT NULL AUTO_INCREMENT COMMENT '网站配置ID',
  `content` text NOT NULL COMMENT '内容',
  `name` text NOT NULL COMMENT '条目名',
  `desc` text NOT NULL COMMENT '网站描述',
  `last_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `favicon` text NOT NULL COMMENT '图标',
  `logo` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- 转存表中的数据 `mz_info`
--

INSERT INTO `mz_info` (`id`, `content`, `name`, `desc`, `last_time`, `favicon`, `logo`) VALUES
(1, '模范行装', 'site_name', '网站名', '2014-10-21 20:05:13', '', 'http://b2cshop-img.stor.sinaapp.com/./class/20141021/54464bf2b99de.png'),
(2, 'http://www.b1queen.com/Home/List/?id=18', 'slider1', '', '2014-11-15 20:54:10', '', 'http://b2cshop-img.stor.sinaapp.com/class/20141115/546630f121a29.png'),
(3, 'http://www.b1queen.com/Home/List/?id=15', 'slider2', '', '2014-11-15 20:54:11', '', 'http://b2cshop-img.stor.sinaapp.com/class/20141115/546634049a7f5.png'),
(4, 'http://www.b1queen.com/Home/List/index.html?id=21', 'slider3', '', '2014-11-15 20:54:11', '', 'http://b2cshop-img.stor.sinaapp.com/class/20141115/5466387f4889e.png'),
(5, 'http://www.b1queen.com/Home/List/?id=28', 'slider4', '', '2014-11-15 20:54:11', '', 'http://b2cshop-img.stor.sinaapp.com/class/20141115/546641f8082e5.png'),
(6, 'http://www.b1queen.com/Home/List/?id=25', 'slider5', '', '2014-11-15 20:54:11', '', 'http://b2cshop-img.stor.sinaapp.com/class/20141115/54663e139c45c.png');

-- --------------------------------------------------------

--
-- 表的结构 `mz_item`
--

CREATE TABLE IF NOT EXISTS `mz_item` (
  `id` int(64) NOT NULL AUTO_INCREMENT COMMENT '商品ID',
  `price` varchar(16) NOT NULL COMMENT '价格',
  `title` text NOT NULL COMMENT '商品名称',
  `desc` text NOT NULL COMMENT '商品描述',
  `sold_num` int(10) NOT NULL COMMENT '售出',
  `stock_num` int(10) NOT NULL COMMENT '库存',
  `brand` text NOT NULL COMMENT '品牌',
  `size` text NOT NULL COMMENT '尺码',
  `category` text NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `visit_times` int(11) NOT NULL DEFAULT '0',
  `module` int(11) NOT NULL COMMENT '产品类型',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '状态（0：下架，1：上架）',
  `class` int(4) NOT NULL COMMENT '类目',
  `hot` int(11) NOT NULL COMMENT '热门类型',
  `zan` int(11) NOT NULL COMMENT '赞',
  PRIMARY KEY (`id`),
  KEY `class` (`class`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=34 ;

--
-- 转存表中的数据 `mz_item`
--

INSERT INTO `mz_item` (`id`, `price`, `title`, `desc`, `sold_num`, `stock_num`, `brand`, `size`, `category`, `create_time`, `visit_times`, `module`, `status`, `class`, `hot`, `zan`) VALUES
(28, '787', '山羊绒衫', '<p>米歇尔奥巴马钟爱的一个牌子。</p><p><br/></p><p>cashmere的时尚经：美丽的拿破仑和约瑟芬的爱情故事，让Cashmere羊毛披肩成为欧洲富商贵族的最爱。传说拿破仑东征时从亚洲带了一份礼物给他心爱的妻子约瑟芬，一条Cashmere的披肩，从此约瑟芬对於Cashmere羊毛的披肩爱不释手，更收集了数百条各式各样Cashmere披肩，一时之间欧洲贵族名媛争相仿效，Cashmere羊毛在当时也谓为流行的代名词。</p><p><br/></p><p>面料：wool算是最普通的羊毛，而美利奴是好一点的羊毛。开司米（cashmere）是羊毛中最高级的材料，也叫山羊绒，是山羊身上的细羊绒，绵羊身上是没有羊绒的。</p><p><br/></p><p>款式：宽松、七分袖、罗纹边</p><p><br/></p><p>洗涤：干洗</p><p><br/></p><p><br/></p>', 3, 2, '1', 'xxl_xl_l_m_s_xs_xxs', '', '2014-10-10 20:35:10', 61, 0, 1, 15, 1, 1),
(32, '1142', '威尔士亲王格子裙', '<p>美国第一夫人米歇尔钟爱的一个牌子。</p><p><br/></p><p>Glen plaid，我想很多女人会因为这个名字而爱上这款格纹！这是那个爱美人不爱江山的温莎公爵深爱的一款格纹。它原本是是出自苏格兰高地格伦欧科镇的羊毛纺织品。19世纪末，伯爵夫人Earl of Seafield头一个把Glen Plaid制成外套，给庄园里的管家穿着。在得到当时的威尔士亲王，后来的温莎公爵欢心后，得到了广泛推广和认同。<span id="_baidu_bookmark_end_20" style="display: none; line-height: 0px;">‍</span><span style="font-family: Tahoma, Arial, sans-serif; font-size: 14px; line-height: 25px; background-color: rgb(255, 255, 255);"><span id="_baidu_bookmark_end_18" style="display: none; line-height: 0px;">‍</span></span><span id="_baidu_bookmark_end_8" style="display: none; line-height: 0px;">‍</span><span style="font-family: Tahoma, Arial, sans-serif; font-size: 14px; line-height: 25px; background-color: rgb(255, 255, 255);"><span id="_baidu_bookmark_end_6" style="display: none; line-height: 0px;">‍</span></span><span id="_baidu_bookmark_end_4" style="display: none; line-height: 0px;">‍</span><span style="font-family: Tahoma, Arial, sans-serif; font-size: 14px; line-height: 25px; background-color: rgb(255, 255, 255);"><span id="_baidu_bookmark_end_2" style="display: none; line-height: 0px;">‍</span></span></p><p><br/></p><p>款式：铅笔裙，裙长在膝盖以上</p><p><br/></p><p>洗涤：干洗</p>', 3, 8, '1', '000_00_0_2_4_6_8_10_12_14_16', '', '2014-11-14 22:57:08', 41, 0, 1, 15, 1, 3),
(33, '492', '波点丝质围巾', '<p>洗涤：干洗</p><p><br/></p><p><br/></p>', 5, 2, '1', '2e3', '', '2014-11-14 23:07:44', 62, 1, 1, 15, 1, 1);

-- --------------------------------------------------------

--
-- 表的结构 `mz_item_brand`
--

CREATE TABLE IF NOT EXISTS `mz_item_brand` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `brand` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- 转存表中的数据 `mz_item_brand`
--


-- --------------------------------------------------------

--
-- 表的结构 `mz_item_info`
--

CREATE TABLE IF NOT EXISTS `mz_item_info` (
  `id` int(16) NOT NULL AUTO_INCREMENT,
  `title` text NOT NULL,
  `url` text NOT NULL,
  `item` int(11) NOT NULL,
  `type` varchar(20) NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=89 ;

--
-- 转存表中的数据 `mz_item_info`
--

INSERT INTO `mz_item_info` (`id`, `title`, `url`, `item`, `type`, `create_time`) VALUES
(54, '', 'http://b2cshop-img.stor.sinaapp.com/./class/20141025/544b8eeca627a.jpg', 30, 'color', '2014-10-25 19:53:37'),
(53, '3', 'http://b2cshop-img.stor.sinaapp.com/./class/20141025/544b844b69efd.jpg', 30, 'desc', '2014-10-25 19:07:13'),
(44, '2', 'http://b2cshop-img.stor.sinaapp.com/./class/20141025/544b7db0f2a27.gif', 30, 'desc', '2014-10-25 18:41:35'),
(43, '拜拜', 'http://b2cshop-img.stor.sinaapp.com/./class/20141025/544b808bd7f46.jpg', 30, 'color', '2014-10-25 18:41:35'),
(42, '机', 'http://b2cshop-img.stor.sinaapp.com/./class/20141025/544b688e86598.jpg', 30, 'desc', '2014-10-25 17:10:03'),
(41, '蓝色', 'http://b2cshop-img.stor.sinaapp.com/./class/20141025/544b6823877a9.jpg', 30, 'color', '2014-10-25 17:10:03'),
(55, 'huli', 'http://b2cshop-img.stor.sinaapp.com/./class/20141027/544e58da2fca8.jpg', 29, 'color', '2014-10-27 22:38:26'),
(56, 'beauty', 'http://b2cshop-img.stor.sinaapp.com/./class/20141105/545a14bf6de81.jpg', 29, 'desc', '2014-11-05 20:16:57'),
(57, 'a skit', 'http://b2cshop-img.stor.sinaapp.com/./class/20141105/545a15136cc4b.jpg', 29, 'desc', '2014-11-05 20:16:57'),
(58, 'beauty2', 'http://b2cshop-img.stor.sinaapp.com/./class/20141105/545a1530c834c.jpg', 29, 'desc', '2014-11-05 20:16:57'),
(59, 'popa', 'http://b2cshop-img.stor.sinaapp.com/./class/20141105/545a15a6109fe.jpg', 29, 'color', '2014-11-05 20:19:40'),
(60, 'katong', 'http://b2cshop-img.stor.sinaapp.com/./class/20141105/545a15c4ee36d.jpg', 29, 'color', '2014-11-05 20:19:40'),
(79, '', 'http://b2cshop-img.stor.sinaapp.com/./class/20141114/54661331797dd.png', 28, 'desc', '2014-11-14 22:36:02'),
(80, '', 'http://b2cshop-img.stor.sinaapp.com/./class/20141114/5466133ad578b.png', 28, 'desc', '2014-11-14 22:36:02'),
(76, '', 'http://b2cshop-img.stor.sinaapp.com/./class/20141114/54661166e4ced.png', 28, 'desc', '2014-11-14 22:28:13'),
(81, '', 'http://b2cshop-img.stor.sinaapp.com/./class/20141114/5466134525b1d.png', 28, 'desc', '2014-11-14 22:36:02'),
(65, '卡其色', 'http://b2cshop-img.stor.sinaapp.com/./class/20141113/5464bb0e243ad.jpg', 31, 'color', '2014-11-13 22:10:23'),
(66, '狂欢色', 'http://b2cshop-img.stor.sinaapp.com/./class/20141113/5464bb386def3.jpg', 31, 'color', '2014-11-13 22:10:23'),
(67, '商品描述一', 'http://b2cshop-img.stor.sinaapp.com/./class/20141113/5464bb82665c9.jpg', 31, 'desc', '2014-11-13 22:10:23'),
(68, '第二个', 'http://b2cshop-img.stor.sinaapp.com/./class/20141113/5464bb97e78ec.jpg', 31, 'desc', '2014-11-13 22:10:23'),
(69, '第三个', 'http://b2cshop-img.stor.sinaapp.com/./class/20141113/5464bbc3c232a.jpg', 31, 'desc', '2014-11-13 22:10:23'),
(70, '红', 'http://b2cshop-img.stor.sinaapp.com/./class/20141114/5465ab8dd0461.png', 28, 'color', '2014-11-13 22:52:14'),
(71, '杏', 'http://b2cshop-img.stor.sinaapp.com/./class/20141114/5465b00c60f39.png', 28, 'color', '2014-11-14 15:34:31'),
(72, '灰', 'http://b2cshop-img.stor.sinaapp.com/./class/20141114/5465b04223859.png', 28, 'color', '2014-11-14 15:34:31'),
(73, '藏青', 'http://b2cshop-img.stor.sinaapp.com/./class/20141114/5465b0716c992.png', 28, 'color', '2014-11-14 15:34:31'),
(74, '黑', 'http://b2cshop-img.stor.sinaapp.com/./class/20141114/5465b0816a155.png', 28, 'color', '2014-11-14 15:34:31'),
(82, '黑白格子', 'http://b2cshop-img.stor.sinaapp.com/./class/20141114/5466189177ff3.png', 32, 'color', '2014-11-14 22:57:08'),
(84, '', 'http://b2cshop-img.stor.sinaapp.com/./class/20141114/5466198aa95ed.png', 32, 'desc', '2014-11-14 23:03:24'),
(85, '', 'http://b2cshop-img.stor.sinaapp.com/./class/20141114/5466199a5906e.png', 32, 'desc', '2014-11-14 23:03:24'),
(86, '', 'http://b2cshop-img.stor.sinaapp.com/./class/20141114/546619a90452b.png', 32, 'desc', '2014-11-14 23:03:24'),
(87, '', 'http://b2cshop-img.stor.sinaapp.com/./class/20141114/546619b5d01a4.png', 32, 'desc', '2014-11-14 23:03:24'),
(88, '', 'http://b2cshop-img.stor.sinaapp.com/./class/20141114/54661abd78a69.png', 33, 'desc', '2014-11-14 23:07:44');

-- --------------------------------------------------------

--
-- 表的结构 `mz_match`
--

CREATE TABLE IF NOT EXISTS `mz_match` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` text NOT NULL,
  `item` varchar(128) NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `desc` text NOT NULL,
  `class` int(11) NOT NULL,
  `hot` int(11) NOT NULL,
  `visit_times` int(11) NOT NULL COMMENT '访问次数',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '上架下架',
  `brand` int(11) NOT NULL COMMENT '品牌',
  `zan` int(11) NOT NULL DEFAULT '0' COMMENT '赞',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=10 ;

--
-- 转存表中的数据 `mz_match`
--

INSERT INTO `mz_match` (`id`, `title`, `item`, `create_time`, `desc`, `class`, `hot`, `visit_times`, `status`, `brand`, `zan`) VALUES
(9, '山羊绒搭配铅笔裤', '28_32_33', '2014-11-14 15:04:43', '山羊绒衫搭配铅笔裤，去完办公室赴聚会', 10, 1, 31, 1, 1, 0);

-- --------------------------------------------------------

--
-- 表的结构 `mz_match_info`
--

CREATE TABLE IF NOT EXISTS `mz_match_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` text NOT NULL,
  `url` text NOT NULL,
  `match` int(11) NOT NULL COMMENT '搭配',
  PRIMARY KEY (`id`),
  KEY `match` (`match`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=14 ;

--
-- 转存表中的数据 `mz_match_info`
--

INSERT INTO `mz_match_info` (`id`, `title`, `url`, `match`) VALUES
(1, '11', 'http://b2cshop-img.stor.sinaapp.com/./class/20141012/543a44973fcf7.gif', 3),
(2, '22', 'http://b2cshop-img.stor.sinaapp.com/./class/20141012/543a44a2179c0.png', 2),
(5, 'qunzi', 'http://b2cshop-img.stor.sinaapp.com/./class/20141109/545f496c110be.jpg', 2),
(6, '搭配1', 'http://b2cshop-img.stor.sinaapp.com/./class/20141113/5464bc1f3b0e8.jpg', 8),
(7, '搭配2', 'http://b2cshop-img.stor.sinaapp.com/./class/20141113/5464bc2f968e2.jpg', 8),
(8, '搭配三', 'http://b2cshop-img.stor.sinaapp.com/./class/20141113/5464bc3f416a8.jpg', 8),
(9, '搭配4', 'http://b2cshop-img.stor.sinaapp.com/./class/20141113/5464bc4b741b1.jpg', 8),
(10, 'e', 'http://b2cshop-img.stor.sinaapp.com/./class/20141113/5464bc8c4694b.jpg', 3),
(11, '11', 'http://b2cshop-img.stor.sinaapp.com/./class/20141113/5464bca0c96df.jpg', 3),
(12, 'barbiq', 'http://b2cshop-img.stor.sinaapp.com/./class/20141113/5464bcb30771a.jpg', 3),
(13, '', 'http://b2cshop-img.stor.sinaapp.com/./class/20141114/5465a96867321.png', 9);

-- --------------------------------------------------------

--
-- 表的结构 `mz_module`
--

CREATE TABLE IF NOT EXISTS `mz_module` (
  `id` int(3) NOT NULL AUTO_INCREMENT,
  `title` text NOT NULL COMMENT '模型名称',
  `content` text NOT NULL,
  `num` int(3) NOT NULL DEFAULT '0',
  `name` varchar(20) NOT NULL COMMENT '模型英文名称',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- 转存表中的数据 `mz_module`
--

INSERT INTO `mz_module` (`id`, `title`, `content`, `num`, `name`) VALUES
(0, '服饰', '尺码;材料;品牌;款式;风格;适用季节;适用人群', 4, 'fushi'),
(1, '配件', '', 1, 'peijian'),
(2, '家纺', '', 0, 'jiafang');

-- --------------------------------------------------------

--
-- 表的结构 `mz_module_info`
--

CREATE TABLE IF NOT EXISTS `mz_module_info` (
  `father` int(5) NOT NULL,
  `title` text NOT NULL,
  `name` varchar(20) NOT NULL,
  `hot` int(11) NOT NULL COMMENT '是否根据此属性进行索引',
  `class` int(1) NOT NULL DEFAULT '0' COMMENT '是否为分类属性',
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `father` (`father`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- 转存表中的数据 `mz_module_info`
--

INSERT INTO `mz_module_info` (`father`, `title`, `name`, `hot`, `class`, `id`) VALUES
(0, '尺码', 'chima', 1, 1, 1),
(0, '品牌', 'pingpai', 0, 0, 2),
(0, '适用人群', 'adaptPeople', 0, 0, 3),
(0, '性别', 'sex', 1, 0, 4),
(2, '类别', 'pjClass', 0, 1, 5);

-- --------------------------------------------------------

--
-- 表的结构 `mz_order`
--

CREATE TABLE IF NOT EXISTS `mz_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `status` varchar(32) NOT NULL DEFAULT '0' COMMENT '状态(0:未发货，1:付款,2:已发货）',
  `total_price` varchar(32) NOT NULL COMMENT '价格',
  `beizhu` text NOT NULL,
  `address_id` text NOT NULL,
  `user` int(11) NOT NULL,
  `billNo` int(32) NOT NULL,
  `order_id` varchar(32) NOT NULL DEFAULT 'order_id',
  `designer` varchar(32) NOT NULL,
  `type` varchar(32) NOT NULL DEFAULT 'good',
  `fuwu` text NOT NULL,
  `num` int(11) NOT NULL,
  `post_name` text NOT NULL COMMENT '快递公司',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=17 ;

--
-- 转存表中的数据 `mz_order`
--

INSERT INTO `mz_order` (`id`, `order_time`, `status`, `total_price`, `beizhu`, `address_id`, `user`, `billNo`, `order_id`, `designer`, `type`, `fuwu`, `num`, `post_name`) VALUES
(10, '2014-11-13 23:10:57', '0', '313', '', '1', 13, 0, 'order_id', '', 'good', '', 0, ''),
(9, '2014-11-13 23:08:20', '0', '256', '', '0', 13, 0, 'order_id', '', 'good', '', 0, ''),
(11, '2014-11-21 20:54:19', '0', '1279', '', '1 1 邮编:1  电话:1', 13, 0, 'order_id', '', 'good', '', 0, ''),
(13, '2014-12-09 18:37:26', '0', '222', '', '北京市海淀区北京邮电大学 苗壮 邮编:100876  电话:18911895560', 13, 0, 'EC09214465163310', '6', 'yuyue', '服务1', 1, ''),
(14, '2014-12-09 19:59:02', '0', '0', '', '北京市海淀区北京邮电大学 苗壮 邮编:100876  电话:18911895560', 13, 0, 'EC09263425447248', '17', 'yuyue', 'bupt12', 3, ''),
(15, '2014-12-09 20:00:07', '1', '42', '', '北京市海淀区北京邮电大学 苗壮 邮编:100876  电话:18911895560', 13, 0, 'EC09264078858621', '17', 'yuyue', 'bupt12', 2, ''),
(16, '2014-12-20 15:02:29', '0', '21', '', '北京市海淀区北京邮电大学 苗壮 邮编:100876  电话:18911895560', 13, 0, 'EC20589492304019', '17', 'yuyue', 'bupt1', 1, '');

-- --------------------------------------------------------

--
-- 表的结构 `mz_order_item`
--

CREATE TABLE IF NOT EXISTS `mz_order_item` (
  `item` int(16) NOT NULL,
  `num` int(16) NOT NULL,
  `order` int(32) NOT NULL,
  `chima` text NOT NULL,
  `color` text NOT NULL,
  `price` varchar(32) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `mz_order_item`
--

INSERT INTO `mz_order_item` (`item`, `num`, `order`, `chima`, `color`, `price`) VALUES
(28, 1, 11, 'xxl', '1', '787'),
(33, 1, 11, 'little', '', '492'),
(31, 1, 7, '43', '卡其色', '256'),
(31, 1, 8, '43', '卡其色', '256'),
(31, 1, 9, '43', '卡其色', '256'),
(28, 1, 10, 'm', 'cpu', '313'),
(32, 1, 12, '00', '1', '1142'),
(28, 2, 12, 'xxl', '1', '787');

-- --------------------------------------------------------

--
-- 表的结构 `mz_user`
--

CREATE TABLE IF NOT EXISTS `mz_user` (
  `id` int(16) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `nick_name` text NOT NULL,
  `username` varchar(16) NOT NULL COMMENT '用户名',
  `password` varchar(128) NOT NULL COMMENT 'md5密码',
  `phone` varchar(32) NOT NULL COMMENT '手机',
  `sex` varchar(1) NOT NULL,
  `email` varchar(64) NOT NULL,
  `passport` text NOT NULL,
  `address_id` int(16) NOT NULL DEFAULT '0',
  `visit_times` int(16) NOT NULL DEFAULT '0',
  `type` int(10) NOT NULL DEFAULT '0',
  `last_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `create_time` varchar(16) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=18 ;

--
-- 转存表中的数据 `mz_user`
--

INSERT INTO `mz_user` (`id`, `nick_name`, `username`, `password`, `phone`, `sex`, `email`, `passport`, `address_id`, `visit_times`, `type`, `last_time`, `create_time`) VALUES
(1, '', 'b2cshop', '6132f55372b36de2f4616805f89476f7', '', '0', 'b2cshop@b2cshop.com', '', 0, 15, 1, '2014-11-06 21:26:52', '0000-00-00 00:00'),
(13, '', 'b1queen', '31936d7aa7bfb4f650ffef4fb1ba0d22', '18911895560', '1', 'b1queen@b1queen.com', '', 0, 67, 1, '2014-12-25 14:07:49', ''),
(17, 'garfield', 'garfield', 'b57662941c5291caba1be851a15db4db', '15210344759', '1', '170209165@qq.com', '', 0, 1, 0, '2014-12-23 09:55:41', '2014-Dec-Tue 09:'),
(16, 'mizy', 'mizy', '31936d7aa7bfb4f650ffef4fb1ba0d22', '18911895560', '0', 'mizy@b1queen.com', '', 0, 1, 0, '2014-11-06 21:59:26', '2014-Nov-Thu 09:');

-- --------------------------------------------------------

--
-- 表的结构 `mz_user_address`
--

CREATE TABLE IF NOT EXISTS `mz_user_address` (
  `address` text NOT NULL COMMENT '地址',
  `user` int(16) NOT NULL COMMENT '用户ID',
  `id` int(16) NOT NULL COMMENT 'id',
  `default` int(1) NOT NULL COMMENT '默认地址',
  `phone` varchar(32) NOT NULL,
  `posta_code` int(11) NOT NULL,
  `name` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `mz_user_address`
--

INSERT INTO `mz_user_address` (`address`, `user`, `id`, `default`, `phone`, `posta_code`, `name`) VALUES
('北京市海淀区北京邮电大学', 13, 1, 1, '18911895560', 100876, '苗壮'),
('北京市朝阳区望京花园', 13, 0, 0, '18665392375', 100782, '苗壮');

-- --------------------------------------------------------

--
-- 表的结构 `mz_user_collect`
--

CREATE TABLE IF NOT EXISTS `mz_user_collect` (
  `item` int(16) NOT NULL,
  `user` int(16) NOT NULL,
  `id` int(32) NOT NULL AUTO_INCREMENT,
  `type` varchar(32) NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- 转存表中的数据 `mz_user_collect`
--

INSERT INTO `mz_user_collect` (`item`, `user`, `id`, `type`, `create_time`) VALUES
(31, 13, 3, 'item', '2014-11-14 20:49:10'),
(29, 13, 5, 'item', '2014-11-14 21:38:17');

-- --------------------------------------------------------

--
-- 表的结构 `mz_yuyue`
--

CREATE TABLE IF NOT EXISTS `mz_yuyue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `designer` int(11) NOT NULL,
  `fuwu` text NOT NULL,
  `num` varchar(11) NOT NULL,
  `total_price` varchar(11) NOT NULL,
  `beizhu` text NOT NULL,
  `order_id` varchar(32) NOT NULL,
  `address` text NOT NULL,
  `user` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- 转存表中的数据 `mz_yuyue`
--

