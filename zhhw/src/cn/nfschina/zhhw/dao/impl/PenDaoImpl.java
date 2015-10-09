package cn.nfschina.zhhw.dao.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import cn.nfschina.zhhw.dao.BaseDao;
import cn.nfschina.zhhw.dao.PenDao;
import cn.nfschina.zhhw.model.LinePoint;
import cn.nfschina.zhhw.model.Pen;
import cn.nfschina.zhhw.model.PenPoint;

@Repository
public class PenDaoImpl  extends BaseDao implements PenDao{

	/* (non-Javadoc)
	 * @see cn.nfschina.zhhw.dao.PenDao#getPen(cn.nfschina.zhhw.dao.Pen)
	 */
	@Override
	public List<Pen> getPen(Pen pen) {
		return this.getSqlMapClientTemplate().queryForList("getPen",pen);
	}

	@Override
	public Long addFence(Pen pen) {
		return (Long)this.getSqlMapClientTemplate().insert("addPen", pen);
	}

	@Override
	public void delFence(Pen pen) {
		this.getSqlMapClientTemplate().delete("delPen",pen);
	}

	@Override
	public void udpFence(Pen pen) {
		this.getSqlMapClientTemplate().update("udpPen",pen);
	}

	@Override
	public void addFencePoint(Long fenceid, PenPoint point) {
		this.getSqlMapClientTemplate().insert("addFencePoint", point);
	}

	@Override
	public List<PenPoint> getFencePoint(PenPoint point) {
		return this.getSqlMapClientTemplate().queryForList("getFencePoint",point);
	}

	@Override
	public void delFencePoint(Long fenceid) {
		this.getSqlMapClientTemplate().delete("delFencePoint", fenceid);
	}

	@Override
	public void addLinePoint(Long lineid, LinePoint point) {
		this.getSqlMapClientTemplate().insert("addLinePoint", point);
	}
	
	
}
