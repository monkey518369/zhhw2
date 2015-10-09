package com.gph.saviorframework.security.web.controller;

import java.io.BufferedOutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.orm.hibernate3.HibernateOptimisticLockingFailureException;
import org.springframework.security.authentication.encoding.Md5PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.gph.saviorframework.Constants;
import com.gph.saviorframework.ErrorCode;
import com.gph.saviorframework.SaviorFrameworkException;
import com.gph.saviorframework.common.model.Org;
import com.gph.saviorframework.common.model.Position;
import com.gph.saviorframework.common.model.User;
import com.gph.saviorframework.security.service.OrgService;
import com.gph.saviorframework.security.service.PositionService;
import com.gph.saviorframework.security.service.RoleService;
import com.gph.saviorframework.security.service.UserService;
import com.gph.saviorframework.security.util.CryptographicStrengthChecker;
import com.gph.saviorframework.security.util.SecurityUtils;
import com.gph.saviorframework.security.web.editor.OrgEditor;
import com.gph.saviorframework.security.web.editor.PositionEditor;
import com.gph.saviorframework.util.FileCutUtil;
import com.gph.saviorframework.util.RequestUtil;

/**
 * 用户控制器.
 * 
 */
@Controller
@RequestMapping("/" + Constants.FRAMEWORK_REQUEST_PATH + "/user")
public class UserController {

	/** 日志输出 */
	final Logger logger = LoggerFactory.getLogger(UserController.class);

	/** 领域对象名称 */
	private static final String domain = User.class.getSimpleName().toLowerCase();

	/** 视图前缀 */
	private static final String viewPrefix = Constants.FRAMEWORK_REQUEST_PATH + "/" + Constants.MODULE_CATEGORY_SECURITY + "/" + domain + "/"
			+ domain + "_";

	/** 用户数据服务 */
	@Autowired
	private UserService userService;
	
	/** 机构数据服务 */
	@Autowired
	private OrgService orgService;

	@Autowired
	private RoleService roleService;

	@Autowired
	private PositionService positionService;

	@Autowired
	private Md5PasswordEncoder passwordEncoder;

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
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		dateFormat.setLenient(false);
		binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
		binder.registerCustomEditor(Org.class, new OrgEditor(orgService));
		binder.registerCustomEditor(Position.class, new PositionEditor(positionService));
	}

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
	 * @param page 起始记录行
	 * @param limit 查询记录数
	 * @param sort 排序字段
	 * @param dir 排序方向
	 * @param org 所属机构ID
	 * @param request
	 * @param modelMap
	 * @return
	 * @throws SaviorFrameworkException
	 */
	@RequestMapping(value = "/index", method = RequestMethod.POST)
	public @ResponseBody
	ModelMap list(@RequestParam(value = "page", required = false, defaultValue = Constants.DEFAULT_PAGE_START) Integer page,
			@RequestParam(value = "rows", required = false, defaultValue = Constants.DEFAULT_PAGE_SIZE) Integer limit,
			@RequestParam(value = "sort", required = false, defaultValue = Constants.DEFAULT_SORT_FIELD) String sort,
			@RequestParam(value = "dir", required = false, defaultValue = Constants.DEFAULT_SORT_DIRECTION) String dir,
			@RequestParam(value = "org", required = false, defaultValue = "") String org, HttpServletRequest request, ModelMap modelMap)
			throws SaviorFrameworkException {

		Map<String, Object> params = RequestUtil.getQueryMap(request, userService.fields);
		try {
			modelMap.addAttribute(Constants.DEFAULT_RECORD_MODEL_KEY, userService.find(org, (page-1)*limit, limit, sort, dir, params));
			modelMap.addAttribute(Constants.DEFAULT_COUNT_MODEL_KEY, userService.count(org, params));
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
	 * @param org
	 * @param modelMap
	 * @return
	 * @throws SaviorFrameworkException
	 */
	@RequestMapping(value = "/excel", method = RequestMethod.GET)
	public String excel(HttpServletRequest request, @RequestParam(value = "org", required = false, defaultValue = "") String org, ModelMap modelMap)
			throws SaviorFrameworkException {

		Map<String, Object> params = RequestUtil.getQueryMap(request, userService.fields);
		// 定义列显示顺序以及列标题
		Map<String, String> columns = new LinkedHashMap<String, String>();
		columns.put("name", messages.getMessage("user.name"));
		columns.put("username", messages.getMessage("user.username"));
		columns.put("email", messages.getMessage("user.email"));
		columns.put("gender", messages.getMessage("user.gender"));
		columns.put("identity", messages.getMessage("user.identity"));
		columns.put("address", messages.getMessage("user.address"));
		columns.put("post", messages.getMessage("user.post"));
		columns.put("tel", messages.getMessage("user.tel"));
		columns.put("qq", "QQ");
		columns.put("mobile", messages.getMessage("user.mobile"));
		columns.put("birthday", messages.getMessage("user.birthday"));
		columns.put("enabled", messages.getMessage("user.enabled"));
		columns.put("order", messages.getMessage("column.order"));
		columns.put("creator", messages.getMessage("column.creator"));
		columns.put("created", messages.getMessage("column.created"));
		columns.put("modifier", messages.getMessage("column.modifier"));
		columns.put("modified", messages.getMessage("column.modified"));
		modelMap.addAttribute(Constants.DEFAULT_EXCEL_COLUMNS_MODEL_KEY, columns);

		modelMap.addAttribute(Constants.DEFAULT_RECORD_MODEL_KEY,
				userService.find(org, 0, Constants.DEFAULT_EXCEL_ROW_LIMIT, Constants.DEFAULT_SORT_FIELD, Constants.DEFAULT_SORT_DIRECTION, params));
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
	 * @param user 数据对象
	 * @return
	 */
	@RequestMapping(value = "/create", method = RequestMethod.POST)
	public @ResponseBody
		ModelMap create(@ModelAttribute User user, @RequestParam MultipartFile usercard,
			@RequestParam(value = "role", required = false) String[] roles) throws SaviorFrameworkException {
		ModelMap modelMap = new ModelMap();
		try {
			securityUtils.setCreateEntity(user);// 设置新建数据的操作用户及时间信息
			user.setPassword(passwordEncoder.encodePassword(Constants.DEFAULT_PASSWORD, ""));	     

			//裁剪头像大小
			byte[] ext = FileCutUtil.UsercardCutUtil(usercard.getBytes());
			user.setExt(ext);  //保存用户头像数据
				
	        userService.save(user);
			modelMap.addAttribute("success", Boolean.TRUE);
			modelMap.addAttribute("username", user.getUsername());
			logger.info(messages.getMessage("log.info.create",
					new String[] { securityUtils.getUserFullName(), messages.getMessage(domain), user.getUsername() }));
		} catch (DataIntegrityViolationException e) {
			e.printStackTrace();
			modelMap.addAttribute("success", Boolean.FALSE);
			modelMap.addAttribute("error", ErrorCode.DATA_INTEGRITY_VIOLATION + "[" + messages.getMessage("user.error.duplicate.identity") + "]");
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
	 * 下载头像
	 * @param username
	 * @param response
	 */
	@RequestMapping("/showusercard")
	public void showUserCard(@RequestParam String username, HttpServletResponse response){
		User user = (User) userService.get(username);
		if(user != null){
			byte[] data = user.getExt();
			BufferedOutputStream bos = null;
			try {
				String filename = username + "_" + new Date().getTime() + ".jpeg";
				response.reset();
				response.setContentType("application/octet-stream");
				response.setHeader("Content-Disposition",  "attachment;filename=\"" + filename+"\"");
				
				bos = new BufferedOutputStream(response.getOutputStream());
				bos.write(data);
				bos.flush();
				bos.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
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
	 * @param username 用户名
	 * @param request
	 * @return
	 * @throws SaviorFrameworkException
	 */
	@RequestMapping(value = "/edit/{username}", method = RequestMethod.POST)
	public @ResponseBody
	ModelMap edit(@PathVariable("username") String username, 
			@RequestParam MultipartFile usercard,
			@RequestParam(value = "role", required = false) String[] roles,
			HttpServletRequest request) throws SaviorFrameworkException {
		ModelMap modelMap = new ModelMap();
		try {
			User user = (User) userService.get(username);
			if(usercard != null){
				byte[] ext = FileCutUtil.UsercardCutUtil(usercard.getBytes());
				user.setExt(ext);  //修改用户头像数据
			}
			Position position = user.getPosition();
			Org org = user.getOrg();
			ServletRequestDataBinder binder = new ServletRequestDataBinder(user);
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			dateFormat.setLenient(false);
			binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
			binder.registerCustomEditor(Org.class, new OrgEditor(orgService));
			binder.registerCustomEditor(Position.class, new PositionEditor(positionService));
			binder.bind(request);
			securityUtils.setModifyEntity(user);// 设置修改数据的操作用户及时间信息
			if (!org.getId().equals(user.getOrg().getId())) {// 如果机构发生变化,则清除用户岗位和所有角色
				user.setPosition(null);
				user.clearRole();
			} else if (!position.getId().equals(user.getPosition().getId())) {// 如果岗位发生变化,则清除用户所有角色
				user.clearRole();
			}
			userService.update(user);
			modelMap.addAttribute("success", Boolean.TRUE);
			logger.info(messages.getMessage("log.info.edit", new String[] { securityUtils.getUserFullName(), messages.getMessage(domain), username }));
		} catch (HibernateOptimisticLockingFailureException e) {
			e.printStackTrace();
			modelMap.addAttribute("success", Boolean.FALSE);
			modelMap.addAttribute("error", ErrorCode.OPTIMISTIC_LOCKING);
			logger.error(messages.getMessage("log.error.edit",
					new String[] { securityUtils.getUserFullName(), messages.getMessage(domain), username }));
		} catch (Exception e) {
			e.printStackTrace();
			modelMap.addAttribute("success", Boolean.FALSE);
			modelMap.addAttribute("error", ErrorCode.UNCAUGHT_EXCEPTION);
			logger.error(messages.getMessage("log.error.edit",
					new String[] { securityUtils.getUserFullName(), messages.getMessage(domain), username }));
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
	 * @param username 用户名
	 * @param modelMap
	 * @return
	 * @throws SaviorFrameworkException
	 */
	@RequestMapping(value = "/view/{username}", method = RequestMethod.GET)
	public @ResponseBody
	ModelMap get(@PathVariable("username") String username, ModelMap modelMap) throws SaviorFrameworkException {
		try {
			modelMap.addAttribute(Constants.DEFAULT_RECORD_MODEL_KEY, userService.findByUsername(username));
			modelMap.addAttribute("success", Boolean.TRUE);
		} catch (Exception e) {
			e.printStackTrace();
			modelMap.addAttribute("success", Boolean.FALSE);
			modelMap.addAttribute("error", ErrorCode.UNCAUGHT_EXCEPTION);
		}
		return modelMap;
	}

	/**
	 * 批量删除用户
	 * 
	 * @param usernames 用户名数组
	 * @param modelMap
	 * @return
	 * @throws SaviorFrameworkException
	 */
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public @ResponseBody
	ModelMap delete(@RequestParam(value = "usernames", required = true) String[] usernames, ModelMap modelMap) throws SaviorFrameworkException {
		try {
			userService.deleteByUsernames(usernames);
			modelMap.addAttribute("success", Boolean.TRUE);
			logger.info(messages.getMessage("log.info.delete", new String[] { securityUtils.getUserFullName(), messages.getMessage(domain),
					StringUtils.arrayToDelimitedString((Object[]) usernames, "|") }));
		} catch (DataIntegrityViolationException e) {
			e.printStackTrace();
			modelMap.addAttribute("success", Boolean.FALSE);
			modelMap.addAttribute("error", messages.getMessage("error.constraint.delete") + "[" + ErrorCode.DATA_INTEGRITY_VIOLATION + "]");
			logger.error(messages.getMessage("log.error.delete", new String[] { securityUtils.getUserFullName(), messages.getMessage(domain),
					StringUtils.arrayToDelimitedString((Object[]) usernames, "|") }));
		} catch (Exception e) {
			e.printStackTrace();
			modelMap.addAttribute("success", Boolean.FALSE);
			modelMap.addAttribute("error", ErrorCode.UNCAUGHT_EXCEPTION);
			logger.error(messages.getMessage("log.error.delete", new String[] { securityUtils.getUserFullName(), messages.getMessage(domain),
					StringUtils.arrayToDelimitedString((Object[]) usernames, "|") }));
		}
		return modelMap;
	}

	/**
	 * 返回分配角色页面
	 * 
	 * @return 角色授权页面视图名称
	 * @throws SaviorFrameworkException
	 */
	@RequestMapping(value = "/role", method = RequestMethod.GET)
	public String assignRole() throws SaviorFrameworkException {
		return viewPrefix + "role_assign";
	}

	/**
	 * 返回用户的角色数据.
	 * 
	 * @param user
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/role/{user}", method = RequestMethod.GET)
	public @ResponseBody
	ModelMap assignRole(@PathVariable("user") String user, ModelMap modelMap) {
		try {
			modelMap.addAttribute(Constants.DEFAULT_RECORD_MODEL_KEY, roleService.findByUser(user));
			modelMap.addAttribute("success", Boolean.TRUE);
		} catch (Exception e) {
			e.printStackTrace();
			modelMap.addAttribute("success", Boolean.FALSE);
			modelMap.addAttribute("error", ErrorCode.UNCAUGHT_EXCEPTION);
		}
		return modelMap;
	}

	/**
	 * 保存用户与角色的关联信息.
	 * 
	 * @param ids 角色id数组
	 * @param username 用户名
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/role", method = RequestMethod.POST)
	public @ResponseBody
	ModelMap saveUserRole(@RequestParam("ids") String[] ids, @RequestParam("username") String username, ModelMap modelMap) {
		try {
			userService.saveUserRole(ids, username);
			modelMap.addAttribute("success", Boolean.TRUE);
		} catch (Exception e) {
			e.printStackTrace();
			modelMap.addAttribute("success", Boolean.FALSE);
			modelMap.addAttribute("error", ErrorCode.UNCAUGHT_EXCEPTION);
		}
		return modelMap;
	}

	/**
	 * 修改密码.
	 * 
	 * @param currentPassword 当前密码
	 * @param newPassword 新密码
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/changepassword", method = RequestMethod.POST)
	@ResponseBody
	public ModelMap changePassword(@RequestParam("currentPassword") String currentPassword, @RequestParam("newPassword") String newPassword,
			ModelMap modelMap) {
		if (CryptographicStrengthChecker.check(newPassword)) {
			try {
				if (securityUtils.getUser().getPassword().equals(passwordEncoder.encodePassword(currentPassword, ""))) {
					User user = (User) userService.get(securityUtils.getUser().getUsername());
					user.setPassword(passwordEncoder.encodePassword(newPassword, ""));
					userService.update(user);
					modelMap.addAttribute("success", Boolean.TRUE);
				} else {
					modelMap.addAttribute("success", Boolean.FALSE);
					modelMap.addAttribute("error", ErrorCode.PASSWORD_INCORRECT);
				}
			} catch (Exception e) {
				e.printStackTrace();
				modelMap.addAttribute("success", Boolean.FALSE);
				modelMap.addAttribute("error", ErrorCode.UNCAUGHT_EXCEPTION);
			}
		} else {
			modelMap.addAttribute("success", Boolean.FALSE);
			modelMap.addAttribute("error", ErrorCode.PASSWORD_INVALID);
		}

		return modelMap;
	}

	/**
	 * 重置密码
	 * 
	 * @param usernames
	 * @param modelMap
	 * @return
	 * @throws SaviorFrameworkException
	 */
	@RequestMapping(value = "/resetpassword", method = RequestMethod.POST)
	public @ResponseBody
	ModelMap resetPassword(@RequestParam(value = "usernames", required = true) String[] usernames, ModelMap modelMap) throws SaviorFrameworkException {
		try {
			Set<User> users = new HashSet<User>();
			User user = null;

			for (String username : usernames) {
				user = (User) userService.get(username);
				user.setPassword(passwordEncoder.encodePassword(Constants.DEFAULT_PASSWORD, ""));
				users.add(user);
			}
			userService.save(users);
			modelMap.addAttribute("success", Boolean.TRUE);
		} catch (Exception e) {
			e.printStackTrace();
			modelMap.addAttribute("success", Boolean.FALSE);
			modelMap.addAttribute("error", ErrorCode.UNCAUGHT_EXCEPTION);
		}
		return modelMap;
	}

	@RequestMapping(value = "/select", method = RequestMethod.GET)
	@ResponseBody
	public List<Map<String, Object>> select(@RequestParam("node") String org) throws SaviorFrameworkException {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		list.addAll(userService.findByOrg(org));
		list.addAll(orgService.findByParent(org, true));
		return list;
	}

	/**
	 * 根据机构查询可用岗位.
	 * 
	 * @param org
	 * @return
	 * @throws SaviorFrameworkException
	 */
	@RequestMapping(value = "/position", method = RequestMethod.GET)
	@ResponseBody
	public ModelMap getPosition(@RequestParam(value = "org", required = true) String org, ModelMap modelMap) throws SaviorFrameworkException {
		try {
			modelMap.addAttribute(Constants.DEFAULT_RECORD_MODEL_KEY, positionService.findByOrg(org));
			modelMap.addAttribute("success", Boolean.TRUE);
		} catch (Exception e) {
			e.printStackTrace();
			modelMap.addAttribute("success", Boolean.FALSE);
			modelMap.addAttribute("error", ErrorCode.UNCAUGHT_EXCEPTION);
		}
		return modelMap;
	}
	
	/**
	 * 根据机构查询可用岗位.
	 * 
	 * @param org
	 * @return
	 * @throws SaviorFrameworkException
	 */
	@RequestMapping(value = "/position2", method = RequestMethod.GET)
	@ResponseBody
	public void getPosition2(@RequestParam(value = "org", required = true) String org, HttpServletResponse response) throws SaviorFrameworkException {
		try {
			JSONArray jsonArray = JSONArray.fromObject( positionService.findByOrg(org));
			response.getWriter().write(jsonArray.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 启用用户.
	 * 
	 * @param usernames 用户名数组
	 * @param modelMap
	 * @return
	 * @throws SaviorFrameworkException
	 */
	@RequestMapping(value = "/enable", method = RequestMethod.POST)
	public @ResponseBody
	ModelMap enable(@RequestParam(value = "usernames", required = true) String[] usernames, ModelMap modelMap) throws SaviorFrameworkException {
		try {
			Set<User> users = new HashSet<User>();
			for (String username : usernames) {
				User user = (User) userService.get(username);
				if (user != null) {
					user.setEnabled(true);
					users.add(user);
				}
			}
			userService.update(users);
			modelMap.addAttribute("success", Boolean.TRUE);
		} catch (Exception e) {
			e.printStackTrace();
			modelMap.addAttribute("success", Boolean.FALSE);
			modelMap.addAttribute("error", ErrorCode.UNCAUGHT_EXCEPTION);
		}
		return modelMap;
	}

	/**
	 * 停用用户.
	 * 
	 * @param usernames 用户名数组
	 * @param modelMap
	 * @return
	 * @throws SaviorFrameworkException
	 */
	@RequestMapping(value = "/disable", method = RequestMethod.POST)
	public @ResponseBody
	ModelMap disable(@RequestParam(value = "usernames", required = true) String[] usernames, ModelMap modelMap) throws SaviorFrameworkException {
		try {
			Set<User> users = new HashSet<User>();
			for (String username : usernames) {
				User user = (User) userService.get(username);
				if (user != null) {
					user.setEnabled(false);
					users.add(user);
				}
			}
			userService.update(users);
			modelMap.addAttribute("success", Boolean.TRUE);
		} catch (Exception e) {
			e.printStackTrace();
			modelMap.addAttribute("success", Boolean.FALSE);
			modelMap.addAttribute("error", ErrorCode.UNCAUGHT_EXCEPTION);
		}
		return modelMap;
	}

}
