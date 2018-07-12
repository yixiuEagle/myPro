<?php if (!defined('THINK_PATH')) exit();?><!-- 管理员列表 -->
<table id="AdminList" class="easyui-datagrid" title="<?php echo ($currentpos); ?>"
	data-options="border:false,fit:true,fitColumns:true,rownumbers:true,singleSelect:true,
	url:'<?php echo U('Admin/index');?>',toolbar:AdminToolbar,method:'post'">
	<thead>
		<tr>
			<th data-options="field:'username',width:15,sortable:true">用户名</th>
			<th data-options="field:'rolename',width:15,sortable:true">所属角色</th>
			<th data-options="field:'lastloginip',width:15,sortable:true">最后登录IP</th>
			<th
				data-options="field:'lastlogintime',width:15,formatter:AdminTimeText,sortable:true">最后登录时间</th>
			<th data-options="field:'email',width:25,sortable:true">E-mail</th>
			<th data-options="field:'realname',width:15,sortable:true">真实姓名</th>
			<th data-options="field:'userid',width:15,formatter:AdminOperateText">管理操作</th>
		</tr>
	</thead>
</table>

<!-- 添加管理员 -->
<div id="AdminAddBox" class="easyui-dialog" title="添加管理员"
	data-options="modal:true,closed:true,iconCls:'icon-add',buttons:[{text:'确定',iconCls:'icon-ok',handler:function(){$('#AdminAddForm').submit();}},{text:'取消',iconCls:'icon-cancel',handler:function(){$('#AdminAddBox').dialog('close');}}]"
	style="width: 540px; height: 300px;"></div>

<!-- 编辑管理员 -->
<div id="AdminEditBox" class="easyui-dialog" title="编辑管理员"
	data-options="modal:true,closed:true,iconCls:'icon-edit',buttons:[{text:'确定',iconCls:'icon-ok',handler:function(){$('#AdminEditForm').submit();}},{text:'取消',iconCls:'icon-cancel',handler:function(){$('#AdminEditBox').dialog('close');}}]"
	style="width: 540px; height: 300px;"></div>

<script type="text/javascript">
//工具栏
var AdminToolbar = [
	{ text: '添加管理员', iconCls: 'icon-add', handler: AdminAdd },
	{ text: '刷新', iconCls: 'icon-reload', handler: AdminReload }
];
//生成登录时间内容
function AdminTimeText(val){
	return val != '1970-01-01 08:00:00' ? val : '';
}
//生成操作内容
function AdminOperateText(val){
	var btn = [];
	btn.push('<a href="javascript:void(0);" onclick="AdminEdit('+val+')">编辑</a>');
	val == 1 ? btn.push('删除') : btn.push('<a href="javascript:void(0);" onclick="AdminDelete('+val+')">删除</a>');
	return btn.join(' | ');
}
//添加
function AdminAdd(){
	var url = '<?php echo U('Admin/add');?>';
	$('#AdminAddBox').dialog({href:url});
	$('#AdminAddBox').dialog('open');
}
//编辑
function AdminEdit(id){
	if(typeof(id) !== 'number'){
		$.messager.alert('提示信息', '未选择管理员', 'error');
		return false;
	}
	var url = '<?php echo U('Admin/edit');?>';
	url += url.indexOf('?') != -1 ? '&id='+id : '?id='+id;
	$('#AdminEditBox').dialog({href:url});
	$('#AdminEditBox').dialog('open');
}
//删除菜单
function AdminDelete(id){
	if(typeof(id) !== 'number'){
		$.messager.alert('提示信息', '未选择管理员', 'error');
		return false;
	}
	$.messager.confirm('提示信息', '确定要删除吗？', function(result){
		if(!result) return false;
		$.post('<?php echo U('admin/delete');?>', {id: id}, function(data){
			if(!data.status){
				$.messager.alert('提示信息', data.info, 'error');
			}else{
				AdminReload();
				$.messager.alert('提示信息', data.info, 'info');
			}
		}, 'json');
	});
}
//刷新
function AdminReload(){
	$('#AdminList').datagrid('reload');
}
</script>