package cn.nfschina.zhhw.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cn.nfschina.zhhw.controller.DatastatisticsTollsController;
import cn.nfschina.zhhw.dao.DataStatisticsDao;
import cn.nfschina.zhhw.dao.GarbageDatastatisticsDao;
import cn.nfschina.zhhw.dao.InfoManageDao;
import cn.nfschina.zhhw.model.DataInnerInfo;
import cn.nfschina.zhhw.model.GarbageModel;
import cn.nfschina.zhhw.model.Org;
import cn.nfschina.zhhw.model.TruckInfo;
import cn.nfschina.zhhw.service.GarbageDatastatisticsService;
import cn.nfschina.zhhw.service.OrgInfoService;

@Service
public class GarbageDatastatisticsServiceImpl implements GarbageDatastatisticsService {
	
	@Resource
	private DatastatisticsTollsController datastatisticsTools; 
	
	@Resource
	private OrgInfoService orgInfoService;
	
	@Resource
	private DataStatisticsDao dataDao;
	
	@Resource
	private InfoManageDao infoManageDao;
	
	@Resource
	private GarbageDatastatisticsDao garbageDao;
	
	/**
	 * 根据时间和车辆得到垃圾重量
	 * @param id
	 * @param startDate
	 * @param endDate
	 * @param time
	 * @return
	 * @author shaolinxing
	 * @time 2015年9月22日 下午9:14:39 
	 * @return Map<String,Object>
	 */
	@Override
	public Map<String, Object> getGarbageForCarByTime(String id,Date startTime, Date endTime, String timeParty) {
		
		List<Object> listWeight = new ArrayList<Object>();//冲数据库查出
		
		List<DataInnerInfo> list = new ArrayList<DataInnerInfo>();//用来放置前台图表显示的数据
		
		Map<String,Object> map = new HashMap<String,Object>();//返回参数
		
		DataInnerInfo dataInnerInfo = new DataInnerInfo();//用来放置车辆与每个时间段的重量
		
		StringBuffer sb = new StringBuffer("[");//用来放置时间段,在前台显示为图例
		
		TruckInfo truckInfo = infoManageDao.getTruckById(id);
		//根据开始时间和结束时间分别得到开始时显示的里程和结束时显示的里程,分别放到listStart和listEnd里面
		while(startTime.compareTo(endTime)<0){
			Date nextTime = datastatisticsTools.initiateDate(startTime,timeParty,sb);
			if(nextTime.compareTo(endTime)<0){
				//调用这个方法,得到这段时间垃圾的总重量
				double weight = getWeight(startTime,nextTime,id);
				listWeight.add(weight);
				startTime = nextTime;
			}else{
				break;
			}
			
		}
		//判断开始时间是否还是小于结束时间,若还是小雨则在进行一次计算
		if(startTime.compareTo(endTime)<=0){
			double weight = getWeight(startTime,endTime,id);
			listWeight.add(weight);
		}
		//把里程数据和车牌号放入dataInnerInfo中在前台生成要展示的数据
		dataInnerInfo.setData(listWeight);
		dataInnerInfo.setName(truckInfo.getPlate_no());
		list.add(dataInnerInfo);
		String str = sb.substring(0, sb.length()-1)+"]";
		map.put("xAxis_categories", sb);
		map.put("series", list);
		map.put("xAxis_title_text", timeParty);
		return map;	
	}

	/**
	 * 根据车辆得到垃圾重量然后进行对比
	 * @param ids
	 * @param startDate
	 * @param endDate
	 * @param time
	 * @return
	 * @author shaolinxing
	 * @time 2015年9月22日 下午9:14:39 
	 * @return Map<String,Object>
	 */
	@Override
	public Map<String, Object> getGarbageForCarByCars(List<String> ids,Date startTime, Date endTime) {
		
		List<DataInnerInfo> list = new ArrayList<DataInnerInfo>();//用来放置前台图表显示的数据
		
		Map<String,Object> map = new HashMap<String,Object>();//返回参数
		
		StringBuffer sb = new StringBuffer("[");//用来放置时间段,在前台显示为图例
		
		for(String id : ids){//循环ids得到每辆车的垃圾重量.
			TruckInfo truckInfo = infoManageDao.getTruckById(id);//根据id得到车辆
			sb.append("'").append(truckInfo.getPlate_no()).append("',");
			double weight = getWeight(startTime,endTime,id);//根据车辆id和时间得到垃圾重量
			DataInnerInfo data = new DataInnerInfo();
			data.setName(truckInfo.getPlate_no());
			List<Object> listWeight = new ArrayList<Object>();
			listWeight.add(weight);
			data.setData(listWeight);
			list.add(data);
		}
		String str = sb.substring(0, sb.length()-1)+"]";
		map.put("xAxis_categories", "垃圾重量");
		map.put("series", list);
		map.put("xAxis_title_text", "车牌号");
		return map;
	}

	/**
	 * 得到组织垃圾重量然后对比
	 * @param id
	 * @param startDate
	 * @param endDate
	 * @param time
	 * @return
	 * @author shaolinxing
	 * @time 2015年9月22日 下午9:14:39 
	 * @return Map<String,Object>
	 */
	@Override
	public Map<String, Object> getGarbageForOrgByOrg(String ids, Date startTime,
			Date endTime, String timeParty) {
		return null;
		
	}

	@Override
	public Map<String, Object> getGarbageForOrgByTime(List<String> ids,Date startTime, Date endTime,String timeParty) {
		
		List<DataInnerInfo> list = new ArrayList<DataInnerInfo>();//用来放置前台图表显示的数据
		
		Map<String,Object> map = new HashMap<String,Object>();//返回参数
		
		StringBuffer sb = new StringBuffer("[");//用来放置时间段,在前台显示为图例
		endTime = datastatisticsTools.initiateDate(endTime,timeParty,new StringBuffer());
		for(String id:ids){//循环组织得到各个时段组织的垃圾重量
			DataInnerInfo data = new DataInnerInfo();//用来存储组织的垃圾重量
			Org org = orgInfoService.getOrgById(id);//根据组织id得到组织
			List<Object> listDouble = new ArrayList<Object>();//存放每次循环时间得到的数据
			Date itemStartTime = datastatisticsTools.equalDate(startTime);
			
			//根据开始时间和结束时间分别得到开始时显示的里程和结束时显示的里程,分别放到listStart和listEnd里面
			while(itemStartTime.compareTo(endTime)<0){//把时间分成时间段,得到每一段时间内垃圾的重量
				Date nextTime = datastatisticsTools.initiateDate(itemStartTime,timeParty,sb);
				if(nextTime.compareTo(endTime)<0){
					double weight = 0;
					List<TruckInfo> trucks = infoManageDao.getCarsByOrg(id);//根据组织id得到组织下面的车辆
					if(trucks!=null&&trucks.size()>0){
						for(TruckInfo truck:trucks){
							double carWeight = getWeight(itemStartTime,nextTime,truck.getId().toString());
							weight = weight + carWeight;
						}
					}
					listDouble.add(weight);
					itemStartTime = nextTime;
				}else{
					datastatisticsTools.initiateDate(nextTime,timeParty,sb);
					break;
				}
			}
			//判断开始时间是否还是小于结束时间,若还是小雨则在进行一次计算
			if(itemStartTime.compareTo(endTime)<=0){
				double weight = 0;
				List<TruckInfo> trucks = infoManageDao.getCarsByOrg(id);//根据组织id得到组织下面的车辆
				if(trucks!=null&&trucks.size()>0){
					for(TruckInfo truck:trucks){
						double carWeight = getWeight(itemStartTime,endTime,truck.getId().toString());
						weight = weight + carWeight;
					}
				}
				listDouble.add(weight);
			}
			data.setData(listDouble);
			data.setName(org.getOrg_name());
			list.add(data);
		}
		
		String str = sb.substring(0, sb.length()-1)+"]";
		map.put("xAxis_categories", str);
		map.put("series", list);
		map.put("xAxis_title_text", timeParty);
		return map;
	}

	
	/**
	 * 根据 车辆id  开始时间   结束时间得到所有的符合条件的数据,并且相加得到总重量.
	 * @param startDate
	 * @param endDate
	 * @param id
	 * @return
	 * @author shaolinxing
	 * @time 2015年9月22日 下午7:42:23 
	 * @return double
	 */
	public double getWeight(Date startDate,Date endDate,String id){
		
		double weight = 0;//总重量
		
		List<GarbageModel> list = garbageDao.getGarbageByTimeForCar(startDate, endDate, id);
		
		if(list!=null&&list.size()>0){
			for(GarbageModel garbage:list){
				double garbageWeight = getWeightByItem(garbage);
				weight = weight + garbageWeight;
			}
		}
		
		return weight;
	}
	/**
	 * 根据garbageModel得到垃圾重量
	 * @param garbage
	 * @return
	 * @author shaolinxing
	 * @time 2015年9月22日 下午7:52:25 
	 * @return double
	 */
	public double getWeightByItem(GarbageModel garbage){
		
		double weight = 0;
		if(garbage!=null){
			if(garbage.getWeight()!=null){}
			
			weight = garbage.getWeight();
		}
		
		return weight;
	}
}
