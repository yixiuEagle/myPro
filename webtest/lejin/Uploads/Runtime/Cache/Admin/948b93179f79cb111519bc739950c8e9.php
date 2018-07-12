<?php if (!defined('THINK_PATH')) exit();?><!-- 举报列表 -->
<?php $rand = round(microtime(true),3)*1000;?>
<table id="jubaoList_<?php echo ($rand); ?>" class="easyui-datagrid" title="<?php echo ($currentpos); ?>" data-options="
	fit:true,rownumbers:true,animate:true,fitColumns:true,
	url:'<?php echo U('jubao/index');?>',idField:'id',border:false,
	toolbar:'#jubaoToolbar_<?php echo ($rand); ?>',pagination:true,singleSelect:true,nowrap:false">
<thead>
	<tr>		
		<th data-options="field:'content',width:20,align:'left'">内容</th>
		<th data-options="field:'id',width:10,formatter:jubaoOperateText">操作</th>
	</tr>
</thead>
</table>

<div id="jubaoToolbar_<?php echo ($rand); ?>" style="padding:5px;height:auto">
	<form id="jubaoSearchForm_<?php echo ($rand); ?>">
		<a href="javascript:;" onclick="jubaoAdd();" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">添加</a>
		<a href="javascript:;" onclick="jubaoRefreshList_<?php echo ($rand); ?>();" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true">刷新</a>		
	</form>
</div>

<!-- 添加 -->
<div id="jubaoAddBox" class="easyui-dialog" title="发送消息"
	data-options="modal:true,closed:true,iconCls:'icon-edit',buttons:[{text:'确定',iconCls:'icon-ok',handler:function(){$('#jubaoAddForm').submit();}},{text:'取消',iconCls:'icon-cancel',handler:function(){$('#jubaoAddBox').dialog('close');}}]"
	style="width: 480px;; height: 320px;"></div>
	
<!-- 编辑 -->
<div id="jubaoEditBox" class="easyui-dialog" title="举报编辑"
	data-options="modal:true,closed:true,iconCls:'icon-edit',buttons:[{text:'确定',iconCls:'icon-ok',handler:function(){$('#jubaoEditForm').submit();}},{text:'取消',iconCls:'icon-cancel',handler:function(){$('#jubaoEditBox').dialog('close');}}]"
	style="width: 480px; height: 320px;"></div>
	
<script type="text/javascript">
//刷新
function jubaoRefreshList_<?php echo ($rand); ?>(){
	$('#jubaoList_<?php echo ($rand); ?>').datagrid('reload');
}
//头像显示
function buildFace(val,row,index){
	if(!val){
		return '<div style="height:60px;padding:3px;margin:auto;"></div>';
	}else{
		return '<img src="/webtest/lejin'+val+'" height="60" style="padding:3px;">';	
	}
}
//操作格式化
function jubaoOperateText(val, row, index){
	var btn = [];
		btn.push('<a href="javascript:void(0);" onclick="jubaoEdit('+val+')">编辑</a>');
		btn.push('<a href="javascript:void(0);" onclick="jubaoDelete('+val+')">删除</a>');
	return btn.join(' | ');
}
//搜索用户
function jubaoSearch_<?php echo ($rand); ?>(){
	var queryParams = $('#jubaoList_<?php echo ($rand); ?>').datagrid('options').queryParams;
	$.each($("#jubaoSearchForm_<?php echo ($rand); ?>").form().serializeArray(), function (index) {
		queryParams[this['name']] = this['value'];
	});
	$('#jubaoList_<?php echo ($rand); ?>').datagrid('load');
}
//添加
function jubaoAdd(){
	var url = '<?php echo U('jubao/add',array('rand'=>$rand));?>';
	$('#jubaoAddBox').dialog({href:url});
	$('#jubaoAddBox').dialog('open');
}
//编辑
function jubaoEdit(id){
	if(typeof(id) !== 'number'){
		$.messager.alert('提示信息', '未选择举报', 'error');
		return false;
	}
	var url = '<?php echo U('jubao/edit');?>';
	url += url.indexOf('?') != -1 ? '&id='+id : '?id='+id;
	url += '&rand=<?php echo ($rand); ?>';
	$('#jubaoEditBox').dialog({href:url});
	$('#jubaoEditBox').dialog('open');
}
//删除 
function jubaoDelete(id){
	if(typeof(id) !== 'number'){
		$.messager.alert('提示信息', '未选择举报', 'error');
		return false;
	}
	$.messager.confirm('提示信息', '确定要删除吗？', function(result){
		if(!result) return false;
		$.post('<?php echo U('jubao/delete');?>', {id: id}, function(data){
			if(!data.status){
				$.messager.alert('提示信息', data.info, 'error');
			}else{
				jubaoRefreshList_<?php echo ($rand); ?>();
				//$.messager.alert('提示信息', data.info, 'info');
			}
		}, 'json');
	});
}
</script>