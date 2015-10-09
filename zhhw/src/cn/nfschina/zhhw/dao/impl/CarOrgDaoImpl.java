package cn.nfschina.zhhw.dao.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import cn.nfschina.zhhw.dao.BaseDao;
import cn.nfschina.zhhw.dao.CarOrgDao;
import cn.nfschina.zhhw.model.Org;

@Repository
public class CarOrgDaoImpl extends BaseDao implements CarOrgDao{

	@SuppressWarnings("unchecked")
	@Override
	public List<Org> getAllOrg() {
		return this.getSqlMapClientTemplate().queryForList("getAllOrg");
	}

}
