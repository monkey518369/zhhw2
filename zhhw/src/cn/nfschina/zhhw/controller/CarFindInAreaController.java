package cn.nfschina.zhhw.controller;

import javax.annotation.Resource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import cn.nfschina.zhhw.service.TruckDynamicService;

/**
 * @Description: 区域找车控制器类（采用新的界面设计后，暂时不用）
 * @copyright: nfschina
 * @ClassName: CarFindInAreaController
 * @author wcy
 * @date 2015年9月10日 上午8:57:01
 */

@RequestMapping(value = "/carcontroller")
@Controller
public class CarFindInAreaController {
	
	//视图前缀
	private static final String viewPrefix = "zhhw/cardispatch/";
	
	@Resource
	private TruckDynamicService carDynamicService;
	
	/**
	* @Description: 获取区域找车模块的视图名
	* @Title: getViewName
	* @param 
	* @return String:试图名
	 */
	@RequestMapping(value = "/carfindinarea")
	private String getViewName(){
		return viewPrefix+"carfindinarea";
	}
}
