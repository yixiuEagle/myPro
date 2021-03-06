<?php if (!defined('THINK_PATH')) exit();?><script type="text/javascript">
$(function(){
	$('#release_upload').uploadify({
		'swf'      : '/Public/js/uploadify/uploadify.swf',
		'uploader' : '<?php echo U('Push/public_upload?name=release');?>',
		'buttonText': 'release证书上传',
		'width'	: 120,
		'height': 28,
		'buttonClass': 'upload_button',
		'auto'	: true,
		'removeTimeout' : 0,//文件队列上传完成1秒后删除
		'fileTypeExts' : '*.pem; *.jpg; *.png',//限制允许上传的图片后缀
		'onUploadSuccess' : function(file, data, response){
			var data = $.parseJSON(data);
			if(!data.status){
				$.messager.alert('提示信息', data.info, 'error');
			}else{
				pushRefreshList();
				$.messager.alert('提示信息', data.info, 'info');
			}
		}
	});
	$('#deveplop_upload').uploadify({
		'swf'      : '/Public/js/uploadify/uploadify.swf',
		'uploader' : '<?php echo U('Push/public_upload?name=develop');?>',
		'buttonText': 'develop证书上传',
		'width'	: 120,
		'height': 28,
		'buttonClass': 'upload_button',
		'auto'	: true,
		'removeTimeout' : 0,//文件队列上传完成1秒后删除
		'fileTypeExts' : '*.pem; *.jpg; *.png',//限制允许上传的图片后缀
		'onUploadSuccess' : function(file, data, response){
			var data = $.parseJSON(data);
			if(!data.status){
				$.messager.alert('提示信息', data.info, 'error');
			}else{
				pushRefreshList();
				$.messager.alert('提示信息', data.info, 'info');
			}
		}
	});
})
</script>
<style type="text/css">
#release_upload-queue{width: 120px;}
#deveplop_upload-queue{width: 120px;}
</style>
<!-- push列表 -->
<table id="pushList" class="easyui-datagrid" title="<?php echo ($currentpos); ?>" data-options="
	fit:true,rownumbers:true,animate:true,fitColumns:false,
	url:'<?php echo U('push/upload');?>',idField:'id',border:false,toolbar:'#pushToolbar',
	singleSelect:true">
<thead>
	<tr>
		<th data-options="field:'name',width:200,align:'left'">push</th>
		<th data-options="field:'id',formatter:pushOperateText,width:200,align:'center'">管理操作</th>
	</tr>
</thead>
</table>

<div id="pushToolbar" style="padding:5px;height:auto">
	<a href="javascript:;" onclick="pushRefreshList();" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true">刷新</a>
	<div style="width: 200px; float: left;"><input id="release_upload" name="release_upload" type="file"></div>
	<div style="width: 200px; float: left;"><input id="deveplop_upload" name="deveplop_upload" type="file"></div>
</div>
<script type="text/javascript">
//刷新菜单列表
function pushRefreshList(){
	$('#pushList').datagrid('reload');
}
//生成操作内容
function pushOperateText(val,row,index){
	var btn = [];
	btn.push('<a href="javascript:void(0);" onclick="deletepush(\''+row.name+'\')">删除</a>');
	return btn.join(' | ');
}
//删除
function deletepush(id){	
	$.messager.confirm('提示信息', '确定删除push文件', function(result){
		if(!result) return false;
		$.post('<?php echo U('push/delete');?>', {id: id}, function(data){
			if(!data.status){
				$.messager.alert('提示信息', data.info, 'error');
			}else{
				pushRefreshList();
				$.messager.alert('提示信息', data.info, 'info');
			}
		}, 'json');
	});
}
</script>