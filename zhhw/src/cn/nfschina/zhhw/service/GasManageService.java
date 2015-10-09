package cn.nfschina.zhhw.service;

import java.util.Date;
import java.util.List;

import cn.nfschina.zhhw.model.GasInfo;

public interface GasManageService {

	void delGas(GasInfo gasInfo);

	void updGas(GasInfo gasInfo);

	void addGas(GasInfo gasInfo);

	List<GasInfo> getAllGas(GasInfo gasInfo);

	String getPlateno(GasInfo gasInfo);

	String getDriverName(GasInfo gasInfo);

	String getUserName(GasInfo gasInfo);
	
	//====================================================shaolinxing start========================
	
	List<GasInfo> getGasByTimePart(Date startTime,Date endTime,String carId);
	
	//====================================================shaolinxing start========================
	
}
