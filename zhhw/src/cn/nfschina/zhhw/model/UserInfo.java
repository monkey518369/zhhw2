package cn.nfschina.zhhw.model;

import java.util.Date;
import java.util.Set;

import com.gph.saviorframework.common.model.Org;
import com.gph.saviorframework.common.model.Position;
import com.gph.saviorframework.common.model.Role;
import com.gph.saviorframework.common.model.User;

public class UserInfo {
	
	/**
	 * 用户名.主键
	 */
	private String username;

	/**
	 * 姓名
	 */
	private String name;

	/**
	 * 描述
	 */
	private String description;

	/**
	 * 密码
	 */
	private String password;

	/**
	 * 邮件
	 */
	private String email;

	/**
	 * 性别
	 */
	private String gender;

	/**
	 * 身份证号
	 */
	private String identity;

	/**
	 * 地址
	 */
	private String address;

	/**
	 * 邮编
	 */
	private String post;

	/**
	 * 电话
	 */
	private String tel;

	/**
	 * 手机
	 */
	private String mobile;

	/**
	 * 生日
	 */
	private Date birthday;

	/**
	 * 启用
	 */
	private boolean enabled;

	/**
	 * 帐户未过期
	 */
	private boolean accountNonExpired;

	/**
	 * 帐户未锁定
	 */
	private boolean accountNonLocked;

	/**
	 * 凭证未过期
	 */
	private boolean credentialsNonExpired;

	/**
	 * 所属机构
	 */
	private Org org;

	/**
	 * 岗位
	 */
	private Position position;
	
	/**
	 * 头像
	 */
	private byte[] ext;

	/**
	 * 关联的角色
	 */
	private Set<Role> roles;

	/**
	 * 次序
	 */
	private Integer order;

	/**
	 * 创建者
	 */
	private User creator;

	/**
	 * 创建时间
	 */
	private Date created;

	/**
	 * 最后修改者
	 */
	private User modifier;

	/**
	 * 最后修改时间
	 */
	private Date modified;

	/**
	 * 乐观锁
	 */
	private Integer version;

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getIdentity() {
		return identity;
	}

	public void setIdentity(String identity) {
		this.identity = identity;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPost() {
		return post;
	}

	public void setPost(String post) {
		this.post = post;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public Date getBirthday() {
		return birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	public boolean isEnabled() {
		return enabled;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}

	public boolean isAccountNonExpired() {
		return accountNonExpired;
	}

	public void setAccountNonExpired(boolean accountNonExpired) {
		this.accountNonExpired = accountNonExpired;
	}

	public boolean isAccountNonLocked() {
		return accountNonLocked;
	}

	public void setAccountNonLocked(boolean accountNonLocked) {
		this.accountNonLocked = accountNonLocked;
	}

	public boolean isCredentialsNonExpired() {
		return credentialsNonExpired;
	}

	public void setCredentialsNonExpired(boolean credentialsNonExpired) {
		this.credentialsNonExpired = credentialsNonExpired;
	}

	public Org getOrg() {
		return org;
	}

	public void setOrg(Org org) {
		this.org = org;
	}

	public Position getPosition() {
		return position;
	}

	public void setPosition(Position position) {
		this.position = position;
	}

	public byte[] getExt() {
		return ext;
	}

	public void setExt(byte[] ext) {
		this.ext = ext;
	}

	public Set<Role> getRoles() {
		return roles;
	}

	public void setRoles(Set<Role> roles) {
		this.roles = roles;
	}

	public Integer getOrder() {
		return order;
	}

	public void setOrder(Integer order) {
		this.order = order;
	}

	public User getCreator() {
		return creator;
	}

	public void setCreator(User creator) {
		this.creator = creator;
	}

	public Date getCreated() {
		return created;
	}

	public void setCreated(Date created) {
		this.created = created;
	}

	public User getModifier() {
		return modifier;
	}

	public void setModifier(User modifier) {
		this.modifier = modifier;
	}

	public Date getModified() {
		return modified;
	}

	public void setModified(Date modified) {
		this.modified = modified;
	}

	public Integer getVersion() {
		return version;
	}

	public void setVersion(Integer version) {
		this.version = version;
	}
	
	
}
