package cn.nfschina.zhhw.dao;

import java.util.List;

import cn.nfschina.zhhw.model.TruckInfo;

public interface TruckManageDao {

	List<TruckInfo> getAllTruck(TruckInfo truckInfo);

	String getOrgName(TruckInfo truckInfo);

	void addTruck(TruckInfo truckInfo);

	void updTruck(TruckInfo truckInfo);

	void delTruck(TruckInfo truckInfo);

	String getDevName(TruckInfo truckInfo);
	
	List<TruckInfo> getTruckById(String ids);
}
