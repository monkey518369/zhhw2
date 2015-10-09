package cn.nfschina.zhhw.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import cn.nfschina.zhhw.service.ComboboxService;
import net.sf.json.JSONArray;

@Service
public class ComboboxServiceImpl implements ComboboxService{
	
	@Override
	public String getJson(List<? extends Object> list) {
		JSONArray jsonArray = JSONArray.fromObject(list);
		String resultStr = jsonArray.toString();
		return resultStr;
	}
}
