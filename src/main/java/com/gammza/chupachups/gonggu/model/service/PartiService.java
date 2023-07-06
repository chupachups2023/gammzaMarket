package com.gammza.chupachups.gonggu.model.service;

import java.util.HashMap;

import com.gammza.chupachups.gonggu.model.vo.Parti;

public interface PartiService {

	int insertParti(Parti parti);

	int updateMemberPoint(HashMap<String,String> updatePoint);
	
}
