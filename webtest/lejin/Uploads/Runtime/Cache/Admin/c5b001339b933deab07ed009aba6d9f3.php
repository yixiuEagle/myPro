<?php if (!defined('THINK_PATH')) exit();?><div class="easyui-panel" data-options="fit:true,title:'<?php echo ($currentpos); ?>',border:false">
<script type="text/javascript">
$(function(){
	$('#registSubbtn').click(function(){$('#registForm').submit()});
	$.formValidator.initConfig({formID:"registForm",theme:'App',onSuccess:registTextSave,submitAfterAjaxPrompt:'有数据正在异步验证，请稍等...',inIframe:true});
	$("#regist_text").formValidator({onShow:"请输入内容",onFocus:"请输入内容"}).inputValidator({min:1,max:9999999,onError:"内容不能为空"});
})
function registTextSave(){
	$.post('<?php echo U('Setting/regist');?>', $("#registForm").serialize(), function(data){
		if(!data.status){
			$.messager.alert('提示信息', data.info, 'error');
		}else{
			$.messager.alert('提示信息', data.info, 'info');
		}
	})
}
</script>
<form id="registForm" style="padding: 10px;">
	<table id="addBox" width="100%">
		<tr>
			<td>
				<textarea id="regist_text" class="easyui-kindeditor" name="regist" style="width:100%; height: 400px;"><?php echo ($content); ?></textarea>
			</td>
			<td><div id="regist_textTip"></div></td>
		</tr>
		<tr>
			<td align="center" style="padding-top: 10px;">
				<a id="registSubbtn" class="easyui-linkbutton">提交</a>
			</td>
			<td></td>
		</tr>
	</table>
</form>
</div>