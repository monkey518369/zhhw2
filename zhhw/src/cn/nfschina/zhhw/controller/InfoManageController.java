package cn.nfschina.zhhw.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.nfschina.zhhw.model.DeviceInfo;
import cn.nfschina.zhhw.model.EasyUITree;
import cn.nfschina.zhhw.model.GasInfo;
import cn.nfschina.zhhw.model.HitchInfo;
import cn.nfschina.zhhw.model.Org;
import cn.nfschina.zhhw.model.TruckInfo;
import cn.nfschina.zhhw.service.CarOrgService;
import cn.nfschina.zhhw.service.ComboboxService;
import cn.nfschina.zhhw.service.InfoManageService;
import cn.nfschina.zhhw.service.OrgInfoService;

import com.alibaba.fastjson.JSONObject;

/**
 * 
 * @author rjh
 * 信息管理
 */
@RequestMapping(value = "/infomanage")
@Controller
public class InfoManageController {  
	
	private static final String viewPrefix = "zhhw/infomanage/";
	
	@Resource
	private InfoManageService infoManageService;
	
	@Resource
	private CarOrgService carOrgService;
	
	@Resource
	private ComboboxService comboboxService;
	
	@Resource
	private OrgInfoService orgInfoService;
	
	
	//跳转终端管理页面
	@RequestMapping(value="/tagendmanage")
	public String showTopEnd(HttpServletRequest request){
		return viewPrefix+"tagendmanage";
	}
	
	//跳转车辆管理页面
	@RequestMapping(value="/truckmanage")
	public String showVehicle(HttpServletRequest request){
		return viewPrefix+"truckmanage";
	}
	
	//跳转加油管理页面
	@RequestMapping(value="/gasmanage")
	public String showGas(HttpServletRequest request){
		return viewPrefix+"gasmanage";
	}
	
	//跳转故障登记页面
	@RequestMapping(value="/breakdownmanage")
	public String showBreakdown(HttpServletRequest request){
		return viewPrefix+"breakdownmanage";
	}
	
	//跳转作业状态监控页面
	@RequestMapping(value="/devicestatusmanage")
	public String showDeviceStatus(HttpServletRequest request){
		return viewPrefix+"devicestatusManage";
	}
	//跳转防拆机保护监控页面
	@RequestMapping(value="/securitycheckmanage")
	public String showSecurityCheck(HttpServletRequest request){
		return viewPrefix+"securityCheckManage";
	}
	
	/**
	 * 
	 * @param groupName
	 * @param request
	 * @return
	 * @author shaolinxing
	 * @time 2015年9月14日 下午4:47:23 
	 * @return Object
	 */
	@ResponseBody
	@RequestMapping(value="/getcarbyorgid")
	public Object getGroupCar(@RequestParam("orgId")String orgId,HttpServletRequest request){
		
		Org org = orgInfoService.getOrgById(orgId);
		
		EasyUITree easyuiTree = new EasyUITree();
		
		easyuiTree.setId(org.getOrg_id());
		easyuiTree.setText(org.getOrg_name());
		easyuiTree.setState("open");
		
		Set<EasyUITree> set = new HashSet<EasyUITree>();
		
		carToEasyUITree(orgId,set);
		easyuiTree.setChildren(set);
		
		
		JSONArray ja = JSONArray.fromObject(easyuiTree);
		return ja;
	}
	
	/**
	 * 
	 * @param orgId
	 * @param listTree
	 * @author shaolinxing
	 * @time 2015年9月15日 下午4:40:53 
	 * @return void
	 */
	//把car转换成easyuitree
	public void carToEasyUITree(String orgId,Set<EasyUITree> listTree){
		
		List<TruckInfo> listCar = new ArrayList<TruckInfo>();
		
		listCar = infoManageService.getCarsByOrg(orgId);
		
		for(TruckInfo car : listCar){
			
			EasyUITree ui = new EasyUITree();
			ui.setId(car.getId()+"");
			ui.setText(car.getPlate_no());
			ui.setState("open");
			ui.setParentId(orgId);
			ui.setCheckbox(true);
			ui.setChildren(new HashSet<EasyUITree>());
			listTree.add(ui);
		}
		
	}
}
