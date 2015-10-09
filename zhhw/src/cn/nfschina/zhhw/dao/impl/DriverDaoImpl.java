package cn.nfschina.zhhw.dao.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import cn.nfschina.zhhw.dao.BaseDao;
import cn.nfschina.zhhw.dao.DriverDao;
import cn.nfschina.zhhw.model.DriverInfo;

@Repository
public class DriverDaoImpl extends BaseDao implements DriverDao{

	@Override
	public List<DriverInfo> getAllDriver() {
		// TODO Auto-generated method stub
		return this.getSqlMapClientTemplate().queryForList("getAllDriver");
	}

}
