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

import com.sun.star.frame.TitleChangedEvent;

import cn.nfschina.zhhw.model.HitchInfo;
import cn.nfschina.zhhw.service.HitchManageService;
import net.sf.json.JSONArray;

@RequestMapping(value = "/hitchmanage")
@Controller
public class HitchManageController {
	
	private static final String viewPrefix = "zhhw/infomanage/";
	
	@Resource
	private HitchManageService hitchManageService;
	
	//查询所有故障登记信息
	@ResponseBody
	@RequestMapping(value="/getAllHitch")
	public List<HitchInfo> findAllBreakdown(@ModelAttribute HitchInfo hitchInfo) {
		List<HitchInfo> hitchList = hitchManageService.getAllHitch(hitchInfo);
		for(int i=0;i<hitchList.size();i++) {
			String plateno = hitchManageService.getPlateNo(hitchList.get(i));
			hitchList.get(i).setPlateno(plateno);
		}
		return hitchList;
	}
	
	//添加一条故障信息
		@RequestMapping(value="toAddHitch")
		public String toAddHitch() {
			return viewPrefix + "/hitch/addhitch";
		}
		@RequestMapping(value="/addHitch",method = RequestMethod.POST)
		@ResponseBody
		public ModelMap addHitch(@ModelAttribute HitchInfo hitchInfo) {
			ModelMap modelMap = new ModelMap();
			hitchManageService.addHitch(hitchInfo);
			modelMap.addAttribute("success", Boolean.TRUE);
			return modelMap;
		}
		
		//修改一条故障信息
		@RequestMapping(value="/toUpdateHitch")
		public String toUpdateHitch(@ModelAttribute HitchInfo hitchInfo,HttpServletRequest request) {
			ServletRequestDataBinder binder = new ServletRequestDataBinder(hitchInfo);
			binder.bind(request);
			return viewPrefix + "/hitch/updatehitch";
		}
		@RequestMapping(value="/updHitch",method = RequestMethod.POST)
		@ResponseBody
		public ModelMap updeHitch(@ModelAttribute HitchInfo hitchInfo) {
			ModelMap modelMap = new ModelMap();
			hitchManageService.updHitch(hitchInfo);
			modelMap.addAttribute("success", Boolean.TRUE);
			return modelMap;
		}
		
		//删除一条或多条故障登记信息
		@RequestMapping(value="/delHitch",method = RequestMethod.POST)
		@ResponseBody
		public ModelMap delHitch(@RequestParam String hitchs) {
			ModelMap modelMap = new ModelMap();
			JSONArray json =JSONArray.fromObject(hitchs);
			List<Object> list = JSONArray.toList(json, HitchInfo.class);
			for (int i = 0; i < list.size(); i++) {
				HitchInfo hitchInfo = (HitchInfo) list.get(i);
				hitchManageService.delHitch(hitchInfo);
			}
			modelMap.addAttribute("success", Boolean.TRUE);
			return modelMap;
		}
}
