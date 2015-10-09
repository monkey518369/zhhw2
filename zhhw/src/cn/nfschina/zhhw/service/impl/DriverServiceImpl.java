package cn.nfschina.zhhw.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cn.nfschina.zhhw.dao.DriverDao;
import cn.nfschina.zhhw.model.DriverInfo;
import cn.nfschina.zhhw.service.DriverService;

@Service
public class DriverServiceImpl implements DriverService{
	
	@Resource
	private DriverDao driverDao;
	@Override
	public List<DriverInfo> getAllDriver() {
		// TODO Auto-generated method stub
		return driverDao.getAllDriver();
	}

}
