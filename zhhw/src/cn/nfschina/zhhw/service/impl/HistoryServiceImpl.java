package cn.nfschina.zhhw.service.impl;

import javax.annotation.Resource;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.nfschina.zhhw.dao.LineDao;
import cn.nfschina.zhhw.dao.PenDao;
import cn.nfschina.zhhw.model.LinePoint;
import cn.nfschina.zhhw.model.PenPoint;
import cn.nfschina.zhhw.service.HistoryService;
@Service
public class HistoryServiceImpl implements HistoryService{
	@Resource
	private PenDao penDao;
	@Resource
	private LineDao lineDao;
	@Override
	@Transactional
	public void drawFence(Long fenceid, Object[] points) {
		penDao.delFencePoint(fenceid);
		for(int i=0;i<points.length;i++){
			JSONObject jso = (JSONObject) points[i];
			PenPoint point =new PenPoint();
			point.setFk_pen_id(fenceid);
			point.setLat(Float.valueOf(jso.getString("lat")));
			point.setLng(Float.valueOf(jso.getString("lng")));
			penDao.addFencePoint(fenceid,point);
			
		}
		
	}
	@Override
	public void drawLine(Long lineid, Object[] points) {
		lineDao.delLinePoint(lineid);
		for(int i=0;i<points.length;i++){
			JSONObject jso = (JSONObject) points[i];
			LinePoint point =new LinePoint();
			point.setFk_line_id(lineid);
			point.setLat(Float.valueOf(jso.getString("lat")));
			point.setLng(Float.valueOf(jso.getString("lng")));
			penDao.addLinePoint(lineid, point);
			
		}
	}

}
