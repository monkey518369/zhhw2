package com.gph.saviorframework.initor.register.listener;

import java.util.Properties;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import chenmin.io.DiskID;

import com.gph.saviorframework.util.PropertiesUtils;
import com.gph.saviorframework.util.SecUtils;

public class RegisterListener implements ServletContextListener {

	@Override
	public void contextDestroyed(ServletContextEvent arg0) {
		
	}

	@Override
	public void contextInitialized(ServletContextEvent arg0) {
		System.out.println("开始验证注册码.....");
		PropertiesUtils pu = new PropertiesUtils();
		Properties globalConfig = pu.loadProperty("com/gph/saviorframework/initor/config/initor.properties");
		String registerConfigPath = globalConfig.getProperty("register.properties.path");
		
		Properties registerConfig = pu.loadProperty(registerConfigPath);
		
		String sourceCode = registerConfig.getProperty("source");
		String regCode = registerConfig.getProperty("reg");
		
		//获取硬盘序列号
		String diskID = DiskID.DiskID();
		Boolean flag = false;
		if(SecUtils.getBase64(diskID.getBytes()).equals(regCode) && diskID.equals(sourceCode)){
			flag = true;
		}
		
		if(!flag){
			System.err.println("系统注册码错误，请联系客服人员");
			System.exit(0);
		}
		else{
			System.out.println("注册码验证通过");
		}
	}
}
