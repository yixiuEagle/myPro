<?php if (!defined('THINK_PATH')) exit();?><!-- 用户列表 -->
<?php $rand = round(microtime(true),3)*1000;?>
<table id="userList_<?php echo ($rand); ?>" class="easyui-datagrid" title="<?php echo ($currentpos); ?>" data-options="
	fit:true,rownumbers:true,animate:true,fitColumns:false,
	url:'<?php echo U('User/extract',array('uid'=>I('uid',0)));?>',idField:'uid',border:false,
	toolbar:'#userToolbar_<?php echo ($rand); ?>',pagination:true,singleSelect:true">
<thead>
	<tr>
		<th data-options="field:'uid',width:100,align:'center'">用户uid</th>
		<th data-options="field:'name',width:120,align:'center'">昵称</th>
		<th data-options="field:'balance',width:120,align:'center'">余额</th>
		<th data-options="field:'account_name',width:120,align:'center'">账户名称</th>
		<th data-options="field:'account_number',width:120,align:'center'">支付宝账号</th>
		<th data-options="field:'price',width:100,align:'center'">提现金额</th>
		<th data-options="field:'create_time',width:100,align:'center'">申请时间</th>
		 <th data-options="field:'id',width:150,align:'center',formatter:userOperateText">操作</th>
	</tr>
</thead>
</table>

<div id="userToolbar_<?php echo ($rand); ?>" style="padding:5px;height:auto">
	<form id="userSearchForm_<?php echo ($rand); ?>">
		<a href="javascript:;" onclick="userRefreshList_<?php echo ($rand); ?>();" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true">刷新</a>
		<input type="text" name="search[name]" placeholder="根据昵称搜索" style="height: 20px; width: 120px;padding-left: 3px;">
		<a href="javascript:;" onclick="userSearch_<?php echo ($rand); ?>();" class="easyui-linkbutton" iconCls="icon-search">确定</a>		
	</form>
</div>

<script type="text/javascript">
//刷新
function userRefreshList_<?php echo ($rand); ?>(){
	$('#userList_<?php echo ($rand); ?>').datagrid('reload');
}
//操作格式化
function userOperateText(val, row, index){
	if(row.status == 1){
		return "已通过";
	}
	if(row.status == 2){
		return "不通过";
	}
	var btn = [];
	btn.push('<a href="javascript:void(0);" onclick="userDetail('+row.id+',1)">审核通过</a>');
	btn.push('<a href="javascript:void(0);" onclick="userDetail('+row.id+',2)">审核不通过</a>');
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
function userDetail(id,status){
	$.messager.confirm('提示信息', '确定要审核吗？', function(result){
		if(!result) return false;
		$.post('<?php echo U('User/extractCheck');?>', {id: id,status:status}, function(data){
			if(!data.status){
				$.messager.alert('提示信息', data.info, 'error');
			}else{
				userRefreshList_<?php echo ($rand); ?>();
				$.messager.alert('提示信息', data.info, 'info');
			}
		}, 'json');
	});
}
</script>