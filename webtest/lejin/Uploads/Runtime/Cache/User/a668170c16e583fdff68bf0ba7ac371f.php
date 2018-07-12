<?php if (!defined('THINK_PATH')) exit();?><!-- 会员列表 -->
<?php $rand = round(microtime(true),3)*1000;?>
<table id="memberList_<?php echo ($rand); ?>" class="easyui-datagrid" title="<?php echo ($currentpos); ?>" data-options="
	fit:true,rownumbers:true,animate:true,fitColumns:true,
	url:'<?php echo U('member/index');?>',idField:'id',border:false,
	toolbar:'#memberToolbar_<?php echo ($rand); ?>',pagination:true,singleSelect:true,nowrap:false
	">
<thead>
	<tr>
		<th rowspan="2" data-options="field:'name',width:20,align:'center'">会员名称</th>
        <th colspan="2" align="center">个人资料</th>
        <th colspan="4" align="center">号资料</th>
        <th colspan="2" align="center">信息发布</th>
        <th colspan="2" align="center">其他</th>
        <th rowspan="2" align="center" data-options="field:'id',width:20,formatter:memberOperateText">操作</th>
    </tr>
	<tr>		
		<th data-options="field:'userimage',width:20,align:'center'">主图修改</th>
		<th data-options="field:'headcount',width:20,align:'center'">头像</th>
		<th data-options="field:'groupimage',width:20,align:'center'">主图修改</th>
		<th data-options="field:'groupheadcount',width:20,align:'center'">头像</th>
		<th data-options="field:'groupcount',width:20,align:'center'">可创建号</th>
		<th data-options="field:'groupshow',width:20,align:'center'">位置信息</th>
		<th data-options="field:'messagecount',width:20,align:'center'">数量/每天</th>
		<th data-options="field:'isvisible',width:20,align:'center'">可见范围</th>
		<th data-options="field:'logo',width:20,align:'center',formatter:buildFace">会员标识</th>
		<th data-options="field:'monthfee',width:20,align:'center'">会费/月</th>
	</tr>
</thead>
</table>

<div id="memberToolbar_<?php echo ($rand); ?>" style="padding:5px;height:auto">
	<form id="memberSearchForm_<?php echo ($rand); ?>">
		<!-- <a href="javascript:;" onclick="memberAdd();" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">添加</a> -->
		<a href="javascript:;" onclick="memberRefreshList_<?php echo ($rand); ?>();" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true">刷新</a>		
	</form>
</div>

<!-- 添加 -->
<div id="memberAddBox" class="easyui-dialog" title="会员添加"
	data-options="modal:true,closed:true,iconCls:'icon-edit',buttons:[{text:'确定',iconCls:'icon-ok',handler:function(){$('#memberAddForm').submit();}},{text:'取消',iconCls:'icon-cancel',handler:function(){$('#memberAddBox').dialog('close');}}]"
	style="width: 480px;; height: 320px;"></div>
	
<!-- 编辑 -->
<div id="memberEditBox" class="easyui-dialog" title="会员编辑"
	data-options="modal:true,closed:true,iconCls:'icon-edit',buttons:[{text:'确定',iconCls:'icon-ok',handler:function(){$('#memberEditForm').submit();}},{text:'取消',iconCls:'icon-cancel',handler:function(){$('#memberEditBox').dialog('close');}}]"
	style="width: 320px; height: 500px;"></div>
	
<script type="text/javascript">
//刷新
function memberRefreshList_<?php echo ($rand); ?>(){
	$('#memberList_<?php echo ($rand); ?>').datagrid('reload');
}
//头像显示
function buildFace(val,row,index){
	if(!val){
		return '<div style="height:40px;padding:3px;margin:auto;"></div>';
	}else{
		return '<img src="'+val+'" height="40" style="padding:3px;">';	
	}
}
//操作格式化
function memberOperateText(val, row, index){
	var btn = [];
		btn.push('<a href="javascript:void(0);" onclick="memberEdit('+val+')">编辑</a>');
		//btn.push('<a href="javascript:void(0);" onclick="memberDelete('+val+')">删除</a>');
	return btn.join(' | ');
}
//搜索用户
function memberSearch_<?php echo ($rand); ?>(){
	var queryParams = $('#memberList_<?php echo ($rand); ?>').datagrid('options').queryParams;
	$.each($("#memberSearchForm_<?php echo ($rand); ?>").form().serializeArray(), function (index) {
		queryParams[this['name']] = this['value'];
	});
	$('#memberList_<?php echo ($rand); ?>').datagrid('load');
}
//添加
function memberAdd(){
	var url = '<?php echo U('member/add',array('rand'=>$rand));?>';
	$('#memberAddBox').dialog({href:url});
	$('#memberAddBox').dialog('open');
}
//编辑
function memberEdit(id){
	if(typeof(id) !== 'number'){
		$.messager.alert('提示信息', '未选择会员', 'error');
		return false;
	}
	var url = '<?php echo U('member/edit');?>';
	url += url.indexOf('?') != -1 ? '&id='+id : '?id='+id;
	url += '&rand=<?php echo ($rand); ?>';
	$('#memberEditBox').dialog({href:url});
	$('#memberEditBox').dialog('open');
}
//删除 
function memberDelete(id){
	if(typeof(id) !== 'number'){
		$.messager.alert('提示信息', '未选择会员', 'error');
		return false;
	}
	$.messager.confirm('提示信息', '确定要删除吗？', function(result){
		if(!result) return false;
		$.post('<?php echo U('member/delete');?>', {id: id}, function(data){
			if(!data.status){
				$.messager.alert('提示信息', data.info, 'error');
			}else{
				memberRefreshList_<?php echo ($rand); ?>();
				//$.messager.alert('提示信息', data.info, 'info');
			}
		}, 'json');
	});
}
</script>