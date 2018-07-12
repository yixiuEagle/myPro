<?php if (!defined('THINK_PATH')) exit();?><script type="text/javascript">
$(function(){
	$.formValidator.initConfig({formID:"categoryAddForm",theme:'App',onError:function(msg){/*$.messager.alert('错误提示', msg, 'error');*/},onSuccess:categorySaveAdd,inIframe:true});
	$("#add_category_name").formValidator({onShow:"请输入类别名称",onFocus:"类别名称不能为空",onCorrect:"输入正确"}).inputValidator({min:1,empty:{leftEmpty:false,rightEmpty:false,emptyError:'类别名称不能有空格'},onError:"类别名称不能为空"});
})
function categorySaveAdd(){
	$.post('<?php echo U('category/add');?>', $("#categoryAddForm").serialize(), function(data){
		if(!data.status){
			$.messager.alert('提示信息', data.info, 'error');
		}else{
			categoryRefreshList();
			$.messager.alert('提示信息', data.info, 'info');
			$('#categoryAddBox').dialog('close');
		}
	})
}
</script>
<form id="categoryAddForm" style="font-size:13px; padding: 20px;">
<table id="addBox">
	<tr>
		<td>名称：</td>
		<td><input id="add_category_name" name="name" type="text" style="width:178px;height:22px" /></td>
		<td><div id="add_category_nameTip"></div></td>
	</tr>
</table>
</form>