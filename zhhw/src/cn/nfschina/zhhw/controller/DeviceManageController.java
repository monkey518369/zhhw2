package cn.nfschina.zhhw.controller;

import java.text.SimpleDateFormat;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.expression.ParseException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.nfschina.zhhw.model.DeviceInfo;
import cn.nfschina.zhhw.model.DeviceStatus;
import cn.nfschina.zhhw.model.SecurityCheck;
import cn.nfschina.zhhw.model.TruckDynamic;
import cn.nfschina.zhhw.service.DeviceManageService;
import cn.nfschina.zhhw.service.TruckDynamicService;
import net.sf.json.JSONArray;

@RequestMapping(value = "/devicemanage")
@Controller
public class DeviceManageController {
	
	private static final String viewPrefix = "zhhw/infomanage/";
	
	@Resource
	private DeviceManageService deviceManageService;
	
	@Resource
	private TruckDynamicService truckDynamicService;
	
	//查询所有终端设备信息
	@RequestMapping(value="/getAllDevice")
	@ResponseBody
	public List<DeviceInfo> findAllDevice(@ModelAttribute DeviceInfo deviceInfo) {
		List<DeviceInfo> deviceList= deviceManageService.getAllDevice(deviceInfo);
		return deviceList;
	}
	
	//添加一条终端信息
	@RequestMapping(value="toAddDevice")
	public String toAddDevice() {
		return viewPrefix + "/device/adddevice";
	}
	
	@RequestMapping(value="/addDevice",method = RequestMethod.POST)
	@ResponseBody
	public ModelMap addDevice(@ModelAttribute DeviceInfo deviceInfo) {
		ModelMap modelMap = new ModelMap();
		deviceManageService.addDevice(deviceInfo);
		modelMap.addAttribute("success", Boolean.TRUE);
		return modelMap;
	}
		
	//修改一条终端信息
	@RequestMapping(value="/toUpdateDevice")
	public String toUpdateDevice(@ModelAttribute DeviceInfo deviceInfo,HttpServletRequest request) {
		ServletRequestDataBinder binder = new ServletRequestDataBinder(deviceInfo);
		binder.bind(request);
		return viewPrefix + "/device/updatedevice";
	}
	
	@RequestMapping(value="/updDevice",method = RequestMethod.POST)
	@ResponseBody
	public ModelMap updDevice(@ModelAttribute DeviceInfo deviceInfo) {
		ModelMap modelMap = new ModelMap();
			deviceManageService.updDevice(deviceInfo);
			modelMap.addAttribute("success", Boolean.TRUE);
			return modelMap;
		}
		
		//删除一条或多条终端信息
		@RequestMapping(value="/deleteDevice",method = RequestMethod.POST)
		@ResponseBody
		public ModelMap delDevice(@RequestParam String devices) {
			ModelMap modelMap = new ModelMap();
			JSONArray json =JSONArray.fromObject(devices);
			List<Object> list = JSONArray.toList(json, DeviceInfo.class);
			for (int i = 0; i < list.size(); i++) {
				DeviceInfo deviceInfo = (DeviceInfo) list.get(i);
				deviceManageService.delDevice(deviceInfo);
			}
			modelMap.addAttribute("success", Boolean.TRUE);
			return modelMap;
		}
		
	//作业状态列表
	@RequestMapping(value="/checkDeviceStatus")
	@ResponseBody
	public List<DeviceStatus> checkDeviceStatus(@ModelAttribute DeviceStatus deviceStatus){
		List<DeviceStatus> statusList = deviceManageService.checkDeviceStatus(deviceStatus);
		return statusList;
	}
	
	@RequestMapping(value="/deviceSecurityCheck")
	@ResponseBody
	public List<SecurityCheck> deviceSecurityCheck(@ModelAttribute SecurityCheck securityCheck){
		List<SecurityCheck> checkList = deviceManageService.deviceSecurityCheck(securityCheck);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		Long currentMillion = System.currentTimeMillis();
		Long circle = 1800000*2*24*7L;//一周没上线就算
		if (!checkList.isEmpty() && null != checkList) {
			for (SecurityCheck bean : checkList) {
				String createTime = bean.getCreatetime();
				try {
					long millionSeconds = sdf.parse(createTime).getTime();
					if (currentMillion-millionSeconds>circle) {
						bean.setStatus("设备正常");
					}else{
						bean.setStatus("设备失联");
					}
				} catch (java.text.ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return checkList;
	}
}
