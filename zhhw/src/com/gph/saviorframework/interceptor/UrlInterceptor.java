package com.gph.saviorframework.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class UrlInterceptor implements HandlerInterceptor {

	@Override
	public void afterCompletion(HttpServletRequest request,
			HttpServletResponse response, Object object, Exception exception)
			throws Exception {
		System.out.println("after");
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response,
			Object object, ModelAndView view) throws Exception {
		System.out.println("post");
		
		String path = request.getRequestURL()+"?"+request.getQueryString();
	}

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
			Object object) throws Exception {
		System.out.println("pre");
		return true;
	}

}
