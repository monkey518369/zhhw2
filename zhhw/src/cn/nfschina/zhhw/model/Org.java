package cn.nfschina.zhhw.model;

import java.util.Date;
import java.util.Set;

/**
 * @Description: 机构层级关系
 * copyright nfschina
 * Org.java
 * create on 2015年9月8日 下午1:37:26
 * @author wcy
 */
public class Org {
	private String org_id;
	private String org_name;
	private String parent_org_id;
	private String org_description;
	private String org_tel;
	private String org_address;
	private String org_contact;
	private String org_path;
	private String org_level;
	private Integer org_enabled;
	private String org_type;
	private String org_property;
	private Integer org_order;
	private Integer org_version;
	private String org_creator;
	private Date org_created;
	private String org_modifier;
	private Date org_modified;
	//存储下级单位
	private Set<Org> children;
	public Org() {
		super();
	}
	
	public Org(String org_id, String org_name, String parent_org_id,
			String org_description, String org_tel, String org_address,
			String org_contact, String org_path, String org_level,
			Integer org_enabled, String org_type, String org_property,
			Integer org_order, Integer org_version, String org_creator,
			Date org_created, String org_modifier, Date org_modified,
			Set<Org> children) {
		super();
		this.org_id = org_id;
		this.org_name = org_name;
		this.parent_org_id = parent_org_id;
		this.org_description = org_description;
		this.org_tel = org_tel;
		this.org_address = org_address;
		this.org_contact = org_contact;
		this.org_path = org_path;
		this.org_level = org_level;
		this.org_enabled = org_enabled;
		this.org_type = org_type;
		this.org_property = org_property;
		this.org_order = org_order;
		this.org_version = org_version;
		this.org_creator = org_creator;
		this.org_created = org_created;
		this.org_modifier = org_modifier;
		this.org_modified = org_modified;
		this.children = children;
	}



	public String getOrg_id() {
		return org_id;
	}
	public void setOrg_id(String org_id) {
		this.org_id = org_id;
	}
	public String getOrg_name() {
		return org_name;
	}
	public void setOrg_name(String org_name) {
		this.org_name = org_name;
	}
	public String getParent_org_id() {
		return parent_org_id;
	}
	public void setParent_org_id(String parent_org_id) {
		this.parent_org_id = parent_org_id;
	}
	public String getOrg_description() {
		return org_description;
	}
	public void setOrg_description(String org_description) {
		this.org_description = org_description;
	}
	public String getOrg_tel() {
		return org_tel;
	}
	public void setOrg_tel(String org_tel) {
		this.org_tel = org_tel;
	}
	public String getOrg_address() {
		return org_address;
	}
	public void setOrg_address(String org_address) {
		this.org_address = org_address;
	}
	public String getOrg_contact() {
		return org_contact;
	}
	public void setOrg_contact(String org_contact) {
		this.org_contact = org_contact;
	}
	public String getOrg_path() {
		return org_path;
	}
	public void setOrg_path(String org_path) {
		this.org_path = org_path;
	}
	public String getOrg_level() {
		return org_level;
	}
	public void setOrg_level(String org_level) {
		this.org_level = org_level;
	}
	public Integer getOrg_enabled() {
		return org_enabled;
	}
	public void setOrg_enabled(Integer org_enabled) {
		this.org_enabled = org_enabled;
	}
	public String getOrg_type() {
		return org_type;
	}
	public void setOrg_type(String org_type) {
		this.org_type = org_type;
	}
	public String getOrg_property() {
		return org_property;
	}
	public void setOrg_property(String org_property) {
		this.org_property = org_property;
	}
	public Integer getOrg_order() {
		return org_order;
	}
	public void setOrg_order(Integer org_order) {
		this.org_order = org_order;
	}
	public Integer getOrg_version() {
		return org_version;
	}
	public void setOrg_version(Integer org_version) {
		this.org_version = org_version;
	}
	public String getOrg_creator() {
		return org_creator;
	}
	public void setOrg_creator(String org_creator) {
		this.org_creator = org_creator;
	}
	public Date getOrg_created() {
		return org_created;
	}
	public void setOrg_created(Date org_created) {
		this.org_created = org_created;
	}
	public String getOrg_modifier() {
		return org_modifier;
	}
	public void setOrg_modifier(String org_modifier) {
		this.org_modifier = org_modifier;
	}
	public Date getOrg_modified() {
		return org_modified;
	}
	public void setOrg_modified(Date org_modified) {
		this.org_modified = org_modified;
	}

	public Set<Org> getChildren() {
		return children;
	}

	public void setChildren(Set<Org> children) {
		this.children = children;
	}

}
