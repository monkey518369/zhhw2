package cn.nfschina.zhhw.dao;

import java.util.Date;
import java.util.List;

import cn.nfschina.zhhw.model.CarWarning;

/**
 * @Description: 车辆报警信息DAO层
 * @copyright: nfschina
 * @ClassName: CarWarningDao
 * @author wcy
 * @date 2015年9月10日 下午4:39:14
 */
public interface CarWarningDao {
	/*
	 * @Description: 获取所有报警车辆信息
	 * @Title: getAllCarWarning
	 * @return List<CarWarning> ： 报警车辆列表
	 * @throws
	 */
	public abstract List<CarWarning> getAllCarWarning();
	
	public abstract int updCarWarning(String describe,String fk_handman,String id);
	
	
	//====================================shaolinxing   start===============================================
	
	public int getAlarmByTimeType(String id,Date startDate,Date endDate,String type);
	//===================================shaolinxing end ===================================================
}
