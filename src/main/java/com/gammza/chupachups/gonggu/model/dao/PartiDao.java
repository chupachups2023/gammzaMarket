package com.gammza.chupachups.gonggu.model.dao;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

import com.gammza.chupachups.gonggu.model.vo.Parti;

@Mapper
public interface PartiDao {

	int insertParti(Parti parti);

	int updateMemberPoint(HashMap<String, String> updatePoint);
	
}
