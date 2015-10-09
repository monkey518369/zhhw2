package cn.nfschina.zhhw.model;

import java.sql.Timestamp;

/**
 * 用来做数据统计的model用。position太复杂。
 * @author 邵林兴
 * @time 2015年9月10日 下午3:44:27
 */
public class DataStatisticsModel {

	private static final long serialVersionUID = 7140321542723764234L;
	//虚拟ID
	private Long id;
	//报警
	private Integer warning;
	//发生时间
	private Timestamp createtime;
	//车辆id
	private Long fk_car_id;
	//里程表数据
	private Float mileage;
	//油量数据
	private Float oil;
	//车重量
	private Float weight;
	//是否在线
	private Integer online;
	
	public Integer getOnline() {
		return online;
	}
	public void setOnline(Integer online) {
		this.online = online;
	}
	public void setWeight(float weight) {
		this.weight = weight;
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public Integer getWarning() {
		return warning;
	}
	public void setWarning(Integer warning) {
		this.warning = warning;
	}
	public Timestamp getCreatetime() {
		return createtime;
	}
	public void setCreatetime(Timestamp createtime) {
		this.createtime = createtime;
	}
	public Long getFk_car_id() {
		return fk_car_id;
	}
	public void setFk_car_id(Long fk_car_id) {
		this.fk_car_id = fk_car_id;
	}
	public Float getMileage() {
		return mileage;
	}
	public void setMileage(Float mileage) {
		this.mileage = mileage;
	}
	public Float getOil() {
		return oil;
	}
	public void setOil(Float oil) {
		this.oil = oil;
	}
	public Float getWeight() {
		return weight;
	}
	public void setWeight(Float weight) {
		this.weight = weight;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	public String toString(){
		
		return "this is dataStatisticsModel";
		
	}
}
