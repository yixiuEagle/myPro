<?php if (!defined('THINK_PATH')) exit();?><div class="easyui-panel" data-options="fit:true,title:'<?php echo ($currentpos); ?>',border:false">
<script type="text/javascript">
$(function(){
	$('#membermentSubbtn').click(function(){$('#membermentForm').submit()});
	$.formValidator.initConfig({formID:"membermentForm",theme:'App',onSuccess:membermentTextSave,submitAfterAjaxPrompt:'有数据正在异步验证，请稍等...',inIframe:true});
	$("#memberment_text").formValidator({onShow:"请输入内容",onFocus:"请输入内容"}).inputValidator({min:1,max:9999999,onError:"内容不能为空"});
})
function membermentTextSave(){
	$.post('<?php echo U('Setting/memberment');?>', $("#membermentForm").serialize(), function(data){
		if(!data.status){
			$.messager.alert('提示信息', data.info, 'error');
		}else{
			$.messager.alert('提示信息', data.info, 'info');
		}
	})
}
</script>
<form id="membermentForm" style="padding: 10px;">
	<table id="addBox" width="100%">
		<tr>
			<td>
				<textarea id="memberment_text" class="easyui-kindeditor" name="memberment" style="width:100%; height: 400px;"><?php echo ($content); ?></textarea>
			</td>
			<td><div id="memberment_textTip"></div></td>
		</tr>
		<tr>
			<td align="center" style="padding-top: 10px;">
				<a id="membermentSubbtn" class="easyui-linkbutton">提交</a>
			</td>
			<td></td>
		</tr>
	</table>
</form>
</div>