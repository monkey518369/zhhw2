package cn.nfschina.zhhw.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.gph.saviorframework.common.model.User;
import com.gph.saviorframework.security.service.UserService;

import cn.nfschina.zhhw.model.DeviceInfo;
import cn.nfschina.zhhw.model.DriverInfo;
import cn.nfschina.zhhw.model.Org;
import cn.nfschina.zhhw.model.TruckInfo;
import cn.nfschina.zhhw.service.CarOrgService;
import cn.nfschina.zhhw.service.ComboboxService;
import cn.nfschina.zhhw.service.DeviceManageService;
import cn.nfschina.zhhw.service.DriverService;
import cn.nfschina.zhhw.service.TruckManageService;

@RequestMapping(value = "/combobox")
@Controller
public class ComboboxController {
	
	@Resource
	private ComboboxService comboboxService;
	
	@Resource
	private CarOrgService carOrgService;
	
	@Resource
	private DeviceManageService deviceService; 
	
	@Resource
	private TruckManageService truckService;
	
	@Resource
	private DriverService driverService;
	
	@Resource
	private UserService userService;
	
	//查询汽车所属公司的下拉列表
	@RequestMapping(value="/getTruckComnameList",method = RequestMethod.POST)
	@ResponseBody
	public Object getTruckComnameList() {
		List<Org> list =  carOrgService.getAllOrg();
		String comnameList = comboboxService.getJson(list);
		Object json = JSONObject.parse(comnameList);
		return json;
	}
	
	//查询汽车终端设备信息编号
	@RequestMapping(value="/getTruckDeviceList",method = RequestMethod.POST)
	@ResponseBody
	public Object getTruckDeviceList() {
		List<DeviceInfo> list =  deviceService.getAllDevice(null);
		String deviceList = comboboxService.getJson(list);
		Object json = JSONObject.parse(deviceList);
		return json;
	}
	
	//查询加油信息所有车辆车牌下拉列表
	@RequestMapping(value="/getGasPlateList",method = RequestMethod.POST)
	@ResponseBody
	public Object getGasPlateList(@ModelAttribute TruckInfo truckInfo) {
		List<TruckInfo> list =  truckService.getAllTruck(truckInfo);
		String truckList = comboboxService.getJson(list);
		Object json = JSONObject.parse(truckList);
		return json;
	}
	
	//查询加油信息所有司机的下拉列表
	@RequestMapping(value="/getGasDriverList",method = RequestMethod.POST)
	@ResponseBody
	public Object getGasDriverList() {
		List<DriverInfo> list =  driverService.getAllDriver();
		String driverList = comboboxService.getJson(list);
		Object json = JSONObject.parse(driverList);
		return json;
	}
	
	
}
