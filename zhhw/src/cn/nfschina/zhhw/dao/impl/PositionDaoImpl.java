package cn.nfschina.zhhw.dao.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import cn.nfschina.zhhw.dao.BaseDao;
import cn.nfschina.zhhw.dao.PositionDao;
import cn.nfschina.zhhw.model.Position;

@Repository
public class PositionDaoImpl  extends BaseDao implements PositionDao{
	/* (non-Javadoc)
	 * @see cn.nfschina.zhhw.dao.PositionDao#getPosition(cn.nfschina.zhhw.model.Position)
	 */
	@Override
	public List<Position> getPosition(Position pos, String starttime, String endtime) {
		Map<String, Object> parameterMap = new HashMap<String, Object>();
		parameterMap.put("position", pos);
		parameterMap.put("starttime", starttime);
		parameterMap.put("endtime", endtime);
		try{
			return this.getSqlMapClientTemplate().queryForList("getPosition",parameterMap);
		}catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}


}
