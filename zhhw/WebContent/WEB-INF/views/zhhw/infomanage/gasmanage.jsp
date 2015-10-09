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
			<li><a href="#">信息管理</a>
			</li>
			<li><a href="#">加油信息</a>
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
				<li class="click" onClick="selectModule();"><span> 
					<img src="${ctx}/third-lib/savior/images/enable.png" /> </span>查找</li>
			</ul>
		</div>
		<div style="margin-bottom:10px;">
			<div style="display:inline;margin-right:30px;margin-left:10px;">
				<fmt:message key="gas.plateno"/>:
				<input name="fk_car_id" type="text"style="width:200px;height:25px;margin-left:20px;" 
			       	   class="easyui-combobox" id="gas_car"/>
			</div>
			<div style="display:inline;margin-right:30px;margin-left:10px;">
				<fmt:message key="gas.money" />： 
				<input name="money" type="text" style="width: 200px; height: 25px;" class="easyui-textbox"
					   id="gas_money" data-options="required:false,multiline:true" />
			</div>
			<div style="display:inline;margin-right:30px;margin-left:10px;">
				<fmt:message key="gas.price" />： 
				<input name="price" type="text" style="width: 200px; height: 25px;" class="easyui-textbox"
					id="gas_price" data-options="required:false,multiline:true" />
			</div>
			<div style="display:inline;margin-right:30px;margin-left:10px;">
				<fmt:message key="gas.create" />： 
				<input name="createtime" type="text" style="width: 200px; height: 25px;" class="easyui-datebox"
					id="gas_cre" data-options="required:false,multiline:true" />
			</div>
		</div>
		<table id="dg_item" title="加油信息列表" class="easyui-datagrid"
			style="width: 100%;"
			url="${ctx}/gasmanage/getAllGas"
			pagination="true" rownumbers="true" fitColumns="false"
			singleSelect="false">
			<thead>
				<tr>
					<th data-options="field:'ck',checkbox:true"></th>
					<th field="id" width="100"><fmt:message key="gas.id" /></th>
					<th field="plateno" width="100"><fmt:message key="gas.plateno" /></th>
					<th field="fk_car_id" hidden="true"></th>
					<th field="type" width="100"><fmt:message key="gas.type" /></th>
					<th field="volume" width="100"><fmt:message key="gas.volume" /></th>
					<th field="money" width="100"><fmt:message key="gas.money" /></th>
					<th field="price" width="100"><fmt:message key="gas.price" /></th>
					<th field="coordinate" width="100"><fmt:message key="gas.coordinate" /></th>
					<th field="driver_name" width="100"><fmt:message key="gas.driver" /></th>
					<th field="fk_driver_id" hidden="true"></th>
					<th field="user_name" width="100"><fmt:message key="gas.user" /></th>
					<th field="fk_handman" hidden="true"></th>
					<th field="createtime" width="150"><fmt:message key="gas.create" /></th>
				</tr>
			</thead> 
		</table>
	</div>

	<div id="window_create" class="easyui-dialog" title="添加加油信息"
		data-options="modal:true,closed:true,iconCls:'icon-save',maximizable:true,width:700,top:20">

	</div>
	<div id="window_edit" class="easyui-dialog" title="编辑加油信息"
		data-options="modal:true,closed:true,iconCls:'icon-edit',maximizable:true,width:700,top:20">
	</div>
	<script type="text/javascript">
	$('#gas_car').combobox({ 
		url:'${ctx}/combobox/getGasPlateList',
		valueField:'id', 
		textField:'plate_no'
	});
	
	$('#gas_driver').combobox({ 
		url:'${ctx}/combobox/getGasDriverList',
		valueField:'id', 
		textField:'driver_name'
	});
		function createModule(){
			var win = $('#window_create');
			win.window({
				href:'${ctx}/gasmanage/toAddGas'
			});
			win.window('open');
		};
		
		function editModule(){
			var row = $('#dg_item').datagrid('getSelected');
			if(row){
				var win = $('#window_edit');
				win.window({
					href:'${ctx}/infomanage/toUpdateGas',
					onLoad:function(){
						$('#gas_edit').form('load', row);
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
					$.ajax({
						type:'POST',
						url:'${ctx}/gasmanage/delGas',
						traditional:true,
						data:{'gas':JSON.stringify(rows)},
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
		
		function selectModule() {
			$('#dg_item').datagrid('reload',{
				id:$('#gas_id').val(),
				fk_car_id:$("input[name=fk_car_id]").val(),
				fk_driver_id:$('input[name=fk_driverr_id]').val(),
				type:$('#gas_type').val(),
				volume:$('#gas_vol').val(),
				money:$('#gas_money').val(),
				coordinate:$('#gas_coor').val(),
				fk_handman:$('#gas_fkh').val(),
				price:$('#gas_price').val(),
				createtime:$('#gas_cre').val()
			});
		};
	</script>
</body>
</html>