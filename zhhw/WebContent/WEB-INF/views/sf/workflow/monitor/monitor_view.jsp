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
	<div data-options="region:'center',split:true" style="width: 100%;height:100%">
		<iframe src="${ctx}/${frameworkPath}/monitor/viewTag?processInstanceId=${param.processInstanceId}" scrolling="yes" frameborder="0" style="width:100%;height:100%;"></iframe>
	</div>
</body>
</html>