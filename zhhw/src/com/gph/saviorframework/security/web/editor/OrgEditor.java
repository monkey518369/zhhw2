package com.gph.saviorframework.security.web.editor;

import java.beans.PropertyEditorSupport;

import com.gph.saviorframework.common.model.Org;
import com.gph.saviorframework.security.service.OrgService;

/**
 * 机构Editor
 * 
 */
public class OrgEditor extends PropertyEditorSupport {

	private OrgService orgService;

	/**
	 * @param orgService
	 */
	public OrgEditor(OrgService orgService) {
		this.orgService = orgService;
	}

	/**
	 * @return
	 * @see java.beans.PropertyEditorSupport#getAsText()
	 */
	@Override
	public String getAsText() {
		if (getValue() instanceof Org) {
			return ((Org) getValue()).getId().toString();
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
		Object org = orgService.get(text);
		if (org != null) {
			setValue(org);
		} else {
			setValue(new Org(text));
		}
	}

}
