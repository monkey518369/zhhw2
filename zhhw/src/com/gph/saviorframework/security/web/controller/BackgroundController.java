package com.gph.saviorframework.security.web.controller;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.gph.saviorframework.SaviorFrameworkException;
import com.gph.saviorframework.common.model.Menu;
import com.gph.saviorframework.security.service.MenuService;
import com.gph.saviorframework.security.util.SecurityUtils;

@Controller
public class BackgroundController {

	@Autowired
	private MenuService menuService;
	
	@Autowired
	private SecurityUtils securityUtils;
	
	/**
	 * 返回列表页面
	 * 
	 * @return 列表页面视图名称
	 * @throws SaviorFrameworkException
	 */
	@RequestMapping(value = "/left", method = RequestMethod.GET)
	public ModelAndView left() throws SaviorFrameworkException {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("left");
		
		Map<Menu, List<Menu>> map = new LinkedHashMap<Menu, List<Menu>>();
		
		List<Menu> parents = menuService.findParentMenu();
		
		for (Menu menu : parents) {
			map.put(menu, menuService.findMenuByParent(menu.getId()));
		}
		
		mv.addObject("map", map);
		return mv;
	}
	
	@RequestMapping(value = "/center", method = RequestMethod.GET)
	public ModelAndView list() throws SaviorFrameworkException {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("center");
		
		mv.addObject("user", securityUtils.getUser());
		
		return mv;
	}
}
