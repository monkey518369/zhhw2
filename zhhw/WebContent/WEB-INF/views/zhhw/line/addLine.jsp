<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/include/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>增加围栏</title>
<%@ include file="/include/jquery.libs.jsp"%>
</head>
<body style="background: #f0f9fd;">
	<div class="formbody">
			<div class="formtitle"><span>添加围栏信息</span></div>
			<form id="line_create" method="post">
				<ul class="forminfo">
					<li><label><fmt:message key="line.line_name" /></label><input name="line_name" type="text"
						style="width: 345px; height: 30px;" class="easyui-textbox"
						data-options="required:true" /><i><font color="red">*</font></i>
					</li>
					<li><label><fmt:message key="line.speed" /></label><input name="speed" type="text"
						style="width: 345px; height: 30px;" class="easyui-numberbox"/>
					</li>
					<li><label><fmt:message key="line.rate_limit" /></label>
						<select id="rate_limit" class="easyui-combobox" name="rate_limit" style="width:345px;height: 30px;"
						data-options="onSelect: function(rec){  
							 
							}">
							<option value="1">限速</option>
							<option value="0">不限速</option>
						</select>
					</li>
					<li><label><fmt:message key="line.speed_time" /></label><input name="speed_time" type="text"
						style="width: 345px; height: 30px;" class="easyui-numberbox"/><i>秒</i>
					</li>
					<li><label><fmt:message key="line.in_alarm_plant" /></label>
						<select id="rate_limit" class="easyui-combobox" name="in_alarm_plant" style="width: 345px; height: 30px;">  
							<option value="1">报警</option>
							<option value="0">不报警</option>
						</select>
					</li>
					<li><label><fmt:message key="line.in_alarm_driver" /></label>
						<select id="rate_limit" class="easyui-combobox" name="in_alarm_driver" style="width: 345px; height: 30px;">  
							<option value="1">报警</option>
							<option value="0">不报警</option>
						</select>
					</li>
					<li><label><fmt:message key="line.out_alarm_plant" /></label>
						<select id="rate_limit" class="easyui-combobox" name="in_alarm_driver" style="width: 345px; height: 30px;">  
							<option value="1">报警</option>
							<option value="0">不报警</option>
						</select>
					</li>
					<li><label><fmt:message key="line.out_alarm_driver" /></label>
						<select id="rate_limit" class="easyui-combobox" name="in_alarm_driver" style="width: 345px; height: 30px;">  
							<option value="1">报警</option>
							<option value="0">不报警</option>
						</select>
					</li>
					<li><label><fmt:message key="line.lose_time" /></label>
						<input class="easyui-datetimebox" name="birthday" data-options="showSeconds:false" style="width: 345px; height: 30px;">
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
	function submitForm() {
		$('#line_create').ajaxSubmit({
			type: 'post',  
			url: "${ctx}/history/addLine" ,  
			success: function(data){
				if(data.success){
					$('#window_create').window('close');
					$("#dg").datagrid('reload');  
					$.messager.alert('<fmt:message key="message.title" />', '<fmt:message key="message.save.successful" />', 'info');
				}
			},  
			error: function(XmlHttpRequest, textStatus, errorThrown){  
				$.messager.alert('<fmt:message key="message.title" />','错误：'+XmlHttpRequest.status, 'error');
			}
		});
	};
	
	function clearForm(){
		$('#line_create').form('clear');
	}
	</script>
</body>
</html>