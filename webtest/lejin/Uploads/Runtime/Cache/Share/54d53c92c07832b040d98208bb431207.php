<?php if (!defined('THINK_PATH')) exit();?><!-- 类别列表 -->
<?php $rand = round(microtime(true),3)*1000;?>
<table id="categoryList_<?php echo ($rand); ?>" class="easyui-datagrid" title="<?php echo ($currentpos); ?>" data-options="
	fit:true,rownumbers:true,animate:true,fitColumns:true,
	url:'<?php echo U('category/index');?>',idField:'id',border:false,
	toolbar:'#categoryToolbar_<?php echo ($rand); ?>',pagination:true,singleSelect:true">
<thead>
	<tr>
		<th data-options="field:'name',width:120,align:'center'">昵称</th>
		<th data-options="field:'alias',width:120,align:'center'">别名</th>
		<th data-options="field:'logo',width:100,align:'center',formatter:buildFace">logo</th>
		<th data-options="field:'id',width:100,align:'center',formatter:categoryOperateText">操作</th>
	</tr>
</thead>
</table>

<div id="categoryToolbar_<?php echo ($rand); ?>" style="padding:5px;height:auto">
	<form id="categorySearchForm_<?php echo ($rand); ?>">
		<a href="javascript:;" onclick="categoryAdd();" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">新增</a>
		<a href="javascript:;" onclick="categoryRefreshList_<?php echo ($rand); ?>();" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true">刷新</a>
		<input type="text" name="search[name]" placeholder="根据昵称搜索" style="height: 20px; width: 120px;padding-left: 3px;">
		<a href="javascript:;" onclick="categorySearch_<?php echo ($rand); ?>();" class="easyui-linkbutton" iconCls="icon-search">确定</a>		
	</form>
</div>
	
<!-- 添加 -->
<div id="categoryAddBox" class="easyui-dialog" title="添加category"
	data-options="modal:true,closed:true,iconCls:'icon-add',buttons:[{text:'确定',iconCls:'icon-ok',handler:function(){$('#categoryAddForm').submit();}},{text:'取消',iconCls:'icon-cancel',handler:function(){$('#categoryAddBox').dialog('close');}}]"
	style="width: 480px; height: 320px;"></div>
	
<!-- 编辑 -->
<div id="categoryEditBox" class="easyui-dialog" title="编辑类别"
	data-options="modal:true,closed:true,iconCls:'icon-add',
				buttons:[{text:'确定',iconCls:'icon-ok',
				handler:function(){$('#categoryEditForm').submit();}},
				{text:'取消',iconCls:'icon-cancel',
				handler:function(){$('#categoryEditBox').dialog('close');}}]"
	style="width: 480px; height: 320px;"></div>

<script type="text/javascript">
//刷新
function categoryRefreshList_<?php echo ($rand); ?>(){
	$('#categoryList_<?php echo ($rand); ?>').datagrid('reload');
}
//头像显示
function buildFace(val,row,index){
	if(!val){
		return '<div style="height:60px;padding:3px;margin:auto;"></div>';
	}else{
		return '<div style="padding:3px;"><img src="'+val+'" height="60" style="padding:1px;border:1px solid #ccc;"></div>';	
	}
}
//操作格式化
function categoryOperateText(val, row, index){
	var btn = [];
		btn.push('<a href="javascript:void(0);" onclick="categoryEdit('+val+')">编辑</a>');
		btn.push('<a href="javascript:void(0);" onclick="categoryDelete('+val+')">删除</a>');
	return btn.join(' | ');
}
//搜索类别
function categorySearch_<?php echo ($rand); ?>(){
	var queryParams = $('#categoryList_<?php echo ($rand); ?>').datagrid('options').queryParams;
	$.each($("#categorySearchForm_<?php echo ($rand); ?>").form().serializeArray(), function (index) {
		queryParams[this['name']] = this['value'];
	});
	$('#categoryList_<?php echo ($rand); ?>').datagrid('load');
}
//类别添加
function categoryAdd(){
	var url = '<?php echo U('category/add');?>';
	url += url.indexOf('?') != -1 ? '&rand=<?php echo ($rand); ?>' : '?rand=<?php echo ($rand); ?>';
	$('#categoryAddBox').dialog({href:url});
	$('#categoryAddBox').dialog('open');
}
//类别编辑
function categoryEdit(id){
	if(typeof(id) !== 'number'){
		$.messager.alert('提示信息', '未选择菜单', 'error');
		return false;
	}
	var url = '<?php echo U('category/edit');?>';
	url += url.indexOf('?') != -1 ? '&id='+id : '?id='+id;
	url += '&rand=<?php echo ($rand); ?>';
	$('#categoryEditBox').dialog({href:url});
	$('#categoryEditBox').dialog('open');
}
//类别删除 
function categoryDelete(id){
	if(typeof(id) !== 'number'){
		$.messager.alert('提示信息', '未选择', 'error');
		return false;
	}
	$.messager.confirm('提示信息', '确定要删除吗？', function(result){
		if(!result) return false;
		$.post('<?php echo U('category/delete');?>', {id: id}, function(data){
			if(!data.status){
				$.messager.alert('提示信息', data.info, 'error');
			}else{
				categoryRefreshList_<?php echo ($rand); ?>();
				$.messager.alert('提示信息', data.info, 'info');
			}
		}, 'json');
	});
}
</script>