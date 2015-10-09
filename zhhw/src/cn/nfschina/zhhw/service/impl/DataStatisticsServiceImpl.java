package cn.nfschina.zhhw.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cn.nfschina.zhhw.dao.DataStatisticsDao;
import cn.nfschina.zhhw.dao.DateTimeDao;
import cn.nfschina.zhhw.dao.InfoManageDao;
import cn.nfschina.zhhw.model.DataInnerInfo;
import cn.nfschina.zhhw.model.DataStatisticsModel;
import cn.nfschina.zhhw.model.GasInfo;
import cn.nfschina.zhhw.model.Org;
import cn.nfschina.zhhw.model.TruckInfo;
import cn.nfschina.zhhw.service.DataStatisticsService;
import cn.nfschina.zhhw.service.GasManageService;
import cn.nfschina.zhhw.service.InfoManageService;
import cn.nfschina.zhhw.service.OrgInfoService;

import com.alibaba.fastjson.JSONArray;
/**
 * @copyright nfschina
 * @author shaolinxing
 * @time 2015年9月9日 下午3:59:31
 */
@Service
public class DataStatisticsServiceImpl implements DataStatisticsService{
	
	@Resource
	private DataStatisticsDao dataDao;
	
	@Resource
	private DateTimeDao dateTimeDao;
	
	@Resource
	private InfoManageDao infoManageDao;
	
	@Resource
	private InfoManageService infoManageService;
	
	@Resource
	private OrgInfoService orgInfoService;
	
	@Resource
	private GasManageService gasManageService;
	
	//================================================里程统计start======================================================
	/**
	 * 得到车辆里程统计根据时间
	 * @param id
	 * @param startTime
	 * @param endTime
	 * @param time
	 * @return
	 * @author shaolinxing
	 * @time 2015年9月10日 上午10:00:12 
	 * @return Map<String,Double>
	 */
	@Override
	public Map<String,Object> getMileAgeForTime(String id,Date startTime,Date endTime,String type){
		//用来存放开始时间显示的里程
		List<DataStatisticsModel> listStart = new ArrayList<DataStatisticsModel>();
		//用来存放结束时间显示的里程
		List<DataStatisticsModel> listEnd = new ArrayList<DataStatisticsModel>();
		//用来存放实际里程
		List<Object> listMileAge = new ArrayList<Object>();
		//用来放置DataInnerInfo
		List<DataInnerInfo> list = new ArrayList<DataInnerInfo>();
		//用来放置要返回的信息
		Map<String,Object> map = new HashMap<String,Object>();
		//用来放置车辆与每个时间段的里程
		DataInnerInfo dataInnerInfo = new DataInnerInfo();
		//用来放置时间段,在前台显示为图例
		StringBuffer sb = new StringBuffer("[");
		//根据开始时间和结束时间分别得到开始时显示的里程和结束时显示的里程,分别放到listStart和listEnd里面
		while(startTime.compareTo(endTime)<0){
			Date nextTime = initiateDate(startTime,type,sb);
			if(nextTime.compareTo(endTime)<0){
				//调用这个方法,来放入
				getStartEnd(listStart,listEnd,startTime,nextTime,id);
				startTime = nextTime;
			}else{
				break;
			}
			
		}
		//判断开始时间是否还是小于结束时间,若还是小雨则在进行一次计算
		if(startTime.compareTo(endTime)<=0){
			getStartEnd(listStart,listEnd,startTime,endTime,id);
		}
		//由于开始里程和结束里程的数量一定一样所以这里只要对其中的一个进行循环.循环中用结束里程减去开始里程得到时间段内的实际里程
		for(int i=0;i<listStart.size();i++){
			double startMile = 0;
			double endMile = 0;
			DataStatisticsModel startPosition = listStart.get(i);
			DataStatisticsModel endPosition = listEnd.get(i);
			//如果没有起始里程则设置为0
			startMile = getRealMileAge(startPosition);
			//如果没有结束里程则设置为0
			endMile = getRealMileAge(endPosition);
			listMileAge.add(Double.valueOf(endMile-startMile));
		}
		//把里程数据和车牌号放入dataInnerInfo中在前台生成要展示的数据
		dataInnerInfo.setData(listMileAge);
		dataInnerInfo.setName(infoManageService.getTruckById(id).getPlate_no());
		list.add(dataInnerInfo);
		String str = sb.substring(0, sb.length()-1)+"]";
		map.put("xAxis_categories", str);
		map.put("series", list);
		map.put("xAxis_title_text", type);
		return map;	
		
	}
	
	/**
	 * 得到车辆里程统计根据车辆
	 * @param id
	 * @param startTime
	 * @param endTime
	 * @author shaolinxing
	 * @time 2015年9月10日 上午10:00:12 
	 * @return Map<String,Double>
	 */
	@Override
	public Map<String, Object> getMileAgeForCars(List<String> ids, Date startTime,Date endTime) {
		//定义返回结果
		Map<String,Object> map = new HashMap<String,Object>();
		//定义展示的数据,里面放置要展示的数据,在前台生成highcharts
		List<DataInnerInfo> datas = new ArrayList<DataInnerInfo>();
		//方式车牌号在前天生成图例
		StringBuffer sb = new StringBuffer("[");
		//通过ids分别查出每个id对应的车牌号和里程
		for(int i=0;i<ids.size();i++){
			//查出每辆车的里程
			List<DataStatisticsModel> listStart = new ArrayList<DataStatisticsModel>();//放置开始位置的状态
			List<DataStatisticsModel> listEnd = new ArrayList<DataStatisticsModel>();//放置结束位置的状态
			double startMileAge = 0;//放置开始位置的里程
			double endMileAge = 0;//放置结束未知的 里程
			getStartEnd(listStart,listEnd,startTime,endTime,ids.get(i));//根据开始时间和结束时间查出开始状态和结束状态
			TruckInfo truckInfo = infoManageService.getTruckById(ids.get(i));//查出每辆车的信息(包括车牌号)
			if(listStart.size()>0){//因为只有一个时间段所以只有一个初始状态不用循环,得到初始里程
				startMileAge = getRealMileAge(listStart.get(0));
			}else{
				startMileAge = 0;
			}
			if(listEnd.size()>0){//因为只有一个时间段所以只有一个初始状态不用循环,得到结束里程
				endMileAge = getRealMileAge(listEnd.get(0));
			}else{
				endMileAge = 0;
			}
			
			if(truckInfo!=null){//若车辆信息不为空
				if(truckInfo.getPlate_no()!=null){//若车牌不为空把数据放入dataInner和sb
					List<Object> list = new ArrayList<Object>();
					DataInnerInfo dataInner = new DataInnerInfo();
					dataInner.setName(truckInfo.getPlate_no());
					list.add(endMileAge-startMileAge);
					dataInner.setData(list);
					datas.add(dataInner);
					sb.append("'").append(truckInfo.getPlate_no()).append("',");
				}
			}
			
			
		}
		String str = sb.substring(0, sb.length()-1)+"]";
		map.put("xAxis_categories", str);
		//map.put("xAxis_categories","['对比']");
		map.put("series", datas);
		map.put("xAxis_title_text", "车牌号");
		return map;
	}
	
	
	/**
	 * 得到组织里程统计根据组织
	 * @param ids
	 * @param startTime
	 * @param endTime
	 * @return
	 * @author shaolinxing
	 * @time 2015年9月17日 下午4:39:26 
	 * @return Map<String,Object>
	 */
	public Map<String,Object> getOrgMileAgeForOrg(List<String> ids,Date startTime,Date endTime){
		//定义返回结果
		Map<String,Object> map = new HashMap<String,Object>();
		//定义展示的数据,里面放置要展示的数据,在前台生成highcharts
		List<DataInnerInfo> datas = new ArrayList<DataInnerInfo>();
		//放置组织名称在前天生成图例
		StringBuffer sb = new StringBuffer("[");
		//通过ids分别查出每个id对应的组织名称和里程
		for(int i=0;i<ids.size();i++){
			Org org = orgInfoService.getOrgById(ids.get(i));//根据组织id得到组织
			List<TruckInfo> trucks = infoManageDao.getCarsByOrg(ids.get(i));//根据组织id得到组织下面的车辆
			double mileAge = 0;//放置组织的里程,通过每个车辆相加
			List<DataStatisticsModel> startMileAges = new ArrayList<DataStatisticsModel>();
			List<DataStatisticsModel> endMileAges = new ArrayList<DataStatisticsModel>();
			if(trucks!=null&&trucks.size()>0){//判断组织下面的车辆是不是空,若是空则里程=0;
				for(TruckInfo truck:trucks){//循环每个组织下的车辆得到初始状态和结束状态.放入list
					getStartEnd(startMileAges,endMileAges,startTime,endTime,truck.getId().toString());
				}
				double startMileAge = 0;//车辆的初始状态的里程
				double endMileAge = 0;
				if(startMileAges!=null&&startMileAges.size()>0){//判断该车里程里面是不是有数据.若没有数据则初始状态里程=0
					for(DataStatisticsModel model:startMileAges){
						startMileAge = startMileAge + getRealMileAge(model);
					}
				}else{
					startMileAge = 0;
				}
				if(endMileAges!=null&&endMileAges.size()>0){//判断该车里程里面是不是有数据.若没有数据则初始状态里程=0
					for(DataStatisticsModel model:endMileAges){
						endMileAge = endMileAge + getRealMileAge(model);
					}
				}else{
					endMileAge = 0;
				}
				mileAge = endMileAge - startMileAge;//通过总的起始里程和结束里程得到实际里程
			}else{
				mileAge = 0;
			}
			String orgName = "";//组织名称,前台图例显示
			if(org!=null){//判断组织信息是否为空.
				orgName = org.getOrg_name();
				if(orgName==null||orgName==""){//若车牌不为空把数据放入dataInner和sb
					orgName = "未知车牌号";
				}
			}else{
				orgName = "未知车辆";
			}
			List<Object> list = new ArrayList<Object>();//存放里程数据
			DataInnerInfo dataInner = new DataInnerInfo();//数据信息对象,
			dataInner.setName(orgName);
			list.add(mileAge);
			dataInner.setData(list);
			datas.add(dataInner);
			sb.append("'").append(orgName).append("',");
			
		}
		String str = sb.substring(0, sb.length()-1)+"]";
		map.put("xAxis_categories", str);
		map.put("series", datas);
		map.put("xAxis_title_text", "组织名称");
		return map;
	}
	
	/**
	 * 得到组织里程统计根据时间
	 * @param id
	 * @param startTime
	 * @param endTime
	 * @param type
	 * @return
	 * @author shaolinxing
	 * @time 2015年9月17日 下午4:39:43 
	 * @return Map<String,Object>
	 */
	public Map<String,Object> getOrgMileAgeForTime(String id,Date startTime,Date endTime,String type){
		//用来存放实际里程
		List<Object> listMileAge = new ArrayList<Object>();
		//用来放置DataInnerInfo
		List<DataInnerInfo> list = new ArrayList<DataInnerInfo>();
		//用来放置要返回的信息
		Map<String,Object> map = new HashMap<String,Object>();
		//用来放置车辆与每个时间段的里程
		DataInnerInfo dataInnerInfo = new DataInnerInfo();
		//根据id得到组织
		Org org = orgInfoService.getOrgById(id);
		//用来放置时间段,在前台显示为图例
		StringBuffer sb = new StringBuffer("[");
		List<TruckInfo> trucks = infoManageDao.getCarsByOrg(id);//根据组织id得到组织下面的车辆
		/*if(trucks!=null&&trucks.size()>0){
			
		}else{//////////////////////////////////////////////先不考虑车为空的情况============================================
			
		}*/
		//根据开始时间和结束时间分别得到开始时显示的里程和结束时显示的里程,分别放到listStart和listEnd里面
		while(startTime.compareTo(endTime)<0){
			Date nextTime = initiateDate(startTime,type,sb);
			if(nextTime.compareTo(endTime)<0){
				//用来存放开始时间显示的里程
				List<DataStatisticsModel> listStart = new ArrayList<DataStatisticsModel>();
				//用来存放结束时间显示的里程
				List<DataStatisticsModel> listEnd = new ArrayList<DataStatisticsModel>();
				for(TruckInfo truck:trucks){
					getStartEnd(listStart,listEnd,startTime,nextTime,truck.getId().toString());
				}
				//由于开始里程和结束里程的数量一定一样所以这里只要对其中的一个进行循环.循环中用结束里程减去开始里程得到时间段内的实际里程
				double startMile = 0;
				double endMile = 0;
				for(int i=0;i<listStart.size();i++){
					DataStatisticsModel startPosition = listStart.get(i);
					DataStatisticsModel endPosition = listEnd.get(i);
					//得到起始里程
					startMile = getRealMileAge(startPosition);
					//得到结束里程
					endMile = getRealMileAge(endPosition);
				}
				listMileAge.add(Double.valueOf(endMile-startMile));
				startTime = nextTime;
			}else{
				break;
			}
			
		}
		//判断开始时间是否还是小于结束时间,若还是小雨则在进行一次计算
		if(startTime.compareTo(endTime)<=0){
			//用来存放开始时间显示的里程
			List<DataStatisticsModel> listStart = new ArrayList<DataStatisticsModel>();
			//用来存放结束时间显示的里程
			List<DataStatisticsModel> listEnd = new ArrayList<DataStatisticsModel>();
			for(TruckInfo truck:trucks){
				getStartEnd(listStart,listEnd,startTime,endTime,truck.getId().toString());
			}
			//由于开始里程和结束里程的数量一定一样所以这里只要对其中的一个进行循环.循环中用结束里程减去开始里程得到时间段内的实际里程
			double startMile = 0;
			double endMile = 0;
			for(int i=0;i<listStart.size();i++){
				DataStatisticsModel startPosition = listStart.get(i);
				DataStatisticsModel endPosition = listEnd.get(i);
				//得到起始里程
				startMile = getRealMileAge(startPosition);
				//得到结束里程
				endMile = getRealMileAge(endPosition);
			}
			listMileAge.add(Double.valueOf(endMile-startMile));
		}
		
		//把里程数据和车牌号放入dataInnerInfo中在前台生成要展示的数据
		dataInnerInfo.setData(listMileAge);
		dataInnerInfo.setName(org.getOrg_name());
		list.add(dataInnerInfo);
		String str = sb.substring(0, sb.length()-1)+"]";
		map.put("xAxis_categories", str);
		map.put("series", list);
		map.put("xAxis_title_text", type);
		return map;	
	}
	
	//================================================里程统计 end=======================================================
	
	
	
	//================================================油耗统计start=====================================================
	
	/**
	 * 得到车辆油耗统计根据车辆
	 * @param id
	 * @param startTime
	 * @param endTime
	 * @param type
	 * @return
	 * @author shaolinxing
	 * @time 2015年9月17日 下午4:39:43 
	 * @return Map<String,Object>
	 */
	@Override
	public Map<String, Object> getGasForCars(List<String> ids,Date startTime, Date endTime) {
		
		Map<String,Object> map = new HashMap<String,Object>();//定义返回结果
		
		List<DataInnerInfo> datas = new ArrayList<DataInnerInfo>();//定义展示的数据,里面放置要展示的数据,在前台生成highcharts
		
		StringBuffer sb = new StringBuffer("[");//放置车牌号在前天生成图例
		
		for(int i=0;i<ids.size();i++){//通过ids分别查出每个id对应的车牌号和油量
			
			List<DataStatisticsModel> listStart = new ArrayList<DataStatisticsModel>();//放置开始位置的状态
			
			List<DataStatisticsModel> listEnd = new ArrayList<DataStatisticsModel>();//放置结束位置的状态
			
			List<GasInfo> gass = gasManageService.getGasByTimePart(startTime, endTime, ids.get(i));
			
			double startGas = 0;//放置开始位置的油量
			
			double endGas = 0;//放置结束未知的油量
			
			double addGas = 0;//这个时间段内加的油量
			
			getStartEnd(listStart,listEnd,startTime,endTime,ids.get(i));//根据开始时间和结束时间查出开始状态和结束状态
			
			TruckInfo truckInfo = infoManageService.getTruckById(ids.get(i));//查出每辆车的信息(包括车牌号)
			
			if(listStart.size()>0){//因为只有一个时间段所以只有一个初始状态不用循环,得到初始里程
				startGas = getRealGas(listStart.get(0));
			}else{
				startGas = 0;
			}
			if(listEnd.size()>0){//因为只有一个时间段所以只有一个初始状态不用循环,得到结束里程
				endGas = getRealGas(listEnd.get(0));
			}else{
				endGas = 0;
			}
			
			if(gass==null){//若加油信心为空,则加油量为0,否则循环得到加油量
				addGas = 0;
			}else{
				
				for(int j=0;j<gass.size();j++){
					GasInfo gas = gass.get(j);
					addGas = addGas + gas.getVolume();
				}
				
			}
			
			if(truckInfo!=null){//若车辆信息不为空
				if(truckInfo.getPlate_no()!=null){//若车牌不为空把数据放入dataInner和sb
					List<Object> list = new ArrayList<Object>();
					DataInnerInfo dataInner = new DataInnerInfo();
					dataInner.setName(truckInfo.getPlate_no());
					double gas = startGas-endGas+addGas;
					list.add(gas);
					dataInner.setData(list);
					datas.add(dataInner);
					sb.append("'").append(truckInfo.getPlate_no()).append("',");
				}
			}
			
			
		}
		String str = sb.substring(0, sb.length()-1)+"]";
		//map.put("xAxis_categories", str);
		//map.put("xAxis_categories","['对比']");
		map.put("series", datas);
		map.put("xAxis_title_text", "车牌号");
		return map;
	}

	/**
	 * 得到车辆油耗统计根据时间
	 * @param id
	 * @param startTime
	 * @param endTime
	 * @param type
	 * @return
	 * @author shaolinxing
	 * @time 2015年9月17日 下午4:39:43 
	 * @return Map<String,Object>
	 */
	@Override
	public Map<String, Object> getGasForTime(String carid, Date startTime,
			Date endTime, String type) {
		
		List<DataStatisticsModel> listStart = new ArrayList<DataStatisticsModel>();//用来存放开始时间显示的油量
		
		List<DataStatisticsModel> listEnd = new ArrayList<DataStatisticsModel>();//用来存放结束时间显示的油量
		
		List<Object> listGas = new ArrayList<Object>();//用来存放实际油量
		
		List<DataInnerInfo> list = new ArrayList<DataInnerInfo>();//前台要展示的数据放在这了,DataInnerInfo是每一条数据
		
		List<List<GasInfo>> gases = new ArrayList<List<GasInfo>>();//用来放置每个时间段的加油信息,
		
		DataInnerInfo dataInnerInfo = new DataInnerInfo();//用来放置车辆与每个时间段的数据
		
		Map<String,Object> map = new HashMap<String,Object>();//用来放置要返回的信息
		
		StringBuffer sb = new StringBuffer("[");//用来放置时间段,在前台显示为图例
		
		while(startTime.compareTo(endTime)<0){//根据开始时间和结束时间分别得到开始时显示的油耗,分别放到listStart和listEnd里面
			Date nextTime = initiateDate(startTime,type,sb);//得到下一个时间段的开始时间
			List<GasInfo> gass = new ArrayList<GasInfo>();//用来放置本段时间的油耗信息
			if(nextTime.compareTo(endTime)<0){//若下一段的初始时间大于查询的结束时间怎,直接查询开始时间到结束时间
				//调用这个方法,来放入
				getStartEnd(listStart,listEnd,startTime,nextTime,carid);
				gass = gasManageService.getGasByTimePart(startTime, nextTime, carid);
				if(gass==null)gass = new ArrayList<GasInfo>();
				gases.add(gass);
				startTime = nextTime;
			}else{
				getStartEnd(listStart,listEnd,startTime,endTime,carid);
				gass = gasManageService.getGasByTimePart(startTime, endTime, carid);
				if(gass==null)gass = new ArrayList<GasInfo>();
				gases.add(gass);
				break;
			}
			
		}
		//由于开始里程和结束里程的数量一定一样所以这里只要对其中的一个进行循环.循环中用结束里程减去开始里程得到时间段内的实际里程
		for(int i=0;i<listStart.size();i++){
			double startGas = 0;//开始状态的油量
			double endGas = 0;//结束状态的油量
			double addGas = 0;//中间加油量
			DataStatisticsModel startPosition = listStart.get(i);
			DataStatisticsModel endPosition = listEnd.get(i);
			List<GasInfo> gass = gases.get(i);//循环加油次数得到总的加油量
			for(int j=0;j<gass.size();j++){
				GasInfo gas = gass.get(j);
				addGas = addGas + gas.getVolume();
			}
			//如果没有起始里程则设置为0
			startGas = getRealGas(startPosition);
			//如果没有结束里程则设置为0
			endGas = getRealGas(endPosition);
			listGas.add(startGas-endGas+addGas);
		}
		//把里程数据和车牌号放入dataInnerInfo中在前台生成要展示的数据
		dataInnerInfo.setData(listGas);
		dataInnerInfo.setName(infoManageService.getTruckById(carid).getPlate_no());
		list.add(dataInnerInfo);
		String str = sb.substring(0, sb.length()-1)+"]";
		map.put("xAxis_categories", str);
		map.put("series", list);
		map.put("xAxis_title_text", type);
		return map;	
	}

	/**
	 * 得到组织油耗统计根据组织
	 * @param id
	 * @param startTime
	 * @param endTime
	 * @param type
	 * @return
	 * @author shaolinxing
	 * @time 2015年9月17日 下午4:39:43 
	 * @return Map<String,Object>
	 */
	@Override
	public Map<String, Object> getOrgGasForOrg(List<String> ids,Date startTime, Date endTime) {
		
		Map<String,Object> map = new HashMap<String,Object>();//定义返回结果
		
		List<DataInnerInfo> datas = new ArrayList<DataInnerInfo>();//定义展示的数据,里面放置要展示的数据,在前台生成highcharts
		
		StringBuffer sb = new StringBuffer("[");//放置组织名称在前天生成图例
		
		for(int i=0;i<ids.size();i++){//通过ids分别查出每个id对应的组织名称和油耗
			Org org = orgInfoService.getOrgById(ids.get(i));//根据组织id得到组织
			List<TruckInfo> trucks = infoManageDao.getCarsByOrg(ids.get(i));//根据组织id得到组织下面的车辆
			double gas = 0;//放置组织的总油耗,通过每个车辆相加
			List<DataStatisticsModel> startPosition = new ArrayList<DataStatisticsModel>();
			List<DataStatisticsModel> endPosition = new ArrayList<DataStatisticsModel>();
			List<GasInfo> gass = new ArrayList<GasInfo>();
			if(trucks!=null&&trucks.size()>0){//判断组织下面的车辆是不是空,若是空则里程=0;
				for(TruckInfo truck:trucks){//循环每个组织下的车辆得到初始状态和结束状态.放入list
					getStartEnd(startPosition,endPosition,startTime,endTime,truck.getId().toString());
					gass.addAll(gasManageService.getGasByTimePart(startTime, endTime, truck.getId().toString()));
				}
				double startGas = 0;//车辆的初始状态的油量
				double endGas = 0;//车辆结束状态的油量
				if(startPosition!=null&&startPosition.size()>0){//判断该车里程里面是不是有数据.若没有数据则初始状态油量=0
					for(DataStatisticsModel model:startPosition){
						startGas = startGas + getRealGas(model);
					}
				}else{
					startGas = 0;
				}
				if(endPosition!=null&&endPosition.size()>0){//判断该车里程里面是不是有数据.若没有数据则初始状态里程=0
					for(DataStatisticsModel model:endPosition){
						endGas = endGas + getRealGas(model);
					}
				}else{
					endGas = 0;
				}
				gas = endGas - startGas;//通过总的起始里程和结束里程得到实际里程
			}else{
				gas = 0;
			}
			if(gass.size()>0){
				for(GasInfo gasInfo:gass){
					gas = gas + gasInfo.getVolume();
				}
			}
			String orgName = "";//组织名称,前台图例显示
			if(org!=null){//判断组织信息是否为空.
				orgName = org.getOrg_name();
				if(orgName==null||orgName==""){//若车牌不为空把数据放入dataInner和sb
					orgName = "未知车牌号";
				}
			}else{
				orgName = "未知车辆";
			}
			List<Object> list = new ArrayList<Object>();//存放里程数据
			DataInnerInfo dataInner = new DataInnerInfo();//数据信息对象,
			dataInner.setName(orgName);
			list.add(gas);
			dataInner.setData(list);
			datas.add(dataInner);
			sb.append("'").append(orgName).append("',");
			
		}
		String str = sb.substring(0, sb.length()-1)+"]";
		map.put("xAxis_categories", str);
		map.put("series",datas);
		map.put("xAxis_title_text", "组织名称");
		return map;
	}

	/**
	 * 得到组织油耗统计根据时间
	 * @param id
	 * @param startTime
	 * @param endTime
	 * @param type
	 * @return
	 * @author shaolinxing
	 * @time 2015年9月17日 下午4:39:43 
	 * @return Map<String,Object>
	 */
	@Override
	public Map<String, Object> getOrgGasForTime(String id, Date startTime,
			Date endTime, String type) {
		
		List<Object> listGas = new ArrayList<Object>();//用来存放实际油耗
		
		List<DataInnerInfo> list = new ArrayList<DataInnerInfo>();//用来放置DataInnerInfo,即要返回的数据
		
		Map<String,Object> map = new HashMap<String,Object>();//用来放置要返回的信息
		
		DataInnerInfo dataInnerInfo = new DataInnerInfo();//用来放置车辆与每个时间段的油耗
		
		Org org = orgInfoService.getOrgById(id);//根据id得到组织
		
		StringBuffer sb = new StringBuffer("[");//用来放置时间段,在前台显示为图例
		
		List<TruckInfo> trucks = infoManageDao.getCarsByOrg(id);//根据组织id得到组织下面的车辆
		/*if(trucks!=null&&trucks.size()>0){
			
		}else{//////////////////////////////////////////////先不考虑车为空的情况============================================
			
		}*/
		//根据开始时间和结束时间分别得到开始时显示的里程和结束时显示的里程,分别放到listStart和listEnd里面
		while(startTime.compareTo(endTime)<0){
			Date nextTime = initiateDate(startTime,type,sb);
			if(nextTime.compareTo(endTime)<0){
				
				double gas = 0;//用来放置这一时间段内地油耗信息 
				List<DataStatisticsModel> listStart = new ArrayList<DataStatisticsModel>();//用来存放开始时间的数据
				
				List<DataStatisticsModel> listEnd = new ArrayList<DataStatisticsModel>();//用来存放结束时间的数据
				
				List<GasInfo> listGasInfo = new ArrayList<GasInfo>();//用来放置加油信息
				
				for(TruckInfo truck:trucks){
					getStartEnd(listStart,listEnd,startTime,nextTime,truck.getId().toString());
					listGasInfo = gasManageService.getGasByTimePart(startTime, nextTime,truck.getId().toString());
				}
				//由于开始里程和结束里程的数量一定一样所以这里只要对其中的一个进行循环.循环中用结束里程减去开始里程得到时间段内的实际里程
				double startGas = 0;
				double endGas = 0;
				for(int i=0;i<listStart.size();i++){
					DataStatisticsModel startPosition = listStart.get(i);
					DataStatisticsModel endPosition = listEnd.get(i);
					//得到起始里程
					startGas = getRealGas(startPosition);
					//得到结束里程
					endGas = getRealGas(endPosition);
				}
				for(int i=0;i<listGasInfo.size();i++){
					GasInfo gasInfo = new GasInfo();
					gas = gasInfo.getVolume();
				}
				listGas.add(Double.valueOf(startGas-endGas+gas));
				startTime = nextTime;
			}else{
				break;
			}
			
		}
		//判断开始时间是否还是小于结束时间,若还是小雨则在进行一次计算
		if(startTime.compareTo(endTime)<=0){
			
			double gas = 0;//用来放置这一时间段内地油耗信息 
			
			List<DataStatisticsModel> listStart = new ArrayList<DataStatisticsModel>();//用来存放开始时间显示的里程
			
			List<DataStatisticsModel> listEnd = new ArrayList<DataStatisticsModel>();//用来存放结束时间显示的里程
			
			List<GasInfo> listGasInfo = new ArrayList<GasInfo>();//用来放置加油信息
			
			for(TruckInfo truck:trucks){
				getStartEnd(listStart,listEnd,startTime,endTime,truck.getId().toString());
				listGasInfo = gasManageService.getGasByTimePart(startTime, endTime,truck.getId().toString());
			}
			//由于开始里程和结束里程的数量一定一样所以这里只要对其中的一个进行循环.循环中用结束里程减去开始里程得到时间段内的实际里程
			double startMile = 0;
			double endMile = 0;
			for(int i=0;i<listStart.size();i++){
				DataStatisticsModel startPosition = listStart.get(i);
				DataStatisticsModel endPosition = listEnd.get(i);
				//得到起始里程
				startMile = getRealMileAge(startPosition);
				//得到结束里程
				endMile = getRealMileAge(endPosition);
			}
			for(int i=0;i<listGasInfo.size();i++){
				GasInfo gasInfo = new GasInfo();
				gas = gasInfo.getVolume();
			}
			listGas.add(Double.valueOf(endMile-startMile+gas));
		}
		
		//把里程数据和车牌号放入dataInnerInfo中在前台生成要展示的数据
		dataInnerInfo.setData(listGas);
		dataInnerInfo.setName(org.getOrg_name());
		list.add(dataInnerInfo);
		String str = sb.substring(0, sb.length()-1)+"]";
		map.put("xAxis_categories", str);
		map.put("series",list);
		map.put("xAxis_title_text", type);
		return map;	
	}

	//================================================油耗统计 end=======================================================
	
	
	@SuppressWarnings("unchecked")
	//================================================在线统计 start=======================================================
	@Override
	public Map<String, Object> getOnlineByDay(String id, Date date) {
		// TODO Auto-generated method stub
		Date startTime = initiateDay(date);//得到今天凌晨
		
		Date endTime = initiateDay(dateTimeDao.getNextDay(date));//得到明天凌晨
		
		//根据开始时间和结束时间得到这一天的状态信息
		List<DataStatisticsModel> positions = (List<DataStatisticsModel>) dataDao.getData(id, startTime, endTime);
		
		List<DataInnerInfo> list = new ArrayList<DataInnerInfo>();//返回的显示数据\
		
		Map<String,Object> map = new HashMap<String,Object>();
		
		if(positions!=null){//若posiotions不为空,则循环得到在线状态和不在线状态,若为空则为不在线状态.
			Date firstTime = startTime;
			Date secondTime = new Date();
			String startPart  = 
					firstTime.getHours()+":"+firstTime.getMinutes()+":"+firstTime.getSeconds();//第一段时间的开始
			String endPart = "";//一段时间的结束
			boolean flag = false;//之前的状态是否是在线状态.开始默认为不在线
			for(int i=0;i<positions.size()-1;i++){//循环状态
				DataStatisticsModel position = positions.get(i);//,找出发出状态的时间
				int status = position.getOnline();//当前状态
				if(flag){//判断之前状态是否为在线,若是在线
					secondTime = position.getCreatetime();//当前状态发出时间
					endPart = secondTime.getHours()+":"
							  +secondTime.getMinutes()+":"+secondTime.getSeconds();//这个状态的结束时间暂时定义为secondTime.
					if(status!=1){//判断现在状态是否为在线,若不在线则状态转变了,需要保存时间段,重新开始另一个时间段
						DataInnerInfo dii = new DataInnerInfo();
						dii.setName(startPart+"-"+endPart);
						dii.setY(secondTime.getTime()-firstTime.getTime());
						dii.setColor("#7cb5ec'");//在线显示的颜色
						firstTime = secondTime;
						list.add(dii);
						flag = false;
					}else{//若当前状态也为在线,则判断两个时间的时间差是否大于180s,若大约则判断为吃时间为不在线.
						if(secondTime.getTime()-firstTime.getTime()>180000){
							if(list.size()>0){//list不为空,则取出上一个不在线时间,与本次时间连起来.
								DataInnerInfo data = new DataInnerInfo();
								data = list.get(list.size()-1);
								data.setY(data.getY()+secondTime.getTime()-firstTime.getTime());
								String name = data.getName();
								String[] strs = name.split("-");
								data.setName(strs[0]+"-"+endPart);
							}
						}else{
							firstTime = secondTime;
						}
					}
				}else{//若之前的状态为不在线,
					secondTime = position.getCreatetime();
					endPart = secondTime.getHours()+":"
							  +secondTime.getMinutes()+":"+secondTime.getSeconds();//这个状态的结束时间暂时定义为secondTime.
					if(status==1){//判断现在状态是否为在线,若在线则状态转变了,需要保存时间段,重新开始另一个时间段,否则继续执行.
						DataInnerInfo dii = new DataInnerInfo();
						dii.setName(startPart+"-"+endPart);
						dii.setY(secondTime.getTime()-firstTime.getTime());
						dii.setColor("#8085e8'");//不在线显示的颜色
						firstTime = secondTime;
						list.add(dii);
						flag = true;
					}
				}
				
			}
			DataInnerInfo data1 = new DataInnerInfo();
			data1.setY(secondTime.getTime()-firstTime.getTime());
			data1.setName(secondTime.getHours()+":"+secondTime.getMinutes()+":"+secondTime.getSeconds()+"-"
						+"23:59:59");
			list.add(data1);
			data1.setColor("#8085e8");
			if(endTime.getTime()-secondTime.getTime()>180000){//判断最后状态的时间和这天的结束时间是否相差大于180s
				DataInnerInfo data = new DataInnerInfo();
				data.setY(endTime.getTime()-secondTime.getTime());
				String name = data.getName();
				data.setName(secondTime.getHours()+":"+secondTime.getMinutes()+":"+secondTime.getSeconds()+"-"
							+"23:59:59");
				list.add(data);
			}
			
		}else{//若positions为空则全天不在线
			DataInnerInfo dii = new DataInnerInfo();
			dii.setName("00:00:00-23:59:59");
			dii.setY(1);
			dii.setColor("#7cb5ec'");
			list.add(dii);
		}
		map.put("data", list);
		return map;
	}

	@Override
	public Map<String, Object> getOnlineBuCar(List<String> ids, Date startTime,
			Date endTime) {
		// TODO Auto-generated method stub
		return null;
	}
	
	//================================================在线统计 end=======================================================
	/**
	 * 根据开始时间和结束时间车辆id查询。
	 * @param listStart
	 * @param listEnd
	 * @param startTime
	 * @param endTime
	 * @param id
	 * @author shaolinxing
	 * @time 2015年9月10日 上午9:57:09 
	 * @return void
	 */
	public void getStartEnd(List<DataStatisticsModel> listStart,List<DataStatisticsModel> listEnd,Date startTime,Date endTime,String id){
		DataStatisticsModel start = new DataStatisticsModel();
		DataStatisticsModel end = new DataStatisticsModel();
		start = dataDao.getMileAgeStart(id, startTime, endTime);
		listStart.add(start);
		end = dataDao.getMileAgeEnd(id, startTime, endTime);
		listEnd.add(end);
	}
	

	/**
	 * 得到真是的里程.初始位置的里程减去结束
	 * @param model
	 * @param b
	 * @return
	 * @author shaolinxing
	 * @time 2015年9月17日 下午4:02:49 
	 * @return double
	 */
	
	public double getRealMileAge(DataStatisticsModel model){
		double b = 0;
		if(model!=null){
			b = model.getMileage();
		}else{
			b = 0;
		}
		return b;
	}
	
	/**
	 * 得到真是的油量.初始位置的里程减去结束
	 * @param model
	 * @param b
	 * @return
	 * @author shaolinxing
	 * @time 2015年9月17日 下午4:02:49 
	 * @return double
	 */
	
	public double getRealGas(DataStatisticsModel model){
		double b = 0;
		if(model!=null&&model.getOil()!=null){
			b = model.getOil();
		}else{
			b = 0;
		}
		return b;
	}
	/**
	 * 构造一个时间
	 * @param date
	 * @param time
	 * @return
	 * @author shaolinxing
	 * @time 2015年9月10日 上午9:23:53 
	 * @return Date
	 */
	@SuppressWarnings("deprecation")
	public Date initiateDate(Date date,String time,StringBuffer sb){
		
		switch(time){
		
		case "年":
			sb.append("'").append(date.getYear()+1900).append("',");
			date = dateTimeDao.getNextYear(date);
			date = initiateYear(date);
			break;
		case "季度":
			date = dateTimeDao.getNextSeason(date);
			date = initiateSeason(date);
			sb.append("'").append(dateTimeDao.getSeason(date)).append("',");
			break;
		case "月":
			sb.append("'").append(date.getMonth()+1).append("',");
			date = dateTimeDao.getNextMonth(date);
			date = initiateMonth(date);
			break;
			
		case "周":
			date = dateTimeDao.getNextWeek(date);
			sb.append("'").append(dateTimeDao.getDayOfWeek(date)).append("',");
			date = initiateWeek(date);
			break;
		case "日":
			date = dateTimeDao.getNextDay(date);
			date = initiateDay(date);
			sb.append("'").append(date.getDate()-1).append("',");
			break;
		case "时":
			date = dateTimeDao.getNextHour(date);
			date = initiateHour(date);
			sb.append("'").append(date.getHours()).append("',");
			break;
		case "分":
			date = dateTimeDao.getNextMinute(date);
			date = initiateMinute(date);
			sb.append("'").append(date.getMinutes()).append("',");
			break;
		default :
			break;
	}
		
		return date;
		
	}


	/**
	 * 构造一个时间根据年份样式为2015-1-1 0：0：0
	 * @param date
	 * @return
	 * @author shaolinxing
	 * @time 2015年9月10日 上午9:40:28 
	 * @return Date
	 */
	@SuppressWarnings("deprecation")
	public Date initiateYear(Date date){
		date.setMonth(0);
		date.setDate(1);
		date.setHours(0);
		date.setMinutes(0);
		date.setSeconds(0);
		return date;
	}
	/**
	 * 构造一个时间根据季度样式为2015-1-1 0：0：0 or 2015-4-1 0：0：0 or 2015-7-1 0：0：0 or 2015-10-1 0：0：0
	 * @param date
	 * @return
	 * @author shaolinxing
	 * @time 2015年9月10日 上午9:34:52 
	 * @return Date
	 */
	@SuppressWarnings("deprecation")
	public Date initiateSeason(Date date){
		int season = dateTimeDao.getSeason(date);
		switch(season){
			
			case 1 :
				date.setMonth(1);
				break;
			case 2 :
				date.setMonth(4);
				break;
			case 3 :
				date.setMonth(7);
				break;
			case 4 :
				date.setMonth(10);
				break;
			default:
				date.setMonth(1);
		
		}
		date.setDate(1);
		date.setHours(0);
		date.setMinutes(0);
		date.setSeconds(0);
		return date;
	}
	
	/**
	 * 构造一个时间根据月样式为2015-7-1 0：0：0
	 * @param date
	 * @return
	 * @author shaolinxing
	 * @time 2015年9月10日 上午11:07:00 
	 * @return Date
	 */
	@SuppressWarnings("deprecation")
	public Date initiateMonth(Date date){	
		date.setDate(1);
		date.setHours(0);
		date.setMinutes(0);
		date.setSeconds(0);
		return date;
		
	}
	/**
	 * 构造一个时间根据月样式为2015-7-1 0：0：0
	 * @param date
	 * @return
	 * @author shaolinxing
	 * @time 2015年9月10日 下午12:08:18 
	 * @return Date
	 */
	@SuppressWarnings("deprecation")
	public Date initiateWeek(Date date){
		
		int index = dateTimeDao.getDayOfWeek(date);
		
		date.setDate(date.getDate()+1-index);
		date.setHours(0);
		date.setMinutes(0);
		date.setSeconds(0);
		return date;
		
	}

	/**
	 * 构造一个时间根据月样式为2015-7-1 0：0：0
	 * @param date
	 * @return
	 * @author shaolinxing
	 * @time 2015年9月10日 下午3:33:49 
	 * @return Date
	 */
	@SuppressWarnings("deprecation")
	public Date initiateDay(Date date){
		
		date.setHours(0);
		date.setMinutes(0);
		date.setSeconds(0);
		return date;
		
	}
	/**
	 * 构造一个时间根据月样式为2015-7-1 21：32：0
	 * @param date
	 * @return
	 * @author shaolinxing
	 * @time 2015年9月10日 下午3:39:56 
	 * @return Date
	 */
	@SuppressWarnings("deprecation")
	private Date initiateMinute(Date date) {
		date.setSeconds(0);
		return date;
	}
	/**
	 * 构造一个时间根据月样式为2015-7-1 21：0：0
	 * @param date
	 * @return
	 * @author shaolinxing
	 * @time 2015年9月10日 下午3:40:02 
	 * @return Date
	 */
	@SuppressWarnings("deprecation")
	private Date initiateHour(Date date) {
		date.setMinutes(0);
		date.setSeconds(0);
		return date;
	}

	
	
}
