<?php if (!defined('THINK_PATH')) exit();?><div class="easyui-panel" data-options="fit:true,title:'<?php echo ($currentpos); ?>',border:false">
<script type="text/javascript">
$(function(){
	$('#usementSubbtn').click(function(){$('#usementForm').submit()});
	$.formValidator.initConfig({formID:"usementForm",theme:'App',onSuccess:usementTextSave,submitAfterAjaxPrompt:'有数据正在异步验证，请稍等...',inIframe:true});
	$("#usement_text").formValidator({onShow:"请输入内容",onFocus:"请输入内容"}).inputValidator({min:1,max:9999999,onError:"内容不能为空"});
})
function usementTextSave(){
	$.post('<?php echo U('Setting/usement');?>', $("#usementForm").serialize(), function(data){
		if(!data.status){
			$.messager.alert('提示信息', data.info, 'error');
		}else{
			$.messager.alert('提示信息', data.info, 'info');
		}
	})
}
</script>
<form id="usementForm" style="padding: 10px;">
	<table id="addBox" width="100%">
		<tr>
			<td>
				<textarea id="usement_text" class="easyui-kindeditor" name="usement" style="width:100%; height: 400px;"><?php echo ($content); ?></textarea>
			</td>
			<td><div id="usement_textTip"></div></td>
		</tr>
		<tr>
			<td align="center" style="padding-top: 10px;">
				<a id="usementSubbtn" class="easyui-linkbutton">提交</a>
			</td>
			<td></td>
		</tr>
	</table>
</form>
</div>