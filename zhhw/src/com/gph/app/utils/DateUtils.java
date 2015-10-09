package com.gph.app.utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtils {

	/**
	 * 根据传入的时间获取当天的开始时间
	 * @param date
	 * @return
	 * @throws ParseException
	 */
	public static Date getStart(Date date) throws ParseException{
		SimpleDateFormat formater = new SimpleDateFormat("yyyy/MM/dd");
		SimpleDateFormat formater2 = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		return formater2.parse(formater.format(date)+ " 00:00:00");
	}
	
	/**
	 * 根据传入的时间获取当天的结束时间
	 * @param date
	 * @return
	 * @throws ParseException
	 */
	public static Date getEnd(Date date) throws ParseException{
		SimpleDateFormat formater = new SimpleDateFormat("yyyy/MM/dd");
		SimpleDateFormat formater2 = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		return formater2.parse(formater.format(new Date())+ " 23:59:59");
	}
}
