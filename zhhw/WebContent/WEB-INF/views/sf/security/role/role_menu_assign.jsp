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
	<div data-options="region:'center',split:true,iconCls:'menu-node-org'" style="width: 100%;height:100%">
			<div id="panel_menu" class="easyui-panel" title="菜单" data-options="fit:true,tools:'#tt'">
				 <%-- <ul id="tt_menu" class="easyui-tree"
					data-options="url:'${ctx}/${frameworkPath}/role/menu/${param.role}',method:'get',
					animate:true,dnd:true,lines:true,checkbox:true,cascadeCheck:false,
					onLoadSuccess:function(node,data){
						if(data){
							$(data).each(function(index,d){
								if(this.state == 'closed'){
									$(this).tree('expandAll');
								}
							});
						}
					},
					onCheck:function(node,checked){
						if(checked){
							var parent = $('#tt_menu').tree('getParent',node.target);
							if(parent){
								if(parent.id!='TREE_ROOT_NODE'){
									$('#tt_menu').tree('check',parent.target);
								}
								//else{
									//先获取所有的子节点,选中所有的子节点
									//var nodes = $('#tt_menu').tree('getChildren',node.target);
									//$.each(nodes,function(index,value){
										//$('#tt_menu').tree('check',value.target);
									//});
								//}
							}
						}
						else{
							var parent = $('#tt_menu').tree('getParent',node.target);
							if(parent){
								if(parent.id!='TREE_ROOT_NODE'){
									//先获取所有的子节点，如果其中的子节点还有选中状态的，父节点的状态处于选中状态，否则就是不选中的状态
									var temp =false;
									var nodes = $('#tt_menu').tree('getChildren',parent.target);
									$.each(nodes,function(index,value){
										if(value.checked){
											temp = true;
										}
									});
									if(!temp){
										$('#tt_menu').tree('uncheck',parent.target);
									}
								}
								else{
									var nodes = $('#tt_menu').tree('getChildren',node.target);
									$.each(nodes,function(index,value){
										$('#tt_menu').tree('uncheck',value.target);
									});
								}
							}
						}
					}"></ul> --%>
					<script type="text/javascript">
						var tree = new Ext.tree.TreePanel({
					        el: 'panel_menu',
					        autoScroll : true,
							margins : '0 0 0 5',
							root : new Ext.tree.AsyncTreeNode({
								text : '<fmt:message key="menu" />',
								draggable : false,
								iconCls : 'node-root',
								id : 'TREE_ROOT_NODE'
							}),
							loader : new Ext.tree.TreeLoader({
								requestMethod : 'GET',
								dataUrl : '${ctx}/${frameworkPath}/role/menu2/${param.role}'
							}),
							listeners : {
								'checkchange' : function(node, checked) {
									if (checked) {
										if (node.parentNode.id != 'TREE_ROOT_NODE') {
											node.bubble(function(n) {
												if (n.getUI().isChecked()) {
													if (!n.parentNode.getUI().isChecked()) {
														n.parentNode.getUI().toggleCheck();
													}
												}
											});
										}
									} else {
										node.eachChild(function(child) {
											child.getUI().toggleCheck(checked);
											child.fireEvent('checkchange', child, checked);
										});
									}
								}
							}
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
			/* var nodes = $('#tt_menu').tree('getChecked');
			var menus = new Array();
			for(var i=0;i<nodes.length;i++){
				menus.push(nodes[i].id);
			} */
			var menus = tree.getChecked('id');
			$.ajax({
				type : 'POST',
				url : '${ctx}/${frameworkPath}/role/menu',
				traditional : true,
				data : {'menus' : menus,role:'${param.role}'},
				success : function(data) {
					if(data.success){
						$.messager.progress('close');
						$('#window_assign_menu').window('close');
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