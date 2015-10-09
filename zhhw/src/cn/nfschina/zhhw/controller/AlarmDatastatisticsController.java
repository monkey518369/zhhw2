package cn.nfschina.zhhw.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.nfschina.zhhw.service.AlarmDatastatisticsService;
import cn.nfschina.zhhw.util.TransactionCode;

/**
 * 报警统计类
 * @author shaolinxing
 * @time 2015年9月23日 下午2:08:20
 */
@Controller
@RequestMapping("/alarmdatastatistics")
public class AlarmDatastatisticsController {

	
	private static String path = "zhhw/datastatistics/";
	
	@Resource
	private AlarmDatastatisticsService alarmService;
	
	//进入报警页面
	@RequestMapping("toalarm")
	public String toAlarm(){
		return path + "alarm";
	}
	
	/**
	 * 
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
	@RequestMapping("/getalarmforcar")
	@ResponseBody
	public Map<String,Object> getAlarmForCar(@RequestParam("id") String id,
											 @RequestParam("startDate") String startDate,
											 @RequestParam("endDate") String endDate,
											 @RequestParam("timeParty") String timeParty,
											 @RequestParam("alarmType") String alarmType,
											 HttpServletRequest request){
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		
		Date startTime = new Date();
		Date endTime = new Date();
		try {
			startTime = sf.parse(startDate);
			endTime = sf.parse(endDate);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		timeParty = TransactionCode.transaction(timeParty);
		String[] alarmTypes = alarmType.split(",");
		List<String>  types= Arrays.asList(alarmTypes);
		Map<String,Object> map = alarmService.getAlarmForCar(id, startTime, endTime, timeParty, types);
		
		return map;
		
	}
	
	/**
	 * 
	 * @param id
	 * @param startDate
	 * @param endDate
	 * @param timeParty
	 * @param alarmType
	 * @param request
	 * @return
	 * @author shaolinxing
	 * @time 2015年9月23日 下午9:34:28 
	 * @return Map<String,Object>
	 */
	@RequestMapping("/getalarmfororg")
	@ResponseBody
	public Map<String,Object> getAlarmForOrg(@RequestParam("id") String id,
											 @RequestParam("startDate") String startDate,
											 @RequestParam("endDate") String endDate,
											 @RequestParam("timeParty") String timeParty,
											 @RequestParam("alarmType") String alarmType,
											 HttpServletRequest request){
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		
		Date startTime = new Date();
		Date endTime = new Date();
		try {
			startTime = sf.parse(startDate);
			endTime = sf.parse(endDate);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		timeParty = TransactionCode.transaction(timeParty);
		String[] alarmTypes = alarmType.split(",");
		List<String>  types= Arrays.asList(alarmTypes);
		Map<String,Object> map = alarmService.getAlarmForOrg(id, startTime, endTime, timeParty, types);
		
		return map;
		
	}
	
}
