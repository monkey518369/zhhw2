package cn.nfschina.zhhw.model;
/**
 * 
 * @author rjh
 * 车辆信息  t_car
 * id	bigint		
 * color	int	颜色	
 * city	int	所在城市	
 * province	int	所在省份	
 * vin	varchar	车管所唯一标识符	
 * fk_org_id	int	车所属公司id	
 * plate_no	varchar	车牌号	
 * start_date	date	车的创建时间	
 * end_date	date	车的报销时间	
 * truck_version	varchar 	车的型号	
 * truck_length	double	车长	
 * truck_width	double	车宽	
 * truck_weight	double 	车重	
 * remark	varchar	备注	
 * online	tinyint	是否在线	
 * sim	varchar	联系电话	
 */
public class TruckInfo {
	
	//主键,车的ID
	private Long id;
	
	//车所属公司ID
	private Long fk_org_id;
	
	//设备外键
	private Long fk_device_id;
	
	//车管所唯一标识符
	private String vin;
	
	//所在城市
	private Integer city;
	
	//所在省
	private Integer province;
	
	//是否在线
	private Integer online;
	
	//车牌号
	private String plate_no;
	
	//车创建时间
	private String start_date;
	
	//车的报销时间
	private String end_date;
	
	//车的型号
	private String truck_version;
	
	//车的颜色
	private Integer color;
	
	//车长
	private Double truck_length;
	
	//车宽
	private Double truck_width;
	
	//车重
	private Double truck_weight;
	
	//备注
	private String remark;
	
	//联系电话
	private String sim;
	
	//组织机构的实体名称
	private String org_name;
	
	//终端设备名称
	private String dev_name;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getFk_org_id() {
		return fk_org_id;
	}

	public void setFk_org_id(Long fk_org_id) {
		this.fk_org_id = fk_org_id;
	}

	public Long getFk_device_id() {
		return fk_device_id;
	}

	public void setFk_device_id(Long fk_device_id) {
		this.fk_device_id = fk_device_id;
	}

	public String getVin() {
		return vin;
	}

	public void setVin(String vin) {
		this.vin = vin;
	}

	public Integer getCity() {
		return city;
	}

	public void setCity(Integer city) {
		this.city = city;
	}

	public Integer getProvince() {
		return province;
	}

	public void setProvince(Integer province) {
		this.province = province;
	}

	public Integer getOnline() {
		return online;
	}

	public void setOnline(Integer online) {
		this.online = online;
	}

	public String getPlate_no() {
		return plate_no;
	}

	public void setPlate_no(String plate_no) {
		this.plate_no = plate_no;
	}

	public String getStart_date() {
		return start_date;
	}

	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}

	public String getEnd_date() {
		return end_date;
	}

	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}

	public String getTruck_version() {
		return truck_version;
	}

	public void setTruck_version(String truck_version) {
		this.truck_version = truck_version;
	}

	public Integer getColor() {
		return color;
	}

	public void setColor(Integer color) {
		this.color = color;
	}

	public Double getTruck_length() {
		return truck_length;
	}

	public void setTruck_length(Double truck_length) {
		this.truck_length = truck_length;
	}

	public Double getTruck_width() {
		return truck_width;
	}

	public void setTruck_width(Double truck_width) {
		this.truck_width = truck_width;
	}

	public Double getTruck_weight() {
		return truck_weight;
	}

	public void setTruck_weight(Double truck_weight) {
		this.truck_weight = truck_weight;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getSim() {
		return sim;
	}

	public void setSim(String sim) {
		this.sim = sim;
	}

	public String getOrg_name() {
		return org_name;
	}

	public void setOrg_name(String org_name) {
		this.org_name = org_name;
	}

	public String getDev_name() {
		return dev_name;
	}

	public void setDev_name(String dev_name) {
		this.dev_name = dev_name;
	}

}
