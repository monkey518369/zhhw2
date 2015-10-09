package cn.nfschina.zhhw.dao;

import java.util.Date;

public interface DateTimeDao {

	public Date getNextYear(Date date); 
	public Date getNextSeason(Date date);
	public Date getNextMonth(Date date);
	public Date getNextWeek(Date date);
	public Date getNextDay(Date date);
	public Date getNextHour(Date date);
	public Date getNextMinute(Date date);
	public Date getNextSecond(Date date);
	public int getSeason(Date date);
	public int getMonth(Date date);
	public int getWeek(Date date);
	public int getDayOfWeek(Date date);
}
