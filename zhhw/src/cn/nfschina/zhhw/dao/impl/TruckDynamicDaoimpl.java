package cn.nfschina.zhhw.dao.impl;

import java.util.Arrays;
import java.util.List;
import org.springframework.stereotype.Repository;
import cn.nfschina.zhhw.dao.BaseDao;
import cn.nfschina.zhhw.dao.TruckDynamicDao;
import cn.nfschina.zhhw.model.TruckDynamic;
import cn.nfschina.zhhw.model.TruckInfo;
@SuppressWarnings("unchecked")
@Repository
public class TruckDynamicDaoimpl extends BaseDao implements TruckDynamicDao {


	@Override
	public List<TruckDynamic> getAllCarDynamic(String plate_nos) {
		List<String> list = null;
		if(plate_nos != null){
			list = Arrays.asList(plate_nos.split(","));
		}
		if(list == null){
			return this.getSqlMapClientTemplate().queryForList("getAllTruck",null);
		}else{
			return this.getSqlMapClientTemplate().queryForList("getAllTruckByPlateNo",list);
		}
	}

	@Override
	public List<TruckInfo> getAllTruckByOrgId(String ids) {
		List<String> list = Arrays.asList(ids.split(","));
		return this.getSqlMapClientTemplate().queryForList("getAllTruckByOrgId",list);
	}

	@Override
	public TruckDynamic getCarByPlateNo(String plate_no) {
		List<TruckDynamic> list = this.getSqlMapClientTemplate().queryForList("getCarByPlateNo",plate_no);
		if(list.size()>0){
			return list.get(0);
		}
		return null;
	}

}
