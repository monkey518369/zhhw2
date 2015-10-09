package org.springframework.security.authentication.event;

import org.springframework.security.core.Authentication;

public class SaviorframeworkLogoutEvent extends AbstractAuthenticationEvent {
	private static final long serialVersionUID = 1L;

	public SaviorframeworkLogoutEvent(Authentication authentication) {
		super(authentication);
	}

}
