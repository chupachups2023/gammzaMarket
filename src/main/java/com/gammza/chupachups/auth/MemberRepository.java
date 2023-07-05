package com.gammza.chupachups.auth;

import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MemberRepository {
	
	@Autowired
	private SqlSessionTemplate sql;
	
	public void kakaoinsert(HashMap<String, Object> kakaoUserInfo) {
		sql.insert("Member.kakaoInsert", kakaoUserInfo);
	}
	
	public KakaoProfile findkakao(HashMap<String, Object> kakaoUserInfo) {
		System.out.println("RN" + kakaoUserInfo.get("id"));
		System.out.println("RE" + kakaoUserInfo.get("nickname"));
		return sql.selectOne("Member.findkakao", kakaoUserInfo);
	}
	
	
	
	
	

}
