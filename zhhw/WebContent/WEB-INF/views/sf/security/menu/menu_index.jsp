<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/include/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<%@ include file="/include/jquery.libs.jsp"%>
<script type="text/javascript">
$(function (){
	$('#tt').tree({
		onClick: function(node){
			$('#dg').datagrid('reload', { 
				parent:node.id
			});
		}
	});
});
</script>
</head>
<body style="background: #f0f9fd;" class="easyui-layout">
	<div data-options="region:'north',split:false" style="height:42px">
		<div class="place">
			<span>位置：</span>
			<ul class="placeul">
				<li><a href="${ctx}/center">首页</a>
				</li>
				<li><a href="#">系统安全</a>
				</li>
				<li><a href="#">菜单管理</a>
				</li>
			</ul>
		</div>
	</div>
	<div data-options="region:'west',split:true,iconCls:'menu-node-menu'" title="菜单"
		style="width: 180px;">
		<ul id="tt" class="easyui-tree"
				data-options="url:'${ctx}/${frameworkPath}/menu/children',method:'get',
				animate:true,dnd:true,lines:true"></ul>
	</div>
	<div data-options="region:'center'">
		
		<div class="rightinfo">
			<div class="tools">
				<ul class="toolbar">
					<li class="click" onClick="createMenu();"><span><img
							src="${ctx}/third-lib/savior/images/t01.png" /> </span>新建</li>
					<li class="click" onClick="editMenu();"><span><img
							src="${ctx}/third-lib/savior/images/t02.png" /> </span>修改</li>
					<li class="click" onClick="deleteMenu();"><span> <img
							src="${ctx}/third-lib/savior/images/t03.png" /> </span>删除</li>
				</ul>
			</div>
			<table id="dg" title="菜单列表" class="easyui-datagrid"
				style="width: 100%;"
				url="${ctx}/${frameworkPath}/menu/index?sort=order&&dir=asc"
				pagination="true" rownumbers="true" fitColumns="true"
				singleSelect="false">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th field="id" width="50">菜单编号</th>
						<th field="name" width="50">菜单名称</th>
						<th field="url" width="50">URL</th>
						<th field="description" width="50">菜单描述</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>

	<div id="window_create" class="easyui-dialog" title="新建菜单"
		data-options="modal:true,closed:true,iconCls:'icon-save',maximizable:true,width:700,top:20">
		
	</div>
	<div id="window_edit" class="easyui-dialog" title="编辑菜单"
		data-options="modal:true,closed:true,iconCls:'icon-edit',maximizable:true,width:700,top:20">
		
	</div>
	<script type="text/javascript">
		function createMenu() {
			var node = $('#tt').tree('getSelected');
			if(node){
				var win = $('#window_create');
				win.window({
					href:'${ctx}/${frameworkPath}/menu/create?parent='+node.id
				});
				win.window('open');
			}
			else{
				$.messager.alert('<fmt:message key="message.title" />',
						'请选择父节点', 'error');
			}
		};

		function editMenu() {
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				var win = $('#window_edit');
				win.window({
					href:'${ctx}/${frameworkPath}/menu/edit?id='+row.id,
					onLoad:function(){
						$.ajax({
							type : 'GET',
							url : '${ctx}/${frameworkPath}/menu/view/' + row.id,
							success : function(data) {
								$('#ff_menu_edit').form('load', data.rows);
							},
							error : function(XmlHttpRequest, textStatus, errorThrown) {
								$.messager.alert('<fmt:message key="message.title" />',
										'错误：' + XmlHttpRequest.status, 'error');
							}
						});
					}
				});
				win.window('open');
				return false;
			} else {
				$.messager.alert('<fmt:message key="message.title" />',
						'<fmt:message key="message.select.one.only" />',
						'error');
				return;
			}
		};

		function deleteMenu() {
			var rows = $('#dg').datagrid('getSelections');
			if (rows.length <= 0) {
				$.messager.alert('<fmt:message key="message.title" />',
						'<fmt:message key="message.select.one.only" />',
						'error');
				return;
			}
			$.messager.confirm('<fmt:message key="message.title" />','是否要删除该菜单？',function(r) {
								if (r) {
									var idArray = new Array();
									for ( var i = 0; i < rows.length; i++) {
										idArray.push(rows[i].id);
									}
									$.ajax({
												type : 'POST',
												url : '${ctx}/${frameworkPath}/menu/delete',
												traditional : true,
												data : {'ids' : idArray},
												success : function(data) {
													$("#dg").datagrid('reload');
													$('#tt').tree("reload");
													$.messager.alert(
																	'<fmt:message key="message.title" />',
																	'<fmt:message key="message.delete.successful" />',
																	'info');
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