package com.gph.saviorframework.config.web.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate3.HibernateOptimisticLockingFailureException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.ServletRequestDataBinder;
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
import com.gph.saviorframework.common.model.Item;
import com.gph.saviorframework.common.model.SubItem;
import com.gph.saviorframework.config.service.ItemService;
import com.gph.saviorframework.config.service.SubItemService;
import com.gph.saviorframework.config.web.editor.ItemEditor;
import com.gph.saviorframework.security.util.SecurityUtils;
import com.gph.saviorframework.util.RequestUtil;


/**
 * 数据子项控制器.
 * 
 */
@Controller
@RequestMapping("/" + Constants.FRAMEWORK_REQUEST_PATH + "/subitem")
public class SubItemController {

	/** 日志输出 */
	final Logger logger = LoggerFactory.getLogger(SubItemController.class);

	/** 领域对象名称 */
	private String domain = SubItem.class.getSimpleName().toLowerCase();

	/** 视图前缀 */
	private String viewPrefix = Constants.FRAMEWORK_REQUEST_PATH + "/" + Constants.MODULE_CATEGORY_CONFIG + "/" + domain + "/" + domain + "_";

	/** 服务 */
	@Autowired
	private SubItemService subItemService;

	@Autowired
	private ItemService itemService;

	@Autowired
	private SecurityUtils securityUtils;

	/**
	 * 注册Editor
	 * 
	 * @param binder
	 */
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		binder.registerCustomEditor(Item.class, new ItemEditor(itemService));
	}

	/**
	 * 返回列表页面
	 * 
	 * @return 列表页面视图名称
	 * @throws FrameworkException
	 */
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list() throws SaviorFrameworkException {
		return viewPrefix + "index";
	}

	/**
	 * 根据分页、排序和其他条件查询记录.
	 * 
	 * @param start
	 * @param limit
	 * @param parent
	 * @param sort
	 * @param dir
	 * @param request
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/list", method = RequestMethod.POST)
	public @ResponseBody
	ModelMap list(@RequestParam(value = "start", required = false) Integer start, @RequestParam(value = "limit", required = false) Integer limit,
			@RequestParam(value = "parent", required = false) String parent, @RequestParam(value = "sort", required = false) String sort,
			@RequestParam(value = "dir", required = false) String dir, HttpServletRequest request, ModelMap modelMap) throws SaviorFrameworkException {

		Map<String, Object> params = RequestUtil.getQueryMap(request, subItemService.fields);
		modelMap.addAttribute(Constants.DEFAULT_RECORD_MODEL_KEY, subItemService.findSubItem(parent, start, limit, sort, dir, params));
		modelMap.addAttribute(Constants.DEFAULT_COUNT_MODEL_KEY, subItemService.findCount(parent, params));
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
	 * @param subitem
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/create", method = RequestMethod.POST)
	public @ResponseBody
	ModelMap save(@ModelAttribute SubItem subitem) throws SaviorFrameworkException {
		ModelMap modelMap = new ModelMap();
		try {
			securityUtils.setCreateEntity(subitem);// 设置新建数据的操作用户及时间信息
			subItemService.save(subitem);
			modelMap.addAttribute("success", Boolean.TRUE);
			modelMap.addAttribute("username", subitem.getId());
		} catch (HibernateOptimisticLockingFailureException e) {
			modelMap.addAttribute("success", Boolean.FALSE);
			modelMap.addAttribute("error", ErrorCode.OPTIMISTIC_LOCKING);
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
	 */
	@RequestMapping(value = "/edit/{id}", method = RequestMethod.POST)
	public @ResponseBody
	ModelMap update(@PathVariable("id") Long id, HttpServletRequest request) throws SaviorFrameworkException {
		ModelMap modelMap = new ModelMap();
		try {
			SubItem subItem = (SubItem) subItemService.get(id);
			ServletRequestDataBinder binder = new ServletRequestDataBinder(subItem);
			binder.registerCustomEditor(Item.class, new ItemEditor(itemService));
			binder.bind(request);
			securityUtils.setModifyEntity(subItem);// 设置修改数据的操作用户及时间信息
			subItemService.update(subItem);
			modelMap.addAttribute("success", Boolean.TRUE);
		} catch (HibernateOptimisticLockingFailureException e) {
			modelMap.addAttribute("success", Boolean.FALSE);
			modelMap.addAttribute("error", ErrorCode.OPTIMISTIC_LOCKING);
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
	 */
	@RequestMapping(value = "/view/{id}", method = RequestMethod.GET)
	public @ResponseBody
	ModelMap get(@PathVariable("id") Long id, ModelMap modelMap) throws SaviorFrameworkException {
		modelMap.addAttribute("success", Boolean.TRUE);
		modelMap.addAttribute(Constants.DEFAULT_RECORD_MODEL_KEY, subItemService.findById(id));
		return modelMap;
	}

	/**
	 * 返回查询页面
	 * 
	 * @return 查询页面视图名称
	 * @throws SaviorFrameworkException
	 */
	@RequestMapping(value = "/find", method = RequestMethod.GET)
	public String find() throws SaviorFrameworkException {
		return viewPrefix + "find";
	}

	/**
	 * 批量删除.
	 * 
	 * @param ids
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/delete", method = RequestMethod.DELETE)
	public @ResponseBody
	ModelMap delete(@RequestParam(value = "ids", required = true) Long[] ids, ModelMap modelMap) {
		subItemService.deleteByIds(ids);
		modelMap.addAttribute("success", Boolean.TRUE);
		return modelMap;
	}

}
