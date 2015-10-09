package com.gph.saviorframework.initor.dbinit.adapter;

import java.io.File;
import java.sql.Connection;
import java.sql.DriverManager;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringUtils;

import com.gph.saviorframework.initor.config.InitorConstants.DB_TYPE;

/**
 * oracle数据库的配置文件
 * @author guopeihui
 *
 */
public class OracleConfig implements DBConfig {
	
	private String host;
	private Integer port;
	private String schema;
	private String username;
	private String userpwd;
	
	private String url;
	
	public OracleConfig(String host,Integer port,String schema,String username,String userpwd){
		this.host = host;
		this.port = port;
		this.schema = schema;
		this.username = username;
		this.userpwd = userpwd;
		
		this.url = "jdbc:oracle:thin:@"+this.host+":"+this.port+":"+this.schema;
	}

	@Override
	public DB_TYPE getDbType() {
		return DB_TYPE.ORACLE;
	}

	@Override
	public Connection getConnection() throws Exception {
		DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
		return DriverManager.getConnection(this.url,this.username,this.userpwd);
	}

	@Override
	public Connection isConnected() throws Exception {
		return null;
	}

	@Override
	public void updateDbConfigFile(String configFilePath) throws Exception {
		String s = FileUtils.readFileToString(new File(configFilePath));
		s = StringUtils.replace(s, "DB_URL", this.url);
		s = StringUtils.replace(s, "DB_USER", this.username);
		s = StringUtils.replace(s, "DB_PASSWORD", this.userpwd);
		s = StringUtils.replace(s, "DB_DRIVER", "oracle.jdbc.driver.OracleDriver");
		s = StringUtils.replace(s, "DB_DIALECT", "org.hibernate.dialect.Oracle10gDialect");
		
		FileUtils.writeStringToFile(new File(configFilePath), s);
	}

	@Override
	public String getDriver() {
		return "oracle.jdbc.driver.OracleDriver";
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
