package com.gph.saviorframework.security.service;

import java.io.Serializable;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.encoding.Md5PasswordEncoder;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.gph.saviorframework.Constants;
import com.gph.saviorframework.FieldType;
import com.gph.saviorframework.common.model.Role;
import com.gph.saviorframework.common.model.TransferUser;
import com.gph.saviorframework.common.model.User;
import com.gph.saviorframework.security.util.SecurityUtils;


/**
 * 用户服务接口.
 * 
 */
@Repository
public class UserService {

	/** 日志输出 */
	final Logger logger = LoggerFactory.getLogger(UserService.class);

	/** 查询参数信息.[字段-类型] */
	public Map<String, String> fields = new HashMap<String, String>();

	/**
	 * HIBERNATE Session Factory.
	 */
	@Autowired
	private SessionFactory sessionFactory;

	@Autowired
	private SecurityUtils securityUtils;

	@Autowired
	private Md5PasswordEncoder passwordEncoder;

	public Session getSession() {
		return sessionFactory.getCurrentSession();
	}

	/**
	 * 构造方法.初始化查询参数.
	 */
	public UserService() {
		fields.put("username", FieldType.STRING);
		fields.put("name", FieldType.STRING);
		fields.put("email", FieldType.STRING);
		fields.put("birthday", FieldType.DATE);
		fields.put("tel", FieldType.STRING);
		fields.put("mobile", FieldType.STRING);
		fields.put("order", FieldType.INTEGER);
		fields.put("enabled", FieldType.BOOLEAN);
	}

	/**
	 * 保存.
	 * 
	 * @param user
	 */
	@Transactional
	public void save(User user) {
		getSession().save(user);
	}

	/**
	 * 更新.
	 * 
	 * @param user
	 */
	@Transactional
	public void update(User user) {
		getSession().update(user);
	}

	/**
	 * 批量保存.
	 * 
	 * @param users 用户对象集合
	 */
	@Transactional
	public void save(Set<User> users) {
		for (User user : users) {
			getSession().save(user);
		}
	}

	/**
	 * 批量保存或者更新.
	 * 
	 * @param users 用户对象集合
	 */
	@Transactional
	public void saveOrUpdate(Set<User> users) {
		for (User user : users) {
			getSession().saveOrUpdate(user);
		}
	}

	/**
	 * 批量更新.
	 * 
	 * @param users 用户对象集合
	 */
	@Transactional
	public void update(Set<User> users) {
		for (User user : users) {
			getSession().update(user);
		}
	}

	/**
	 * 根据主键查询.
	 * 
	 * @param id 用户主键
	 * @return
	 */
	@Transactional(readOnly = true)
	public Object get(Serializable id) {
		return getSession().get(User.class, id);
	}

	/**
	 * 根据用户名查询.
	 * 
	 * @param username 用户名
	 * @return
	 */
	@Transactional(readOnly = true)
	public Object findByUsername(String username) {
		return getSession()
				.createQuery(
						"select new map(u.username as username, u.name as name, u.gender as gender, u.identity as identity, u.email as email, u.address as address, u.post as post, "
								+ "u.tel as tel, u.mobile as mobile, u.birthday as birthday, u.position.id as position, u.position.name as positionname, "
								+ "u.enabled as enabled, u.enabled as _enabled, u.accountNonExpired as accountNonExpired, u.accountNonLocked as accountNonLocked, "
								+ "u.credentialsNonExpired as credentialsNonExpired, u.org.id as org, u.org.name as orgName, u.order as order, u.version as version) "
								+ "from User u where u.username =? ").setString(0, username).uniqueResult();
	}

	/**
	 * 删除.
	 * 
	 * @param user 用户对象
	 */
	@Transactional
	public void delete(User user) {
		getSession().delete(user);
	}

	/**
	 * 根据用户名删除.
	 * 
	 * @param username 用户名
	 */
	private void deleteByUsername(String username) {
		getSession().createQuery("delete from User u where u.username=?").setString(0, username).executeUpdate();
	}

	/**
	 * 根据用户名批量删除.
	 * 
	 * @param usernames 用户名数组
	 */
	@Transactional
	public void deleteByUsernames(String[] usernames) {
		for (String username : usernames) {
			deleteByUsername(username);
		}
	}

	/**
	 * 根据分页、排序和其他条件查询记录.
	 * 
	 * @param org 组织机构ID
	 * @param start 起始记录行数
	 * @param limit 查询记录数量
	 * @param sort 排序字段
	 * @param dir 排序方向
	 * @param params 查询参数
	 * @return
	 */
	@Transactional(readOnly = true)
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> find(String org, Integer start, Integer limit, String sort, String dir, Map<String, Object> params) {
		Query query = null;
		String hql = "select new map(u.username as username,u.username as usernamerole, u.name as name, u.gender as gender, u.identity as identity, u.email as email, u.address as address, u.post as post, u.tel as tel, u.birthday as birthday, u.position.id as position, u.position.name as positionname, u.ext as ext, u.enabled as enabled, u.org.id as org, u.org.name as orgname, u.order as order,"
				+ "u.creator.name as creator,u.created as created,u.modifier.name as modifier,u.modified as modified) "
				+ "from User u left join u.creator left join u.modifier where 1=1 ";
		if (params.keySet().size() > 0) {
			for (String key : params.keySet()) {
				if (fields.get(key).equals(FieldType.STRING)) {
					hql += " and u." + key + " like :" + key;
				} else {
					hql += " and u." + key + " = :" + key;
				}
			}
		}
		String orderBy = " order by u." + sort + " " + dir;
		if (org.isEmpty()) {
			hql += " and u.org.path like :path ";
			query = getSession().createQuery(hql + orderBy).setString("path", "%" + securityUtils.getUser().getOrg().getId() + "%");
		} else {
			hql += " and u.org.id=:org";
			query = getSession().createQuery(hql + orderBy).setString("org", org);
		}

		if (params.keySet().size() > 0) {
			query.setProperties(params);
		}
		return query.setFirstResult(start).setMaxResults(limit).list();

	}

	/**
	 * 根据参数查询记录数量.
	 * 
	 * @param org 组织机构ID
	 * @param params 查询参数
	 * @return
	 */
	@Transactional(readOnly = true)
	public Long count(String org, Map<String, Object> params) {
		Query query = null;
		String hql = "select count(*) from User where 1=1 ";
		if (params.keySet().size() > 0) {
			for (String key : params.keySet()) {
				if (fields.get(key).equals(FieldType.STRING)) {
					hql += " and " + key + " like :" + key;
				} else {
					hql += " and " + key + " = :" + key;
				}
			}
		}
		if (org.isEmpty()) {
			hql += " and org.path like :path ";
			query = getSession().createQuery(hql).setString("path", "%" + securityUtils.getUser().getOrg().getId() + "%");
		} else {
			hql += " and org.id=:org";
			query = getSession().createQuery(hql).setString("org", org);
		}

		if (params.keySet().size() > 0) {
			query.setProperties(params);
		}
		return Long.valueOf(query.uniqueResult().toString());
	}

	/**
	 * 保存用户与角色的关联关系.
	 * 
	 * @param ids 角色ID数组
	 * @param username 用户名
	 */
	@Transactional
	public void saveUserRole(String[] ids, String username) {
		Object user = getSession().get(User.class, username);
		if (null != user) {
			((User) user).clearRole();
			for (String id : ids) {
				Object role = getSession().get(Role.class, id);
				if (role != null) {
					((User) user).addRole((Role) role);
				}
			}
			getSession().update(user);
		}

	}

	/**
	 * 根据用户名查询用户及其角色与资源信息.
	 * 
	 * @param username 用户名
	 * @return
	 */
	@Transactional(readOnly = true)
	public User loadByUsername(String username) {
		return (User) getSession()
				.createQuery(
						"select u from User u left join fetch u.roles r left join fetch r.functions left join fetch r.permissions "
								+ "where u.username=:username order by u.order asc").setString("username", username).uniqueResult();

	}

	/**
	 * 根据组织机构ID和角色ID查询用户,以树节点格式返回.角色关联用户功能中使用.
	 * 
	 * @param org 组织机构ID
	 * @param role 角色ID
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@Transactional(readOnly = true)
	public List<Map<String, Object>> findByOrgAndRole(String org, String role) {
		return getSession()
				.createQuery(
						"select new map(u.username as id, u.name as text,"
								+ "(case when (select count(*) from Role role inner join role.users user where role.id = :role and user.username = u.username )>0 then true else false end ) as checked) "
								+ "from User u inner join u.position.roles r where u.org.id=:org and r.id = :role").setString("role", role)
				.setString("org", org).list();

	}
	
	/**
	 * 根据组织机构ID和角色ID查询用户,以树节点格式返回.角色关联用户功能中使用.
	 * 
	 * @param org 组织机构ID
	 * @param role 角色ID
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@Transactional(readOnly = true)
	public List<Map<String, Object>> findByOrgAndRole2(String org, String role) {
		return getSession()
				.createQuery(
						"select new map(u.username as id, u.name as name,u.org.name as org,"
								+ "(case when (select count(*) from Role role inner join role.users user where role.id = :role and user.username = u.username )>0 then true else false end ) as checked) "
								+ "from User u inner join u.position.roles r where u.org.id=:org and r.id = :role").setString("role", role)
				.setString("org", org).list();

	}

	/**
	 * 根据组织机构ID查询用户,以树节点格式返回. 选择用户组件中使用.
	 * 
	 * @param org 组织机构ID
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@Transactional(readOnly = true)
	public List<Map<String, Object>> findByOrg(String org) {
		return getSession()
				.createQuery("select new map(u.username as id, u.name as text, 1 as leaf, u.username as qtip) from User u where u.org.id=:org")
				.setString("org", org).list();

	}

	@SuppressWarnings("unchecked")
	@Transactional(readOnly = true)
	public List<Map<String, Object>> findByOrgAndPermission(String orgId, String permissionId) {
		return getSession()
				.createQuery(
						"select new map(u.username as id, u.name as text, 1 as leaf, u.username as qtip,'node-user' as iconCls,"
								+ "(case when (select count(*) from Permission p inner join p.associatedUsers user where p.id = :permissionId and user.username = u.username )>0 then true else false end ) as checked) "
								+ "from User u where u.org.id=:orgId").setString("permissionId", permissionId).setString("orgId", orgId).list();

	}

	@Transactional
	public void saveTransferUser(TransferUser user) {
		user.setPassword(passwordEncoder.encodePassword(Constants.DEFAULT_PASSWORD, ""));
		Date date = new Date();
		getSession()
				.createSQLQuery(
						"insert into SF_USER(USER_ID,ORG_ID,USER_NAME,USER_PASSWORD,USER_ENABLED,"
								+ "USER_ACCOUNT_NONEXPIRED,USER_ACCOUNT_NONLOCKED,USER_CREDENTIALS_NONEXPIRED,USER_VERSION,"
								+ "USER_CREATOR,USER_CREATED,USER_MODIFIER,USER_MODIFIED) values(?,?,?,?,?,?,?,?,?,?,?,?,?)")
				.setString(0, user.getUsername()).setString(1, user.getOrg()).setString(2, user.getName()).setString(3, user.getPassword())
				.setBoolean(4, user.isEnabled()).setBoolean(5, true).setBoolean(6, true).setBoolean(7, true).setInteger(8, 0).setString(9, "admin")
				.setDate(10, date).setString(11, "admin").setDate(12, date).executeUpdate();
	}

	@Transactional
	public void updateTransferUser(TransferUser user) {
		Date date = new Date();
		getSession().createSQLQuery("update SF_USER set ORG_ID=?,USER_NAME=?,USER_ENABLED=?,USER_MODIFIED=? where USER_ID=?")
				.setString(0, user.getOrg()).setString(1, user.getName()).setBoolean(2, user.isEnabled()).setDate(3, date)
				.setString(4, user.getUsername()).executeUpdate();
	}
}
