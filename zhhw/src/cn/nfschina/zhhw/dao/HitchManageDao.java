package cn.nfschina.zhhw.dao;

import java.util.List;

import cn.nfschina.zhhw.model.HitchInfo;

public interface HitchManageDao {

	List<HitchInfo> getAllHitch(HitchInfo hitchInfo);

	void addHitch(HitchInfo hitchInfo);

	void updHitch(HitchInfo hitchInfo);

	void delHitch(HitchInfo hitchInfo);

	String getPlateNo(HitchInfo hitchInfo);

}
