<?php if (!defined('THINK_PATH')) exit();?><!-- 类别列表 -->
<?php $rand = round(microtime(true),3)*1000;?>
<table id="bannerList_<?php echo ($rand); ?>" class="easyui-datagrid" title="<?php echo ($currentpos); ?>" data-options="
	fit:true,rownumbers:true,animate:true,fitColumns:true,
	url:'<?php echo U('banner/index');?>',idField:'id',border:false,
	toolbar:'#bannerToolbar_<?php echo ($rand); ?>',pagination:true,singleSelect:true">
<thead>
	<tr>
		<th data-options="field:'actiontext',width:120,align:'center'">类型</th>
		<th data-options="field:'image',width:100,align:'center',formatter:buildFace">图片</th>
		<th data-options="field:'id',width:100,align:'center',formatter:bannerOperateText">操作</th>
	</tr>
</thead>
</table>

<div id="bannerToolbar_<?php echo ($rand); ?>" style="padding:5px;height:auto">
	<form id="bannerSearchForm_<?php echo ($rand); ?>">
		<a href="javascript:;" onclick="bannerAdd();" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">新增</a>
		<a href="javascript:;" onclick="bannerRefreshList_<?php echo ($rand); ?>();" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true">刷新</a>
		<input type="text" name="search[name]" placeholder="根据昵称搜索" style="height: 20px; width: 120px;padding-left: 3px;">
		<a href="javascript:;" onclick="bannerSearch_<?php echo ($rand); ?>();" class="easyui-linkbutton" iconCls="icon-search">确定</a>		
	</form>
</div>
	
<!-- 添加 -->
<div id="bannerAddBox" class="easyui-dialog" title="添加banner"
	data-options="modal:true,closed:true,iconCls:'icon-add',buttons:[{text:'确定',iconCls:'icon-ok',handler:function(){$('#bannerAddForm').submit();}},{text:'取消',iconCls:'icon-cancel',handler:function(){$('#bannerAddBox').dialog('close');}}]"
	style="width: 800px; height: 600px;"></div>
	
<!-- 编辑 -->
<div id="bannerEditBox" class="easyui-dialog" title="编辑类别"
	data-options="modal:true,closed:true,iconCls:'icon-add',
				buttons:[{text:'确定',iconCls:'icon-ok',
				handler:function(){$('#bannerEditForm').submit();}},
				{text:'取消',iconCls:'icon-cancel',
				handler:function(){$('#bannerEditBox').dialog('close');}}]"
	style="width: 800px; height: 600px;"></div>

<script type="text/javascript">
//刷新
function bannerRefreshList_<?php echo ($rand); ?>(){
	$('#bannerList_<?php echo ($rand); ?>').datagrid('reload');
}
//头像显示
function buildFace(val,row,index){
	if(!val){
		return '<div style="height:60px;padding:3px;margin:auto;"></div>';
	}else{
		return '<div style="padding:3px;"><img src="/webtest/lejin'+val+'" height="60" style="padding:1px;border:1px solid #ccc;"></div>';	
	}
}
//操作格式化
function bannerOperateText(val, row, index){
	var btn = [];
		btn.push('<a href="javascript:void(0);" onclick="bannerEdit('+val+')">编辑</a>');
		btn.push('<a href="javascript:void(0);" onclick="bannerDelete('+val+')">删除</a>');
	return btn.join(' | ');
}
//搜索类别
function bannerSearch_<?php echo ($rand); ?>(){
	var queryParams = $('#bannerList_<?php echo ($rand); ?>').datagrid('options').queryParams;
	$.each($("#bannerSearchForm_<?php echo ($rand); ?>").form().serializeArray(), function (index) {
		queryParams[this['name']] = this['value'];
	});
	$('#bannerList_<?php echo ($rand); ?>').datagrid('load');
}
//类别添加
function bannerAdd(){
	var url = '<?php echo U('banner/add');?>';
	url += url.indexOf('?') != -1 ? '&rand=<?php echo ($rand); ?>' : '?rand=<?php echo ($rand); ?>';
	$('#bannerAddBox').dialog({href:url});
	$('#bannerAddBox').dialog('open');
}
//类别编辑
function bannerEdit(id){
	if(typeof(id) !== 'number'){
		$.messager.alert('提示信息', '未选择菜单', 'error');
		return false;
	}
	var url = '<?php echo U('banner/edit');?>';
	url += url.indexOf('?') != -1 ? '&id='+id : '?id='+id;
	url += '&rand=<?php echo ($rand); ?>';
	$('#bannerEditBox').dialog({href:url});
	$('#bannerEditBox').dialog('open');
}
//类别删除 
function bannerDelete(id){
	if(typeof(id) !== 'number'){
		$.messager.alert('提示信息', '未选择', 'error');
		return false;
	}
	$.messager.confirm('提示信息', '确定要删除吗？', function(result){
		if(!result) return false;
		$.post('<?php echo U('banner/delete');?>', {id: id}, function(data){
			if(!data.status){
				$.messager.alert('提示信息', data.info, 'error');
			}else{
				bannerRefreshList_<?php echo ($rand); ?>();
				$.messager.alert('提示信息', data.info, 'info');
			}
		}, 'json');
	});
}
</script>