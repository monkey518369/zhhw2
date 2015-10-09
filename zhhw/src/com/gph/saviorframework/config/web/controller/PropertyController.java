package com.gph.saviorframework.config.web.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate3.HibernateOptimisticLockingFailureException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gph.saviorframework.Constants;
import com.gph.saviorframework.ErrorCode;
import com.gph.saviorframework.SaviorFrameworkException;
import com.gph.saviorframework.common.model.Property;
import com.gph.saviorframework.config.service.PropertyService;

/**
 * 
 */
@Controller
@RequestMapping("/" + Constants.FRAMEWORK_REQUEST_PATH + "/config/property")
public class PropertyController {

	/** 日志输出 */
	final Logger logger = LoggerFactory.getLogger(PropertyController.class);

	/** 领域对象名称 */
	private String domain = Property.class.getSimpleName().toLowerCase();

	/** 视图前缀 */
	private String viewPrefix = Constants.FRAMEWORK_REQUEST_PATH + "/config/" + domain + "/" + domain + "_";

	/** 服务 */
	@Autowired
	private PropertyService propertyService;

	@RequestMapping
	public @ResponseBody
	ModelMap get(ModelMap modelMap) throws SaviorFrameworkException {
		modelMap.addAttribute(Constants.DEFAULT_RECORD_MODEL_KEY, propertyService.get());
		return modelMap;
	}

	@RequestMapping(value = "/portlet", method = RequestMethod.GET)
	public String portlet(ModelMap modelMap) throws SaviorFrameworkException {
		return viewPrefix + "portlet";
	}

	@RequestMapping(value = "/edit", method = RequestMethod.GET)
	public String edit(ModelMap modelMap) throws SaviorFrameworkException {
		return viewPrefix + "edit";
	}

	@RequestMapping(value = "/find", method = RequestMethod.GET)
	@ResponseBody
	public ModelMap find(ModelMap modelMap) throws SaviorFrameworkException {
		try {
			modelMap.addAttribute(Constants.DEFAULT_RECORD_MODEL_KEY, propertyService.find());
			modelMap.addAttribute("success", Boolean.TRUE);
		} catch (Exception e) {
			modelMap.addAttribute("success", Boolean.FALSE);
			modelMap.addAttribute("error", ErrorCode.UNCAUGHT_EXCEPTION);
		}
		return modelMap;
	}

	@RequestMapping(value = "/edit", method = RequestMethod.POST)
	public ModelMap edit(@ModelAttribute Property property, ModelMap modelMap) throws SaviorFrameworkException {
		try {
			propertyService.save(property);
			modelMap.addAttribute("success", Boolean.TRUE);
		} catch (HibernateOptimisticLockingFailureException e) {
			e.printStackTrace();
			modelMap.addAttribute("success", Boolean.FALSE);
			modelMap.addAttribute("error", ErrorCode.OPTIMISTIC_LOCKING);
		} catch (Exception e) {
			e.printStackTrace();
			modelMap.addAttribute("success", Boolean.FALSE);
			modelMap.addAttribute("error", ErrorCode.UNCAUGHT_EXCEPTION);
		}
		return modelMap;
	}
}
