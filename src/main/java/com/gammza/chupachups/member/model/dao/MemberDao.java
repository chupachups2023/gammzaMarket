package com.gammza.chupachups.member.model.dao;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

import com.gammza.chupachups.member.model.vo.Member;

@Mapper
public interface MemberDao {
	
	int insertMember(Member member);
	
	Member selectOneMember(String userId);
	
	int updateMember(Member member);

	Member checkIdFunc(String userId);

	int insertKakaoMember(Member member);

	Member selectMemberByKakao(Long id);

	Member selectMemberByNaver(String id);

	/* Member selectMemberByPhone(String phone); */

	String insertNaverIdkey(String naverIdkey);

	int updateKakaoIdkey(HashMap<String, String> map);

	int updateNaverIdkey(HashMap<String, String> map);

	String findIdClick(String phone);

	int insertNaverMember(Member member);

	String findPwdClick(String userId, String phone);

	int changeStatus(String userId);

	int selectProceedingGonggu(String userId);

}
