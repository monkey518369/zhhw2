package org.springframework.security.web.authentication.logout;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.security.authentication.event.SaviorframeworkLogoutEvent;
import org.springframework.security.core.Authentication;

/**
 * 
 */
public class SaviorframeworkLogoutEventHandler implements LogoutHandler, ApplicationContextAware {

	private ApplicationContext applicationContext;

	final Logger logger = LoggerFactory.getLogger(SaviorframeworkLogoutEventHandler.class);

	/**
	 * @param request
	 * @param response
	 * @param authentication
	 * @see org.springframework.security.web.authentication.logout.LogoutHandler#logout(javax.servlet.http.HttpServletRequest,
	 *      javax.servlet.http.HttpServletResponse, org.springframework.security.core.Authentication)
	 */
	@Override
	public void logout(HttpServletRequest request, HttpServletResponse response, Authentication authentication) {
		if (authentication != null) {
			applicationContext.publishEvent(new SaviorframeworkLogoutEvent(authentication));
		}

	}

	/**
	 * @param applicationContext
	 * @throws BeansException
	 * @see org.springframework.context.ApplicationContextAware#setApplicationContext(org.springframework.context.ApplicationContext)
	 */
	@Override
	public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
		this.applicationContext = applicationContext;

	}

}
