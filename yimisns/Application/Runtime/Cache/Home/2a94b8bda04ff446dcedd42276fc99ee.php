<?php if (!defined('THINK_PATH')) exit();?>﻿<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<link rel="shortcut icon" href="/yimisns/Public/home/images/favicon.ico" mce_href="/yimisns/Public/home/images/favicon.ico" type="image/x-icon" />
<link rel="icon" href="/yimisns/Public/home/images/favicon.ico" mce_href="/yimisns/Public/home/images/favicon.ico" type="image/x-icon">
<title><?php echo ($title); ?></title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="">
<link href="/yimisns/Public/home/css/prettyPhoto.css" rel="stylesheet" type="text/css" />
<link href="/yimisns/Public/home/css/camera.css" rel="stylesheet" id="camera-css" type="text/css" media="all" />
<link href="/yimisns/Public/home/css/bootstrap.css" rel="stylesheet" />
<link href="/yimisns/Public/home/css/theme.css" rel="stylesheet" />
<link href="/yimisns/Public/home/css/skins/tango/skin.css" rel="stylesheet" type="text/css"/>
<link href="/yimisns/Public/home/css/bootstrap-responsive.css" rel="stylesheet">
<script src="/yimisns/Public/js/jquery.min.js" lang="javascript"></script>

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
                          
                        	<div class="logo"><a href="<?php echo U('index');?>"><img src="/yimisns/Public/home/images/logo.png" alt="" /></a></div>
                                                
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
                                   		<!-- <li><a href="<?php echo U('index');?>">首页</a></li> -->
                                      	<!-- <li><a href="<?php echo U('contacts');?>">联系我们</a></li> -->
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
    <div class="page_container">
        <!--slider-->
        <div id="main_slider">
            <div class="camera_wrap" id="camera_wrap_1">
                <div data-src="/yimisns/Public/home/images/slider/1.jpg"></div>
                <div data-src="/yimisns/Public/home/images/slider/2.jpg"></div>
                <div data-src="/yimisns/Public/home/images/slider/3.jpg"></div>                                      
            </div><!-- #camera_wrap_1 -->
            <div class="clear"></div>	
        </div>        
        <!--//slider-->

        <!--planning-->
        <div class="wrap planning">
            <div class="container">
                <div class="download" >
                    <div class="span3" >
                        <a href="<?php echo U('Home/index/android_download');?>">
                        	<span class="img_icon icon1"></span>
                            <span class="link_title">安卓下载</span>

                        </a>
                    </div>
                    <div class="span3" >
                        <a href="<?php echo U('Home/index/iphone_download');?>">
                        	<span class="img_icon icon2"></span>
                            <span class="link_title">苹果官方下载</span>

                        </a>
                    </div>
                     <div class="span3" >
                        <a href="<?php echo U('Home/index/android_download');?>">
                        	<span class="img_icon icon3"></span>
                            <span class="link_title">安卓二维码</span>

                        </a>
                    </div>
                    <div class="span3" >
                        <a href="<?php echo U('Home/index/iphone_download');?>">
                        	<span class="img_icon icon4"></span>
                            <span class="link_title">苹果二维码</span>

                        </a>
                    </div>
                    <div class="span3" style="display:none">
                        <a href="#">
                        	<span class="img_icon icon3"></span>
                            <span class="link_title">iPhone越狱版下载</span>
                        	Nunc vel arcu arcu. Nulla mollis feugiat dui id tincidunt. Aenean ac lobortis elit.
                        </a>
                    </div>
                        	
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
                        	<div class="copyright">&copy; 2016 一米 版权所有. All Rights Reserved. <!-- <a href="http://www.miitbeian.gov.cn/" style="color:#444444;">蜀ICP备14007549号</a>   --> </div>                        
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

	
	<script src="/yimisns/Public/js/jquery.min.js"></script>
    <script type="text/javascript" src="/yimisns/Public/home/js/jquery.easing.1.3.js"></script>
    <script type="text/javascript" src="/yimisns/Public/home/js/jquery.mobile.customized.min.js"></script>
    <script type="text/javascript" src="/yimisns/Public/home/js/camera.js"></script>
    <script src="/yimisns/Public/home/js/bootstrap.js"></script>
    <script src="/yimisns/Public/home/js/superfish.js"></script>
    <script type="text/javascript" src="/yimisns/Public/home/js/jquery.prettyPhoto.js"></script>
    <script type="text/javascript" src="/yimisns/Public/home/js/jquery.jcarousel.js"></script>
    <script type="text/javascript" src="/yimisns/Public/home/js/jquery.tweet.js"></script>
    <!-- myscript.js功能屏蔽，内含测试网速，网站打开慢 
    <script type="text/javascript" src="/yimisns/Public/home/js/myscript.js"></script>
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