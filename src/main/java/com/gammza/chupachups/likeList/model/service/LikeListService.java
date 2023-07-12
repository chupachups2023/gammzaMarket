package com.gammza.chupachups.likeList.model.service;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;

import com.gammza.chupachups.likeList.model.vo.Zzim;

public interface LikeListService {

	int selectTotalRecord(String userId);
 
	List<Zzim> selectLikeList(String userId, RowBounds rowBounds);

	int deleteZzim(String zzimNo);

	List<Zzim> selectZzim(int gongguNo); //공구글마다 찜 수 몇인지

	Zzim selectMyZzim(HashMap<String, String> map);

	int insertLikeList(HashMap<String, String> map);

	int selectZzimNo();
	
}
