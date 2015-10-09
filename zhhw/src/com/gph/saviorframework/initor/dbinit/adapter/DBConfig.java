package com.gph.saviorframework.initor.dbinit.adapter;

import java.sql.Connection;

import com.gph.saviorframework.initor.config.InitorConstants.DB_TYPE;

public interface DBConfig {
	
	public DB_TYPE getDbType();
	
	public Connection getConnection() throws Exception;
	
	public Connection isConnected() throws Exception;
	
	public String getDriver();
	
	public String getUrl();
	
	public String getUserName();
	
	public String getPassword();
	
	public void updateDbConfigFile(String configFilePath) throws Exception;
}
