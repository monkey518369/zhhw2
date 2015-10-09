package cn.nfschina.zhhw.controller;

import java.util.Date;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cn.nfschina.zhhw.dao.DateTimeDao;

@Service
public class DatastatisticsTollsController {


	@Resource
	private DateTimeDao dateTimeDao;
	
	/**
	 * 构造一个时间
	 * @param date
	 * @param timeParty
	 * @param sb
	 * @return
	 * @author shaolinxing
	 * @time 2015年9月22日 下午2:56:12 
	 * @return Date
	 */
	@SuppressWarnings("deprecation")
	public Date initiateDate(Date date,String timeParty,StringBuffer sb){
		
		if(sb==null){
			sb = new StringBuffer();
		}
		
		switch(timeParty){
			
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
				sb.append("'").append(date.getDate()).append("',");
				date = dateTimeDao.getNextDay(date);
				date = initiateDay(date);
				break;
			case "小时":
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
	
	/**
	 * 根据一个时间构造一个和她相等的时间;
	 * @param date
	 * @return
	 * @author shaolinxing
	 * @time 2015年9月24日 下午4:52:39 
	 * @return Date
	 */
	@SuppressWarnings("deprecation")
	public Date equalDate(Date date){
		Date newDate = new Date();
		
		newDate.setYear(date.getYear());
		newDate.setMonth(date.getMonth());
		newDate.setDate(date.getDate());
		newDate.setHours(0);
		newDate.setMinutes(0);
		newDate.setSeconds(0);
		return newDate;
	}
	
}
