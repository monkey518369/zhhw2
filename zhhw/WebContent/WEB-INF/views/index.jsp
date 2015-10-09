<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/include/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>中国智慧环卫物联网管控系统</title>
<link rel="shortcut icon" href="style/images/logo1.png" type="image/x-icon" />
<%@ include file="/include/jquery.libs.jsp"%>
<script type="text/javascript">
	function addTab(title, url){    
	    if ($('#main_center').tabs('exists', title)){    
	        $('#main_center').tabs('select', title);    
	    } else {    
	        var content = '<iframe scrolling="auto" frameborder="0"  src="'+url+'" style="width:100%;height:100%;"></iframe>';   
	        $('#main_center').tabs('add',{    
	            title:title,    
	            content:content,  
	            closable:true    
	        });    
	    }    
	}   
</script>
</head>
<body style="background: #f0f9fd;" class="easyui-layout">
	<div data-options="region:'north',split:false"
		style="background: url(${ctx}/third-lib/savior/images/topbg.gif) repeat-x;">
		<div class="topleft">
			<a href="main.html" target="_parent"><img
				src="${ctx}/third-lib/savior/images/logo.png" title="系统首页" /> </a>
		</div>
		<div class="topright">
			<ul>
				<li><span>
				<img src="${ctx}/third-lib/savior/images/help.png" title="帮助"
						class="helpimg" /> </span><a href="#">帮助</a></li>
				<li><a href="#">关于</a></li>
				<li><a href="j_spring_security_logout" target="_parent">退出</a>
				</li>
			</ul>

			<div class="user">
				<span><sec:authentication property="principal.name" />
				</span> <i>消息</i> <b>50</b>
			</div>

		</div>
	</div>
	<div data-options="region:'west',split:false,iconCls:'menu-node-menu'"
		title="功能树" style="width: 180px;">
		<div id="main_west_accordion" class="easyui-accordion" style="height:100%;border:0px">
			<script type="text/javascript">
				$.ajax({
					type : 'GET',
					url : '${ctx}/${frameworkPath}/menu/nav2',
					success : function(data) {
						var json = eval('('+data+')');
						$.each(json, function(i, item){
							$('#main_west_accordion').accordion('add',{
								title:item.text,
								iconCls:item.iconCls,
								content:'<ul id="tt_'+item.id+'" class="easyui-tree" data-options="animate:true,dnd:true,lines:true"></ul>'
							});  
							$('#tt_'+item.id).tree({
								type:'POST',
				                url:"${ctx}/${frameworkPath}/menu/nav2/children?parentId="+item.id,
				                onClick: function (node) {
				                    if (node.attributes != "") {  
				                    	addTab(node.text,'${ctx}/'+node.attributes[0].url);
				                    }  
				                }
				            });
						});
					},
					error : function(XmlHttpRequest, textStatus, errorThrown) {
						$.messager.alert('<fmt:message key="message.title" />','错误：' + XmlHttpRequest.status,'error');
					}
				});
			</script>
	       <!--  <div title="About" data-options="iconCls:'icon-ok'" style="overflow:auto;padding:2px;">
	            
	        </div>
	        <div title="Help" data-options="iconCls:'icon-help'" style="padding:10px;">
	            
	        </div> -->
        </div>
	</div>
	<div id="main_center" class="easyui-tabs" data-options="region:'center',fit:true,plain:true" >
		 <div title="首页" style="padding:10px">
			<div class="mainindex">
				<div class="welinfo">
					<span><img src="${ctx}/third-lib/savior/images/sun.png"
						alt="天气" /> </span> <b>${user.name}早上好，欢迎使用信息管理系统</b><a href="#">帐号设置</a>
				</div>
				<div class="welinfo">
					<span><img src="${ctx}/third-lib/savior/images/time.png"
						alt="时间" /> </span> <i>您上次登录的时间：2013-10-09 15:22</i> （不是您登录的？<a href="#">请点这里</a>）
				</div>
				<div class="xline"></div>
				<div class="box"></div>
			</div>
		</div>
	</div>
</body>
</html>