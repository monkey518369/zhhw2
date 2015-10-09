$(function(){
	initInput();//初始化组织和车牌号的精确查找
	
	initCombBox();
	
	datastatisticsType();//初始化选择统计类型的单选框
	
	$("#top_search_btn").click(function(){
		showcharts();
	})
})
//初始化选择报警类型的下拉框
function initCombBox(){
	$("#search_alarm_type").combobox({    
	    data: [{
				label: '超速报警',
				value: '1'
			},{
				label: '越界报警',
				value: '2'
			},{
				label: '进界报警',
				value: '3'
			},{
				label: '脱离线路报警',
				value: '4'
			}] , 
		valueField:'value',    
	    textField:'label',
	    multiple:true,
	    editable:false,
	}); 
}
 
//初始化选择统计类型的单选框
var datastatisticsType = function(){
	$("input[name=alarm_type]").click(function(){
		var type = $(this).val();
		$("#selected_org").html("");//把之前选中的车辆或组织树清空
		switch(type){
			case 'group':initOrgTree('org_tree_org');
				 break
			case 'car':initOrgTree('org_tree_car')
				break
		}
	})
}

//初始化组织和车牌号的精确查找
var initInput = function(){
	$("#search_plat").searchbox({
		searcher:function(value,name){ 
		}, 
		prompt:'车牌号精确查找' 

	})
	
	$("#search_org").searchbox({
		searcher:function(value,name){
		},
		prompt:'组织精确查找'
	})
}

//初始化组织树
function initOrgTree(id){
	var onclick ;
	if(id!="org_tree_org"&&id!="org_tree_org_time"){
		onclick = function(node){
			$.ajax({
				type:'GET',
				url:'../infomanage/getcarbyorgid',
				data:{
					orgId:node.id
				},
				success:function(data){
					if(data[0].children.length>1){//判断组织线面是不是有车辆,
						initCarTree('car_tree',data)
					}else{
						$("#car_tree").html("<li>该组织暂无车辆</li>");
					}
					$("#car_window").window("open");
				},
				error:function(){
					$("#car_tree").html("<li>获取车辆错误,请重新尝试</li>");
					$("#car_window").window("open");
				}
			})
		}
	}
	$("#"+id).tree({
		url:'../carorg/getOrgJson',
		method:'get',
		animate:true,
		onClick:onclick
	})
	id = id.replace(/tree/,'window')
	$("#"+id).window("open");
}

//初始化车辆树
function initCarTree(id,data){
	$("#"+id).tree({
		data:data,
		method:'get',
		animate:true,
	})
}

//在组织树上点击取消
function cancelorg(){
	var nodes = $("#org_tree_org").tree("getChecked");
	$.each(nodes,function(i,item){
		$("#org_tree_org").tree("uncheck",item.target)
	})
}

//在组织树上点击保存
function saveorg(){
	var nodes = $("#org_tree_org").tree("getSelected");
	var tree = getNodesByNodes(nodes,null)
	//在右边生成已经选择的组织树
	createSelectedTree(tree);
	//关闭选择组织的window
	$("#org_window_org").window("close");
}

//在选择车辆树上点击选着保存
function savecar(){
	var tree = [];
	var new_nodes = $("#car_tree").tree("getSelected");
	var new_tree = getNodesByNodes(new_nodes,null);
	tree = new_tree;
	//在右边生成已经选择的组织树或车辆树
	createSelectedTree(tree)
	//关闭选择组织的window
	$("#car_window").window("close");
}

//根据选择的组织或车辆生成右边的树
function createSelectedTree(data){
	$("#selected_org").tree({
		data:data,
		onContextMenu: function(e, node){
			e.preventDefault();
			// 查找节点
			$('#selected_org').tree('select', node.target);
			// 显示快捷菜单
			$('#selected_org_menu').menu('show', {
				left: e.pageX,
				top: e.pageY
			});
		}
		
	})
}

//根据节点得到新的节点
function getNodesByNodes(nodes,node){
	var tree = [];
	var new_node = node;
	if(nodes instanceof  Array){
		$.each(nodes,function(i,item){
			if(new_node!=null){
				if(new_node.id!=item.id){
					var node = new Object();
					node.id=item.id;
					node.text=item.text;
					tree.push(node);
				}
			}else{
				var node = new Object();
				node.id=item.id;
				node.text=item.text;
				tree.push(node);
			}
			
		});
	}else{
		var node = new Object();
		node.id=nodes.id;
		node.text=nodes.text;
		tree.push(node);
	}
	
	return tree;
}

//点击右键删除已经选择的组织或车辆
function remove_selected_org_menu(){
	
	var node = $('#selected_org').tree('getSelected');
	$("#selected_org").tree("remove",node.target);
	
}

//得到已经选中的车辆或者组织
function getAllChecked(){
	var nodes = $("#selected_org").tree("getChildren");
	return nodes[0].id;
}

//ajax展示图表
function showcharts(){
	var flag = $("#selected_org").html();//判断是否已经选择了 组织或者车辆
	if(flag==""||flag==null){//若没有选择车辆或组织则返回错误
		alert("请选择车辆或组织")
		return ;
	}
	var type = $("input[name=alarm_type]:checked").val();//得到是展示的单车辆还是多个车辆还是组织
	var startDate = $('#center_starttime').datebox('getValue');//得到开始时间	
	var endDate = $("#center_endtime").datebox('getValue');//得到结束时间
	var timeParty = $("input[name=search_time]").val();//得到要查询的时间段
	var alarmType = $("#search_alarm_type").combo('getValues');//得到要查找的类型
	var showType = $("#show_style").combo('getValues');//得到展示的样式
	var id = getAllChecked();//得到已经选择的车辆或组织
	var showType="";//得到展示数据的形式
	if(type=="group"){
		var str = id.split(",");
		if(str.length<1){
			alert("请选择要对比的组织");
			return;
		}else{
			showGroupCharts(type,id,startDate,endDate,timeParty,alarmType,showType);
		}
	}else if(type=="car"){
		var str = id.split(",");
		if(str.length<1){
			alert("请选择对比车辆");
			return;
		}else{
			showCarCharts(type,id,startDate,endDate,timeParty,alarmType,showType)
		}
	}else{
		alert("未知错误,请重新尝试");
		location.reload(); 
	}
}

//对车辆信息数据进行查询展示
function showCarCharts(type,id,startDate,endDate,timeParty,alarmType,showType){
	$.ajax({
		type:'get',
		url:'../alarmdatastatistics/getalarmforcar',
		data:{
			id:id,
			startDate:startDate,
			endDate:endDate,
			timeParty:timeParty,
			alarmType:""+alarmType+"",
		},
		success:function(data){
			var highcharts = new Highcharts.Chart({
				chart:{
					renderTo:'container',
					type:"column",
				},	
				title:{
					text:"报警统计"
				},
				xAxis:{
					title:{
						text:data.xAxis_title_text
					},
					 categories:eval(data.xAxis_categories),
					 //labels:eval(data.xAxis_categories)
				},
				yAxis:{
					title:{
						text:"次数"
					},
				},
				 series:eval(data.series)
			})
		},
		error:function(){
			
		}
	})
	
}

//对组织的数据进行查询展示
function showGroupCharts(type,id,startDate,endDate,timeParty,alarmType,showType){
	$.ajax({
		type:'get',
		url:'../alarmdatastatistics/getalarmfororg',
		data:{
			id:id,
			startDate:startDate,
			endDate:endDate,
			timeParty:timeParty,
			alarmType:""+alarmType+"",
		},
		success:function(data){
			var highcharts = new Highcharts.Chart({
				chart:{
					renderTo:'container',
					type:"column",
				},	
				title:{
					text:"报警统计"
				},
				xAxis:{
					title:{
						text:data.xAxis_title_text
					},
					 categories:eval(data.xAxis_categories),
					 //labels:eval(data.xAxis_categories)
				},
				yAxis:{
					title:{
						text:"次数"
					},
				},
				 series:eval(data.series)
			})
		},
		error:function(){
			
		}
	})
	
}
