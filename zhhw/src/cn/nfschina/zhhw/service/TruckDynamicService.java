package cn.nfschina.zhhw.service;

import java.util.List;

import cn.nfschina.zhhw.model.TruckDynamic;
import cn.nfschina.zhhw.model.TruckInfo;

/**
 * @Description: 车辆动态信息的业务层接口
 * @copyright: nfschina
 * @ClassName: TruckDynamicService
 * @author wcy
 * @date 2015年9月10日 上午9:17:17
 */
public interface TruckDynamicService {
	
	/*
	 * @Description: 根据车牌号获取所有动态车辆信息
	 * @Title: getAllCarDynamic
	 * @param plate_nos：车牌号,用"，"隔开
	 * @return List<TruckDynamic>:车辆信息列表
	 * @throws
	 */
	public abstract List<TruckDynamic> getAllCarDynamic(String plate_nos);
	
	/*
	 * @Description: 根据机构id获取车辆信息
	 * @Title: getAllTruckByOrgId
	 * @param ids ：机构组织id
	 * @return List<TruckInfo> 车辆信息列表
	 * @throws
	 */
	public abstract List<TruckInfo> getAllTruckByOrgId(String ids);
	
	/*
	 * @Description: 根据车牌号获取车辆动态信息
	 * @Title: getCarByPlateNo
	 * @param  plate_no:车牌号
	 * @return TruckDynamic
	 * @throws
	 */
	public abstract TruckDynamic getCarByPlateNo(String plate_no);
}
