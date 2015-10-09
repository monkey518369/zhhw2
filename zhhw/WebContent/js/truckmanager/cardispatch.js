/**
 * 车辆远程调度
 * @returns
 */

function getContextPath() {
	var pathName = document.location.pathname;
	var index = pathName.substr(1).indexOf("/");
	var result = pathName.substr(0, index + 1);
	return result;
}

$('#orgTree').tree({   
	url : getContextPath() + '/carorg/getOrgJson',
	onClick: function(node){
		loadCarTree(node.id);
	}
});

$('#carTree').tree({
	url : getContextPath() + '/infomanage/getcarbyorgid?orgId='+1011,
	checkbox : true,
	onCheck:function(node){
		var org = $('#carTree').tree('getRoot').text;
		if(node.parentId == '' && node.checked){
			var cars = node.children;
			for(var i=0;i<cars.length;i++){
				var car = cars[i];
				var plate_no = car.text;
				var id = car.id;
				insertDataGrid(id,plate_no,org);
			}
			return;
		}else if(node.parentId == '' && !node.checked){
			var cars = node.children;
			for(var i=0;i<cars.length;i++){
				var car = cars[i];
				var id = car.id;
				deleteDataGrid(id);
			}
			return;
		}
		
		var plate_no = node.text;
		var id = node.id;
		if(!node.checked){
			insertDataGrid(id,plate_no,org);
		}else{
			deleteDataGrid(id);
		}
	}
})

/**
 * 将勾选的车辆数据加入到数据表格中
 * @param id
 * @param plate_no
 */
function insertDataGrid(id,plate_no,org){
	var datas = $('#carChecked').datagrid('getData').rows;
	//判断现在的数据表格中是否有记录，如果没有加入该记录
	for(var i=0;i<datas.length;i++){
		var data = datas[i];
		if(data.id==id){
			return;
		}
	}
	$('#carChecked').datagrid('insertRow',{
		index: 0,	// 索引从0开始
		row: {
			id: id,
			plate_no: plate_no,
			org: org
		}
	});
}

/**
 * 将被勾选掉的数据从数据表格中删除
 * @param id
 */
function deleteDataGrid(id){
	var index = -1;			//标记要删除的数据行
	var datas = $('#carChecked').datagrid('getData').rows;
	for(var i=0;i<datas.length;i++){
		var data = datas[i];
		if(data.id==id){
			index = i;
		}
	}
	if(index!=-1){
		$('#carChecked').datagrid('deleteRow',index);
	}
}

/**
 * 生成组织车辆数
 * @param id
 */
function loadCarTree(id){
	$('#carTree').tree({
		url : getContextPath() + '/infomanage/getcarbyorgid?orgId='+id,
		checkbox : true,
		onCheck:function(node){
			var org = $('#carTree').tree('getRoot').text;
			if(node.parentId == '' && node.checked){
				var cars = node.children;
				for(var i=0;i<cars.length;i++){
					var car = cars[i];
					var plate_no = car.text;
					var id = car.id;
					insertDataGrid(id,plate_no,org);
				}
				return;
			}else if(node.parentId == '' && !node.checked){
				var cars = node.children;
				for(var i=0;i<cars.length;i++){
					var car = cars[i];
					var id = car.id;
					deleteDataGrid(id);
				}
				return;
			}
			
			var plate_no = node.text;
			var id = node.id;
			if(!node.checked){
				insertDataGrid(id,plate_no,org);
			}else{
				deleteDataGrid(id);
			}
		}
	})
}

/**
 * 调度车辆
 */
function dispatchCar(){
	var datas = $('#carChecked').datagrid('getData');
	//下发指令的车辆id
	var ids = "";
	if(datas.total>0){
		//文本下发类型
		var textMessage = $('input[name="textMessage"]:checked').val();
		
		//电话回拨类型
		var ConversationType = $('input[name="ConversationType"]:checked').val();
		
		//文本信息内容
		var message = $('#message').val();
		//回拨电话号码
		var phoneNum = $('#phoneNum').combobox('getText');

		for(var i=0;i<datas.total;i++){
			var data = datas.rows[i];
			ids += data.id+",";
		}
		$.ajax({
			url : getContextPath() + '/cardispatch/dispatch',
			data : {
				ids : ids,
				textMessage : textMessage,
				message : message,
				ConversationType : ConversationType,
				phoneNum : phoneNum
			},
			success:function(data){
				console.info(data);
				var message = '';
				for(var i=0;i<data.length;i++){
					message += data[i];
					message += "<br/>";
				}
				parent.$.messager.show({
					title : '消息接受返回',
					msg : message,
					timeout : 1000 * 2,
					height:300
				});
			}
		})
	}
}
