package cn.nfschina.zhhw.model;
/**
 * 围栏，线路的定点
 * @author wxy
 *
 */
public class LinePoint {
	private Long id;
	private Long fk_line_id;
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
	 * @return the fk_line_id
	 */
	public Long getFk_line_id() {
		return fk_line_id;
	}
	/**
	 * @param fk_line_id the fk_line_id to set
	 */
	public void setFk_line_id(Long fk_line_id) {
		this.fk_line_id = fk_line_id;
	}
}
