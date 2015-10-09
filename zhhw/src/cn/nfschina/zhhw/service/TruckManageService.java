package cn.nfschina.zhhw.service;

import java.util.List;

import org.springframework.stereotype.Service;

import cn.nfschina.zhhw.model.TruckInfo;

@Service
public interface TruckManageService {

	List<TruckInfo> getAllTruck(TruckInfo truckInfo);

	String getOrgName(TruckInfo truckInfo);

	void addTruck(TruckInfo truckInfo);

	void updTruck(TruckInfo truckInfo);

	void delTruck(TruckInfo truckInfo);

	String getDevName(TruckInfo truckInfo);
	
	List<TruckInfo> getTruckById(String ids);
}
