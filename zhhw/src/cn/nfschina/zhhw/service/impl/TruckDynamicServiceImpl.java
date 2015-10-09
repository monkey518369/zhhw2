package cn.nfschina.zhhw.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cn.nfschina.zhhw.dao.TruckDynamicDao;
import cn.nfschina.zhhw.model.TruckDynamic;
import cn.nfschina.zhhw.model.TruckInfo;
import cn.nfschina.zhhw.service.TruckDynamicService;

@Service
public class TruckDynamicServiceImpl implements TruckDynamicService{

	@Resource
	private TruckDynamicDao carManagerDao;
	
	@Override
	public List<TruckDynamic> getAllCarDynamic(String plate_nos) {
		
		return carManagerDao.getAllCarDynamic(plate_nos);
	}

	@Override
	public List<TruckInfo> getAllTruckByOrgId(String ids) {
		return carManagerDao.getAllTruckByOrgId(ids);
	}

	@Override
	public TruckDynamic getCarByPlateNo(String plate_no) {
		return carManagerDao.getCarByPlateNo(plate_no);
	}

}
