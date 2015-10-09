<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/include/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<%@ include file="/include/jquery.libs.jsp"%>
</head>
<body style="background: #f0f9fd;">
	<div class="place">
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="${ctx}/center">首页</a>
			</li>
			<li><a href="#">信息管理</a>
			</li>
			<li><a href="#">终端信息</a>
			</li>
		</ul>
	</div>
	<div class="rightinfo">
		<div class="tools">
			<ul class="toolbar">
				<li class="click" onClick="createModule();"><span><img
						src="${ctx}/third-lib/savior/images/t01.png" /> </span>添加</li>
				<li class="click" onClick="editModule();"><span><img
						src="${ctx}/third-lib/savior/images/t02.png" /> </span>修改</li>
				<li class="click" onClick="deleteModule();"><span>
					<img src="${ctx}/third-lib/savior/images/t03.png" /> </span>删除</li>
				<li class="click" onClick="selectModule();"><span> 
					<img src="${ctx}/third-lib/savior/images/enable.png" /> </span>查找</li>
			</ul>
		</div>
		<div style="margin-bottom:10px;">
			<div style="display:inline;margin-right:30px;margin-left:10px;">
				<fmt:message key="device.name" />：<input id="device_name" type="text"
					style="width: 200px; height: 25px;" class="easyui-textbox"/>
			</div>
			<div style="display:inline;margin-right:30px;margin-left:10px;">
				<fmt:message key="device.version" />：<input id="device_version" type="text"
					style="width: 200px; height: 25px;" class="easyui-textbox"/>
			</div>
			<div style="display:inline;margin-right:30px;margin-left:10px;">
				<fmt:message key="device.manufacturer" />：<input id="device_manu"
					type="text" style="width: 200px; height: 25px;" class="easyui-textbox"
					data-options="required:false,multiline:true" />
			</div>
			
		</div>
		<table id="dg_item" title="终端信息列表" class="easyui-datagrid"
			style="width: 100%;"
			url="${ctx}/devicemanage/getAllDevice"
			pagination="true" rownumbers="true" fitColumns="false"
			singleSelect="false">
			<thead>
				<tr>
					<th data-options="field:'ck',checkbox:true"></th>
					<th field="id" width="200"><fmt:message key="device.id" /></th>
					<th field="dev_name" width="200"><fmt:message key="device.name" /></th>
					<th field="version" width="200"><fmt:message key="device.version" /></th>
					<th field="manufacturer" width="200"><fmt:message key="device.manufacturer" /></th>
				</tr>
			</thead>
		</table>
	</div>

	<div id="window_create" class="easyui-dialog" title="新建终端信息"
		data-options="modal:true,closed:true,iconCls:'icon-save',maximizable:true,width:700,top:20">

	</div>
	<div id="window_edit" class="easyui-dialog" title="编辑终端信息"
		data-options="modal:true,closed:true,iconCls:'icon-edit',maximizable:true,width:700,top:20">
	</div>
	<script type="text/javascript">
		function createModule(){
			var win = $('#window_create');
			win.window({
				href:'${ctx}/devicemanage/toAddDevice'
			});
			win.window('open');
		};
		
		function editModule(){
			var row = $('#dg_item').datagrid('getSelected');
			if(row){
				var win = $('#window_edit');
				win.window({
					href:'${ctx}/devicemanage/toUpdateDevice',
					onLoad:function(){
						$('#device_edit').form('load', row);
					}
				});
				win.window('open');
				return false;
			}
			else{
				$.messager.alert('<fmt:message key="message.title" />', 
						'<fmt:message key="message.select.one.only" />', 'error');
				return;
			}
		};
		
		function deleteModule(){
			var rows = $('#dg_item').datagrid('getSelections');
			if(rows.length<=0){
				$.messager.alert('<fmt:message key="message.title" />', 
						'<fmt:message key="message.select.one.only" />', 'error');
				return;
			}
			$.messager.confirm('<fmt:message key="message.title" />', '是否要删除该信息？', function(r){
				if(r){
					$.ajax({
						type:'POST',
						url:'${ctx}/devicemanage/delDevice',
						traditional:true,
						data:{'devices':JSON.stringify(rows)},
						success:function(data){
	                		$.messager.alert('<fmt:message key="message.title" />', 
	                				'<fmt:message key="message.delete.successful" />', 'info');
	                		$("#dg_item").datagrid('reload');  
						},
						error: function(XmlHttpRequest, textStatus, errorThrown){  
							$.messager.alert('<fmt:message key="message.title" />','删除错误：'+XmlHttpRequest.status, 'error');;  
		                }  
					});
					return false;
				}
			});
		};
		
		 function selectModule() {
             $('#dg_item').datagrid('reload',{
            	 	id:$("#device_id").val(),
            		dev_name:$("#device_name").val(),
            	 	version:$("#device_version").val(),
            	 	manufacturer:$("#device_manu").val()
            });
         };
	</script>
</body>
</html>