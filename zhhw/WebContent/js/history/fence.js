// 地图
var map;
var currentFenceid;
$(function() {
	// 默认加载表格
	initPage();	
	initGrid();
	initPagerRefresh();
});
/**
 * 设计围栏分组情况
 * @param {Object} value
 * @param {Object} row
 * @param {Object} index
 * @return {TypeName} 
 */

/**
 * initPagerRefreshs是确定分页刷新是重新查询
 */
function initPagerRefresh() {
	var dg = $("#dg");
	var opts = dg.datagrid('options');
	var pager = dg.datagrid('getPager');
	pager.pagination( {
		showPageList : true,
		showRefresh : true,
		onSelectPage : function(pageNum, pageSize) {
			opts.pageNumber = pageNum;
			opts.pageSize = pageSize;
			pager.pagination('refresh', {
				pageNumber : pageNum,
				pageSize : pageSize
			});
			initGrid(pageNum, pageSize);
		},
		onRefresh : function(pageNum, pageSize) {
			opts.pageNumber = pageNum;
			opts.pageSize = pageSize;
			pager.pagination('refresh', {
				pageNumber : pageNum,
				pageSize : pageSize
			});
			initGrid(pageNum, pageSize);
		},
		onChangePageSize : function(pageSize) {
			var pageNum = 1;
			opts.pageNumber = pageNum;
			opts.pageSize = pageSize;
			pager.pagination('refresh', {
				pageNumber : pageNum,
				pageSize : pageSize
			});
			initGrid(pageNum, pageSize);
		}
	});
}
function initPage(){
	var options = {
		pageList: [10,20,30,40,50],
		pageSize: 10,
		pagination : true,
		border : false,
		fit : true,
		nowrap : true,
		striped : true,
		rownumbers : true
	};
	$('#dg').datagrid(options);
}
function initGrid(pageNum, pageSize) {
	if (!pageNum) {
		pageNum = 1;
	}
	if (!pageSize) {
		var dg = $("#dg");
		var opts = dg.datagrid('options');
		pageSize = opts.pageSize;
	}
	// 加载表格
	$.ajax( {
		type : "post",
		url : getContextPath() + "/history/getFence",
		data : {
			pageNum : pageNum,
			pageSize : pageSize
		},
		dataType : "json",
		success : function(data) {
			//alert(JSON.stringify(data));
			$('#dg').datagrid('loadData', data);
			
		},
		error : function(data) {
			$.messager.alert('提示信息', "数据加载失败");
		}
	});
}

function onClickRow(index) {
	//alert("来了");
	//选中行
	//$('#dg').datagrid('selectRow', index);
	// 向后台发请求，更新当前地图的围栏显示
	currentFenceid = $('#dg').datagrid('getSelected').id;
	var fencepoints;
	//alert(currentFenceid);
	$.ajax({
		type : "post",
		url : getContextPath()+"/history/getFencePoint",
		dataType : "json",
		data : {
			"fenceid" : currentFenceid
		},
		success : function(data) {
			// 清除所有的地图覆盖物
			map.clearOverlays();
			//alert(JSON.stringify(data));
			var pts = [];
			for(var j = 0;j < data.length ; j++){
				// 可以将这些点存储到后台数据库
				var plypoint = data[j];
				var lng = plypoint.lng;
				var lat = plypoint.lat;
				// 模拟从后台数据库中传出来的点重新构造一个新的多边形区域
				var p = new BMap.Point(lng, lat);
				pts.push(p);
			}
			if(data.length>0){
				var fenceOverlay = new BMap.Polygon(pts);
				fenceOverlay.setStrokeColor("red")//设置多边形边线颜色
				fenceOverlay.setFillColor("red");//设置多边形填充颜色
				// 增加右键菜单
				var markerMenu=new BMap.ContextMenu();
				markerMenu.addItem(new BMap.MenuItem('删除',removeMarker.bind(fenceOverlay)));
				markerMenu.addItem(new BMap.MenuItem('围栏信息',function(pt){$.messager.alert('围栏信息',$('#dg').datagrid('getSelected').info)}));
				fenceOverlay.addContextMenu(markerMenu);
				// 设置地图的中心点为当前围栏顶点集合的第一个顶点
				map.centerAndZoom(new BMap.Point(pts[0].lng, pts[0].lat), 16);
				map.addOverlay(fenceOverlay);
			}
		},
		error : function(data) {
			alert(JSON.stringify(fencepoints));
		}
	});
}
/*
 *  点击添加按钮的响应参数
 */
function append() {
	var win = $('#window_create');
	win.window({
		href: getContextPath()+'/history/toAddFence'
	});
	win.window('open');
}
/*
 * 点击删除按钮的响应函数
 */
function removeit() {
	$.messager.confirm("确认", "确认删除", function(r) {
		if (r) {
			var row = $('#dg').datagrid('getSelected');
			var removeid = $('#dg').datagrid('getRowIndex',row);
			//提交数据库
			if (row) {
				var id = row.id;
				$.ajax( {
					type : "post",
					url : getContextPath() + "/history/delFence",
					data : {
						"id" : row.id
					},
					dataType : "json",
					success : function(data) {
						map.clearOverlays();
						$('#dg').datagrid('cancelEdit', editIndex).datagrid('deleteRow', removeid);
						//$("#dg_item").datagrid('reload');  
						$.messager.alert('提示信息', "删除数据成功");
					},
					error : function(data) {
						$.messager.alert('提示信息', "删除数据失败");
					}
		
				});
				if(row.id==null||row.id==""){//新增行
					$('#dg').datagrid('cancelEdit', editIndex).datagrid('deleteRow', removeid);
				}
			} else {
				$.messager.alert('提示信息', "选择需要删除的行");
			}
			editIndex = undefined;
		}
	}); 
}

// 页面加载之后执行,初始化
$(document).ready(function() {
	map = new BMap.Map('allmap', {enableMapClick: false});
	map.enableScrollWheelZoom();//开启滚动缩放
	map.enableContinuousZoom();//开启缩放平滑
	map.centerAndZoom(new BMap.Point(116.404, 39.9155), 16);
	var styleOptions = {
		strokeColor:"red",	//边线颜色。
		fillColor:"red",	//填充颜色。当参数为空时，圆形将没有填充效果。
		strokeWeight: 3,	//边线的宽度，以像素为单位。
		strokeOpacity: 0.8,	//边线透明度，取值范围0 - 1。
		fillOpacity: 0.6,	//填充的透明度，取值范围0 - 1。
		strokeStyle: 'solid' //边线的样式，solid或dashed。
	}
	var drawingManager = new BMapLib.DrawingManager(map, {
		isOpen: false,
		drawingType: BMAP_DRAWING_MARKER,// 绘画模式
		enableDrawingTool: true, //是否显示工具栏
		enableCalculate: false,// 绘制是否进行测距(画线时候)、测面(画圆、多边形、矩形)
		drawingToolOptions: {
			anchor: BMAP_ANCHOR_TOP_RIGHT, //位置
			offset: new BMap.Size(5, 5),
			drawingModes : [
				BMAP_DRAWING_CIRCLE,// 圆形
				BMAP_DRAWING_RECTANGLE,// 矩形
				BMAP_DRAWING_POLYGON // 多边形
			]
		},
		circleOptions: styleOptions, //圆的样式
		polylineOptions: styleOptions, //线的样式
		polygonOptions: styleOptions, //多边形的样式
		rectangleOptions: styleOptions //矩形的样式
	});
	var ply;
	drawingManager.enableCalculate();//开启计算模式
	// ply覆盖物圆形
	drawingManager.addEventListener("overlaycomplete", function(e) {
		// 获取覆盖物	
		ply = e.overlay;
		var info ="";
		if ("rectangle"==drawingManager.getDrawingMode()){
			info ="长宽为";
			var points = ply.getPath();
			for(var i = 1;i < points.length-1 ; i++){
				var plypoint = points[i];
				info += " "+map.getDistance(points[i],points[i-1]).toFixed(2)+' 米';
			}
			info+=";面积"+e.calculate+"平方米";
		}
		if("circle"==drawingManager.getDrawingMode()){
			var info ="圆心("+ply.getCenter().lat+","+ply.getCenter().lng+");半径"+ply.getRadius()+"米;面积"+e.calculate+"平方米";
		}
		if("polygon"==drawingManager.getDrawingMode()){
			info ="多边形各边长为";
			var points = ply.getPath();
			for(var i = 1;i < points.length ; i++){
				var plypoint = points[i];
				info += " "+map.getDistance(points[i],points[i-1]).toFixed(2)+' 米';
			}
		}
		// 添加右键删除菜单
		var markerMenu=new BMap.ContextMenu();
		markerMenu.addItem(new BMap.MenuItem('删除',removeMarker.bind(ply)));
		markerMenu.addItem(new BMap.MenuItem('围栏信息',function(pt){$.messager.alert('围栏信息',info)}));
		ply.addContextMenu(markerMenu);
		// 将顶点存储到数据库
		storePoints(ply,info);
	});
	// ply覆盖物圆形
/*	*/
}); 
// 围栏删除函数
var removeMarker = function(e,ee,marker){
	removeit();
}
//保存围栏的点信息;ply覆盖物，info围栏的备注信息
function storePoints(ply,info){
	currentFence = $('#dg').datagrid('getSelected');
	if(currentFence == null){
		$.messager.alert('提示', "至少选中一个围栏进行修改");
		map.clearOverlays();
	}
	else{
		$.messager.confirm("确认", "确认修改", function(r) {
			if (r) {
			//修改围栏
				storePoints1(ply,1);
			} else{
				map.clearOverlays();
				$('#dg').datagrid('getSelected');
				onClickRow(currentFenceid);
			}
		});
	}
}
/*
 * 修改围栏定点函数
 * @param {Object} ply
 * @param {Object} replace 是否需要重新绘制 0新建，1修改
 */
function storePoints1(ply,replace){
	var currentFenceid = $('#dg').datagrid('getSelected').id;
	var points = ply.getPath();
	// 将顶点组装成json数据
	var fencepoints = "[";
	for(var i = 0;i < points.length ; i++){
		var plypoint = points[i];
		var lng = plypoint.lng;// 经度
		var lat = plypoint.lat;// 纬度
		fencepoints = fencepoints + '{"lng":"'+lng+'","lat":"'+lat+'"}';
		if(i < points.length - 1){
			fencepoints = fencepoints + ",";
		}
	}
	fencepoints = fencepoints + "]";
	// 将Json串传回后台
	$.ajax({
		type : "post",
		url : getContextPath()+"/history/drawFence",
		data : {
			"fenceid": currentFenceid,
			"fencepoints" : fencepoints
		},
		dataType : "json",
		success : function(data) {
			if(replace==1)
			{
				$.messager.alert('提示信息', "修改围栏成功");
				map.clearOverlays();
				ply.setStrokeColor("red")//设置多边形边线颜色
				ply.setFillColor("red");//设置多边形填充颜色
				map.addOverlay(ply);
			}else{
				$.messager.alert('提示信息', "新建围栏成功");
			}
		},
		error : function(data) {
			if(replace==1)
			{
				$.messager.alert('提示信息', "修改围栏失败");
				map.clearOverlays();
				ply.setStrokeColor("red")//设置多边形边线颜色
				ply.setFillColor("red");//设置多边形填充颜色
				map.addOverlay(ply);
			}else{
				$.messager.alert('提示信息', "新建围栏是失败");
			}
		}
	});
}
//响应删除键
function keyDelete() {
	if (event.keyCode == 46) { //Delete的键值为46
		removeit();
	}
}

/////////////////////////////分组配置///////////////////////////////////
/*表格分组列的内容，以下是围栏分组的内容*/
var configid;
function groupformatter(value, row, index) {
	return '<a href="#" onclick="configGroup(' + row.id + ')">分组</a>';
}
function configGroup(id) {
	configid = id;
	//初始化数据
	$.ajax( {
		type : "post",//post/submit
		url : "listGroupConfigByUser.action",//action
		dataType : "json",//返回的数据类型
		data : {
			configid : configid,
			tablename : "fenceconfig",
			configcolum : "fenceid"
		},
		success : function(data) {//回调函数
			$('#sdg').datagrid('loadData', data);
			//打开对话框
		$('#dlg').dialog('open');
		},
		error : function(data) {
			$.messager.alert('提示', "数据加载失败");
		}
	});
}


function getContextPath() {
	var pathName = document.location.pathname;
	var index = pathName.substr(1).indexOf("/");
	var result = pathName.substr(0, index + 1);
	return result;
}