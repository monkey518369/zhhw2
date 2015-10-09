package cn.nfschina.zhhw.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.nfschina.zhhw.service.impl.OnlineDatastatisticsServiceImpl;
import cn.nfschina.zhhw.util.TransactionCode;

@RequestMapping("onlinedatastatistics")
@Controller
public class OnlineDatastatisticsController {
	
	private static String path = "zhhw/datastatistics/";
	
	@Resource
	private OnlineDatastatisticsServiceImpl onlineService;
	
	@RequestMapping("/toonline")
	public String toOnline(){
		return path + "online";
	}
	
	/**
	 * 根据天和id得到每天在线的饼图
	 * @param id
	 * @param strDate
	 * @param request
	 * @return
	 * @author shaolinxing
	 * @time 2015年9月25日 下午2:54:24 
	 * @return Map<String,Object>
	 */
	@RequestMapping("/online")
	@ResponseBody
	public Map<String,Object> getOnlineByDay(@RequestParam("id")String id,
											@RequestParam("date") String strDate,
											HttpServletRequest request){
		
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		try {
			date = sf.parse(strDate);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
		Map<String,Object> map = onlineService.getOnlineByDay(id, date);
		return map;
		
	}
	
	@RequestMapping("/onlinetime")
	@ResponseBody
	public Map<String,Object> getOnline(@RequestParam("id")String id,
										@RequestParam("startDate")String startDate,
										@RequestParam("endDate")String endDate,
										@RequestParam("timeParty")String timeParty,
										HttpServletRequest request){
		
		timeParty = TransactionCode.transaction(timeParty);
		
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		Date start = new Date();
		Date end = new Date();
		try {
			start = sf.parse(startDate);
			end = sf.parse(endDate);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String[] array = id.split(",");
		List<String> ids = new ArrayList<String>();
		for(int i=0;i<array.length;i++){
			ids.add(array[i]);
		}
		Map<String,Object> map = onlineService.getOnlineTime(ids, start, end, timeParty);
		
		return map;
	}
}
