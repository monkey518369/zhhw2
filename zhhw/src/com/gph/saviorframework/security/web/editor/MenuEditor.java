package com.gph.saviorframework.security.web.editor;

import java.beans.PropertyEditorSupport;

import com.gph.saviorframework.Constants;
import com.gph.saviorframework.common.model.Menu;
import com.gph.saviorframework.security.service.MenuService;

/**
 * 菜单Editor
 * 
 */
public class MenuEditor extends PropertyEditorSupport {

	private MenuService menuService;

	/**
	 * @param menuService
	 */
	public MenuEditor(MenuService menuService) {
		this.menuService = menuService;
	}

	/**
	 * @return
	 * @see java.beans.PropertyEditorSupport#getAsText()
	 */
	@Override
	public String getAsText() {
		if (getValue() instanceof Menu) {
			return ((Menu) getValue()).getId().toString();
		}
		return null;
	}

	/**
	 * @param text
	 * @throws IllegalArgumentException
	 * @see java.beans.PropertyEditorSupport#setAsText(java.lang.String)
	 */
	@Override
	public void setAsText(String text) throws IllegalArgumentException {
		if (text.equalsIgnoreCase(Constants.TREE_ROOT_NODE) || text.equalsIgnoreCase("")) {
			setValue(null);
			return;
		}
		Object menu = menuService.get(text);
		if (menu != null) {
			setValue(menu);
		} else {
			setValue(new Menu(text));
		}
	}

}
