<?php if (!defined('THINK_PATH')) exit();?><!-- 类别列表 -->
<table id="categoryList" class="easyui-datagrid"
	title="<?php echo ($currentpos); ?>"
	data-options="border:false,fit:true,fitColumns:false,rownumbers:true,singleSelect:true,animate:true,
				url:'<?php echo U('category/index');?>',idField:'id',pagination:true,
				toolbar:categoryToolbar">
	<thead>
		<tr>
			<th data-options="field:'name',width:300,align:'center'">名称</th>
			<th data-options="field:'id',width:200,align:'center',formatter:categoryOperateText">操作</th>
		</tr>
	</thead>
</table>
<!-- 添加行业 -->
<div id="categoryAddBox" class="easyui-dialog" title="添加行业"
	data-options="modal:true,closed:true,iconCls:'icon-add',buttons:[{text:'确定',iconCls:'icon-ok',handler:function(){$('#categoryAddForm').submit();}},{text:'取消',iconCls:'icon-cancel',handler:function(){$('#categoryAddBox').dialog('close');}}]"
	style="width: 480px; height: 300px;"></div>

<!-- 编辑行业 -->
<div id="categoryEditBox" class="easyui-dialog" title="编辑行业"
	data-options="modal:true,closed:true,iconCls:'icon-edit',buttons:[{text:'确定',iconCls:'icon-ok',handler:function(){$('#categoryEditForm').submit();}},{text:'取消',iconCls:'icon-cancel',handler:function(){$('#categoryEditBox').dialog('close');}}]"
	style="width: 480px; height: 300px;"></div>
	
<script type="text/javascript">
var categoryToolbar = [
	{ text: '刷新', iconCls: 'icon-reload', handler: categoryRefreshList },
	{ text: '添加', iconCls: 'icon-add', handler: categoryAdd },
];
//格式化操作内容
function categoryOperateText(id){
	var btn = [];
		btn.push('<a href="javascript:void(0);" onclick="categoryEdit('+id+')">编辑</a>');
		btn.push('<a href="javascript:void(0);" onclick="categoryDelete('+id+')">删除</a>');
	return btn.join(' | ');
}
//刷新
function categoryRefreshList(){
	$('#categoryList').datagrid('reload');
}
//添加
function categoryAdd(){
	$('#categoryAddBox').dialog({ href:'<?php echo U('category/add');?>' });
	$('#categoryAddBox').dialog('open');
}
//编辑
function categoryEdit(id){
	$('#categoryEditBox').dialog({ href:'<?php echo U('category/edit');?>' + '?id=' + id });
	$('#categoryEditBox').dialog('open');
}
//删除
function categoryDelete(id){
	if(typeof(id) !== 'number'){
		$.messager.alert('提示信息', '未选择类别', 'error');
		return false;
	}
	$.messager.confirm('提示信息', '确定要删除吗？', function(result){
		if(!result) return false;
		$.post('<?php echo U('Category/delete');?>', { id: id}, function(data){
			if(!data.status){
				$.messager.alert('提示信息', data.info, 'error');
			}else{
				categoryRefreshList();
				$.messager.alert('提示信息', data.info, 'info');
			}
		}, 'json');
	});
}
</script>