package cn.nfschina.zhhw.model;

/**
 * @Description: 人员信息实体类
 * copyright nfschina
 * Person.java
 * create on 2015年9月2日 下午5:00:29
 * @author wcy
 */
public class Person {
	//虚拟id
	private String no;
	//所属单位
	private String company;
	//姓名
	private String name;
	//负责区域
	private String respondArea;
	//工作状态
	private String status;
	public Person() {
		super();
	}
	public Person(String no, String company, String name, String respondArea,
			String status) {
		super();
		this.no = no;
		this.company = company;
		this.name = name;
		this.respondArea = respondArea;
		this.status = status;
	}
	public String getNo() {
		return no;
	}
	public void setNo(String no) {
		this.no = no;
	}
	public String getCompany() {
		return company;
	}
	public void setCompany(String company) {
		this.company = company;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getRespondArea() {
		return respondArea;
	}
	public void setRespondArea(String respondArea) {
		this.respondArea = respondArea;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
}
