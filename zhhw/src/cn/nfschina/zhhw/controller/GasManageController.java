package cn.nfschina.zhhw.controller;

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

import cn.nfschina.zhhw.model.GasInfo;
import cn.nfschina.zhhw.service.GasManageService;
import net.sf.json.JSONArray;

@RequestMapping(value = "/gasmanage")
@Controller
public class GasManageController {
	
	private static final String viewPrefix = "zhhw/infomanage/";
	
	@Resource
	private GasManageService gasManageService;
	
	@ResponseBody
	@RequestMapping(value="/getAllGas")
	public List<GasInfo> getAllGas(@ModelAttribute GasInfo gasInfo) {
		List<GasInfo> gasList = gasManageService.getAllGas(gasInfo);
		for(int i=0;i<gasList.size();i++) {
			String plateno = gasManageService.getPlateno(gasList.get(i));
			String driver_name = gasManageService.getDriverName(gasList.get(i));
			String user_name = gasManageService.getUserName(gasList.get(i));
			gasList.get(i).setPlateno(plateno);
			gasList.get(i).setDriver_name(driver_name);
			gasList.get(i).setUser_name(user_name);
		}
		return gasList;
	}
	
		//添加一条加油信息
	@RequestMapping(value="toAddGas")
	public String toAddGas() {
		return viewPrefix + "/gas/addgas";
	}
	@RequestMapping(value="/addGas",method = RequestMethod.POST)
	@ResponseBody
	public ModelMap addGas(@ModelAttribute GasInfo gasInfo) {
		ModelMap modelMap = new ModelMap();
		gasManageService.addGas(gasInfo);
		modelMap.addAttribute("success", Boolean.TRUE);
		return modelMap;
	}
		
		//修改一条加油信息
	@RequestMapping(value="/toUpdateGas")
	public String toUpdateGas(@ModelAttribute GasInfo gasInfo,HttpServletRequest request) {
		ServletRequestDataBinder binder = new ServletRequestDataBinder(gasInfo);
		binder.bind(request);
		return viewPrefix + "/gas/updategas";
		}
		@RequestMapping(value="/updGas",method = RequestMethod.POST)
		@ResponseBody
		public ModelMap updGas(@ModelAttribute GasInfo gasInfo) {
			ModelMap modelMap = new ModelMap();
		gasManageService.updGas(gasInfo);
		modelMap.addAttribute("success", Boolean.TRUE);
		return modelMap;
	}
		
	//删除一条油气信息
	@RequestMapping(value="/delGas",method = RequestMethod.POST)
	@ResponseBody
	public ModelMap deleteGas(@RequestParam String gas) {
		ModelMap modelMap = new ModelMap();
		JSONArray json =JSONArray.fromObject(gas);
		List<Object> list = JSONArray.toList(json, GasInfo.class);
		for (int i = 0; i < list.size(); i++) {
			GasInfo gasInfo = (GasInfo) list.get(i);
			gasManageService.delGas(gasInfo);
		}
			modelMap.addAttribute("success", Boolean.TRUE);
			return modelMap;
	}
	
	
}
