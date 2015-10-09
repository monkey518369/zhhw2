<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/include/taglibs.jsp"%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<%@ include file="/include/jquery.libs.jsp"%>
<script language="javascript">
	$(function(){
    $('.logout').css({'position':'absolute','left':($(window).width()-490)/2});
	$(window).resize(function(){  
    $('.logout').css({'position':'absolute','left':($(window).width()-490)/2});
    }); 
});  
</script> 
</head>
<body style="background:#edf6fa;">

    <div class="logout">
    
    <h2>安全的退出了！</h2>
    <p>看到这个提示，说明您安全的退出系统了!</p>
    <div class="reindex"><a href="${ctx}/login" target="_parent">返回首页</a></div>
    
    </div>


</body>
</html>