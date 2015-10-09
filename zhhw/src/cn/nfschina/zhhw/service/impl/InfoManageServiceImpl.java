package cn.nfschina.zhhw.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cn.nfschina.zhhw.dao.InfoManageDao;
import cn.nfschina.zhhw.model.DeviceInfo;
import cn.nfschina.zhhw.model.GasInfo;
import cn.nfschina.zhhw.model.HitchInfo;
import cn.nfschina.zhhw.model.Org;
import cn.nfschina.zhhw.model.TruckInfo;
import cn.nfschina.zhhw.service.InfoManageService;

@Service
public class InfoManageServiceImpl implements InfoManageService{

	@Resource 
	private InfoManageDao infoManageDao;
	
	@Override
	public List<TruckInfo> getAllVehicle() {
		return infoManageDao.getAllVehicle();
	}

	@Override
	public List<GasInfo> getAllGas() {
		// TODO Auto-generated method stub
		return infoManageDao.getAllGas();
	}

	@Override
	public List<HitchInfo> getAllHitchInfo() {
		// TODO Auto-generated method stub
		return infoManageDao.getAllHitchInfo();
	}

	@Override
	public List<DeviceInfo> getAllDeviceInfo() {
		// TODO Auto-generated method stub
		return infoManageDao.getAllDeviceInfo();
	}

	@Override
	public void addTruck(TruckInfo truckInfo) {
		// TODO Auto-generated method stub
		 infoManageDao.addTruck(truckInfo);
	}

	@Override
	public void deleteTruck(TruckInfo truckInfo) {
		// TODO Auto-generated method stub
		infoManageDao.delTruck(truckInfo);
	}

	@Override
	public void updateTruck(TruckInfo truckInfo) {
		// TODO Auto-generated method stub
		infoManageDao.updTruck(truckInfo);
	}

	@Override
	public void addGas(GasInfo gasInfo) {
		// TODO Auto-generated method stub
		infoManageDao.addGas(gasInfo);
	}

	@Override
	public void addDevice(DeviceInfo deviceInfo) {
		// TODO Auto-generated method stub
		infoManageDao.addDevice(deviceInfo);
	}

	@Override
	public void updateDevice(DeviceInfo deviceInfo) {
		// TODO Auto-generated method stub
		infoManageDao.updDevice(deviceInfo);
	}

	@Override
	public void deleteDevice(DeviceInfo deviceInfo) {
		// TODO Auto-generated method stub
		infoManageDao.delDevice(deviceInfo);
	}

	@Override
	public void updateGas(GasInfo gasInfo) {
		// TODO Auto-generated method stub
		infoManageDao.updGas(gasInfo); 
	}

	@Override
	public void deleteGas(GasInfo gasInfo) {
		// TODO Auto-generated method stub
		infoManageDao.delGas(gasInfo);
	}

	@Override
	public void addHitch(HitchInfo hitchInfo) {
		// TODO Auto-generated method stub
		infoManageDao.addHitch(hitchInfo);
	}

	@Override
	public void updateHitch(HitchInfo hitchInfo) {
		// TODO Auto-generated method stub
		infoManageDao.updHitch(hitchInfo);
	}

	@Override
	public void deleteHitch(HitchInfo hitchInfo) {
		// TODO Auto-generated method stub
		infoManageDao.delHitch(hitchInfo);
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
		TruckInfo truckInfo = infoManageDao.getTruckById(id);
		return truckInfo;
	}
	/**
	 * 通过orgid得到车辆
	 * create by sholinxing
	 * create time 2015/9/10
	 * 
	 */
	@Override
	public List<TruckInfo> getCarsByOrg(String orgId) {
		// TODO Auto-generated method stub
		
		List<TruckInfo> truckInfos = infoManageDao.getCarsByOrg(orgId);
		
		return truckInfos;
	}

	@Override
	public List<String> getTruckComname(TruckInfo truckInfo) {
		List<String> comnameList = infoManageDao.getTruckComname(truckInfo);
		return comnameList;
	}

	@Override
	public Org getOrg(TruckInfo truckInfo) {
		return infoManageDao.getOrg(truckInfo);
	}

	@Override
	public String getOrgName(TruckInfo truckInfo) {
		// TODO Auto-generated method stub
		return infoManageDao.getOrgName(truckInfo);
	}

}
