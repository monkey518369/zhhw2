package cn.nfschina.zhhw.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

public interface OnlineDatastatisticsService {

	public Map<String,Object> getOnlineByDay(String id,Date date);
	
	public Map<String,Object> getOnlineTime(String id,Date startDate,Date endDate,String timeParty);
	
	public Map<String,Object> getOnlineTime(List<String> ids,Date startDate,Date endDate,String timeParty);
	
}
