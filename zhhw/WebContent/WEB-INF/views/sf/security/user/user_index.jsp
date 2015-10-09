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
				org:node.id
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
				<li><a href="#">用户管理</a>
				</li>
			</ul>
		</div>
	</div>
	<div data-options="region:'west',split:true,iconCls:'menu-node-org'" title="组织机构树"
		style="width: 180px;">
		<ul id="tt" class="easyui-tree"
				data-options="url:'${ctx}/${frameworkPath}/org/children',method:'get',
				animate:true,dnd:true,lines:true"></ul>
	</div>
	<div data-options="region:'center'">
		
		<div class="rightinfo">
			<div class="tools">
				<ul class="toolbar">
					<li class="click" onClick="createUser();"><span><img
							src="${ctx}/third-lib/savior/images/t01.png" /> </span>添加</li>
					<li class="click" onClick="editUser();"><span><img
							src="${ctx}/third-lib/savior/images/t02.png" /> </span>修改</li>
					<sec:authorize access="hasRole('USER_ENABLE')">
						<li class="click" onClick="deleteUser();"><span> <img
							src="${ctx}/third-lib/savior/images/t03.png" /> </span>删除</li>
					</sec:authorize>		
					<li class="click" onClick="resetPassword();"><span> <img
							src="${ctx}/third-lib/savior/images/resetpassword.png" /> </span><fmt:message key="button.reset.password" /></li>
					<sec:authorize access="hasRole('USER_ENABLE')">
						<li class="click" onClick="enableUser();"><span> <img
							src="${ctx}/third-lib/savior/images/enable.png" /> </span><fmt:message key="button.enable" /></li>
					</sec:authorize>
					<sec:authorize access="hasRole('USER_DISABLE')">
						<li class="click" onClick="disableUser();"><span> <img
							src="${ctx}/third-lib/savior/images/disable.png" /> </span><fmt:message key="button.disable" /></li>
					</sec:authorize>
					<sec:authorize access="hasRole('USER_ROLE')">
						<li class="click" onClick="assignRole();"><span>
						<img src="${ctx}/third-lib/savior/images/users.png" /> </span>分配角色</li>
					</sec:authorize>
					<sec:authorize access="hasRole('USER_ROLE')">
						<li class="click" onClick="showUsercard();"><span>
						<img src="${ctx}/third-lib/savior/images/view.png" /> </span>查看头像</li>
					</sec:authorize>
				</ul>
			</div>
			<table id="dg" title="用户列表" class="easyui-datagrid"
				style="width: 100%;"
				url="${ctx}/${frameworkPath}/user/index?sort=order&&dir=asc"
				pagination="true" rownumbers="true" fitColumns="true"
				singleSelect="false">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th field="username" width="20"><fmt:message key="user.username" /></th>
						<th field="name" width="20"><fmt:message key="user.name" /></th>
						<th field="email" width="20"><fmt:message key="user.email" /></th>
						<th field="positionname" width="20"><fmt:message key="user.position" /></th>
						<th field="orgname" width="20"><fmt:message key="user.org" /></th>
						<th data-options="field:'enabled',width:20,align:'left',formatter:formatBoolean">是否启用</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>

	<div id="window_create" class="easyui-dialog" title="新建用户"
		data-options="modal:true,closed:true,iconCls:'icon-add',maximizable:true,width:700,top:20,height:400">
		
	</div>
	
	<div id="window_edit" class="easyui-dialog" title="修改用户"
		data-options="modal:true,closed:true,iconCls:'icon-edit',maximizable:true,width:700,top:20,height:400">
		
	</div>
	
	<div id="window_assign_role" class="easyui-dialog" title="分配角色"
		data-options="modal:true,closed:true,iconCls:'icon-edit',maximizable:true,width:700,top:20,height:400">
		
	</div>

	<script type="text/javascript">
	 	function formatBoolean(val,row,rowindex){
	        if (val==false){
	            return '<span style="color:red;">停用</span>';
	        } else {
	        	return '<span style="color:green;">启用</span>';
	        }
	    };
	    
	    function formatRole(val,row,rowindex){
	    	return '<a href="#"><img src="${ctx}/static/style/images/button/group_key.png"></img></a>';
	    };
	    
	    //查看头像
	    function showUsercard(){
	    	var row = $('#dg').datagrid('getSelected');
			if (row) {
				window.location.href="${ctx}/${frameworkPath}/user/showusercard?username=" + row.username;
				return false;
			} else {
				$.messager.alert('<fmt:message key="message.title" />',
						'<fmt:message key="message.select.one.only" />',
						'error');
				return false;
			}
	    }
	    
	    function assignRole(){
	    	var row = $('#dg').datagrid('getSelected');
			if (row) {
				var win = $('#window_assign_role');
				win.window({
					href:'${ctx}/${frameworkPath}/user/role?username='+row.username
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
	 	
		function createUser() {
			var node = $('#tt').tree('getSelected');
			if(node){
				var win = $('#window_create');
				win.window({
					href:'${ctx}/${frameworkPath}/user/create?org='+node.id
				});
				win.window('open');//window('refresh','${ctx}/${frameworkPath}/user/create?org='+node.id);
			}
			else{
				$.messager.alert('<fmt:message key="message.title" />',
						'请选择父节点', 'error');
			}
		};

		function editUser() {
			var node = $('#tt').tree('getSelected');
			if(node){
				var row = $('#dg').datagrid('getSelected');
				if (row) {
					var win = $('#window_edit');
					win.window({
						href:'${ctx}/${frameworkPath}/user/edit?org='+node.id+'&&username='+row.username,
						onLoad:function(){
							$.ajax({
								type : 'GET',
								url : '${ctx}/${frameworkPath}/user/view/' + row.username,
								success : function(data) {
									$('#ff_user_edit').form('load', data.rows);
								},
								error : function(XmlHttpRequest, textStatus, errorThrown) {
									$.messager.alert('<fmt:message key="message.title" />',
											'错误：' + XmlHttpRequest.status, 'error');
								}
							});
						}
					});
					win.window('open');//.window('refresh','${ctx}/${frameworkPath}/user/edit?org='+node.id+'&&username='+row.username);
					
					return false;
				} else {
					$.messager.alert('<fmt:message key="message.title" />',
							'<fmt:message key="message.select.one.only" />',
							'error');
					return;
				}
			}
			else{
				$.messager.alert('<fmt:message key="message.title" />',
						'请选择父节点', 'error');
			}
		};

		function deleteUser() {
			var rows = $('#dg').datagrid('getSelections');
			if (rows.length <= 0) {
				$.messager.alert('<fmt:message key="message.title" />',
						'<fmt:message key="message.select.one.only" />',
						'error');
				return;
			}
			$.messager.confirm('<fmt:message key="message.title" />','是否要删除选中的用户？',function(r) {
								if (r) {
									var idArray = new Array();
									for ( var i = 0; i < rows.length; i++) {
										idArray.push(rows[i].username);
									}
									$.ajax({
												type : 'POST',
												url : '${ctx}/${frameworkPath}/user/delete',
												traditional : true,
												data : {'usernames' : idArray},
												success : function(data) {
													if(data.success){
														$("#dg").datagrid('reload');
														$('#tt').tree("reload");
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
		
		function enableUser() {
			var rows = $('#dg').datagrid('getSelections');
			if (rows.length <= 0) {
				$.messager.alert('<fmt:message key="message.title" />',
						'<fmt:message key="message.select.one.only" />',
						'error');
				return;
			}
			$.messager.confirm('<fmt:message key="message.title" />','是否要启用选中的用户？',function(r) {
								if (r) {
									var idArray = new Array();
									for ( var i = 0; i < rows.length; i++) {
										idArray.push(rows[i].username);
									}
									$.ajax({
												type : 'POST',
												url : '${ctx}/${frameworkPath}/user/enable',
												traditional : true,
												data : {'usernames' : idArray},
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
		
		function disableUser() {
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
										idArray.push(rows[i].username);
									}
									$.ajax({
												type : 'POST',
												url : '${ctx}/${frameworkPath}/user/disable',
												traditional : true,
												data : {'usernames' : idArray},
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
																	'错误：' + XmlHttpRequest.status,'error');
												}
											});
									return false;
								}
							});
		};
		
		function resetPassword() {
			var rows = $('#dg').datagrid('getSelections');
			if (rows.length <= 0) {
				$.messager.alert('<fmt:message key="message.title" />',
						'<fmt:message key="message.select.one.only" />',
						'error');
				return;
			}
			$.messager.confirm('<fmt:message key="message.title" />','确定要重置所选用户的密码吗？',function(r) {
								if (r) {
									var idArray = new Array();
									for ( var i = 0; i < rows.length; i++) {
										idArray.push(rows[i].username);
									}
									$.ajax({
												type : 'POST',
												url : '${ctx}/${frameworkPath}/user/resetpassword',
												traditional : true,
												data : {'usernames' : idArray},
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
																	'错误：' + XmlHttpRequest.status,'error');
												}
											});
									return false;
								}
							});
		};
	</script>
</body>
</html>