package cn.nfschina.zhhw.dao.impl;

import java.util.Arrays;
import java.util.List;

import org.springframework.stereotype.Repository;

import cn.nfschina.zhhw.dao.BaseDao;
import cn.nfschina.zhhw.dao.TruckManageDao;
import cn.nfschina.zhhw.model.TruckInfo;

@Repository
public class TruckManageDaoImpl extends BaseDao implements TruckManageDao{
	
	@Override
	public List<TruckInfo> getAllTruck(TruckInfo truckInfo) {
		return this.getSqlMapClientTemplate().queryForList("getAllTruckInfo",truckInfo);
	}
	
	@Override
	public void addTruck(TruckInfo truckInfo) {
		// TODO Auto-generated method stub
		this.getSqlMapClientTemplate().insert("addTruck",truckInfo);
	}

	@Override
	public void delTruck(TruckInfo truckInfo) {
		// TODO Auto-generated method stub
		this.getSqlMapClientTemplate().delete("deleteTruck",truckInfo);
	}

	@Override
	public void updTruck(TruckInfo truckInfo) {
		// TODO Auto-generated method stub
		this.getSqlMapClientTemplate().update("updateTruck",truckInfo);
	}
	
	@Override
	public String getOrgName(TruckInfo truckInfo) {
		// TODO Auto-generated method stub
		return (String) this.getSqlMapClientTemplate().queryForObject("getOrgName",truckInfo);
	}

	@Override
	public String getDevName(TruckInfo truckInfo) {
		// TODO Auto-generated method stub
		return (String) this.getSqlMapClientTemplate().queryForObject("getDevName",truckInfo);
	}

	@Override
	public List<TruckInfo> getTruckById(String ids) {
		List<String> list = Arrays.asList(ids.split(","));
		return this.getSqlMapClientTemplate().queryForList("getTruckById",list);
	}
}
