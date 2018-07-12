<?php if (!defined('THINK_PATH')) exit();?><!-- 群组列表 -->
<?php $rand = round(microtime(true),3)*1000;?>
<table id="groupList_<?php echo ($rand); ?>" class="easyui-datagrid" title="<?php echo ($currentpos); ?>" data-options="
	fit:true,rownumbers:true,animate:true,fitColumns:true,
	url:'<?php echo U('Index/index');?>',border:false,
	toolbar:'#groupToolbar_<?php echo ($rand); ?>',pagination:true,singleSelect:true">
<thead>
	<tr>
		<th data-options="field:'name',width:10,align:'center'">业主名</th>
		<th data-options="field:'shop_name',width:15,align:'left'">店铺名称</th>
		<th data-options="field:'cat_name',width:10,align:'center'">店铺类型</th>
		<th data-options="field:'phone',width:10,align:'left'">电话</th>
		<th data-options="field:'address',width:30,sortable:true">地址</th>
		<th data-options="field:'status',width:5,align:'center',formatter:buildFace">状态</th>
		<th data-options="field:'create_time',width:10,align:'center'">申请时间</th>
		<th data-options="field:'id',width:10,formatter:groupOperateText">操作</th>
	</tr>
</thead>
</table>

<div id="groupToolbar_<?php echo ($rand); ?>" style="padding:5px;height:auto">
	<form id="groupSearchForm_<?php echo ($rand); ?>">
		<a href="javascript:;" onclick="groupRefreshList_<?php echo ($rand); ?>();" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true">刷新</a>
		<!-- 认证状态:  -->
		<select name="search[audit]" class="easyui-combobox" panelHeight="auto" style="width:100px">
			<option value="0">未审核</option>
			<option value="1">已通过</option>
			<option value="2">未通过</option>
			<option value="" selected="selected">所有</option>
		</select>
		<input type="text" name="search[name]" placeholder="根据业主名称搜索" style="height: 20px; width: 120px;padding-left: 3px;">
		<a href="javascript:;" onclick="groupSearch_<?php echo ($rand); ?>();" class="easyui-linkbutton" iconCls="icon-search">确定</a>		
	</form>
</div>

<script type="text/javascript">
//刷新
function groupRefreshList_<?php echo ($rand); ?>(){
	$('#groupList_<?php echo ($rand); ?>').datagrid('reload');
}
//状态
function buildFace(val){
	if(val == "0"){
		return '未审核';
	}else if(val == "1"){
		return '通过';
	}else if(val == "2"){
		return '未通过';
	}
}
//操作格式化
function groupOperateText(val, row, index){
	var btn = [];
	if(row.status == 0){
		btn.push('<a href="javascript:void(0);" onclick="audit('+val+',1)">通过审核</a>');
		btn.push('<a href="javascript:void(0);" onclick="audit('+val+',2)">不通过审核</a>');
	}else{
		if(row.status == 1){
			return "已通过审核";
		}else{
			return "未通过审核";
		}
	}
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
//审核
function audit(id,status){
	$.messager.confirm('提示信息', '确定操作吗？', function(result){
		if(!result) return false;
		$.post('<?php echo U('Index/audit');?>', {id: id, status: status}, function(data){
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