package com.gph.saviorframework.initor.dbinit.adapter;

import java.io.File;
import java.sql.Connection;
import java.sql.DriverManager;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringUtils;

import com.gph.saviorframework.initor.config.InitorConstants.DB_TYPE;

public class MySqlConfig implements DBConfig {
	
	private String host;
	private Integer port;
	private String schema;
	private String username;
	private String userpwd;
	
	private String url;
	
	public MySqlConfig(String host,Integer port,String schema,String username,String userpwd){
		this.host = host;
		this.port = port;
		this.schema = schema;
		this.username = username;
		this.userpwd = userpwd;
		
		this.url = "jdbc:mysql://"+this.host+":"+this.port+"/"+this.schema+"?user="+this.username+"&password="+
			this.userpwd+"&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull";
	}

	@Override
	public DB_TYPE getDbType() {
		return DB_TYPE.MYSQL;
	}

	@Override
	public Connection getConnection() throws Exception {
		DriverManager.registerDriver(new com.mysql.jdbc.Driver());
		return DriverManager.getConnection(this.url,this.username,this.userpwd);
	}

	@Override
	public Connection isConnected() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updateDbConfigFile(String configFilePath) throws Exception {
		String s = FileUtils.readFileToString(new File(configFilePath));
		s = StringUtils.replace(s, "DB_URL", this.url);
		s = StringUtils.replace(s, "DB_USER", this.username);
		s = StringUtils.replace(s, "DB_PASSWORD", this.userpwd);
		s = StringUtils.replace(s, "DB_DRIVER", "com.mysql.jdbc.Driver");
		s = StringUtils.replace(s, "DB_DIALECT", "org.hibernate.dialect.MySQL5Dialect");
		
		FileUtils.writeStringToFile(new File(configFilePath), s);
	}

	@Override
	public String getDriver() {
		return "com.mysql.jdbc.Driver";
	}

	@Override
	public String getUrl() {
		return this.url;
	}

	@Override
	public String getUserName() {
		return this.username;
	}

	@Override
	public String getPassword() {
		return this.userpwd;
	}

}
