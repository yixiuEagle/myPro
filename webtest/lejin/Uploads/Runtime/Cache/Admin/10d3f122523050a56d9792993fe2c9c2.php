<?php if (!defined('THINK_PATH')) exit();?><!-- 举报列表 -->
<?php $rand = round(microtime(true),3)*1000;?>
<table id="jubaoList_<?php echo ($rand); ?>" class="easyui-datagrid" title="<?php echo ($currentpos); ?>" data-options="
	fit:true,rownumbers:true,animate:true,fitColumns:true,
	url:'<?php echo U('jubao/jubao');?>',idField:'id',border:false,
	toolbar:'#jubaoToolbar_<?php echo ($rand); ?>',pagination:true,singleSelect:true,nowrap:false">
<thead>
	<tr>		
		<th data-options="field:'uname',width:15,align:'left'">举报用户</th>
		<th data-options="field:'fname',width:15,align:'left'">被举报者</th>
		<th data-options="field:'content',width:40,align:'left'">内容</th>
		<th data-options="field:'typetext',width:10,align:'left'">类型</th>
		<th data-options="field:'createtime',width:15,align:'left'">时间</th>
		<th data-options="field:'id',width:20,formatter:jubaoOperateText">操作</th>
	</tr>
</thead>
</table>

<div id="jubaoToolbar_<?php echo ($rand); ?>" style="padding:5px;height:auto">
	<form id="jubaoSearchForm_<?php echo ($rand); ?>">
<!-- 		<a href="javascript:;" onclick="jubaoAdd();" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">添加</a>
 -->		<a href="javascript:;" onclick="jubaoRefreshList_<?php echo ($rand); ?>();" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true">刷新</a>		
	</form>
</div>

<!-- 添加 -->
<div id="jubaoAddBox" class="easyui-dialog" title="家长圈添加"
	data-options="modal:true,closed:true,iconCls:'icon-edit',buttons:[{text:'确定',iconCls:'icon-ok',handler:function(){$('#jubaoAddForm').submit();}},{text:'取消',iconCls:'icon-cancel',handler:function(){$('#jubaoAddBox').dialog('close');}}]"
	style="width: 480px;; height: 320px;"></div>
	
<!-- 编辑 -->
<div id="jubaoEditBox" class="easyui-dialog" title="发送消息"
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
		btn.push('<a href="javascript:void(0);" onclick="jubaoDelete('+val+')">删除</a>');
	if (row.type == 0){
		if (row.isshield == 1){
			btn.push('<a href="javascript:void(0);" onclick="cancelShield('+row.otherid+')">取消屏蔽</a>');
		}else{
			btn.push('<a href="javascript:void(0);" onclick="jubaoShield('+row.otherid+')">屏蔽用户</a>');
		}
	}
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
//删除 
function jubaoDelete(id){
	if(typeof(id) !== 'number'){
		$.messager.alert('提示信息', '未选择家长圈', 'error');
		return false;
	}
	$.messager.confirm('提示信息', '确定要删除吗？', function(result){
		if(!result) return false;
		$.post('<?php echo U('jubao/jubaoDelete');?>', {id: id}, function(data){
			if(!data.status){
				$.messager.alert('提示信息', data.info, 'error');
			}else{
				jubaoRefreshList_<?php echo ($rand); ?>();
				//$.messager.alert('提示信息', data.info, 'info');
			}
		}, 'json');
	});
}
//屏蔽用户
function jubaoShield(id){
	if(typeof(id) !== 'number'){
		$.messager.alert('提示信息', '请选择屏蔽用户', 'error');
		return false;
	}
	$.messager.confirm('提示信息', '确定要屏蔽吗？', function(result){
		if(!result) return false;
		$.post('<?php echo U('jubao/jubaoShield');?>', {id: id}, function(data){
			if(!data.status){
				$.messager.alert('提示信息', data.info, 'error');
			}else{
				jubaoRefreshList_<?php echo ($rand); ?>();
				//$.messager.alert('提示信息', data.info, 'info');
			}
		}, 'json');
	});
}
//取消屏蔽
function cancelShield(id){
	if(typeof(id) !== 'number'){
		$.messager.alert('提示信息', '请选择屏蔽用户', 'error');
		return false;
	}
	$.messager.confirm('提示信息', '确定要屏蔽吗？', function(result){
		if(!result) return false;
		$.post('<?php echo U('jubao/cancelShield');?>', {id: id}, function(data){
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