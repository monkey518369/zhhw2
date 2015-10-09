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
			<li><a href="#">系统安全</a>
			</li>
			<li><a href="#">角色管理</a>
			</li>
		</ul>
	</div>
	<div class="rightinfo">
		<div class="tools">
			<ul class="toolbar">
				<li class="click" onClick="createRole();"><span><img
						src="${ctx}/third-lib/savior/images/t01.png" /> </span>添加</li>
				<li class="click" onClick="editRole();"><span><img
						src="${ctx}/third-lib/savior/images/t02.png" /> </span>修改</li>
				<li class="click" onClick="deleteRole();"><span>
					<img src="${ctx}/third-lib/savior/images/t03.png" /> </span>删除</li>
				<li class="click" onClick="assignUser();"><span>
					<img src="${ctx}/third-lib/savior/images/users.png" /> </span>分配用户</li>
				<li class="click" onClick="assignMenu();"><span>
					<img src="${ctx}/third-lib/savior/images/menus.png" /> </span>分配菜单</li>
				<li class="click" onClick="assignFunction();"><span>
					<img src="${ctx}/third-lib/savior/images/function.png" /> </span>分配功能</li>
			</ul>
		</div>
		<table id="dg" title="角色列表" class="easyui-datagrid"
			style="width: 100%;"
			url="${ctx}/${frameworkPath}/role/index?sort=order&&dir=asc"
			pagination="true" rownumbers="true" fitColumns="true"
			singleSelect="false">
			<thead>
				<tr>
					<th data-options="field:'ck',checkbox:true"></th>
					<th field="id" width="50"><fmt:message key="role.id" /></th>
					<th field="name" width="50"><fmt:message key="role.name" /></th>
					<th field="creator" width="50"><fmt:message key="column.creator" /></th>
					<th field="created" width="50"><fmt:message key="column.created" /></th>
				</tr>
			</thead>
		</table>
	</div>

	<div id="window_create" class="easyui-dialog" title="新建角色"
		data-options="modal:true,closed:true,iconCls:'icon-add',maximizable:true,width:700,top:20,height:400">
		
	</div>
	
	<div id="window_edit" class="easyui-dialog" title="编辑角色"
		data-options="modal:true,closed:true,iconCls:'icon-edit',maximizable:true,width:700,top:20,height:400">
		
	</div>
	
	<div id="window_assign_menu" class="easyui-dialog" title="分配菜单"
		data-options="modal:true,closed:true,iconCls:'icon-edit',maximizable:true,width:700,top:20,height:400">
		
	</div>
	
	<div id="window_assign_user" class="easyui-dialog" title="分配用户"
		data-options="modal:true,closed:true,iconCls:'icon-edit',maximizable:true,width:700,top:20,height:400">
		
	</div>
	
	<div id="window_assign_function" class="easyui-dialog" title="分配功能"
		data-options="modal:true,closed:true,iconCls:'icon-edit',maximizable:true,width:700,top:20,height:400">
		
	</div>
	
	<script type="text/javascript">
		function createRole() {
			var win = $('#window_create');
			win.window('open').window('refresh','${ctx}/${frameworkPath}/role/create');
		};
		
		function editRole() {
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				var win = $('#window_edit');
				win.window({
					href:'${ctx}/${frameworkPath}/role/edit?id='+row.id,
					onLoad:function(){
						$.ajax({
							type : 'GET',
							url : '${ctx}/${frameworkPath}/role/view/' + row.id,
							success : function(data) {
								$('#ff_role_edit').form('load', data.rows);
							},
							error : function(XmlHttpRequest, textStatus, errorThrown) {
								$.messager.alert('<fmt:message key="message.title" />',
										'错误：' + XmlHttpRequest.status, 'error');
							}
						});
					}
				});
				win.window('open');//.window('refresh','${ctx}/${frameworkPath}/role/edit?id='+row.id);
				
				return false;
			} else {
				$.messager.alert('<fmt:message key="message.title" />',
						'<fmt:message key="message.select.one.only" />',
						'error');
				return false;
			}
		};
		
		function assignMenu() {
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				var win = $('#window_assign_menu');
				win.window({
					href:'${ctx}/${frameworkPath}/role/menu?role='+row.id,
					onLoad:function(){
						
					}
				});
				win.window('open');
				
				return false;
			} else {
				$.messager.alert('<fmt:message key="message.title" />',
						'<fmt:message key="message.select.one.only" />',
						'error');
				return false;
			}
		};
		
		function assignUser() {
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				var win = $('#window_assign_user');
				win.window({
					href:'${ctx}/${frameworkPath}/role/user?role='+row.id,
					onLoad:function(){
						
					}
				});
				win.window('open');
				
				return false;
			} else {
				$.messager.alert('<fmt:message key="message.title" />',
						'<fmt:message key="message.select.one.only" />',
						'error');
				return false;
			}
		};
		
		function assignFunction() {
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				var win = $('#window_assign_function');
				win.window({
					href:'${ctx}/${frameworkPath}/role/function?role='+row.id,
					onLoad:function(){
						
					}
				});
				win.window('open');
				
				return false;
			} else {
				$.messager.alert('<fmt:message key="message.title" />',
						'<fmt:message key="message.select.one.only" />',
						'error');
				return false;
			}
		};
		
		function deleteRole() {
			var rows = $('#dg').datagrid('getSelections');
			if (rows.length <= 0) {
				$.messager.alert('<fmt:message key="message.title" />',
						'<fmt:message key="message.select.one.only" />',
						'error');
				return;
			}
			$.messager.confirm('<fmt:message key="message.title" />','是否要删除选中的角色？',function(r) {
								if (r) {
									var idArray = new Array();
									for ( var i = 0; i < rows.length; i++) {
										idArray.push(rows[i].id);
									}
									$.ajax({
												type : 'POST',
												url : '${ctx}/${frameworkPath}/role/delete',
												traditional : true,
												data : {'ids' : idArray},
												success : function(data) {
													if(data.success){
														$("#dg").datagrid('reload');
														$.messager.alert(
																		'<fmt:message key="message.title" />',
																		'<fmt:message key="message.delete.successful" />',
																		'info');
													}
													else{
														$.messager.alert(
																'<fmt:message key="message.title" />',data.error,'error');
													}
												},
												error : function(XmlHttpRequest, textStatus, errorThrown) {
													$.messager.alert(
																	'<fmt:message key="message.title" />',
																	'删除错误：' + XmlHttpRequest.status,'error');
												}
											});
									return false;
								}
							});
		};
	</script>
</body>
</html>