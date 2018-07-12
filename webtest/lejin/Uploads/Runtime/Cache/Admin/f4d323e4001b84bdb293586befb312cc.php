<?php if (!defined('THINK_PATH')) exit();?><div class="easyui-panel" data-options="fit:true,title:'<?php echo ($currentpos); ?>',border:false">
<script type="text/javascript">
$(function(){
	$('#AdminPwdSubbtn').click(function(){$('#AdminEditPwdForm').submit()});
	$.formValidator.initConfig({formID:"AdminEditPwdForm",theme:'App',onSuccess:AdminPwdSave,inIframe:true});
	$("#old_password").formValidator({onShow:"不修改密码请留空",onFocus:"密码应该为6-20位之间"}).inputValidator({min:6,max:20,empty:{leftEmpty:false,rightEmpty:false,emptyError:"密码两边不能有空格"},onError:"密码应该为6-20位之间"}).ajaxValidator({
		type : "post",
		url : "<?php echo U('Admin/public_checkPassword');?>",
		data : {password: function(){return $("#old_password").val()}},
		datatype : "json",
		async:'false',
		success : function(data){
			var json = $.parseJSON(data);
            return json.status == 1 ? true : false;
		},
		onError : "旧密码输入错误",
		onWait : "请稍候..."
	});
	$("#new_password").formValidator({onShow:"不修改密码请留空",onFocus:"密码应该为6-20位之间"}).inputValidator({min:6,max:20,empty:{leftEmpty:false,rightEmpty:false,emptyError:"密码两边不能有空格"},onError:"密码不能为空,请确认"});
	$("#new_pwdconfirm").formValidator({onShow:"不修改密码请留空",onFocus:"请输入确认密码"}).compareValidator({desID:"new_password",operateor:"=",onError:"输入两次密码不一致"});
})
function AdminPwdSave(){
	$.post('<?php echo U('Admin/public_editPwd');?>', $("#AdminEditPwdForm").serialize(), function(data){
		if(!data.status){
			$.messager.alert('提示信息', data.info, 'error');
		}else{
			$.messager.confirm('提示信息', data.info, function(result){
				if(result) window.location.href = data.url;
			});
		}
	})
}
</script>
<form id="AdminEditPwdForm" style="font-size:13px">
<table cellspacing="10" style="border: 1px solid #ccc; width: 500px;">
	<tr>
		<td width="90">用户名：</td>
		<td colspan="2"><?php echo ($info["username"]); ?> (真实姓名： <?php echo ($info["realname"]); ?>)</td>
	</tr>
	<tr>
		<td>E-mail：</td>
		<td><?php echo ($info["email"]); ?></td>
		<td width="180"></td>
	</tr>
	<tr>
		<td>旧密码：</td>
		<td><input id="old_password" name="old_password" type="password" style="width:180px;height:22px" /></td>
		<td><div id="old_passwordTip"></div></td>
	</tr>
	<tr>
		<td>新密码：</td>
		<td><input id="new_password" name="new_password" type="password" style="width:180px;height:22px" /></td>
		<td><div id="new_passwordTip"></div></td>
	</tr>
	<tr>
		<td>重复新密码：</td>
		<td><input id="new_pwdconfirm" type="password" style="width:180px;height:22px" /></td>
		<td><div id="new_pwdconfirmTip"></div></td>
	</tr>
	<tr>
		<td></td>
		<td colspan="3" align="left">
			<a id="AdminPwdSubbtn" class="easyui-linkbutton" style="width: 50px;">提交</a>
		</td>
	</tr>
</table>
</form>
</div>