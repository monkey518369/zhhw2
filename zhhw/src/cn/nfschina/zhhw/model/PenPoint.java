package cn.nfschina.zhhw.model;
/**
 * 围栏，线路的定点
 * @author wxy
 *
 */
public class PenPoint {
	private Long id;
	private Long fk_pen_id;
	private Float lat;
	private Float lng;
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
	 * @return the fk_pen_id
	 */
	public Long getFk_pen_id() {
		return fk_pen_id;
	}
	/**
	 * @param fk_pen_id the fk_pen_id to set
	 */
	public void setFk_pen_id(Long fk_pen_id) {
		this.fk_pen_id = fk_pen_id;
	}
}
