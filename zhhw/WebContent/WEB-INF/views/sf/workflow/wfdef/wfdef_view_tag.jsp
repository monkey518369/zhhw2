<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/include/taglibs.jsp"%>
<%@taglib prefix="fwf" uri="/saviorWorkflow-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>流程预览</title>
    <fwf:FHead></fwf:FHead> 
  </head>
  <body>
  	<fwf:FModel id="myModel" defId="${param.processId}" ></fwf:FModel>
  </body>
</html>