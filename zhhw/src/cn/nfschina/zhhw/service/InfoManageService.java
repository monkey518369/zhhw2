package cn.nfschina.zhhw.service;

import java.util.List;

import org.springframework.stereotype.Service;

import cn.nfschina.zhhw.model.DeviceInfo;
import cn.nfschina.zhhw.model.GasInfo;
import cn.nfschina.zhhw.model.HitchInfo;
import cn.nfschina.zhhw.model.Org;
import cn.nfschina.zhhw.model.TruckInfo;

public interface InfoManageService {

	List<TruckInfo> getAllVehicle();
	
	List<TruckInfo> getCarsByOrg(String orgId);

	List<GasInfo> getAllGas();

	List<HitchInfo> getAllHitchInfo();

	List<DeviceInfo> getAllDeviceInfo();

	TruckInfo getTruckById(String id);
	
	void addTruck(TruckInfo truckInfo);

	void deleteTruck(TruckInfo truckInfo);

	void updateTruck(TruckInfo truckInfo);

	void addGas(GasInfo gasInfo);

	void addDevice(DeviceInfo deviceInfo);

	void updateDevice(DeviceInfo deviceInfo);

	void deleteDevice(DeviceInfo deviceInfo);

	void updateGas(GasInfo gasInfo);

	void deleteGas(GasInfo gasInfo);

	void addHitch(HitchInfo hitchInfo);

	void updateHitch(HitchInfo hitchInfo);

	void deleteHitch(HitchInfo hitchInfo);

	List<String> getTruckComname(TruckInfo truckInfo);

	String getOrgName(TruckInfo truckInfo);

	Org getOrg(TruckInfo truckInfo);
	
}
