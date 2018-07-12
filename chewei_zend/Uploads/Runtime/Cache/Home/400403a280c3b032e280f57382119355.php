<?php if (!defined('THINK_PATH')) exit();?>﻿<!-- 联系我们 -->  
	﻿<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<link rel="shortcut icon" href="/chewei_zend/Public/img/favicon.ico" mce_href="/chewei_zend/Public/img/favicon.ico" type="image/x-icon" />
<link rel="icon" href="/chewei_zend/Public/img/favicon.ico" mce_href="/chewei_zend/Public/img/favicon.ico" type="image/x-icon">
<title><?php echo ($title); ?></title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="">

<!-- 
<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,600,700,800' rel='stylesheet' type='text/css'>
 -->

<link href="/chewei_zend/Public/css/web/prettyPhoto.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" id="camera-css"  href="/chewei_zend/Public/css/web/camera.css" type="text/css" media="all">
<link href="/chewei_zend/Public/css/web/bootstrap.css" rel="stylesheet">
<link href="/chewei_zend/Public/css/web/theme.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="/chewei_zend/Public/css/web/skins/tango/skin.css" />
<link href="/chewei_zend/Public/css/web/bootstrap-responsive.css" rel="stylesheet">
<!--[if lt IE 9]>
	<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->    
</head>
	<!--header-->
    <div class="header">
    	<div class="wrap">
        	<div class="navbar navbar_ clearfix">
            	<div class="container">
                    <div class="row">
                        <div class="span4">
                          
                        	<div class="logo"><a href="<?php echo U('Home/index');?>"><img src="/chewei_zend/Public/img/logo.png" alt="" /></a></div>
                                                
                        </div>
                        <div class="span8">
                        	<div class="follow_us" style="display:none">
                                <ul>
                                    <li><a href="#" class="facebook">Facebook</a></li>
                                    <li><a href="#" class="vimeo">Vimeo</a></li>
                                    <li><a href="#" class="tumbrl">Tumbrl</a></li>
                                    <li><a href="#" class="twitter">Twitter</a></li>
                                    <li><a href="#" class="delicious">Delicious</a></li>
                                </ul>
                            </div>
                            <div class="clear"></div>
                            <nav id="main_menu">
                                <div class="menu_wrap">
                                    <ul class="nav sf-menu">
                                    
                                    <?php if($_SESSION['nickname'] == '' ): ?><li class="current"><a href="<?php echo U('Home/index');?>">首页</a></li>
                                      <li><a href="<?php echo U('Home/index/contacts');?>">联系我们</a></li>
                     <!-- 
					<li><a href="/merchant">登陆</a></li>
					 -->
                                    
                                    <?php else: ?>
                                     <li class="current"><a href="<?php echo U('Home/index');?>">首页</a></li>
									  <li><a href="#"><?php echo ($nickname); ?></a></li>
                                      <li><a href="<?php echo U('Home/index/contacts');?>">联系我们</a></li>
					<!-- 
					<li><a href="/merchant">登陆</a></li>
					 --><?php endif; ?>
                                    
                                    </ul>
                                </div>
                             </nav>                           
                        </div>
                    </div>                
                </div>
             </div>
        </div>    
    </div>
    <!--//header-->    
     
   
<body>


    <!--page_container-->
    <style type="text/css">
<!--
.STYLE4 {font-family: "新宋体"; font-weight: bold; }
.STYLE5 {color: #000000}
.STYLE6 {
	color: #FF0000;
	font-weight: bold;
}
-->
    </style>
    <div class="page_container">
	<div class="breadcrumb">
        	<div class="wrap">
            	<div class="container">
                    <a href="<?php echo U('Home/index');?>">首页</a><span>/</span>联系我们
                </div>
            </div>
        </div>
                       
        <!--planning-->
        <div class="wrap planning">
            <div class="container">
                <div class="contacts" >
                这里添写联系信息
                <!-- 
                    <p class="STYLE5"><span class="STYLE6">如果</span>你是愿意做诚实生意的社区小生意人，请联系我们，我们将欢迎你成为我们的合作伙伴。我们将帮助你找到更多客户。同一区域内前20名商家我们承诺不收取任何加盟费用，且在该区域内永久免费。</p>
                    <p class="STYLE5"><span class="STYLE6">如果</span>你是有志于从事社区020推广、运营的新时代青年，请联系我们，我们的发展和壮大需要你的加盟。 </p>
                    <p class="STYLE4">联系方式:邮箱：xx QQ  : xx 手机：xx </p>
                     -->
                    </div>
            </div>
        </div>
        <!--//planning-->
    </div>
    <!--//page_container-->
    
      
    <!--footer-->
    <div id="footer">
    	
        
        <div class="footer_bottom">
            <div class="wrap">
            	<div class="container">
                	<div class="row">
                		<div class="span5">    
                        	<div class="copyright">&copy; 2015艾生活 e-life 版权所有. All Rights Reserved. <!-- <a href="http://www.miitbeian.gov.cn/" style="color:#444444;">蜀ICP备14007549号</a>   --> </div>                        
                        </div>
                        <div class="span7">
                        	<div class="foot_right_block">
                            	<div class="fright" style="display:none">
                                	<form action="#" method="post">
                                        <input class="inp_search" name="name" type="text" value="Search the Site" onfocus="if (this.value == 'Search the Site') this.value = '';" onblur="if (this.value == '') this.value = 'Search the Site';" />                                        
                                    </form>
                                </div>
                                <div class="follow_us" style="display:none">
                                	<ul>
                                        <li><a rel="tooltip" href="#" title="Facebook" class="facebook">Facebook</a></li>
                                        <li><a rel="tooltip" href="#" title="Twitter" class="twitter">Twitter</a></li>
                                        <li><a rel="tooltip" href="#" title="Tumbrl" class="tumbrl">Tumbrl</a></li>
                                        <li><a rel="tooltip" href="#" title="Vimeo" class="vimeo">Vimeo</a></li>
                                        <li><a rel="tooltip" href="#" title="Delicious" class="delicious">Delicious</a></li>
                                    </ul>
                                </div>
                                <div class="clear"></div>
                            
                            	<div class="clear"></div>
                            	<div class="foot_menu">
                            		<ul>
                            		<!-- 
                                        <li><a href="<?php echo U('Home/index/index');?>" class="current">首页</a></li>
                                        <li><a href="<?php echo U('Home/index/contacts');?>">联系我们</a></li>
                                      -->
                                    </ul>
                            	</div>
                            </div>                            
                        </div>
                    </div>	
                </div>
            </div>
        </div>
    </div>
    <!--//footer-->    

	
	<script src="/chewei_zend/Public/js/jquery.min.js"></script>
    <script type="text/javascript" src="/chewei_zend/Public/js/jquery.easing.1.3.js"></script>
    <script type="text/javascript" src="/chewei_zend/Public/js/jquery.mobile.customized.min.js"></script>
    <script type="text/javascript" src="/chewei_zend/Public/js/camera.js"></script>
    <script src="/chewei_zend/Public/js/bootstrap.js"></script>
    <script src="/chewei_zend/Public/js/superfish.js"></script>
    <script type="text/javascript" src="/chewei_zend/Public/js/jquery.prettyPhoto.js"></script>
    <script type="text/javascript" src="/chewei_zend/Public/js/jquery.jcarousel.js"></script>
    <script type="text/javascript" src="/chewei_zend/Public/js/jquery.tweet.js"></script>
    <!-- myscript.js功能屏蔽，内含测试网速，网站打开慢 
    <script type="text/javascript" src="/chewei_zend/Public/js/myscript.js"></script>
     -->
    <script type="text/javascript">
		$(document).ready(function(){	
			//Slider
			$('#camera_wrap_1').camera();
			
			//Featured works & latest posts
			$('#mycarousel, #mycarousel2, #newscarousel').jcarousel();													
		});		
	</script>
</body>
</html>