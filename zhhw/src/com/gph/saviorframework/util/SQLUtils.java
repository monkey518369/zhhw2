package com.gph.saviorframework.util;

import java.io.File;

import org.apache.tools.ant.Project;
import org.apache.tools.ant.taskdefs.SQLExec;
import org.apache.tools.ant.types.EnumeratedAttribute;

public class SQLUtils {
	
	/**
	 * 根据数据库连接执行sql文件
	 * @param connection
	 */
	public static void executeSqlFile(
			String driver, 
			String url,
			String username,
			String password,
			String filename){
		
		SQLExec sqlExec = new SQLExec();
		sqlExec.setDriver(driver);
		sqlExec.setUrl(url);
		sqlExec.setUserid(username);
		sqlExec.setPassword(password);
		sqlExec.setEncoding("utf-8");
		sqlExec.setOnerror((SQLExec.OnError)EnumeratedAttribute.getInstance(SQLExec.OnError.class, "continue"));
		
		sqlExec.setSrc(new File(filename));
		sqlExec.setProject(new Project());
		sqlExec.execute();
	}
	
	public static void executeSqlFile(
			SQLExec sqlExec,
			String driver, 
			String url,
			String username,
			String password,
			String filename){
		
		sqlExec.setDriver(driver);
		sqlExec.setUrl(url);
		sqlExec.setUserid(username);
		sqlExec.setPassword(password);
		sqlExec.setEncoding("utf-8");
		sqlExec.setOnerror((SQLExec.OnError)EnumeratedAttribute.getInstance(SQLExec.OnError.class, "continue"));
		
		sqlExec.setSrc(new File(filename));
		sqlExec.setProject(new Project());
		sqlExec.execute();
	}
}
