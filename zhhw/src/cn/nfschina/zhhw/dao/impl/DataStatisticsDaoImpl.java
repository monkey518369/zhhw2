package cn.nfschina.zhhw.dao.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import cn.nfschina.zhhw.dao.BaseDao;
import cn.nfschina.zhhw.dao.DataStatisticsDao;
import cn.nfschina.zhhw.model.DataStatisticsModel;

@Repository
public class DataStatisticsDaoImpl extends BaseDao implements DataStatisticsDao{

	/**
	 * 得到开始时间统计的初始状态
	 * @param id
	 * @param startTime
	 * @param endTime
	 * @return
	 * @author shaolinxing
	 * @time 2015年9月10日 上午10:00:12 
	 * @return DataStatisticsModel
	 */
	@Override
	public DataStatisticsModel getMileAgeStart(String id,Date startTime, Date endTime) {
		// TODO Auto-generated method stub
		
		Map<String,String> hashMap = new HashMap<String,String>();
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		hashMap.put("starttime", sf.format(startTime));
		hashMap.put("endtime",sf.format(endTime));
		hashMap.put("id", id);
		
		
		DataStatisticsModel dataStatisticsModel = (DataStatisticsModel) this.getSqlMapClientTemplate().queryForObject("getstart",hashMap);
		
		
		return dataStatisticsModel;
	}

	/**
	 * 得到结束时间统计的结束状态
	 * @param id
	 * @param startTime
	 * @param endTime
	 * @return
	 * @author shaolinxing
	 * @time 2015年9月10日 上午10:00:12 
	 * @return DataStatisticsModel
	 */
	@Override
	public DataStatisticsModel getMileAgeEnd(String id, Date startTime, Date endTime) {
		// TODO Auto-generated method stub
		Map<String,Object> hashMap = new HashMap<String,Object>();
		hashMap.put("starttime", startTime);
		hashMap.put("endtime",endTime);
		hashMap.put("id", id);
		
		
		DataStatisticsModel dataStatisticsModel = (DataStatisticsModel) this.getSqlMapClientTemplate().queryForObject("getend",hashMap);
		
		
		return dataStatisticsModel;
	}

	@Override
	public List<DataStatisticsModel> getData(String id, Date startTime, Date endTime) {
		// TODO Auto-generated method stub
		Map<String,Object> hashMap = new HashMap<String,Object>();
		hashMap.put("starttime", startTime);
		hashMap.put("endtime",endTime);
		hashMap.put("id", id);
		
		
		List<DataStatisticsModel> dataStatisticsModels = (List<DataStatisticsModel>) this.getSqlMapClientTemplate().queryForList("getData",hashMap);
		
		
		return dataStatisticsModels;
	}


}
