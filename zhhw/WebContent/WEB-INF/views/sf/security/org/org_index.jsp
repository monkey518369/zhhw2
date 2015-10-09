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
	$('#tt_org').tree({
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
				<li><a href="#">组织机构管理</a>
				</li>
			</ul>
		</div>
	</div>
	<div data-options="region:'west',split:true,iconCls:'menu-node-org'" title="组织机构树"
		style="width: 180px;">
		<ul id="tt_org" class="easyui-tree"
				data-options="url:'${ctx}/${frameworkPath}/org/children',method:'get',
				animate:true,dnd:true,lines:true"></ul>
	</div>
	<div data-options="region:'center'">
		<div class="rightinfo">
			<div class="tools">
				<ul class="toolbar">
					<li class="click" onClick="createOrg();"><span><img
							src="${ctx}/third-lib/savior/images/t01.png" /> </span>添加</li>
					<li class="click" onClick="editOrg();"><span><img
							src="${ctx}/third-lib/savior/images/t02.png" /> </span>修改</li>
					<li class="click" onClick="deleteOrg();"><span> <img
							src="${ctx}/third-lib/savior/images/t03.png" /> </span>删除</li>
					<li class="click" onClick="enableOrg();"><span> <img
							src="${ctx}/third-lib/savior/images/enable.png" /> </span>启用组织</li>
					<li class="click" onClick="disableOrg();"><span> <img
							src="${ctx}/third-lib/savior/images/disable.png" /> </span>停用组织</li>
				</ul>
			</div>
			<table id="dg" title="组织机构列表" class="easyui-datagrid"
				style="width: 100%;"
				url="${ctx}/${frameworkPath}/org/index?sort=order&&dir=asc"
				pagination="true" rownumbers="true" fitColumns="true"
				singleSelect="false">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th field="id" width="20">组织机构编号</th>
						<th field="name" width="30">组织机构名称</th>
						<th field="contact" width="20">联系人</th>
						<th field="address" width="50">地址</th>
						<th field="tel" width="20">联系电话</th>
						<th data-options="field:'enabled',width:20,align:'left',formatter:formatBoolean">是否启用</th>
						<th field="description" width="50">组织机构描述</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>

	<div id="window_create" class="easyui-dialog" title="新建组织机构"
		data-options="modal:true,closed:true,iconCls:'icon-add',maximizable:true,width:700,top:20,height:400">
		
	</div>
	
	<div id="window_edit" class="easyui-dialog" title="编辑组织结构"
		data-options="modal:true,closed:true,iconCls:'icon-edit',maximizable:true,width:700,top:20,height:400">
		
	</div>

	<script type="text/javascript">
	 	function formatBoolean(val,row){
	        if (val==false){
	            return '<span style="color:red;">停用</span>';
	        } else {
	        	return '<span style="color:green;">启用</span>';
	        }
	    };
	 	
		function createOrg() {
			var node = $('#tt_org').tree('getSelected');
			if(node){
				var win = $('#window_create');
				win.window({
					href:'${ctx}/${frameworkPath}/org/create?parent='+node.id
				});
				win.window('open');
			}
			else{
				$.messager.alert('<fmt:message key="message.title" />',
						'请选择父节点', 'error');
			}
		};
		
		function editOrg() {
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				var win = $('#window_edit');
				win.window({
					href:'${ctx}/${frameworkPath}/org/edit?id='+row.id,
					onLoad:function(){
						$.ajax({
							type : 'GET',
							url : '${ctx}/${frameworkPath}/org/view/' + row.id,
							success : function(data) {
								$('#ff_org_edit').form('load', data.rows);
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

		function deleteOrg() {
			var rows = $('#dg').datagrid('getSelections');
			if (rows.length <= 0) {
				$.messager.alert('<fmt:message key="message.title" />',
						'<fmt:message key="message.select.one.only" />',
						'error');
				return;
			}
			$.messager.confirm('<fmt:message key="message.title" />','是否要删除选中的组织？',function(r) {
								if (r) {
									var idArray = new Array();
									for ( var i = 0; i < rows.length; i++) {
										idArray.push(rows[i].id);
									}
									$.ajax({
												type : 'POST',
												url : '${ctx}/${frameworkPath}/org/delete',
												traditional : true,
												data : {'ids' : idArray},
												success : function(data) {
													if(data.success){
														$("#dg").datagrid('reload');
														$('#tt_org').tree("reload");
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
		
		function enableOrg() {
			var rows = $('#dg').datagrid('getSelections');
			if (rows.length <= 0) {
				$.messager.alert('<fmt:message key="message.title" />',
						'<fmt:message key="message.select.one.only" />',
						'error');
				return;
			}
			$.messager.confirm('<fmt:message key="message.title" />','是否要启用选中的组织？',function(r) {
								if (r) {
									var idArray = new Array();
									for ( var i = 0; i < rows.length; i++) {
										idArray.push(rows[i].id);
									}
									$.ajax({
												type : 'POST',
												url : '${ctx}/${frameworkPath}/org/enable',
												traditional : true,
												data : {'ids' : idArray},
												success : function(data) {
													if(data.success){
														$("#dg").datagrid('reload');
														$.messager.alert(
																		'<fmt:message key="message.title" />',
																		'<fmt:message key="message.operation.successful" />',
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
		
		function disableOrg() {
			var rows = $('#dg').datagrid('getSelections');
			if (rows.length <= 0) {
				$.messager.alert('<fmt:message key="message.title" />',
						'<fmt:message key="message.select.one.only" />',
						'error');
				return;
			}
			$.messager.confirm('<fmt:message key="message.title" />','是否要停用选中的组织？',function(r) {
								if (r) {
									var idArray = new Array();
									for ( var i = 0; i < rows.length; i++) {
										idArray.push(rows[i].id);
									}
									$.ajax({
												type : 'POST',
												url : '${ctx}/${frameworkPath}/org/disable',
												traditional : true,
												data : {'ids' : idArray},
												success : function(data) {
													if(data.success){
														$("#dg").datagrid('reload');
														$.messager.alert(
																		'<fmt:message key="message.title" />',
																		'<fmt:message key="message.operation.successful" />',
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