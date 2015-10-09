package cn.nfschina.zhhw.dao.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import cn.nfschina.zhhw.dao.BaseDao;
import cn.nfschina.zhhw.dao.InfoManageDao;
import cn.nfschina.zhhw.model.DeviceInfo;
import cn.nfschina.zhhw.model.GasInfo;
import cn.nfschina.zhhw.model.HitchInfo;
import cn.nfschina.zhhw.model.Org;
import cn.nfschina.zhhw.model.TruckInfo;

@Repository
public class InfoManageDaoImpl extends BaseDao implements InfoManageDao{

	@Override
	public List<TruckInfo> getAllVehicle() {
		return this.getSqlMapClientTemplate().queryForList("getAllTruckInfo");
	}

	@Override
	public List<GasInfo> getAllGas() {
		return this.getSqlMapClientTemplate().queryForList("getAllGasInfo");
	}

	@Override
	public List<HitchInfo> getAllHitchInfo() {
		// TODO Auto-generated method stub
		return this.getSqlMapClientTemplate().queryForList("getAllHitchInfo");
	}

	@Override
	public List<DeviceInfo> getAllDeviceInfo() {
		// TODO Auto-generated method stub
		return this.getSqlMapClientTemplate().queryForList("getAllDeviceInfo");
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
	public void addGas(GasInfo gasInfo) {
		// TODO Auto-generated method stub
		this.getSqlMapClientTemplate().insert("addGas",gasInfo);
	}

	@Override
	public void addDevice(DeviceInfo deviceInfo) {
		this.getSqlMapClientTemplate().insert("addDevice",deviceInfo);
	}

	@Override
	public void updDevice(DeviceInfo deviceInfo) {
		// TODO Auto-generated method stub
		this.getSqlMapClientTemplate().update("updateDevice",deviceInfo);
	}

	@Override
	public void delDevice(DeviceInfo deviceInfo) {
		// TODO Auto-generated method stub
		this.getSqlMapClientTemplate().delete("deleteDevice",deviceInfo);
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
	/**
	 * 通过id得到车辆
	 * create by sholinxing
	 * create time 2015/9/10
	 * 
	 */
	@Override
	public TruckInfo getTruckById(String id) {
		// TODO Auto-generated method stub
		
		TruckInfo car = (TruckInfo)this.getSqlMapClientTemplate().queryForObject("gettruckbyid",id);
		
		return car;
	}
	/**
	 * 通过orgid得到车辆
	 * @param orgId
	 * @return
	 * @author shaolinxing
	 * @time 2015年9月14日 下午7:00:26 
	 * @return List<TruckInfo>
	 */
	@Override
	public List<TruckInfo> getCarsByOrg(String orgId) {
		// TODO Auto-generated method stub
		
		List<TruckInfo> list = this.getSqlMapClientTemplate().queryForList("gettruckbyorg",orgId);
		
		return list;
	}

	@Override
	public List<String> getTruckComname(TruckInfo truckInfo) {
		return this.getSqlMapClientTemplate().queryForList("getTruckComname",truckInfo);
	}

	@Override
	public String getOrgName(TruckInfo truckInfo) {
		// TODO Auto-generated method stub
		return (String) this.getSqlMapClientTemplate().queryForObject("getOrgName",truckInfo);
	}

	@Override
	public Org getOrg(TruckInfo truckInfo) {
		// TODO Auto-generated method stub
		return (Org) this.getSqlMapClientTemplate().queryForObject("getOrg",truckInfo);
	}

}
