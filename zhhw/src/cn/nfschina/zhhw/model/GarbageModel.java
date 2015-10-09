package cn.nfschina.zhhw.model;

import java.util.Date;

/**
 * 
 * @author shaolinxing
 * @time 2015年9月22日 下午7:16:54
 */
public class GarbageModel {

	private Long id;
	
	private Long fk_car_id;
	
	private Double weight;
	
	private double lng;
	
	private double lat;
	
	private Date createTime;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getFk_car_id() {
		return fk_car_id;
	}

	public void setFk_car_id(Long fk_car_id) {
		this.fk_car_id = fk_car_id;
	}

	public Double getWeight() {
		return weight;
	}

	public void setWeight(Double weight) {
		this.weight = weight;
	}

	public double getLng() {
		return lng;
	}

	public void setLng(double lng) {
		this.lng = lng;
	}

	public double getLat() {
		return lat;
	}

	public void setLat(double lat) {
		this.lat = lat;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	
	public String toString(){
		return "id:"+id+"  fk_car_id:"+fk_car_id+"  weight:"+weight+"  lng:"+lng+
				"  lat:"+lat+" createTime:"+createTime;
	}
	
	
}
