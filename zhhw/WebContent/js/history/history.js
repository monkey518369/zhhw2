$(function() {
	var mapDiv = $('#allmap');
	var prevDiv = mapDiv.prev();
	var parentDiv = mapDiv.parent();
	mapDiv.height(parentDiv.height() - prevDiv.height());
});
var id;//学生id
var name;//学生姓名
// 百度地图API功能
var lushu;//百度路书
var isrun = false;//是否处于路线运行状态
var gc = new BMap.Geocoder();//根据经纬度反编译地址的变量
//以下是历史轨迹运行的图标
var myIcon = new BMap.Icon("../image/menu/master.png", {
	width : 32,
	height : 32
}, {
	anchor : new BMap.Size(16, 32)
});
var baiduIcon = new BMap.Icon('http://developer.baidu.com/map/jsdemo/img/car.png', 
		new BMap.Size(52,26),
		{anchor : new BMap.Size(27, 13)}
);
var map = new BMap.Map("allmap"); // 创建Map实例
map.centerAndZoom("北京市", 12); // 创建点坐标
map.enableScrollWheelZoom(); //启用滚轮放大缩小

//initTree();
initDateTimeBox();
var rows;

function listLine() {
	var starttime = $('#starttime').datetimebox('getValue');
	var endtime = $('#endtime').datetimebox('getValue');
	if(id==""){
		$.messager.alert('提示', "选择车辆");
	}else{
		var carid = id;
	}
	if (starttime == "") {
		$.messager.alert('提示', "输入起始时间");
		return;
	}
	if (endtime == "") {
		$.messager.alert('提示', "输入结束时间");
		return;
	}
	if (starttime > endtime) {
		$.messager.alert('提示', "开始时间不能早于结束时间");
		return;
	}
	iniPath2(carid, starttime, endtime);
}
function iniPath2(carid, starttime, endtime) {
	jQuery.ajax( {
		type : "post",
		url : getContextPath() + "/history/getPosition",
		data : {
			"carid" : carid,
			"starttime" : starttime,
			"endtime" : endtime
		},
		dataType : "json",
		success : function(data) {
			map.clearOverlays();
			if (data.length > 0) {
				rows = data;
				var polylinePointsArray = [];
				for(var i = 0;i<data.length;i++){
					var item = data[i];
					var x = item.lng;
					var y = item.lat;
					var pt = new BMap.Point(x, y);
					polylinePointsArray[i] = pt;
					var mkr = new BMap.Marker(pt);
					var _html = "提示";
					gc.getLocation(pt, function(rs) {
						var addComp = rs.addressComponents;
						_html = "位于：<br>" + addComp.province + ", " + addComp.city
								+ ", " + addComp.district + ", " + addComp.street
								+ ", " + addComp.streetNumber + "。<br>经纬度：(" + x + ","
								+ y + ")";
					});
					map.addOverlay(mkr);
					mkr.addEventListener("mouseover", function(e) {
						this.openInfoWindow(new BMap.InfoWindow(_html));
					});
				}
				var polyline = new BMap.Polyline(polylinePointsArray, {
					strokeColor : "blue",
					strokeWeight : 3,
					strokeOpacity : 0.5
				})
				map.addOverlay(polyline);
				var arrPois = polyline.getPath(); //通过驾车实例，获得一系列点的数组
				iniHistory(arrPois);
			} else {
				$.messager.alert('提示', "没有检测到轨迹");
			}
		}
	});
}
function iniHistory(arrPois) {
	var speed = $('#ss').numberspinner('getValue');
	//map.setViewport(arrPois);

 	lushu = new BMapLib.LuShu(map, arrPois, {
		defaultContent : name,
		speed : speed,
		icon : baiduIcon,
		enableRotation:true,//是否设置marker随着道路的走向进行旋转
		autoView:true,//是否开启自动视野调整，如果开启那么路书在运动过程中会根据视野自动调整
		landmarkPois : []
	}); 
}
function runLine() {
	if (lushu) {
		isrun = true;
		lushu.start();
	} 

}
function stopLine() {
	isrun = false;
	lushu.stop();
}
function pauseLine() {
	lushu.pause();
}
function showMessage() {
	lushu.showInfoWindow();
}
function hideMessage() {
	lushu.hideInfoWindow();
}
/*
 * 设置播放速度
 */
function setSpeed() {
	if (isrun && !lushu == "") {
		$.messager.confirm("确认", "设置速度需要停止运行", function(r) {
			if (r) {
				stopLine();
				var speed = $('#ss').numberspinner('getValue');
				lushu.setSpeed(speed);
				runLine();
			}
		});
	} else {
		stopLine();
		var speed = $('#ss').numberspinner('getValue');
		lushu.setSpeed(speed);
		runLine();
	}
}
function validateDateTime(beginTimeId, endTimeId, whichTimeId) {
	if(whichTimeId==endTimeId){
		var v1 = $('#' + endTimeId).datetimebox("getValue");
		var nowdate = new Date().format("yyyy-MM-dd hh:mm:ss"); 
		if (date1 > nowdate) {
			
			$('#' + endTimeId).datetimebox("setValue", "");
			$.messager.alert('提示', '结束时间不能大于当前时间');
			return false;
		}
	}
	
	var v1 = $('#' + beginTimeId).datetimebox("getValue");
	//var date1 = new Date(v1);
	var v2 = $('#' + endTimeId).datetimebox("getValue");
	//var date2 = new Date(v2);

	if (v1 == '' || v2 == '') {
		return true;
	}
	if (v1 < v2) {

		return true;
	}
	try {
		$('#' + whichTimeId).datetimebox("setValue", "");
	} catch (e) {
	}
	try {
		$('#' + whichTimeId).datebox("setValue", "");
	} catch (e) {
	}

	$.messager.alert('提示', '开始时间要小于结束时间！');
	return false;
}
function initDateTimeBox(){
	//现在开始时间<结束时间
	$('#starttime').datetimebox( {
		onHidePanel : function(date) {
			validateDateTime('starttime', 'endtime', 'starttime');
		}
	});
	$('#endtime').datetimebox( {
		onHidePanel : function(date) {
			validateDateTime('starttime', 'endtime', 'endtime');
		}
	});
}
//显示组织机构窗口
function orgShow(){
	$('#orgTree').tree({
		url : getContextPath() + '/carorg/getOrgJson'
	}); 
	$('#orgWin').window('open');
}
function getCarByOrgId(){
	var ids = "";
	var nodes = $('#orgTree').tree('getChecked');
	for(var i=0;i<nodes.length;i++){
		ids += nodes[i].id+",";
	}
	ids = ids.substr(0,ids.lastIndexOf(","))

	$('#carlist').tree({
		url : getContextPath() + '/truckmanage/getAllTruckByOrgList?ids='+ids,
		onClick : function(node) {
			id=node.id;
			name=node.text;
		}
	}); 
	$('#orgWin').window('close');
}
function orgHide(){
	
}
function getContextPath() {
	var pathName = document.location.pathname;
	var index = pathName.substr(1).indexOf("/");
	var result = pathName.substr(0, index + 1);
	return result;
}