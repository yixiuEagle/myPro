<?php if (!defined('THINK_PATH')) exit();?><div class="easyui-panel"
	data-options="fit:true,title:'<?php echo ($currentpos); ?>',border:false">
<script type="text/javascript">
$(function(){
	$('#pushSubmit').click(function(){$('#pushForm').submit()});
	$.formValidator.initConfig({formID:"pushForm",theme:'App',onSuccess:pushInfoSave,inIframe:true});
})
function pushInfoSave(){
	$.post('<?php echo U('Push/index');?>', $("#pushForm").serialize(), function(data){
		if(!data.status){
			$.messager.alert('提示信息', data.info, 'error');
		}else{
			$.messager.alert('提示信息', data.info, 'info');
		}
	})
}
</script>
	<form id="pushForm" style="font-size: 13px">
		<table cellspacing="10" style="border: 1px solid #ccc; width: 500px;">
			<?php if($info): ?><tr>
					<td width="80">调试模式：</td>
					<td width="40">
						<input type="radio" name="push" id="realname" value="1"/></td>
					<td>说明：开发模式</td>
				</tr>
				<tr>
					<td>发布版模式：</td>
					<td>
						<input type="radio" name="push" id="email" value="0"  checked="checked"/></td>
					<td>说明：发布版模式</td>
				</tr>
			<?php else: ?>
				<tr>
					<td width="80">调试模式：</td>
					<td width="40">
						<input type="radio" name="push" id="realname" value="1" checked="checked"/></td>
					<td>说明：开发模式</td>
				</tr>
				<tr>
					<td>发布版模式：</td>
					<td>
						<input type="radio" name="push" id="email" value="0"/></td>
					<td>说明：发布版模式</td>
				</tr><?php endif; ?>
			<tr>
				<td>证书密码：</td>
				<td>
					<input type="text" name="password" id="password" value="<?php echo ($passwd); ?>" style="padding: 3px 6px;"/></td>
				<td>说明：证书密码</td>
			</tr>
			<tr>
				<td></td>
				<td colspan="2" align="left">
					<a id="pushSubmit" class="easyui-linkbutton" style="width: 50px;">提交</a>
				</td>
			</tr>
		</table>
	</form>
</div>