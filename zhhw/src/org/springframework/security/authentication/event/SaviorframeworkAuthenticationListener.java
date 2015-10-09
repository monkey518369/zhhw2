package org.springframework.security.authentication.event;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.context.ApplicationListener;
import org.springframework.security.web.authentication.WebAuthenticationDetails;

import com.gph.saviorframework.common.model.User;

public class SaviorframeworkAuthenticationListener implements ApplicationListener<AbstractAuthenticationEvent> {

	private static final Log logger = LogFactory.getLog(SaviorframeworkAuthenticationListener.class);

	/**
	 * @param event
	 * @see org.springframework.context.ApplicationListener#onApplicationEvent(org.springframework.context.ApplicationEvent)
	 */
	@Override
	public void onApplicationEvent(AbstractAuthenticationEvent event) {
		if (event instanceof InteractiveAuthenticationSuccessEvent) {
			String log = "";
			Object user = event.getAuthentication().getPrincipal();
			if (user instanceof User) {
				log += ((User) user).getName();
				log += "|" + ((User) user).getUsername();
			}
			Object details = event.getAuthentication().getDetails();
			if (details instanceof WebAuthenticationDetails) {
				log += "|" + ((WebAuthenticationDetails) details).getRemoteAddress();
			}
			log = "[" + log + "]" + " 登录. ";
			logger.info(log);
			return;
		}

		if (event instanceof SaviorframeworkLogoutEvent) {
			if (event.getAuthentication() != null) {
				String log = "";
				Object user = event.getAuthentication().getPrincipal();
				if (user instanceof User) {
					log += ((User) user).getName();
					log += "|" + ((User) user).getUsername();
				}
				Object details = event.getAuthentication().getDetails();
				if (details instanceof WebAuthenticationDetails) {
					log += "|" + ((WebAuthenticationDetails) details).getRemoteAddress();
				}
				log = "[" + log + "]" + " 注销.";
				logger.info(log);
			}
		}

	}
}
