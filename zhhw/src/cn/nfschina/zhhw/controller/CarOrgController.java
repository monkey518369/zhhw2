package cn.nfschina.zhhw.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.nfschina.zhhw.model.Org;
import cn.nfschina.zhhw.service.CarOrgService;

import com.alibaba.fastjson.JSON;

/**
 * @Description: 组织机构控制器
 * @copyright: nfschina
 * @ClassName: CarOrgController
 * @author wcy
 * @date 2015年9月10日 上午9:02:19
 */
@RequestMapping(value = "/carorg")
@Controller
public class CarOrgController {

	@Resource
	private CarOrgService carOrgService;
	
	/**
	* @Description: 获取easyui构建组织机构的json字符串
	* @Title: getOrgJson
	* @param 
	* @return String：json字符串
	 */
	@RequestMapping(value = "/getOrgJson")
	@ResponseBody
	private Object getOrgJson(){
		List<Org> list = carOrgService.getAllOrg();
		String str = carOrgService.getOrgJson(list);
		Object json = JSON.parse(str);
		return json;
	}
	
}
