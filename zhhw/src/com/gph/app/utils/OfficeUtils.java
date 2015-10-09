package com.gph.app.utils;

import java.io.File;
import java.net.ConnectException;

import com.artofsolving.jodconverter.DocumentConverter;
import com.artofsolving.jodconverter.openoffice.connection.OpenOfficeConnection;
import com.artofsolving.jodconverter.openoffice.connection.SocketOpenOfficeConnection;
import com.artofsolving.jodconverter.openoffice.converter.OpenOfficeDocumentConverter;

public class OfficeUtils extends Thread {

	private File inputFile;// 需要转换的文件 
	private File outputFile;// 输出的文件 

	public OfficeUtils(File inputFile, File outputFile) { 
		this.inputFile = inputFile; 
		this.outputFile = outputFile; 
	} 
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		File inputFile = new File("f://share//1.doc");
		File outputFile = new File("f://share//1.pdf");
		OfficeUtils dp=new OfficeUtils(inputFile,outputFile);
		dp.start();
	}
	
	public void run(){
		office2PDF();
	}

	public int office2PDF() {
		try {
			if (!inputFile.exists()) {
				return -1;// 找不到源文件, 则返回-1
			}

			// 如果目标路径不存在, 则新建该路径
			if (!outputFile.getParentFile().exists()) {
				outputFile.getParentFile().mkdirs();
			}

			OpenOfficeConnection connection = new SocketOpenOfficeConnection(8100);
			connection.connect();
			
			DocumentConverter converter = new OpenOfficeDocumentConverter(connection);
			converter.convert(inputFile, outputFile);
			connection.disconnect();

			return 0;
		} catch (ConnectException e) {
			e.printStackTrace();
		} 

		return 1;
	}
}
