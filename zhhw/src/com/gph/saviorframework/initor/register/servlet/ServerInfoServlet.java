package com.gph.saviorframework.initor.register.servlet;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringUtils;

import chenmin.io.DiskID;

/**
 * Servlet implementation class MacServlet
 */
public class ServerInfoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServerInfoServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			
			//为了获取硬盘序列号，先将dll拷到java的library路径中
			String libPath = System.getProperty("java.library.path");
			
			String realPath_DLL = getServletContext().getRealPath("dll/DiskID.dll");
			String realPath_DLL_1 = getServletContext().getRealPath("dll/DiskID32.dll");
			
			File file1 = new File(libPath.split(";")[0]+"\\DiskID.dll");
			if(!file1.exists()){
			}
			
			FileUtils.copyFile(new File(realPath_DLL), new File(libPath.split(";")[0]+"\\DiskID.dll"));
			FileUtils.copyFile(new File(realPath_DLL_1), new File(libPath.split(";")[0]+"\\DiskID32.dll"));
			
			String res = StringUtils.EMPTY;
			
			//屏蔽掉的地方是原先获取mac地址的方法
			
			/*List<String> macs = MacUtils.getMac();
			
			for (int i = 0; i < macs.size(); i++) {
				if(macs.size()==1){ 
					res = SecUtils.getMD5(macs.get(0).getBytes());
				}
				else {
					if(i==macs.size()-1){
						res+= SecUtils.getMD5(macs.get(i).getBytes());
					}
					else {
						res+= SecUtils.getMD5(macs.get(i).getBytes())+"-";
					}
				}
			}*/
			
			res = DiskID.DiskID();
			
			response.getWriter().print("{'success':true,'code':'"+res+"'}");
		}
		catch (Exception e) {
			response.getWriter().print("{'success':false,'error':'"+e.getMessage()+"'}");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
