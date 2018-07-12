<?php if (!defined('THINK_PATH')) exit();?><!-- 反馈列表 -->
<?php $rand = round(microtime(true),3)*1000;?>
<table id="feedbackList_<?php echo ($rand); ?>" class="easyui-datagrid" title="<?php echo ($currentpos); ?>" data-options="
	fit:true,rownumbers:true,animate:true,fitColumns:true,
	url:'<?php echo U('Jubao/feedback');?>',idField:'id',border:false,
	toolbar:'#feedbackToolbar_<?php echo ($rand); ?>',pagination:true,singleSelect:true,nowrap:false">
<thead>
	<tr>		
		<th data-options="field:'uid',width:15,align:'left'">反馈者ID</th>
		<th data-options="field:'name',width:15,align:'left'">反馈者</th>
		<th data-options="field:'content',width:40,align:'left'">内容</th>
		<th data-options="field:'createtime',width:15,align:'left'">时间</th>
		<th data-options="field:'id',width:20,formatter:feedbackOperateText">操作</th>
	</tr>
</thead>
</table>
	
<div id="feedbackToolbar_<?php echo ($rand); ?>" style="padding:5px;height:auto">
	<form id="feedbackSearchForm_<?php echo ($rand); ?>">
<!-- 		<a href="javascript:;" onclick="jubaoAdd();" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">添加</a>
 -->		<a href="javascript:;" onclick="feedbackRefreshList_<?php echo ($rand); ?>();" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true">刷新</a>		
	</form>
</div>

<!-- 编辑 -->
<div id="jubaoEditBox" class="easyui-dialog" title="发送消息"
	data-options="modal:true,closed:true,iconCls:'icon-edit',buttons:[{text:'确定',iconCls:'icon-ok',handler:function(){$('#jubaoEditForm').submit();}},{text:'取消',iconCls:'icon-cancel',handler:function(){$('#jubaoEditBox').dialog('close');}}]"
	style="width: 480px; height: 320px;"></div>
	
<script type="text/javascript">
//刷新
function feedbackRefreshList_<?php echo ($rand); ?>(){
	$('#feedbackList_<?php echo ($rand); ?>').datagrid('reload');
}
//操作格式化
function feedbackOperateText(val, row, index){
	var btn = [];
	btn.push('<a href="javascript:void(0)" onclick="message('+row.uid+')">发送消息</a>');
	return btn.join(' | ');
}
//发送消息
function message(id){
	if(typeof(id) !== 'number'){
		$.messager.alert('提示信息', '未选择用户', 'error');
		return false;
	}
	var url = '<?php echo U('jubao/message');?>';
	url += url.indexOf('?') != -1 ? '&id='+id : '?id='+id;
	url += '&rand=<?php echo ($rand); ?>';
	$('#jubaoEditBox').dialog({href:url});
	$('#jubaoEditBox').dialog('open');
}
</script>