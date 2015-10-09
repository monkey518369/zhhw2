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
	<div data-options="region:'center',split:true,iconCls:'menu-node-org'" style="width: 100%;height:100%">
			<div id="panel_function" class="easyui-panel" title="<fmt:message key="function" />" data-options="fit:true,tools:'#tt'">
				 <%-- <ul id="tt_function" class="easyui-tree"
					data-options="url:'${ctx}/${frameworkPath}/role/function/${param.role}',method:'get',
					animate:true,dnd:true,lines:true,checkbox:true,onlyLeafCheck:true"></ul> --%>
					<script type="text/javascript">
						var tree = new Ext.tree.TreePanel({
							el:'panel_function',
							autoScroll : true,
							margins : '0 0 0 5',
							border:false,
							root : new Ext.tree.AsyncTreeNode({
								text : '<fmt:message key="function" />',
								draggable : false,
								iconCls : 'node-root',
								id : 'TREE_ROOT_NODE'
							}),
							loader : new Ext.tree.TreeLoader({
								requestMethod : 'GET',
								dataUrl : '${ctx}/${frameworkPath}/role/function2/${param.role}'
							})
				    	});
						
						tree.render();
						
						tree.expandAll();
					</script>
			</div>
			<div id="tt">
				<a href="#" class="icon-save" onclick="save()"></a>
				<a href="#" class="icon-reload" onclick="refresh()"></a>  
			</div>
	</div>
	<script type="text/javascript">
		function refresh(){
			tree.root.reload();
			tree.expandAll();
		};
		/*保存操作*/
		function save(){
			$.messager.progress({
                title:'请稍后',
                msg:'正在保存数据...'
            });
			/* var nodes = $('#tt_function').tree('getChecked');
			var checked = new Array();
			for(var i=0;i<nodes.length;i++){
				checked.push(nodes[i].id);
			} */
			$.ajax({
				type : 'POST',
				url : '${ctx}/${frameworkPath}/role/function2',
				traditional : true,
				data : {'checked' : tree.getChecked('id'),role:'${param.role}'},
				success : function(data) {
					if(data.success){
						$.messager.progress('close');
						$('#window_assign_function').window('close');
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
					$.messager.progress('close');
					$.messager.alert(
									'<fmt:message key="message.title" />',
									'错误：' + XmlHttpRequest.status,'error');
				}
			});
		}
	</script>
</body>
</html>