package com.gph.saviorframework.initor.util;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import com.gph.saviorframework.initor.config.AJAXConstant;

public class AjaxUtils {
	
	public static PrintWriter getAjaxRespnseWriter(HttpServletResponse response) throws IOException{
		response.setContentType(AJAXConstant.AJAX_RES_CONTENT_TYPE);
		response.setCharacterEncoding(AJAXConstant.AJAX_RES_C_ENCODING);
		response.setHeader(AJAXConstant.AJAX_RES_HEADER_CACHE, AJAXConstant.AJAX_RES_HEADER_CACHE$NO);
		
		return response.getWriter();
	}
}
