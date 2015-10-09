package cn.nfschina.zhhw.dao.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import cn.nfschina.zhhw.dao.BaseDao;
import cn.nfschina.zhhw.dao.LineDao;
import cn.nfschina.zhhw.model.Line;
import cn.nfschina.zhhw.model.LinePoint;

@Repository
public class LineDaoImpl  extends BaseDao implements LineDao{

	/* (non-Javadoc)
	 * @see cn.nfschina.zhhw.dao.LineDao#getLine(cn.nfschina.zhhw.dao.Line)
	 */
	@Override
	public List<Line> getLine(Line line) {
		return this.getSqlMapClientTemplate().queryForList("getLine",line);
	}

	@Override
	public Long addLine(Line line) {
		return (Long)this.getSqlMapClientTemplate().insert("addLine", line);
	}

	@Override
	public void delLine(Line line) {
		this.getSqlMapClientTemplate().delete("delLine",line);
	}

	@Override
	public void udpLine(Line line) {
		this.getSqlMapClientTemplate().update("udpLine",line);
	}

	@Override
	public void addLinePoint(Long fenceid, LinePoint point) {
		this.getSqlMapClientTemplate().insert("addLinePoint", point);
	}

	@Override
	public List<LinePoint> getLinePoint(LinePoint point) {
		return this.getSqlMapClientTemplate().queryForList("getLinePoint",point);
	}

	@Override
	public void delLinePoint(Long fenceid) {
		this.getSqlMapClientTemplate().delete("delLinePoint", fenceid);
	}
	
	
}
