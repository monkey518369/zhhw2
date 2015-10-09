package org.springframework.security.url;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;

public class UrlEntryPoint implements AuthenticationEntryPoint {

	@Override
	public void commence(HttpServletRequest request, HttpServletResponse response,
            AuthenticationException authException) throws IOException, ServletException {
		String targetUrl = null;
        String url = request.getRequestURI();
        
        if(url.indexOf("login")!=-1){
        	targetUrl = request.getContextPath()+"/login";
        }
        else{
        	targetUrl=request.getContextPath()+"/index";
        }
        
        response.sendRedirect(targetUrl);
	}

}
