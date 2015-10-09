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
<body style="background: #f0f9fd;">
	<div>
		<div class="formtitle">
			<span>岗位基本信息</span>
		</div>
		<form id="ff_position_create" method="post">
			<ul class="forminfo">
				<li><label><fmt:message key="position.id" />:</label><input
					name="id" type="text" style="width: 345px; height: 32px;"
					 class="easyui-textbox" data-options="required:true" /><i></i>
				</li>
				<li><label><fmt:message key="position.name" />:</label><input
					name="name" type="text" style="width: 345px; height: 32px;"
					class="easyui-textbox" data-options="required:true" /><i>名称不能超过50个字符</i>
				</li>
				<li><label><fmt:message key="position.type" />:</label><input id="ccl"
					name="type" type="text" style="width: 345px; height: 32px;"
					" class="easyui-combobox"
					data-options="
						required:false,
						valueField:'value',
						textField:'name',
						url:'${ctx}/${frameworkPath}/item/POSITION_TYPE/sub2',
						method:'get',
						onSelect: function(rec){
							if(rec.value==1){
								$('#org').combo('enable');
								$('#positionLevels').combo('disable');
							}
							else if(rec.value==2){
								$('#org').combo('disable');
								$('#positionLevels').combo('enable');
							}
							else if(rec.value==0){
								$('#org').combo('disable');
								$('#positionLevels').combo('disable');
							}
						}" />
				</li>
				<li><label><fmt:message key="position.description" />：</label> <input
					name="description" type="text" style="width: 345px; height: 80px;"
					" class="easyui-textbox"
					data-options="required:false,multiline:true" /><i>岗位描述不能超过200个字符</i>
				</li>
				<li><label><fmt:message key="column.order" />:</label><input name="order" type="text"
						style="width: 345px; height: 32px;" " class="easyui-numberbox"
						data-options="required:false" /><i>数据库排序的字段</i>
				</li>
				<li><label><fmt:message key="position.org" />:</label><select id="org" name="checkedOrgs" type="text"
						style="width: 345px; height: 32px;" " class="easyui-combotree"
						data-options="url:'${ctx}/${frameworkPath}/position/org',method:'get',disabled:true" multiple /><i>所选组织机构</i>
				</li>
				<li><label><fmt:message key="position.level" />:</label><input id="positionLevels" name="positionLevel" type="text"
						style="width: 345px; height: 32px;" " class="easyui-combotree"
						data-options="url:'${ctx}/${frameworkPath}/positionlevel/get2',method:'get',
							disabled:true,multiple:true,valueField:'id',textField:'text'" /><i>所选岗位级别，可多选</i>
				</li>
			</ul>
		</form>
		<div style="text-align: center; padding: 5px">
			<a href="javascript:void(0)" class="easyui-linkbutton"
				style="width:137px;height:35px; background:url(${ctx}/third-lib/savior/images/btnbg.png) no-repeat; font-size:14px;font-weight:bold;color:#fff; cursor:pointer;"
				onclick="submitForm()">保存数据</a> <a href="javascript:void(0)"
				style="width:137px;height:35px; background:url(${ctx}/third-lib/savior/images/btnbg.png) no-repeat; font-size:14px;font-weight:bold;color:#fff; cursor:pointer;"
				class="easyui-linkbutton" onclick="clearForm()">清除数据</a>
		</div>
	</div>
	<script type="text/javascript">
		function submitForm() {
			$('#ff_position_create').ajaxSubmit({
								type : 'post',
								url : "${ctx}/${frameworkPath}/position/create",
								traditional:true,
								success : function(data) {
									if (data.success) {
										$('#window_create').window('close');
										$("#dg").datagrid('reload');
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
		};
	</script>
</body>
</html>