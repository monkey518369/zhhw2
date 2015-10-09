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


<body>

	<div class="place">
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="#">首页</a></li>
		</ul>
	</div>

	<div class="mainindex">


		<div class="welinfo">
			<span><img src="${ctx}/third-lib/savior/images/sun.png" alt="天气" /> </span> <b>${user.name}早上好，欢迎使用信息管理系统</b><a
				href="#">帐号设置</a>
		</div>

		<div class="welinfo">
			<span><img src="${ctx}/third-lib/savior/images/time.png" alt="时间" /> </span> <i>您上次登录的时间：2013-10-09
				15:22</i> （不是您登录的？<a href="#">请点这里</a>）
		</div>

		<div class="xline"></div>
		<div class="box"></div>

	</div>



</body>

</html>
