<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/include/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>报警设置</title>
<%@ include file="/include/jquery.libs.jsp"%>
<script type="text/javascript">
$(function (){
	$("#set_tree").tree({
		url:'../carorg/getOrgJson',
		method:'get',
		animate:true,
		onClick:function(node){
			$('#org_car').datagrid('reload',{
				orgId: node.id,
			});


		}
	})
});
</script>
</head> 
<body style="background: #f0f9fd;" class="easyui-layout">
	<div data-options="region:'north',split:false" style="height:42px">
		<div class="place">
			<span>位置：</span>
			<ul class="placeul">
				<li><a href="${ctx}/center">首页</a>
				</li>
				<li><a href="#">车辆管理</a>
				</li>
				<li><a href="#">报警设置</a>
				</li>
			</ul>
		</div>
	</div>
	<div data-options="region:'west',split:true,iconCls:'menu-node-org'" title="组织机构树"
		style="width: 180px;min-height:450px;">
		<ul id="set_tree" class="easyui-tree"></ul>
	</div>
	<div data-options="region:'center'">
		<div class="rightinfo">
			<div class="tools">
				<ul class="toolbar">
					<li class="click" onClick="setSpeed();"><span><img
							src="${ctx}/third-lib/savior/images/t01.png" /> </span>超速设置</li>
					<li class="click" onClick="setAlarm();"><span><img
							src="${ctx}/third-lib/savior/images/t01.png" /> </span>报警设置</li>
					<li class="click" onClick="setJobTime();"><span> <img
							src="${ctx}/third-lib/savior/images/t01.png" /> </span>作业时间设置</li>
				</ul>
			</div>
			<table id="org_car" title="车辆信息列表" class="easyui-datagrid"
			style="width:100%"
			url="${ctx}/setcar/getcarbyorgid"
			pagination="true" rownumbers="true" fitColumns="false"
			singleSelect="false">
			<thead>
				<tr>
					<th data-options="field:'ck',checkbox:true"></th>
					<th field="id" width="100"><fmt:message key="truck.id" /></th>
					<th field="province" width="100"><fmt:message key="truck.province" /></th>
					<th field="city" width="100"><fmt:message key="truck.city" /></th>
					<th field="org_name" width="100"><fmt:message key="truck.comname" /></th>
					<th field="plate_no" width="150"><fmt:message key="truck.plateno" /></th>
					<th field="online" width="100"><fmt:message key="truck.online" /></th>
					<th field="dev_name"  width="100"><fmt:message key="truck.device" /></th>
					<th field="sim" width="150"><fmt:message key="truck.sim" /></th>
				</tr>
			</thead>
		</table>
		</div>
	</div>

	<div id="window_speed" class="easyui-dialog" title="超速设置"
		data-options="modal:true,closed:true,iconCls:'icon-add',maximizable:true,width:700,top:20,height:400">
		<div class="formtitle"><span>添加超速信息</span></div>
		<div style="text-align:center;margin-top:30px;">
			<label for="speed">最大速度</label>
			<input type="text" id="speed" class="easyui-numberbox" data-options="min:0,prompt:'千米每小时'"
				   name="speed">
			<label for="time">持续时间</label>
			<input type="text" id="time" class="easyui-numberbox" data-options="min:0,prompt:'秒'"
				   name="time">
		</div>
		<div style="text-align:center;padding: 5px;margin-top:30px;">
			<a href="javascript:void(0)" class="easyui-linkbutton" style="width:137px;height:35px; background:url(${ctx}/third-lib/savior/images/btnbg.png) no-repeat; font-size:14px;font-weight:bold;color:#fff; cursor:pointer;"
				onclick="submitSpeed()">保存数据</a> 
			<a href="javascript:void(0)" style="width:137px;height:35px; background:url(${ctx}/third-lib/savior/images/btnbg.png) no-repeat; font-size:14px;font-weight:bold;color:#fff; cursor:pointer;"
				class="easyui-linkbutton" onclick="clearForm()">清除数据</a>
		</div>
	</div>
	<div id="window_alarm" class="easyui-dialog" title="报警设置"
		data-options="modal:true,closed:true,iconCls:'icon-add',maximizable:true,width:700,top:20,height:400">
		<div class="formtitle"><span>添加报警设置</span></div>
		<div style="text-align:center;margin-top:30px;">
			<label for="alarm">报警间隔</label>
			<input type="text" id="alarm" class="easyui-numberbox" data-options="min:0,prompt:'秒'"
				   name="alarm">
		</div>
		<div style="text-align:center;padding: 5px;margin-top:30px;">
			<a href="javascript:void(0)" class="easyui-linkbutton" style="width:137px;height:35px; background:url(${ctx}/third-lib/savior/images/btnbg.png) no-repeat; font-size:14px;font-weight:bold;color:#fff; cursor:pointer;"
				onclick="submitAlarm()">保存数据</a> 
			<a href="javascript:void(0)" style="width:137px;height:35px; background:url(${ctx}/third-lib/savior/images/btnbg.png) no-repeat; font-size:14px;font-weight:bold;color:#fff; cursor:pointer;"
				class="easyui-linkbutton" onclick="clearAlarm()">清除数据</a>
		</div>
	</div>
	<div id="window_jobTime" class="easyui-dialog" title="报警设置"
		data-options="modal:true,closed:true,iconCls:'icon-add',maximizable:true,width:700,top:20,height:400">
		<div class="formtitle"><span>最长作业时间设置</span></div>
		<div style="text-align:center;margin-top:30px;">
			<label for="jobTime">最长作业时间</label>
			<input type="text" id="jobTime" class="easyui-numberbox" data-options="min:0,prompt:'秒'"
				   name="jobTime">
		</div>
		<div style="text-align:center;padding: 5px;margin-top:30px;">
			<a href="javascript:void(0)" class="easyui-linkbutton" style="width:137px;height:35px; background:url(${ctx}/third-lib/savior/images/btnbg.png) no-repeat; font-size:14px;font-weight:bold;color:#fff; cursor:pointer;"
				onclick="submitJobTime()">保存数据</a> 
			<a href="javascript:void(0)" style="width:137px;height:35px; background:url(${ctx}/third-lib/savior/images/btnbg.png) no-repeat; font-size:14px;font-weight:bold;color:#fff; cursor:pointer;"
				class="easyui-linkbutton" onclick="clearJobTime()">清除数据</a>
		</div>
	</div>

<script type="text/javascript">
	function setSpeed() {
		var sims = [];
		var cks = $("input[name=ck]:checked").each(function(){
			sims.push($(this).parents("tr").find(".datagrid-cell-c1-sim").html())
		})
		
		if(sims.length==0){
			alert("请选择车辆");
			return
		}
		
		$('#window_speed').window('open');
	};
	
	
	
	function setJobTime() {
		var sims = [];
		var cks = $("input[name=ck]:checked").each(function(){
			sims.push($(this).parents("tr").find(".datagrid-cell-c1-sim").html())
		})
		
		if(sims.length==0){
			alert("请选择车辆");
			return
		}
		
		$('#window_jobTime').window('open');
	};
	function setAlarm() {
		var sims = [];
		var cks = $("input[name=ck]:checked").each(function(){
			sims.push($(this).parents("tr").find(".datagrid-cell-c1-sim").html())
		})
		
		if(sims.length==0){
			alert("请选择车辆");
			return
		}
		
		$('#window_alarm').window('open');
	};
	
	
	function submitSpeed(){
		var sims = [];
		var cks = $("input[name=ck]:checked").each(function(){
			sims.push($(this).parents("tr").find(".datagrid-cell-c1-sim").html())
		})
		var speed = $("#speed").val();
		var time = $("#time").val();
		if(speed==null||speed==""||time==null||time==""){
			alert("请按要求填写速度和时间");
			return;
		}
		$.each(sims,function(i,item){
			var url = '../setcar/setspeed';
			var win = "window_speed";
			ajaxSent(url,win,"speed",item,speed,time)
		})

	}
	
	function submitJobTime(){
		var sims = [];
		var cks = $("input[name=ck]:checked").each(function(){
			sims.push($(this).parents("tr").find(".datagrid-cell-c1-sim").html())
		})
		var jobTime = $("#jobTime").val();
		if(jobTime==null||jobTime==""){
			alert("请按要求填写作业时间");
			return;
		}
		$.each(sims,function(i,item){
			var url = '../setcar/setspeed';
			var win = "window_jobTime";
			ajaxSent(url,win,"jobTime",item,jobTime)
		})

	}
	function submitAlarm(){
		var sims = [];
		var cks = $("input[name=ck]:checked").each(function(){
			sims.push($(this).parents("tr").find(".datagrid-cell-c1-sim").html())
		})
		var alarm = $("#alarm").val();
		if(alarm==null||alarm==""){
			alert("请按要求填写报警间隔");
			return;
		}
		$.each(sims,function(i,item){
			var url = '../setcar/setspeed';
			var win = "window_alarm";
			ajaxSent(url,win,"time",item,time)
		})
	}
	function ajaxSent(url,win,type,item,param1,param2){
		$.ajax({
			type:"GET",
			url:url,
			data:{
				type:type,
				item:item,
				param1:param1,
				param2:param2
			},
			success:function(data){
				$('#'+win).window('close');
				alert(data.result);
				
			}
		}) 
	}
	function clearSpeed(){
		
	}
</script>
</body>
</html>