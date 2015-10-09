package com.gph.saviorframework.initor.dbinit.servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Properties;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gph.saviorframework.initor.config.InitorConstants.DB_TYPE;
import com.gph.saviorframework.initor.dbinit.adapter.DBConfig;
import com.gph.saviorframework.initor.dbinit.adapter.Kingbase6Config;
import com.gph.saviorframework.initor.dbinit.adapter.MSSQL2000Config;
import com.gph.saviorframework.initor.dbinit.adapter.MySqlConfig;
import com.gph.saviorframework.initor.dbinit.adapter.OracleConfig;
import com.gph.saviorframework.initor.dbinit.util.InstallHelper;
import com.gph.saviorframework.initor.util.AjaxUtils;
import com.gph.saviorframework.util.PropertiesUtils;
import com.gph.saviorframework.util.SQLUtils;

/**
 * Servlet implementation class InstallServlet
 */
public class InstallServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public InstallServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		DB_TYPE dbType = DB_TYPE.valueOf(request.getParameter("dbType").toString());
		
		String dbHost = request.getParameter("dbHost").toString();
		Integer dbPort = Integer.valueOf(request.getParameter("dbPort"));
		String dbSchema = request.getParameter("dbSchema").toString();
		String dbUserName = request.getParameter("dbUser").toString();
		String dbPassword = request.getParameter("dbPassword").toString();
		
		DBConfig dbConfig = null;
		switch (dbType) {
			case ORACLE:
				dbConfig = new OracleConfig(dbHost, dbPort, dbSchema, dbUserName, dbPassword);
				break;
			case MYSQL:
				dbConfig = new MySqlConfig(dbHost, dbPort, dbSchema, dbUserName, dbPassword);
				break;
			case MSSQL2000:
				dbConfig = new MSSQL2000Config(dbHost, dbPort, dbSchema, dbUserName, dbPassword);
				break;
			case KINGBASE6:
				dbConfig = new Kingbase6Config(dbHost, dbPort, dbSchema, dbUserName, dbPassword);
				break;
			default:
				break;
		}
		
		PropertiesUtils pu = new PropertiesUtils();
		Properties properties = pu.loadProperty("com/gph/saviorframework/initor/config/initor.properties");
		
		String runtimeWebXmlPath = this.getClass().getResource("/").getFile()+properties.getProperty("webxml.runtime.path");
		String dbInitSqlFolderPath = this.getClass().getResource("/").getFile()+properties.getProperty("dbinit.sql.folder");
		
		List<String> filePaths = InstallHelper.getDbTypeSqlPaths(".sql", dbInitSqlFolderPath, dbConfig);
		
		for (int i = 0; i < filePaths.size(); i++) {
			for (String path : filePaths) {
				File file = new File(path);
				if(file.getName().startsWith(String.valueOf(i))){
					/*List<String> ddlSqlList = null;
					try {
						ddlSqlList = InstallHelper.readSql(path);
					} catch (Exception e) {
						e.printStackTrace();
						PrintWriter out = AjaxUtils.getAjaxRespnseWriter(response);
						out.print("{'success':false,'error':'"+e.getMessage()+"'}");
						out.close();
					}
					Connection connection = null;
					String ss = null;
					try {
						connection = dbConfig.getConnection();
						Statement statement = connection.createStatement();
						for (String ddlSql : ddlSqlList) {
							ss = ddlSql;
							statement.execute(ddlSql);
						}
					} catch (Exception e) {
						System.err.println(ss+":"+e.getMessage());
						PrintWriter out = AjaxUtils.getAjaxRespnseWriter(response);
						out.print("{'success':false,'error':'"+e.getMessage()+"'}");
						out.close();
					}*/
					
					try {
						SQLUtils.executeSqlFile(
								dbConfig.getDriver(), 
								dbConfig.getUrl(), 
								dbConfig.getUserName(), 
								dbConfig.getPassword(), 
								file.getAbsolutePath());
					} catch (Exception e) {
						e.printStackTrace();
						PrintWriter out = AjaxUtils.getAjaxRespnseWriter(response);
						out.print("{'success':false,'error':'"+e.getMessage()+"'}");
						out.close();
					}
				}
			}
		}
		
		//更新配置文件
		try {
			dbConfig.updateDbConfigFile(this.getClass().getResource("/").getFile()+"application.properties");
		} catch (Exception e) {
			PrintWriter out = AjaxUtils.getAjaxRespnseWriter(response);
			out.print("{'success':false,'error':'"+e.getMessage()+"'}");
			out.close();
		}
		
		InstallHelper.reWriteWebXml(runtimeWebXmlPath, getServletContext().getRealPath("/WEB-INF/web.xml"));
		PrintWriter out = AjaxUtils.getAjaxRespnseWriter(response);
		out.print("{'success':true}");
		out.close();
	}

}
