package cn.nfschina.zhhw.service;

import java.util.List;
import java.util.Map;

import cn.nfschina.zhhw.model.Org;

/**
 * @Description: 机构组织的业务层接口
 * @copyright: nfschina
 * @ClassName: CarOrgService
 * @author wcy
 * @date 2015年9月10日 上午9:12:05
 */
public interface CarOrgService {
	
	/*
	 * @Description: 获取所有组织机构
	 * @Title: getAllOrg
	 * @return List<Org>：所有的组织信息
	 * @throws
	 */
	public abstract List<Org> getAllOrg();
	
	/*
	 * @Description: 获取车辆信息json字符串
	 * @Title: getOrgJson
	 * @param @param list:组织的list集合
	 * @return String：生成用于构建easyui机构组织树的json字符串
	 * @throws
	 */
	public abstract String getOrgJson(List<Org> list);
}
