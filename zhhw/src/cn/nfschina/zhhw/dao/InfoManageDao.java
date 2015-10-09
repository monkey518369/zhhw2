package cn.nfschina.zhhw.dao;

import java.util.List;

import cn.nfschina.zhhw.model.DeviceInfo;
import cn.nfschina.zhhw.model.GasInfo;
import cn.nfschina.zhhw.model.HitchInfo;
import cn.nfschina.zhhw.model.Org;
import cn.nfschina.zhhw.model.TruckInfo;

public interface InfoManageDao {

	List<TruckInfo> getAllVehicle();
	
	List<TruckInfo> getCarsByOrg(String orgId);
	
	List<GasInfo> getAllGas();

	List<HitchInfo> getAllHitchInfo();

	List<DeviceInfo> getAllDeviceInfo();
	
	TruckInfo getTruckById(String id);
	
	void addTruck(TruckInfo truckInfo);

	void delTruck(TruckInfo truckInfo);

	void updTruck(TruckInfo truckInfo);

	void addGas(GasInfo gasInfo);

	void addDevice(DeviceInfo deviceInfo);

	void updDevice(DeviceInfo deviceInfo);

	void delDevice(DeviceInfo deviceInfo);

	void updGas(GasInfo gasInfo);

	void delGas(GasInfo gasInfo);

	void addHitch(HitchInfo hitchInfo);

	void updHitch(HitchInfo hitchInfo);

	void delHitch(HitchInfo hitchInfo);

	List<String> getTruckComname(TruckInfo truckInfo);

	String getOrgName(TruckInfo truckInfo);

	Org getOrg(TruckInfo truckInfo);
	
}
