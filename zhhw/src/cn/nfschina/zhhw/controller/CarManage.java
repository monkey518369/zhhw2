package cn.nfschina.zhhw.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping(value = "/carmanage")
@Controller
public class CarManage {

	private static final String viewPrefix = "zhhw/truckmanager/";
							  
	@RequestMapping(value = "/cardispatch")
	private String getViewName(){
		return viewPrefix+"cardispatch";
	}
	
}
