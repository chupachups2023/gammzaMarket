package com.gammza.chupachups.likeList.model.service;

import java.util.List;

import com.gammza.chupachups.likeList.model.vo.Zzim;

public interface LikeListService {

	int selectTotalRecord(String userId);

	List<Zzim> selectLikeList(String userId);

	List<Zzim> selectZzim(int gongguNo); //공구글마다 찜 수 몇인지
	
}
