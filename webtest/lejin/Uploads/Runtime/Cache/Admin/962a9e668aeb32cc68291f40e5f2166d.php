<?php if (!defined('THINK_PATH')) exit();?><!-- 模块列表 -->
<table id="moduleList" class="easyui-datagrid"
	title="<?php echo ($currentpos); ?>"
	data-options="fit:true,rownumbers:true,animate:true,fitColumns:true,
	url:'<?php echo U('Module/index');?>',idField:'id',toolbar:moduleToolbar,
	border:false,singleSelect:true,nowrap:false">
	<thead>
		<tr>
			<th data-options="field:'name',width:40,align:'center'">模块名称</th>
			<th data-options="field:'displayname',width:40,align:'center'">显示名称</th>
			<th data-options="field:'version',width:40,align:'center'">版本号</th>
			<th data-options="field:'author',width:70,align:'center'">作者</th>
			<th data-options="field:'price',width:30,align:'center'">价格</th>
			<th data-options="field:'status',width:40,align:'center',formatter:StateBuildText">状态</th>
			<th data-options="field:'description',width:200">描述</th>
			<th data-options="field:'id',formatter:OperateText,width:80,align:'center'">管理操作</th>
		</tr>
	</thead>
</table>

<script type="text/javascript">
//工具栏
var moduleToolbar = [
	{ text: '刷新', iconCls: 'icon-reload', handler: moduleRefreshList }
];
//状态内容格式化
function StateBuildText(val) {
	var title = '未安装';
	switch (val) {
		case '0':
			title = "未安装";
			break;
		case '1':
			title = "<font color='blue'>运行中</font>";
			break;
		case '2':
			title = "已暂停";
			break;
		default:
			break;
	}	
	return title;
}
//操作内容格式化
function OperateText(val,row,index){
	var btn = [];
	if (val == undefined){
		btn.push('<a href="javascript:void(0);" onclick="installAndStartup(\''+row.name+'\')">安装</a>');
	}else if (row.status == '2'){
		btn.push('<a href="javascript:void(0);" onclick="startup('+val+')">启动</a>');
	}else{
		btn.push('<a href="javascript:void(0);" onclick="stop('+val+')">停止</a>');
	}
	btn.push('<a href="javascript:void(0);" onclick="del(\''+row.name+'\','+val+')">删除</a>');
	return btn.join(' | ');
}
//安装并启动
function installAndStartup(name) {
	if(typeof(name) !== 'string'){
		$.messager.alert('提示信息', '未选择模块', 'error');
		return false;
	}
	$.post('<?php echo U('Module/installAndStartup');?>', {module: name}, function(data){
		if(!data.status){
			$.messager.alert('提示信息', data.info, 'error');
		}else{
			getLeft(4, '我的面板');//更新菜单
			moduleRefreshList();
			$.messager.alert('提示信息', data.info, 'info');
		}
	}, 'json');
}
//启动
function startup(id) {
	if(typeof(id) !== 'number'){
		$.messager.alert('提示信息', '未选择模块', 'error');
		return false;
	}
	$.post('<?php echo U('Module/startup');?>', {id: id}, function(data){
		if(!data.status){
			$.messager.alert('提示信息', data.info, 'error');
		}else{
			moduleRefreshList();
			$.messager.alert('提示信息', data.info, 'info');
		}
	}, 'json');
}
//停止
function stop(id) {
	if(typeof(id) !== 'number'){
		$.messager.alert('提示信息', '未选择模块', 'error');
		return false;
	}
	$.post('<?php echo U('Module/stop');?>', {id: id}, function(data){
		if(!data.status){
			$.messager.alert('提示信息', data.info, 'error');
		}else{
			moduleRefreshList();
			$.messager.alert('提示信息', data.info, 'info');
		}
	}, 'json');
}
//删除
function del(name, id) {
	if(typeof(name) !== 'string'){
		$.messager.alert('提示信息', '未选择模块', 'error');
		return false;
	}
	if (id == undefined){id=0}
	$.messager.confirm('提示信息', '删除后不能恢复,确定要把该模块从系统中删除吗？', function(result){
		if(!result) return false;
		$.post('<?php echo U('Module/delete');?>', {module: name, id: id}, function(data){
			if(!data.status){
				$.messager.alert('提示信息', data.info, 'error');
			}else{
				getLeft(4, '我的面板');//更新菜单
				moduleRefreshList();
				$.messager.alert('提示信息', data.info, 'info');
			}
		}, 'json');
	});
}
//刷新菜单列表
function moduleRefreshList(){
	$('#moduleList').datagrid('reload');
}
</script>