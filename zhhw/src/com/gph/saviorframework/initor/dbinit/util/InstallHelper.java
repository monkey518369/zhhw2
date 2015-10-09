package com.gph.saviorframework.initor.dbinit.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringUtils;

import com.gph.saviorframework.initor.dbinit.adapter.DBConfig;

public class InstallHelper {
	
	public static void reWriteWebXml(String from, String to) throws IOException{
		FileUtils.copyFile(new File(from), new File(to));
	}
	
	/**
	 * 读取SQL语句。“/*”“-”“#”“REM”开头为注释，“;”为SQL结束。
	 * 
	 * @param fileName SQL文件地址
	 * @return List of SQL statements
	 * @throws Exception
	 */
	public static List<String> readSql(String fileName) 
			throws Exception {
		BufferedReader br = new BufferedReader(new InputStreamReader(
				new FileInputStream(fileName), "UTF-8"));
		List<String> sqlList = new ArrayList<String>();
		StringBuilder sqlSb = new StringBuilder();
		String s = null;
		while ((s = br.readLine()) != null) {
			if (s.startsWith("/*") || s.startsWith("#") || s.startsWith("REM") || s.startsWith("-")
					|| StringUtils.isBlank(s)) {
				continue;
			}
			if (s.endsWith(";")) {
				sqlSb.append(s);
				sqlSb.setLength(sqlSb.length() - 1);
				sqlList.add(sqlSb.toString());
				sqlSb.setLength(0);
			} else {
				sqlSb.append(s);
			}
		}
		br.close();
		return sqlList;
	}
	
	public static List<String> getDbTypeSqlPaths(String fileEnds,String dbInitSQLFolderPath,DBConfig dbConfig){
		if(StringUtils.isEmpty(dbInitSQLFolderPath)){
			throw new NullPointerException("路径不能为空");
		}
		if(StringUtils.isEmpty(fileEnds)){
			throw new NullPointerException("入参不能为空");
		}
		
		List<String> sqlFilePathList = new ArrayList<String>();
		
		File dir = new File(dbInitSQLFolderPath+"/"+dbConfig.getDbType().toString().toLowerCase()+"/");
		
		File[] files = dir.listFiles();
		
		if(files == null){
			throw new NullPointerException("指定路径下无文件");
		}
		
		for (File file : files) {
			if(file.getName().endsWith(fileEnds)){
				sqlFilePathList.add(file.getAbsolutePath());
			}
		}
		
		return sqlFilePathList;
	}
}
