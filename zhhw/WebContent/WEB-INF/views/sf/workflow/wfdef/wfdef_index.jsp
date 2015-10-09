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
			<li><a href="#">BPM平台</a>
			</li>
			<li><a href="#">流程定义管理</a>
			</li>
		</ul>
	</div>
	<div class="rightinfo">
		<div class="tools">
			<ul class="toolbar">
				<li class="click" onClick="createProcess();"><span><img
						src="${ctx}/savior/images/t01.png" /> </span>新建流程</li>
				<%-- <li class="click" onClick="editModule();"><span><img
						src="${ctx}/savior/images/t02.png" /> </span>修改</li>
				<li class="click" onClick="deleteModule();"><span>
					<img src="${ctx}/savior/images/t03.png" /> </span>删除</li> --%>
				<li class="click" onClick="viewProcess();"><span>
					<img src="${ctx}/savior/images/process_view.png" /> </span>查看流程</li>
			</ul>
		</div>
		<table id="dg_wfdef" title="流程列表" class="easyui-datagrid"
			style="width: 100%;"
			url="${ctx}/${frameworkPath}/wfdef/index"
			pagination="true" rownumbers="true" fitColumns="true"
			singleSelect="false">
			<thead>
				<tr>
					<th data-options="field:'ck',checkbox:true"></th>
					<th field="id" width="50">编号</th>
					<th field="processId" width="50">流程编号</th>
					<th field="name" width="50">流程名称</th>
					<th field="displayName" width="50">显示名称</th>
					<th field="definitionType" width="50">定义类型</th>
					<th field="version" width="50">版本号</th>
				</tr>
			</thead>
		</table>
	</div>

	<div id="window_create" class="easyui-dialog" title="新建流程"
		data-options="modal:true,closed:true,maximized:true,iconCls:'icon-save',maximizable:true,width:700,top:20">

	</div>
	<div id="window_view" class="easyui-dialog" title="预览流程"
		data-options="modal:true,closed:true,maximized:true,iconCls:'icon-edit',maximizable:true,width:700,top:20">

	</div>
	<script type="text/javascript">
		function createProcess(){
			var win = $('#window_create');
			win.window({
				href:'${ctx}/${frameworkPath}/wfdef/create'
			});
			win.window('open');
		};
		
		function editModule(){
			var row = $('#dg').datagrid('getSelected');
			if(row){
				var win = $('#window_edit');
				win.window({
					href:'${ctx}/${frameworkPath}/module/edit?id='+row.id,
					onLoad:function(){
						$.ajax({
							type:'GET',
							url:'${ctx}/${frameworkPath}/module/view/'+row.id,
							success:function(data){
								$('#ff_module_edit').form('load', data.rows);
							},
							error: function(XmlHttpRequest, textStatus, errorThrown){  
								$.messager.alert('<fmt:message key="message.title" />','错误：'+XmlHttpRequest.status, 'error');;  
			                }  
						});
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
			var rows = $('#dg').datagrid('getSelections');
			if(rows.length<=0){
				$.messager.alert('<fmt:message key="message.title" />', 
						'<fmt:message key="message.select.one.only" />', 'error');
				return;
			}
			$.messager.confirm('<fmt:message key="message.title" />', '是否要删除该信息？', function(r){
				if(r){
					var idArray = new Array();
					for(var i=0; i<rows.length; i++){
						idArray.push(rows[i].id);
		            }
					$.ajax({
						type:'POST',
						url:'${ctx}/${frameworkPath}/module/delete',
						traditional:true,
						data:{'ids':idArray},
						success:function(data){
							$("#dg").datagrid('reload');  
	                		$.messager.alert('<fmt:message key="message.title" />', 
	                				'<fmt:message key="message.delete.successful" />', 'info');
						},
						error: function(XmlHttpRequest, textStatus, errorThrown){  
							$.messager.alert('<fmt:message key="message.title" />','删除错误：'+XmlHttpRequest.status, 'error');;  
		                }  
					});
					return false;
				}
			});
		};
		
		function viewProcess(){
			var row = $('#dg_wfdef').datagrid('getSelected');
			if(row){
				var win = $('#window_view');
				win.window({
					href:'${ctx}/${frameworkPath}/wfdef/view?processId='+row.id+'&&version='+row.version
				});
				win.window('open');
				
				return false;
			}
			else{
				$.messager.alert('<fmt:message key="message.title" />', 
						'<fmt:message key="message.select.one.only" />', 'error');
				return;
			}
		}
	</script>
</body>
</html>