package cn.nfschina.zhhw.service.impl;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cn.nfschina.zhhw.dao.CarWarningDao;
import cn.nfschina.zhhw.model.CarWarning;
import cn.nfschina.zhhw.service.CarWarningService;

@Service
public class CarWarningServiceImpl implements CarWarningService{

	@Resource
	private CarWarningDao carWarningDao;

	@Override
	public List<CarWarning> getAllCarWarning() {
		List<CarWarning> list = carWarningDao.getAllCarWarning();
		if(list.size()>0){
			for(CarWarning warn:list){
				StringBuffer point = new StringBuffer("(");
				point.append(warn.getCar_lng());
				point.append(",");
				point.append(warn.getCar_lat()+")");
				warn.setPoint(point.toString());
			}
		}
		return list;
	}

	@Override
	public int updCarWarning(String describe, String fk_handman, String id) {
		return carWarningDao.updCarWarning(describe, fk_handman, id);
	}
	
	//===============================================shaolinxing start=========================================
	/**
	 * 根据车id开始时间结束时间报警类型得到报警的个数(若时间为空则查出说有这个类型的报警,若报警类型为空则查出这个时间段的所有类型的报警,都为空则为全部)
	 * @param id
	 * @param startDate
	 * @param endDate
	 * @param timeParty
	 * @param alarmType
	 * @param request
	 * @return
	 * @author shaolinxing
	 * @time 2015年9月23日 下午5:04:07 
	 * @return Map<String,Object>
	 */
	public int getAlarmByTimeType (String id, Date startDate,Date endDate,String type){
		
		return carWarningDao.getAlarmByTimeType(id, startDate,endDate,type);
	
	}
	
	//==================================================shaolinxing end=========================================
}
