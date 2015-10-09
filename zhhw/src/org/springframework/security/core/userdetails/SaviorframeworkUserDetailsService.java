package org.springframework.security.core.userdetails;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.dao.DataAccessException;

import com.gph.saviorframework.security.service.UserService;
import com.gph.saviorframework.common.model.User;

public class SaviorframeworkUserDetailsService implements UserDetailsService {

	@Autowired
	private UserService userService;

	@Autowired
	private MessageSourceAccessor messages;

	/**
	 * 
	 * @param username
	 * @return
	 * @throws UsernameNotFoundException
	 * @throws DataAccessException
	 * @see org.springframework.security.core.userdetails.UserDetailsService#loadUserByUsername(java.lang.String)
	 */
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException, DataAccessException {
		User user = userService.loadByUsername(username);
		if (user == null) {
			throw new UsernameNotFoundException(messages.getMessage("user.not.found", new Object[] { username }), username);
		}
		return user;
	}

}
