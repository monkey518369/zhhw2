package cn.nfschina.zhhw.model;

import java.util.Set;

/**
 * 
 * @author shaolinxing
 * @time 2015年9月14日 下午8:09:15
 */
public class EasyUITree {

	private String id;
	
	private String text;
	
	private String state;
	
	private boolean checkbox;
	
	private Set<EasyUITree> children;
	
	private String parentId;

	public EasyUITree() {
		super();
	}

	public EasyUITree(String id, String text, String state, boolean checkbox,
			Set<EasyUITree> children, String parentId) {
		super();
		this.id = id;
		this.text = text;
		this.state = state;
		this.checkbox = checkbox;
		this.children = children;
		this.parentId = parentId;
	}

	public String getParentId() {
		return parentId;
	}

	public void setParentId(String parentId) {
		this.parentId = parentId;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public boolean isCheckbox() {
		return checkbox;
	}

	public void setCheckbox(boolean checkbox) {
		this.checkbox = checkbox;
	}

	public Set<EasyUITree> getChildren() {
		return children;
	}

	public void setChildren(Set<EasyUITree> children) {
		this.children = children;
	}
	
	
	
}
