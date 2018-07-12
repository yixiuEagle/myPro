<?php if (!defined('THINK_PATH')) exit();?><div class="easyui-panel"
	data-options="fit:true,title:'<?php echo ($currentpos); ?>',border:false">
		<table cellspacing="10" style="border: 1px solid #ccc; width: 680px;">
			<tr>
				<td width="180"></td>
				<td><a href="http://www.thinkchat.com.cn" target="_blank">我要续费</a>
			</tr>
			<tr>
				<td width="180">状态：</td>
				<td><?php echo ($info["status"]); ?></td>
			</tr>
			<tr>
				<td width="180">订单ID：</td>
				<td><?php echo ($info["orderid"]); ?></td>
			</tr>
			<tr>
				<td width="180">账号ID：</td>
				<td><?php echo ($info["acount"]); ?></td>
			</tr>
			<tr>
				<td width="180">支付方式：</td>
				<td><?php echo ($info["paymethod"]); ?></td>
			</tr>
			
			<tr>
				<td width="180">购买时间：</td>
				<td><?php echo ($info["buytime"]); ?></td>
			</tr>
			<tr>
				<td width="180">过期时间：</td>
				<td><?php echo ($info["expiretime"]); ?></td>
			</tr>
			
			<tr>
				<td width="180">支持最大在线用户数：</td>
				<td><?php echo ($info["chat_maxonlineuser"]); ?>人</td>
			</tr>
			
		</table>
</div>
<script type="text/javascript">
function setLincense(){	
	var url = '<?php echo U('Index/setLincense');?>';
	$('#pagetabs').tabs('add',{
		title: '设置Lincense',
		href: url,
		closable: true,
		cache: false
	});
}
</script>