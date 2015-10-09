package cn.nfschina.zhhw.dao.impl;

import java.sql.SQLException;
import java.util.Date;

import org.springframework.stereotype.Repository;

import cn.nfschina.zhhw.dao.BaseDao;
import cn.nfschina.zhhw.dao.DateTimeDao;

@Repository
public class DateTimeDaoImpl extends BaseDao implements DateTimeDao{

	@Override
	public Date getNextYear(Date date) {
		// TODO Auto-generated method stub
		
		Date nextYear = (Date)this.getSqlMapClientTemplate().queryForObject("getnextyear", date);
		
		return nextYear;
	}

	@Override
	public Date getNextSeason(Date date) {
		// TODO Auto-generated method stub
		
		Date nextSeason = (Date)this.getSqlMapClientTemplate().queryForObject("getnextseason", date);
		
		return nextSeason;
	}

	@Override
	public Date getNextMonth(Date date) {
		// TODO Auto-generated method stub
		
		Date nextMonth = (Date)this.getSqlMapClientTemplate().queryForObject("getnextmonth", date);
		
		return nextMonth;
	}

	@Override
	public Date getNextWeek(Date date) {
		// TODO Auto-generated method stub
		
		Date nextWeek = (Date)this.getSqlMapClientTemplate().queryForObject("getnextweek", date);
		
		return nextWeek;
	}

	@Override
	public Date getNextDay(Date date) {
		// TODO Auto-generated method stub
		
		Date nextDay = (Date)this.getSqlMapClientTemplate().queryForObject("getnextday", date);
		
		return nextDay;
	}

	@Override
	public Date getNextHour(Date date) {
		// TODO Auto-generated method stub
		
		Date nextHour = (Date)this.getSqlMapClientTemplate().queryForObject("getnexthour", date);
		
		return nextHour;
	}

	@Override
	public Date getNextMinute(Date date) {
		// TODO Auto-generated method stub
		
		Date nextMinute = (Date)this.getSqlMapClientTemplate().queryForObject("getnextminute", date);
		
		return nextMinute;
	}

	@Override
	public Date getNextSecond(Date date) {
		// TODO Auto-generated method stub
		
		Date nextSecond = (Date)this.getSqlMapClientTemplate().queryForObject("getnextsecond", date);
		
		return nextSecond;
	}

	@Override
	public int getSeason(Date date) {
		// TODO Auto-generated method stub
		
		int season = (int)this.getSqlMapClientTemplate().queryForObject("getseason",date);
		
		return season;
	}

	@Override
	public int getMonth(Date date) {
		// TODO Auto-generated method stub
		
		int month = (int)this.getSqlMapClientTemplate().queryForObject("getmonth",date);
		
		return month;
	}

	@Override
	public int getWeek(Date date) {
		// TODO Auto-generated method stub
		
		int week = (int)this.getSqlMapClientTemplate().queryForObject("getweek",date);
		
		return week;
	}

	@Override
	public int getDayOfWeek(Date date) {
		// TODO Auto-generated method stub
		
		int index = (int)this.getSqlMapClientTemplate().queryForObject("getdayofweek",date);
		
		return index;
	}
	
	

}
