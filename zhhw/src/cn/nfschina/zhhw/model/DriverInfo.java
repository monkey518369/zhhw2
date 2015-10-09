package cn.nfschina.zhhw.model;
/**
 * 司机信息实体
 * @author rjh
 * id	bigint		
 * driver_name	varchar	姓名	
 * birth	varchar	出生年月	
 * sex	bit	性别	0女 1男
 * area	varchar	负责区域	
 * fk_org	varchar	所属公司	外键关联，关联org表的id
 * status	varchar	工作状态	
 * email	varchar	邮箱	
 * tel	varchar	电话	
 * remark	varchar	备注	
 */
public class DriverInfo {
	
	private Long id;
	private String driver_name;
	private String brith;
	private Integer sex;
	private String area;
	private String fk_org;
	private String status;
	private String email;
	private String tel;
	private String remark;
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getDriver_name() {
		return driver_name;
	}
	public void setDriver_name(String driver_name) {
		this.driver_name = driver_name;
	}
	public String getBrith() {
		return brith;
	}
	public void setBrith(String brith) {
		this.brith = brith;
	}
	public Integer getSex() {
		return sex;
	}
	public void setSex(Integer sex) {
		this.sex = sex;
	}
	public String getArea() {
		return area;
	}
	public void setArea(String area) {
		this.area = area;
	}
	public String getFk_org() {
		return fk_org;
	}
	public void setFk_org(String fk_org) {
		this.fk_org = fk_org;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	
}
