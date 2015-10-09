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
			<li><a href="#">车辆信息</a>
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
				<fmt:message key="truck.plateno" />：<input type="text" id="truck_pla" 
				style="width: 170px;height:25px;" class="easyui-textbox"/>
			</div>
			<div style="display:inline;margin-right:30px;">
				<fmt:message key="truck.comname" />：<input type="text" id="truck_org" 
				style="width:170px;height:25px;"class="easyui-combobox" name="fk_org_id"/>	
			</div>
			<div style="display:inline;margin-right:30px;">
				<fmt:message key="truck.city" />：<input type="text" style="width: 170px;height:25px;"
				class="easyui-textbox" id="truck_city" data-options="required:false,multiline:true" />
			</div>
			<div style="display:inline;margin-right:30px;">
				<fmt:message key="truck.province" />：<input type="text" style="width: 170px; height:25px;"
				class="easyui-textbox" id="truck_pro" data-options="required:false,multiline:true" />
			</div>
			<div style="display:inline;margin-right:30px;">
				<fmt:message key="truck.sim" />：<input id="truck_sim"  type="text" style="width: 170px; height:25px;"
				class="easyui-textbox" data-options="required:false,multiline:true" />
			</div>
		</div>
		<table id="dg_item" title="车辆信息列表" class="easyui-datagrid"
			style="width:100%"
			url="${ctx}/truckmanage/getAllTruck"
			pagination="true" rownumbers="true" fitColumns="false"
			singleSelect="false">
			<thead>
				<tr>
					<th data-options="field:'ck',checkbox:true"></th>
					<th field="id" width="100"><fmt:message key="truck.id" /></th>
					<th field="province" width="100"><fmt:message key="truck.province" /></th>
					<th field="city" width="100"><fmt:message key="truck.city" /></th>
					<th field="org_name" width="100"><fmt:message key="truck.comname" /></th>
					<th field="fk_org_id" hidden="true"></th>
					<th field="plate_no" width="150"><fmt:message key="truck.plateno" /></th>
					<th field="start_date" width="150"><fmt:message key="truck.starttime" /></th>
					<th field="end_date" width="150"><fmt:message key="truck.endtime" /></th>
					<th field="truck_version" width="100"><fmt:message key="truck.version" /></th>
					<th field="truck_length" width="100"><fmt:message key="truck.length" /></th>
					<th field="truck_width" width="100"><fmt:message key="truck.width" /></th>
					<th field="truck_weight" width="100"><fmt:message key="truck.weight" /></th>
					<th field="color" width="100"><fmt:message key="truck.color" /></th>
					<th field="vin" width="150"><fmt:message key="truck.vin" /></th>
					<th field="online" width="100"><fmt:message key="truck.online" /></th>
					<th field="fk_device_id"  hidden="true">
					<th field="dev_name"  width="100"><fmt:message key="truck.device" /></th>
					<th field="sim" width="150"><fmt:message key="truck.sim" /></th>
					<th field="remark" width="200"><fmt:message key="truck.remark" /></th>
				</tr>
			</thead>
		</table>
	</div>

	<div id="window_create" class="easyui-dialog" title="新建车辆"
		data-options="modal:true,closed:true,iconCls:'icon-save',maximizable:true,width:700,top:20">

	</div>
	<div id="window_edit" class="easyui-dialog" title="编辑车辆"
		data-options="modal:true,closed:true,iconCls:'icon-edit',maximizable:true,width:700,top:20">

	</div>
	<script type="text/javascript">
		function createModule(){
			var win = $('#window_create');
			win.window({
				href:'${ctx}/truckmanage/toAddTruck'
			});
			win.window('open');
		};
		
		function editModule(){
			var row = $('#dg_item').datagrid('getSelected');
			if(row){
				var win = $('#window_edit');
				win.window({
					href:'${ctx}/truckmanage/toUpdateTruck',
					onLoad:function(){
						$('#truck_edit').form('load', row);
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
			console.info(rows);
			if(rows.length<=0){
				$.messager.alert('<fmt:message key="message.title" />', 
						'<fmt:message key="message.select.one.only" />', 'error');
				return;
			}
			$.messager.confirm('<fmt:message key="message.title" />', '是否要删除该信息？', function(r){
				if(r){
					$.ajax({
						type:'POST',
						url:'${ctx}/truckmanage/delTruck',
						traditional:true,
						data:{'trucks':JSON.stringify(rows)},
						success:function(data){
	                		$.messager.alert('<fmt:message key="message.title" />', 
	                				'<fmt:message key="message.delete.successful" />', 'info');
	                		$("#dg_item").datagrid('reload');  
						},
						error: function(XmlHttpRequest, textStatus, errorThrown){  
							$.messager.alert('<fmt:message key="message.title" />','删除错误：'+XmlHttpRequest.status, 'error');  
		                }  
					});
					return false;
				}
			});
		};
		
		$('#truck_org').combobox({ 
			url:'${ctx}/combobox/getTruckComnameList',
			valueField:'org_id', 
			textField:'org_name'
		});
		
		$('#truck_device').combobox({ 
			url:'${ctx}/combobox/getTruckDeviceList',
			valueField:'id', 
			textField:'dev_name'
		});
		function selectModule(){
			$('#dg_item').datagrid('reload',{
				id:$('#truck_id').val(),
				city:$('#truck_city').val(),
				province:$('#truck_pro').val(),
				vin:$('#truck_vin').val(),
				fk_org_id:$("input[name=fk_org_id]").val(),
				plate_no:$('#truck_pla').val(),
				start_data:$('#truck_st').val(),
				end_date:$('#truck_ed').val(),
				truck_version:$('#truck_ver').val(),
				truck_length:$('#truck_len').val(),
				truck_width:$('#truck_wid').val(),
			 	truck_weight:$('#truck_wei').val(),
				remark:$('#truck_rem').val(),
				color:$('#truck_col').val(),
				online:$('#truck_onl').val(),
				sim:$('#truck_sim').val(),
				fk_device_id:$("input[name=fk_device_id]").val()
			 })
		}
	</script>
</body>
</html>