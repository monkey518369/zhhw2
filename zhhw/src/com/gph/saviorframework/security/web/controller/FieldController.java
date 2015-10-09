package com.gph.saviorframework.security.web.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.orm.hibernate3.HibernateOptimisticLockingFailureException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gph.saviorframework.Constants;
import com.gph.saviorframework.ErrorCode;
import com.gph.saviorframework.SaviorFrameworkException;
import com.gph.saviorframework.common.model.Field;
import com.gph.saviorframework.common.model.Function;
import com.gph.saviorframework.security.service.FieldService;
import com.gph.saviorframework.security.service.FunctionService;
import com.gph.saviorframework.security.util.UserSession;
import com.gph.saviorframework.security.web.editor.FunctionEditor;
import com.gph.saviorframework.util.RequestUtil;

/**
 * 字段控制器.
 * 
 */
@Controller
@RequestMapping("/" + Constants.FRAMEWORK_REQUEST_PATH + "/field")
public class FieldController {

	/** 日志输出 */
	final Logger logger = LoggerFactory.getLogger(FieldController.class);

	/** 领域对象名称 */
	private final String domain = Field.class.getSimpleName().toLowerCase();

	/** 视图前缀 */
	private final String viewPrefix = Constants.FRAMEWORK_REQUEST_PATH + "/" + Constants.MODULE_CATEGORY_SECURITY + "/" + domain + "/" + domain + "_";

	/** 服务 */
	@Autowired
	private FieldService fieldService;

	@Autowired
	private FunctionService functionService;

	/** 国际化资源 */
	@Autowired
	private MessageSourceAccessor messages;

	@Autowired
	private UserSession userSession;

	/**
	 * 注册Editor
	 * 
	 * @param binder
	 */
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		binder.registerCustomEditor(Function.class, new FunctionEditor(functionService));
	} 

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
	 * 返回列表数据
	 * 
	 * @param start
	 * @param limit
	 * @param sort
	 * @param dir
	 * @param request
	 * @param modelMap
	 * @return
	 * @throws SaviorFrameworkException
	 */
	@RequestMapping(value = "/list", method = RequestMethod.POST)
	public @ResponseBody
	ModelMap listByFunction(@RequestParam(value = "start", required = false, defaultValue = Constants.DEFAULT_PAGE_START) Integer start,
			@RequestParam(value = "limit", required = false, defaultValue = Constants.DEFAULT_PAGE_SIZE) Integer limit,
			@RequestParam(value = "sort", required = false, defaultValue = Constants.DEFAULT_SORT_FIELD) String sort,
			@RequestParam(value = "dir", required = false, defaultValue = Constants.DEFAULT_SORT_DIRECTION) String dir, HttpServletRequest request,
			ModelMap modelMap) throws SaviorFrameworkException {

		Map<String, Object> params = RequestUtil.getQueryMap(request, fieldService.fields);
		String functionId = ServletRequestUtils.getStringParameter(request, "functionId", null);
		try {
			modelMap.addAttribute(Constants.DEFAULT_RECORD_MODEL_KEY, fieldService.findByFunction(start, limit, sort, dir, params, functionId));
			modelMap.addAttribute(Constants.DEFAULT_COUNT_MODEL_KEY, fieldService.countByFunction(params, functionId));
			modelMap.addAttribute("success", Boolean.TRUE);
			logger.info(messages.getMessage("log.info.list", new String[] { userSession.getUserFullName(), messages.getMessage(domain) }));
		} catch (Exception e) {
			e.printStackTrace();
			modelMap.addAttribute("success", Boolean.FALSE);
			logger.error(messages.getMessage("log.error.list", new String[] { userSession.getUserFullName(), messages.getMessage(domain) }));
		}
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
	 * @param function 数据对象
	 * @return
	 */
	@RequestMapping(value = "/create", method = RequestMethod.POST)
	public @ResponseBody
	ModelMap create(@ModelAttribute Field field) throws SaviorFrameworkException {
		ModelMap modelMap = new ModelMap();
		try {
			userSession.setCreateEntity(field);// 设置新建数据的操作用户及时间信息
			fieldService.save(field);
			modelMap.addAttribute("success", Boolean.TRUE);
			modelMap.addAttribute("id", field.getId());
			logger.info(messages.getMessage("log.info.create", new String[] { userSession.getUserFullName(), messages.getMessage(domain),
					field.getId().toString() }));
		} catch (DataIntegrityViolationException e) {
			e.printStackTrace();
			modelMap.addAttribute("success", Boolean.FALSE);
			modelMap.addAttribute("error", ErrorCode.DATA_INTEGRITY_VIOLATION + "[" + messages.getMessage("function.error.duplicate.id") + "]");
			logger.error(messages.getMessage("log.error.create", new String[] { userSession.getUserFullName(), messages.getMessage(domain) }));
		} catch (Exception e) {
			e.printStackTrace();
			modelMap.addAttribute("success", Boolean.FALSE);
			modelMap.addAttribute("error", ErrorCode.UNCAUGHT_EXCEPTION);
			logger.error(messages.getMessage("log.error.create", new String[] { userSession.getUserFullName(), messages.getMessage(domain) }));
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
	ModelMap edit(@PathVariable("id") Long id, HttpServletRequest request) throws SaviorFrameworkException {
		ModelMap modelMap = new ModelMap();
		try {
			Field field = (Field) fieldService.get(id);
			ServletRequestDataBinder binder = new ServletRequestDataBinder(field);
			binder.registerCustomEditor(Function.class, new FunctionEditor(functionService));
			binder.bind(request);
			userSession.setModifyEntity(field);// 设置修改数据的操作用户及时间信息
			fieldService.update(field);
			modelMap.addAttribute("success", Boolean.TRUE);
			logger.info(messages.getMessage("log.info.edit",
					new String[] { userSession.getUserFullName(), messages.getMessage(domain), id.toString() }));
		} catch (HibernateOptimisticLockingFailureException e) {
			e.printStackTrace();
			modelMap.addAttribute("success", Boolean.FALSE);
			modelMap.addAttribute("error", ErrorCode.OPTIMISTIC_LOCKING);
			logger.error(messages.getMessage("log.error.edit",
					new String[] { userSession.getUserFullName(), messages.getMessage(domain), id.toString() }));
		} catch (Exception e) {
			e.printStackTrace();
			modelMap.addAttribute("success", Boolean.FALSE);
			modelMap.addAttribute("error", ErrorCode.UNCAUGHT_EXCEPTION);
			logger.error(messages.getMessage("log.error.edit",
					new String[] { userSession.getUserFullName(), messages.getMessage(domain), id.toString() }));
		}

		return modelMap;
	}

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

	/**
	 * 根据ID查询.
	 * 
	 * @param id 主键
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/view/{id}", method = RequestMethod.GET)
	public @ResponseBody
	ModelMap view(@PathVariable("id") String id, ModelMap modelMap) throws SaviorFrameworkException {
		try {
			modelMap.addAttribute("success", Boolean.TRUE);
			modelMap.addAttribute(Constants.DEFAULT_RECORD_MODEL_KEY, fieldService.findById(id));
		} catch (Exception e) {
			e.printStackTrace();
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
	 */
	@RequestMapping(value = "/delete", method = RequestMethod.DELETE)
	public @ResponseBody
	ModelMap delete(@RequestParam(value = "ids", required = true) String[] ids, ModelMap modelMap) throws SaviorFrameworkException {
		try {
			fieldService.deleteByIds(ids);
			modelMap.addAttribute("success", Boolean.TRUE);
			logger.info(messages.getMessage(
					"log.info.delete",
					new String[] { userSession.getUserFullName(), messages.getMessage(domain),
							StringUtils.arrayToDelimitedString((Object[]) ids, "|") }));
		} catch (DataIntegrityViolationException e) {
			e.printStackTrace();
			modelMap.addAttribute("success", Boolean.FALSE);
			modelMap.addAttribute("error", ErrorCode.DATA_INTEGRITY_VIOLATION);
			logger.error(messages.getMessage("log.error.delete", new String[] { userSession.getUserFullName(), messages.getMessage(domain),
					StringUtils.arrayToDelimitedString((Object[]) ids, "|") }));
		} catch (Exception e) {
			e.printStackTrace();
			modelMap.addAttribute("success", Boolean.FALSE);
			modelMap.addAttribute("error", ErrorCode.UNCAUGHT_EXCEPTION);
			logger.error(messages.getMessage("log.error.delete", new String[] { userSession.getUserFullName(), messages.getMessage(domain),
					StringUtils.arrayToDelimitedString((Object[]) ids, "|") }));
		}
		return modelMap;
	}

	/**
	 * 根据功能ID查询.
	 * 
	 * @param functionId 功能ID
	 * @param modelMap
	 * @return
	 * @throws SaviorFrameworkException
	 */
	@RequestMapping(value = "/function/{functionId}", method = RequestMethod.GET)
	public @ResponseBody
	ModelMap findByFunction(@PathVariable("functionId") String functionId, ModelMap modelMap) throws SaviorFrameworkException {
		try {
			modelMap.addAttribute("success", Boolean.TRUE);
			modelMap.addAttribute(Constants.DEFAULT_RECORD_MODEL_KEY, fieldService.findByFunction(functionId));
		} catch (Exception e) {
			e.printStackTrace();
			modelMap.addAttribute("success", Boolean.FALSE);
			modelMap.addAttribute("error", ErrorCode.UNCAUGHT_EXCEPTION);
		}
		return modelMap;
	}

}
