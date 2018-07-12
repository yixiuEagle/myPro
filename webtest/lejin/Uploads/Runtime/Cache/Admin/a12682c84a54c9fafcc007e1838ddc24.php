<?php if (!defined('THINK_PATH')) exit();?><script type="text/javascript">
$(function(){
	$.formValidator.initConfig({formID:"AdminAddForm",theme:'App',onError:function(msg){/*$.messager.alert('错误提示', msg, 'error');*/},onSuccess:AdminSaveAdd,submitAfterAjaxPrompt:'有数据正在异步验证，请稍等...',inIframe:true});
	$("#AdminAdd_username").formValidator({onShow:"请输入用户名",onFocus:"用户名应该为2-20位之间"}).inputValidator({min:2,max:20,onError:"用户名应该为2-20位之间"}).ajaxValidator({
		type : "post",
		url : "<?php echo U('Admin/public_checkName');?>",
		data : {name:function(){return $("#AdminAdd_username").val()} },
		datatype : "json",
		async:'false',
		success : function(data){
			var json = $.parseJSON(data);
            return json.status == 1 ? false : true;
		},
		onError : "用户名已存在",
		onWait : "请稍候..."
	});
	$("#AdminAdd_password").formValidator({onShow:"请输入密码",onFocus:"密码应该为6-20位之间"}).inputValidator({min:6,max:20,onError:"密码应该为6-20位之间"});
	$("#AdminAdd_pwdconfirm").formValidator({onShow:"请输入确认密码",onFocus:"请输入确认密码"}).compareValidator({desID:"AdminAdd_password",operateor:"=",onError:"输入两次密码不一致"});
	$("#AdminAdd_email").formValidator({onShow:"请输入E-mail",onFocus:"请输入E-mail"}).regexValidator({regExp:"email",dataType:"enum",onError:"E-mail格式错误"});
	$("#AdminAdd_realname").formValidator({onShow:"请输入真实姓名",onFocus:"真实姓名应该为2-20位之间"}).inputValidator({min:2,max:20,empty:{leftEmpty:false,rightEmpty:false,emptyError:"姓名两边不能有空格"},onError:"真实姓名应该为2-20位之间"});
	$("#AdminAdd_role").formValidator({onShow:"请选择角色",onFocus:"请选择角色"}).inputValidator({min:0,onError:"请选择角色"});
})
function AdminSaveAdd(){
	$.post('<?php echo U('Admin/add');?>', $("#AdminAddForm").serialize(), function(data){
		if(!data.status){
			$.messager.alert('提示信息', data.info, 'error');
		}else{
			AdminReload();
			$.messager.alert('提示信息', data.info, 'info');
			$('#AdminAddBox').dialog('close');
		}
	})
}
</script>
<form id="AdminAddForm" style="font-size:13px; padding: 5px 0 0 10px;">
<table>
	<tr>
		<td width="80">用户名：</td>
		<td><input type="text" name="info[username]" id="AdminAdd_username" style="width:180px;height:22px" /></td>
		<td><div id="AdminAdd_usernameTip"></div></td>
	</tr>
	<tr>
		<td>密码：</td>
		<td><input type="password" name="info[password]" id="AdminAdd_password" style="width:180px;height:22px" /></td>
		<td><div id="AdminAdd_passwordTip"></div></td>
	</tr>
	<tr>
		<td>确认密码：</td>
		<td><input type="password" name="info[pwdconfirm]" id="AdminAdd_pwdconfirm" style="width:180px;height:22px" /></td>
		<td><div id="AdminAdd_pwdconfirmTip"></div></td>
	</tr>
	<tr>
		<td>E-mail：</td>
		<td><input type="text" name="info[email]" id="AdminAdd_email" style="width:180px;height:22px" /></td>
		<td><div id="AdminAdd_emailTip"></div></td>
	</tr>
	<tr>
		<td>真实姓名：</td>
		<td><input type="text" name="info[realname]" id="AdminAdd_realname" style="width:180px;height:22px" /></td>
		<td><div id="AdminAdd_realnameTip"></div></td>
	</tr>
	<tr>
		<td>所属角色：</td>
		<td>
			<select class="easyui-combobox" data-options="editable:false,panelHeight:'auto'" name="info[roleid]" id="AdminAdd_role" style="height:25px">
			<?php if(is_array($rolelist)): foreach($rolelist as $key=>$role): ?><option value="<?php echo ($role["roleid"]); ?>"><?php echo ($role["rolename"]); ?></option><?php endforeach; endif; ?>
			</select>
		</td>
		<td><div id="AdminAdd_roleTip"></div></td>
	</tr>
</table>
</form>