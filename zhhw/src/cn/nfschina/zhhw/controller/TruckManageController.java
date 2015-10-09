package cn.nfschina.zhhw.controller;

import java.text.SimpleDateFormat;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.sun.org.apache.xerces.internal.impl.xpath.regex.ParseException;

import cn.nfschina.zhhw.model.TruckDynamic;
import cn.nfschina.zhhw.model.TruckInfo;
import cn.nfschina.zhhw.service.TruckDynamicService;
import cn.nfschina.zhhw.service.TruckManageService;
import net.sf.json.JSONArray;

@RequestMapping(value = "/truckmanage")
@Controller
public class TruckManageController {
	
	private static final String viewPrefix = "zhhw/infomanage/";
	
	@Resource
	private TruckManageService truckManageService;
	
	//视图前缀
	private static final String viewPrefix1 = "zhhw/truckmanager/";
	
	@Resource
	private TruckDynamicService truckDynamicService;
	
	//车辆地图动态信息界面
	@RequestMapping(value="/truckdynamic")
	public String showCarDynamic(HttpServletRequest request){
		return viewPrefix1+"truckmanager";
	}
	
	/*
	 * 获取所有车辆信息
	 */
	@RequestMapping(value = "/getAllTruckDynamic")
	@ResponseBody
	public List<TruckDynamic> getAllTruckDynamic(String plate_nos) throws java.text.ParseException{
		List<TruckDynamic> cds = truckDynamicService.getAllCarDynamic(plate_nos);
		cds = this.checkTruckStatus(cds);
		return cds;
	}
	
	//根据部门id获取车辆						   
	@RequestMapping(value="/getAllTruckByOrgId",method=RequestMethod.POST)
	@ResponseBody
	private Object getAllTruckByOrgId(@RequestParam String ids){
		List<TruckInfo> list = truckDynamicService.getAllTruckByOrgId(ids);
		JSONArray jsonArray = JSONArray.fromObject(list);
		String resultStr = jsonArray.toString();
		return JSON.parse(resultStr);
	}

	// 根据部门id获取车辆
	@RequestMapping(value = "/getAllTruckByOrgList", method = RequestMethod.POST)
	@ResponseBody
	private Object getAllTruckByOrgList(@RequestParam String ids) {
		List<TruckInfo> list = truckDynamicService.getAllTruckByOrgId(ids);
		JSONArray jsonArray = JSONArray.fromObject(list);
		String resultStr = jsonArray.toString();
		resultStr = resultStr.replaceAll("plate_no", "text");
		return JSON.parse(resultStr);
	}
	
//	//根据部门id获取车辆						   
//	@RequestMapping(value="/getAllTruckByOrgId",method=RequestMethod.POST)
//	@ResponseBody
//	private String getAllTruckByOrgId(@RequestParam String ids){
//		List<TruckInfo> list = truckDynamicService.getAllTruckByOrgId(ids);
//		JSONArray jsonArray = JSONArray.fromObject(list);
//		String resultStr = jsonArray.toString();
////		try {
////			resultStr = new String(resultStr.getBytes(),"iso8859-1");
////		} catch (UnsupportedEncodingException e) {
////			e.printStackTrace();
////		}
//		return resultStr;
//	}	
	
	//根据车牌号获取车辆信息
	@RequestMapping(value ="/getCarByPlateNo",method=RequestMethod.POST)
	@ResponseBody
	private ModelMap getCarByPlateNo(String plate_nos) throws java.text.ParseException{
		ModelMap map = new ModelMap();
		List<TruckDynamic> list = truckDynamicService.getAllCarDynamic(plate_nos);
		list = this.checkTruckStatus(list);
		if(list!=null){
			map.addAttribute("truckList", list);
			map.addAttribute("result", "success");
			map.addAttribute("message","车辆获取成功");
		}else{
			map.addAttribute("result", "error");
			map.addAttribute("message","车辆获取失败，请重新输入车牌号！");
		}
		return map;
	}
	
	//查询所有车辆的信息
	@ResponseBody
	@RequestMapping(value="/getAllTruck")
	public List<TruckInfo> findAllTruck(@ModelAttribute TruckInfo truckInfo) {
		List<TruckInfo> truckList = truckManageService.getAllTruck(truckInfo);
		for(int i=0;i<truckList.size();i++) {
			String org = truckManageService.getOrgName(truckList.get(i));
			String dev_name = truckManageService.getDevName(truckList.get(i));
			truckList.get(i).setOrg_name(org);
			truckList.get(i).setDev_name(dev_name);
		}
		return truckList;
	}
	
	//添加一条车辆信息
	@RequestMapping(value="toAddTruck")
	public String toAddTruck() {
		return viewPrefix + "/truck/addtruck";
		}
	@RequestMapping(value="/addTruck",method = RequestMethod.POST)
	@ResponseBody
	public ModelMap addTruck(@ModelAttribute TruckInfo truckInfo) {
		ModelMap modelMap = new ModelMap();
		truckManageService.addTruck(truckInfo);
		modelMap.addAttribute("success", Boolean.TRUE);
		return modelMap;
	}
		
	//修改一条车辆信息
	@RequestMapping(value="/toUpdateTruck")
	public String toUpdateTruck(@ModelAttribute TruckInfo truckInfo,HttpServletRequest request) {
		ServletRequestDataBinder binder = new ServletRequestDataBinder(truckInfo);
		binder.bind(request);
		return viewPrefix + "/truck/updatetruck";
	}
	@RequestMapping(value="/updTruck",method = RequestMethod.POST)
	@ResponseBody
	public ModelMap updateTruck(@ModelAttribute TruckInfo truckInfo) {
		ModelMap modelMap = new ModelMap();
		truckManageService.updTruck(truckInfo);
		modelMap.addAttribute("success", Boolean.TRUE);
		return modelMap;
	}
		
	//删除一条车辆信息
	@RequestMapping(value="/delTruck",method = RequestMethod.POST)
	@ResponseBody
	public ModelMap delTruck(@RequestParam String trucks) {
		ModelMap modelMap = new ModelMap();
		JSONArray json =JSONArray.fromObject(trucks);
		List<Object> list = JSONArray.toList(json, TruckInfo.class);
		for (int i = 0; i < list.size(); i++) {
			TruckInfo truckInfo = (TruckInfo) list.get(i);
			truckManageService.delTruck(truckInfo);
		}
		modelMap.addAttribute("success", Boolean.TRUE);
		return modelMap;
	}
	
	@SuppressWarnings("unused")
	private List<TruckDynamic> checkTruckStatus(List<TruckDynamic> DynamicList) throws java.text.ParseException{
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		Long currentMillion = System.currentTimeMillis();
		Long circle = 1800000L;//暂时设为30分钟循环一次
		if (!DynamicList.isEmpty() && null != DynamicList) {
			for (TruckDynamic truckDynamic : DynamicList) {
				String createTime = truckDynamic.getCreateTime();
				try {
					long millionSeconds = sdf.parse(createTime).getTime();
					if (currentMillion-millionSeconds>circle) {
						truckDynamic.setDeviceStatus("2");
					}else{
						truckDynamic.setDeviceStatus("1");
					}
				} catch (ParseException e) {
					e.printStackTrace();
				}
			}
		}
		return DynamicList;
	}
}
