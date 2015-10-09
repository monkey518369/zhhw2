/**
 * copyright nfschina
 * Pen.java
 * create on 2015年9月14日
 * @author wxy
 */
package cn.nfschina.zhhw.model;

import java.sql.Date;

/**
 * @Description:电子围栏
 * copyright nfschina
 * Pen.java
 * create on 2015年9月14日
 * @author wxy
 */
public class Pen {
	private Long id;//代理主键
	private String fence_name;//围栏名称
	private Float speed;//速度
	private Integer rate_limit;//是否限速
	private Integer in_alarm_plant;//是否进入围栏时向平台报警
	private Integer in_alarm_driver;//是否进入围栏时向司机报警
	private Integer out_alarm_plant;//是否出围栏时向平台报警
	private Integer out_alarm_driver;//是否出围栏时向司机报警
	private Date create_time;//创建时间
	private Long fk_creater_id;//创建人
	private Date lose_time;//销毁时间
	private Integer speed_time;//速度超时多久时报警
	private Long fk_tenant_id;//租户代码
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
	 * @return the fence_name
	 */
	public String getFence_name() {
		return fence_name;
	}
	/**
	 * @param fence_name the fence_name to set
	 */
	public void setFence_name(String fence_name) {
		this.fence_name = fence_name;
	}
	/**
	 * @return the speed
	 */
	public Float getSpeed() {
		return speed;
	}
	/**
	 * @param speed the speed to set
	 */
	public void setSpeed(Float speed) {
		this.speed = speed;
	}
	/**
	 * @return the rate_limit
	 */
	public Integer getRate_limit() {
		return rate_limit;
	}
	/**
	 * @param rate_limit the rate_limit to set
	 */
	public void setRate_limit(Integer rate_limit) {
		this.rate_limit = rate_limit;
	}
	/**
	 * @return the in_alarm_plant
	 */
	public Integer getIn_alarm_plant() {
		return in_alarm_plant;
	}
	/**
	 * @param in_alarm_plant the in_alarm_plant to set
	 */
	public void setIn_alarm_plant(Integer in_alarm_plant) {
		this.in_alarm_plant = in_alarm_plant;
	}
	/**
	 * @return the in_alarm_driver
	 */
	public Integer getIn_alarm_driver() {
		return in_alarm_driver;
	}
	/**
	 * @param in_alarm_driver the in_alarm_driver to set
	 */
	public void setIn_alarm_driver(Integer in_alarm_driver) {
		this.in_alarm_driver = in_alarm_driver;
	}
	/**
	 * @return the out_alarm_plant
	 */
	public Integer getOut_alarm_plant() {
		return out_alarm_plant;
	}
	/**
	 * @param out_alarm_plant the out_alarm_plant to set
	 */
	public void setOut_alarm_plant(Integer out_alarm_plant) {
		this.out_alarm_plant = out_alarm_plant;
	}
	/**
	 * @return the out_alarm_driver
	 */
	public Integer getOut_alarm_driver() {
		return out_alarm_driver;
	}
	/**
	 * @param out_alarm_driver the out_alarm_driver to set
	 */
	public void setOut_alarm_driver(Integer out_alarm_driver) {
		this.out_alarm_driver = out_alarm_driver;
	}
	/**
	 * @return the create_time
	 */
	public Date getCreate_time() {
		return create_time;
	}
	/**
	 * @param create_time the create_time to set
	 */
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	/**
	 * @return the fk_creater_id
	 */
	public Long getFk_creater_id() {
		return fk_creater_id;
	}
	/**
	 * @param fk_creater_id the fk_creater_id to set
	 */
	public void setFk_creater_id(Long fk_creater_id) {
		this.fk_creater_id = fk_creater_id;
	}
	/**
	 * @return the lose_time
	 */
	public Date getLose_time() {
		return lose_time;
	}
	/**
	 * @param lose_time the lose_time to set
	 */
	public void setLose_time(Date lose_time) {
		this.lose_time = lose_time;
	}
	/**
	 * @return the speed_time
	 */
	public Integer getSpeed_time() {
		return speed_time;
	}
	/**
	 * @param speed_time the speed_time to set
	 */
	public void setSpeed_time(Integer speed_time) {
		this.speed_time = speed_time;
	}
	/**
	 * @return the fk_tenant_id
	 */
	public Long getFk_tenant_id() {
		return fk_tenant_id;
	}
	/**
	 * @param fk_tenant_id the fk_tenant_id to set
	 */
	public void setFk_tenant_id(Long fk_tenant_id) {
		this.fk_tenant_id = fk_tenant_id;
	}
	
}
