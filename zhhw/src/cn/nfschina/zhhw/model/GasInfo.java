package cn.nfschina.zhhw.model;

/**
 * Id	bigInt	主键
 * fk_car_id	bigint	车辆编号
 * fk_driver_id	bigint	司机
 * Type	Varchar	油气类型
 * Volume	Int	升数
 * money	double	总金额
 * coordinate	Varchar	坐标
 * fk_handman	varchar	操作人id
 * price	double	单价
 * createtime	date	时间
 * @author rjh
 */
public class GasInfo {
	
	//主键
	private Long id;
	
	//车辆编号
	private Long fk_car_id;
	
	//司机编号
	private Long fk_driver_id;
	
	//油气类型
	private String type;
	
	//升数
	private Integer volume;
	
	//金额
	private Double money;
	
	//油气单价
	private Double price;
	
	//坐标
	private String coordinate;
	
	//司机id
	private String fk_handman;
	
	//操作时间
	private String createtime;
	
	//车牌号
	private String plateno;
	
	//司机姓名
	private String driver_name;
	
	//操作人
	private String user_name;

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

	public Long getFk_driver_id() {
		return fk_driver_id;
	}

	public void setFk_driver_id(Long fk_driver_id) {
		this.fk_driver_id = fk_driver_id;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Integer getVolume() {
		return volume;
	}

	public void setVolume(Integer volume) {
		this.volume = volume;
	}

	public Double getMoney() {
		return money;
	}

	public void setMoney(Double money) {
		this.money = money;
	}

	public Double getPrice() {
		return price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}

	public String getCoordinate() {
		return coordinate;
	}

	public void setCoordinate(String coordinate) {
		this.coordinate = coordinate;
	}

	public String getFk_handman() {
		return fk_handman;
	}

	public void setFk_handman(String fk_handman) {
		this.fk_handman = fk_handman;
	}

	public String getCreatetime() {
		return createtime;
	}

	public void setCreatetime(String createtime) {
		this.createtime = createtime;
	}

	public String getPlateno() {
		return plateno;
	}

	public void setPlateno(String plateno) {
		this.plateno = plateno;
	}

	public String getDriver_name() {
		return driver_name;
	}

	public void setDriver_name(String driver_name) {
		this.driver_name = driver_name;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	
}
