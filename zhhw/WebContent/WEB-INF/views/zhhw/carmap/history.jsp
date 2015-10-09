<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
<script type="text/javascript"
	src="http://api.map.baidu.com/api?v=2.0&ak=tjrBmampSfkzl4OVU6b6YGQh"></script>
<%@ include file="/include/jquery.libs.jsp"%>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/static/js/history/lushu.js"></script>
<style type="text/css">
body, html, #allmap {
	width: 100%;
	height: 100%;
	overflow: hidden;
	margin: 0;
}

.style {
	width: 66px;
	line-height: 34px;
	display: block;
	float: left;
}
.buttonstyle{
margin-right: 4px;
margin-top: 4px;
margin-left: 0px;"
margin-bottom: 2px;"
}
</style>
</head>
<body class="easyui-layout" style="width: 100%; height: 100%;">
	<div data-options="region:'west',split:true" title="监控车辆"
		style="width: 250px;">
		<div class="easyui-panel" style="padding: 5px;">
			<a href="#" class="easyui-linkbutton buttonstyle"
				data-options="iconCls:'icon-search'" onclick="orgShow()">选择车辆</a>
			<div>
				<ul id="carlist" class="easyui-tree"
					style="height: 200px; border: 2px solid"
					data-options="iconCls:'icon-show'"></ul>
			</div>
			<div>
				<label class="style">开始时间 </label>
				<input id="starttime"
					class="easyui-datetimebox" value="new Date().toLocaleDateString()"
					style="width: 170px">
			</div>
			<div>
			<label class="style">结束时间 </label> <input
					id="endtime" class="easyui-datetimebox" value="now()"
					style="width: 170px"> <input id="ss"
					class="easyui-numberspinner" value="4000"
					data-options="min:10,max:5000,required:true" style="width: 80px;"></input>
				<a href="#" class="easyui-linkbutton buttonstyle" 
					data-options="iconCls:'icon-speed'" onclick="setSpeed()">设置速度(m/h)</a>
				<a href="#" class="easyui-linkbutton buttonstyle"
					data-options="iconCls:'icon-line'" onclick="listLine()">生成历史轨迹</a>
			</div>
			<div>
				<a href="#" class="easyui-linkbutton buttonstyle"
					data-options="iconCls:'icon-start'" onclick="runLine()">运行</a> <a
					href="#" class="easyui-linkbutton buttonstyle"
					data-options="iconCls:'icon-stop'" onclick="stopLine()">停止</a> <a
					href="#" class="easyui-linkbutton buttonstyle"
					data-options="iconCls:'icon-pause'" onclick="pauseLine()">暂停</a>
			</div>
			<div>
				<a href="#" class="easyui-linkbutton buttonstyle"
					data-options="iconCls:'icon-hide'" onclick="hideMessage()">隐藏车牌</a>
				<a href="#" class="easyui-linkbutton buttonstyle"
					data-options="iconCls:'icon-show'" onclick="showMessage()">显示车牌</a>
			</div>
		</div>
	</div>
	<div id="allmap"
		data-options="region:'center',title:'轨迹回放',iconCls:'icon-ok'"></div>
	<div id="orgWin" class="easyui-window" collapsible='false'
		closed="true" minimizable='false' maximizable='false' title="选择组织机构"
		style="width: 300px; height: 500px; padding: 5px;">
		组织机构：
		<ul id="orgTree" class="easyui-tree"
			data-options="url:'${ctx}/carorg/getOrgJson',checkbox:true"></ul>
		<a href="#" class="easyui-linkbutton buttonstyle"
			data-options="iconCls:'icon-save'" onclick="getCarByOrgId()">确定</a> <a
			href="#" class="easyui-linkbutton buttonstyle"
			data-options="iconCls:'icon-remove'" onclick="orgHide()">关闭</a>

	</div>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/static/js/history/history.js"></script>
</body>
</html>
