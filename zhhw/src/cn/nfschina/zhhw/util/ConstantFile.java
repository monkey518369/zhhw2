
package cn.nfschina.zhhw.util;

/**
 * 定义与网管通信使用的命令编码设置。
 * copyright nfschina
 * ConstantFile.java
 * create on 2015年9月1日
 * @author wxy
 */
public class ConstantFile {
	/*
	 * 以下三行是信息下发的编码
	 */

	/**
	 * 用于与网关程序通信的围栏设置编码。
	 * create on  2015年9月1日
	 * @author wxy
	 */
	public static final String FENCE_SET_CODE = "32";
	/**
	 * 用于与网购程序通信的线路设置编码。
	 * create on  2015年9月1日
	 * @author wxy
	 */
	public static final String LINE_SET_CODE = "34";
	/**
	 * 用于与网购程序通信的参数设置编码。
	 * create on  2015年9月1日
	 * @author wxy
	 */
	public static final String PARAMETRER_SET_CODE = "08";

	/**
	 * 用于与网购程序通信的参数设置编码——紧急报警时会汇报时间间隔。
	 * create on  2015年9月1日
	 * @author wxy
	 */
	public static final String CODE_ALERT_TIME = "0x0022";
	
	/**
	 * 用于与网购程序通信的参数设置编码——最大速度。
	 * create on  2015年9月1日
	 * @author wxy
	 */
	public static final String CODE_MAX_SPEED = "0x0055";
	/**
	 * 用于与网购程序通信的参数设置编码——醉倒速度持续时间。
	 * create on  2015年9月1日
	 * @author wxy
	 */
	public static final String CODE_MAX_SPEED_TIME = "0x0056";
	/**
	 * 用于与网购程序通信的参数设置编码——连续作业时间。
	 * create on  2015年9月1日
	 * @author wxy
	 */
	public static final String CODE_WORK_TIME = "0x0057";


}
