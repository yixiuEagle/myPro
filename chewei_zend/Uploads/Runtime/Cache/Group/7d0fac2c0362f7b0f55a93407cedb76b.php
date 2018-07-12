<?php if (!defined('THINK_PATH')) exit();?><!-- 群组列表 -->
<?php $rand = round(microtime(true),3)*1000;?>
<table id="groupList_<?php echo ($rand); ?>" class="easyui-datagrid" title="<?php echo ($currentpos); ?>" data-options="
	fit:true,rownumbers:true,animate:true,fitColumns:true,
	url:'<?php echo U('Group/index',array('uid'=>I('uid',0)));?>',idField:'uid',border:false,
	toolbar:'#groupToolbar_<?php echo ($rand); ?>',pagination:true,singleSelect:true">
<thead>
	<tr>		
		<th data-options="field:'logosmall',width:20,align:'center',formatter:buildFace">logo</th>
		<th data-options="field:'creator',width:20,align:'center'">创建者</th>
		<th data-options="field:'name',width:20,align:'center'">名称</th>
		<th data-options="field:'count',width:20,align:'center'">成员数</th>
		<!-- <th data-options="field:'category',width:20,align:'center'">所属类别</th> -->
		<!-- <th data-options="field:'audit',width:20,align:'center',formatter:groupAuditText">审核状态</th> -->
		<th data-options="field:'createtime',width:20,sortable:true">创建时间</th>
		<th data-options="field:'id',width:10,formatter:groupOperateText">操作</th>
	</tr>
</thead>
</table>

<div id="groupToolbar_<?php echo ($rand); ?>" style="padding:5px;height:auto">
	<form id="groupSearchForm_<?php echo ($rand); ?>">
		<a href="javascript:;" onclick="groupRefreshList_<?php echo ($rand); ?>();" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true">刷新</a>
		<!-- 认证状态:
		<select name="search[audit]" class="easyui-combobox" panelHeight="auto" style="width:100px">
			<option value="0">未审核</option>
			<option value="1">已通过</option>
			<option value="2">未通过</option>
			<option value="3" selected="selected">所有</option>
		</select>  -->
		<input type="text" name="search[name]" placeholder="根据名称搜索" style="height: 20px; width: 120px;padding-left: 3px;">
		<a href="javascript:;" onclick="groupSearch_<?php echo ($rand); ?>();" class="easyui-linkbutton" iconCls="icon-search">确定</a>		
	</form>
</div>

<!-- 审核不通过 -->
<div id="groupAuditBox" class="easyui-dialog" title="群组审核"
	data-options="modal:true,closed:true,iconCls:'icon-edit',buttons:[{text:'确定',iconCls:'icon-ok',handler:function(){$('#groupAuditForm').submit();}},{text:'取消',iconCls:'icon-cancel',handler:function(){$('#groupAuditBox').dialog('close');}}]"
	style="width: 600px; height: 280px;"></div>

<!-- 编辑 -->
<div id="groupEditBox" class="easyui-dialog" title="群组编辑"
	data-options="modal:true,closed:true,iconCls:'icon-edit',buttons:[{text:'确定',iconCls:'icon-ok',handler:function(){$('#groupEditForm').submit();}},{text:'取消',iconCls:'icon-cancel',handler:function(){$('#groupEditBox').dialog('close');}}]"
	style="width: 600px; height: 480px;"></div>
<script type="text/javascript">
//刷新
function groupRefreshList_<?php echo ($rand); ?>(){
	$('#groupList_<?php echo ($rand); ?>').datagrid('reload');
}
//头像显示
function buildFace(val,row,index){
	if(!val){
		return '<div style="height:60px;padding:3px;margin:auto;"></div>';
	}else{
		return '<img src="'+val+'" height="60" style="padding:3px;">';	
	}
}
//操作格式化
function groupOperateText(val, row, index){
	var btn = [];
		btn.push('<a href="javascript:void(0);" onclick="groupEdit('+val+')">编辑</a>');
		btn.push('<a href="javascript:void(0);" onclick="groupDelete('+val+','+row.uid+')">删除</a>');
	return btn.join(' | ');
}
//搜索用户
function groupSearch_<?php echo ($rand); ?>(){
	var queryParams = $('#groupList_<?php echo ($rand); ?>').datagrid('options').queryParams;
	$.each($("#groupSearchForm_<?php echo ($rand); ?>").form().serializeArray(), function (index) {
		queryParams[this['name']] = this['value'];
	});
	$('#groupList_<?php echo ($rand); ?>').datagrid('load');
}
//审核状态文本
function groupAuditText(val, row, index){
	var html = '<select class="easyui-combobox" panelHeight="auto" style="width:100px;" onchange="groupAuditChange(this.value,'+row.id+')">';
	if(val == 0){
		html += '<option selected="selected" value="0">未处理</option>';
		html += '<option value="1">通过</option>';
		html += '<option value="2">未通过</option>';
	}else if(val == 1){
		return '通过';
	}else{
		return '未通过';
	}
	html += '</select>';
	return html;
}
//审核
function groupAuditChange(val, id){
	if (val == 2){
		var url = '<?php echo U('Group/auditNopass');?>';
		url += url.indexOf('?') != -1 ? '&id='+id : '?id='+id;
		url += '&rand=<?php echo ($rand); ?>';
		$('#groupAuditBox').dialog({href:url});
		$('#groupAuditBox').dialog('open');
		groupRefreshList_<?php echo ($rand); ?>();
	}else if(val == 1){
		$.messager.confirm('提示信息', '确定吗？', function(result){
			if(!result) {
				groupRefreshList_<?php echo ($rand); ?>();
				return false;
			}
			$.post('<?php echo U('Group/auditPass');?>', {audit:val,id:id}, function(data){
				if(!data.status){
					$.messager.alert('提示信息', data.info, 'error');
				}else{
					groupRefreshList_<?php echo ($rand); ?>();
					$.messager.alert('提示信息', data.info, 'info');
				}
			}, 'json');
		});
	}
}
//编辑
function groupEdit(id){
	if(typeof(id) !== 'number'){
		$.messager.alert('提示信息', '未选择群组', 'error');
		return false;
	}
	var url = '<?php echo U('Group/edit');?>';
	url += url.indexOf('?') != -1 ? '&id='+id : '?id='+id;
	url += '&rand=<?php echo ($rand); ?>';
	$('#groupEditBox').dialog({href:url});
	$('#groupEditBox').dialog('open');
}
//删除 
function groupDelete(id, uid){
	if(typeof(id) !== 'number'){
		$.messager.alert('提示信息', '未选择群组', 'error');
		return false;
	}
	$.messager.confirm('提示信息', '确定要删除吗？', function(result){
		if(!result) return false;
		$.post('<?php echo U('Group/delete');?>', {id: id, uid: uid}, function(data){
			if(!data.status){
				$.messager.alert('提示信息', data.info, 'error');
			}else{
				groupRefreshList_<?php echo ($rand); ?>();
				$.messager.alert('提示信息', data.info, 'info');
			}
		}, 'json');
	});
}
</script>