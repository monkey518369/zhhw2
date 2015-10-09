package cn.nfschina.zhhw.model;

/**
* @Description: 车辆动态信息实体类
* @copyright: nfschina
* @ClassName: TruckDynamic
* @author wcy
* @date 2015年9月2日 上午8:52:33
 */
public class TruckDynamic {
	
	//车辆Id
	private String truck_id;
	
	//车辆时速
	private String speed;
	
	private String company;
	//车辆油量
	private String oil;
	
	//车辆状态
	private String status;
	
	//车辆经度
	private String car_lng;
	
	//车辆纬度
	private String car_lat;
	
	private String createTime;
	
	//车载终端状态
	private String deviceStatus;

	public TruckDynamic() {
		super();
	}

	public TruckDynamic(String truck_id, String speed, String company, String oil,
			String status, String car_lng, String car_lat,String deviceStatus,String createTime) {
		super();
		this.truck_id = truck_id;
		this.speed = speed;
		this.company = company;
		this.oil = oil;
		this.status = status;
		this.car_lng = car_lng;
		this.car_lat = car_lat;
		this.deviceStatus = deviceStatus;
		this.createTime = createTime;
	}

	public String getTruck_id() {
		return truck_id;
	}

	public void setTruck_id(String truck_id) {
		this.truck_id = truck_id;
	}

	public String getSpeed() {
		return speed;
	}

	public void setSpeed(String speed) {
		this.speed = speed;
	}

	public String getOil() {
		return oil;
	}

	public void setOil(String oil) {
		this.oil = oil;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
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

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public String getDeviceStatus() {
		return deviceStatus;
	}

	public void setDeviceStatus(String deviceStatus) {
		this.deviceStatus = deviceStatus;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	
}
