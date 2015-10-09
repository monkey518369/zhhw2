package com.gph.saviorframework.security.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.gph.saviorframework.SaviorFrameworkException;
import com.gph.saviorframework.common.model.Permission;
import com.gph.saviorframework.common.model.SubItem;
import com.gph.saviorframework.config.service.SubItemService;

@Component
public class ItemProvider {

	/** 服务 */
	@Autowired
	private SubItemService subItemService;

	@Autowired
	private PermissionProvider permissionProvider;

	/**
	 * 根据字典主项ID查询字典子项.
	 * 
	 * @param itemId 字典主项ID
	 * @return
	 */
	public List<SubItem> getSubItemEntity(String itemId) {
		return subItemService.findEntityByItem(itemId);
	}

	/**
	 * 根据字典ID和字典值.
	 * 
	 * @param itemId
	 * @param subitemValue
	 * @return
	 */
	public SubItem getSubItem(String itemId, String subitemValue) {
		return (SubItem) subItemService.findSubItem(itemId, subitemValue);

	}

	/**
	 * 根据字典主项ID查询字典子项.
	 * 
	 * @param itemId 字典主项ID
	 * @return
	 */
	public List<Map<String, Object>> getSubItemMap(String itemId) {
		return subItemService.findMapByItem(itemId);
	}

	/**
	 * 根据当前登录用户,功能ID和字典主项ID查询字典子项.
	 * 
	 * @param itemId 字典主项ID
	 * @return
	 * @throws SaviorFrameworkException
	 */
	public List<SubItem> getSubItemEntityByPermission(String itemId, String functionId) throws SaviorFrameworkException {
		List<SubItem> subitems = new ArrayList<SubItem>();
		Set<Permission> permissions = permissionProvider.getItemPermissionByFunction(functionId);
		for (Permission permission : permissions) {
			if (permission.getSubitem().getParent().getId().equals(itemId)) {
				subitems.add(permission.getSubitem());
			}
		}
		return subitems;
	}

	/**
	 * 根据当前登录用户,功能ID和字典主项ID查询字典子项.
	 * 
	 * @param itemId
	 * @param functionId
	 * @return
	 * @throws SaviorFrameworkException
	 */
	public List<Map<String, Object>> getSubItemMapByPermission(String itemId, String functionId) throws SaviorFrameworkException {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		for (SubItem subitem : getSubItemEntityByPermission(itemId, functionId)) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("id", subitem.getId());
			map.put("name", subitem.getName());
			map.put("value", subitem.getValue());
			map.put("cascade", subitem.isCascade());
			list.add(map);
		}
		return list;
	}

}
