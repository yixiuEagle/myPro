<?php if (!defined('THINK_PATH')) exit();?><script type="text/javascript">
function AdminRoleSetSave(){
	var nodes = $('#roleTree').tree('getChecked');
	var menuids = [];
	for(var i=0; i<nodes.length; i++){
		menuids.push(nodes[i]['id']);
		menuids.push(nodes[i]['attributes']['parent']);
	}
	$.post('<?php echo U('Admin/roleSet?dosubmit=1&id='.$id);?>', {menuids: menuids.join(',')}, function(data){
		if(!data.status){
			$.messager.alert('提示信息', data.info, 'error');
		}else{
			$.messager.alert('提示信息', data.info, 'info');
			$('#adminRoleSetBox').dialog('close');
		}
	})
	return false;
}
</script>
<form id="adminRoleSetForm" style="font-size:13px" onsubmit="return AdminRoleSetSave()">
	<ul class="easyui-tree" id="roleTree" data-options="url:'<?php echo U('Admin/roleSet?id='.$id);?>',method:'post',animate:true,checkbox:true,lines:true"></ul>
</form>