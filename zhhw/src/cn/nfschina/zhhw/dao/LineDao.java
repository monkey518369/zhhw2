package cn.nfschina.zhhw.dao;

import java.util.List;

import cn.nfschina.zhhw.model.Line;
import cn.nfschina.zhhw.model.LinePoint;

public interface LineDao {
	public List<Line> getLine(Line line);

	public Long addLine(Line line);

	public void delLine(Line line);

	public void udpLine(Line line);

	public void addLinePoint(Long fenceid, LinePoint point);

	public List<LinePoint> getLinePoint(LinePoint point);

	public void delLinePoint(Long lineid);
	
}
