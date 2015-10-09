package cn.nfschina.zhhw.dao;

import java.util.Date;
import java.util.List;

import cn.nfschina.zhhw.model.GarbageModel;

public interface GarbageDatastatisticsDao {

	public List<GarbageModel> getGarbageByTimeForCar(Date startDate,Date endDate,String id);
}
