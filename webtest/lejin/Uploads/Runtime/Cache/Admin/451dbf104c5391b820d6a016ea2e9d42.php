<?php if (!defined('THINK_PATH')) exit();?><script type="text/javascript">
$(function(){
	$.formValidator.initConfig({formID:"jubaoAddForm",theme:'App',onError:function(msg){},onSuccess:savejubaoAdd,inIframe:true});
})
function savejubaoAdd(){
	$.post('<?php echo U('jubao/add');?>', $("#jubaoAddForm").serialize(), function(data){
		if(!data.status){
			$.messager.alert('提示信息', data.info, 'error');
		}else{
			jubaoRefreshList_<?php echo ($rand); ?>();
			$.messager.alert('提示信息', data.info, 'info');
			$('#jubaoAddBox').dialog('close');
		}
	})
}
</script>

<form id="jubaoAddForm" style="font-size:13px; padding: 5px 0px 5px 5px;">
<table id="editBox" cellspacing="5">
	<tr>
		<td width="60" align="right">内容：</td>
		<td><textarea name="content" style="width: 250px; height: 44px;"></textarea></td>
		<td><div id="add_jubao_contentTip"></div></td>
	</tr>
</table>
</form>