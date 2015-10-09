package cn.nfschina.zhhw.service;

import java.util.Date;
import java.util.List;

import cn.nfschina.zhhw.model.CarWarning;

/**
 * @Description: 车辆报警service层
 * @copyright: nfschina
 * @ClassName: CarWarningService
 * @author wcy
 * @date 2015年9月10日 下午5:23:17
 */
public interface CarWarningService {

	/*
	 * @Description: 获取所有报警车辆信息
	 * @Title: getAllCarWarning
	 * @return List<CarWarning> ： 报警车辆列表
	 * @throws
	 */
	public abstract List<CarWarning> getAllCarWarning();
	
	/*
	 * @Description: 更新车辆报警信息
	 * @Title: updateCarWarning
	 * @param @param describe
	 * @param @param fk_handman
	 * @param @param id	
	 * @return int 受影响行数
	 * @throws
	 */
	public abstract int updCarWarning(String describe,String fk_handman,String id);
	
	//==============================================shaolinxing start==========================
	public int getAlarmByTimeType (String id, Date startDate,Date endDate,String type);
	//==============================================shaolinxing end==========================
}
