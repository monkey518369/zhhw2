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
			<li><a href="#">岗位管理</a>
			</li>
		</ul>
	</div>
	<div class="rightinfo">
		<div class="tools">
			<ul class="toolbar">
				<li class="click" onClick="createPosition();"><span><img
						src="${ctx}/third-lib/savior/images/t01.png" /> </span>添加</li>
				<li class="click" onClick="editPosition();"><span><img
						src="${ctx}/third-lib/savior/images/t02.png" /> </span>修改</li>
				<li class="click" onClick="deletePosition();"><span>
					<img src="${ctx}/third-lib/savior/images/t03.png" /> </span>删除</li>
				<li class="click" onClick="assignRoles();"><span>
					<img src="${ctx}/third-lib/savior/images/roles.png" /> </span>分配角色</li>
			</ul>
		</div>
		<table id="dg" title="岗位列表" class="easyui-datagrid"
			style="width: 100%;"
			url="${ctx}/${frameworkPath}/position/list?sort=order&&dir=asc"
			pagination="true" rownumbers="true" fitColumns="true"
			singleSelect="false">
			<thead>
				<tr>
					<th data-options="field:'ck',checkbox:true"></th>
					<th field="id" width="20"><fmt:message key="position.id" /></th>
					<th field="name" width="30"><fmt:message key="position.name" /></th>
					<th field="description" width="50"><fmt:message key="position.description" /></th>
					<th data-options="field:'type',width:20,align:'left',formatter:formatType"><fmt:message key="position.type" /></th>
					<th field="order" width="15"><fmt:message key="column.order" /></th>
					<th field="creator" width="50"><fmt:message key="column.creator" /></th>
					<th field="created" width="50"><fmt:message key="column.created" /></th>
				</tr>
			</thead>
		</table>
	</div>

	<div id="window_create" class="easyui-dialog" title="新建岗位"
		data-options="modal:true,closed:true,iconCls:'icon-add',maximizable:true,width:700,top:20">
		
	</div>
	
	<div id="window_edit" class="easyui-dialog" title="编辑岗位"
		data-options="modal:true,closed:true,iconCls:'icon-edit',maximizable:true,width:700,top:20,height:420">
		
	</div>
	
	<div id="window_assign" class="easyui-dialog" title="分配角色"
		data-options="modal:true,closed:true,iconCls:'icon-edit',maximizable:true,width:700,top:20,height:300">
		
	</div>
	
	<script type="text/javascript">
		function formatType(val,row){
	        if (val==0){
	            return '全局';
	        } else if (val==1){
	            return '指定机构';
	        }
	        else if (val==2){
	            return '指定级别';
	        }
	    };
		function createPosition() {
			var win = $('#window_create');
			win.window({
				href:'${ctx}/${frameworkPath}/position/create'
			});
			win.window('open');
		};
		
		function editPosition() {
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				var win = $('#window_edit');
				win.window({
					href:'${ctx}/${frameworkPath}/position/edit?id='+row.id,
					onLoad:function(){
						$.ajax({
							type : 'GET',
							url : '${ctx}/${frameworkPath}/position/view/' + row.id,
							success : function(data) {
								$('#ff_position_edit').form('load', data.rows);
								var rec = $('#ccl').val();
								if(rec==1){
									$('#org').combo('enable');
									$('#positionLevels').combo('disable');
								}
								else if(rec==2){
									$('#org').combo('disable');
									$('#positionLevels').combo('enable');
								}
								else if(rec==0){
									$('#org').combo('disable');
									$('#positionLevels').combo('disable');
								}
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
		
		function deletePosition() {
			var rows = $('#dg').datagrid('getSelections');
			if (rows.length <= 0) {
				$.messager.alert('<fmt:message key="message.title" />',
						'<fmt:message key="message.select.one.only" />',
						'error');
				return;
			}
			$.messager.confirm('<fmt:message key="message.title" />','是否要删除选中的岗位？',function(r) {
								if (r) {
									var idArray = new Array();
									for ( var i = 0; i < rows.length; i++) {
										idArray.push(rows[i].id);
									}
									$.ajax({
												type : 'POST',
												url : '${ctx}/${frameworkPath}/position/delete',
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
		
		function assignRoles() {
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				var win = $('#window_assign');
				win.window({
					href:'${ctx}/${frameworkPath}/position/role?positionId='+row.id/* ,
					onLoad:function(){
						$.ajax({
							type : 'GET',
							url : '${ctx}/${frameworkPath}/position/view/' + row.id,
							success : function(data) {
								$('#ff_position_edit').form('load', data.rows);
								var rec = $('#ccl').val();
								if(rec==1){
									$('#org').combo('enable');
									$('#positionLevels').combo('disable');
								}
								else if(rec==2){
									$('#org').combo('disable');
									$('#positionLevels').combo('enable');
								}
								else if(rec==0){
									$('#org').combo('disable');
									$('#positionLevels').combo('disable');
								}
							},
							error : function(XmlHttpRequest, textStatus, errorThrown) {
								$.messager.alert('<fmt:message key="message.title" />',
										'错误：' + XmlHttpRequest.status, 'error');
							}
						});
					} */
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
	</script>
</body>
</html>