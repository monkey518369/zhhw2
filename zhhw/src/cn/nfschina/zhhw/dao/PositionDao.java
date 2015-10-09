package cn.nfschina.zhhw.dao;

import java.util.List;

import cn.nfschina.zhhw.model.Position;

public interface PositionDao {
	public List<Position> getPosition(Position pos, String starttime, String endtime);
	
}
