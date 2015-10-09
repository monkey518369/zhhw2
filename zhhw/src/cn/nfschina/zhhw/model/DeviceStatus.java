package cn.nfschina.zhhw.model;

public class DeviceStatus {

	private Long id;
	//设备ID外键
	private Long dev_id;
	//GPS模块传感器状态
	private String gpsstatus;
	//油箱传感器状态
	private String gasstatus;
	//垃圾重量检测传感器状态
	private String garbagestatus;
	//时速表传感器状态
	private String speedstatus;
	//摄像头管理器状态
	private String camerastatus;
	
//	public DeviceStatus(Long id, Long dev_id, String gpsstatus, String gasstatus,
//			String garbagestatus, String speedstatus, String camerastatus) {
//		super();
//		this.id = id;
//		this.dev_id = dev_id;
//		this.gpsstatus = gpsstatus;
//		this.gasstatus = gasstatus;
//		this.garbagestatus = garbagestatus;
//		this.speedstatus = speedstatus;
//		this.camerastatus = camerastatus;
//	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getDev_id() {
		return dev_id;
	}

	public void setDev_id(Long dev_id) {
		this.dev_id = dev_id;
	}

	public String getGpsstatus() {
		return gpsstatus;
	}

	public void setGpsstatus(String gpsstatus) {
		this.gpsstatus = gpsstatus;
	}

	public String getGasstatus() {
		return gasstatus;
	}

	public void setGasstatus(String gasstatus) {
		this.gasstatus = gasstatus;
	}

	public String getGarbagestatus() {
		return garbagestatus;
	}

	public void setGarbagestatus(String garbagestatus) {
		this.garbagestatus = garbagestatus;
	}

	public String getSpeedstatus() {
		return speedstatus;
	}

	public void setSpeedstatus(String speedstatus) {
		this.speedstatus = speedstatus;
	}

	public String getCamerastatus() {
		return camerastatus;
	}

	public void setCamerastatus(String camerastatus) {
		this.camerastatus = camerastatus;
	}

}
