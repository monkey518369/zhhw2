/**
 * 区域找车
 */

var styleOptions = {
    strokeColor:"blue",    //边线颜色。
    fillColor:"blue",      //填充颜色。当参数为空时，圆形将没有填充效果。
    strokeWeight: 1,       //边线的宽度，以像素为单位。
    strokeOpacity: 0.3,	   //边线透明度，取值范围0 - 1。
    fillOpacity: 0.3,      //填充的透明度，取值范围0 - 1。
    strokeStyle: 'dashed' //边线的样式，solid或dashed。
}

/*
 * 标识地图绘制工具应用模块
 * 0：表示车辆动态信息
 * 1：表示报警信息
 */
var drawType = 0;


//实例化鼠标绘制工具
var drawingManager = new BMapLib.DrawingManager(map, {
    isOpen: false, //是否开启绘制模式
    enableDrawingTool: true, //是否显示工具栏
    drawingToolOptions: {
        anchor: BMAP_ANCHOR_TOP_LEFT, //位置
        offset: new BMap.Size(40, 9), //偏离值
        scale : 0.5,
        drawingModes  : [
			BMAP_DRAWING_CIRCLE,
			BMAP_DRAWING_POLYGON,
			BMAP_DRAWING_RECTANGLE
		]
    },
    circleOptions: styleOptions, //圆的样式
    polylineOptions: styleOptions, //线的样式
    polygonOptions: styleOptions, //多边形的样式
    rectangleOptions: styleOptions //矩形的样式
});


//地图增加覆盖物绘制结束时间，判断所有车是否在覆盖物上，如果是，则在此处增加标注
drawingManager.addEventListener('overlaycomplete', function(e){
	//请求所有车辆的点,可优化，定时取值，不需要每次都取
	var carList = new Array();
	if(drawType==0){
		$.ajax({
			url : getContextPath()+"/truckmanage/getAllTruckDynamic",
			dataType : 'json',
			async : false,
			success : function(data){
				for(var i = 0;i < data.length;i++){
					carList.push(data[i]);
				}
			}
		});
	}else {
		$.ajax({
			url : getContextPath()+"/carwarning/getAllCarWarning",
			dataType : 'json',
			async : false,
			success : function(data){
				for(var i = 0;i < data.length;i++){
					carList.push(data[i]);
				}
			}
		});
	}
	
	/*
	 * 清除datagrid所有数据,用于显示区域中有的车辆信息
	 */
	var rowsLength = $("#truckList").datagrid('getRows').length;	//datagrid 行数
	for(var i=0;i<rowsLength;i++){
		$("#truckList").datagrid('deleteRow',rowsLength-i-1);	//由于删除是没删除一行索引会改变，故从索引最大的一行开始删除
	}
	var overlay = e.overlay;
	overlays.push(overlay);
	//为了显示清楚，确保地图只有一个覆盖物
	for(var i = 0;i < overlays.length-1; i++){
		map.removeOverlay(overlays[i]);
	}

	if(e.drawingMode == BMAP_DRAWING_CIRCLE){
		for(var i = 0;i < carList.length;i++){
			var car  = carList[i];
			console.info(car);
			var point = new BMap.Point(car.car_lng, car.car_lat);
			if(BMapLib.GeoUtils.isPointInCircle(point, overlay)){
				drawMarkInMap(point,car);
			}
		}
	}else if(e.drawingMode == BMAP_DRAWING_POLYGON){
		for(var i = 0;i < carList.length;i++){
			var car  = carList[i];
			var point = new BMap.Point(car.car_lng, car.car_lat);
			if(BMapLib.GeoUtils.isPointInPolygon(point, overlay)){
				drawMarkInMap(point,car);
			}
		}
	}else if(e.drawingMode == BMAP_DRAWING_RECTANGLE){
		var bounds = overlay.getBounds();
		for(var i = 0;i < carList.length;i++){
			var car  = carList[i];
			var point = new BMap.Point(car.car_lng, car.car_lat);
			if(BMapLib.GeoUtils.isPointInRect(point, bounds)){
				drawMarkInMap(point,car);
			}
		}
	}
	//关闭地图的绘制状态（只有当关闭绘制状态时才可点击查看地图上标注的提示信息）
	drawingManager.close();
});

//在地图上绘制标注点
function drawMarkInMap(point,car){
	var marker = new BMap.Marker(point, {}); // 创建标注
	console.info(point+"1");
	overlays.push(marker);
	map.addOverlay(marker); // 将标注添加到地图中
	if(drawType == 0){
		console.info(point+"2");
		$('#truckList').datagrid('insertRow',{
			index: 0,
			row: {
				truck_id : car.truck_id,
				company: car.company,
				speed: car.speed,
				oil: car.oil,
				status: car.status,
				car_lng : car.car_lng,
				car_lat : car.car_lat
			}
		});
		var sContent = "车辆编号:"+car.truck_id+"<br/>" +"车辆所属公司:"+car.company+"<br/>" +"车辆时速:"+car.speed+"<br/>" +"车辆油量:"+car.oil+"<br/>" +"车辆状态:"+(car.status=="1"?"正常":"不正常");
		addClickHandler(sContent, marker);
	}else {
		console.info(point+"3");
		$('#truckList').datagrid('insertRow',{
			index: 0,
			row: {
				car_id : car.car_id,
				plate_no: car.plate_no,
				type: car.type,
				point: car.point,
				create_time: car.create_time,
				handman : car.handman,
				describe : car.describe,
				status : car.status
			}
		});
		var sContent = "车辆编号:"+car.car_id+"<br/>" 
							+"车牌号:"+car.plate_no+"<br/>" 
							+"报警类型:"+car.type+"<br/>" 
							+"报警位置:"+car.point+"<br/>" 
							+"报警时间:"+car.create_time+"<br/>" 
							+"报警描述:"+car.describe+"<br/>" 
							+"车辆状态:"+(car.status=="1"?"正常":"不正常");
		addClickHandler(sContent, marker);
	}
	
}