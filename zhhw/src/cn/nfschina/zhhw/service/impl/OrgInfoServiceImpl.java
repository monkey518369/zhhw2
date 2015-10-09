package cn.nfschina.zhhw.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cn.nfschina.zhhw.dao.OrgInfoDao;
import cn.nfschina.zhhw.model.Org;
import cn.nfschina.zhhw.service.OrgInfoService;

/**
 * org的相关方法
 * @author shaolinxing
 * @time 2015年9月17日 下午3:38:14
 */
@Service
public class OrgInfoServiceImpl implements OrgInfoService {

	@Resource
	private OrgInfoDao orgInfoDao;
	
	/**
	 * 根据组织id得到组织
	 * @param orgId
	 * @author shaolinxing
	 * @time 2015年9月10日 上午10:00:12 
	 * @return Org
	 */
	@Override
	public Org getOrgById(String orgId) {
		// TODO Auto-generated method stub
		Org org = orgInfoDao.getOrgById(orgId);
		return org;
	}

}
