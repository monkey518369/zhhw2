package cn.nfschina.zhhw.service;

import java.util.List;

import cn.nfschina.zhhw.model.DeviceInfo;
import cn.nfschina.zhhw.model.DeviceStatus;
import cn.nfschina.zhhw.model.SecurityCheck;

public interface DeviceManageService {

	List<DeviceInfo> getAllDevice(DeviceInfo deviceInfo);

	void addDevice(DeviceInfo deviceInfo);

	void updDevice(DeviceInfo deviceInfo);

	void delDevice(DeviceInfo deviceInfo);

	List<DeviceStatus> checkDeviceStatus(DeviceStatus deviceStatus);
	
	List<SecurityCheck> deviceSecurityCheck(SecurityCheck securityCheck);
}
