<?php if (!defined('THINK_PATH')) exit();?><div class="easyui-panel"
	data-options="fit:true,title:'<?php echo ($currentpos); ?>',border:false">
<script type="text/javascript">
$(function(){
	$('#group_background_upload').uploadify({
		'swf'      : '/webtest/lejin/Public/js/uploadify/uploadify.swf',
		'uploader' : '<?php echo U('Setting/public_uploadHead');?>',
		'buttonText': '选择图片',
		'width'	: 70,
		'height': 28,
		'buttonClass': 'upload_button',
		'auto'	: true,
		'removeTimeout' : 0,//文件队列上传完成1秒后删除
		'fileTypeDesc' : 'Image Files',//只允许上传图像
		'fileTypeExts' : '*.gif; *.jpg; *.png',//限制允许上传的图片后缀
		'onUploadSuccess' : function(file, data, response){
			var data = $.parseJSON(data);
			if(!data.status){
				$.messager.alert('提示信息', data.info, 'error');
			}else{
				var image = data.url;
				$('#edit_back_group').attr('src','/webtest/lejin'+image['0']['smallUrl']);
				$('#background_group').attr('value',image['0']['smallUrl']);
			}
		}
	});
	$('#user_background_upload').uploadify({
		'swf'      : '/webtest/lejin/Public/js/uploadify/uploadify.swf',
		'uploader' : '<?php echo U('Setting/public_uploadHead');?>',
		'buttonText': '选择图片',
		'width'	: 70,
		'height': 28,
		'buttonClass': 'upload_button',
		'auto'	: true,
		'removeTimeout' : 0,//文件队列上传完成1秒后删除
		'fileTypeDesc' : 'Image Files',//只允许上传图像
		'fileTypeExts' : '*.gif; *.jpg; *.png',//限制允许上传的图片后缀
		'onUploadSuccess' : function(file, data, response){
			var data = $.parseJSON(data);
			if(!data.status){
				$.messager.alert('提示信息', data.info, 'error');
			}else{
				var image = data.url;
				$('#edit_back_user').attr('src','/webtest/lejin'+image['0']['smallUrl']);
				$('#background_user').attr('value',image['0']['smallUrl']);
			}
		}
	});
	$('#submitBackground').click(function(){$('#backgroundEditForm').submit()});
	$.formValidator.initConfig({formID:"backgroundEditForm",theme:'App',onError:function(msg){},onSuccess:background_SaveEdit,inIframe:true});
})
function background_SaveEdit(){
	$.post('<?php echo U('Setting/main');?>', $("#backgroundEditForm").serialize(), function(data){
		if(!data.status){
			$.messager.alert('提示信息', data.info, 'error');
		}else{
			$.messager.alert('提示信息', data.info, 'info');
		}
	})
}
</script>
<form id="backgroundEditForm" style="font-size:13px; padding: 5px 0 0 10px;">
<table cellspacing="5">
	<tr>
		<td>群号主图：</td>
		<td align="center">
			<input id="group_background_upload" type="file">
			<input id="background_group" name="background_group" value="<?php echo ((isset($info['background_group']) && ($info['background_group'] !== ""))?($info['background_group']):''); ?>" type="hidden">
		</td>
		<td>
			<img id="edit_back_group" src="/webtest/lejin<?php echo ((isset($info['background_group']) && ($info['background_group'] !== ""))?($info['background_group']):''); ?>" height="80px;" style="min-width: 80px;padding: 3px; border: 1px solid #ccc;">
		</td>
	</tr>
	<tr>
		<td>用户主图：</td>
		<td align="center">
			<input id="user_background_upload" type="file">
			<input id="background_user" name="background_user" value="<?php echo ((isset($info['background_user']) && ($info['background_user'] !== ""))?($info['background_user']):''); ?>" type="hidden">
		</td>
		<td>
			<img id="edit_back_user" src="/webtest/lejin<?php echo ((isset($info['background_user']) && ($info['background_user'] !== ""))?($info['background_user']):''); ?>" height="80px;" style="min-width: 80px;padding: 3px; border: 1px solid #ccc;">
		</td>
	</tr>
	<tr>
		<td></td>
		<td colspan="2" align="left">
			<input type="hidden" value="<?php echo ((isset($info["id"]) && ($info["id"] !== ""))?($info["id"]):''); ?>" name="id">
			<a id="submitBackground" class="easyui-linkbutton" style="width: 50px;">提交</a>
		</td>
	</tr>
	</table>
</form>
</div>