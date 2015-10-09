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
	
	<style>
		/*选项卡1*/  
		#toolCarDynamic,#toolCarfindInArea{width:300px;margin:0px;padding:0px;margin-bottom:30px; overflow:hidden;}  
		  
		/*菜单class*/  
		.lib_tabborder_sx{border:1px solid #95C9E1;}  
		.lib_Menubox_sx {line-height:28px;position:relative; float:left; width:150px; height:240px;border-right:1px solid #95C9E1;}  
		  
		.lib_Menubox_sx ul{margin:0px;padding:0px;list-style:none; position:absolute; top:15px; left:5px; margin-left:10px; height:25px;text-align:center;}  
		.lib_Menubox_sx li{display:block;cursor:pointer;width:70px;color:#949694;font-weight:bold; margin-bottom:5px;height:25px;line-height:25px; background-color:#E4F2FD}  
		.lib_Menubox_sx li.hover{padding:0px;background:#fff;width:116px;border:1px solid #95C9E1; border-right:0;  
		color:#739242;height:25px;line-height:25px;}  
		.lib_Contentbox_sx{margin-top:0px; border-top:none;padding:10px; border-left:0; margin-left:0px;}   
	</style>
	<%@ include file="/include/jquery.libs.jsp"%>
  </head>

  <body class="easyui-layout"style="width:75%;text-align:left">
  	
  	<!-- 显示组织树 -->
  	<div id="orgWin" class="easyui-window" collapsible='false' closed="true" minimizable='false' maximizable='false' title="选择组织机构" style="width:300px;height:300px;padding:5px;overflow:auto">
  		组织机构：
  		<ul id = "orgTree" class="easyui-tree" data-options="url:'${ctx}/carorg/getOrgJson',checkbox:true"></ul>
  		<ul class="toolbar">
  			<br/><br/>
	  		<li class="click" onClick="getCarByOrgId();"><span><img
							src="${ctx}/third-lib/savior/images/t01.png" /> </span>确定</li>
			<li class="click" onClick="orgHide();"><span><img
							src="${ctx}/third-lib/savior/images/t03.png" /> </span>关闭</li>				
		</ul>
  	</div>
  
  
  	<!-- 车辆动态信息工具栏 -->
	<div id="toolCarDynamic" class="lib_tabborder_sx" style="background-color: #ffffff; position: absolute; left: 100px; top: 50px; z-index: 1000; display: none;">
		<div><a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-back" plain="true" onclick="backCarDynamic();"></a></div>
		<!-- 
		<div class="lib_Menubox_sx ">
			<ul>
				<li id="one1" onclick="setTab('one',1,5)" class="hover">模糊查询</li>
				<li id="one2" onclick="setTab('one',2,5)">高级检索</li>
			</ul>
		</div>
		 -->
		<div class="lib_Contentbox_sx ">
			<div id="con_one_1">
				<input type="radio" name="searchType" checked="checked" onclick="orgHide();">车牌号:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input id="plate_no" class="easyui-validatebox" style="border:1px;border-style:solid"/> <a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="searchByPlateNo('plate_no');"></a><br/>
				<input type="radio" name="searchType" onclick ="orgShow();">选择车辆:<input id="carlist" class="easyui-combobox" name="dept" editable='false'/> <a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="searchByPlateNo('plate_no_fk_org');"></a>
			</div>
			<!-- 			
			<div id="con_one_2" style="display: none"></div>
			<div id="con_one_3" style="display: none"></div> 
			-->
		</div>
	</div>

	<!-- 区域找车工具栏 -->
	<!-- 
	<div id="toolCarfindInArea" class="lib_tabborder_sx" style="background-color: #ffffff; position: absolute; left: 120px; top: 30px; z-index: 1000; display: none;">
		<div class="lib_Menubox_sx ">
			<ul>
				<li id="two1" onclick="setTab('two',1,5)" class="hover"></li>
				<li id="two2" onclick="setTab('two',2,5)"></li>
			</ul>
		</div>
		<div class="lib_Contentbox_sx ">
			<div id="con_two_1"></div>
			<div id="con_two_2" style="display: none"></div>
		</div>
	</div>
	 -->
    <div region="west" collapsible="false" split="false" icon="icon-info" title="管理项" style="width:100px;" class="big-size-icon">
	    <a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-car-dynamic" plain="true" onclick="truckDynamic();"></a>
	    	<br/>&nbsp;&nbsp;&nbsp;&nbsp;车辆动态信息
	    <a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-car-find-in-area" plain="true" onclick="truckWarning();"></a>
	    	<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;车辆报警
	</div>

	<div data-options="region:'center',plain:true,title:'车辆位置信息'" style="overflow: hidden; height: 100%; width: 100%" id="opt_info">
		<div class="easyui-layout" style="width: 100%; height: 87%">
			<div id="mapdata" class="easyui-layout" style="width: 100%; height: 100%">
				<div data-options="region:'center',title:'地图',split:true" id="map" fit="true" border="false" plain="true">
					<div id="cardistributemap" style="width: 100%;"></div>
				</div>
				<div data-options="region:'south',title:'车辆列表',split:false"
					style="height: 40%;">
					
					<table id="truckList" title="数据表格" style="width: 100%;">
						
					</table>														 
				</div>
			</div>
		</div>
	</div>
	
	<!-- 窗口 -->
	<div id="winWarning" class="easyui-window" title="车辆报警"
		style="width: 550px; height:300px" maximizable='false' closed="true" minimizable='false' collapsible='false' data-options="iconCls:'icon-save',modal:true">
		<div class="easyui-layout" data-options="fit:true,border:false">
			<div data-options="region:'center',border:false" title="" style="overflow: hidden;padding: 10px;">	
			<form id="dealWarningForm" method="post">
				<fieldset>
					<legend><img src="${ctx }/style/img/formedit.png" style="margin-bottom: -3px;"/> 车辆报警信息编辑</legend>
					 <input name="id" id="id" value="0" type="hidden"/>
					 <table>
						 <tr>
						    <th>报警信息编号：</th>
							<td><input name="warningId" id="warningId" type="text" class="easyui-textbox" disabled="disabled"/></td>
							<th>车牌号：</th>
							<td><input name="deal_warn_plate_no" id="deal_warn_plate_no" type="text" class="easyui-textbox" disabled="disabled"/></td>
						 </tr>
						 <tr>
						    <th>警报类型：</th>
							<td><input name="type" id="type" name="type" type="text" class="easyui-textbox" disabled="disabled"/></td>
							<th>警报位置</th>
							<td><input name="point" id="point" type="text" type="text" class="easyui-textbox" disabled="disabled"/></td>
						 </tr>
						 <tr>
							<th>处理描述：</th>
							<td colspan="3"><input id="describe" name="describe" class="easyui-textbox" data-options="multiline:true" style="width: 435px;height: 80px;"></td>
						 </tr>
					 </table>
				</fieldset>
				<div style="text-align: center; padding: 5px">
				<a href="javascript:void(0)" class="easyui-linkbutton" style="width:137px;height:35px; background:url(${ctx}/third-lib/savior/images/btnbg.png) no-repeat; font-size:14px;font-weight:bold;color:#fff; cursor:pointer;"
					onclick="submitForm()">保存数据</a> 
				<a href="javascript:void(0)" style="width:137px;height:35px; background:url(${ctx}/third-lib/savior/images/btnbg.png) no-repeat; font-size:14px;font-weight:bold;color:#fff; cursor:pointer;"
					class="easyui-linkbutton" onclick="clearForm()">清除数据</a>
			</div>
			</form>
			</div>
		</div>
	</div>
	<script type="text/javascript" src="${ctx }/js/truckmanager/carmanager.js"></script>
	<script type="text/javascript" src="${ctx }/js/truckmanager/carfindinarea.js"></script>
	<script type="text/javascript" src="${ctx }/js/truckmanager/carwarning.js"></script>
  </body>
</html>