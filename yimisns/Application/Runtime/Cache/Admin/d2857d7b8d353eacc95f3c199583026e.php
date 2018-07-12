<?php if (!defined('THINK_PATH')) exit();?><script type="text/javascript">
//提交
function server_Add(){
	var form = new FormData(document.getElementById("serverForm"));
	var url='<?php echo U('Service/addservice');?>';
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
$('#category').combobox({
    url:'/yimisns/index.php/Admin/Service/category',
   valueField:'id',
   textField:'name',
   panelHeight:'auto',
   editable:false,
	onLoadSuccess: function (msg) {
		if (msg) {
			if('<?php echo ($data["category"]); ?>' == "" || '<?php echo ($data["category"]); ?>' == undefined || '<?php echo ($data["category"]); ?>' == null){
				$('#category').combobox('setText',"——请选择类型——");
			}else{
			    $('#category').combobox('setValue',"<?php echo ($data["category"]); ?>");
				
			}
		}
	}
});
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
	<tr>
		<td>类型：</td>
		<td>
		 <input class="easyui-combobox" name="data[categoryid]" id="category"/>
		</td>
    	<td><div id="user_edit_jobTip"></div></td>
	</tr>
	<tr>
		<td>位置：</td>
		<td> 经度：<input name="data[lng]" type="text" style="width:100px;height:22px" />纬度：<input class="easyui-textbox" name="data[lat]" type="text" style="width:100px;height:22px" />
		</td>
		<td><div></div></td>
	</tr> 
	</table>
	</form>