package cn.nfschina.zhhw.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cn.nfschina.zhhw.dao.HitchManageDao;
import cn.nfschina.zhhw.model.HitchInfo;
import cn.nfschina.zhhw.service.HitchManageService;

@Service
public class HitchManageServiceImpl implements HitchManageService{
	
	@Resource
	private HitchManageDao hitchManageDao;
	@Override
	public List<HitchInfo> getAllHitch(HitchInfo hitchInfo) {
		// TODO Auto-generated method stub
		return hitchManageDao.getAllHitch(hitchInfo);
	}

	@Override
	public void addHitch(HitchInfo hitchInfo) {
		// TODO Auto-generated method stub
		hitchManageDao.addHitch(hitchInfo);
	}

	@Override
	public void updHitch(HitchInfo hitchInfo) {
		// TODO Auto-generated method stub
		hitchManageDao.updHitch(hitchInfo);
	}

	@Override
	public void delHitch(HitchInfo hitchInfo) {
		// TODO Auto-generated method stub
		hitchManageDao.delHitch(hitchInfo);
	}

	@Override
	public String getPlateNo(HitchInfo hitchInfo) {
		// TODO Auto-generated method stub
		return hitchManageDao.getPlateNo(hitchInfo);
	}

}
