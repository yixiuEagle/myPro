<?php if (!defined('THINK_PATH')) exit();?><script type="text/javascript">
$(function(){
	$('#add_banner_upload').uploadify({
		'swf'      : '/Public/js/uploadify/uploadify.swf',
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
				$('#add_banner_image').css('display','block');
				$('#add_banner_image').attr('src',''+image['0']['smallUrl']);
				$('#add_banner_logo').attr('value',image['0']['smallUrl']);
			}
		}
	});
	$.formValidator.initConfig({formID:"bannerAddForm",theme:'App',onError:function(msg){},onSuccess:banner_Saveadd,inIframe:true});
})
function banner_Saveadd(){
	$.post('<?php echo U('banner/add');?>', $("#bannerAddForm").serialize(), function(data){
		if(!data.status){
			$.messager.alert('提示信息', data.info, 'error');
		}else{
			bannerRefreshList_<?php echo ($rand); ?>()
			$.messager.alert('提示信息', data.info, 'info');
			$('#bannerAddBox').dialog('close');
		}
	})
}
</script>
<form id="bannerAddForm" style="font-size:13px; padding: 5px 0 0 10px;">
<table cellspacing="5">
	<tr>
		<td width="60">类型：</td>
		<td>
			<input type="radio" name="type" value="1" checked="checked"/>三方地址   
			<input type="radio" name="type" value="0"   />文本内容
		</td>
		<td></td>
	</tr>
	<tr>
		<td>类别：</td>
		<td>
			<input id="add_banner_action" class="easyui-combobox" name="action" style="padding:3px 6px;"
					data-options="
						valueField:'id',
						textField:'text',
						data: [{'id':'0','text':'留言','selected':true},{'id':'1','text':'关注'},{'id':'2','text':'动态'}],
						panelHeight:'auto',
			">
			</td>
		<td></td>
	</tr>
	<tr>
		<td>图片：</td>
		<td>
			<img id="add_banner_image" src="" height="80px;" style="min-width: 80px;padding: 3px; border: 1px solid #ccc; display: none;">
			<input id="add_banner_logo" name="image" value="" type="hidden">
		</td>
		<td></td>
	</tr>
	<tr>
		<td></td>
		<td colspan="2">
			<input id="add_banner_upload" name="add_banner_upload" type="file">
		</td>
	</tr>
	<tr>
		<td valign="top">内空：</td>
		<td>
			<textarea id="editor_text" class="easyui-kindeditor" name="content" style="width:100%; height: 320px;"></textarea>
		</td>
		<td></td>
	</tr>
	</table>
</form>