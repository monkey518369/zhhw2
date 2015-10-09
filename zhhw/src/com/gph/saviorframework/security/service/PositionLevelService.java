package com.gph.saviorframework.security.service;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.gph.saviorframework.common.model.Function;
import com.gph.saviorframework.common.model.PositionLevel;

/**
 * 
 */
@Repository
public class PositionLevelService {

	/** 日志输出 */
	final Logger logger = LoggerFactory.getLogger(PositionLevelService.class);

	/**
	 * HIBERNATE Session Factory.
	 */
	@Autowired
	private SessionFactory sessionFactory;

	public Session getSession() {
		return sessionFactory.getCurrentSession();
	}

	/**
	 * 查询所有数据.
	 * 
	 * @return
	 */
	@Transactional(readOnly = true)
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> findMap() {
		return getSession().createQuery("select new map(pl.id as id,pl.name as name) from PositionLevel pl").list();
	}
	
	/**
	 * 查询所有数据.
	 * 
	 * @return
	 */
	@Transactional(readOnly = true)
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> findMap2() {
		return getSession().createQuery("select new map(pl.id as id,pl.name as text) from PositionLevel pl").list();
	}

	@Transactional(readOnly = true)
	@SuppressWarnings("unchecked")
	public List<Function> findByPosition(String position) {
		return getSession()
				.createQuery(
						"select new map(pl.id as id,pl.name as name,"
								+ "(case when (select count(*) from Position position inner join position.levels level "
								+ "where position.id=? and level.id = pl.id)>0 then true else false end ) as checked ) from PositionLevel pl")
				.setString(0, position).list();
	}
	
	@Transactional(readOnly = true)
	@SuppressWarnings("unchecked")
	public List<Function> findByPosition2(String position) {
		return getSession()
				.createQuery(
						"select new map(pl.id as id,pl.name as text,"
								+ "(case when (select count(*) from Position position inner join position.levels level "
								+ "where position.id=? and level.id = pl.id)>0 then true else false end ) as checked ) from PositionLevel pl")
				.setString(0, position).list();
	}

	/**
	 * 根据主键查询.
	 * 
	 * @param id 主键
	 * @return
	 */
	@Transactional(readOnly = true)
	public Object get(Serializable id) {
		return getSession().get(PositionLevel.class, id);
	}

}
