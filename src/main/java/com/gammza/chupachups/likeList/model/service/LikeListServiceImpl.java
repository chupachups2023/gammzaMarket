package com.gammza.chupachups.likeList.model.service;

import java.util.List;

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
	public List<Zzim> selectLikeList(String userId) {
		return likeListDao.selectLikeList(userId);
	}

	@Override
	public List<Zzim> selectZzim(int gongguNo) {
		return likeListDao.selectZzim(gongguNo);
	}
}
