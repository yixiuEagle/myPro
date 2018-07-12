<?php if (!defined('THINK_PATH')) exit();?><script type="text/javascript">
$(function(){
	$.formValidator.initConfig({formID:"jubaoEditForm",theme:'App',onError:function(msg){/*$.messager.alert('错误提示', msg, 'error');*/},onSuccess:AdminSaveAdd,submitAfterAjaxPrompt:'有数据正在异步验证，请稍等...',inIframe:true});
	$("#AdminAdd_username").formValidator({onShow:"请输入用户uid",onFocus:"请输入数字"}).inputValidator({min:2,max:20,onError:"请输入数字"}).regexValidator({
		regExp:"^[1-9]\\d*$",
		param : "",
		dataType:"string",
		onError:"必须为数字"
	}).ajaxValidator({
		type : "post",
		url : "<?php echo U('jubao/public_checkUid');?>",
		data : {name:function(){return $("#AdminAdd_username").val()} },
		datatype : "json",
		async:'false',
		success : function(data){
			var json = $.parseJSON(data);
			var info = json.info;
			$("#fromuid").val(info.uid);
			$("#fromname").val(info.name);
			$("#fromhead").val(info.head);
            return json.status == 1 ? false : true;
		},
		onError : "用户名已存在",
		onWait : "请稍候..."
	});
	$("#AdminAdd_realname").formValidator({onShow:"请输入消息内容",onFocus:"请输入消息内容"}).inputValidator({min:2,max:20,empty:{leftEmpty:false,rightEmpty:false,emptyError:"姓名两边不能有空格"},onError:"请输入文字内容"});
})
function AdminSaveAdd(){
	$.post('<?php echo U('Jubao/message');?>', $("#jubaoEditForm").serialize(), function(data){
		if(!data.status){
			$.messager.alert('提示信息', data.info, 'error');
		}else{
			feedbackRefreshList_<?php echo ($rand); ?>();
			$.messager.alert('提示信息', data.info, 'info');
			$('#jubaoEditBox').dialog('close');
		}
	})
}
</script>
<form id="jubaoEditForm" style="font-size:13px; padding: 5px 0 0 10px;">
<table>
	<tr>
		<td width="80">发送者uid：</td>
		<td>
			<input type="text" name="uid" id="AdminAdd_username" style="width:180px;height:22px" value="">
			<input type="hidden" id="fromname" name="fromname" value="">
			<input type="hidden" id="fromhead" name="fromhead" value="">
			</td>
		<td><div id="AdminAdd_usernameTip"></div></td>
	</tr>
	<tr>
		<td>内容：</td>
		<td><textarea name="content" id="AdminAdd_realname" style="width: 180px; height: 88px;"></textarea></td>
		<td><div id="AdminAdd_realnameTip"></div></td>
	</tr>
	<tr>
		<td>
		<input type="hidden" name="typechat" value="100">
		<input type="hidden" name="toid" value="<?php echo ($touser["uid"]); ?>">
		<input type="hidden" name="toname" value="<?php echo ($touser["name"]); ?>">
		<input type="hidden" name="tohead" value="<?php echo ($touser["head"]); ?>">
		<input type="hidden" name="tag" value="<?php echo ($touser["tag"]); ?>">
		</td>
	</tr>
</table>
</form>