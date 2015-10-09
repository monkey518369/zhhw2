package cn.nfschina.zhhw.util;

import java.io.UnsupportedEncodingException;

/**
 * 为了解决乱码问题，这是个转码类，把iso8859-1转换称utf8
 * 
 * @author shaolinxing
 * @time 2015年9月7日 上午11:27:48
 */
public class TransactionCode {

	public static String transaction(String str){
		
		String result = null;
		
		try {
			byte[] bytes = str.getBytes("iso8859-1");
			result = new String(bytes,"utf-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return result;
		
	}
	
}
