<?php if (!defined('THINK_PATH')) exit();?><script type="text/javascript">
$(function(){
	$.formValidator.initConfig({formID:"adminRoleAddForm",theme:'App',onError:function(msg){/*$.messager.alert('错误提示', msg, 'error');*/},onSuccess:adminRoleAddSave,submitAfterAjaxPrompt:'有数据正在异步验证，请稍等...',inIframe:true});
	$("#adminAddRolename").formValidator({onShow:"请输入角色名称",onFocus:"角色名称不能为空"}).inputValidator({min:1,max:999,onError:"角色名称不能为空"}).ajaxValidator({
		type : "post",
		url : "<?php echo U('Admin/public_checkRoleName');?>",
		data : {rolename:function(){return $("#adminAddRolename").val()} },
		datatype : "json",
		async:'false',
		success : function(data){
			var json = $.parseJSON(data);
            return json.status == 1 ? false : true;
		},
		onError : "角色名称已存在",
		onWait : "请稍候..."
	});
})
function adminRoleAddSave(){
	$.post('<?php echo U('Admin/roleAdd');?>', $("#adminRoleAddForm").serialize(), function(data){
		if(!data.status){
			$.messager.alert('提示信息', data.info, 'error');
		}else{
			adminRoleReload();
			$.messager.alert('提示信息', data.info, 'info');
			$('#adminRoleAddBox').dialog('close');
		}
	})
}
</script>
<form id="adminRoleAddForm" style="font-size:13px">
<table cellspacing="6" width="100%">
	<tr>
		<td width="80">角色名称：</td>
		<td><input type="text" name="info[rolename]" id="adminAddRolename" style="width:180px;height:22px" /></td>
		<td><div id="adminAddRolenameTip"></div></td>
	</tr>
	<tr>
		<td>角色描述：</td>
		<td colspan="2"><textarea name="info[description]" style="width:90%;height:60px;font-size:12px"></textarea></td>
	</tr>
	<tr>
		<td>是否启用：</td>
		<td colspan="2"><label><input type="radio" name="info[disabled]" value="0" checked />启用</label> <label><input type="radio" name="info[disabled]" value="1" />禁止</label></td>
	</tr>
	<tr>
		<td>排序：</td>
		<td colspan="2"><input type="text" name="info[listorder]" style="width:40px;height:22px" /></td>
	</tr>
</table>
</form>