package com.gph.saviorframework.security.web.editor;

import java.beans.PropertyEditorSupport;

import com.gph.saviorframework.common.model.Field;
import com.gph.saviorframework.security.service.FieldService;

/**
 * 数据项Editor
 * 
 */
public class FieldEditor extends PropertyEditorSupport {

	private FieldService fieldService;

	/**
	 * @param itemService
	 */
	public FieldEditor(FieldService fieldService) {
		this.fieldService = fieldService;
	}

	/**
	 * @return
	 * @see java.beans.PropertyEditorSupport#getAsText()
	 */
	@Override
	public String getAsText() {
		if (getValue() instanceof Field) {
			return ((Field) getValue()).getId().toString();
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
		Object field = fieldService.get(Long.valueOf(text));
		if (field != null && field instanceof Field) {
			setValue(field);
		} else {
			setValue(new Field(Long.valueOf(text)));
		}
	}

}
