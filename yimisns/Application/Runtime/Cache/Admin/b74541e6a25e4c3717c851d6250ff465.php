<?php if (!defined('THINK_PATH')) exit();?><!-- 用户列表 -->
<?php $rand = round(microtime(true),3)*1000;?>
<table id="serverList" class="easyui-datagrid" title="<?php echo ($currentpos); ?>" data-options="
	fit:true,rownumbers:true,animate:true,fitColumns:false,
	url:'<?php echo U('Service/servicelist',array('id'=>I('id',0)));?>',idField:'id',border:false,
	toolbar:'#Toolbar_<?php echo ($rand); ?>',pagination:true,singleSelect:true">
<thead>
	<tr>
		<th data-options="field:'img',width:200,align:'center',formatter:buildFace">图片</th>
		<th data-options="field:'name',width:120,align:'center'">名称</th>
		<th data-options="field:'type',width:120,align:'center'">类型</th>
		<th data-options="field:'createtime',width:120,align:'center'">创建时间</th>
		<th data-options="field:'id',width:100,align:'center',formatter:userOperateText">操作</th>
	</tr>
</thead>
</table>

<div id="Toolbar_<?php echo ($rand); ?>" style="padding:5px;height:auto">
	<form id="SearchForm_<?php echo ($rand); ?>">
		<a href="javascript:;" onclick="Refresh();" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true">刷新</a>
		<input class="easyui-combobox" name="search[name]" id="sear" style="height: 20px; width: 120px;padding-left: 3px;">
		<a href="javascript:;" onclick="Search_<?php echo ($rand); ?>();" class="easyui-linkbutton" iconCls="icon-search">确定</a>		
		<a href="javascript:;" onclick="Add_server();" class="easyui-linkbutton" iconCls="icon-add">添加</a>
	</form>
</div>

<!-- 编辑 -->
<div id="userEditBox" class="easyui-dialog" title="编辑用户"
	data-options="modal:true,closed:true,iconCls:'icon-add',
				buttons:[{text:'确定',iconCls:'icon-ok',
				handler:function(){$('#userEditForm').submit();}},
				{text:'取消',iconCls:'icon-cancel',
				handler:function(){$('#userEditBox').dialog('close');}}]"
	style="width: 600px; height: 480px;"></div>
<!-- 添加 -->
<div id="addserBox" class="easyui-dialog" title="添加服务站点"
	data-options="modal:true,closed:true,iconCls:'icon-edit',
				buttons:[{text:'确定',iconCls:'icon-ok',
				handler:function(){server_Add();}},
				{text:'取消',iconCls:'icon-cancel',
				handler:function(){$('#addserBox').dialog('close');}}]"
	style="width: 600px; height: 400px;"></div>
<script type="text/javascript">
      
//类型
$.ajax({  
    url: '/yimisns/index.php/Admin/Service/category',  
    dataType: 'json',  
    success: function (jsonstr) {  
        jsonstr.unshift({  
            'id': '',  
            'name': '-请选择-'  
        });//向json数组开头添加自定义数据  
        $('#sear').combobox({  
            data: jsonstr,  
            panelHeight:'auto',
            editable:false,
            valueField: 'id',  
            textField: 'name',  
            onLoadSuccess: function () { //加载完成后,设置选中第一项  
                var val = $(this).combobox('getData');  
                for (var item in val[0]) {  
                    if (item == 'id') {  
                        $(this).combobox('select', val[0][item]);  
                    }  
                }  
            }  
        });  
    }  
});  
//添加服务站点
function Add_server(){
	var url = '<?php echo U('Service/addservice');?>';
	$('#addserBox').dialog({href:url});
	$('#addserBox').dialog('open');
}
//刷新
function Refresh(){
	$('#serverList').datagrid('reload');
}
//图片显示
function buildFace(val,row,index){
	if(!val){
		return '<div style="height:60px;padding:3px;margin:auto;"></div>';
	}else{
		return '<div style="padding:3px;"><img src="'+val+'" height="60" style="padding:1px;border:1px solid #ccc;"></div>';	
	}
}
//操作
function userOperateText(val, row, index){
	var btn = [];
		btn.push('<a href="javascript:void(0);" onclick="deleteServer('+row.id+')">删除</a>');
		return btn.join(' | ');
}
//搜索
function Search_<?php echo ($rand); ?>(){
	var queryParams = $('#serverList').datagrid('options').queryParams;
	$.each($("#SearchForm_<?php echo ($rand); ?>").form().serializeArray(), function (index) {
		queryParams[this['name']] = this['value'];
	});
	$('#serverList').datagrid('load');
}
//编辑
function userEdit(id){
	if(typeof(id) !== 'number'){
		$.messager.alert('提示信息', '未选择菜单', 'error');
		return false;
	}
	var url = '<?php echo U('User/edit');?>';
	url += url.indexOf('?') != -1 ? '&uid='+id : '?uid='+id;
	url += '&rand=<?php echo ($rand); ?>';
	$('#userEditBox').dialog({href:url});
	$('#userEditBox').dialog('open');
}
//删除 
function deleteServer(id){
	if(typeof(id) !== 'number'){
		$.messager.alert('提示信息', '未选择', 'error');
		return false;
	}
	$.messager.confirm('提示信息', '确定要删除吗？', function(result){
		if(!result) return false;
		$.post('<?php echo U('Service/deleteservice');?>', {id: id}, function(data){
			if(!data.status){
				$.messager.alert('提示信息', data.info, 'error');
			}else{
				Refresh();
				$.messager.alert('提示信息', data.info, 'info');
			}
		}, 'json');
	});
}

</script>