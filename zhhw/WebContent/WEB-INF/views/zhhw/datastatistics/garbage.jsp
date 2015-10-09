<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="/include/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>垃圾统计</title>
<link rel="stylesheet" type="text/css" href="../js/datastatistics/garbage.css">
<%@ include file="/include/jquery.libs.jsp"%>
<script type="text/javascript" src="../js/highchart/highcharts.js"></script>
<script type="text/javascript" src="../js/datastatistics/garbage.js"></script>
</head>
<body class="easyui-layout">
<div data-options="region:'north',split:false" class="garbage_north">
	<div class="place">
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="${ctx}/center">首页</a></li>
			<li><a href="javascript:void(0)">统计报表</a></li>
			<li><a href="javascript:void(0)">垃圾统计</a></li>
		</ul>
	</div>
</div>
<div data-options="region:'west',split:true,title:'选项'" class="garbage_west">
	<div class="west_top" data-options="region:'north'">
		<!-- <div class="datastatistics_type">
			<input id="radio_org_time" type="radio" name="garbage_type" value="group_time"/>组织统计
		</div> -->
		<div class="datastatistics_type">
			<input id="radio_org" type="radio" name="garbage_type" value="group"/>组织统计
		</div>
		<div class="datastatistics_type">
			<input id="radio_car" type="radio" name="garbage_type" value="car"/>多车对比
		</div>
		<div class="datastatistics_type">
			<input id="radio_car_time" type="radio" name="garbage_type" value="car_time"/>单车统计
		</div>
	</div>
	<div class="west_mid" data-options="region:'center'">
		<div>
			<input id="search_org" class="mid_search" name="search_org">
		</div>
		<div>
			<input id="search_plat" class="mid_search" name="search_plat">
		</div>
	</div>
	<div id="west_bot" class="west_bot" data-options="region:'south'">
       	<div data-options="region:'center',border:false" style="max-height:300px;">
			<ul id="selected_org" class="checked_org" ></ul>
		</div>
	</div>
</div>

<div data-options="region:'center',split:true" class="garbage_center">
	<div class="center_top">
		<label for="center_starttime">开始时间:</label></label>
		<input id="center_starttime" class="easyui-datebox center_starttime">
		<label for="center_endtime">结束时间:</label>
		<input id="center_endtime" class="easyui-datebox center_endtime">
		<label for="search_time">时间段:</label>
		<select id="search_time" name="search_time" class="easyui-combobox" style="width:60px;">
			<option value="年" style="cursor:pointer;">年</option>
			<option value="月" style="cursor:pointer;">月</option>
			<option value="日" style="cursor:pointer;">日</option>
		</select>
        <!-- <label for="show_style">展示样式</label>
        <select id="search_time" name="search_time" class="easyui-combobox">
			<option value="柱状图" style="cursor:pointer;">柱状图</option>
			<option value="饼状图" style="cursor:pointer;">饼状图</option>
			<option value="折线图" style="cursor:pointer;">折线图</option>
		</select> -->
		
		<a id="top_search_btn" href="javascript:void(0)" class="easyui-linkbutton top_search_btn">查询</a>
	</div>
	<div class="easyui-panel center_content" title="图表展示">
		<div id="container" style="max-width:900px;min-height:400px"></div>
	</div>
</div>
<!-- dialog -->
<div id="org_window_org" class="easyui-window" title="组织树" left="250px" style="width:300px;height:400px"
			data-options="modal:true,closed:true">
		    <div class="easyui-panel" title="菜单" data-options="tools: [{    
		    iconCls:'icon-cancel',handler:cancelorg},{iconCls:'icon-save', handler:saveorg}]" style="height:99%;">
		    	<ul id="org_tree_org"></ul>						
		    </div>	
</div>
<div id="org_window_org_time" class="easyui-window" title="组织树" left="250px" style="width:300px;height:400px"
			data-options="modal:true,closed:true">
		    <div class="easyui-panel" title="菜单" data-options="tools: [{iconCls:'icon-save',    
		    handler:saveorgtime}]" style="height:99%;">
		    	<ul id="org_tree_org_time"></ul>					
		    </div>			
</div>
<div id="org_window_car" class="easyui-window" title="组织树" left="250px" style="width:300px;height:400px"
			data-options="modal:true,closed:true,iconCls:'icon-save'">
		    	<ul id="org_tree_car"></ul>					
</div>
<div id="car_window" class="easyui-window" title="组织树" left="600px" style="width:300px;height:400px"
			data-options="modal:true,closed:true">
		    <div class="easyui-panel" title="菜单" data-options="tools: [{    
		    iconCls:'icon-cancel',handler:cancelcar},{iconCls:'icon-save',handler:savecar}]" style="height:99%;">
		    	<ul id="car_tree" ></ul>					
		    </div>
					
</div>
<!-- 右键菜单 -->
<div id="selected_org_menu" class="easyui-menu" style="width:120px;">
	<div onclick="remove_selected_org_menu()" data-options="iconCls:'icon-remove'">移除</div>
</div>

</body>
</html>