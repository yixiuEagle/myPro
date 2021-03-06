<?php if (!defined('THINK_PATH')) exit();?><script type="text/javascript">
<?php $timestamp = time();?>
$(function() {
	$('#edit_apk_upload').uploadify({
		'formData'     : {
			'timestamp' : '<?php echo $timestamp;?>',
			'token'     : '<?php echo md5('unique_salt' . $timestamp);?>'
		},
		'swf'      : '/Public/js/uploadify/uploadify.swf',
		'uploader' : '<?php echo U('Version/public_upload');?>',
		'buttonText': 'APK上传',
		'width'	: 70,
		'height': 26,
		'removeTimeout':0,
		'buttonClass': 'upload_button',
		'onUploadSuccess' : function(file, data, response){
			var data = $.parseJSON(data);
			if(!data.status){
				$.messager.alert('提示信息', data.info, 'error');
			}else{
				$('#edit_apk_url').attr('value',data.url);
				//$.messager.alert('提示信息', data.info, 'info');
			}
		}
	});

	$.formValidator.initConfig({formID:"apkEditForm",theme:'App',onSuccess:apkUploadSave,inIframe:true});
	$("#edit_apk_version").formValidator({onShow:"请输入版本号",onFocus:"版本号不能为空"}).inputValidator({min:1,max:20,empty:{leftEmpty:false,rightEmpty:false,emptyError:"版本号两边不能有空格"},onError:"版本号不能为空,请确认"});
	$("#edit_apk_url").formValidator({onShow:"请上传apk",onFocus:"请上传apk"}).inputValidator({min:1,max:200,empty:{leftEmpty:false,rightEmpty:false,emptyError:"url两边不能有空格"},onError:"请上传apk"});
	$("#edit_apk_descp").formValidator({onShow:"请输入描述",onFocus:"描述不能为空"}).inputValidator({min:1,max:999,onError:"描述不能为空,请确认"});
});
function apkUploadSave(){
	$.post('<?php echo U('Version/edit');?>', $("#apkEditForm").serialize(), function(data){
		if(!data.status){
			$.messager.alert('提示信息', data.info, 'error');
		}else{
			apkRefreshList();
			$.messager.alert('提示信息', data.info, 'info');
			$('#apkEditBox').dialog('close');
		}
	})
}
</script>
<form id="apkEditForm" style="padding-top: 10px; padding-left: 5px;">
	<table id="editBox">
		<tr>
			<td width="100" align="center">版&nbsp;本&nbsp;号：</td>
			<td><input type="text" id="edit_apk_version"
				name="info[version]" value="<?php echo ($info["version"]); ?>" style="width: 450px; height: 20px;"></td>
			<td><div id="edit_apk_versionTip"></div></td>
		</tr>
		<tr>
			<td width="100" align="center">U<span style="margin-left: 10px;"></span>R<span style="margin-left: 10px;"></span>L：</td>
			<td><input type="text" id="edit_apk_url" name="info[url]"
				value="<?php echo ($info["url"]); ?>" readonly="readonly" style="width: 450px;height: 20px;"></td>
			<td><div id="edit_apk_urlTip"></div></td>
		</tr>
		<tr>
			<td width="100"></td>
			<td>
				<div id="queue"></div> <input id="edit_apk_upload" name="edit_apk_upload"
				type="file" multiple="false">
			</td>
		</tr>
		<tr>
			<td align="center">升级类型：</td>
			<td><select id="edit_apk_updatetype" panelHeight="auto" class="easyui-combobox" name="info[updatetype]"
				style="width: 100px;">
				<?php if(is_array($uptype)): foreach($uptype as $key=>$u): ?><option value="<?php echo ($u["id"]); ?>" <?php if(($info["updatetype"]) == $u["id"]): ?>selected<?php endif; ?>><?php echo ($u["text"]); ?></option><?php endforeach; endif; ?>				
				</select></td>
			<td colspan="1"><div id="edit_apk_updatetypesTip"></div></td>
		</tr>
		<tr>
			<td width="100" align="center" valign="top">描<span style="margin-left: 25px;"></span>述：</td>
			<td><textarea
					style="width: 450px; height: 120px;"
					id="edit_apk_descp" name="info[description]"><?php echo ($info["description"]); ?></textarea></td>
			<td><div id="edit_apk_descpTip"></div></td>
		</tr>
		<tr>
			<td colspan="3">
				<input type="hidden" name="info[id]" value="<?php echo ($info["id"]); ?>">
			</td>
		</tr>
	</table>
</form>