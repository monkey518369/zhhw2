package com.gph.saviorframework.security.web.editor;

import java.beans.PropertyEditorSupport;

import com.gph.saviorframework.common.model.SubItem;
import com.gph.saviorframework.config.service.SubItemService;

/**
 * 数据项Editor
 * 
 */
public class SubItemEditor extends PropertyEditorSupport {

	private SubItemService subitemService;

	/**
	 * @param itemService
	 */
	public SubItemEditor(SubItemService subitemService) {
		this.subitemService = subitemService;
	}

	/**
	 * @return
	 * @see java.beans.PropertyEditorSupport#getAsText()
	 */
	@Override
	public String getAsText() {
		if (getValue() instanceof SubItem) {
			return ((SubItem) getValue()).getId().toString();
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
		Object subitem = subitemService.get(Long.valueOf(text));
		if (subitem != null && subitem instanceof SubItem) {
			setValue(subitem);
		} else {
			setValue(new SubItem(Long.valueOf(text)));
		}
	}

}
