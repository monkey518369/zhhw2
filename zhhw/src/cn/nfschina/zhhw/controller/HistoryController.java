package cn.nfschina.zhhw.controller;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.nfschina.zhhw.dao.LineDao;
import cn.nfschina.zhhw.dao.PenDao;
import cn.nfschina.zhhw.dao.PositionDao;
import cn.nfschina.zhhw.model.Line;
import cn.nfschina.zhhw.model.Pen;
import cn.nfschina.zhhw.model.GridDateTable;
import cn.nfschina.zhhw.model.PenPoint;
import cn.nfschina.zhhw.model.LinePoint;
import cn.nfschina.zhhw.model.Position;
import cn.nfschina.zhhw.service.HistoryService;


/**
 * @Description: 历史轨迹回放的控制器
 * copyright nfschina
 * HistoryController.java
 * create on 2015年9月2日
 * @author wxy
 */
@RequestMapping(value = "/history")
@Controller
public class HistoryController {

	//历史轨迹回放视图前缀
	private static final String historyViewPrefix = "zhhw/carmap/";
	//围栏视图前缀
	private static final String fenceViewPrefix = "zhhw/fence/";
	//线路视图前缀
	private static final String lineViewPrefix = "zhhw/line/";
	
	@Resource
	private PositionDao positionDao;//位置信息相关的Dao
	@Resource
	private PenDao penDao;//围栏信息相关的Dao
	@Resource
	private LineDao lineDao;//历史轨迹恢复服务
	@Resource
	private HistoryService historyService;//历史轨迹恢复服务
	
	/**
	 * 返回历史轨迹恢复的URL
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/gethistory")
	public String getHistory(HttpServletRequest request){
		//List<CarDynamic> cds = getAllCarDynamic();
		//request.setAttribute("cds", cds);
		return historyViewPrefix+"history";
	}
	/**
	 * 获取围栏菜单的URL
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/getFenceMenu")
	public String getFenceMenu(HttpServletRequest request){
		//List<CarDynamic> cds = getAllCarDynamic();
		//request.setAttribute("cds", cds);
		return fenceViewPrefix+"fence";
	}
	/**
	 * 获取指定车辆的所有位置
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/getPosition")
	@ResponseBody
	public List<Position> getPosition(HttpServletRequest request){
		String carid = request.getParameter("carid");
		String starttime = request.getParameter("starttime");
		String endtime = request.getParameter("endtime");
		Position pos = new Position();
		pos.setFk_car_id(Long.valueOf(carid));
		List<Position> list = positionDao.getPosition(pos,starttime,endtime);
		return list;
	}
	/**
	 * 获取所有的围栏
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/getFence")
	@ResponseBody
	public GridDateTable getFence(HttpServletRequest request){
		GridDateTable penTable = new GridDateTable();
		Pen pen = new Pen();
		List<Pen> rows = penDao.getPen(pen);
		penTable.setTotal(rows.size());
		penTable.setRows(rows);
		return penTable;
	}
	
	/**
	 * 跳转到添加围栏的url
	 * @return
	 */
	@RequestMapping(value="toAddFence")
	public String toAddFence() {
		return fenceViewPrefix+"addFence";
	}
	/**
	 * 添加围栏的url
	 * @return
	 */
	@RequestMapping(value="addFence")
	@ResponseBody
	public ModelMap addFence(Pen pen) {
		ModelMap modelMap = new ModelMap();
		this.penDao.addFence(pen);
		modelMap.addAttribute("success", Boolean.TRUE);
		return modelMap;
	}
	/**
	 * 删除指定围栏
	 * @param id
	 * @return
	 */
	@RequestMapping(value="delFence")
	@ResponseBody
	public ModelMap delFence(Long id) {
		ModelMap modelMap = new ModelMap();
		Pen pen = new Pen();
		pen.setId(id);
		this.penDao.delFence(pen);
		modelMap.addAttribute("success", Boolean.TRUE);
		return modelMap;
	}
	
	/**
	 * 跳转到更新围栏的url
	 * @return
	 */
	@RequestMapping(value="toUdpFence")
	public String toUdpFence() {
		return fenceViewPrefix+"updFence";
	}
	/**
	 * 更新围栏
	 * @return
	 */
	@RequestMapping(value="udpFence")
	@ResponseBody
	public ModelMap udpFence(Pen pen) {
		ModelMap modelMap = new ModelMap();
		this.penDao.udpFence(pen);
		modelMap.addAttribute("success", Boolean.TRUE);
		return modelMap;
	}
	/**
	 * 添加围栏的顶点
	 * @return
	 */
	@RequestMapping(value="drawFence")
	@ResponseBody
	public ModelMap drawFence(HttpServletRequest request) {
		String fenceid = request.getParameter("fenceid");
		String fencepoints = request.getParameter("fencepoints");
		JSONArray jsonArray = JSONArray.fromObject(fencepoints);
		Object[] points = jsonArray.toArray();
		historyService.drawFence(Long.valueOf(fenceid),points);
		ModelMap modelMap = new ModelMap();
		modelMap.addAttribute("success", Boolean.TRUE);
		return modelMap;
	}
	/**
	 * 获取围栏的所有顶点
	 * @param request
	 * @return
	 */
	@RequestMapping(value="getFencePoint")
	@ResponseBody
	public List<PenPoint> getFencePoint(HttpServletRequest request){
		String fenceid = request.getParameter("fenceid");
		PenPoint point = new PenPoint();
		point.setFk_pen_id(Long.valueOf(fenceid));
		List<PenPoint> list = penDao.getFencePoint(point);
		return list;
	}

	
	
	/**
	 * 获取围栏菜单的URL
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/getLineMenu")
	public String getLineMenu(HttpServletRequest request){
		//List<CarDynamic> cds = getAllCarDynamic();
		//request.setAttribute("cds", cds);
		return lineViewPrefix+"line";
	}

	/**
	 * 获取所有的围栏
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/getLine")
	@ResponseBody
	public GridDateTable getLine(HttpServletRequest request){
		GridDateTable lineTable = new GridDateTable();
		Line line = new Line();
		List<Line> rows = lineDao.getLine(line);
		lineTable.setTotal(rows.size());
		lineTable.setRows(rows);
		return lineTable;
	}
	
	/**
	 * 跳转到添加围栏的url
	 * @return
	 */
	@RequestMapping(value="toAddLine")
	public String toAddLine() {
		return lineViewPrefix+"addLine";
	}
	/**
	 * 添加围栏的url
	 * @return
	 */
	@RequestMapping(value="addLine")
	@ResponseBody
	public ModelMap addLine(Line line) {
		ModelMap modelMap = new ModelMap();
		this.lineDao.addLine(line);
		modelMap.addAttribute("success", Boolean.TRUE);
		return modelMap;
	}
	/**
	 * 删除指定围栏
	 * @param id
	 * @return
	 */
	@RequestMapping(value="delLine")
	@ResponseBody
	public ModelMap delLine(Long id) {
		ModelMap modelMap = new ModelMap();
		Line line = new Line();
		line.setId(id);
		this.lineDao.delLine(line);
		modelMap.addAttribute("success", Boolean.TRUE);
		return modelMap;
	}
	
	/**
	 * 跳转到更新围栏的url
	 * @return
	 */
	@RequestMapping(value="toUdpLine")
	public String toUdpLine() {
		return lineViewPrefix+"updLine";
	}
	/**
	 * 更新围栏
	 * @return
	 */
	@RequestMapping(value="udpLine")
	@ResponseBody
	public ModelMap udpLine(Line line) {
		ModelMap modelMap = new ModelMap();
		this.lineDao.udpLine(line);
		modelMap.addAttribute("success", Boolean.TRUE);
		return modelMap;
	}
	/**
	 * 添加围栏的顶点
	 * @return
	 */
	@RequestMapping(value="drawLine")
	@ResponseBody
	public ModelMap drawLine(HttpServletRequest request) {
		String lineid = request.getParameter("lineid");
		String linepoints = request.getParameter("linepoints");
		JSONArray jsonArray = JSONArray.fromObject(linepoints);
		Object[] points = jsonArray.toArray();
		historyService.drawLine(Long.valueOf(lineid),points);
		ModelMap modelMap = new ModelMap();
		modelMap.addAttribute("success", Boolean.TRUE);
		return modelMap;
	}
	/**
	 * 获取围栏的所有顶点
	 * @param request
	 * @return
	 */
	@RequestMapping(value="getLinePoint")
	@ResponseBody
	public List<LinePoint> getLinePoint(HttpServletRequest request){
		String lineid = request.getParameter("lineid");
		LinePoint point = new LinePoint();
		point.setFk_line_id(Long.valueOf(lineid));
		List<LinePoint> list = lineDao.getLinePoint(point);
		return list;
	}

}
