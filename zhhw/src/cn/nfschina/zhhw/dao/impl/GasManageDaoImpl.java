package cn.nfschina.zhhw.dao.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import cn.nfschina.zhhw.dao.BaseDao;
import cn.nfschina.zhhw.dao.GasManageDao;
import cn.nfschina.zhhw.model.GasInfo;

@Repository
public class GasManageDaoImpl extends BaseDao implements GasManageDao {
	
	@Override
	public List<GasInfo> getAllGas(GasInfo gasInfo) {
		return this.getSqlMapClientTemplate().queryForList("getAllGasInfo",gasInfo);
	}
	
	@Override
	public void addGas(GasInfo gasInfo) {
		// TODO Auto-generated method stub
		this.getSqlMapClientTemplate().insert("addGas",gasInfo);
	}
	
	@Override
	public void updGas(GasInfo gasInfo) {
		// TODO Auto-generated method stub
		this.getSqlMapClientTemplate().update("updateGas",gasInfo);
	}
	
	@Override
	public void delGas(GasInfo gasInfo) {
		// TODO Auto-generated method stub
		this.getSqlMapClientTemplate().delete("deleteGas",gasInfo);
	}

	@Override
	public String getPlateno(GasInfo gasInfo) {
		// TODO Auto-generated method stub
		return (String) this.getSqlMapClientTemplate().queryForObject("getPlateno",gasInfo);
	}

	@Override
	public String getDriverName(GasInfo gasInfo) {
		// TODO Auto-generated method stub
		return (String) this.getSqlMapClientTemplate().queryForObject("getDriverName",gasInfo);
	}

	@Override
	public String getUserName(GasInfo gasInfo) {
		// TODO Auto-generated method stub
		return (String) this.getSqlMapClientTemplate().queryForObject("getUserName",gasInfo);
	}

	//====================================================shaolinxing start========================
	
	//查询某一时间段内的油耗信息
	@Override
	public List<GasInfo> getGasByTimePart(Date startTime, Date endTime,String carId) {
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("carId", carId);
		map.put("startTime", startTime);
		map.put("endTime", endTime);
		
		@SuppressWarnings("unchecked")
		List<GasInfo> list = this.getSqlMapClientTemplate().queryForList("getGasByTimePart",map);
		
		return list;
	}

	//====================================================shaolinxing end========================
}
