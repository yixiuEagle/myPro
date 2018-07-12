<?php if (!defined('THINK_PATH')) exit();?><script type="text/javascript">
$(function(){
	$('#add_category_upload').uploadify({
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
				$('#add_category_image').attr('src',''+image['0']['smallUrl']);
				$('#add_category_logo').attr('value',image['0']['smallUrl']);
			}
		}
	});
	$.formValidator.initConfig({formID:"categoryAddForm",theme:'App',onError:function(msg){},onSuccess:category_Saveadd,inIframe:true});
})
function category_Saveadd(){
	$.post('<?php echo U('category/add');?>', $("#categoryAddForm").serialize(), function(data){
		if(!data.status){
			$.messager.alert('提示信息', data.info, 'error');
		}else{
			categoryRefreshList_<?php echo ($rand); ?>()
			$.messager.alert('提示信息', data.info, 'info');
			$('#categoryAddBox').dialog('close');
		}
	})
}
</script>
<form id="categoryAddForm" style="font-size:13px; padding: 5px 0 0 10px;">
<table cellspacing="5">
	<tr>
		<td></td>
		<td>
			<img id="add_category_image" src="" height="80px;" style="min-width: 80px;padding: 3px; border: 1px solid #ccc;">
			<input id="add_category_logo" name="logo" value="" type="hidden">
		</td>
		<td></td>
	</tr>
	<tr>
		<td></td>
		<td colspan="2">
			<input id="add_category_upload" name="add_category_upload" type="file">
		</td>
	</tr>
	<tr>
		<td>名称：</td>
		<td><input type="text" name="name" id="category_add_name" value="" style="width:280px;height:22px;padding: 3px 6px;" /></td>
		<td><div id="category_add_nameTip"></div></td>
	</tr>
	<tr>
		<td>别名：</td>
		<td><input type="text" name="alias" id="category_add_alias" value="" style="width:280px;height:22px;padding: 3px 6px;" /></td>
		<td><div id="category_add_aliasTip"></div></td>
	</tr>
	</table>
</form>