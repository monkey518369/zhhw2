package cn.nfschina.zhhw.model;

/**
 * @author Alessandro
 *
 */
public class SecurityCheck {

	private long id;
	//设备ID外键
	private long dev_id;
	//设备名
	private String dev_name;
	//车辆ID外键
	private long car_id;
	//车牌号
	private String car_no;
	//车辆经度
	private String car_lng;
	//车辆纬度
	private String car_lat;
	//设备状态
	private String status;
	private String createtime;
	
	
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public long getDev_id() {
		return dev_id;
	}
	public void setDev_id(long dev_id) {
		this.dev_id = dev_id;
	}
	public long getCar_id() {
		return car_id;
	}
	public void setCar_id(long car_id) {
		this.car_id = car_id;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getCar_no() {
		return car_no;
	}
	public void setCar_no(String car_no) {
		this.car_no = car_no;
	}
	public String getDev_name() {
		return dev_name;
	}
	public void setDev_name(String dev_name) {
		this.dev_name = dev_name;
	}
	public String getCar_lng() {
		return car_lng;
	}
	public void setCar_lng(String car_lng) {
		this.car_lng = car_lng;
	}
	public String getCar_lat() {
		return car_lat;
	}
	public void setCar_lat(String car_lat) {
		this.car_lat = car_lat;
	}
	public String getCreatetime() {
		return createtime;
	}
	public void setCreatetime(String createtime) {
		this.createtime = createtime;
	}
	
}
