package com.gammza.chupachups.gonggu.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

import com.gammza.chupachups.gonggu.model.vo.Gonggu;
import com.gammza.chupachups.gonggu.model.vo.Parti;

@Mapper
public interface PartiDao {

	int insertParti(Parti parti);

	int updateMemberPoint(HashMap<String, String> updatePoint);

	ArrayList<Gonggu> selectAllPartiList(String userId);

	Parti selectOneParti(HashMap<String, String> selectParti);

	int updatePartiStatusSelf(HashMap<String, String> map);

	int updateLeaderPoint(Gonggu gonggu);

	ArrayList<Parti> selectPartiListForLeader(int gongguNo);

	int updatePartiStatusByLeader(HashMap<String, String> map);
	
}
