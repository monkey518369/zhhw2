<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/include/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<%@ include file="/include/jquery.libs.jsp"%>
<script type="text/javascript">
$(function(){	
	//导航切换
	$(".menuson li").click(function(){
		$(".menuson li.active").removeClass("active");
		$(this).addClass("active");
	});
	
	$('.title').click(function(){
		var $ul = $(this).next('ul');
		$('dd').find('ul').slideUp();
		if($ul.is(':visible')){
			$(this).next('ul').slideUp();
		}else{
			$(this).next('ul').slideDown();
		}
	});
});
</script>
</head>
<body style="background: #f0f9fd;">
	<div class="lefttop">
		<span></span>功能树
	</div>
	
	<div style="overflow-y:auto; overflow-x:hidden;">
		<dl class="leftmenu">
			<c:forEach var="f" items="${map}">
				<dd>
					<div class="title">
						<span class="menu-node-${f.key.icon}" style="height:16px;width:16px"></span>${f.key.name}
					</div>
					<c:if test="${f.value.size()>0}">
						 <ul class="menuson">
							 <c:forEach var="item" items="${f.value}">
							     <li><cite></cite><a href="${ctx}/${item.url}" target="rightFrame">${item.name}</a><i></i></li>
							 </c:forEach>
						 </ul>
					</c:if>
				</dd>
			</c:forEach>
		</dl>
	</div>

	
</body>
</html>