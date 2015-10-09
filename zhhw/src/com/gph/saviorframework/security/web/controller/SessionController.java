package com.gph.saviorframework.security.web.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.gph.saviorframework.SaviorFrameworkException;

/**
 * 
 */
@Controller
public class SessionController {

	@RequestMapping(value = "/invalid-session", method = RequestMethod.GET)
	public String invalidSession(HttpServletRequest request, HttpServletResponse response) throws SaviorFrameworkException {
		response.addHeader("session_timeout", "true");
		return "common/invalid-session";
	}
}
