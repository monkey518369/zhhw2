package com.gph.saviorframework.security.web.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
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
import org.springframework.security.web.access.intercept.SaviorframeworkFilterInvocationSecurityMetadataSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
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
import com.gph.saviorframework.common.model.Function;
import com.gph.saviorframework.common.model.Role;
import com.gph.saviorframework.security.service.FunctionService;
import com.gph.saviorframework.security.service.MenuService;
import com.gph.saviorframework.security.service.OrgService;
import com.gph.saviorframework.security.service.PermissionService;
import com.gph.saviorframework.security.service.RoleService;
import com.gph.saviorframework.security.service.UserService;
import com.gph.saviorframework.security.util.SecurityUtils;
import com.gph.saviorframework.util.RequestUtil;

/**
 * 角色控制器.
 * 
 */
@Controller
@RequestMapping("/" + Constants.FRAMEWORK_REQUEST_PATH + "/role")
public class RoleController {

	/** 日志输出 */
	final Logger logger = LoggerFactory.getLogger(RoleController.class);

	/** 领域对象名称 */
	private final String domain = Role.class.getSimpleName().toLowerCase();

	/** 视图前缀 */
	private final String viewPrefix = Constants.FRAMEWORK_REQUEST_PATH + "/" + Constants.MODULE_CATEGORY_SECURITY + "/" + domain + "/" + domain + "_";

	/** 服务 */
	@Autowired
	private RoleService roleService;

	@Autowired
	private UserService userService;

	@Autowired
	private FunctionService functionService;

	@Autowired
	private MenuService menuService;

	@Autowired
	private OrgService orgService;

	@Autowired
	private PermissionService permissionService;

	@Autowired
	private SaviorframeworkFilterInvocationSecurityMetadataSource filterInvocationSecurityMetadataSource;

	/** 国际化资源 */
	@Autowired
	private MessageSourceAccessor messages;

	@Autowired
	private SecurityUtils securityUtils;

	/**
	 * 返回列表页面
	 * 
	 * @return 列表页面视图名称
	 * @throws FrameworkException
	 */
	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public String index() throws SaviorFrameworkException {
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
	 */
	@RequestMapping(value = "/index", method = RequestMethod.POST)
	@ResponseBody
	public ModelMap list(@RequestParam(value = "page", required = false, defaultValue = Constants.DEFAULT_PAGE_START) Integer start,
			@RequestParam(value = "rows", required = false, defaultValue = Constants.DEFAULT_PAGE_SIZE) Integer limit,
			@RequestParam(value = "sort", required = false, defaultValue = Constants.DEFAULT_SORT_FIELD) String sort,
			@RequestParam(value = "dir", required = false, defaultValue = Constants.DEFAULT_SORT_DIRECTION) String dir, HttpServletRequest request,
			ModelMap modelMap) throws SaviorFrameworkException {

		Map<String, Object> params = RequestUtil.getQueryMap(request, roleService.fields);
		try {
			modelMap.addAttribute(Constants.DEFAULT_RECORD_MODEL_KEY, roleService.find((start-1)*limit, limit, sort, dir, params));
			modelMap.addAttribute(Constants.DEFAULT_COUNT_MODEL_KEY, roleService.count(params));
			modelMap.addAttribute("success", Boolean.TRUE);
			logger.info(messages.getMessage("log.info.list", new String[] { securityUtils.getUserFullName(), messages.getMessage(domain) }));
		} catch (Exception e) {
			e.printStackTrace();
			modelMap.addAttribute("success", Boolean.FALSE);
			logger.error(messages.getMessage("log.error.list", new String[] { securityUtils.getUserFullName(), messages.getMessage(domain) }));
		}
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
	public String excel(HttpServletRequest request, ModelMap modelMap) throws SaviorFrameworkException {

		Map<String, Object> params = RequestUtil.getQueryMap(request, roleService.fields);
		// 定义列显示顺序以及列标题
		Map<String, String> columns = new LinkedHashMap<String, String>();
		columns.put("name", messages.getMessage("role.name"));
		columns.put("description", messages.getMessage("role.description"));
		columns.put("order", messages.getMessage("column.order"));
		columns.put("creator", messages.getMessage("column.creator"));
		columns.put("created", messages.getMessage("column.created"));
		columns.put("modifier", messages.getMessage("column.modifier"));
		columns.put("modified", messages.getMessage("column.modified"));
		modelMap.addAttribute(Constants.DEFAULT_EXCEL_COLUMNS_MODEL_KEY, columns);

		modelMap.addAttribute(Constants.DEFAULT_RECORD_MODEL_KEY,
				roleService.find(0, Constants.DEFAULT_EXCEL_ROW_LIMIT, Constants.DEFAULT_SORT_FIELD, Constants.DEFAULT_SORT_DIRECTION, params));
		modelMap.addAttribute("count", roleService.count(params));
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
		return viewPrefix + "create";
	}

	/**
	 * 保存新建数据
	 * 
	 * @param role 数据对象
	 * @return
	 */
	@RequestMapping(value = "/create", method = RequestMethod.POST)
	@ResponseBody
	public ModelMap save(@ModelAttribute Role role) throws SaviorFrameworkException {
		ModelMap modelMap = new ModelMap();
		try {
			securityUtils.setCreateEntity(role);// 设置新建数据的操作用户及时间信息

			Function index = (Function) functionService.get("INDEX");// 新建角色默认具有首页访问权限
			role.addFunction(index);

			roleService.save(role);
			modelMap.addAttribute("success", Boolean.TRUE);
			modelMap.addAttribute("id", role.getId());
			logger.info(messages.getMessage("log.info.create",
					new String[] { securityUtils.getUserFullName(), messages.getMessage(domain), role.getId() }));
		} catch (DataIntegrityViolationException e) {
			e.printStackTrace();
			modelMap.addAttribute("success", Boolean.FALSE);
			modelMap.addAttribute("error", ErrorCode.DATA_INTEGRITY_VIOLATION + "[" + messages.getMessage("role.error.duplicate.id") + "]");
			logger.error(messages.getMessage("log.error.create", new String[] { securityUtils.getUserFullName(), messages.getMessage(domain) }));
		} catch (Exception e) {
			e.printStackTrace();
			modelMap.addAttribute("success", Boolean.FALSE);
			modelMap.addAttribute("error", ErrorCode.UNCAUGHT_EXCEPTION);
			logger.error(messages.getMessage("log.error.create", new String[] { securityUtils.getUserFullName(), messages.getMessage(domain) }));
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
	@ResponseBody
	public ModelMap update(@PathVariable("id") String id, HttpServletRequest request) throws SaviorFrameworkException {
		ModelMap modelMap = new ModelMap();
		try {
			Role role = (Role) roleService.get(id);
			ServletRequestDataBinder binder = new ServletRequestDataBinder(role);
			binder.bind(request);
			securityUtils.setModifyEntity(role);// 设置修改数据的操作用户及时间信息
			roleService.update(role);
			modelMap.addAttribute("success", Boolean.TRUE);
			logger.info(messages.getMessage("log.info.edit", new String[] { securityUtils.getUserFullName(), messages.getMessage(domain), id }));
		} catch (HibernateOptimisticLockingFailureException e) {
			e.printStackTrace();
			modelMap.addAttribute("success", Boolean.FALSE);
			modelMap.addAttribute("error", ErrorCode.OPTIMISTIC_LOCKING);
			logger.error(messages.getMessage("log.error.edit", new String[] { securityUtils.getUserFullName(), messages.getMessage(domain), id }));
		} catch (Exception e) {
			e.printStackTrace();
			modelMap.addAttribute("success", Boolean.FALSE);
			modelMap.addAttribute("error", ErrorCode.UNCAUGHT_EXCEPTION);
			logger.error(messages.getMessage("log.error.edit", new String[] { securityUtils.getUserFullName(), messages.getMessage(domain), id }));
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
	 * @param id 主键
	 * @param modelMap
	 * @return
	 * @throws SaviorFrameworkException
	 */
	@RequestMapping(value = "/view/{id}", method = RequestMethod.GET)
	@ResponseBody
	public ModelMap get(@PathVariable("id") String id, ModelMap modelMap) throws SaviorFrameworkException {
		try {
			modelMap.addAttribute(Constants.DEFAULT_RECORD_MODEL_KEY, roleService.findById(id));
			modelMap.addAttribute("success", Boolean.TRUE);
		} catch (Exception e) {
			e.printStackTrace();
			modelMap.addAttribute("success", Boolean.FALSE);
			modelMap.addAttribute("error", ErrorCode.UNCAUGHT_EXCEPTION);
		}
		return modelMap;
	}

	/**
	 * 查询所有数据
	 * 
	 * @param modelMap
	 * @return
	 * @throws SaviorFrameworkException
	 */
	@RequestMapping(value = "/find", method = RequestMethod.GET)
	@ResponseBody
	public ModelMap find(ModelMap modelMap) throws SaviorFrameworkException {
		try {
			modelMap.addAttribute(Constants.DEFAULT_RECORD_MODEL_KEY, roleService.findMap());
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
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	@ResponseBody
	public ModelMap delete(@RequestParam(value = "ids", required = true) String[] ids, ModelMap modelMap) throws SaviorFrameworkException {
		try {
			roleService.deleteByIds(ids);
			modelMap.addAttribute("success", Boolean.TRUE);
			logger.info(messages.getMessage("log.info.delete", new String[] { securityUtils.getUserFullName(), messages.getMessage(domain),
					StringUtils.arrayToDelimitedString((Object[]) ids, "|") }));
		} catch (DataIntegrityViolationException e) {
			e.printStackTrace();
			modelMap.addAttribute("success", Boolean.FALSE);
			modelMap.addAttribute("error", ErrorCode.DATA_INTEGRITY_VIOLATION);
			logger.error(messages.getMessage("log.error.delete", new String[] { securityUtils.getUserFullName(), messages.getMessage(domain),
					StringUtils.arrayToDelimitedString((Object[]) ids, "|") }));
		} catch (Exception e) {
			e.printStackTrace();
			modelMap.addAttribute("success", Boolean.FALSE);
			modelMap.addAttribute("error", ErrorCode.UNCAUGHT_EXCEPTION);
			logger.error(messages.getMessage("log.error.delete", new String[] { securityUtils.getUserFullName(), messages.getMessage(domain),
					StringUtils.arrayToDelimitedString((Object[]) ids, "|") }));
		}
		return modelMap;
	}

	// ------------------------------------------------------------------------------------------------------------------------

	/**
	 * 返回分配用户页面
	 * 
	 * @return 授权页面视图名称
	 * @throws SaviorFrameworkException
	 */
	@RequestMapping(value = "/user", method = RequestMethod.GET)
	public String assignUser() throws SaviorFrameworkException {
		return viewPrefix + "user_assign";
	}

	/**
	 * 根据组织机构和角色查询用户.
	 * 
	 * @param org 组织机构ID
	 * @param role 角色
	 * @return 记录集合
	 * @throws IOException 
	 */
	@RequestMapping(value = "/user/{role}", method = RequestMethod.GET)
	@ResponseBody
	public void assignUser(HttpServletRequest request,HttpServletResponse response,
			@PathVariable("role") String role) throws SaviorFrameworkException, IOException {
		/*List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		list.addAll(userService.findByOrgAndRole(org, role));
		list.addAll(orgService.findByRole(org, role));
		return list;*/
		
		JSONArray array = new JSONArray();
		String id = request.getParameter("id");
		if(org.apache.commons.lang.StringUtils.isEmpty(id)){
			id=securityUtils.getUser().getOrg().getId();
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("id", id);
			map.put("text", securityUtils.getUser().getOrg().getName());
			List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
			list.addAll(userService.findByOrgAndRole(id, role));
			list.addAll(orgService.findByRole(id, role));
			map.put("children", list);
			array.add(map);
		}
		else{
			List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
			list.addAll(userService.findByOrgAndRole(id, role));
			list.addAll(orgService.findByRole(id, role));
			array = JSONArray.fromObject(list);
		}
		response.getWriter().write(array.toString());
	}
	
	@RequestMapping(value = "/user2/{role}", method = RequestMethod.GET)
	@ResponseBody
	public List<Map<String, Object>> assignUser(@RequestParam("node") String org, @PathVariable("role") String role) throws SaviorFrameworkException {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		list.addAll(userService.findByOrgAndRole(org, role));
		list.addAll(orgService.findByRole(org, role));
		return list;
	}

	/**
	 * 保存与用户的关联信息.
	 * 
	 * @param menus 用户名数组
	 * @param role 角色编码
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/user", method = RequestMethod.POST)
	@ResponseBody
	public ModelMap saveRoleUser(@RequestParam("checked") String[] checked, @RequestParam("unchecked") String[] unchecked,
			@RequestParam("role") String role, ModelMap modelMap) throws SaviorFrameworkException {
		try {
			roleService.saveRoleUser(checked, unchecked, role);
			modelMap.addAttribute("success", Boolean.TRUE);
		} catch (Exception e) {
			e.printStackTrace();
			modelMap.addAttribute("success", Boolean.FALSE);
			modelMap.addAttribute("error", ErrorCode.UNCAUGHT_EXCEPTION);
		}
		return modelMap;
	}
	
	/**
	 * 保存与用户的关联信息.
	 * 
	 * @param menus 用户名数组
	 * @param role 角色编码
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/user2", method = RequestMethod.POST)
	@ResponseBody
	public ModelMap saveRoleUser(HttpServletRequest request,
			@RequestParam("role") String role, ModelMap modelMap) throws SaviorFrameworkException {
		String[] checked = request.getParameterValues("checked");
		try {
			roleService.saveRoleUser(checked, role);
			modelMap.addAttribute("success", Boolean.TRUE);
		} catch (Exception e) {
			e.printStackTrace();
			modelMap.addAttribute("success", Boolean.FALSE);
			modelMap.addAttribute("error", ErrorCode.UNCAUGHT_EXCEPTION);
		}
		return modelMap;
	}

	// ------------------------------------------------------------------------------------------------------------------------

	/**
	 * 返回分配菜单页面
	 * 
	 * @return 授权页面视图名称
	 * @throws SaviorFrameworkException
	 */
	@RequestMapping(value = "/menu", method = RequestMethod.GET)
	public String assignMenu() throws SaviorFrameworkException {
		return viewPrefix + "menu_assign";
	}

	/**
	 * 根据父级记录和角色查询菜单.
	 * 
	 * @param node 父级菜单ID
	 * @param role 角色
	 * @return 记录集合
	 * @throws IOException 
	 */
	@RequestMapping(value = "/menu/{role}", method = RequestMethod.GET)
	@ResponseBody
	public void assignMenu(HttpServletRequest request,HttpServletResponse response, 
			@PathVariable("role") String role) throws SaviorFrameworkException, IOException {
		
		JSONArray array = new JSONArray();
		String id = request.getParameter("id");
		if(org.apache.commons.lang.StringUtils.isEmpty(id)){
			id="TREE_ROOT_NODE";
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("id", "TREE_ROOT_NODE");
			map.put("text", messages.getMessage("menu"));
			map.put("children", menuService.findByRole(id, role));
			array.add(map);
		}
		else{
			List<Map<String, Object>> list = menuService.findByRole(id, role);
			array = JSONArray.fromObject(list);
		}
		response.getWriter().write(array.toString());
	}
	
	/**
	 * 根据父级记录和角色查询菜单.
	 * 
	 * @param node 父级菜单ID
	 * @param role 角色
	 * @return 记录集合
	 */
	@RequestMapping(value = "/menu2/{role}", method = RequestMethod.GET)
	@ResponseBody
	public List<Map<String, Object>> assignMenu(@RequestParam("node") String node, @PathVariable("role") String role) throws SaviorFrameworkException {
		return menuService.findByRole(node, role);
	}


	/**
	 * 保存与菜单的关联信息.
	 * 
	 * @param menus 菜单编码数组
	 * @param role 角色编码
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/menu", method = RequestMethod.POST)
	@ResponseBody
	public ModelMap assignMenu(HttpServletRequest request, @RequestParam("role") String role, ModelMap modelMap) throws SaviorFrameworkException {
		String[] menus = request.getParameterValues("menus");
		try {
			roleService.saveRelationWithMenu(menus, role);
			modelMap.addAttribute("success", Boolean.TRUE);
		} catch (Exception e) {
			e.printStackTrace();
			modelMap.addAttribute("success", Boolean.FALSE);
			modelMap.addAttribute("error", ErrorCode.UNCAUGHT_EXCEPTION);
		}
		return modelMap;
	}

	// ------------------------------------------------------------------------------------------------------------------------

	/**
	 * 返回分配功能页面
	 * 
	 * @return 授权页面视图名称
	 * @throws SaviorFrameworkException
	 */
	@RequestMapping(value = "/function", method = RequestMethod.GET)
	public String function() throws SaviorFrameworkException {
		return viewPrefix + "function";
	}

	/**
	 * 
	 * 
	 * @param role
	 * @param modelMap
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping(value = "/function/{role}", method = RequestMethod.GET)
	@ResponseBody
	public void function(@PathVariable("role") String role, HttpServletResponse response,HttpServletRequest request)
			throws SaviorFrameworkException, IOException {
		String id = request.getParameter("id");
		JSONArray array = new JSONArray();
		if(org.apache.commons.lang.StringUtils.isEmpty(id)){
			id="TREE_ROOT_NODE";
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("id", id);
			map.put("text", messages.getMessage("function"));
			map.put("children", functionService.findModuleAndFunctionByRole(id, role));
			array.add(map);
		}
		else{
			array = JSONArray.fromObject(functionService.findModuleAndFunctionByRole(id, role));
		}
		response.getWriter().write(array.toString());
	}
	
	/**
	 * 为extjs的tree准备的方法
	 * @param node
	 * @param role
	 * @param modelMap
	 * @return
	 * @throws SaviorFrameworkException
	 */
	@RequestMapping(value = "/function2/{role}", method = RequestMethod.GET)
	@ResponseBody
	public List<Map<String, Object>> function(@RequestParam("node") String node, @PathVariable("role") String role, ModelMap modelMap)
			throws SaviorFrameworkException {
		return functionService.findModuleAndFunctionByRole(node, role);
	}

	/**
	 * 保存与资源的关联信息.
	 * 
	 * @param checkedIds
	 * @param avaliableIds
	 * @param role
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/function", method = RequestMethod.POST)
	@ResponseBody
	public ModelMap function(@RequestParam("checked") String[] checkedIds, @RequestParam("unchecked") String[] uncheckedIds,
			@RequestParam("role") String role, ModelMap modelMap) throws SaviorFrameworkException {
		try {
			roleService.saveRoleFunction(checkedIds, uncheckedIds, role);
			filterInvocationSecurityMetadataSource.init();
			modelMap.addAttribute("success", Boolean.TRUE);
		} catch (Exception e) {
			e.printStackTrace();
			modelMap.addAttribute("success", Boolean.FALSE);
			modelMap.addAttribute("error", ErrorCode.UNCAUGHT_EXCEPTION);
		}
		return modelMap;
	}
	
	@RequestMapping(value = "/function2", method = RequestMethod.POST)
	@ResponseBody
	public ModelMap function2(HttpServletRequest request,
			@RequestParam("role") String role, ModelMap modelMap) throws SaviorFrameworkException {
		String[] checkedIds = request.getParameterValues("checked");
		try {
			roleService.saveRoleFunction(checkedIds, role);
			filterInvocationSecurityMetadataSource.init();
			modelMap.addAttribute("success", Boolean.TRUE);
		} catch (Exception e) {
			e.printStackTrace();
			modelMap.addAttribute("success", Boolean.FALSE);
			modelMap.addAttribute("error", ErrorCode.UNCAUGHT_EXCEPTION);
		}
		return modelMap;
	}

	// ------------------------------------------------------------------------------------------------------------------------

	/**
	 * 返回分配数据权限页面
	 * 
	 * @return 授权页面视图名称
	 * @throws SaviorFrameworkException
	 */
	@RequestMapping(value = "/permission", method = RequestMethod.GET)
	public String assignPermission() throws SaviorFrameworkException {
		return viewPrefix + "permission";
	}

	/**
	 * 根据分页、排序和角色信息查询数据权限.
	 * 
	 * @param role
	 * @param function
	 * @param modelMap
	 * @return
	 * @throws SaviorFrameworkException
	 */
	@RequestMapping(value = "/permission/{role}", method = RequestMethod.GET)
	public @ResponseBody
	ModelMap assignPermission(@PathVariable("role") String role, HttpServletRequest request, ModelMap modelMap) throws SaviorFrameworkException {
		try {
			String functionId = ServletRequestUtils.getStringParameter(request, "functionId");
			modelMap.addAttribute(Constants.DEFAULT_RECORD_MODEL_KEY, permissionService.findByRoleAndFunction(role, functionId));
			modelMap.addAttribute("success", Boolean.TRUE);
		} catch (Exception e) {
			e.printStackTrace();
			modelMap.addAttribute("success", Boolean.FALSE);
			modelMap.addAttribute("error", ErrorCode.UNCAUGHT_EXCEPTION);
		}
		return modelMap;
	}

	/**
	 * 保存角色与权限的关联信息.
	 * 
	 * @param permissionIds 权限ID数组
	 * @param roleId 角色ID
	 * @param modelMap
	 * @return
	 * @throws SaviorFrameworkException
	 */
	@RequestMapping(value = "/permission", method = RequestMethod.POST)
	public @ResponseBody
	ModelMap assignPermission(@RequestParam("permissionIds") Long[] permissionIds, @RequestParam("roleId") String roleId,
			@RequestParam("functionId") String functionId, ModelMap modelMap) throws SaviorFrameworkException {
		try {
			roleService.saveRolePermission(permissionIds, roleId, functionId);
			modelMap.addAttribute("success", Boolean.TRUE);
		} catch (Exception e) {
			e.printStackTrace();
			modelMap.addAttribute("success", Boolean.FALSE);
			modelMap.addAttribute("error", ErrorCode.UNCAUGHT_EXCEPTION);
		}
		return modelMap;
	}

}
