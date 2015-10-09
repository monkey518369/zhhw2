package cn.nfschina.zhhw.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

public interface GarbageDatastatisticsService {

	
	public Map<String,Object> getGarbageForCarByTime(String id,Date startTime,Date endTime,String timeParty);
	
	public Map<String,Object> getGarbageForCarByCars(List<String> ids,Date startTime,Date endTime);
	
	public Map<String,Object> getGarbageForOrgByOrg(String id,Date startTime,Date endTime,String timeParty);
	
	public Map<String,Object> getGarbageForOrgByTime(List<String> id,Date startTime,Date endTime,String timeParty);
}
