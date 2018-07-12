<?php if (!defined('THINK_PATH')) exit();?><!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
		<title>详细</title>
		<style type="text/css">
		body,html{
			margin: 0;
			padding: 0;
			font-family: '微软雅黑', 'Regular';
			width: 100%;overflow-x: hidden;
			box-sizing: content-box;
		}
		ul,li,p{
			list-style-type: none;
			margin: 0;
			padding: 0;
		}
		p{
			font-size: 20px;
			text-align: left;
		}
		.content{
			padding: 15px;
			line-height: 150%;
			text-align: left;
			font-size: 16px;
			max-width: 100%;}
		.content img{max-width: 100%; height: auto;}
		</style>
	</head>
	<body>
		<div class="content">
		<?php echo ($content); ?>
		</div>
	</body>
</html>