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
  
  <body>
	<div id="layout" class="easyui-layout" style="width:86%;height:560px;">   
       <div data-options="region:'north',split:false,title:'车辆选择'" split="false" collapsible='false' style="height:300px;overflow:auto;">
       		<div style="float:left;height:300px;width:22%;overflow:auto;">
       			<ul id="orgTree"></ul> 
       		</div>
       		<div style="float:left;overflow:auto;height:300px;width:22%;">
       			<ul id="carTree"></ul>
       		</div>
       		<div style="float:left;overflow:auto;width:56%;height:300px">
       			<table id='carChecked' class="easyui-datagrid" style="width:100%;height:300px"   
        			data-options="fitColumns:true,title:'被选中车辆',singleSelect:true,pagination:true">   
	    			<thead>   
		        		<tr>   
				            <th data-options="field:'id',width:400,align:'center'">车辆编码</th> 
				            <th data-options="field:'plate_no',width:400,align:'center'">车牌号</th>   
				            <th data-options="field:'org',width:400,align:'center'">所属机构</th>
		        		</tr>   
	   				 </thead>   
				</table>  
       		</div>
       </div>
       <div data-options="region:'center',title:'调度方式设置'" split="false" style="height:150px;overflow:auto;">
       		<div style="float:left;">
       			<form>
					<fieldset>
						<legend><img src="${ctx }/style/img/formedit.png" style="margin-bottom: -3px;"/>文本下发</legend>
						<br/>
						 <table>
							 <tr>
							 	<td colspan="4">
							 	<input type="radio" name="textMessage" value="urgent">紧急
							 	&nbsp;&nbsp;&nbsp;
							 	<input type="radio" name="textMessage" value="terminalScren">终端显示器显示
							 	&nbsp;&nbsp;&nbsp;
							 	<input type="radio" name="textMessage" value="terminalTTS">终端TTS播读
							 	&nbsp;&nbsp;&nbsp;
							 	<input type="radio" name="textMessage" value="screnShow">广告屏显示
							 	</td>
							 </tr>
							 <tr>
								<th>文本信息：</th>
								<td colspan="3"><input id="message" name="message" class="easyui-textbox" data-options="multiline:true" style="width: 435px;height: 80px;"></td>
							 </tr>
						 </table>
					</fieldset>
				</form>
			</div>
			<div style="float:left; margin-left:100px;">
				<form>
					<fieldset>
						<legend><img src="${ctx }/style/img/formedit.png" style="margin-bottom: -3px;"/>电话回拨</legend>
						<br/>
						 <table>
							 <tr>
							 	<td colspan="4">
							 	<input type="radio" name="ConversationType" value="common">普通通话
							 	&nbsp;&nbsp;&nbsp;
							 	<input type="radio" name="ConversationType" value="monitor">监听
							 	</td>
							 </tr>
							 <tr>
								<th>回拨号码：</th>
								<td>
								<input id="phoneNum" class="easyui-combobox" name="dept" style="width:500px" data-options="valueField:'id',textField:'tel',url:'${ctx}/cardispatch/getAllDriverPhone'" />  
							 	</td>
							 </tr>
						 </table>
					</fieldset>
				</form>
			</div>
       </div>
    </div>
    <br/>
    <div style="margin-left: 500px">
    	<a href="javascript:void(0)" class="easyui-linkbutton" style="width:137px;height:35px; background:url(${ctx}/third-lib/savior/images/btnbg.png) no-repeat; font-size:14px;font-weight:bold;color:#fff; cursor:pointer;"
					onclick="dispatchCar()">下发调度</a> 
    </div>
	<script type="text/javascript" src="${ctx }/js/truckmanager/cardispatch.js"></script>
  </body>
</html>