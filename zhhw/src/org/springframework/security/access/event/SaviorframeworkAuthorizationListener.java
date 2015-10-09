package org.springframework.security.access.event;

import java.util.Date;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.security.web.FilterInvocation;
import org.springframework.security.web.authentication.WebAuthenticationDetails;
import com.gph.saviorframework.common.model.User;

public class SaviorframeworkAuthorizationListener implements ApplicationListener<AbstractAuthorizationEvent> {

	private static final Log logger = LogFactory.getLog(SaviorframeworkAuthorizationListener.class);

	/**
	 * @param event
	 * @see org.springframework.context.ApplicationListener#onApplicationEvent(org.springframework.context.ApplicationEvent)
	 */
	@Override
	public void onApplicationEvent(AbstractAuthorizationEvent event) {
		if (event instanceof AuthorizedEvent) {
			String log = "";
			
			Object user = ((AuthorizedEvent) event).getAuthentication().getPrincipal();
			if (user instanceof User) {
				log += ((User) user).getName();
				log += "|" + ((User) user).getUsername();
			}
			Object details = ((AuthorizedEvent) event).getAuthentication().getDetails();
			if (details instanceof WebAuthenticationDetails) {
				log += "|" + ((WebAuthenticationDetails) details).getRemoteAddress();
			}
			log = "[" + log + "]" + " 访问 ";
			Object source = ((AuthorizedEvent) event).getSource();
			if (source instanceof FilterInvocation) {
				log += ((FilterInvocation) source).getFullRequestUrl();
			}

			logger.info(log);
		}
	}

}
