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
			<li><a href="#">系统配置</a>
			</li>
			<li><a href="#">字典管理</a>
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
			</ul>
		</div>
		<table id="dg_item" title="字典列表" class="easyui-datagrid"
			style="width: 100%;"
			url="${ctx}/${frameworkPath}/item/list?sort=order&&dir=asc"
			pagination="true" rownumbers="true" fitColumns="true"
			singleSelect="false">
			<thead>
				<tr>
					<th data-options="field:'ck',checkbox:true"></th>
					<th field="id" width="50"><fmt:message key="item.id" /></th>
					<th field="name" width="50"><fmt:message key="item.name" /></th>
					<th field="description" width="50"><fmt:message key="item.description" /></th>
					<th field="order" width="50"><fmt:message key="column.order" /></th>
					<th field="creator" width="50"><fmt:message key="column.creator" /></th>
					<th field="created" width="50"><fmt:message key="column.created" /></th>
				</tr>
			</thead>
		</table>
	</div>

	<div id="window_create" class="easyui-dialog" title="新建字典"
		data-options="modal:true,closed:true,iconCls:'icon-save',maximizable:true,width:700,top:20">

	</div>
	<div id="window_edit" class="easyui-dialog" title="编辑字典"
		data-options="modal:true,closed:true,iconCls:'icon-edit',maximizable:true,width:700,top:20">

	</div>
	<script type="text/javascript">
		function createModule(){
			var win = $('#window_create');
			win.window({
				href:'${ctx}/${frameworkPath}/item/create'
			});
			win.window('open');
		};
		
		function editModule(){
			var row = $('#dg_item').datagrid('getSelected');
			if(row){
				var win = $('#window_edit');
				win.window({
					href:'${ctx}/${frameworkPath}/item/edit?id='+row.id,
					onLoad:function(){
						$('#ff_item_edit').form('load', row);
						/* $.ajax({
							type:'GET',
							url:'${ctx}/${frameworkPath}/item/view/'+row.id,
							success:function(data){
								$('#ff_item_create').form('load', data);
							},
							error: function(XmlHttpRequest, textStatus, errorThrown){  
								$.messager.alert('<fmt:message key="message.title" />','错误：'+XmlHttpRequest.status, 'error');;  
			                }  
						}); */
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
					var idArray = new Array();
					for(var i=0; i<rows.length; i++){
						idArray.push(rows[i].id);
		            }
					$.ajax({
						type:'POST',
						url:'${ctx}/${frameworkPath}/item/delete',
						traditional:true,
						data:{'ids':idArray},
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
	</script>
</body>
</html>