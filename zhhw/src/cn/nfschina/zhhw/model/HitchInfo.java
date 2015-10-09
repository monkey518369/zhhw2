package cn.nfschina.zhhw.model;

/**
 * 字段	类型	 含义	
 * Id	bigInt		
 * truck_id	bigInt	车辆id	
 * Describe	Varchar	描述	
 * Lng	Varchar	经度	
 * Lat	Varchar	纬度	
 * Create_time	Datetime	发生时间	
 * user_id 登记人id
 * @author rjh
 */
public class HitchInfo {
	
	//主键
	private Long id;
	
	//车辆编号
	private Long fk_truck_id;
	
	//故障描述
	private String summary;
	
	//经度
	private Float lng;
	
	//纬度
	private Float lat;
	
	//故障登记时间
	private String create_time;
	
	//登记人id
	private Long user_id;
	
	//车牌号
	private String plateno;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getFk_truck_id() {
		return fk_truck_id;
	}

	public void setFk_truck_id(Long fk_truck_id) {
		this.fk_truck_id = fk_truck_id;
	}

	public String getSummary() {
		return summary;
	}

	public void setSummary(String summary) {
		this.summary = summary;
	}

	public Float getLng() {
		return lng;
	}

	public void setLng(Float lng) {
		this.lng = lng;
	}

	public Float getLat() {
		return lat;
	}

	public void setLat(Float lat) {
		this.lat = lat;
	}

	public String getCreate_time() {
		return create_time;
	}

	public void setCreate_time(String create_time) {
		this.create_time = create_time;
	}

	public Long getUser_id() {
		return user_id;
	}

	public void setUser_id(Long user_id) {
		this.user_id = user_id;
	}

	public String getPlateno() {
		return plateno;
	}

	public void setPlateno(String plateno) {
		this.plateno = plateno;
	}
	
	

}
