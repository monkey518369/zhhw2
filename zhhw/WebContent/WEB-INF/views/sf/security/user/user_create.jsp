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
<body style="background: #f0f9fd;" class="formbody">
	<div >
    		<div class="formtitle"><span>用户基本信息</span></div>
    		<form id="ff_org_create" enctype="multipart/form-data" method="post">
				<input type="hidden" name="org" value="${param.org}">
				<ul class="forminfo">
					<li><label><fmt:message key="user.username" />:</label><input name="username" type="text"
						style="width: 345px; height: 32px;" " class="easyui-textbox"
						data-options="required:true" /><i>用户号不能超过30个字符</i>
					</li>
					<li><label><fmt:message key="user.name" />:</label><input name="name" type="text"
						style="width: 345px; height: 32px;" " class="easyui-textbox"
						data-options="required:true" /><i>名称不能超过50个字符</i>
					</li>
					<li><label><fmt:message key="user.gender" />:</label><input name="gender" type="text"
						style="width: 345px; height: 32px;" " class="easyui-combobox"
						data-options="required:false,valueField:'value',textField:'name',url:'${ctx}/${frameworkPath}/item/USER_GENDER/sub2',method:'get'" />
					</li>
					<li><label><fmt:message key="user.email" />:</label><input name="email" type="text"
						style="width: 345px; height: 32px;" " class="easyui-textbox"
						data-options="required:false,validType:'email'" />
					</li>
					
					<li><label><fmt:message key="user.identity" />:</label><input name="identity" type="text"
						style="width: 345px; height: 32px;" " class="easyui-textbox"
						data-options="required:false" />
					</li>
					<li><label><fmt:message key="user.birthday" />:</label><input name="birthday" type="text"
						style="width: 345px; height: 32px;" " class="easyui-datebox"
						data-options="required:false" />
					</li>
					<li><label><fmt:message key="user.tel" />:</label><input name="tel" type="text"
						style="width: 345px; height: 32px;" " class="easyui-numberbox"
						data-options="required:false,validType:'tel'" /><i>固定电话</i>
					</li>
					<li><label><fmt:message key="user.mobile" />:</label><input name="mobile" type="text"
						style="width: 345px; height: 32px;" " class="easyui-numberbox"
						data-options="required:false,validType:'mobile'" /><i>手机号码</i>
					</li>
					<li><label><fmt:message key="user.address" />:</label><input name="address" type="text"
						style="width: 345px; height: 32px;" " class="easyui-textbox"
						data-options="required:false" />
					</li>
					<li><label><fmt:message key="user.post" />:</label><input name="post" type="text"
						style="width: 345px; height: 32px;" " class="easyui-textbox"
						data-options="required:false,validType:'ZIP'" />
					</li>
					<li><label>是否启用:</label><select
						class="easyui-combobox" name="enabled" style="width: 345px; height: 32px;">
							<option value="true">是</option>
							<option value="false">否</option>
						</select>
					</li>
					<li><label><fmt:message key="user.position" />:</label><input name="position" type="text"
						style="width: 345px; height: 32px;" " class="easyui-combobox"
						data-options="required:false,valueField:'ID',textField:'NAME',url:'${ctx}/${frameworkPath}/user/position2?org=${param.org}',method:'get'" />
					</li>
					<li><label><fmt:message key="user.ext" />:</label><input id="usercard" name="usercard" type="file"
						style="width: 345px; height: 32px;" />
					</li>
					<li><label><fmt:message key="user.description" />：</label>
					<input name="description" type="text"
						style="width: 345px; height: 80px;" " class="easyui-textbox"
						data-options="required:false,multiline:true" /><i>组织描述不能超过200个字符</i>
					</li>
				</ul>
			</form>
			<div style="text-align: center; padding: 5px">
				<a href="javascript:void(0)" class="easyui-linkbutton" style="width:137px;height:35px; background:url(${ctx}/third-lib/savior/images/btnbg.png) no-repeat; font-size:14px;font-weight:bold;color:#fff; cursor:pointer;"
					onclick="submitForm()">保存数据</a>
				<a href="javascript:void(0)" style="width:137px;height:35px; background:url(${ctx}/third-lib/savior/images/btnbg.png) no-repeat; font-size:14px;font-weight:bold;color:#fff; cursor:pointer;"
					class="easyui-linkbutton" onclick="clearForm()">清除数据</a>
			</div>
    	</div>

	<script type="text/javascript">
		function submitForm() {
  			$('#ff_org_create').ajaxSubmit({
								type : 'post',
								url : "${ctx}/${frameworkPath}/user/create?org=${param.org}",
								success : function(data) {
									if (data.success) {
										$('#window_create').window('close');
										$("#dg").datagrid('reload');
										$('#tt').tree("reload");
										$.messager.alert(
														'<fmt:message key="message.title" />',
														'<fmt:message key="message.save.successful" />',
														'info');
									}
									else{
										$.messager.alert(
												'<fmt:message key="message.title" />',
												'错误：' + data.error,
												'error');
									}
								},
								error : function(XmlHttpRequest, textStatus,errorThrown) {
									$.messager.alert(
													'<fmt:message key="message.title" />',
													'错误：' + XmlHttpRequest.status,
													'error');
								}
							});
		}
	</script>
</body>
</html>