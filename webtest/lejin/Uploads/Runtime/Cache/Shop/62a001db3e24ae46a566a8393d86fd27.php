<?php if (!defined('THINK_PATH')) exit();?><!-- 群组列表 -->
<?php $rand = round(microtime(true),3)*1000;?>
<table id="groupList_<?php echo ($rand); ?>" class="easyui-datagrid" title="<?php echo ($currentpos); ?>" data-options="
	fit:true,rownumbers:true,animate:true,fitColumns:true,
	url:'<?php echo U('Goods/index');?>',border:false,
	toolbar:'#groupToolbar_<?php echo ($rand); ?>',pagination:true,singleSelect:true">
<thead>
	<tr>
		<th data-options="field:'name',width:10,align:'center'">商品名称</th>
		<th data-options="field:'shop_name',width:15,align:'left'">店铺名称</th>
		<th data-options="field:'smallUrl',width:10,align:'center',formatter:buildFace">商品图片</th>
		<th data-options="field:'profile',width:10,align:'left'">商品简介</th>
		<th data-options="field:'create_time',width:30">创建时间</th>
		<!--<th data-options="field:'id',width:10,formatter:groupOperateText">操作</th>-->
	</tr>
</thead>
</table>

<div id="groupToolbar_<?php echo ($rand); ?>" style="padding:5px;height:auto">
	<form id="groupSearchForm_<?php echo ($rand); ?>">
		<a href="javascript:;" onclick="groupRefreshList_<?php echo ($rand); ?>();" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true">刷新</a>
		<input type="text" name="search[name]" placeholder="根据商品名称搜索" style="height: 20px; width: 120px;padding-left: 3px;">
		<a href="javascript:;" onclick="groupSearch_<?php echo ($rand); ?>();" class="easyui-linkbutton" iconCls="icon-search">确定</a>		
	</form>
</div>

<script type="text/javascript">
//刷新
function groupRefreshList_<?php echo ($rand); ?>(){
	$('#groupList_<?php echo ($rand); ?>').datagrid('reload');
}

//操作格式化
//function groupOperateText(val, row, index){
//	var btn = [];
//	if(row.status == 0){
//		btn.push('<a href="javascript:void(0);" onclick="audit('+val+',1)">通过审核</a>');
//		btn.push('<a href="javascript:void(0);" onclick="audit('+val+',2)">不通过审核</a>');
//	}else{
//		if(row.status == 1){
//			return "已通过审核";
//		}else{
//			return "未通过审核";
//		}
//	}
//	return btn.join(' | ');
//}
//搜索用户
function groupSearch_<?php echo ($rand); ?>(){
	var queryParams = $('#groupList_<?php echo ($rand); ?>').datagrid('options').queryParams;
	$.each($("#groupSearchForm_<?php echo ($rand); ?>").form().serializeArray(), function (index) {
		queryParams[this['name']] = this['value'];
	});
	$('#groupList_<?php echo ($rand); ?>').datagrid('load');
}
//头像显示
function buildFace(val,row,index){
	if(!val){
		return '<div style="height:60px;padding:3px;margin:auto;"></div>';
	}else{
		return '<img src="'+val+'" height="60" style="padding:3px;">';
	}
}
//审核
//function audit(id,status){
//	$.messager.confirm('提示信息', '确定操作吗？', function(result){
//		if(!result) return false;
//		$.post('<?php echo U('Index/audit');?>', {id: id, status: status}, function(data){
//			if(!data.status){
//				$.messager.alert('提示信息', data.info, 'error');
//			}else{
//				groupRefreshList_<?php echo ($rand); ?>();
//				$.messager.alert('提示信息', data.info, 'info');
//			}
//		}, 'json');
//	});
//}
</script>