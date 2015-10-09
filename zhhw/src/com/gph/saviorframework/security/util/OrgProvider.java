package com.gph.saviorframework.security.util;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.gph.saviorframework.SaviorFrameworkException;
import com.gph.saviorframework.common.model.Org;
import com.gph.saviorframework.common.model.Permission;
import com.gph.saviorframework.security.service.OrgService;

@Component
public class OrgProvider {

	@Autowired
	private OrgService orgService;

	/** 用户会话对象 */
	@Autowired
	private UserSession userSession;

	@Autowired
	private PermissionProvider permissionProvider;

	/**
	 * 根据功能ID查询当前登录用户已被分配的机构列表.
	 * 
	 * @param functionId 功能ID
	 * @return
	 * @throws SaviorFrameworkException
	 */
	public List<Org> getOrgByPermission(String functionId) throws SaviorFrameworkException {
		List<Org> orgs = new ArrayList<Org>();
		Set<Permission> permissions = permissionProvider.getOrgPermissionByFunction(functionId);
		for (Permission permission : permissions) {
			if (permission.getOrgType().equals(Permission.ORG_TYPE_CREATOR_ORG)) {
				orgs.add(userSession.getUser().getOrg());
			} else if (permission.getOrgType().equals(Permission.ORG_TYPE_CREATOR_ORG_UP)) {
				orgs.addAll(orgService.findLowerEntity(userSession.getUser().getOrg().getPath()));
			} else if (permission.getOrgType().equals(Permission.ORG_TYPE_CREATOR_ORG_DOWN)) {
				orgs.addAll(orgService.findHigherEntity(userSession.getUser().getOrg().getPath()));
			}
		}
		return orgs;
	}

	/**
	 * 返回所有机构数据对象.
	 * 
	 * @return 机构数据对象集合
	 */
	public List<Org> getOrg() {
		return orgService.findAll();
	}

	/**
	 * 根据机构ID查询机构信息.
	 * 
	 * @param id
	 * @return
	 */
	public Org findOrgById(String id) {
		return (Org) orgService.get(id);
	}
}
