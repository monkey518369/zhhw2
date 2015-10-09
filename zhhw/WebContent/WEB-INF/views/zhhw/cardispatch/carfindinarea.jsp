<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
	<title>车辆地图动态信息</title> 
	<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=tjrBmampSfkzl4OVU6b6YGQh"></script>
	<script type="text/javascript" src="http://api.map.baidu.com/library/GeoUtils/1.2/src/GeoUtils_min.js"></script>
	<script type="text/javascript" src="http://api.map.baidu.com/library/DrawingManager/1.4/src/DrawingManager_min.js"></script>
	<link rel="stylesheet" href="http://api.map.baidu.com/library/DrawingManager/1.4/src/DrawingManager_min.css" />
	<!--加载检索信息窗口-->
	<script type="text/javascript" src="http://api.map.baidu.com/library/SearchInfoWindow/1.4/src/SearchInfoWindow_min.js"></script>
	<link rel="stylesheet" href="http://api.map.baidu.com/library/SearchInfoWindow/1.4/src/SearchInfoWindow_min.css" />
	<%@ include file="/include/jquery.libs.jsp"%>
  </head>

  <body class="easyui-layout" style="text-align:left">
	
    <div data-options="region:'center',plain:true,title:'车辆位置信息'" style="overflow: hidden;" id="opt_info">
        <div id="map" fit="true" border="false" plain="true">
        	<div id="cardistributemap" style="width:100%;"></div>
        </div>
	</div>
	
	<script type="text/javascript" src="${ctx }/js/cardispatch/carfindinarea.js"></script>
  </body>
</html>