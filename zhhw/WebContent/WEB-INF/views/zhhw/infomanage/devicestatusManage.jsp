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
			<li><a href="#">作业状态监控</a>
			</li>
		</ul>
	</div>
	<div class="rightinfo">
		<div class="tools">
			<ul class="toolbar">
				<li class="click" onClick="selectModule();"><span> 
					<img src="${ctx}/third-lib/savior/images/enable.png" /> </span>查找</li>
			</ul>
		</div>
		<div>
			<fmt:message key="deviceStatus.dev_id" /><input id="device_id" type="text"
					style="width: 200px; height: 30px;" class="easyui-textbox"
					data-options="required:false" />
		</div>
		<table id="dg_item" title="作业状态信息列表" class="easyui-datagrid"
			style="width: 100%;"
			url="${ctx}/devicemanage/checkDeviceStatus"
			pagination="true" rownumbers="true" fitColumns="false"
			singleSelect="false">
			<thead>
				<tr>
					<th data-options="field:'ck',checkbox:false"></th>
					<th field="dev_id" width="200"><fmt:message key="deviceStatus.dev_id" /></th>
					<th field="gpsstatus" width="200"><fmt:message key="deviceStatus.gpsstatus" /></th>
					<th field="gasstatus" width="200"><fmt:message key="deviceStatus.gasstatus" /></th>
					<th field="garbagestatus" width="200"><fmt:message key="deviceStatus.garbagestatus" /></th>
					<th field="speedstatus" width="200"><fmt:message key="deviceStatus.speedstatus" /></th>
					<th field="camerastatus" width="200"><fmt:message key="deviceStatus.camerastatus" /></th>
				</tr>
			</thead>
		</table>
	</div>

	<script type="text/javascript">
		
		 function selectModule() {
             $('#dg_item').datagrid('reload',{
            	 dev_id:$("#device_id").val()
            });
         };
	</script>
</body>
</html>