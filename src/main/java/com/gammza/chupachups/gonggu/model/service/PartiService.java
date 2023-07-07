package com.gammza.chupachups.gonggu.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.gammza.chupachups.gonggu.model.vo.Gonggu;
import com.gammza.chupachups.gonggu.model.vo.Parti;

public interface PartiService {

	int insertParti(Parti parti);

	int updateMemberPointMinus(HashMap<String,String> updatePoint);
	
	int updateMemberPointPlus(HashMap<String, String> updatePoint);

	ArrayList<Gonggu> selectAllPartiList(String userId);
	
	Parti selectOneParti(HashMap<String, String> selectParti);

	int updatePartiStatusSelf(HashMap<String, String> map);

	ArrayList<Parti> selectPartiListForLeader(int gongguNo);

	int updatePartiStatusByLeader(HashMap<String, String> map);
	
}
