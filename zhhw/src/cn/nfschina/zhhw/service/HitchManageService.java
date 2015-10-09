package cn.nfschina.zhhw.service;

import java.util.List;

import cn.nfschina.zhhw.model.HitchInfo;

public interface HitchManageService {

	List<HitchInfo> getAllHitch(HitchInfo hitchInfo);

	void addHitch(HitchInfo hitchInfo);

	void updHitch(HitchInfo hitchInfo);

	void delHitch(HitchInfo hitchInfo);

	String getPlateNo(HitchInfo hitchInfo);

}
