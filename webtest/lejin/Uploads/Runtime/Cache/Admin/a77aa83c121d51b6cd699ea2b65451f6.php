<?php if (!defined('THINK_PATH')) exit();?><script type="text/javascript">
$(function(){
	var edit_menu_parent_url = '<?php echo U('Menu/public_selectTree');?>';
	$('#edit_menu_parentid').combotree({url:edit_menu_parent_url}); 
	$.formValidator.initConfig({formID:"editForm",theme:'App',onError:function(msg){/*$.messager.alert('错误提示', msg, 'error');*/},onSuccess:saveMenuEdit,submitAfterAjaxPrompt:'有数据正在异步验证，请稍等...',inIframe:true});
	$("#edit_menu_parentid").formValidator({onShow:"请选择上级菜单",onFocus:"上级菜单不能为空"}).inputValidator({min:0,type:'value',onError:"上级菜单不能为空"}).defaultPassed();
	$("#edit_menu_name").formValidator({onShow:"请输入菜单名称",onFocus:"菜单名称不能为空",onCorrect:"输入正确"}).inputValidator({min:1,empty:{leftEmpty:false,rightEmpty:false,emptyError:'菜单名称不能有空格'},onError:"菜单名称不能为空"}).ajaxValidator({
		type : "post",
		url : "<?php echo U('Menu/public_checkName');?>",
		data : {name:function(){return $("#edit_menu_name").val()},Default:'<?php echo ($data["name"]); ?>'},
		datatype : "json",
		async:'false',
		success : function(data){
			var json = $.parseJSON(data);
            return json.status == 1 ? false : true;
		},
		onError : "菜单名称已存在",
		onWait : "请稍候..."
	}).defaultPassed();
	$("#edit_menu_module").formValidator({onShow:"请输入模块名",onFocus:"模块名不能少于2个字符"}).inputValidator({min:2,empty:{leftEmpty:false,rightEmpty:false,emptyError:'模块名不能有空格'},onError:"模块名不能少于2个字符"}).regexValidator({
		regExp:"^([A-Z][a-z1-9]+)+$",
		param : "",
		dataType:"string",
		onError:"必须为首字母大写的驼峰法命名"
	});
	$("#edit_menu_m").formValidator({onShow:"请输入控制器名",onFocus:"控制器名不能少于2个字符"}).inputValidator({min:2,empty:{leftEmpty:false,rightEmpty:false,emptyError:'控制器名不能有空格'},onError:"控制器名不能少于2个字符"}).regexValidator({
		regExp:"^([A-Z][a-z1-9]+)+$",
		param : "",
		dataType:"string",
		onError:"必须为首字母大写的驼峰法命名"
	});
	$("#edit_menu_a").formValidator({onShow:"请输入方法名",onFocus:"方法名不能少于2个字符"}).inputValidator({min:2,empty:{leftEmpty:false,rightEmpty:false,emptyError:'方法名不能有空格'},onError:"方法名不能少于2个字符"}).regexValidator({
		regExp:"^[a-z][a-z1-9_]+([A-Z][a-z1-9]+)?$",
		param : "",
		dataType:"string",
		onError:"必须为首字母小写的驼峰法命名"
     });
})
function saveMenuEdit(){
	$.post('<?php echo U('Menu/edit?id='.$data['id']);?>', $("#editForm").serialize(), function(data){
		if(!data.status){
			$.messager.alert('提示信息', data.info, 'error');
		}else{
			MenuRefreshList();
			$.messager.alert('提示信息', data.info, 'info');
			$('#editMenuBox').dialog('close');
		}
	})
}
</script>
<form id="editForm" style="font-size:13px">
<table id="editBox">
	<tr>
		<td width="100">上级菜单：</td>
		<td><input id="edit_menu_parentid" name="info[parentid]" class="easyui-combotree" value="<?php echo ($data["parentid"]); ?>" style="width:180px;height:26px" /></td>
		<td><div id="edit_menu_parentidTip"></div></td>
	</tr>
	<tr>
		<td>菜单名称：</td>
		<td><input id="edit_menu_name" name="info[name]" type="text" value="<?php echo ($data["name"]); ?>" style="width:178px;height:22px" /></td>
		<td><div id="edit_menu_nameTip"></div></td>
	</tr>
	<tr>
		<td>模块名：</td>
		<td><input id="edit_menu_module" name="info[module]" type="text" value="<?php echo ($data["module"]); ?>" style="width:178px;height:22px" /></td>
		<td><div id="edit_menu_moduleTip"></div></td>
	</tr>
	<tr>
		<td>控制器名：</td>
		<td><input id="edit_menu_m" name="info[m]" type="text" value="<?php echo ($data["m"]); ?>" style="width:178px;height:22px" /></td>
		<td><div id="edit_menu_mTip"></div></td>
	</tr>
	<tr>
		<td>方法名：</td>
		<td><input id="edit_menu_a" name="info[a]" type="text" value="<?php echo ($data["a"]); ?>" style="width:178px;height:22px" /></td>
		<td><div id="edit_menu_aTip"></div></td>
	</tr>
	<tr>
		<td>附加参数：</td>
		<td><input class="input_show" name="info[data]" type="text" value="<?php echo ($data["data"]); ?>" style="width:178px;height:22px" /></td>
		<td></td>
	</tr>
	<tr>
		<td>是否显示菜单：</td>
		<td colspan="2">
			<label><input name="info[display]" value="1" type="radio" <?php if(($data["display"]) == "1"): ?>checked<?php endif; ?> />是</label>
			<label><input name="info[display]" value="0" type="radio" <?php if(($data["display"]) == "0"): ?>checked<?php endif; ?> />否</label>
		</td>
	</tr>
</table>
</form>