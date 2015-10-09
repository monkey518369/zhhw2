/**
 * 车辆动态信息查询
 */
function getContextPath() {
	var pathName = document.location.pathname;
	var index = pathName.substr(1).indexOf("/");
	var result = pathName.substr(0, index + 1);
	return result;
}

/*
 * 用于标记界面的操作类型，多个模块在同一界面上操作，有时需要更新表格
 * 1：车辆动态信息查询
 * 2：区域找车
 * 3：车辆报警
 */
var  operateType = 1;

//用于储存所有车辆所在的点
var points = new Array();
//用于存储地图中所有的覆盖物
var overlays = new Array();

var $dg = $("#truckList");
var $grid = $dg.datagrid({
	url : getContextPath() + "/truckmanage/getAllTruckDynamic",
	columns : [[
        {field:'truck_id',title:'车辆编号',width:20},
	    {field:'company',title:'所属公司',width:20},
	    {field:'speed',title:'时速',width:20},
	    {field:'oil',title:'油量',width:20},
	    {field:'status',title:'状态',width:20,formatter: function(value,row,index){
	    	if (value == null) {
				return "";
			} else {
				return value=="1"?"正常":"不正常";
			}
	    }}
	]],
	fitColumns: true,
	pagination : true,
	singleSelect : true,
	noheader : true,
	onClickRow : function(rowIndex, rowData){
		map.clearOverlays();
		var bMapPoint = new BMap.Point(rowData.car_lng,rowData.car_lat);
		var marker = new BMap.Marker(bMapPoint, {});
		map.addOverlay(marker); // 将标注添加到地图中
		overlays.push(marker);
		var sContent = "车辆编号:"+rowData.truck_id+"<br/>" +"车辆所属公司:"+rowData.company+"<br/>" +"车辆时速:"+rowData.speed+"<br/>" +"车辆油量:"+rowData.oil+"<br/>" +"车辆状态:"+(rowData.status=="1"?"正常":"不正常");
		addClickHandler(sContent, marker);
		drawingManager.close();
		map.panTo(bMapPoint);
	}
});


//设置地图显示区域高度
$('#cardistributemap').height($(window).height()-120);

//百度地图
var map = new BMap.Map("cardistributemap");
map.centerAndZoom(new BMap.Point(116.417854, 39.921988), 10);
map.enableScrollWheelZoom(true);

var infoWidows = new Array();

//页面加载完成默认在地图中显示所有车辆
$(function(){
	drawCarDynamicInMap();
	$("#mapdata").layout('collapse','south');
	$('#carlist').combobox({
	    required:true,    
	    multiple:true,
	    valueField:'id',
	    textField:'plate_no',
//	    formatter: function (row) {
//            var opts = $(this).combobox('options');
//            return '<input type="checkbox" class="combobox-checkbox">' + row[opts.textField]
//        },
	});
})

//点击车辆动态信息按钮时在地图上绘制动态信息的点
function drawCarDynamicInMap(){
	$.ajax({
		url : getContextPath() + '/truckmanage/getAllTruckDynamic',
		type : 'post',
		dataType : 'json',
		success : function(data) {
			for(var i = 0;i<data.length;i++){
				var truck = data[i];
				var bMapPoint = new BMap.Point(truck.car_lng,truck.car_lat);
				var marker = new BMap.Marker(bMapPoint, {}); // 创建标注
				map.addOverlay(marker); // 将标注添加到地图中
				overlays.push(marker);
				//给车辆增加标注信息
				var sContent = "车辆编号:"+truck.truck_id+"<br/>" +"车辆所属公司:"+truck.company+"<br/>" +"车辆时速:"+truck.speed+"<br/>" +"车辆油量:"+truck.oil+"<br/>" +"车辆状态:"+(truck.status=="1"?"正常":"不正常");
				addClickHandler(sContent, marker);
			}
		}
	});
}

//标注点击提示事件
function addClickHandler(content, marker) {
	marker.addEventListener("click", function(e) {
		openInfo(content, e);
	});
}
//提示窗口设置
var opts = {
	width : 200, // 信息窗口宽度
	height : 200, // 信息窗口高度
	title : "车辆动态信息" , // 信息窗口标题
	enableMessage : true
// 设置允许信息窗发送短息
};

//创建提示框
function openInfo(content, e) {
	var p = e.target;
	var point = new BMap.Point(p.getPosition().lng, p.getPosition().lat);
	var infoWindow = new BMap.InfoWindow(content, opts); // 创建信息窗口对象 
	map.openInfoWindow(infoWindow, point); //开启信息窗口
}

function truckDynamic(){
	drawType = 0;
	$("#toolCarDynamic").toggle();
	$grid = $dg.datagrid({
		url : getContextPath() + "/truckmanage/getAllTruckDynamic",
		columns : [[
	        {field:'truck_id',title:'车辆编号',width:20},
		    {field:'company',title:'所属公司',width:20},
		    {field:'speed',title:'时速',width:20},
		    {field:'oil',title:'油量',width:20},
		    {field:'status',title:'状态',width:20,formatter: function(value,row,index){
		    	if (value == null) {
					return "";
				} else {
					return value=="1"?"正常":"不正常";
				}
		    }}        
		]],
		fitColumns: true,
		pagination : true,
		singleSelect : true,
		noheader : true,
		onClickRow : function(rowIndex, rowData){
			map.clearOverlays();
			var bMapPoint = new BMap.Point(rowData.car_lng,rowData.car_lat);
			var marker = new BMap.Marker(bMapPoint, {});
			map.addOverlay(marker); // 将标注添加到地图中
			overlays.push(marker);
			var sContent = "车辆编号:"+rowData.truck_id+"<br/>" +"车辆所属公司:"+rowData.company+"<br/>" +"车辆时速:"+rowData.speed+"<br/>" +"车辆油量:"+rowData.oil+"<br/>" +"车辆状态:"+(rowData.status=="1"?"正常":"不正常");
			addClickHandler(sContent, marker);
			drawingManager.close();
			map.panTo(bMapPoint);
		},onDblClickRow : function(rowIndex, rowData){
			console.info(rowData);
		},onLoadSuccess : function(data){
			var len = data.total;
			var rows = data.rows;
			if(len >0){
				map.clearOverlays();
				for(var i=0;i<len;i++){
					var truck = rows[i];
					var bMapPoint = new BMap.Point(truck.car_lng,truck.car_lat);
					var marker = new BMap.Marker(bMapPoint, {}); // 创建标注
					map.addOverlay(marker); // 将标注添加到地图中
					overlays.push(marker);
					//给车辆增加标注信息
					var sContent = "车辆编号:"+truck.truck_id+"<br/>" +"车辆所属公司:"+truck.company+"<br/>" +"车辆时速:"+truck.speed+"<br/>" +"车辆油量:"+truck.oil+"<br/>" +"车辆状态:"+(truck.status=="1"?"正常":"不正常");
					addClickHandler(sContent, marker);
				}
			}
		}
	});
}

//tab页切换
function setTab(name,cursel,n)  
{  
    for(i=1;i<=n;i++)  
    {
        var menu=document.getElementById(name+i);
        var con=document.getElementById("con_"+name+"_"+i);
        menu.className=i==cursel?"hover":"";
        con.style.display=i==cursel?"block":"none";
    }
}

//收缩菜单
function backCarDynamic(){
	$("#toolCarDynamic").hide();
}

//隐藏组织机构窗口
function orgHide(){
	$('#orgWin').window('close');
}

//显示组织机构窗口
function orgShow(){
	
	$('#org').tree({    
	    url : getContextPath() + '/carorg/getOrgJson'
	}); 
	$('#orgWin').window('open');
}

//查询部门的车辆
function getCarByOrgId(){
	var ids = "";
	var nodes = $('#orgTree').tree('getChecked');
	for(var i=0;i<nodes.length;i++){
		ids += nodes[i].id+",";
	}
	ids = ids.substr(0,ids.lastIndexOf(","))
	var url = getContextPath() + '/truckmanage/getAllTruckByOrgId?ids='+ids; 
	$('#carlist').combobox('reload', url);
	$('#orgWin').window('close');
}
//按车牌号找车
function searchByPlateNo(searchType){
	var plate_no;
	if(searchType=="plate_no"){
		plate_no = $('#plate_no').val();
	}else if(searchType=="plate_no_fk_org"){
		plate_no = $('#carlist').combobox('getText');
	}
	$.ajax({
		url : getContextPath() + "/truckmanage/getCarByPlateNo",
		data :{'plate_nos':plate_no},
		dataType : "json",
		type : "post",
		success : function(data){
			if(data.result=='success'){
				//有查询结果处理
				map.clearOverlays();
				var truckList = data.truckList;
				for(var i = 0;i < truckList.length;i++){
					var truck = truckList[i];
					var lng = truck.car_lng;
					var lat = truck.car_lat;
					var mapPoint = new BMap.Point(lng,lat);
					var marker = new BMap.Marker(mapPoint, {});
					map.addOverlay(marker); // 将标注添加到地图中
					overlays.push(marker);
					var sContent = "车辆编号:"+truck.truck_id+"<br/>" +"车辆所属公司:"+truck.company+"<br/>" +"车辆时速:"+truck.speed+"<br/>" +"车辆油量:"+truck.oil+"<br/>" +"车辆状态:"+(truck.status=="1"?"正常":"不正常");
					addClickHandler(sContent, marker);
					map.panTo(mapPoint);
				}
				
				$("#truckList").datagrid('load',{
					plate_nos: plate_no
				});				
			}else{
				//无查询结果弹出提示框
				$.messager.alert(
						data.message,
						'错误：' + data.message,
						'error');
			}
		},
		error : function(data){
		}
	});
}
