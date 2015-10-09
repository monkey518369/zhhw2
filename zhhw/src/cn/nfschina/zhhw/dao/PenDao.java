package cn.nfschina.zhhw.dao;

import java.util.List;

import cn.nfschina.zhhw.model.LinePoint;
import cn.nfschina.zhhw.model.Pen;
import cn.nfschina.zhhw.model.PenPoint;
import cn.nfschina.zhhw.model.Position;

public interface PenDao {
	public List<Pen> getPen(Pen pen);

	public Long addFence(Pen pen);

	public void delFence(Pen pen);

	public void udpFence(Pen pen);

	public void addFencePoint(Long fenceid, PenPoint point);

	public List<PenPoint> getFencePoint(PenPoint point);

	public void delFencePoint(Long fenceid);

	public void addLinePoint(Long lineid, LinePoint point);
	
}
