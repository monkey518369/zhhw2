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
    		<form id="hitch_create" method="post">
				<ul class="forminfo">
					<li><label><fmt:message key="hitch.id" /></label><input name="id" type="text"
						style="width: 345px; height: 30px;" " class="easyui-textbox"
						data-options="required:true" /><i>主键</i>
					</li>
					<li><label><fmt:message key="hitch.plateno" />:</label><input name="fk_truck_id" type="text"
						style="width: 345px; height: 30px;" " class="easyui-textbox"
						id="car" data-options="required:true" /><i>外键</i>
					</li>
					<li><label><fmt:message key="hitch.describe" />:</label><input name="describe" type="text"
						style="width: 345px; height: 30px;" " class="easyui-textbox"
						data-options="required:false" /><i>例:汽油-o21</i>
					</li>
					<li><label><fmt:message key="hitch.lng" />：</label> <input
					name="lng" type="text" style="width: 345px; height: 30px;" class="easyui-textbox"
					data-options="required:false,multiline:true" /><i></i>
					</li>
					<li><label><fmt:message key="hitch.lat" />：</label> <input
					name="lat" type="text" style="width: 345px; height: 30px;" class="easyui-textbox"
					data-options="required:false,multiline:true" /><i>加油所花费的金额</i>
					</li>
					<li><label><fmt:message key="hitch.createtime" />：</label> <input
					name="create_time" type="text" style="width: 345px; height: 30px;" class="easyui-datebox"
					data-options="required:false,multiline:true" /><i>例:E128 S23</i>
					</li>
					<li><label><fmt:message key="hitch.user" />：</label> <input
					name="user_id" type="text" style="width: 345px; height: 30px;" class="easyui-textbox"
					data-options="required:false,multiline:true" /><i>例:E128 S23</i>
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
	$('#car').combobox({ 
		url:'${ctx}/combobox/getGasPlateList',
		valueField:'id', 
		textField:'plate_no'
	});
	function submitForm() {
		$('#hitch_create').ajaxSubmit({
       	 	type: 'post',  
            url: "${ctx}/hitchmanage/addHitch" ,  
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
		$('#hitch_create').form('clear');
	}
	</script>
</body>
</html>