package com.gph.saviorframework.config.web.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.orm.hibernate3.HibernateOptimisticLockingFailureException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gph.saviorframework.Constants;
import com.gph.saviorframework.ErrorCode;
import com.gph.saviorframework.SaviorFrameworkException;
import com.gph.saviorframework.common.model.Portlet;
import com.gph.saviorframework.config.service.PortletService;
import com.gph.saviorframework.util.RequestUtil;

@Controller
@RequestMapping("/" + Constants.FRAMEWORK_REQUEST_PATH + "/portlet")
public class PortletController {

	/** 日志输出 */
	final Logger logger = LoggerFactory.getLogger(PortletController.class);

	/** 领域对象名称 */
	private String domain = Portlet.class.getSimpleName().toLowerCase();

	/** 视图前缀 */
	private String viewPrefix = Constants.FRAMEWORK_REQUEST_PATH + "/" + Constants.MODULE_CATEGORY_CONFIG + "/" + domain + "/" + domain + "_";

	/** 服务 */
	@Autowired
	private PortletService portletService;

	/**
	 * 返回列表页面
	 * 
	 * @return 列表页面视图名称
	 * @throws SaviorFrameworkException
	 */
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list() throws SaviorFrameworkException {
		return viewPrefix + "list";
	}

	/**
	 * 根据分页、排序和其他条件查询记录.
	 * 
	 * @param start 起始记录行数
	 * @param limit 查询记录数量
	 * @param sort 排序字段
	 * @param dir 排序方向
	 * @param request
	 * @param modelMap
	 * @return
	 * @throws SaviorFrameworkException
	 */
	@RequestMapping(value = "/list", method = RequestMethod.POST)
	public @ResponseBody
	ModelMap list(@RequestParam(value = "start", required = false, defaultValue = Constants.DEFAULT_PAGE_START) Integer start,
			@RequestParam(value = "limit", required = false, defaultValue = Constants.DEFAULT_PAGE_SIZE) Integer limit,
			@RequestParam(value = "sort", required = false, defaultValue = Constants.DEFAULT_SORT_FIELD) String sort,
			@RequestParam(value = "dir", required = false, defaultValue = Constants.DEFAULT_SORT_DIRECTION) String dir, HttpServletRequest request,
			ModelMap modelMap) throws SaviorFrameworkException {

		Map<String, Object> params = RequestUtil.getQueryMap(request, portletService.fields);
		modelMap.addAttribute(Constants.DEFAULT_RECORD_MODEL_KEY, portletService.find(start, limit, sort, dir, params));
		modelMap.addAttribute(Constants.DEFAULT_COUNT_MODEL_KEY, portletService.count(params));
		return modelMap;
	}

	/**
	 * 返回新建页面
	 * 
	 * @return 新建页面视图名称
	 * @throws SaviorFrameworkException
	 */
	@RequestMapping(value = "/create", method = RequestMethod.GET)
	public String create() throws SaviorFrameworkException {
		return viewPrefix + "create";
	}

	/**
	 * 保存新建数据
	 * 
	 * @param portlet
	 * @return
	 * @throws SaviorFrameworkException
	 */
	@RequestMapping(value = "/create", method = RequestMethod.POST)
	public @ResponseBody
	ModelMap save(@ModelAttribute Portlet portlet) throws SaviorFrameworkException {
		ModelMap modelMap = new ModelMap();
		try {
			portletService.save(portlet);
			modelMap.addAttribute("success", Boolean.TRUE);
			modelMap.addAttribute("id", portlet.getId());
		} catch (Exception e) {
			e.printStackTrace();
			modelMap.addAttribute("success", Boolean.FALSE);
			modelMap.addAttribute("error", ErrorCode.UNCAUGHT_EXCEPTION);
		}
		return modelMap;
	}

	/**
	 * 返回编辑页面
	 * 
	 * @return 编辑页面视图名称
	 * @throws SaviorFrameworkException
	 */
	@RequestMapping(value = "/edit", method = RequestMethod.GET)
	public String edit() throws SaviorFrameworkException {
		return viewPrefix + "edit";
	}

	/**
	 * 更新编辑数据
	 * 
	 * @param id
	 * @param request
	 * @return
	 * @throws SaviorFrameworkException
	 */
	@RequestMapping(value = "/edit/{id}", method = RequestMethod.POST)
	public @ResponseBody
	ModelMap update(@PathVariable("id") String id, HttpServletRequest request) throws SaviorFrameworkException {
		ModelMap modelMap = new ModelMap();
		try {
			Portlet portlet = (Portlet) portletService.get(id);
			ServletRequestDataBinder binder = new ServletRequestDataBinder(portlet);
			binder.bind(request);
			portletService.update(portlet);
			modelMap.addAttribute("success", Boolean.TRUE);
		} catch (HibernateOptimisticLockingFailureException e) {
			modelMap.addAttribute("success", Boolean.FALSE);
			modelMap.addAttribute("error", ErrorCode.OPTIMISTIC_LOCKING);
		} catch (Exception e) {
			modelMap.addAttribute("success", Boolean.FALSE);
			modelMap.addAttribute("error", ErrorCode.UNCAUGHT_EXCEPTION);
		}
		return modelMap;
	}

	/**
	 * 返回查看页面
	 * 
	 * @return
	 * @throws SaviorFrameworkException
	 */
	@RequestMapping(value = "/view", method = RequestMethod.GET)
	public String view() throws SaviorFrameworkException {
		return viewPrefix + "view";
	}

	/**
	 * 返回查看数据.
	 * 
	 * @param id
	 * @param modelMap
	 * @return
	 * @throws SaviorFrameworkException
	 */
	@RequestMapping(value = "/view/{id}", method = RequestMethod.GET)
	public @ResponseBody
	ModelMap get(@PathVariable("id") String id, ModelMap modelMap) throws SaviorFrameworkException {
		try {
			modelMap.addAttribute(Constants.DEFAULT_RECORD_MODEL_KEY, portletService.findById(id));
			modelMap.addAttribute("success", Boolean.TRUE);
		} catch (Exception e) {
			modelMap.addAttribute("success", Boolean.FALSE);
			modelMap.addAttribute("error", ErrorCode.UNCAUGHT_EXCEPTION);
		}
		return modelMap;
	}

	/**
	 * 批量删除.
	 * 
	 * @param ids 主键数组
	 * @param modelMap
	 * @return
	 * @throws SaviorFrameworkException
	 */
	@RequestMapping(value = "/delete", method = RequestMethod.DELETE)
	public @ResponseBody
	ModelMap delete(@RequestParam(value = "ids", required = true) String[] ids, ModelMap modelMap) throws SaviorFrameworkException {
		try {
			portletService.deleteByIds(ids);
			modelMap.addAttribute("success", Boolean.TRUE);
		} catch (DataIntegrityViolationException e) {
			modelMap.addAttribute("success", Boolean.FALSE);
			modelMap.addAttribute("error", ErrorCode.DATA_INTEGRITY_VIOLATION);
		} catch (Exception e) {
			modelMap.addAttribute("success", Boolean.FALSE);
			modelMap.addAttribute("error", ErrorCode.UNCAUGHT_EXCEPTION);
		}
		return modelMap;
	}

	@RequestMapping(value = "/import", method = RequestMethod.GET)
	public String avaliable() throws SaviorFrameworkException {
		return viewPrefix + "import";
	}

	@RequestMapping(value = "/import", method = RequestMethod.POST)
	public @ResponseBody
	ModelMap avaliable(@RequestParam(value = "positionId") Long positionId, HttpServletRequest request, ModelMap modelMap) throws SaviorFrameworkException {

		modelMap.addAttribute(Constants.DEFAULT_RECORD_MODEL_KEY, portletService.findAvaliable(positionId));
		modelMap.addAttribute(Constants.DEFAULT_COUNT_MODEL_KEY, portletService.countAvaliable(positionId));
		return modelMap;
	}

}
