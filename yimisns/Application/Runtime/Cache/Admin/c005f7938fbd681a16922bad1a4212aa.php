<?php if (!defined('THINK_PATH')) exit();?><script type="text/javascript">
//提交
function server_Add(){
	var form = new FormData(document.getElementById("serverForm"));
	var url='<?php echo U('Service/addtype');?>';
	var name=$.trim($("#name").val());
	if(name==""||name==null){
		$.messager.alert('提示信息', '请输入名称!', 'error'); 
		return;
	}
	$.messager.progress();
	$.ajax({  
	    url :url,
	    type : "POST",  
	    data: form,
        contentType: false,
        processData: false,
	    success : function(data) { 
	    	$.messager.progress('close');
	    	Refresh();
	    	$.messager.alert('提示信息', data.info, 'info'); 
	    	$('#addserBox').dialog('close');
	    },  
	    error : function(data) {  
	    	$.messager.alert('提示信息', data.info, 'error');  
	    }  
	});  
}		

</script>
<form id="serverForm" style="font-size:13px; padding: 5px 0 0 10px;">
<table cellspacing="5">
	<tr>
		<td>图片：</td>
		<td><input name="file" type="file"  style="width:180px;height:22px" />
		</td>
		<td><div id="user_edit_nicknameTip"></div></td>
	</tr>
	 <tr>
		<td>名称：</td>
		<td><input id="name" type="text" name="data[name]"  style="width:180px;height:22px" />
		</td>
		<td><div></div></td>
	</tr>
	</table>
	</form>