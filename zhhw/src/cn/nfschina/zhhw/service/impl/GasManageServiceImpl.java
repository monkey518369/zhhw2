package cn.nfschina.zhhw.service.impl;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cn.nfschina.zhhw.dao.GasManageDao;
import cn.nfschina.zhhw.model.GasInfo;
import cn.nfschina.zhhw.service.GasManageService;

@Service
public class GasManageServiceImpl implements GasManageService{

	@Resource
	private GasManageDao gasManageDao;
	
	@Override
	public void delGas(GasInfo gasInfo) {
		// TODO Auto-generated method stub
		gasManageDao.delGas(gasInfo);
	}

	@Override
	public void updGas(GasInfo gasInfo) {
		// TODO Auto-generated method stub
		gasManageDao.updGas(gasInfo);
	}

	@Override
	public void addGas(GasInfo gasInfo) {
		// TODO Auto-generated method stub
		gasManageDao.addGas(gasInfo);
	}

	@Override
	public List<GasInfo> getAllGas(GasInfo gasInfo) {
		// TODO Auto-generated method stub
		return gasManageDao.getAllGas(gasInfo);
	}

	@Override
	public String getPlateno(GasInfo gasInfo) {
		// TODO Auto-generated method stub
		return gasManageDao.getPlateno(gasInfo);
	}

	@Override
	public String getDriverName(GasInfo gasInfo) {
		// TODO Auto-generated method stub
		return gasManageDao.getDriverName(gasInfo);
	}

	@Override
	public String getUserName(GasInfo gasInfo) {
		// TODO Auto-generated method stub
		return gasManageDao.getUserName(gasInfo);
	}
	
	//====================================================shaolinxing start========================
	
	//查询某一时间段内的油耗信息
	@Override
	public List<GasInfo> getGasByTimePart(Date startTime, Date endTime,String carId) {
		// TODO Auto-generated method stub
		return gasManageDao.getGasByTimePart(startTime,endTime,carId);
	}
	
	//====================================================shaolinxing end========================
	
	
	
}
