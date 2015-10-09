<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/include/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<%@ include file="/include/jquery.libs.jsp"%>
</head>
<body style="background: #f0f9fd;" class="easyui-layout">
	<div data-options="region:'north',split:false" style="height:42px">
		<div class="place">
			<span>位置：</span>
			<ul class="placeul">
				<li><a href="${ctx}/center">首页</a>
				</li>
				<li><a href="#">系统安全</a>
				</li>
				<li><a href="#">控制台</a>
				</li>
			</ul>
		</div>
	</div>
	<div id="console_panel" class="easyui-panel"
		data-options="title:'日志输出',region:'center'">
		
	</div>
	<script type="text/javascript">
	ConsoleView = Ext.extend(Ext.Panel, {
		row : 0,// Tab键顺序
		task : null,
		constructor : function(cfg) {// 构造方法
			Ext.apply(this, cfg);
			// 设置基类属性
			ConsoleView.superclass.constructor.call(this, {
				el:'console_panel',
				layout : 'fit',
				autoScroll : true,
				items : []
			});
			this.task = {
				run : function() {
					this.requestData();
				},
				scope : this,
				interval : 5000
			};
			this.on('render', function() {
				Ext.TaskMgr.start(this.task);
			}, this, {
				delay : 500
			});

			this.on('destroy', function() {
				Ext.TaskMgr.stop(this.task);
			}, this);
		},
		requestData : function() {
			Ext.Ajax.request({
				url : '${ctx}/${frameworkPath}/console/view/' + this.row,
				method : 'GET',
				callback : this.updateData,
				scope : this
			});
		},
		updateData : function(options, success, response) {
			if (success) {
				var data = Ext.decode(response.responseText).rows;
				for ( var i = 0; i < data.length; i++) {
					Ext.DomHelper.append(this.body, {
						cn : '<font style=\"font-weight: bold;\">' + data[i].info + '</font>'
					});
				}
				this.row += data.length;
				var bottom = this.getHeight(); 
				this.body.scroll("b", bottom, true);
			}
		}
	});
	var consolview = new ConsoleView();
	consolview.render();
	</script>
</body>
</html>