/**
 * 车辆报警
 */

//车辆报警 在地图上显示所有
function truckWarning(){
	drawType = 1;
	//改变datagrid的表结构，用于显示报警相关信息
	$dg.datagrid({
		url : getContextPath() + "/carwarning/getAllCarWarning",
		columns : [[
	        {field:'car_id',title:'车辆编号',width:20},
	        {field:'plate_no',title:'车牌号',width:20},
		    {field:'type',title:'警报类型',width:20},
		    {field:'point',title:'警报位置坐标',width:20},
		    {field:'create_time',title:'发出时间',width:20,formatter:function(value,row,index){
		    	if (value == null) {
					return "";
				} else {
					return formatDate(value,'yyyy-MM-dd HH:mm:ss');
				}
		    }},
		    {field:'handman',title:'处理人',width:20},
		    {field:'describe',title:'描述',width:20},
		    {field:'status',title:'处理状态',width:20,formatter: function(value,row,index){
		    	if (value == null) {
					return "";
				} else {
					return value=="1"?"已处理":"未处理";
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
			var sContent = "车辆编号:"+rowData.car_id+"<br/>" 
							+"车牌号:"+rowData.plate_no+"<br/>" 
							+"报警类型:"+rowData.type+"<br/>" 
							+"报警位置:"+rowData.point+"<br/>" 
							+"报警时间:"+rowData.create_time+"<br/>" 
							+"报警描述:"+rowData.describe+"<br/>" 
							+"车辆状态:"+(rowData.status=="1"?"正常":"不正常");
			addClickHandler(sContent, marker);
			drawingManager.close();
			map.panTo(bMapPoint);
		},
		onDblClickRow : function(rowIndex, rowData){
			updateWarning(rowIndex, rowData);
		},
		onLoadSuccess : function(data){
			var len = data.total;
			var rows = data.rows;
			if(len >0){
				map.clearOverlays();
				for(var i=0;i<len;i++){
					var row = rows[i];
					var bMapPoint = new BMap.Point(row.car_lng,row.car_lat);
					var marker = new BMap.Marker(bMapPoint, {}); // 创建标注
					map.addOverlay(marker); // 将标注添加到地图中
					overlays.push(marker);
					//给车辆增加标注信息
					var sContent = "车辆编号:"+row.car_id+"<br/>" 
							+"车牌号:"+row.plate_no+"<br/>" 
							+"报警类型:"+row.type+"<br/>" 
							+"报警位置:"+row.point+"<br/>" 
							+"报警时间:"+row.create_time+"<br/>" 
							+"报警描述:"+row.describe+"<br/>" 
							+"车辆状态:"+(row.status=="1"?"正常":"不正常");
					addClickHandler(sContent, marker);
				}
			}
		}
	});
}

//双击报警表格，弹出报警处理界面
function updateWarning(rowIndex, rowData){
	$('#winWarning').window('open');


	$("#warningId").textbox('setValue',rowData.id);
	$("#deal_warn_plate_no").textbox('setValue',rowData.plate_no);
	$("#type").textbox('setValue',rowData.type);
	$("#point").textbox('setValue',rowData.point);
	$("#describe").textbox('setValue',rowData.describe);
	/* 
	 * easyui的textbox和validatebox的 赋值区别
	 * textbox：$('userId').textbox('setValue','aaa');
	 * validatebox :$('userId').val('aaa');
	*/
}

//毫秒日期时间格式化
function formatDate(time, format) {
	var	t = new Date(time);
	var tf = function(i) {
		return (i < 10 ? '0' : '') + i
	};
	return format.replace(/yyyy|MM|dd|HH|mm|ss/g, function(a) {
		switch (a) {
		case 'yyyy':
			return tf(t.getFullYear());
			break;
		case 'MM':
			return tf(t.getMonth() + 1);
			break;
		case 'mm':
			return tf(t.getMinutes());
			break;
		case 'dd':
			return tf(t.getDate());
			break;
		case 'HH':
			return tf(t.getHours());
			break;
		case 'ss':
			return tf(t.getSeconds());
			break;
		}
		;
	});
}

//提交表单内容
function submitForm() {
	$('#dealWarningForm').ajaxSubmit({
   	 	type: 'post',  
        url: getContextPath() + "/carwarning/updateCarWarning" , 
        data:{
        	warningId : $("#warningId").textbox('getValue'),
        	describe : $("#describe").val()
        },
        success: function(data){
        	if(data.success){
        		$('#winWarning').window('close');
        		$dg.datagrid('reload');  
        		$.messager.alert('Result', '报警信息已处理！', 'info');
        	}
        },  
        error: function(XmlHttpRequest, textStatus, errorThrown){  
        	$.messager.alert('Result','错误：'+'报警信息处理失败！', 'error');
        }  
   });
};

//清楚表单内容
function clearForm(){
	$("#describe").textbox('setValue','');
}