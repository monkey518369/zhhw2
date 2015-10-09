package cn.nfschina.zhhw.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.nfschina.zhhw.dao.DateTimeDao;
import cn.nfschina.zhhw.model.DataInnerInfo;
import cn.nfschina.zhhw.service.DataStatisticsService;
import cn.nfschina.zhhw.util.TransactionCode;

@Controller
@RequestMapping("/data")
public class DataStatisticsController {

	@Resource
	private DataStatisticsService dataService; 
	
	@Resource
	private DateTimeDao dateTimeDao;
	
	//文件位置前缀
	private String path = "zhhw/datastatistics";
	
	//显示jsp的controller都在这里了========================
	
	//里程统计页面
	@RequestMapping("/mileage")
	public String toMileAge(){
		return path+"/mileage";
	}
	
	//油耗统计
	@RequestMapping("/gas")
	public String toGas(){
		return path+"/gas";
	}
	
	//在线统计
	@RequestMapping("/online")
	public String toOnline(){
		return path + "/online";
	}
	
	//==========================================里程统计  start==========================================================
	/**
	 * 查询车辆的里程
	 * @param carIds
	 * @param startDate
	 * @param endDate
	 * @param time
	 * @param count
	 * @param request
	 * @return
	 * @author shaolinxing
	 * @time 2015年9月9日 下午3:40:20 
	 * @return List<List<Double>>
	 */
	@RequestMapping(value="/getmileage",method=RequestMethod.GET)
	@ResponseBody
	public Map<String,Object> getMileAge(@RequestParam(required=false) String carIds,
								   @RequestParam(required=false) String startDate,
								   @RequestParam(required=false) String endDate,
								   @RequestParam(required=false) String time,
								   @RequestParam(required=false) Integer count,
								   HttpServletRequest request){
		Map<String,Object> map = new HashMap<String,Object>();
		String[] strs = carIds.split(",");
		List<String> list = new ArrayList<String>();
		for(int i=0;i<strs.length;i++){
			if(!(strs[i].equals(",")))
				list.add(strs[i]);
		}
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		Date startTime = null;
		Date endTime = null;
		try {
			startTime = sf.parse(startDate);
			endTime = sf.parse(endDate);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		time = TransactionCode.transaction(time);

		if(strs.length==1){
			map = dataService.getMileAgeForTime(carIds,startTime,endTime,time);
		}
		else{
			map = dataService.getMileAgeForCars(list, startTime, endTime);
		}
		return map;
		
	}
	
	/**
	 * 查询组织的里程
	 * @param orgIds
	 * @param startDate
	 * @param endDate
	 * @param time
	 * @param request
	 * @return
	 * @author shaolinxing
	 * @time 2015年9月17日 下午8:28:47 
	 * @return Map<String,Object>
	 */
	@RequestMapping(value="/getorgmileage",method=RequestMethod.GET)
	@ResponseBody
	public Map<String,Object> getOrgMileAge(@RequestParam(required=false) String orgIds,
										   @RequestParam(required=false) String startDate,
										   @RequestParam(required=false) String endDate,
										   @RequestParam(required=false) String time,
										   HttpServletRequest request){
		
		Map<String,Object> map = new HashMap<String,Object>();
		String[] strs = orgIds.split(",");
		List<String> list = new ArrayList<String>();
		for(int i=0;i<strs.length;i++){
			if(!(strs[i].equals(",")))
				list.add(strs[i]);
		}
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		Date startTime = null;
		Date endTime = null;
		try {
			startTime = sf.parse(startDate);
			endTime = sf.parse(endDate);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		time = TransactionCode.transaction(time);

		if(strs.length==1){
			map = dataService.getOrgMileAgeForTime(orgIds,startTime,endTime,time);
		}
		else{
			map = dataService.getOrgMileAgeForOrg(list, startTime, endTime);
		}
		return map;
		
	}
	
	//==========================================里程统计  end==========================================================
	
	
	//==========================================油耗统计  start==========================================================
	/**
	 * 查询车辆的油耗
	 * @param orgIds
	 * @param startDate
	 * @param endDate
	 * @param time
	 * @param request
	 * @return
	 * @author shaolinxing
	 * @time 2015年9月18日 上午9:31:53 
	 * @return Map<String,Object>
	 */
	@RequestMapping("/getgas")
	@ResponseBody
	public Map<String,Object> getGas(@RequestParam(required=false) String carIds,
								   @RequestParam(required=false) String startDate,
								   @RequestParam(required=false) String endDate,
								   @RequestParam(required=false) String time,
								   HttpServletRequest request){
		Map<String,Object> map = new HashMap<String,Object>();
		Map<String,Object> mileAgeMap = new HashMap<String,Object>();
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		Date startTime = new Date();
		Date endTime = new Date();
		try {
			startTime = sf.parse(startDate);
			endTime = sf.parse(endDate);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		String[] strs = carIds.split(",");
		List<String> list = new ArrayList<String>();
		for(int i=0;i<strs.length;i++){
			if(!(strs[i].equals(",")))
				list.add(strs[i]);
		}
		
		time = TransactionCode.transaction(time);

		if(strs.length==1){
			map = dataService.getGasForTime(carIds,startTime,endTime,time);
			mileAgeMap = dataService.getMileAgeForTime(carIds, startTime, endTime,time);
			map = getGasMileAge(map,mileAgeMap);
		}
		else{
			map = dataService.getGasForCars(list, startTime, endTime);
			mileAgeMap = dataService.getMileAgeForCars(list, startTime, endTime);
			map = getGasMileAge(map,mileAgeMap);
		}
		return map;
	}
	
	/**
	 * 查询组织的油耗
	 * @param orgIds
	 * @param startDate
	 * @param endDate
	 * @param time
	 * @param request
	 * @return
	 * @author shaolinxing
	 * @time 2015年9月18日 上午9:32:11 
	 * @return Map<String,Object>
	 */
	@RequestMapping("/getorggas")
	@ResponseBody
	public Map<String,Object> getOrgGas(@RequestParam(required=false) String orgIds,
									   @RequestParam(required=false) String startDate,
									   @RequestParam(required=false) String endDate,
									   @RequestParam(required=false) String time,
									   HttpServletRequest request){


		Map<String,Object> map = new HashMap<String,Object>();
		Map<String,Object> mileAgeMap = new HashMap<String,Object>();
		String[] strs = orgIds.split(",");
		List<String> list = new ArrayList<String>();
		for(int i=0;i<strs.length;i++){
			if(!(strs[i].equals(",")))
				list.add(strs[i]);
		}
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		Date startTime = null;
		Date endTime = null;
		try {
			startTime = sf.parse(startDate);
			endTime = sf.parse(endDate);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		time = TransactionCode.transaction(time);

		if(strs.length==1){
			map = dataService.getOrgGasForTime(orgIds,startTime,endTime,time);
			mileAgeMap = dataService.getOrgMileAgeForTime(orgIds, startTime, endTime, time);
			map = getGasMileAge(map,mileAgeMap);
		}
		else{
			map = dataService.getOrgGasForOrg(list, startTime, endTime);
			mileAgeMap = dataService.getOrgMileAgeForOrg(list, startTime, endTime);
			map = getGasMileAge(map,mileAgeMap);
		}
		return map;
}

	/**
	 * 改成百公里油耗
	 * @param gasMap
	 * @param mileAgeMap 
	 * @return
	 * @author shaolinxing
	 * @time 2015年9月18日 上午9:32:11 
	 * @return Map<String,Object>
	 */
	
	public Map<String,Object> getGasMileAge(Map<String,Object> gasMap,Map<String,Object> mileAgeMap){
		
		@SuppressWarnings("unchecked")
		List<DataInnerInfo> listGasInfo  = (List<DataInnerInfo>) gasMap.get("series");
		@SuppressWarnings("unchecked")
		List<DataInnerInfo> listMileAgeInfo = (List<DataInnerInfo>) mileAgeMap.get("series");
		
		if(listGasInfo!=null&&listMileAgeInfo!=null){
			for(int i=0;i<listGasInfo.size();i++){
				
				DataInnerInfo dataGas = listGasInfo.get(i);
				DataInnerInfo dataMileAge = listMileAgeInfo.get(i);
				@SuppressWarnings("unchecked")
				List<Object> listGas = (List<Object>) dataGas.getData();
				@SuppressWarnings("unchecked")
				List<Object> listMileAge = (List<Object>) dataMileAge.getData();
				for(int j=0;j<listGas.size();j++){
					double gas = (double) listGas.get(j);
					double mileAge = (double) listMileAge.get(j);
					if(mileAge==0){
						listGas.set(j, 0);
					}else{
						listGas.set(j, gas/mileAge*100);
					}
					
				}
				
			}
		}
		
		return gasMap;
	}
	
	//==========================================油耗统计  end==========================================================
	
	
	//==========================================在线统计 start==========================================================
	/**
	 * 查询组织的在线
	 * @param orgIds
	 * @param startDate
	 * @param endDate
	 * @param time
	 * @param request
	 * @return
	 * @author shaolinxing
	 * @time 2015年9月18日 上午9:32:11 
	 * @return Map<String,Object>
	 */
	@RequestMapping("/getonline")
	@ResponseBody
	public Map<String,Object> getOnlineForDay(@RequestParam(required=false) String carIds,
									   @RequestParam(required=false) String startDate,
									   @RequestParam(required=false) String endDate,
									   HttpServletRequest request){
		Map<String,Object> map = new HashMap<String,Object>();
		String[] strs = carIds.split(",");
		List<String> list = new ArrayList<String>();
		for(int i=0;i<strs.length;i++){
			if(!(strs[i].equals(",")))
				list.add(strs[i]);
		}
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		Date startTime = null;
		Date endTime = null;
		try {
			if(startDate!=null&&startDate!="")
			startTime = sf.parse(startDate);
			if(endDate!=null&&endDate!="")
			endTime = sf.parse(endDate);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}


		if(strs.length==1){
			map = dataService.getOnlineByDay(carIds,startTime);
			
		}
		else{
			map = dataService.getOnlineBuCar(list, startTime, endTime);
			
		}
		return map;
		
	}
	
	//==========================================在线统计  end==========================================================
}
