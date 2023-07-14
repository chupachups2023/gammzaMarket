package com.gammza.chupachups.likeList.model.service;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gammza.chupachups.likeList.model.dao.LikeListDao;
import com.gammza.chupachups.likeList.model.vo.Zzim;

@Service
public class LikeListServiceImpl implements LikeListService {

	@Autowired
	private LikeListDao likeListDao;

	@Override
	public int selectTotalRecord(String userId) {
		return likeListDao.selectTotalRecord(userId);
	}

	@Override
	public List<Zzim> selectLikeList(String userId, RowBounds rowBounds) {
		return likeListDao.selectLikeList(userId, rowBounds);
	}

	@Override
	public int deleteZzim(String zzimNo) {
		return likeListDao.deleteZzim(zzimNo);
	}

	@Override
	public List<Zzim> selectZzim(int gongguNo) {
		return likeListDao.selectZzim(gongguNo);
	}

	@Override
	public Zzim selectMyZzim(HashMap<String, String> map) {
		return likeListDao.selectMyZzim(map);
	}

	@Override
	public int insertLikeList(HashMap<String, String> map) {
		return likeListDao.insertLikeList(map);
	}

	@Override
	public int selectZzimNo() {
		return likeListDao.selectZzimNo();
	}
}
