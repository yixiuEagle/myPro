<?php if (!defined('THINK_PATH')) exit();?><!-- logs列表 -->
<table id="logsList" class="easyui-datagrid" title="<?php echo ($currentpos); ?>" data-options="
	fit:true,rownumbers:true,animate:true,fitColumns:false,
	url:'<?php echo U('Logs/index');?>',idField:'id',border:false,toolbar:logsToolbar,
	singleSelect:false,selectOnCheck:true,checkOnSelect:true">
<thead>
	<tr>
		<th data-options="field:'ck',checkbox:true"></th>
		<th data-options="field:'name',width:220,align:'center'">logs</th>
		<th data-options="field:'id',formatter:LogsOperateText,width:120,align:'center'">管理操作</th>
	</tr>
</thead>
</table>

<!-- 添加管理员 -->
<div id="LogsViewBox" class="easyui-dialog" title="查看"
	data-options="modal:true,closed:true,iconCls:'icon-add',buttons:[{text:'确定',iconCls:'icon-ok',handler:function(){$('#AdminAddForm').submit();}},{text:'取消',iconCls:'icon-cancel',handler:function(){$('#LogsViewBox').dialog('close');}}]"
	style="width: 900px; height: 500px;"></div>
	
<script type="text/javascript">
//工具栏
var logsToolbar = [
	{ text: '刷新', iconCls: 'icon-reload', handler: logsRefreshList },
	{ text: '删除', iconCls: 'icon-remove', handler: logsDeleteList }
];
//删除
function logsDeleteList(){
	var selected = $("#logsList").datagrid("getSelections");
    if (selected.length == 0) {
        $.messager.alert('提示信息', '请选择要删除的文件？', 'error');
        return false;
    }
    var idString = "";
    $.each(selected, function (index, item) {
        idString += item.name + ",";
    });
    deleteLogs(idString);
}
//刷新菜单列表
function logsRefreshList(){
	$('#logsList').datagrid('reload');
}
//生成操作内容
function LogsOperateText(val,row,index){
	var btn = [];
	btn.push('<a href="javascript:void(0);" onclick="viewLogs(\''+row.name+'\')">查看</a>');
	btn.push('<a href="javascript:void(0);" onclick="deleteLogs(\''+row.name+'\')">删除</a>');
	return btn.join(' | ');
}
//查看
function viewLogs(id){
	var url = '<?php echo U('Logs/detail');?>';
	url += url.indexOf('?') != -1 ? '&id='+id : '?id='+id;
	$('#LogsViewBox').dialog({href:url});
	$('#LogsViewBox').dialog('open');
}
//删除
function deleteLogs(id){	
	$.messager.confirm('提示信息', '确定删除Logs文件', function(result){
		if(!result) return false;
		$.post('<?php echo U('Logs/delete');?>', {id: id}, function(data){
			if(!data.status){
				$.messager.alert('提示信息', data.info, 'error');
			}else{
				logsRefreshList();
				$.messager.alert('提示信息', data.info, 'info');
			}
		}, 'json');
	});
}
</script>