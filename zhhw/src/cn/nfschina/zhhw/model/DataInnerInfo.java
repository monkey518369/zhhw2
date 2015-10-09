package cn.nfschina.zhhw.model;

import java.util.List;
/**
 * 用来生成前台highcharts要展示的数据
 * @author 邵林兴
 * @time 2015年9月17日 下午3:34:59
 */
public class DataInnerInfo {

	private String name;//数据列 的名称
	
	private List<Object> data;//数据列的数据(柱状图,折线图)
	
	private double y;//数据列饼状图
	
	private String color;//饼状图颜色

	public String getColor() {
		return color;
	}

	public void setColor(String color) {
		this.color = color;
	}

	public double getY() {
		return y;
	}

	public void setY(double y) {
		this.y = y;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Object getData() {
		return data;
	}

	public void setData(List<Object> data) {
		this.data = data;
	}
	
	
	
}
