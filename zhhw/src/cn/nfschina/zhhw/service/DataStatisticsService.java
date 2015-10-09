package cn.nfschina.zhhw.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

public interface DataStatisticsService {


	public Map<String, Object> getMileAgeForTime(String carIds, Date startDate,Date endDate, String time);
	
	public Map<String, Object> getMileAgeForCars(List<String> carIds, Date startDate,Date endDate);
	
	public Map<String,Object> getOrgMileAgeForOrg(List<String> ids,Date startTime,Date endTime);
	
	public Map<String,Object> getOrgMileAgeForTime(String id,Date startTime,Date endTime,String type);
	
	public Map<String,Object> getGasForCars(List<String> carIds, Date startDate,Date endDate);
	
	public Map<String,Object> getGasForTime(String carid,Date startDate,Date endDate,String time);
	
	public Map<String,Object> getOrgGasForOrg(List<String> ids,Date startTime,Date endTime);
	
	public Map<String,Object> getOrgGasForTime(String id,Date startTime,Date endTime,String type);
	
	public Map<String,Object> getOnlineByDay(String id,Date date);
	
	public Map<String,Object> getOnlineBuCar(List<String> ids,Date startTime,Date endTime);
}
