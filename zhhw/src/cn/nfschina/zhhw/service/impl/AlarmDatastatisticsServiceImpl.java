package cn.nfschina.zhhw.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cn.nfschina.zhhw.controller.DatastatisticsTollsController;
import cn.nfschina.zhhw.dao.InfoManageDao;
import cn.nfschina.zhhw.model.DataInnerInfo;
import cn.nfschina.zhhw.model.TruckInfo;
import cn.nfschina.zhhw.service.AlarmDatastatisticsService;
import cn.nfschina.zhhw.service.CarWarningService;

@Service
public class AlarmDatastatisticsServiceImpl implements AlarmDatastatisticsService {

	
	@Resource
	private CarWarningService carWarningService;
	
	@Resource
	private DatastatisticsTollsController datastatisticsTools;
	
	@Resource
	private InfoManageDao infoManageDao;
	/**
	 * 根据车id开始时间结束时间报警类型得到数据
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
	@Override
	public Map<String, Object> getAlarmForCar(String id,Date startDate,Date endDate,String timeParty,List<String> types){
		
		List<DataInnerInfo> list = new ArrayList<DataInnerInfo>();
		StringBuffer sb = new StringBuffer("[");//用来放置时间段,在前台显示为图例
		for(String str:types){//循环组织得到各个时段组织的垃圾重量
			DataInnerInfo data = new DataInnerInfo();//用来存储每种劲爆的数量
			List<Object> listDouble = new ArrayList<Object>();//存放每次循环时间得到的数据
			Date itemStartTime = datastatisticsTools.equalDate(startDate);//重新定义一个时间,作为循环用 的开始时间
			
			//根据开始时间和结束时间分别得到开始时间得到警报的数量
			while(itemStartTime.compareTo(endDate)<=0){//把时间分成时间段,得到每一段时间内垃圾的重量
				Date nextTime = datastatisticsTools.initiateDate(itemStartTime,timeParty,sb);
				if(nextTime.compareTo(endDate)<=0){
					int warnings =  carWarningService.getAlarmByTimeType(id, itemStartTime, nextTime, str);
					listDouble.add(warnings);
					itemStartTime = nextTime;
				}else{
					datastatisticsTools.initiateDate(nextTime,timeParty,sb);
					break;
				}
			}
			//判断开始时间是否还是小于结束时间,若还是小雨则在进行一次计算
			if(itemStartTime.compareTo(endDate)<=0){
				int warnings =  carWarningService.getAlarmByTimeType(id, itemStartTime, endDate, str);
				listDouble.add(warnings);
			}
			data.setData(listDouble);
			data.setName(str);
			list.add(data);
		}
		String str = sb.substring(0, sb.length()-1)+"]";
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("xAxis_categories", str);
		map.put("series", list);
		map.put("xAxis_title_text", timeParty);
		return map;
	}

	@Override
	public Map<String, Object> getAlarmForOrg(String id,Date startDate,Date endDate,String timeParty,List<String> types){

		List<DataInnerInfo> list = new ArrayList<DataInnerInfo>();
		StringBuffer sb = new StringBuffer("[");//用来放置时间段,在前台显示为图例
		for(String str:types){//循环组织得到各个时段组织的垃圾重量
			DataInnerInfo data = new DataInnerInfo();//用来存储每种劲爆的数量
			List<Object> listDouble = new ArrayList<Object>();//存放每次循环时间得到的数据
			Date itemStartTime = datastatisticsTools.equalDate(startDate);//重新定义一个时间,作为循环用 的开始时间
			
			//根据开始时间和结束时间分别得到开始时间得到警报的数量
			while(itemStartTime.compareTo(endDate)<=0){//把时间分成时间段,得到每一段时间内垃圾的重量
				Date nextTime = datastatisticsTools.initiateDate(itemStartTime,timeParty,sb);
				if(nextTime.compareTo(endDate)<=0){
					List<TruckInfo> trucks = infoManageDao.getCarsByOrg(id);//根据组织id得到组织下面的车辆
					double warnings = 0;
					if(trucks!=null&&trucks.size()>0){
						for(TruckInfo truck:trucks){
							double warning = carWarningService.
									getAlarmByTimeType(truck.getId().toString(), itemStartTime, nextTime, str);//得到数量
							warnings = warnings + warning;
						}
					}
					listDouble.add(warnings);
					itemStartTime = nextTime;
				}else{
					datastatisticsTools.initiateDate(nextTime,timeParty,sb);
					break;
				}
			}
			//判断开始时间是否还是小于结束时间,若还是小雨则在进行一次计算
			if(itemStartTime.compareTo(endDate)<=0){
				List<TruckInfo> trucks = infoManageDao.getCarsByOrg(id);//根据组织id得到组织下面的车辆
				double warnings = 0;
				if(trucks!=null&&trucks.size()>0){
					for(TruckInfo truck:trucks){
						double warning = carWarningService.
								getAlarmByTimeType(truck.getId().toString(),itemStartTime,endDate, str);//得到数量
						warnings = warnings + warning;
					}
				}
				listDouble.add(warnings);
			}
			data.setData(listDouble);
			data.setName(str);
			list.add(data);
		}
		String str = sb.substring(0, sb.length()-1)+"]";
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("xAxis_categories", str);
		map.put("series", list);
		map.put("xAxis_title_text", timeParty);
		return map;
	}

}
