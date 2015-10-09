package cn.nfschina.zhhw.model;

/**
 * 设备表t_device
 * Id	bigInt		
 * Dev_name	Varchar	设备名称	
 * Version	Varchar	设备型号	
 * manufacturer	Varchar	生产厂商	
 * @author rjh
 *
 */
public class DeviceInfo {
	
	//终端设备编号
	private Long id;
	
	//终端设备名称
	private String dev_name;
	
	//终端设备型号
	private String version;
	
	//终端设备生产厂家
	private String manufacturer;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getDev_name() {
		return dev_name;
	}

	public void setDev_name(String dev_name) {
		this.dev_name = dev_name;
	}

	public String getVersion() {
		return version;
	}

	public void setVersion(String version) {
		this.version = version;
	}

	public String getManufacturer() {
		return manufacturer;
	}

	public void setManufacturer(String manufacturer) {
		this.manufacturer = manufacturer;
	}

}
