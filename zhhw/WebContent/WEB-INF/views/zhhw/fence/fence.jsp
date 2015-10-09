<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<%@ include file="/include/jquery.libs.jsp"%>
	<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&&ak=tjrBmampSfkzl4OVU6b6YGQh"></script>
	<!--加载鼠标绘制工具-->
	<script type="text/javascript" src="http://api.map.baidu.com/library/DrawingManager/1.4/src/DrawingManager_min.js"></script>
	<link rel="stylesheet" href="http://api.map.baidu.com/library/DrawingManager/1.4/src/DrawingManager_min.css" />
	<!--加载检索信息窗口-->
	<script type="text/javascript" src="http://api.map.baidu.com/library/SearchInfoWindow/1.4/src/SearchInfoWindow_min.js"></script>
	<!--加载BMapLib.GeoUtils类，用于判断当前坐标点是否在多边形内-->
	<script type="text/javascript" src="http://api.map.baidu.com/library/GeoUtils/1.2/src/GeoUtils.js"></script>
	<link rel="stylesheet" href="http://api.map.baidu.com/library/SearchInfoWindow/1.4/src/SearchInfoWindow_min.css" />
	<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/history/fence.js"></script>
		
</head>
<body style="padding: 0px;" onkeydown="keyDelete()">
	<div class="easyui-layout" style="width: 80%; height: 80%;">
		<div id="allmap" data-options="region:'center',title:'报警区域管理',iconCls:'icon-ok'" style="width: 100%; height: 100%; float: right; display: inline;">
		</div>
		<div data-options="region:'south',split:true" title="电子围栏管理" style="height: 230px;">
				<table id="dg" class="easyui-datagrid"
					data-options="region:'south',onClickRow:onClickRow,iconCls:'icon-save',toolbar: '#tb',fit: true,
			 				loadMsg:'正在努力加载，请稍后...',rownumbers:true,singleSelect:true,pagination:true">
					<thead>
						<tr>
							<th data-options="field:'id',align:'center',hidden:true">
								ID
							</th>
							<th
								data-options="field:'fence_name',align:'center'">
								围栏名称
							</th>

							<th
								data-options="field:'speed',align:'center'">
								速度
							</th>
							<th
								data-options="field:'speed_time',align:'center'">
								超速时间
							</th>
							<th
								data-options="field:'rate_limit',align:'center'">
								限速
							</th>
							<th
								data-options="field:'in_alarm_plant',align:'center'">
								进入终端报警
							</th>
							<th
								data-options="field:'in_alarm_driver',align:'center'">
								进入平台报警
							</th>
							<th
								data-options="field:'out_alarm_driver',align:'center'">
								离开终端报警
							</th>
							<th
								data-options="field:'out_alarm_plant',align:'center'">
								离开平台报警
							</th>
							<th
								data-options="field:'create_time',align:'center'">
								创建时间
							</th>
							<th
								data-options="field:'fk_creater_id',align:'center'">
								创始人
							</th>
							<th
								data-options="field:'lose_time',align:'center'">
								失效时间
							</th>
							<th
								data-options="field:'fk_tenant_id',align:'center',hidden:true">
								企业代码
							</th>
						</tr>
					</thead>
				</table>
				<div id="tb" style="height: auto">
					<a href="javascript:void(0)" class="easyui-linkbutton"
						data-options="iconCls:'icon-add',plain:true" onclick="append()">增加</a>
					<a href="javascript:void(0)" class="easyui-linkbutton"
						data-options="iconCls:'icon-remove',plain:true" onclick="removeit()">删除</a>
					<a href="javascript:void(0)" class="easyui-linkbutton"
						data-options="iconCls:'icon-save',plain:true" onclick="editModule()">修改</a>
					<a href="javascript:void(0)" class="easyui-linkbutton"
						data-options="iconCls:'icon-tip',plain:true" onclick="$('#tip').dialog('open');">操作提示</a>
				</div>
				<div id="tip" class="easyui-dialog" title="操作说明"
					data-options="modal:true, iconCls:'icon-save',closed: true"
					style="width: 800px; height: 300px; padding: 10px">
					<h2>操作步骤：<h2>
					<h1>一、添加围栏： </h1>
					<p style="text-indent: 2em">点击电子围栏管理中的“添加”按钮，会出现一条新且是空的围栏信息。 将围栏信息填写完整之后，点击保存。</p>
					<p style="text-indent: 2em">保存完毕之后才能在画图上进行围栏设计，根据不同地区，选择不同形状的图案工具，如;想设计圆形，就选择画圆按钮；想设计方形，就选择画矩形按钮；如果要设计围栏的形状是个不规则图形，可以选择画多边形按钮；拖动地图则选择那个小手图案的拖动地图按钮。</p>
					<p style="text-indent: 2em">1圆形，在选择“圆形”按钮之后，鼠标光标会变成个小十字，鼠标左键点击你想设计围栏的区域中心位置，不松开左键往外拖动到设计围栏的边缘，松开鼠标左键即可自动保存。</p>
					<p style="text-indent: 2em">2矩形，在选择“矩形”按钮之后，鼠标光标会变成个小十字，鼠标左键点击你想设计围栏的区域任意一个角，不松开左键往外拖动到设计围栏对面角，松开鼠标左键即可自动保存。</p>
					<p style="text-indent: 2em">3多边形，在选择“多边形”按钮之后，鼠标光标会变成个小十字，鼠标左键点击一下你想设计围栏的区域一个边缘点，松开鼠标左键沿着你设计围栏的边缘线拖动鼠标，需要改变方向的时候可以点击一下鼠标左键后松开，然后改变方向拖动鼠标，依次类推直到画完设计围栏最后一个点，然后双击鼠标左键即可完成保存。</p>
					<p style="text-indent: 2em">4 拖动地图
						在选择“拖动地图”按钮之后，鼠标在地图上变成一只小手，按住鼠标左键不放，可以移动鼠标来拖动地图直到到达你想要设计围栏的位置。
						注意事项：在地图上画围栏设计前，一定要先保存新添加围栏，或者是选择已经保存的围栏。
						如果选择已经设计过围栏的信息，再进行围栏设计，将会自动取消以前围栏设计图案。
					</p>
					<h1> 二、删除围栏：</h1>
					<p style="text-indent: 2em">选择你想删除的围栏条目，点击“删除”后会有确认提示，点击“确认”按钮即能删除该围栏，点击“取消”按钮将不删除围栏，返回围栏设计。</p>
				</div>
		</div>
	</div>
	<div id="window_create" class="easyui-dialog" title="添加围栏信息"
		data-options="modal:true,closed:true,iconCls:'icon-save',maximizable:true,width:700,top:20">

	</div>
	<div id="window_edit" class="easyui-dialog" title="编辑围栏信息"
		data-options="modal:true,closed:true,iconCls:'icon-edit',maximizable:true,width:700,top:20">

	</div>
	<script type="text/javascript">
	/*点击修改按钮响应函数，修改围栏属性*/
	function editModule(){
		var row = $('#dg').datagrid('getSelected');
		if(row){
			var win = $('#window_edit');
			win.window({
				href:'${ctx}/history/toUdpFence',
				onLoad:function(){
					$('#fence_update').form('load', row);
				}
			});
			win.window('open');
			return false;
		}
		else{
			$.messager.alert('<fmt:message key="message.title" />', 
					'<fmt:message key="message.select.one.only" />', 'error');
			return;
		}
	}
	</script>
</body>
</html>