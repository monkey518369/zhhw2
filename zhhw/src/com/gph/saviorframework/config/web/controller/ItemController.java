package com.gph.saviorframework.config.web.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.orm.hibernate3.HibernateOptimisticLockingFailureException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.ServletRequestUtils;
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
import com.gph.saviorframework.config.service.ItemService;
import com.gph.saviorframework.security.util.ItemProvider;
import com.gph.saviorframework.security.util.UserSession;
import com.gph.saviorframework.util.RequestUtil;

/**
 * 数据项控制器.
 * 
 */
@Controller
@RequestMapping("/" + Constants.FRAMEWORK_REQUEST_PATH + "/item")
public class ItemController {

	/** 日志输出 */
	final Logger logger = LoggerFactory.getLogger(ItemController.class);

	/** 领域对象名称 */
	private String domain = Item.class.getSimpleName().toLowerCase();

	/** 视图前缀 */
	private String viewPrefix = Constants.FRAMEWORK_REQUEST_PATH + "/" + Constants.MODULE_CATEGORY_CONFIG + "/" + domain + "/" + domain + "_";

	/** 服务 */
	@Autowired
	private ItemService itemService;

	/** 国际化资源 */
	@Autowired
	private MessageSourceAccessor messages;

	@Autowired
	private UserSession userSession;

	@Autowired
	private ItemProvider itemProvider;

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
	ModelMap list(@RequestParam(value = "page", required = false, defaultValue = Constants.DEFAULT_PAGE_START) Integer start,
			@RequestParam(value = "rows", required = false, defaultValue = Constants.DEFAULT_PAGE_SIZE) Integer limit,
			@RequestParam(value = "sort", required = false, defaultValue = Constants.DEFAULT_SORT_FIELD) String sort,
			@RequestParam(value = "dir", required = false, defaultValue = Constants.DEFAULT_SORT_DIRECTION) String dir, HttpServletRequest request,
			ModelMap modelMap) throws SaviorFrameworkException {

		Map<String, Object> params = RequestUtil.getQueryMap(request, itemService.fields);
		modelMap.addAttribute(Constants.DEFAULT_RECORD_MODEL_KEY, itemService.find((start-1)*limit, limit, sort, dir, params));
		modelMap.addAttribute(Constants.DEFAULT_COUNT_MODEL_KEY, itemService.count(params));
		return modelMap;
	}

	/**
	 * 导出数据至excel文件.
	 * 
	 * @param request
	 * @param modelMap
	 * @return
	 * @throws SaviorFrameworkException
	 */
	@RequestMapping(value = "/excel", method = RequestMethod.GET)
	public String exportXls(HttpServletRequest request, ModelMap modelMap) throws SaviorFrameworkException {

		Map<String, Object> params = RequestUtil.getQueryMap(request, itemService.fields);
		// 定义列显示顺序以及列标题
		Map<String, String> columns = new LinkedHashMap<String, String>();
		columns.put("pid", messages.getMessage("item.id"));
		columns.put("pname", messages.getMessage("item.name"));
		columns.put("pdescription", messages.getMessage("item.description"));
		columns.put("porder", messages.getMessage("column.order"));
		columns.put("name", messages.getMessage("subitem.name"));
		columns.put("value", messages.getMessage("subitem.value"));
		columns.put("order", messages.getMessage("column.order"));
		modelMap.addAttribute(Constants.DEFAULT_EXCEL_COLUMNS_MODEL_KEY, columns);

		modelMap.addAttribute(Constants.DEFAULT_RECORD_MODEL_KEY,
				itemService.findSubs(0, Constants.DEFAULT_EXCEL_ROW_LIMIT, Constants.DEFAULT_SORT_FIELD, Constants.DEFAULT_SORT_DIRECTION, params));
		return "excelView";
	}

	/**
	 * 返回新建页面
	 * 
	 * @return 新建页面视图名称
	 * @throws SaviorFrameworkException
	 */
	@RequestMapping(value = "/create", method = RequestMethod.GET)
	public String create() throws SaviorFrameworkException {
		System.out.println(viewPrefix+"===================");
		return viewPrefix + "create";
	}

	/**
	 * 保存新建数据
	 * 
	 * @param item
	 * @return
	 * @throws SaviorFrameworkException
	 */
	@RequestMapping(value = "/create", method = RequestMethod.POST)
	public @ResponseBody
	ModelMap create(@ModelAttribute Item item) throws SaviorFrameworkException {
		ModelMap modelMap = new ModelMap();
		try {
			userSession.setCreateEntity(item);// 设置新建数据的操作用户及时间信息
			itemService.save(item);
			modelMap.addAttribute("success", Boolean.TRUE);
			modelMap.addAttribute("id", item.getId());
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
			Item item = (Item) itemService.get(id);
			ServletRequestDataBinder binder = new ServletRequestDataBinder(item);
			binder.bind(request);
			userSession.setModifyEntity(item);// 设置修改数据的操作用户及时间信息
			itemService.update(item);
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
			modelMap.addAttribute(Constants.DEFAULT_RECORD_MODEL_KEY, itemService.findById(id));
			modelMap.addAttribute("success", Boolean.TRUE);
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
	 * @throws SaviorFrameworkException
	 */
	@RequestMapping(value = "/delete", method = RequestMethod.DELETE)
	public @ResponseBody
	ModelMap delete(@RequestParam(value = "ids", required = true) String[] ids, ModelMap modelMap) throws SaviorFrameworkException {
		try {
			itemService.deleteByIds(ids);
			modelMap.addAttribute("success", Boolean.TRUE);
		} catch (DataIntegrityViolationException e) {
			e.printStackTrace();
			modelMap.addAttribute("success", Boolean.FALSE);
			modelMap.addAttribute("error", ErrorCode.DATA_INTEGRITY_VIOLATION);
		} catch (Exception e) {
			e.printStackTrace();
			modelMap.addAttribute("success", Boolean.FALSE);
			modelMap.addAttribute("error", ErrorCode.UNCAUGHT_EXCEPTION);
		}
		return modelMap;
	}

	/**
	 * 返回数据子项集合.
	 * 
	 * @param id 数据项ID
	 * @param modelMap
	 * @return
	 * @throws SaviorFrameworkException
	 */
	@RequestMapping(value = "/{itemId}/sub", method = RequestMethod.GET)
	@ResponseBody
	public ModelMap getSubItem(@PathVariable("itemId") String itemId, ModelMap modelMap) throws SaviorFrameworkException {
		Object subs = itemProvider.getSubItemMap(itemId);
		if (subs != null) {
			modelMap.addAttribute(Constants.DEFAULT_RECORD_MODEL_KEY, subs);
		}
		return modelMap;
	}
	
	@RequestMapping(value = "/{itemId}/sub2", method = RequestMethod.GET)
	@ResponseBody
	public void getSubItem2(@PathVariable("itemId") String itemId,HttpServletResponse response) throws SaviorFrameworkException, IOException {
		Object subs = itemProvider.getSubItemMap(itemId);
		JSONArray jsonArray = JSONArray.fromObject(subs);
		response.getWriter().write(jsonArray.toString());
	}

	/**
	 * 返回根据权限过滤后的数据子项集合.
	 * 
	 * @param id 数据项ID
	 * @param modelMap
	 * @return
	 * @throws SaviorFrameworkException
	 */
	@RequestMapping(value = "/{itemId}/{functionId}/permission/sub", method = RequestMethod.GET)
	@ResponseBody
	public ModelMap getSubItemByPermission(@PathVariable("itemId") String itemId, @PathVariable("functionId") String functionId, ModelMap modelMap)
			throws SaviorFrameworkException {
		List<Map<String, Object>> permissionSubs = itemProvider.getSubItemMapByPermission(itemId, functionId);
		if (permissionSubs != null && !permissionSubs.isEmpty()) {
			modelMap.addAttribute(Constants.DEFAULT_RECORD_MODEL_KEY, permissionSubs);
		} else {
			Object subs = itemProvider.getSubItemMap(itemId);
			if (subs != null) {
				modelMap.addAttribute(Constants.DEFAULT_RECORD_MODEL_KEY, subs);
			}
		}
		return modelMap;
	}

	/**
	 * 返回数据子项集合.
	 * 
	 * @param request
	 * @param modelMap
	 * @return
	 * @throws SaviorFrameworkException
	 */
	@RequestMapping(value = "/sub", method = RequestMethod.GET)
	@ResponseBody
	public ModelMap getSubItem(HttpServletRequest request, ModelMap modelMap) throws SaviorFrameworkException {
		String itemId = ServletRequestUtils.getStringParameter(request, "itemId", null);
		if (itemId == null || itemId.isEmpty()) {
			modelMap.addAttribute(Constants.DEFAULT_RECORD_MODEL_KEY, new ArrayList<Map<String, Object>>());
		} else {
			modelMap.addAttribute(Constants.DEFAULT_RECORD_MODEL_KEY, itemProvider.getSubItemMap(itemId));
		}
		return modelMap;
	}

	/**
	 * 返回所有权限数据项信息.
	 * 
	 * @param modelMap
	 * @return
	 * @throws SaviorFrameworkException
	 */
	@RequestMapping(value = "/permission", method = RequestMethod.GET)
	@ResponseBody
	public ModelMap getPermissionItems(ModelMap modelMap) throws SaviorFrameworkException {
		modelMap.addAttribute(Constants.DEFAULT_RECORD_MODEL_KEY, itemService.findPermissionItems());
		return modelMap;
	}

}
