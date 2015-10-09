package com.gph.saviorframework.security.web.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gph.saviorframework.Constants;
import com.gph.saviorframework.ErrorCode;
import com.gph.saviorframework.SaviorFrameworkException;
import com.gph.saviorframework.security.service.PositionLevelService;

/**
 * 
 */
@Controller
@RequestMapping("/" + Constants.FRAMEWORK_REQUEST_PATH + "/positionlevel")
public class PositionLevelController {

	/** 日志输出 */
	final Logger logger = LoggerFactory.getLogger(PositionLevelController.class);

	/** 服务 */
	@Autowired
	private PositionLevelService positionLevelService;

	/**
	 * 返回所有岗位级别信息.
	 * 
	 * @param modelMap
	 * @return
	 * @throws SaviorFrameworkException
	 */
	@RequestMapping(value = "/get", method = RequestMethod.GET)
	@ResponseBody
	public ModelMap get(ModelMap modelMap) throws SaviorFrameworkException {
		try {
			modelMap.addAttribute("success", Boolean.TRUE);
			modelMap.addAttribute(Constants.DEFAULT_RECORD_MODEL_KEY, positionLevelService.findMap());
		} catch (Exception e) {
			e.printStackTrace();
			modelMap.addAttribute("success", Boolean.FALSE);
			modelMap.addAttribute("error", ErrorCode.UNCAUGHT_EXCEPTION);
		}
		return modelMap;
	}
	
	@RequestMapping(value = "/get2", method = RequestMethod.GET)
	@ResponseBody
	public void get2(HttpServletResponse response) throws SaviorFrameworkException, IOException {
		JSONArray jsonArray = JSONArray.fromObject(positionLevelService.findMap2());
		response.getWriter().write(jsonArray.toString());
	}

	@RequestMapping(value = "/{position}/get", method = RequestMethod.GET)
	@ResponseBody
	public ModelMap getByPosition(@PathVariable("position") String position, ModelMap modelMap) throws SaviorFrameworkException {
		try {
			modelMap.addAttribute("success", Boolean.TRUE);
			modelMap.addAttribute(Constants.DEFAULT_RECORD_MODEL_KEY, positionLevelService.findByPosition(position));
		} catch (Exception e) {
			e.printStackTrace();
			modelMap.addAttribute("success", Boolean.FALSE);
			modelMap.addAttribute("error", ErrorCode.UNCAUGHT_EXCEPTION);
		}
		return modelMap;
	}
	
	@RequestMapping(value = "/{position}/get2", method = RequestMethod.GET)
	@ResponseBody
	public void getByPosition2(@PathVariable("position") String position, HttpServletResponse response) throws SaviorFrameworkException, IOException {
		JSONArray jsonArray = JSONArray.fromObject(positionLevelService.findByPosition2(position));
		response.getWriter().write(jsonArray.toString());
	}
}
