package cn.nfschina.zhhw.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.nfschina.zhhw.service.GarbageDatastatisticsService;
import cn.nfschina.zhhw.util.TransactionCode;


@RequestMapping("/garbagedatastatistics")
@Controller
public class GarbageDatastatisticsController {

	private static String path = "zhhw/datastatistics/";
	
	@Resource
	private GarbageDatastatisticsService garbageService;
	
	@RequestMapping("/togarbagedatastatistics")
	public String toGarbageDatastatistics(){
		return path + "garbage";
	}
	
	/**
	 * 
	 * @param ids
	 * @param startDate
	 * @param endDate
	 * @param time
	 * @return
	 * @author shaolinxing
	 * @time 2015年9月22日 下午9:14:39 
	 * @return Map<String,Object>
	 */
	@RequestMapping("/getgarbageforcar")
	@ResponseBody
	public Map<String,Object> getGarbageForCar(@RequestParam("ids")String ids,
											   @RequestParam("startDate")String startDate,
											   @RequestParam("endDate")String endDate,
											   @RequestParam("time")String time){
		
		Map<String,Object> map = new HashMap<String,Object>();
		String[] strs = ids.split(",");
		List<String> list = new ArrayList<String>();
		for(int i=0;i<strs.length;i++){
			if(!(strs[i].equals(",")))
				list.add(strs[i]);
		}
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
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
			map = garbageService.getGarbageForCarByTime(ids, startTime, endTime,time);
		}
		else{
			map = garbageService.getGarbageForCarByCars(list, startTime, endTime);
		}
		return map;
	}
	
	@RequestMapping("/getcarbagefororg")
	@ResponseBody
	public Map<String,Object> getGarbageForOrg(@RequestParam("ids")String ids,
											   @RequestParam("startDate")String startDate,
											   @RequestParam("endDate")String endDate,
											   @RequestParam("timeParty")String timeParty){
		Map<String,Object> map = new HashMap<String,Object>();
		String[] strs = ids.split(",");
		List<String> list = new ArrayList<String>();
		for(int i=0;i<strs.length;i++){
			if(!(strs[i].equals(",")))
				list.add(strs[i]);
		}
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		Date startTime = null;
		Date endTime = null;
		try {
			startTime = sf.parse(startDate);
			endTime = sf.parse(endDate);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		timeParty = TransactionCode.transaction(timeParty);

		map = garbageService.getGarbageForOrgByTime(list, startTime, endTime, timeParty);
		return map;
	}
	
	
	
}
