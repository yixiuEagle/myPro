<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="./Public/js/jquery.min.js"></script>
<title>测试</title>
<script type="text/javascript">
	function get(){
		var KEY = $('#KEY').attr('value');
		var input = '<tr><td class="frmText">';
			input += ''+KEY+':</td><td> <input class="frmInput" type="text" name="'+KEY+'" value="">';
			input += '</td></tr>';
		$("#tab").append(input);
	}
	function actionchange(){
		var URL = $('#url').attr('value');
		form1.action=URL;
		$('#showUrl').html(URL);
	}
	$(function(){
		$('#showUrl').html(form1.action);
	});
</script>
<style type="text/css">
input {
	border: 1px solid #ccc;
	height: 20px;
	font-size: 14px;
	padding: 3px 6px;
}
.button {width: 100px; height: 28px; }
.frmInput {width: 250px;}
</style>
</head>
<body>
	<form action="" method="post" enctype="multipart/form-data" name="form1" target="_blank">
		<table id="tab" cellspacing="0" cellpadding="4" frame="box"	bordercolor="#dcdcdc" rules="none" style="border-collapse: collapse;">
			<tr>
				<td class="frmHeader" style="border-right: 2px solid white; background: #dcdcdc">参数</td>
				<td class="frmHeader" style="background: #dcdcdc">值</td>
			</tr>
			<tr>
				<td class="frmText">设置API接口URL:</td>
				<td>
					<input class="frmInput" type="text" value="" id="url">
					<input type="button" value="设置" onclick="actionchange()" class="button">
					<span id="showUrl" style="color: red"></span>
				</td>
			</tr>
			<tr>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td class="frmText">添加KEY:</td>
				<td>
					<input class="frmInput" type="text" value="" id="KEY">
					<input type="button" value="添加" onclick="get()" class="button">
					<input type="submit" value="调用" class="button">
				</td>
			</tr>
			<tr>
				<td class="frmText">APPKEY:</td>
				<td><input class="frmInput" type="text" name="appkey" value="69011ae7d1f3c17284b99c42254aca2d"></td>
			</tr>
			<tr>
				<td class="frmText">上传图片:</td>
				<td><input class="frmInput" type="file" name="pic" value=""></td>
			</tr>
			<tr>
				<td class="frmText">上传图片:</td>
				<td><input class="frmInput" type="file" name="pic2"	value=""></td>
			</tr>
		</table>
	</form>
	<div style="padding-top: 10px;">
		<h2>说明</h2>
		<p>1.接口路径的设置，填写自己想要测试的接口路径，看到后面的红色的路径是你想要的路径，表示设置成功</p>
		<p>2.返回的数据类型 xml/json/serialize_base64 测试的时候填写自己想要的格式就OK</p>
		<p>4.默认路径是不用传参的测试接口</p>
	</div>
</body>
</html>