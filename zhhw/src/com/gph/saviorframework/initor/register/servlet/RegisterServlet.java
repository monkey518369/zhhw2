package com.gph.saviorframework.initor.register.servlet;

import java.io.IOException;
import java.util.Properties;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gph.saviorframework.util.PropertiesUtils;

public class RegisterServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
       
    public RegisterServlet() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String sourceCode = request.getParameter("sourcecode");
			String regCode = request.getParameter("regcode");
			
			PropertiesUtils pu = new PropertiesUtils();
			Properties globalConfig = pu.loadProperty("com/gph/saviorframework/initor/config/initor.properties");
			String registerConfigPath = globalConfig.getProperty("register.properties.path");
			
			Properties registerConfig = pu.loadProperty(registerConfigPath);
			registerConfig.setProperty("source", sourceCode);
			registerConfig.setProperty("reg", regCode);
			pu.saveProperty(registerConfigPath, registerConfig);
			
			response.getWriter().print("{'success':true}");
		} 
		catch (Exception e) {
			e.printStackTrace();
			response.getWriter().print("{'success':false}");
		}
	}
}
