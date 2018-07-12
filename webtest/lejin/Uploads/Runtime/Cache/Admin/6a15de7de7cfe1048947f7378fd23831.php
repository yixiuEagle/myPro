<?php if (!defined('THINK_PATH')) exit();?><script type="text/javascript">
$(function(){
	$.formValidator.initConfig({formID:"jubaoEditForm",theme:'App',onError:function(msg){},onSuccess:savejubaoEdit,inIframe:true});
})
function savejubaoEdit(){
	$.post('<?php echo U('jubao/edit');?>', $("#jubaoEditForm").serialize(), function(data){
		if(!data.status){
			$.messager.alert('提示信息', data.info, 'error');
		}else{
			jubaoRefreshList_<?php echo ($rand); ?>();
			$.messager.alert('提示信息', data.info, 'info');
			$('#jubaoEditBox').dialog('close');
		}
	})
}
</script>

<form id="jubaoEditForm" style="font-size:13px; padding: 5px 0px 5px 5px;">
<table id="editBox" cellspacing="5">

	<tr>
		<td width="60" align="right">内容：</td>
		<td>
			<input type="hidden" name="id" value="<?php echo ($info["id"]); ?>">
			<textarea name="content" style="width: 250px; height: 44px;"><?php echo ($info["content"]); ?></textarea>
		</td>
		<td><div id="edit_jubao_contentTip"></div></td>
	</tr>

</table>
</form>