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
	<div class="formbody">
    		<div class="formtitle"><span>添加加油信息</span></div>
    			<form id="device_edit" method="post">
				<ul class="forminfo">
					<li><label><fmt:message key="device.id" /></label><input name="id" type="text"
						style="width: 345px; height: 30px;" " class="easyui-numberbox"
						data-options="required:true" /><i>主键</i>
					</li>
					<li><label><fmt:message key="device.name" />:</label><input name="dev_name" type="text"
						style="width: 345px; height: 30px;" " class="easyui-textbox"
						data-options="required:true" /><i>外键</i>
					</li>
					<li><label><fmt:message key="device.version" />:</label><input name="version" type="text"
						style="width: 345px; height: 30px;" " class="easyui-textbox"
						data-options="required:false" /><i>例:汽油-o21</i>
					</li>
					<li><label><fmt:message key="device.manufacturer" />：</label> <input
					name="manufacturer" type="text" style="width: 345px; height: 30px;" class="easyui-textbox"
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
	function submitForm() {
		$('#device_edit').ajaxSubmit({
       	 	type: 'post',  
            url: "${ctx}/devicemanage/updDevice" ,  
            success: function(data){
            	if(data.success){
            		$('#window_edit').window('close');
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
		$('#device_edit').form('clear');
	}
	</script>
</body>
</html>