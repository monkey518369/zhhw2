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
	<div class="rightinfo">
		<table id="dgRole" title="角色列表" class="easyui-datagrid"
			style="width: 100%;" toolbar="#toolbar"
			url="${ctx}/${frameworkPath}/user/role/${param.username}?sort=order&&dir=asc" method="GET" rownumbers="true" fitColumns="true"
			singleSelect="false">
			<thead>
				<tr>
					<th data-options="field:'ck',checkbox:true"></th>
					<th field="id" width="20"><fmt:message key="role.id" /></th>
					<th field="name" width="30"><fmt:message key="role.name" /></th>
				</tr>
			</thead>
		</table>
	</div>
	<div id="toolbar" style="height:auto">
		<a href="#" class="easyui-linkbutton" iconCls="icon-save" plain="true" onClick="submit()">保存</a>        
	</div>
	<script type="text/javascript">
		function submit() {
			var rows = $('#dgRole').datagrid('getSelections');
			if (rows.length <= 0) {
				$.messager.alert('<fmt:message key="message.title" />',
						'<fmt:message key="message.select.one.only" />',
						'error');
				return;
			}
			var idArray = new Array();
			for ( var i = 0; i < rows.length; i++) {
				idArray.push(rows[i].id);
			}
			$.ajax({
				type : 'POST',
				url : '${ctx}/${frameworkPath}/user/role',
				traditional : true,
				data : {'ids' : idArray, username:'${param.username}'},
				success : function(data) {
					if(data.success){
						$('#window_assign_role').window('close');
						$.messager.alert(
										'<fmt:message key="message.title" />',
										'<fmt:message key="message.save.successful" />',
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
		}
	</script>
</body>
</html>