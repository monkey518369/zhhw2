package cn.nfschina.zhhw.model;

import java.util.Date;

/**
 * @Description: 车辆报警实体类
 * @copyright: nfschina
 * @ClassName: CarWarning
 * @author wcy
 * @date 2015年9月10日 下午4:40:40
 */
public class CarWarning {
 	private String id;
	private String car_id;
	private String plate_no;
	private String type;
	private String car_lng;
	private String car_lat;
	private String point;
	private Date create_time;
	private Date hand_time;
	private String handman;
	private String describe;
	private String status;
	
	public CarWarning() {
		super();
	}
	
	
	public CarWarning(String id, String car_id, String plate_no, String type,
			String car_lng, String car_lat, String point, Date create_time,
			Date hand_time, String handman, String describe, String status) {
		super();
		this.id = id;
		this.car_id = car_id;
		this.plate_no = plate_no;
		this.type = type;
		this.car_lng = car_lng;
		this.car_lat = car_lat;
		this.point = point;
		this.create_time = create_time;
		this.hand_time = hand_time;
		this.handman = handman;
		this.describe = describe;
		this.status = status;
	}

	public String getId() {
		return id;
	}


	public void setId(String id) {
		this.id = id;
	}

	public String getCar_id() {
		return car_id;
	}
	public void setCar_id(String car_id) {
		this.car_id = car_id;
	}
	public String getPlate_no() {
		return plate_no;
	}
	public void setPlate_no(String plate_no) {
		this.plate_no = plate_no;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
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
	public String getPoint() {
		return point;
	}
	public void setPoint(String point) {
		this.point = point;
	}
	public Date getCreate_time() {
		return create_time;
	}
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	public String getHandman() {
		return handman;
	}
	public void setHandman(String handman) {
		this.handman = handman;
	}
	public String getDescribe() {
		return describe;
	}
	public void setDescribe(String describe) {
		this.describe = describe;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}


	public Date getHand_time() {
		return hand_time;
	}


	public void setHand_time(Date hand_time) {
		this.hand_time = hand_time;
	}
	
	
}
