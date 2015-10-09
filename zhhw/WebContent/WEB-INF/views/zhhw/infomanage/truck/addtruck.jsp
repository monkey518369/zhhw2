+ <%@ page language="java" contentType="text/html; charset=UTF-8"
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
	<div class="formbody">
    		<div class="formtitle"><span>添加车辆信息</span></div>
			<form id="truck_create" method="post">
				<ul class="forminfo">
					<li><fmt:message key="truck.id" />:<i></i><i></i><input  id="id" name="id" type="text"style="width: 170px; height: 30px;"
					 class="easyui-numberbox"data-options="required:true" /><i></i><i></i><i></i>
					 <fmt:message key="truck.plateno" />:<i></i><input name="plate_no" type="text"
						style="width: 170px; height: 30px;" class="easyui-textbox"data-options="required:false" /><i></i><i></i><i></i>
					</li>
					<li>
						<fmt:message key="truck.starttime" />:<i></i><i></i><input
						name="start_date" type="text" style="width: 170px; height: 30px;" class="easyui-datebox"
						data-options="required:false,multiline:true" />
						<fmt:message key="truck.endtime" />:<i></i><input
						name="end_date" type="text" style="width: 170px; height: 30px;" class="easyui-datebox"
						data-options="required:false,multiline:true" /><i></i><i></i><i></i>
					</li>
					<li>
						<fmt:message key="truck.comname" />:<i></i><i></i><i></i><input type="text"style="width: 450px; height: 30px;" class="easyui-combobox"
						 name ="fk_org_id" id="org" data-options="required:true" />
					</li>
					<li><fmt:message key="truck.length" />&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input
						name="truck_length" type="text" style="width: 170px; height: 30px;" class="easyui-numberbox"
						data-options="required:false,multiline:true" /><i></i><i></i><i></i>
						<fmt:message key="truck.width" />&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input
						name="truck_width" type="text" style="width: 170px; height: 30px;" class="easyui-numberbox"
						data-options="required:false,multiline:true" />
					</li>
					<li><fmt:message key="truck.weight" />:<input
						name="truck_weight" type="text" style="width: 170px; height: 30px;" class="easyui-numberbox"
						data-options="required:false,multiline:true" /><i></i>
						<fmt:message key="truck.color" />： <input
						name="color" type="text" style="width: 170px; height: 30px;" class="easyui-numberbox"
						data-options="required:false,multiline:true" /><i></i>
					</li>
					<li><fmt:message key="truck.vin" /> :    <input
						name="vin" type="text" style="width: 170px; height: 30px;" class="easyui-numberbox"
						data-options="required:false,multiline:true" /><i></i>
						<fmt:message key="truck.online" />： <input
						name="truck_width" type="text" style="width: 170px; height: 30px;" class="easyui-numberbox"
						data-options="required:false,multiline:true" /><i></i>
					</li>
					<li><fmt:message key="truck.city" /> :    <input
						name="city" type="text" style="width: 170px; height: 30px;" class="easyui-numberbox"
						data-options="required:false,multiline:true" /><i></i>
						<fmt:message key="truck.province" /> :    <input
						name="province" type="text" style="width: 170px; height: 30px;" class="easyui-numberbox"
						data-options="required:false,multiline:true" /><i></i>
					</li>
					<li>
						<fmt:message key="truck.version" />:<i></i><i></i><input
							name="truck_version" type="text" style="width: 170px; height: 30px;" class="easyui-textbox"
							data-options="required:false,multiline:true" />
						<fmt:message key="truck.device" />:<i></i><i></i><input
							name="fk_device_id" type="text" style="width: 170px; height: 30px;" class="easyui-combobox"
							id="device" data-options="required:false,multiline:true" />
					</li>
					<li><fmt:message key="truck.sim" /> :<input
						name="sim" type="text" style="width: 170px; height: 30px;" class="easyui-textbox"
						data-options="required:false,multiline:true" /><i></i>
						<fmt:message key="truck.remark" /> :    <input
						name="remark" type="text" style="width: 170px; height: 30px;" class="easyui-textbox"
						data-options="required:false,multiline:true" /><i></i>
					</li> 
				</ul>
			</form>
			<div style="text-align: center; padding: 5px">
				<a href="javascript:void(0)" class="easyui-linkbutton" style="width:137px;height:35px; background:url(${ctx}/third-lib/savior/images/btnbg.png) no-repeat; font-size:14px;font-weight:bold;color:#fff; cursor:pointer;"
					onclick="submitForm()">保存数据</a> 
				<a href="javascript:void(0)" style="width:137px;height:35px; background:url(${ctx}/third-lib/savior/images/btnbg.png) no-repeat; font-size:14px;font-weight:bold;color:#fff; cursor:pointer;"
					class="easyui-linkbutton" onclick="clearForm()">清除数据</a>
			</div>
    	</div>
	<script type="text/javascript">
	$('#org').combobox({ 
		url:'${ctx}/combobox/getTruckComnameList',
		valueField:'org_id', 
		textField:'org_name'
	});
	
	$('#device').combobox({ 
		url:'${ctx}/combobox/getTruckDeviceList',
		valueField:'id', 
		textField:'dev_name'
	});
	
	function submitForm() {
		$('#truck_create').ajaxSubmit({
       	 	type: 'post',  
            url: "${ctx}/truckmanage/addTruck" ,  
            success: function(data){
            	if(data.success){
            		$('#window_create').window('close');
            		$("#dg_item").datagrid('reload');  
            		$.messager.alert('<fmt:message key="message.title" />', '<fmt:message key="message.save.successful" />', 'info');
            	}
            },  
            error: function(XmlHttpRequest, textStatus, errorThrown){  
            	$.messager.alert('<fmt:message key="message.title" />','错误：'+XmlHttpRequest.status, 'error');
            }  
       });
	};
	
	function clearForm(){
		$('#truck_create').form('clear');
	}
	</script>
</body>
</html>