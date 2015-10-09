$(function(){
	initInput();//初始化组织和车牌号的精确查找
	
	datastatisticsType();//初始化选择统计类型的单选框
	
	$("#top_search_btn").click(function(){
		showcharts();
	})
})
//初始化选择统计类型的单选框
var datastatisticsType = function(){
	$("input[name=garbage_type]").click(function(){
		var type = $(this).val();
		$("#selected_org").html("");
		switch(type){
			case 'group':initOrgTree('org_tree_org');
				 break
			case 'group_time':initOrgTree('org_tree_org_time')
				break
			case 'car':initOrgTree('org_tree_car')
				break
			case 'car_time':initOrgTree('org_tree_car')
				break
			default:initOrgTree('org_tree_car')
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
	var checkbox = true;
	var onclick ;
	if(id!="org_tree_org"&&id!="org_tree_org_time"){
		checkbox=false;
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
		checkbox:checkbox,
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
		checkbox:true
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
	var nodes = $("#org_tree_org").tree("getChecked");
	var tree = getNodesByNodes(nodes,null)
	//在右边生成已经选择的组织树
	createSelectedTree(tree);
	//关闭选择组织的window
	$("#org_window_org").window("close");
}
function saveorgtime(){
	var nodes = $("#org_tree_org_time").tree("getChecked");
	var tree = getNodesByNodes(nodes,null)
	//在右边生成已经选择的组织树
	createSelectedTree(tree);
	//关闭选择组织的window
	$("#org_window_org_time").window("close");
}

//在选择车辆树上点击选择取消
function cancelcar(){
	var nodes = $("#car_tree").tree("getChecked");
	$.each(nodes,function(i,node){
		$("#car_tree").tree("uncheck",node.target)
	})
}
//在选择车辆树上点击选着保存
function savecar(){
	var tree = [];
	var org_node = $("#org_tree_car").tree("getSelected")
	var new_nodes = $("#car_tree").tree("getChecked");
	var new_tree = getNodesByNodes(new_nodes,org_node);
	var old_tree = [];
	var flag = $("#selected_org").html();
	if(flag!=null&&flag!=""){
		var old_nodes = $("#selected_org").tree("getChildren");
		old_tree = getNodesByNodes(old_nodes,null);
	}
	
	tree = new_tree.concat(old_tree);
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
	var ids = "";
	$.each(nodes,function(i,node){
		ids = ids + node.id + ",";
	})
	ids = ids.substring(0,ids.length-1)
	return ids;
	
}
//ajax展示图表
function showcharts(){
	var type = $("input[name=garbage_type]:checked").val();//得到是展示的单车辆还是多个车辆还是组织
	var startDate = $('#center_starttime').datetimebox('getValue');//得到开始时间	
	var endDate = $("#center_endtime").datetimebox('getValue');//得到结束时间
	var time = $("input[name=search_time]").val();//得到要查询的时间段
	var flag = $("#selected_org").html();//查看是否已经选择了 组织或者车辆
	if(flag==""||flag==null){//若没有选择车辆或组织则返回错误
		alert("请选择车辆或组织")
		return ;
	}
	var ids = getAllChecked();//得到已经选择的车辆或组织
	var showType="";//得到展示数据的形式
	if(type=="group"){
		var str = ids.split(",");
		if(str.length<=1){
			alert("请选择要对比的组织");
			return;
		}else{
			showGroupCharts(type,ids,startDate,endDate,time,"column");
		}
		
	}else if(type=="group_time"){
		var str = ids.split(",");
		if(str.length!=1){
			alert("组织统计下只能选中一个组织");
			return;
		}else{
			showGroupCharts(type,ids,startDate,endDate,time,"column");
		}
		
	}else if(type=="car"){
		var str = ids.split(",");
		if(str.length<=1){
			alert("请选择对比车辆");
			return;
		}else{
			showCarCharts(type,ids,startDate,endDate,time,"column")
		}
		
	}else if(type=="car_time"){
		var str = ids.split(",");
		if(str.length!=1){
			alert("单车统计下,只能选中一辆车");
			return;
		}else{
			showCarCharts(type,ids,startDate,endDate,time,"spline");
		}
	}else{
		alert("未知错误,请重新尝试");
		location.reload(); 
	}
}

//对车辆信息数据进行查询展示
function showCarCharts(type,ids,startDate,endDate,time,showType){
	if(type=="group"||type=="car"){
		type = "column"
	}else{
		type = "spline"
	}
	$.ajax({
		type:'get',
		url:'../garbagedatastatistics/getgarbageforcar',
		data:{
			ids:ids,
			startDate:startDate,
			endDate:endDate,
			time:time,
		},
		success:function(data){
			var highcharts = new Highcharts.Chart({
				chart:{
					renderTo:'container',
					type:type,
				},	
				title:{
					text:"垃圾统计"
				},
				xAxis:{
					title:{
						text:data.xAxis_title_text
					},
					 //categories:eval(data.xAxis_categories),
					 //labels:eval(data.xAxis_categories)
				},
				yAxis:{
					title:{
						text:"重量(kg)"
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
function showGroupCharts(type,ids,startDate,endDate,time,showType){
	$.ajax({
		type:'get',
		url:'../../garbagedatastatistics/getcarbagefororg',
		data:{
			ids:ids,
			startDate:startDate,
			endDate:endDate,
			timeParty:time,
		},
		success:function(data){
			var highcharts = new Highcharts.Chart({
				chart:{
					renderTo:'container',
					type:"column",
				},	
				title:{
					text:"垃圾统计"
				},
				xAxis:{
					title:{
						text:data.xAxis_title_text
					},
					 categories:eval(data.xAxis_categories)
				},
				yAxis:{
					title:{
						text:"重量(kg)"
					},
				},
				 series:eval(data.series)
			})
		},
		error:function(){
			
		}
	})
	
}
