package cn.nfschina.zhhw.dao.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import cn.nfschina.zhhw.dao.BaseDao;
import cn.nfschina.zhhw.dao.CarWarningDao;
import cn.nfschina.zhhw.model.CarWarning;

@SuppressWarnings("unchecked")
@Repository
public class CarWarningDaoImpl extends BaseDao implements CarWarningDao{
	
	@Override
	public List<CarWarning> getAllCarWarning() {
		return this.getSqlMapClientTemplate().queryForList("getAllCarWarning");
	}

	@Override
	public int updCarWarning(String describe,String fk_handman,String id) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("describe", describe);
		map.put("fk_handman", fk_handman);
		map.put("id", id);
		return this.getSqlMapClientTemplate().update("updateCarWarning", map);
	}

	//===========================================shaolinxing start===========================================
	@Override
	public int getAlarmByTimeType(String id, Date startDate,
			Date endDate, String type) {
		Map<String,Object> map = new HashMap<String,Object>();
		int count = 0;
		if(startDate.equals(endDate)){
			map.put("id", id);
			map.put("startDate", startDate);
			map.put("type", type);
			count = (int)this.getSqlMapClientTemplate().queryForObject("getWarningCountByTimeType1",map);
		}else{
			map.put("id", id);
			map.put("startDate", startDate);
			map.put("endDate", endDate);
			map.put("type", type);
			count = (int)this.getSqlMapClientTemplate().queryForObject("getWarningCountByTimeType2", map);
		}
		
		
		return count;
	}
	//==========================================shaolinxing end==============================================
}
