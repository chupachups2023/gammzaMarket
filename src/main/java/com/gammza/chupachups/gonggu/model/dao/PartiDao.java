package com.gammza.chupachups.gonggu.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

import com.gammza.chupachups.gonggu.model.vo.Gonggu;
import com.gammza.chupachups.gonggu.model.vo.Parti;

@Mapper
public interface PartiDao {

	int insertParti(Parti parti);

	int updateMemberPointMinus(HashMap<String, String> updatePoint);
	
	int updateMemberPointPlus(HashMap<String, String> updatePoint);

	ArrayList<Gonggu> selectAllPartiList(HashMap<String, String> listMap);

	Parti selectOneParti(HashMap<String, String> selectParti);

	int updatePartiStatusSelf(HashMap<String, String> map);

	ArrayList<Parti> selectPartiListForLeader(HashMap<String, String> map);

	int updatePartiStatusByLeader(HashMap<String, String> map);
	
}
