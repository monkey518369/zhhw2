package cn.nfschina.zhhw.dao.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import cn.nfschina.zhhw.dao.BaseDao;
import cn.nfschina.zhhw.dao.HitchManageDao;
import cn.nfschina.zhhw.model.HitchInfo;

@Repository
public class HitchManageDaoImpl extends BaseDao implements HitchManageDao{
	
	@Override
	public List<HitchInfo> getAllHitch(HitchInfo hitchInfo) {
		// TODO Auto-generated method stub
		return this.getSqlMapClientTemplate().queryForList("getAllHitchInfo",hitchInfo);
	}
	
	@Override
	public void addHitch(HitchInfo hitchInfo) {
		// TODO Auto-generated method stub
		this.getSqlMapClientTemplate().insert("addHitch",hitchInfo);
	}

	@Override
	public void updHitch(HitchInfo hitchInfo) {
		// TODO Auto-generated method stub
		this.getSqlMapClientTemplate().update("updateHitch",hitchInfo);
	}

	@Override
	public void delHitch(HitchInfo hitchInfo) {
		// TODO Auto-generated method stub
		this.getSqlMapClientTemplate().delete("deleteHitch",hitchInfo);
	}

	@Override
	public String getPlateNo(HitchInfo hitchInfo) {
		// TODO Auto-generated method stub
		return (String) this.getSqlMapClientTemplate().queryForObject("getPlateNo",hitchInfo);
	}
}
