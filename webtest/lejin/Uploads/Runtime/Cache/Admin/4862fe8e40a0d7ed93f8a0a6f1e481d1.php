<?php if (!defined('THINK_PATH')) exit();?><script type="text/javascript">
$(function(){
	$.formValidator.initConfig({formID:"AdminEditForm",theme:'App',onError:function(msg){/*$.messager.alert('错误提示', msg, 'error');*/},onSuccess:AdminSaveEdit,submitAfterAjaxPrompt:'有数据正在异步验证，请稍等...',inIframe:true});
	$("#AdminEdit_password").formValidator({empty:true,onShow:"不修改密码请留空",onFocus:"密码应该为6-20位之间"}).inputValidator({min:6,max:20,onError:"密码应该为6-20位之间"});
	$("#AdminEdit_pwdconfirm").formValidator({onShow:"不修改密码请留空",onFocus:"请输入确认密码"}).compareValidator({desID:"AdminEdit_password",operateor:"=",onError:"输入两次密码不一致"});
	$("#AdminEdit_email").formValidator({onShow:"请输入E-mail",onFocus:"请输入E-mail"}).regexValidator({regExp:"email",dataType:"enum",onError:"E-mail格式错误"}).ajaxValidator({
		type : "post",
		url : "<?php echo U('Admin/public_checkEmail');?>",
		data : {email: function(){return $("#AdminEdit_email").val()}, Default: '<?php echo ($info["email"]); ?>'},
		datatype : "json",
		async:'false',
		success : function(data){
			var json = $.parseJSON(data);
            return json.status == 1 ? false : true;
		},
		onError : "该邮箱已经存在",
		onWait : "请稍候..."
	});
	$("#AdminEdit_realname").formValidator({onShow:"请输入真实姓名",onFocus:"真实姓名应该为2-20位之间"}).inputValidator({min:2,max:20,empty:{leftEmpty:false,rightEmpty:false,emptyError:"姓名两边不能有空格"},onError:"真实姓名应该为2-20位之间"});
	$("#AdminEdit_role").formValidator({onShow:"请选择角色",onFocus:"请选择角色"}).inputValidator({min:0,onError:"请选择角色"});
})
function AdminSaveEdit(){
	$.post('<?php echo U('Admin/edit?id='.$info['userid']);?>', $("#AdminEditForm").serialize(), function(data){
		if(!data.status){
			$.messager.alert('提示信息', data.info, 'error');
		}else{
			AdminReload();
			$.messager.alert('提示信息', data.info, 'info');
			$('#AdminEditBox').dialog('close');
		}
	})
}
</script>
<form id="AdminEditForm" style="font-size:13px; padding: 5px 0 0 10px;">
<table>
	<tr>
		<td width="80">用户名：</td>
		<td><?php echo ($info["username"]); ?></td>
		<td></td>
	</tr>
	<tr>
		<td>密码：</td>
		<td><input type="password" name="info[password]" id="AdminEdit_password" style="width:180px;height:22px" /></td>
		<td><div id="AdminEdit_passwordTip"></div></td>
	</tr>
	<tr>
		<td>确认密码：</td>
		<td><input type="password" name="info[pwdconfirm]" id="AdminEdit_pwdconfirm" style="width:180px;height:22px" /></td>
		<td><div id="AdminEdit_pwdconfirmTip"></div></td>
	</tr>
	<tr>
		<td>E-mail：</td>
		<td><input type="text" name="info[email]" id="AdminEdit_email" value="<?php echo ($info["email"]); ?>" style="width:180px;height:22px" /></td>
		<td><div id="AdminEdit_emailTip"></div></td>
	</tr>
	<tr>
		<td>真实姓名：</td>
		<td><input type="text" name="info[realname]" id="AdminEdit_realname" value="<?php echo ($info["realname"]); ?>" style="width:180px;height:22px" /></td>
		<td><div id="AdminEdit_realnameTip"></div></td>
	</tr>
	<tr>
		<td>所属角色：</td>
		<td>
			<select class="easyui-combobox" data-options="editable:false,panelHeight:'auto'" name="info[roleid]" id="AdminEdit_role" style="height:25px">
			<?php if(is_array($rolelist)): foreach($rolelist as $key=>$role): ?><option value="<?php echo ($role["roleid"]); ?>" <?php if(($info["roleid"]) == $role["roleid"]): ?>selected<?php endif; ?>><?php echo ($role["rolename"]); ?></option><?php endforeach; endif; ?>
			</select>
		</td>
		<td><div id="AdminEdit_roleTip"></div></td>
	</tr>
</table>
</form>