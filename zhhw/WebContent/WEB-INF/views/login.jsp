<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/include/taglibs.jsp"%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>中国智慧环卫物联网管控系统</title>
<link rel="SHORTCUT ICON" type="image/ico"
	href="${ctx}/static/favicon.ico" />
<%@ include file="/include/jquery.libs.jsp"%>
<script language="javascript">
	$(function() {
		$('.loginbox').css({
			'position' : 'absolute',
			'left' : ($(window).width() - 692) / 2
		});
		$(window).resize(function() {
			$('.loginbox').css({
				'position' : 'absolute',
				'left' : ($(window).width() - 692) / 2
			});
		});
		$('.qrcode').css({
			
		})
	});
</script>
<style type="text/css">
	span{margin:0;padding:0;display:block;}
</style>
</head>
<body
	style="background-color:#1c77ac; background-image:url(${ctx}/savior/images/light.png); background-repeat:no-repeat; background-position:center top; overflow:hidden;">

	<script language="JavaScript">
		if (window != top)
			top.location.href = location.href;
	</script>

	<div id="mainBody">
		<div id="cloud1" class=""></div>
		<div id="cloud2" class=""></div>
	</div>
	<div class="logintop">
		<span>欢迎登录后台管理界面平台</span>
		<ul>
			<li><a href="#">回首页</a>
			</li>
			<li><a href="#">帮助</a>
			</li>
			<li><a href="#">关于</a>
			</li>
		</ul>
	</div>
	<div class="loginbody">
		<span class="systemlogo"></span>
		<div class="loginbox">
			<form id="ff" method="post" action="${ctx}/j_spring_security_check">
				<ul>
					<li><input name="j_username" type="text" class="loginuser" value="admin"
						onclick="JavaScript:this.value=''" />
					</li>
					<li><input name="j_password" type="password" class="loginpwd" value="admin"
						onclick="JavaScript:this.value=''" />
					</li>
					<li><input name="" type="submit" class="loginbtn" value="登录"/><label><input
							name="" type="checkbox" value="" checked="checked" />记住密码</label><label><a
							href="#">忘记密码？</a>
					</label>
					</li>
			</ul>
			</form>
			${SPRING_SECURITY_LAST_EXCEPTION.message}
		</div>
	</div>
	<div class="loginbm">
		版权所有 2015
	</div>
<!-- 	<script>
        function submitForm(){
            $('#ff').ajaxSubmit({
            	 type: 'post',  
                 url: "j_spring_cas_security_check" ,  
                 success: function(data){  
                	 window.location.href="${ctx}/admin";
                 },  
                 error: function(XmlHttpRequest, textStatus, errorThrown){  
                	 debugger;
                	 $.messager.alert('<fmt:message key="message.title" />','错误：'+XmlHttpRequest.status, 'error');
                 }  
            });
        }
    </script> -->
</body>
</html>