<?php if (!defined('THINK_PATH')) exit();?><!-- 用户列表 -->
<table id="apkList" class="easyui-datagrid" title="<?php echo ($currentpos); ?>" data-options="
	fit:true,rownumbers:true,animate:true,fitColumns:true,
	url:'<?php echo U('Version/apk');?>',idField:'id',border:false,
	toolbar:apkToolbar,pagination:true,singleSelect:true,nowrap:false">
<thead>
	<tr>
		<th data-options="field:'version',width:80,align:'center'">版本号</th>
		<th data-options="field:'description',width:400">描述</th>
		<th data-options="field:'createtime',width:100,align:'center'">上传时间</th>
		<th data-options="field:'updatetype',width:80,align:'center',formatter:updateTypeText">升级类型</th>
		<th data-options="field:'url',width:50,align:'center',formatter:apkDownload">下载</th>
		<th data-options="field:'id',width:100,align:'center',formatter:apkOperateText">操作</th>
	</tr>
</thead>
</table>

<!-- 添加 -->
<div id="apkAddBox" class="easyui-dialog" title="添加APK"
	data-options="modal:true,closed:true,iconCls:'icon-add',buttons:[{text:'确定',iconCls:'icon-ok',handler:function(){$('#apkAddForm').submit();}},{text:'取消',iconCls:'icon-cancel',handler:function(){$('#apkAddBox').dialog('close');}}]"
	style="width: 730px; height: 380px;"></div>
<!-- 编辑 -->
<div id="apkEditBox" class="easyui-dialog" title="编辑APK"
	data-options="modal:true,closed:true,iconCls:'icon-add',buttons:[{text:'确定',iconCls:'icon-ok',handler:function(){$('#apkEditForm').submit();}},{text:'取消',iconCls:'icon-cancel',handler:function(){$('#apkEditBox').dialog('close');}}]"
	style="width: 730px; height: 380px;"></div>
<script type="text/javascript">
//工具栏
var apkToolbar = [
	{ text: '刷新', iconCls: 'icon-reload', handler: apkRefreshList },
	{ text: '添加', iconCls: 'icon-add', handler: apkAdd },
];
//升级类型格式化
function updateTypeText(val){
	var html = '';
	if (val == 0){
		html = '正常升级';
	}else if(val == 1){
		html = '警告升级';
	}else if(val == 2){
		html = '强制升级';
	}
	return html;
}
//apk下载
function apkDownload(val){
	return '<a target="_blank" href="'+val+'">下载</a>';
}
//操作格式化
function apkOperateText(val, row, index){
	var btn = [];
		btn.push('<a href="javascript:void(0);" onclick="apkEdit('+val+')">编辑</a>');
		btn.push('<a href="javascript:void(0);" onclick="apkDelete('+val+')">删除</a>');
	return btn.join(' | ');
}
//刷新
function apkRefreshList(){
	$('#apkList').datagrid('reload');
}
//添加
function apkAdd(){
	var url = '<?php echo U('Version/add');?>';
	$('#apkAddBox').dialog({href:url});
	$('#apkAddBox').dialog('open');
}
//apk编辑
function apkEdit(id){
	if(typeof(id) !== 'number'){
		$.messager.alert('提示信息', '请选择一条记录', 'error');
		return false;
	}
	var url = '<?php echo U('Version/edit');?>';
	url += url.indexOf('?') != -1 ? '&id='+id : '?id='+id;
	$('#apkEditBox').dialog({href:url});
	$('#apkEditBox').dialog('open');
}
//apk删除 
function apkDelete(id){
	if(typeof(id) !== 'number'){
		$.messager.alert('提示信息', '未选择', 'error');
		return false;
	}
	$.messager.confirm('提示信息', '确定要删除吗？', function(result){
		if(!result) return false;
		$.post('<?php echo U('Version/delete');?>', {id: id}, function(data){
			if(!data.status){
				$.messager.alert('提示信息', data.info, 'error');
			}else{
				apkRefreshList();
				$.messager.alert('提示信息', data.info, 'info');
			}
		}, 'json');
	});
}
</script>