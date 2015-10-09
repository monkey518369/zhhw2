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
import cn.nfschina.zhhw.dao.DateTimeDao;
import cn.nfschina.zhhw.model.DataInnerInfo;
import cn.nfschina.zhhw.model.DataStatisticsModel;
import cn.nfschina.zhhw.service.InfoManageService;
import cn.nfschina.zhhw.service.OnlineDatastatisticsService;

@Service
public class OnlineDatastatisticsServiceImpl implements OnlineDatastatisticsService{

	@Resource
	private DatastatisticsTollsController tolls;
	
	@Resource
	private DateTimeDao dateTimeDao;
	
	@Resource
	private DataStatisticsDao dataDao;
	
	@Resource
	private InfoManageService infoManageService;
	
	/**
	 * 根据日期得到当天的在线状态饼图
	 * @param id
	 * @param endTime
	 * @return
	 * @author shaolinxing
	 * @time 2015年9月25日 下午3:35:01 
	 * @return Map<String, Object>
	 */
	@Override
	public Map<String, Object> getOnlineByDay(String id,Date date) {
		
		Map<String,Object> map = new HashMap<String,Object>();//返回的结果
		
		Date startTime = tolls.initiateDay(date);//得到今天凌晨,并且作为循环的起始比较时间
		
		Date endTime = tolls.initiateDay(dateTimeDao.getNextDay(date));//得到明天凌晨
		
		List<DataInnerInfo> list = new ArrayList<DataInnerInfo>();//返回的显示数据
		
		//根据开始时间和结束时间得到这一天的状态信息
		List<DataStatisticsModel> positions = (List<DataStatisticsModel>) dataDao.getData(id, startTime, endTime);
		
		Date staticDate = tolls.equalDate(startTime);//重新构造一个时间,用来定义一段时间的开始
		
		if(positions!=null&&positions.size()>0){
			for(int i=0;i<positions.size();i++){//循环所有的状态,根据时间间隔判断是否再线
				if(i!=positions.size()-1){//判断是不是最后一次循环
					DataStatisticsModel position = positions.get(i);
					Date nextPositionTime = new Date();
					DataStatisticsModel nextPosition = positions.get(i+1);
					nextPositionTime = nextPosition.getCreatetime();	
					Date positionTime = position.getCreatetime();
					if(positionTime.getTime()-startTime.getTime()>600000){//若相邻的两个时间间隔大于10分钟,则表明这段时间不在线.
						//判断下一段事假您是否在线,若不在线则不执行if
						if(nextPositionTime.getTime()-positionTime.getTime()<600000){
							DataInnerInfo notOnline = new DataInnerInfo();//放置不在线的时间段的时间和长度
							notOnline.setName(getNameByTime(startTime,positionTime));
							List<Object> notOnlineList = new ArrayList<Object>();
							notOnlineList.add(positionTime.getTime()-startTime.getTime());
							notOnline.setData(notOnlineList);
							notOnline.setY(positionTime.getTime()-startTime.getTime());
							notOnline.setColor("#7cb5ec");
							DataInnerInfo online = new DataInnerInfo();//放置在线时间段的时间和长度
							online.setName(getNameByTime(staticDate, startTime));
							List<Object> onlineList = new ArrayList<Object>();
							onlineList.add(startTime.getTime()-staticDate.getTime());
							online.setData(onlineList);
							online.setY(startTime.getTime()-staticDate.getTime());
							online.setColor("#8085e8");
							list.add(online);
							list.add(notOnline);
							startTime = positionTime;
							staticDate = startTime;
						}
						
					}else{
						startTime = positionTime;
					}
				}else{
					DataStatisticsModel position = positions.get(i);
					Date nextPositionTime = endTime;
					Date positionTime = position.getCreatetime();
					if(positionTime.getTime()-startTime.getTime()>600000){//若相邻的两个时间间隔大于10分钟,则表明这段时间不在线.
						//判断下一段事假您是否在线,若不在线则不执行if
						if(nextPositionTime.getTime()-positionTime.getTime()<600000){
							DataInnerInfo notOnline = new DataInnerInfo();//放置不在线的时间段的时间和长度
							notOnline.setName(getNameByTime(startTime,positionTime));
							List<Object> notOnlineList = new ArrayList<Object>();
							notOnlineList.add(positionTime.getTime()-startTime.getTime());
							notOnline.setData(notOnlineList);
							notOnline.setColor("#7cb5ec");
							notOnline.setY(positionTime.getTime()-startTime.getTime());
							DataInnerInfo online = new DataInnerInfo();//放置在线时间段的时间和长度
							online.setName(getNameByTime(staticDate, startTime));
							List<Object> onlineList = new ArrayList<Object>();
							onlineList.add(startTime.getTime()-staticDate.getTime());
							online.setData(onlineList);
							online.setColor("#8085e8");
							online.setY(startTime.getTime()-staticDate.getTime());
							list.add(online);
							list.add(notOnline);
							DataInnerInfo online2 = new DataInnerInfo();
							online2.setName(getNameByTime(positionTime, endTime));
							List<Object> onlineList2 = new ArrayList<Object>();
							onlineList2.add(positionTime.getTime()-endTime.getTime());
							online2.setData(onlineList2);
							online2.setY(positionTime.getTime()-endTime.getTime());
							online2.setColor("#8085e8");
							list.add(online2);
							
						}else{
							DataInnerInfo notOnline = new DataInnerInfo();//放置不在线的时间段的时间和长度
							notOnline.setName(getNameByTime(startTime,endTime));
							List<Object> notOnlineList = new ArrayList<Object>();
							notOnlineList.add(endTime.getTime()-startTime.getTime());
							notOnline.setData(notOnlineList);
							notOnline.setColor("#7cb5ec");
							notOnline.setY(endTime.getTime()-startTime.getTime());
							DataInnerInfo online = new DataInnerInfo();//放置在线时间段的时间和长度
							online.setName(getNameByTime(staticDate, startTime));
							List<Object> onlineList = new ArrayList<Object>();
							onlineList.add(startTime.getTime()-staticDate.getTime());
							online.setData(onlineList);
							online.setColor("#8085e8");
							online.setY(startTime.getTime()-staticDate.getTime());
							list.add(online);
							list.add(notOnline);
						}
						
					}else{
						//判断下一段事假您是否在线,若不在线则不执行if
						if(nextPositionTime.getTime()-positionTime.getTime()<600000){
							DataInnerInfo online = new DataInnerInfo();//放置在线时间段的时间和长度
							online.setName(getNameByTime(staticDate, nextPositionTime));
							List<Object> onlineList = new ArrayList<Object>();
							onlineList.add(nextPositionTime.getTime()-staticDate.getTime());
							online.setData(onlineList);
							online.setColor("#8085e8");
							online.setY(nextPositionTime.getTime()-staticDate.getTime());
							list.add(online);
						}else{
							DataInnerInfo notOnline = new DataInnerInfo();//放置不在线的时间段的时间和长度
							notOnline.setName(getNameByTime(positionTime,endTime));
							List<Object> notOnlineList = new ArrayList<Object>();
							notOnlineList.add(endTime.getTime()-positionTime.getTime());
							notOnline.setData(notOnlineList);
							notOnline.setColor("#7cb5ec");
							notOnline.setY(endTime.getTime()-positionTime.getTime());
							DataInnerInfo online = new DataInnerInfo();//放置在线时间段的时间和长度
							online.setName(getNameByTime(staticDate, positionTime));
							List<Object> onlineList = new ArrayList<Object>();
							onlineList.add(positionTime.getTime()-staticDate.getTime());
							online.setData(onlineList);
							online.setColor("#8085e8");
							online.setY(positionTime.getTime()-staticDate.getTime());
							list.add(online);
							list.add(notOnline);
						}
					}
				}
			}
		}
		map.put("data", list);
		return map;
	}

	/**根据时间组合出字符串
	 * 
	 * @param startTime
	 * @param endTime
	 * @return
	 * @author shaolinxing
	 * @time 2015年9月25日 下午3:35:01 
	 * @return String
	 */
	@SuppressWarnings("deprecation")
	public String getNameByTime(Date startTime,Date endTime){
		
		String str = ""+startTime.getHours()+":"+startTime.getMinutes()+":"+startTime.getSeconds()+"--"+
				endTime.getHours()+":"+endTime.getMinutes()+":"+endTime.getSeconds();
		
		return str;
		
	}


	

	/**
	 * 根据日期得到每天的在线时长
	 * @param id
	 * @param endTime
	 * @param startDate
	 * @param timeParty
	 * @return
	 * @author shaolinxing
	 * @time 2015年9月25日 下午3:35:01 
	 * @return Map<String, Object>
	 */
	@Override
	public Map<String, Object> getOnlineTime(String id, Date startDate,Date endDate,String timeParty) {
		
		Map<String,Object> map = new HashMap<String,Object>();
		
		List<DataInnerInfo> list = new ArrayList<DataInnerInfo>();
		
		DataInnerInfo dataInnerInfo = new DataInnerInfo();
		//存放在线时间的数据
		List<Object> listData = new ArrayList<Object>();
		//用来放置时间段,在前台显示为图例
		StringBuffer sb = new StringBuffer("[");
		//根据开始时间和结束时间和时间段得到总共分几段
		while(startDate.compareTo(endDate)<0){
			Date nextDate = tolls.initiateDate(startDate,timeParty,sb);
			if(nextDate.compareTo(endDate)<=0){
				List<DataStatisticsModel> listModel = dataDao.getData(id, startDate, nextDate);
				listData.add(getTime(listModel));
				startDate = nextDate;
			}else{
				break;
			}
			
		}
		//判断开始时间是否还是小于结束时间,若还是小雨则在进行一次计算
		if(startDate.compareTo(endDate)<=0){
			if(startDate.equals(endDate)){
				Date nextDate = tolls.initiateDate(startDate,timeParty,sb);
				nextDate = tolls.initiateDate(startDate, "日", sb);
				List<DataStatisticsModel> listModel = dataDao.getData(id, endDate, nextDate);
				listData.add(getTime(listModel));
			}else{
				List<DataStatisticsModel> listModel = dataDao.getData(id, startDate, endDate);
				listData.add(getTime(listModel));
			}
			
		}
		
		dataInnerInfo.setData(listData);
		dataInnerInfo.setName(infoManageService.getTruckById(id).getPlate_no());
		list.add(dataInnerInfo);
		String str = sb.substring(0, sb.length()-1)+"]";
		map.put("xAxis_categories", str);
		map.put("series", list);
		map.put("xAxis_title_text", timeParty);
		return map;	
	}
	
	/**
	 * 通过一段时间的所有状态得到总在线时间
	 * @param list
	 * @return
	 * @author shaolinxing
	 * @time 2015年9月25日 下午2:25:10 
	 * @return long
	 */
	public double getTime(List<DataStatisticsModel> list){
		
		double total = 0;//定义返回的数据,这段时间在线的总时间(毫秒)
		if(list!=null&&list.size()>0){
			for(int i=0;i<list.size()-1;i++){//循环判断,若两个状态的时间差小于十分钟则是在线状态,则计算入总时间,否则不计算
				DataStatisticsModel firstPosition = list.get(i);
				DataStatisticsModel secondPosition = list.get(i+1);
				Date firstTime = firstPosition.getCreatetime();
				Date secondTime = secondPosition.getCreatetime();
				if(secondTime.getTime()-firstTime.getTime()<600000){
					total = total + secondTime.getTime()-firstTime.getTime();
				}
			}
		}
		double houre = total/(60*60*1000);
		houre = (0.0 + (int) (houre * 100))/100;
		return houre;
	}

	@Override
	public Map<String, Object> getOnlineTime(List<String> ids, Date startDate,
			Date endDate, String timeParty) {

		Map<String,Object> map = new HashMap<String,Object>();
		
		List<DataInnerInfo> list = new ArrayList<DataInnerInfo>();
		
		//用来放置时间段,在前台显示为图例
		StringBuffer sb = new StringBuffer("[");
		for(int i=0;i<ids.size();i++){
			String id = ids.get(i);
			DataInnerInfo dataInnerInfo = new DataInnerInfo();
			//存放在线时间的数据
			List<Object> listData = new ArrayList<Object>();
			
			Date staticDate = tolls.equalDate(startDate);
			//根据开始时间和结束时间和时间段得到总共分几段
			while(staticDate.compareTo(endDate)<0){
				Date nextDate = tolls.initiateDate(staticDate,timeParty,sb);
				if(nextDate.compareTo(endDate)<=0){
					List<DataStatisticsModel> listModel = dataDao.getData(id, staticDate, nextDate);
					listData.add(getTime(listModel));
					staticDate = nextDate;
				}else{
					break;
				}
				
			}
			//判断开始时间是否还是小于结束时间,若还是小雨则在进行一次计算
			if(staticDate.compareTo(endDate)<=0){
				if(staticDate.equals(endDate)){
					Date nextDate = tolls.initiateDate(staticDate,timeParty,sb);
					nextDate = tolls.initiateDate(staticDate, "日", sb);
					List<DataStatisticsModel> listModel = dataDao.getData(id, endDate, nextDate);
					listData.add(getTime(listModel));
				}else{
					List<DataStatisticsModel> listModel = dataDao.getData(id, startDate, endDate);
					listData.add(getTime(listModel));
				}
				
			}
			dataInnerInfo.setData(listData);
			dataInnerInfo.setName(infoManageService.getTruckById(id).getPlate_no());
			list.add(dataInnerInfo);
		}
		String str = sb.substring(0, sb.length()-1)+"]";
		map.put("xAxis_categories", str);
		map.put("series", list);
		map.put("xAxis_title_text", timeParty);
		return map;	
	}
}
