package com.gammza.chupachups.likeList.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.gammza.chupachups.likeList.model.vo.Zzim;

@Mapper
public interface LikeListDao {

	int selectTotalRecord(String userId);

	List<Zzim> selectLikeList(String userId);

	List<Zzim> selectZzim(int gongguNo);

}
