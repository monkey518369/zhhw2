package cn.nfschina.zhhw.dao.impl;

import org.springframework.stereotype.Repository;

import cn.nfschina.zhhw.dao.BaseDao;
import cn.nfschina.zhhw.dao.OrgInfoDao;
import cn.nfschina.zhhw.model.Org;

@Repository
public class OrgInfoDaoImpl extends BaseDao implements OrgInfoDao{

	@Override
	public Org getOrgById(String orgId) {
		// TODO Auto-generated method stub
		Org org = (Org)this.getSqlMapClientTemplate().queryForObject("getorgbyid",orgId);
		return org;
	}

}
