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
	<div data-options="region:'north',split:false" style="height:42px">
		<div class="place">
			<span>位置：</span>
			<ul class="placeul">
				<li><a href="${ctx}/center">首页</a>
				</li>
				<li><a href="#">系统监控</a>
				</li>
				<li><a href="#">数据监控</a>
				</li>
			</ul>
		</div>
	</div>
	<div id="panel_monitoring_data" data-options="region:'center'">
		<script type="text/javascript">
			$(function(){
				var panel = $('#panel_monitoring_data');
				var content = '<iframe scrolling="yes" frameborder="0"  src="druid" style="width:100%;height:100%;"></iframe>'; 
				panel.panel({
					content:content
				});
			});
		</script>
	</div>
</body>
</html>