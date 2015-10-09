package cn.nfschina.zhhw.dao;

import java.util.Date;
import java.util.List;

import cn.nfschina.zhhw.model.GasInfo;

public interface GasManageDao {

	void addGas(GasInfo gasInfo);

	List<GasInfo> getAllGas(GasInfo gasInfo);

	void updGas(GasInfo gasInfo);

	void delGas(GasInfo gasInfo);

	String getPlateno(GasInfo gasInfo);

	String getDriverName(GasInfo gasInfo);

	String getUserName(GasInfo gasInfo);
	
	//====================================================shaolinxing start========================
	
	List<GasInfo> getGasByTimePart(Date startTime, Date endTime,String carId);
	
	//====================================================shaolinxing end========================
	

}
