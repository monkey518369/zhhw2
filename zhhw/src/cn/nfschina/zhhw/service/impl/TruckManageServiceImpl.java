package cn.nfschina.zhhw.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cn.nfschina.zhhw.dao.TruckManageDao;
import cn.nfschina.zhhw.model.TruckInfo;
import cn.nfschina.zhhw.service.TruckManageService;

@Service
public class TruckManageServiceImpl implements TruckManageService{
	
	@Resource 
	private TruckManageDao truckManageDao;
	@Override
	public List<TruckInfo> getAllTruck(TruckInfo truckInfo) {
		// TODO Auto-generated method stub
		return truckManageDao.getAllTruck(truckInfo);
	}

	@Override
	public String getOrgName(TruckInfo truckInfo) {
		// TODO Auto-generated method stub
		return truckManageDao.getOrgName(truckInfo);
	}

	@Override
	public void addTruck(TruckInfo truckInfo) {
		// TODO Auto-generated method stub
		truckManageDao.addTruck(truckInfo);
	}

	@Override
	public void updTruck(TruckInfo truckInfo) {
		// TODO Auto-generated method stub
		truckManageDao.updTruck(truckInfo);
	}

	@Override
	public void delTruck(TruckInfo truckInfo) {
		// TODO Auto-generated method stub
		truckManageDao.delTruck(truckInfo);
	}

	@Override
	public String getDevName(TruckInfo truckInfo) {
		// TODO Auto-generated method stub
		return truckManageDao.getDevName(truckInfo);
	}

	@Override
	public List<TruckInfo> getTruckById(String ids) {
		
		return truckManageDao.getTruckById(ids);
	}

}
