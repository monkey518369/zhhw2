package cn.nfschina.zhhw.dao.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import cn.nfschina.zhhw.dao.BaseDao;
import cn.nfschina.zhhw.dao.GarbageDatastatisticsDao;
import cn.nfschina.zhhw.model.GarbageModel;

@Repository
public class GarbageDatastatisticsDaoImpl extends BaseDao implements GarbageDatastatisticsDao {

	@SuppressWarnings("unchecked")
	@Override
	public List<GarbageModel> getGarbageByTimeForCar(Date startDate,
			Date endDate, String id) {
		// TODO Auto-generated method stub
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("id", id);
		map.put("starttime",startDate );
		map.put("endtime", endDate);
		
		List<GarbageModel> list = this.getSqlMapClientTemplate().queryForList("getGarbageByCarForTime", map);
		
		return list;
	}

}
