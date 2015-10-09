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
	<div class="formbody">
    		<div class="formtitle"><span>组织机构基本信息</span></div>
    		<form id="ff_org_edit" method="post">
				<ul class="forminfo">
					<li><label>组织编号:</label><input name="id" type="text"
						style="width: 345px; height: 32px;" " class="easyui-textbox"
						data-options="required:true" /><i>标题不能超过30个字符</i>
					</li>
					<li><label>组织名称:</label><input name="name" type="text"
						style="width: 345px; height: 32px;" " class="easyui-textbox"
						data-options="required:true" /><i>名称不能超过50个字符</i>
					</li>
					<li><label>联系人:</label><input name="contact" type="text"
						style="width: 345px; height: 32px;" " class="easyui-textbox"
						data-options="required:false" />
					</li>
					<li><label>联系电话:</label><input name="tel" type="text"
						style="width: 345px; height: 32px;" " class="easyui-textbox"
						data-options="required:false" />
					</li>
					<li><label>联系地址:</label><input name="address" type="text"
						style="width: 345px; height: 32px;" " class="easyui-textbox"
						data-options="required:false" />
					</li>
					<li><label>组织排序:</label><input name="order" type="text"
						style="width: 345px; height: 32px;" " class="easyui-numberbox"
						data-options="required:false" /><i>数据库排序的字段</i>
					</li>
					<li><label>组织类别:</label><input name="category" type="text"
						style="width: 345px; height: 32px;" " class="easyui-combobox"
						data-options="required:false,valueField:'value',textField:'name',url:'${ctx}/${frameworkPath}/item/ORG_CATEGORY/sub2',method:'get'" />
					</li>
					<li><label>组织属性:</label><input name="property" type="text"
						style="width: 345px; height: 32px;" " class="easyui-combobox"
						data-options="required:false,valueField:'value',textField:'name',url:'${ctx}/${frameworkPath}/item/ORG_PROPERTY/sub2',method:'get'" />
					</li>
					<li><label>是否启用:</label>
						<input name="enabled" type="text"
						style="width: 345px; height: 32px;" " class="easyui-combobox"
						data-options="required:false,valueField:'value',textField:'name',url:'${ctx}/${frameworkPath}/item/COMMON_YESNO/sub2',method:'get'" />
					</li>
					<li><label>组织描述：</label>
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
		var row = $('#dg').datagrid('getSelected');
		$('#ff_org_edit').ajaxSubmit({
							type : 'post',
							url : "${ctx}/${frameworkPath}/org/edit/"+ row.id,
							success : function(data) {
								if (data.success) {
									$('#window_edit').window('close');
									$("#dg").datagrid('reload');
									$('#tt_org').tree("reload");
 									$.messager.alert('<fmt:message key="message.title" />',
													'<fmt:message key="message.save.successful" />',
													'info');
								}
							},
							error : function(XmlHttpRequest, textStatus,
									errorThrown) {
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