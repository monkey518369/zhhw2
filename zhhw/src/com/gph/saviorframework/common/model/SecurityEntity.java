package com.gph.saviorframework.common.model;

import java.util.Date;

/**
 * 安全实体接口
 * @author guopeihui
 *
 */
public interface SecurityEntity {

	public void setCreator(User creator);

	public void setCreated(Date created);

	public void setModifier(User modifier);

	public void setModified(Date modified);
}
