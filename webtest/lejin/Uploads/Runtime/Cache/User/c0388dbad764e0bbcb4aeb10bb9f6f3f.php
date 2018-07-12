<?php if (!defined('THINK_PATH')) exit();?><!-- 用户列表 -->
<?php $rand = round(microtime(true),3)*1000;?>
<table id="userList_<?php echo ($rand); ?>" class="easyui-datagrid" title="<?php echo ($currentpos); ?>" data-options="
	fit:true,rownumbers:true,animate:true,fitColumns:false,
	url:'<?php echo U('User/index',array('uid'=>I('uid',0)));?>',idField:'uid',border:false,
	toolbar:'#userToolbar_<?php echo ($rand); ?>',pagination:true,singleSelect:true">
<thead>
	<tr>
		<th data-options="field:'uid',width:100,align:'center'">用户uid</th>
		<th data-options="field:'head',width:100,align:'center',formatter:buildFace">头像</th>
		<th data-options="field:'name',width:120,align:'center'">昵称</th>
		<th data-options="field:'balance',width:120,align:'center'">余额</th>
		 <th data-options="field:'id',width:100,align:'center',formatter:userOperateText">操作</th>
	</tr>
</thead>
</table>

<div id="userToolbar_<?php echo ($rand); ?>" style="padding:5px;height:auto">
	<form id="userSearchForm_<?php echo ($rand); ?>">
		<a href="javascript:;" onclick="userRefreshList_<?php echo ($rand); ?>();" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true">刷新</a>
		<select name="search[account]">
            <option value="0">全部</option>
            <option value="1">账户正常用户</option>
            <option value="2">账户异常用户</option>
		</select>
        <input type="text" name="search[name]" placeholder="根据昵称搜索" style="height: 20px; width: 120px;padding-left: 3px;">
		<a href="javascript:;" onclick="userSearch_<?php echo ($rand); ?>();" class="easyui-linkbutton" iconCls="icon-search">确定</a>		
	</form>
</div>

<!-- 发送消息 -->
<div id="sendMsgBox" class="easyui-dialog" title="发送消息"
	data-options="modal:true,closed:true,iconCls:'icon-add',buttons:[{text:'确定',iconCls:'icon-ok',handler:function(){$('#sendMsgForm').submit();}},{text:'取消',iconCls:'icon-cancel',handler:function(){$('#sendMsgBox').dialog('close');}}]"
	style="width: 600px; height: 300px;"></div>
<!-- 向所有用户发送消息 -->
<div id="sendAllMsgBox" class="easyui-dialog" title="向所有用户发送消息"
	data-options="modal:true,closed:true,iconCls:'icon-add',buttons:[{text:'确定',iconCls:'icon-ok',handler:function(){$('#sendAllMsgForm').submit();}},{text:'取消',iconCls:'icon-cancel',handler:function(){$('#sendAllMsgBox').dialog('close');}}]"
	style="width: 730px; height: 350px;"></div>
	
<!-- 编辑 -->
<div id="userEditBox" class="easyui-dialog" title="编辑用户"
	data-options="modal:true,closed:true,iconCls:'icon-add',
				buttons:[{text:'确定',iconCls:'icon-ok',
				handler:function(){$('#userEditForm').submit();}},
				{text:'取消',iconCls:'icon-cancel',
				handler:function(){$('#userEditBox').dialog('close');}}]"
	style="width: 600px; height: 480px;"></div>

<script type="text/javascript">
//刷新
function userRefreshList_<?php echo ($rand); ?>(){
	$('#userList_<?php echo ($rand); ?>').datagrid('reload');
}
//头像显示
function buildFace(val,row,index){
	if(!val){
		return '<div style="width:60px;height:60px;padding:1px;margin:auto;"></div>';
	}else{
		return '<div style="padding:1px;"><img src="'+val+'" height="60" width="60" style="padding:1px;border:1px solid #ccc;"></div>';	
	}
}
//性别内容格式化
function genderText(val){
	var text = '';
	switch (val) {
	case '0':
		text = '男';
		break;
	case '1':
		text = '女';
		break;
	default:
		text = '未填写';
		break;
	}
	return text;
}
//操作格式化
function userOperateText(val, row, index){
	var btn = [];
		btn.push('<a href="javascript:void(0);" onclick="userDetail('+row.uid+')">充值100元</a>');
	return btn.join(' | ');
}
//搜索用户
function userSearch_<?php echo ($rand); ?>(){
	var queryParams = $('#userList_<?php echo ($rand); ?>').datagrid('options').queryParams;
	$.each($("#userSearchForm_<?php echo ($rand); ?>").form().serializeArray(), function (index) {
		queryParams[this['name']] = this['value'];
	});
	$('#userList_<?php echo ($rand); ?>').datagrid('load');
}
function userDetail(id){
    $.post('<?php echo U('User/add100');?>', {uid: id}, function(data){
        if(!data.status){
            $.messager.alert('提示信息', data.info, 'error');
        }else{
            userRefreshList_<?php echo ($rand); ?>();
            $.messager.alert('提示信息', data.info, 'info');
        }
    }, 'json');
}
//用户编辑
function userEdit(id){
	if(typeof(id) !== 'number'){
		$.messager.alert('提示信息', '未选择菜单', 'error');
		return false;
	}
	var url = '<?php echo U('User/edit');?>';
	url += url.indexOf('?') != -1 ? '&uid='+id : '?uid='+id;
	url += '&rand=<?php echo ($rand); ?>';
	$('#userEditBox').dialog({href:url});
	$('#userEditBox').dialog('open');
}
//用户删除 
function userDelete(id){
	if(typeof(id) !== 'number'){
		$.messager.alert('提示信息', '未选择', 'error');
		return false;
	}
	$.messager.confirm('提示信息', '确定要删除吗？', function(result){
		if(!result) return false;
		$.post('<?php echo U('User/delete');?>', {uid: id}, function(data){
			if(!data.status){
				$.messager.alert('提示信息', data.info, 'error');
			}else{
				userRefreshList_<?php echo ($rand); ?>();
				$.messager.alert('提示信息', data.info, 'info');
			}
		}, 'json');
	});
}
//发送消息
function userSendMsg(id){
	var url = '<?php echo U('User/sendMsg');?>';
	url += url.indexOf('?') != -1 ? '&id='+id : '?id='+id;
	$('#sendMsgBox').dialog({href:url});
	$('#sendMsgBox').dialog('open');
}
//向所有用户发送消息
function sendAllMsg(){
	var url = '<?php echo U('User/sendallMsg');?>';
	$('#sendAllMsgBox').dialog({href:url});
	$('#sendAllMsgBox').dialog('open');
}
</script>