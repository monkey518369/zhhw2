package cn.nfschina.zhhw.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

public interface AlarmDatastatisticsService {

	public Map<String,Object> getAlarmForCar(String id,Date startDate,Date endDate,String timeParty,List<String> types);
	
	public Map<String,Object> getAlarmForOrg(String id,Date startDate,Date endDate,String timeParty,List<String> types);
}
