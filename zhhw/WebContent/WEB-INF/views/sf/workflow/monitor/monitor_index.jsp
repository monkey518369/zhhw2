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
<body style="background: #f0f9fd;" class="easyui-layout">
	<div data-options="region:'north',height:200" class="easyui-panel">
		<table id="dg_ins" title="流程列表" class="easyui-datagrid"
			style="width: 100%;height:100%" data-options="url:'${ctx}/${frameworkPath}/wfdef/index',rownumbers:true, 
			fitColumns:true,singleSelect:false,
			onClickRow:function(index,row){
				$('#dg_proceeIns').datagrid('reload',{
					processId:row.processId
				});
			}">
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
	<div data-options="region:'center'" class="easyui-panel">
		<table id="dg_proceeIns" title="流程实例" class="easyui-datagrid"
			style="width: 100%;height:100%" toolbar="#toolbar"
			url="${ctx}/${frameworkPath}/monitor/index" rownumbers="true" fitColumns="true"
			singleSelect="false">
			<thead>
				<tr>
					<th data-options="field:'ck',checkbox:true"></th>
					<th field="id" width="50">流程实例编号</th>
					<th field="name" width="50">流程实例名称</th>
					<th field="state" width="50" formatter="formatState">流程实例状态</th>
				</tr>
			</thead>
		</table>
	</div>
	<div id="toolbar">
		<a href="#" class="easyui-linkbutton" data-options="iconCls:'button-suspend',plain:true">挂起流程实例</a>
		<a href="#" class="easyui-linkbutton" data-options="iconCls:'button-restore',plain:true">恢复流程实例</a>
		<a href="#" class="easyui-linkbutton" data-options="iconCls:'button-delete',plain:true">删除流程实例</a>
		<a href="#" class="easyui-linkbutton" data-options="iconCls:'button-fullscreen',plain:true" onClick="viewProcessIns()">监视流程实例</a>
	</div>
	<div id="window_monitor" class="easyui-window" title="监视流程"
		data-options="modal:true,closed:true,maximized:true,iconCls:'button-fullscreen',maximizable:true,width:700,top:20">

	</div>
	<script type="text/javascript">
		function formatState(value,row){
			switch(value){
			case '0':
				return '初始化中';
			case '1':
				return '<font size="3" color="green">运行中</font>';
			case '7':
				return '已经结束';
			case '9':
				return '被撤销';
			}
	    };
	    function viewProcessIns(){
			var row = $('#dg_proceeIns').datagrid('getSelected');
			if(row){
				var win = $('#window_monitor');
				win.window({
					href:'${ctx}/${frameworkPath}/monitor/view?processInstanceId='+row.id
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