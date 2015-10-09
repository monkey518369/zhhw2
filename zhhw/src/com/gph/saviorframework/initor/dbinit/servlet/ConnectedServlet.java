package com.gph.saviorframework.initor.dbinit.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gph.saviorframework.initor.config.AJAXConstant;
import com.gph.saviorframework.initor.config.InitorConstants.DB_TYPE;
import com.gph.saviorframework.initor.dbinit.adapter.DBConfig;
import com.gph.saviorframework.initor.dbinit.adapter.Kingbase6Config;
import com.gph.saviorframework.initor.dbinit.adapter.MSSQL2000Config;
import com.gph.saviorframework.initor.dbinit.adapter.MySqlConfig;
import com.gph.saviorframework.initor.dbinit.adapter.OracleConfig;
import com.gph.saviorframework.initor.util.AjaxUtils;

/**
 * Servlet implementation class ConnectedServlet
 */
public class ConnectedServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ConnectedServlet() {
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
				Connection connection = null;
				try {
					connection = dbConfig.getConnection();
					connection.close();
				} 
				catch (Exception e) {
					PrintWriter out = AjaxUtils.getAjaxRespnseWriter(response);
					out.print(AJAXConstant.AJAX_FAILED_BOOLEAN);
					out.close();
				} 
				break;
				
			case MYSQL:
				dbConfig = new MySqlConfig(dbHost, dbPort, dbSchema, dbUserName, dbPassword);
				Connection connection_mysql = null;
				try {
					connection_mysql = dbConfig.getConnection();
					connection_mysql.close();
				} 
				catch (Exception e) {
					PrintWriter out = AjaxUtils.getAjaxRespnseWriter(response);
					out.print(AJAXConstant.AJAX_FAILED_BOOLEAN);
					out.close();
				} 
				break;
							
			case MSSQL2000:
				dbConfig = new MSSQL2000Config(dbHost, dbPort, dbSchema, dbUserName, dbPassword);
				Connection connection_MSSQL2000 = null;
				try {
					connection_MSSQL2000 = dbConfig.getConnection();
					connection_MSSQL2000.close();
				} 
				catch (Exception e) {
					e.printStackTrace();
					PrintWriter out = AjaxUtils.getAjaxRespnseWriter(response);
					out.print(AJAXConstant.AJAX_FAILED_BOOLEAN);
					out.close();
				} 
				break;
				
			case KINGBASE6:
				dbConfig = new Kingbase6Config(dbHost, dbPort, dbSchema, dbUserName, dbPassword);
				Connection connection_kb6 = null;
				try {
					connection_kb6 = dbConfig.getConnection();
					connection_kb6.close();
				} 
				catch (Exception e) {
					e.printStackTrace();
					PrintWriter out = AjaxUtils.getAjaxRespnseWriter(response);
					out.print(AJAXConstant.AJAX_FAILED_BOOLEAN);
					out.close();
				} 
				break;
				
			default:
				break;
		}
		PrintWriter out = AjaxUtils.getAjaxRespnseWriter(response);
		out.print(AJAXConstant.AJAX_SUCCESS_BOOLEAN);
		out.close();
	}

}
