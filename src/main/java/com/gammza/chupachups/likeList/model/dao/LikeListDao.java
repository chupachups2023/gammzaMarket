package com.gammza.chupachups.likeList.model.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import com.gammza.chupachups.likeList.model.vo.Zzim;

@Mapper
public interface LikeListDao {

	int selectTotalRecord(String userId);
 
	List<Zzim> selectLikeList(String userId, RowBounds rowBounds);

	int deleteZzim(String zzimNo);

	List<Zzim> selectZzim(int gongguNo);

	Zzim selectMyZzim(HashMap<String, String> map);

	int insertLikeList(HashMap<String, String> map);

	int selectZzimNo();

}
