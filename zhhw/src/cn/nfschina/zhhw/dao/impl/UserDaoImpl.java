package cn.nfschina.zhhw.dao.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.gph.saviorframework.common.model.User;

import cn.nfschina.zhhw.dao.BaseDao;
import cn.nfschina.zhhw.dao.UserDao;

@Repository
public class UserDaoImpl extends BaseDao implements UserDao{

	@Override
	public List<User> getAllUser() {
		// TODO Auto-generated method stub
		return this.getSqlMapClientTemplate().queryForList("getAllUser");
	}
	
}
