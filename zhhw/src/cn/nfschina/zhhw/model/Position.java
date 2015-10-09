package cn.nfschina.zhhw.model;

import java.sql.Timestamp;

/**
 * @Description:车辆位置信息
 * copyright nfschina
 * Position.java
 * create on 2015年9月7日
 * @author wxy
 */
public class Position implements java.io.Serializable {

	private static final long serialVersionUID = 7140321542723764234L;
	//虚拟ID
	private Long id;
	//报警
	private Integer warning;
	//状态，预留字段
	private Integer status;
	//纬度
	private Float lat;
	//经度
	private Float lng;
	//角度
	private Integer altitude;
	//速度
	private Integer speed;
	//方向
	private Integer direction;
	//
	private Timestamp createtime;
	//
	private Long fk_car_id;
	/**
	 * @return the id
	 */
	public Long getId() {
		return id;
	}
	/**
	 * @param id the id to set
	 */
	public void setId(Long id) {
		this.id = id;
	}
	/**
	 * @return the warning
	 */
	public Integer getWarning() {
		return warning;
	}
	/**
	 * @param warning the warning to set
	 */
	public void setWarning(Integer warning) {
		this.warning = warning;
	}
	/**
	 * @return the status
	 */
	public Integer getStatus() {
		return status;
	}
	/**
	 * @param status the status to set
	 */
	public void setStatus(Integer status) {
		this.status = status;
	}
	/**
	 * @return the lat
	 */
	public Float getLat() {
		return lat;
	}
	/**
	 * @param lat the lat to set
	 */
	public void setLat(Float lat) {
		this.lat = lat;
	}
	/**
	 * @return the lng
	 */
	public Float getLng() {
		return lng;
	}
	/**
	 * @param lng the lng to set
	 */
	public void setLng(Float lng) {
		this.lng = lng;
	}
	/**
	 * @return the altitude
	 */
	public Integer getAltitude() {
		return altitude;
	}
	/**
	 * @param altitude the altitude to set
	 */
	public void setAltitude(Integer altitude) {
		this.altitude = altitude;
	}
	/**
	 * @return the speed
	 */
	public Integer getSpeed() {
		return speed;
	}
	/**
	 * @param speed the speed to set
	 */
	public void setSpeed(Integer speed) {
		this.speed = speed;
	}
	/**
	 * @return the direction
	 */
	public Integer getDirection() {
		return direction;
	}
	/**
	 * @param direction the direction to set
	 */
	public void setDirection(Integer direction) {
		this.direction = direction;
	}
	/**
	 * @return the createtime
	 */
	public Timestamp getCreatetime() {
		return createtime;
	}
	/**
	 * @param createtime the createtime to set
	 */
	public void setCreatetime(Timestamp createtime) {
		this.createtime = createtime;
	}
	/**
	 * @return the fk_car_id
	 */
	public Long getFk_car_id() {
		return fk_car_id;
	}
	/**
	 * @param fk_car_id the fk_car_id to set
	 */
	public void setFk_car_id(Long fk_car_id) {
		this.fk_car_id = fk_car_id;
	}
	
	
}