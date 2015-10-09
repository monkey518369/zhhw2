package cn.nfschina.zhhw.dao;

import java.util.List;

import cn.nfschina.zhhw.model.TruckDynamic;
import cn.nfschina.zhhw.model.TruckInfo;

/**
 * @Description: 车辆动态信息Dao层接口，采用新的页面布局后，将区域找车，车辆报警等放在一个界面，使用一个接口
 * @copyright: nfschina
 * @ClassName: TruckDynamicDao
 * @author wcy
 * @date 2015年9月10日 上午9:05:01
 */
public interface TruckDynamicDao {

	/*
	 * @Description: 获取所有车辆动态信息
	 * @Title: getAllCarDynamic
	 * @param plate_nos：车牌号
	 * @return List<TruckDynamic>:车辆列表
	 * @throws
	 */
	public abstract List<TruckDynamic> getAllCarDynamic(String plate_nos);
	
	/*
	 * @Description: 根据部门id获取车辆
	 * @Title: getAllTruckByOrgId
	 * @param ids:用","拼接的部门ids
	 * @return List<TruckInfo>:传入参数部门所拥有的车辆
	 * @throws
	 */
	public abstract List<TruckInfo> getAllTruckByOrgId(String ids);
	
	/*
	 * @Description: 根据车牌号获取车辆动态信息
	 * @Title: getCarByPlateNo
	 * @param  plate_no:车牌号
	 * @return TruckDynamic:该车的当前动态信息
	 * @throws
	 */
	public abstract TruckDynamic getCarByPlateNo(String plate_no);
}
