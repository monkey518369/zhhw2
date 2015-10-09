package cn.nfschina.zhhw.dao;

import java.util.Date;
import java.util.List;

import cn.nfschina.zhhw.model.DataStatisticsModel;

public interface DataStatisticsDao {

	public DataStatisticsModel getMileAgeStart(String id,Date startTime, Date endTime);
	
	public DataStatisticsModel getMileAgeEnd(String id,Date startTime,Date endTime);
	
	public List<DataStatisticsModel> getData(String id, Date startTime, Date endTime);
}
