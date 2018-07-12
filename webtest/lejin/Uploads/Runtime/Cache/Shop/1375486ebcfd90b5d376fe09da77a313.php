<?php if (!defined('THINK_PATH')) exit();?><!-- 群组列表 -->
<?php $rand = round(microtime(true),3)*1000;?>
<table id="groupList_<?php echo ($rand); ?>" class="easyui-datagrid" title="<?php echo ($currentpos); ?>" data-options="
	fit:true,rownumbers:true,animate:true,fitColumns:true,
	url:'<?php echo U('Order/index');?>',border:false,
	toolbar:'#groupToolbar_<?php echo ($rand); ?>',pagination:true,singleSelect:true">
<thead>
	<tr>
		<th data-options="field:'name',width:10,align:'center'">用户名</th>
		<th data-options="field:'order_no',width:15,align:'left'">订单No</th>
		<th data-options="field:'status',width:15,align:'left',formatter:formatStatus">状态</th>
		<th data-options="field:'total_price',width:15,align:'left'">总价</th>
		<th data-options="field:'coupon_price',width:15,align:'left'">优惠券抵扣</th>
		<th data-options="field:'balances_price',width:15,align:'left'">余额抵扣</th>
		<th data-options="field:'actual_price',width:15,align:'left'">实际支付</th>
		<th data-options="field:'shipping_address',width:15,align:'left'">收货地址</th>
		<th data-options="field:'remark',width:15,align:'left'">备注</th>
		<th data-options="field:'create_time',width:30">创建时间</th>
		<th data-options="field:'id',width:10,formatter:groupOperateText">操作</th>
	</tr>
</thead>
</table>

<div id="groupToolbar_<?php echo ($rand); ?>" style="padding:5px;height:auto">
	<form id="groupSearchForm_<?php echo ($rand); ?>">
		<a href="javascript:;" onclick="groupRefreshList_<?php echo ($rand); ?>();" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true">刷新</a>
		<input type="text" name="search[name]" placeholder="根据用户名称搜索" style="height: 20px; width: 120px;padding-left: 3px;">
		<a href="javascript:;" onclick="groupSearch_<?php echo ($rand); ?>();" class="easyui-linkbutton" iconCls="icon-search">确定</a>		
	</form>
</div>

<script type="text/javascript">
//刷新
function groupRefreshList_<?php echo ($rand); ?>(){
	$('#groupList_<?php echo ($rand); ?>').datagrid('reload');
}

//操作格式化
function groupOperateText(val, row, index){
	return '<a href="javascript:void(0);" onclick="deleteg('+val+')">删除</a>';
}
function deleteg(id){
    $.messager.confirm('提示信息', '确定操作吗？', function(result){
        if(!result) return false;
        $.post('<?php echo U('Order/delete');?>', {id: id}, function(data){
            if(!data.status){
                $.messager.alert('提示信息', data.info, 'error');
            }else{
                groupRefreshList_<?php echo ($rand); ?>();
                $.messager.alert('提示信息', data.info, 'info');
            }
        }, 'json');
    });
}
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
//0.未支付，1.已支付待发货，2.已发货待收货，3.已收货待评价，4.待卖家评价，5.完成，6.退货，7.换货，8.投诉，9.已取消
function formatStatus(val) {
	var text = "";
	switch (parseInt(val)){
		case 0:
			text = "未支付";
			break;
		case 1:
			text = "待发货";
			break;
		case 2:
			text = "待收货";
			break;
		case 3:
			text = "待评价";
			break;
		case 4:
			text = "待卖家评价";
			break;
		case 5:
			text = "完成";
			break;
		case 6:
			text = "退货";
			break;
		case 7:
			text = "换货";
			break;
		case 8:
			text = "投诉";
			break;
		case 9:
			text = "已取消";
			break;
	}
	return text;
}
</script>