<?php if (!defined('THINK_PATH')) exit();?><script type="text/javascript">
$(function(){
	$('#edit_banner_upload').uploadify({
		'swf'      : '/lejin/Public/js/uploadify/uploadify.swf',
		'uploader' : '<?php echo U('banner/public_upload');?>',
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
				var image = data.image;
				$('#edit_banner_image').attr('src','/lejin'+image['0']['smallUrl']);
				$('#edit_banner_logo').attr('value',image['0']['smallUrl']);
			}
		}
	});
	$.formValidator.initConfig({formID:"bannerEditForm",theme:'App',onError:function(msg){},onSuccess:banner_SaveEdit,inIframe:true});
})
function banner_SaveEdit(){
	$.post('<?php echo U('banner/edit');?>', $("#bannerEditForm").serialize(), function(data){
		if(!data.status){
			$.messager.alert('提示信息', data.info, 'error');
		}else{
			bannerRefreshList_<?php echo ($rand); ?>()
			$.messager.alert('提示信息', data.info, 'info');
			$('#bannerEditBox').dialog('close');
		}
	})
}
</script>
<form id="bannerEditForm" style="font-size:13px; padding: 5px 0 0 10px;">
<table cellspacing="5">
	<tr>
		<td width="60">类型：</td>
		<td>
			<input type="radio" name="type" value="1" <?php if(($info["type"]) == "1"): ?>checked="checked"<?php endif; ?>/>三方地址   
			<input type="radio" name="type" value="0"  <?php if(($info["type"]) == "0"): ?>checked="checked"<?php endif; ?> />文本内容
		</td>
		<td></td>
	</tr>
	<tr>
		<td>类别：</td>
		<td>
			<input id="add_banner_action" class="easyui-combobox" name="action" value="<?php echo ($info["action"]); ?>" style="padding:3px 6px;"
					data-options="
						valueField:'id',
						textField:'text',
						data: [{'id':'0','text':'留言'},{'id':'1','text':'关注'},{'id':'2','text':'动态'}],
						panelHeight:'auto',
			">
			</td>
		<td><div id="user_edit_genderTip"></div></td>
	</tr>
	<tr>
		<td></td>
		<td>
			<img id="edit_banner_image" src="/lejin<?php echo ($info["image"]); ?>" height="80px;" style="min-width: 80px;padding: 3px; border: 1px solid #ccc;">
			<input id="edit_banner_logo" name="image" value="<?php echo ($info["image"]); ?>" type="hidden">
		</td>
		<td></td>
	</tr>
	<tr>
		<td></td>
		<td colspan="2">
			<input id="edit_banner_upload" name="edit_banner_upload" type="file">
		</td>
	</tr>
	<tr>
		<td valign="top">内容：</td>
		<td>
			<textarea id="editor_text" class="easyui-kindeditor" name="content" style="width:100%; height: 320px;"><?php echo ($info["content"]); ?></textarea>
		</td>
		<td></td>
	</tr>
	<tr>
		<td><input type="hidden" name="id" value="<?php echo ($info["id"]); ?>"></td>
	</tr>
	</table>
</form>