package com.gph.saviorframework.security.web.controller;

import java.io.IOException;
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
import org.springframework.dao.DataAccessException;
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
import com.gph.saviorframework.common.model.Org;
import com.gph.saviorframework.common.model.Position;
import com.gph.saviorframework.common.model.PositionLevel;
import com.gph.saviorframework.security.service.OrgService;
import com.gph.saviorframework.security.service.PositionLevelService;
import com.gph.saviorframework.security.service.PositionService;
import com.gph.saviorframework.security.service.RoleService;
import com.gph.saviorframework.security.util.SecurityUtils;
import com.gph.saviorframework.util.RequestUtil;

/**
 * 岗位控制器.
 * 
 */
@Controller
@RequestMapping("/" + Constants.FRAMEWORK_REQUEST_PATH + "/position")
public class PositionController {

	/** 日志输出 */
	final Logger logger = LoggerFactory.getLogger(FunctionController.class);

	/** 领域对象名称 */
	private final String domain = Position.class.getSimpleName().toLowerCase();

	/** 视图前缀 */
	private final String viewPrefix = Constants.FRAMEWORK_REQUEST_PATH + "/" + Constants.MODULE_CATEGORY_SECURITY + "/" + domain + "/" + domain + "_";

	/** 岗位类型:全局 */
	private static final String TYPE_GLOBLE = "0";
	/** 岗位类型:指定机构 */
	private static final String TYPE_ORG = "1";
	/** 岗位类型:指定级别 */
	private static final String TYPE_LEVEL = "2";

	/** 服务 */
	@Autowired
	private PositionService positionService;

	@Autowired
	private RoleService roleService;

	@Autowired
	private OrgService orgService;

	@Autowired
	private PositionLevelService positionLevelService;

	/** 国际化资源 */
	@Autowired
	private MessageSourceAccessor messages;

	@Autowired
	private SecurityUtils securityUtils;

	/**
	 * 注册Editor
	 * 
	 * @param binder
	 */
	@InitBinder
	public void initBinder(WebDataBinder binder) {
	}

	/**
	 * 返回列表页面
	 * 
	 * @return 列表页面视图名称
	 * @throws FrameworkException
	 */
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list() throws SaviorFrameworkException {
		return viewPrefix + "list";
	}

	/**
	 * 根据分页、排序和其他条件查询记录.
	 * 
	 * @param page 起始记录行数
	 * @param rows 查询记录数量
	 * @param sort 排序字段
	 * @param dir 排序方向
	 * @param parent 上级机构
	 * @param request
	 * @param modelMap
	 * @return
	 * @throws SaviorFrameworkException
	 */
	@RequestMapping(value = "/list", method = RequestMethod.POST)
	public @ResponseBody
	ModelMap list(@RequestParam(value = "page", required = false, defaultValue = Constants.DEFAULT_PAGE_START) Integer page,
			@RequestParam(value = "rows", required = false, defaultValue = Constants.DEFAULT_PAGE_SIZE) Integer rows,
			@RequestParam(value = "sort", required = false, defaultValue = Constants.DEFAULT_SORT_FIELD) String sort,
			@RequestParam(value = "dir", required = false, defaultValue = Constants.DEFAULT_SORT_DIRECTION) String dir, HttpServletRequest request,
			ModelMap modelMap) throws SaviorFrameworkException {
		Map<String, Object> params = RequestUtil.getQueryMap(request, positionService.fields);
		try {
			modelMap.addAttribute(Constants.DEFAULT_RECORD_MODEL_KEY, positionService.find((page-1)*rows, rows, sort, dir, params));
			modelMap.addAttribute(Constants.DEFAULT_COUNT_MODEL_KEY, positionService.count(params));
			modelMap.addAttribute("success", Boolean.TRUE);
			logger.info(messages.getMessage("log.info.list", new String[] { securityUtils.getUserFullName(), messages.getMessage(domain) }));
		} catch (DataAccessException e) {
			e.printStackTrace();
			modelMap.addAttribute("success", Boolean.FALSE);
			logger.error(messages.getMessage("log.error.list", new String[] { securityUtils.getUserFullName(), messages.getMessage(domain) }));
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
	 * @param position 数据对象
	 * @return
	 * @throws SaviorFrameworkException
	 */
	@RequestMapping(value = "/create", method = RequestMethod.POST)
	public @ResponseBody
	ModelMap save(@ModelAttribute Position position, HttpServletRequest request) throws SaviorFrameworkException {
		ModelMap modelMap = new ModelMap();
		try {
			securityUtils.setCreateEntity(position);// 设置新建数据的操作用户及时间信息
			if (position.getType().equalsIgnoreCase(TYPE_GLOBLE)) {

			} else if (position.getType().equalsIgnoreCase(TYPE_ORG)) {
				String[] checkedOrgs = ServletRequestUtils.getStringParameters(request, "checkedOrgs");
				for (String orgId : checkedOrgs) {
					Object org = orgService.get(orgId);
					if (org != null) {
						position.addOrg((Org) org);
					}
				}
			} else if (position.getType().equalsIgnoreCase(TYPE_LEVEL)) {
				String[] positionLevels = ServletRequestUtils.getStringParameters(request, "positionLevel");
				for (String pl : positionLevels) {
					Object positionLevel = positionLevelService.get(pl);
					if (positionLevel != null) {
						position.addPositionLevel((PositionLevel) positionLevel);
					}
				}
			}
			positionService.save(position);
			modelMap.addAttribute("success", Boolean.TRUE);
			modelMap.addAttribute("id", position.getId());
			logger.info(messages.getMessage("log.info.create", new String[] { securityUtils.getUserFullName(), messages.getMessage(domain),
					position.getId().toString() }));
		} catch (DataIntegrityViolationException e) {
			e.printStackTrace();
			modelMap.addAttribute("success", Boolean.FALSE);
			modelMap.addAttribute("error", ErrorCode.DATA_INTEGRITY_VIOLATION + "[" + messages.getMessage("menu.error.duplicate.identity") + "]");
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
	public @ResponseBody
	ModelMap update(@PathVariable("id") Long id, HttpServletRequest request) throws SaviorFrameworkException {
		ModelMap modelMap = new ModelMap();
		try {
			Position position = (Position) positionService.get(id);
			ServletRequestDataBinder binder = new ServletRequestDataBinder(position);
			binder.bind(request);
			securityUtils.setModifyEntity(position);// 设置修改数据的操作用户及时间信息
			if (position.getType().equalsIgnoreCase(TYPE_GLOBLE)) {
				position.clearPositionLevel();
				position.clearOrg();
			} else if (position.getType().equalsIgnoreCase(TYPE_ORG)) {
				String[] checkedOrgs = ServletRequestUtils.getStringParameters(request, "checkedOrgs");
				/*String[] uncheckedOrgs = ServletRequestUtils.getStringParameters(request, "uncheckedOrgs");
				for (String orgId : uncheckedOrgs) {
					Object org = orgService.get(orgId);
					if (org != null) {
						position.getOrgs().remove(org);
					}
				}
				for (String orgId : checkedOrgs) {
					Object org = orgService.get(orgId);
					if (org != null) {
						position.addOrg((Org) org);
					}
				}*/
				position.clearOrg();
				for (String orgId : checkedOrgs) {
					Object org = orgService.get(orgId);
					if (org != null) {
						position.addOrg((Org) org);
					}
				}
				position.clearPositionLevel();
			} else if (position.getType().equalsIgnoreCase(TYPE_LEVEL)) {
				String[] positionLevels = ServletRequestUtils.getStringParameters(request, "positionLevel");
				position.clearPositionLevel();
				for (String pl : positionLevels) {
					Object positionLevel = positionLevelService.get(pl);
					if (positionLevel != null) {
						position.addPositionLevel((PositionLevel) positionLevel);
					}
				}
				position.clearOrg();
			}
			positionService.update(position);
			modelMap.addAttribute("success", Boolean.TRUE);
			logger.info(messages.getMessage("log.info.edit",
					new String[] { securityUtils.getUserFullName(), messages.getMessage(domain), id.toString() }));
		} catch (HibernateOptimisticLockingFailureException e) {
			e.printStackTrace();
			modelMap.addAttribute("success", Boolean.FALSE);
			modelMap.addAttribute("error", ErrorCode.OPTIMISTIC_LOCKING);
			logger.error(messages.getMessage("log.error.edit",
					new String[] { securityUtils.getUserFullName(), messages.getMessage(domain), id.toString() }));
		} catch (Exception e) {
			e.printStackTrace();
			modelMap.addAttribute("success", Boolean.FALSE);
			modelMap.addAttribute("error", ErrorCode.UNCAUGHT_EXCEPTION);
			logger.error(messages.getMessage("log.error.edit",
					new String[] { securityUtils.getUserFullName(), messages.getMessage(domain), id.toString() }));
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
	 * 返回查看数据
	 * 
	 * @param id 主键
	 * @param modelMap
	 * @return
	 * @throws SaviorFrameworkException
	 */
	@RequestMapping(value = "/view/{id}", method = RequestMethod.GET)
	public @ResponseBody
	ModelMap get(@PathVariable("id") String id, ModelMap modelMap) throws SaviorFrameworkException {
		try {
			modelMap.addAttribute(Constants.DEFAULT_RECORD_MODEL_KEY, positionService.findById(id));
			modelMap.addAttribute("success", Boolean.TRUE);
		} catch (Exception e) {
			e.printStackTrace();
			modelMap.addAttribute("success", Boolean.FALSE);
			modelMap.addAttribute("error", ErrorCode.UNCAUGHT_EXCEPTION);
		}
		return modelMap;
	}

	/**
	 * 批量删除
	 * 
	 * @param ids 主键数组
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public @ResponseBody
	ModelMap delete(@RequestParam(value = "ids", required = true) String[] ids, ModelMap modelMap) throws SaviorFrameworkException {
		try {
			positionService.deleteByIds(ids);
			modelMap.addAttribute("success", Boolean.TRUE);
			logger.info(messages.getMessage("log.info.delete", new String[] { securityUtils.getUserFullName(), messages.getMessage(domain),
					StringUtils.arrayToDelimitedString((Object[]) ids, "|") }));
		} catch (DataIntegrityViolationException e) {
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

	/**
	 * 返回岗位关联角色页面
	 * 
	 * @return 关联角色页面视图名称
	 * @throws SaviorFrameworkException
	 */
	@RequestMapping(value = "/role", method = RequestMethod.GET)
	public String role() throws SaviorFrameworkException {
		return viewPrefix + "role";
	}

	/**
	 * 返回岗位的角色数据.
	 * 
	 * @param position
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/{position}/role", method = RequestMethod.GET)
	public @ResponseBody
	ModelMap role(@PathVariable("position") String position, ModelMap modelMap) {
		try {
			modelMap.addAttribute(Constants.DEFAULT_RECORD_MODEL_KEY, roleService.findByPosition(position));
			modelMap.addAttribute("success", Boolean.TRUE);
		} catch (Exception e) {
			e.printStackTrace();
			modelMap.addAttribute("success", Boolean.FALSE);
			modelMap.addAttribute("error", ErrorCode.UNCAUGHT_EXCEPTION);
		}
		return modelMap;
	}

	/**
	 * 保存岗位与角色的关联信息.
	 * 
	 * @param roleIds 角色id数组
	 * @param positionId 岗位
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/{position}/role", method = RequestMethod.POST)
	@ResponseBody
	public ModelMap role(@PathVariable("position") Long positionId, HttpServletRequest request, ModelMap modelMap) {
		String[] roleIds = request.getParameterValues("ids");
		try {
			positionService.savePositionRole(positionId, roleIds);
			modelMap.addAttribute("success", Boolean.TRUE);
		} catch (Exception e) {
			e.printStackTrace();
			modelMap.addAttribute("success", Boolean.FALSE);
			modelMap.addAttribute("error", ErrorCode.UNCAUGHT_EXCEPTION);
		}
		return modelMap;
	}

	/**
	 * 根据上级机构和相关联岗位查询.
	 * 
	 * @param org
	 * @param position
	 * @return
	 * @throws SaviorFrameworkException
	 * @throws IOException 
	 */
	@RequestMapping(value = "/{position}/org", method = RequestMethod.GET)
	public @ResponseBody void getOrgTree(HttpServletRequest request,HttpServletResponse response, @PathVariable("position") String position) 
		throws SaviorFrameworkException, IOException {
		JSONArray array = new JSONArray();
		String id = request.getParameter("id");
		if(org.apache.commons.lang.StringUtils.isEmpty(id)){
			id=securityUtils.getUser().getOrg().getId();
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("id", securityUtils.getUser().getOrg().getId());
			map.put("text", securityUtils.getUser().getOrg().getName());
			map.put("children", orgService.findByPosition(id, position));
			array.add(map);
		}
		else{
			List<Map<String, Object>> list = orgService.findByPosition(id,position);
			array = JSONArray.fromObject(list);
		}
		response.getWriter().write(array.toString());
	}

	/**
	 * 根据上级机构查询机构信息.
	 * 
	 * @param org
	 * @return
	 * @throws SaviorFrameworkException
	 * @throws IOException 
	 */
	@RequestMapping(value = "/org", method = RequestMethod.GET)
	public @ResponseBody void getOrgTree(HttpServletRequest request,HttpServletResponse response) throws SaviorFrameworkException, IOException {
		JSONArray array = new JSONArray();
		String id = request.getParameter("id");
		if(org.apache.commons.lang.StringUtils.isEmpty(id)){
			id=securityUtils.getUser().getOrg().getId();
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("id", securityUtils.getUser().getOrg().getId());
			map.put("text", securityUtils.getUser().getOrg().getName());
			map.put("children", orgService.findByParent(id));
			array.add(map);
		}
		else{
			List<Map<String, Object>> list = orgService.findByParent(id);
			array = JSONArray.fromObject(list);
		}
		response.getWriter().write(array.toString());
	}

	/**
	 * 返回门户应用设置页面
	 * 
	 * @return 门户应用设置页面视图名称
	 * @throws SaviorFrameworkException
	 */
	@RequestMapping(value = "/portlet", method = RequestMethod.GET)
	public String portlet() throws SaviorFrameworkException {
		return viewPrefix + "portlet";
	}

	/**
	 * 导出数据至excel文件.
	 * 
	 * @param request
	 * @param org
	 * @param modelMap
	 * @return
	 * @throws SaviorFrameworkException
	 */
	@RequestMapping(value = "/excel", method = RequestMethod.GET)
	public String excel(HttpServletRequest request, ModelMap modelMap)
			throws SaviorFrameworkException {

		Map<String, Object> params = RequestUtil.getQueryMap(request, positionService.fields);
		// 定义列显示顺序以及列标题
		Map<String, String> columns = new LinkedHashMap<String, String>();
		columns.put("name", messages.getMessage("position.name"));
		columns.put("order", messages.getMessage("column.order"));
		columns.put("creator", messages.getMessage("column.creator"));
		columns.put("created", messages.getMessage("column.created"));
		columns.put("modifier", messages.getMessage("column.modifier"));
		columns.put("modified", messages.getMessage("column.modified"));
		modelMap.addAttribute(Constants.DEFAULT_EXCEL_COLUMNS_MODEL_KEY, columns);

		modelMap.addAttribute(Constants.DEFAULT_RECORD_MODEL_KEY,
				positionService.find(0, Constants.DEFAULT_EXCEL_ROW_LIMIT, Constants.DEFAULT_SORT_FIELD, Constants.DEFAULT_SORT_DIRECTION, params));
		return "excelView";
	}
}
