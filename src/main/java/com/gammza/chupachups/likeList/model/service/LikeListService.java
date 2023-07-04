package com.gammza.chupachups.likeList.model.service;

import java.util.List;

import org.apache.ibatis.session.RowBounds;

import com.gammza.chupachups.likeList.model.vo.Zzim;

public interface LikeListService {

	int selectTotalRecord(String userId);

	List<Zzim> selectLikeList(String userId, RowBounds rowBounds);

	int deleteZzim(String zzimNo);

}
