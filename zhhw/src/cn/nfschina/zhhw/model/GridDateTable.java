/**
 * copyright nfschina
 * Pen.java
 * create on 2015年9月14日
 * @author wxy
 */
package cn.nfschina.zhhw.model;

import java.sql.Date;
import java.util.List;

/**
 * @Description:电子围栏的封装
 * copyright nfschina
 * Pen.java
 * create on 2015年9月14日
 * @author wxy
 */
public class GridDateTable {
	private int total;
	private List rows;
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public List getRows() {
		return rows;
	}
	public void setRows(List rows) {
		this.rows = rows;
	}
}
