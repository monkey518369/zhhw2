package com.gph.saviorframework.config.web.editor;

import java.beans.PropertyEditorSupport;

import com.gph.saviorframework.common.model.Item;
import com.gph.saviorframework.config.service.ItemService;

/**
 * 数据项Editor
 * 
 * 
 */
public class ItemEditor extends PropertyEditorSupport {

	private ItemService itemService;

	/**
	 * @param itemService
	 */
	public ItemEditor(ItemService itemService) {
		this.itemService = itemService;
	}

	/**
	 * @return
	 * @see java.beans.PropertyEditorSupport#getAsText()
	 */
	@Override
	public String getAsText() {
		if (getValue() instanceof Item) {
			return ((Item) getValue()).getId().toString();
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
		Object item = itemService.get(text);
		if (item != null && item instanceof Item) {
			setValue(item);
		} else {
			setValue(new Item(text));
		}
	}

}
