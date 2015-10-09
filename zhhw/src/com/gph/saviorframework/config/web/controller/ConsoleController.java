package com.gph.saviorframework.config.web.controller;

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
import com.gph.saviorframework.config.service.ConsoleService;

@Controller
@RequestMapping("/" + Constants.FRAMEWORK_REQUEST_PATH + "/console")
public class ConsoleController {

	/** 日志输出 */
	final Logger logger = LoggerFactory.getLogger(ConsoleController.class);

	/** 视图前缀 */
	private String viewPrefix = Constants.FRAMEWORK_REQUEST_PATH + "/" + Constants.MODULE_CATEGORY_CONFIG + "/console/console_";

	/** 服务 */
	@Autowired
	private ConsoleService logService;

	/**
	 * 返回查看页面
	 * 
	 * @return 查看页面视图名称
	 * @throws SaviorFrameworkException
	 */
	@RequestMapping(value = "/view", method = RequestMethod.GET)
	public String view() throws SaviorFrameworkException {
		return viewPrefix + "view";
	}

	@RequestMapping(value = "/view/{row}", method = RequestMethod.GET)
	@ResponseBody
	public ModelMap view(@PathVariable("row") Integer row, ModelMap modelMap) throws SaviorFrameworkException {
		try {
			modelMap.addAttribute("success", Boolean.TRUE);
			modelMap.addAttribute(Constants.DEFAULT_RECORD_MODEL_KEY, logService.find(row));
		} catch (Exception e) {
			e.printStackTrace();
			modelMap.addAttribute("success", Boolean.FALSE);
			modelMap.addAttribute("error", ErrorCode.UNCAUGHT_EXCEPTION);
		}
		return modelMap;
	}
}
