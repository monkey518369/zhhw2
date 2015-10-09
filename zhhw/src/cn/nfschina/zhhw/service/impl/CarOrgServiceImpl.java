package cn.nfschina.zhhw.service.impl;


import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import net.sf.json.JSONArray;

import org.springframework.stereotype.Service;

import cn.nfschina.zhhw.dao.CarOrgDao;
import cn.nfschina.zhhw.model.Org;
import cn.nfschina.zhhw.service.CarOrgService;

@Service
public class CarOrgServiceImpl implements CarOrgService{
	
	@Resource
	private CarOrgDao carOrgDao;
	@Override
	public List<Org> getAllOrg() {
		return carOrgDao.getAllOrg();
	}

//	@Override
//	public String getOrgJson(List<Org> list) {
//		List<Org> rootList = new ArrayList<Org>();;
//		//返回结果
//		String resultStr = "[{";
//		//映射父节点id和该机构的下级机构
//		Map<String, List<Org>> map = new HashMap<String, List<Org>>();
//		
//		for(Org org:list){
//			if(org.getParent_org_id()==null)
//			{
//				rootList.add(org);
//			}
//			String parentOrgId = org.getOrg_id();
//			if(map.keySet().contains(parentOrgId)){
//				map.get("parentOrgId").add(org);
//			}else{
//				List<Org> children = new ArrayList<Org>();
//				children.add(org);
//				map.put(parentOrgId, children);
//			}
//		}
//		
//		for(Org org:rootList){			
//			resultStr += "\"id\":\""+org.getOrg_name()+"\",";
//		}
//		
//		resultStr += "}]";
//		return resultStr;
//	}

	@Override
	public String getOrgJson(List<Org> list) {
		Org root = null;
		Map<String,Org> map = new HashMap<String, Org>();
		
		for(Org org:list){
			map.put(org.getOrg_id(), org);
		}
		for(Org org:list){
			String parentOrgId = org.getParent_org_id();
			if(parentOrgId==null){
				root = org;
				continue;
			}
			Org parentOrg = map.get(parentOrgId);
			Set<Org> set = parentOrg.getChildren();
			if(set==null){
				parentOrg.setChildren(new HashSet<Org>());
			}
			parentOrg.getChildren().add(org);
		}
		JSONArray jsonArray = JSONArray.fromObject(root);
		String resultStr = jsonArray.toString();
		return resultStr.replaceAll("org_name", "text").replaceAll("org_id", "id");
	}

}
