<?php if (!defined('THINK_PATH')) exit();?><script type="text/javascript">
$(function(){
	$.formValidator.initConfig({formID:"memberEditForm",theme:'App',onError:function(msg){},onSuccess:savememberEdit,inIframe:true});
})
function savememberEdit(){
	$.post('<?php echo U('member/edit');?>', $("#memberEditForm").serialize(), function(data){
		if(!data.status){
			$.messager.alert('提示信息', data.info, 'error');
		}else{
			memberRefreshList_<?php echo ($rand); ?>();
			$.messager.alert('提示信息', data.info, 'info');
			$('#memberEditBox').dialog('close');
		}
	})
}
</script>
<style type="text/css">
.input-small {padding: 3px 6px; height: 18px;}
td span {font-weight: bold;margin-left: 10px; font-size: 16px;}
</style>

<form id="memberEditForm" style="font-size:13px;">
<table id="editBox" cellspacing="5">
	<tr>
		<td colspan="3"><span>个人资料</span></td>
	</tr>
	<tr>
		<td width="120" align="right">主图：</td>
		<td>
			<input type="hidden" name="id" value="<?php echo ($info["id"]); ?>">
			是<input type="radio" name="userimage" value="1" <?php if(($info["userimage"]) == "1"): ?>checked="checked"<?php endif; ?>>
			否<input type="radio" name="userimage" value="0" <?php if(($info["userimage"]) == "0"): ?>checked="checked"<?php endif; ?>>

		</td>
		<td></td>
	</tr>
	<tr>
		<td width="120" align="right">头像：</td>
		<td>
			<input type="text" name="headcount" value="<?php echo ($info["headcount"]); ?>" class="input-small">
		</td>
		<td></td>
	</tr>
	<tr>
		<td colspan="3"><span>号资料</span></td>
	</tr>
	<tr>
		<td width="120" align="right">主图：</td>
		<td>
			是<input type="radio" name="groupimage" value="1" <?php if(($info["groupimage"]) == "1"): ?>checked="checked"<?php endif; ?>>
			否<input type="radio" name="groupimage" value="0" <?php if(($info["groupimage"]) == "0"): ?>checked="checked"<?php endif; ?>>
		</td>
		<td></td>
	</tr>
	<tr>
		<td width="120" align="right">头像：</td>
		<td>
			<input type="text" name="groupheadcount" value="<?php echo ($info["groupheadcount"]); ?>" class="input-small">
		</td>
		<td></td>
	</tr>
		<tr>
		<td width="120" align="right">可创建号：</td>
		<td>
			<input type="text" name="groupcount" value="<?php echo ($info["groupcount"]); ?>" class="input-small">
		</td>
		<td></td>
	</tr>
	<tr>
		<td width="120" align="right">位置信息：</td>
		<td>
			是<input type="radio" name="groupshow" value="1" <?php if(($info["groupshow"]) == "1"): ?>checked="checked"<?php endif; ?>>
			否<input type="radio" name="groupshow" value="0" <?php if(($info["groupshow"]) == "0"): ?>checked="checked"<?php endif; ?>>
		</td>
		<td></td>
	</tr>
		<tr>
		<td colspan="3"><span>信息发布</span></td>
	</tr>
	<tr>
		<td width="120" align="right">数量/每天：</td>
		<td>
			<input type="text" name="messagecount" value="<?php echo ($info["messagecount"]); ?>" class="input-small">
		</td>
		<td></td>
	</tr>
	<tr>
		<td width="120" align="right">可见范围：</td>
		<td>
			<select name="isvisible" style="width:100px;">
				<option value="0" <?php if(($info["isvisible"]) == "0"): ?>selected="selected"<?php endif; ?>>本地</option>
				<option value="1" <?php if(($info["isvisible"]) == "1"): ?>selected="selected"<?php endif; ?>>本省</option>
				<option value="2" <?php if(($info["isvisible"]) == "2"): ?>selected="selected"<?php endif; ?>>全国</option>
			</select>
		</td>
		<td></td>
	</tr>
		<tr>
		<td colspan="3"><span>其他</span></td>
	</tr>
	<tr>
		<td width="120" align="right">会员标识：</td>
		<td>
			<?php if($info['logo']): ?><img src="<?php echo ($info["logo"]); ?>" height="40" style="padding:3px;"><?php endif; ?>
		</td>
		<td></td>
	</tr>
	<tr>
		<td width="120" align="right">会费/月：</td>
		<td>
			<input type="text" name="monthfee" value="<?php echo ($info["monthfee"]); ?>" class="input-small">
		</td>
		<td></td>
	</tr>
</table>
</form>