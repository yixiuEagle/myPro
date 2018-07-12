<?php if (!defined('THINK_PATH')) exit();?><script type="text/javascript">
$(function(){
	$('#edit_category_upload').uploadify({
		'swf'      : '/Public/js/uploadify/uploadify.swf',
		'uploader' : '<?php echo U('category/public_upload');?>',
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
				$('#edit_category_image').attr('src',''+image['0']['smallUrl']);
				$('#edit_category_logo').attr('value',image['0']['smallUrl']);
			}
		}
	});
	$.formValidator.initConfig({formID:"categoryEditForm",theme:'App',onError:function(msg){},onSuccess:category_SaveEdit,inIframe:true});
})
function category_SaveEdit(){
	$.post('<?php echo U('category/edit');?>', $("#categoryEditForm").serialize(), function(data){
		if(!data.status){
			$.messager.alert('提示信息', data.info, 'error');
		}else{
			categoryRefreshList_<?php echo ($rand); ?>()
			$.messager.alert('提示信息', data.info, 'info');
			$('#categoryEditBox').dialog('close');
		}
	})
}
</script>
<form id="categoryEditForm" style="font-size:13px; padding: 5px 0 0 10px;">
<table cellspacing="5">
	<tr>
		<td></td>
		<td>
			<img id="edit_category_image" src="<?php echo ($info["logo"]); ?>" height="80px;" style="min-width: 80px;padding: 3px; border: 1px solid #ccc;">
			<input id="edit_category_logo" name="logo" value="<?php echo ($info["logo"]); ?>" type="hidden">
		</td>
		<td></td>
	</tr>
	<tr>
		<td></td>
		<td colspan="2">
			<input id="edit_category_upload" name="edit_category_upload" type="file">
		</td>
	</tr>
	<tr>
		<td>名称：</td>
		<td><input type="text" name="name" id="category_edit_name" value="<?php echo ($info["name"]); ?>" style="width:280px;height:22px;padding: 3px 6px;" /></td>
		<td><div id="category_edit_nameTip"></div></td>
	</tr>
	<tr>
		<td>别名：</td>
		<td><input type="text" name="alias" id="category_edit_alias" value="<?php echo ($info["alias"]); ?>" style="width:280px;height:22px;padding: 3px 6px;" /></td>
		<td><div id="category_edit_aliasTip"></div></td>
	</tr>
	<tr>
		<td><input type="hidden" name="id" value="<?php echo ($info["id"]); ?>"></td>
	</tr>
	</table>
</form>