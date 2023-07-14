package com.gammza.chupachups.member.model.service;

import java.util.HashMap;

import com.gammza.chupachups.member.model.vo.Member;

public interface MemberService {
	
	int insertMember(Member member);
	
	Member selectOneMember(String userId);
	
	int updateMember(Member member);

	Member checkIdFunc(String userId);

	int insertKakaoMember(Member member);

	Member selectMemberByKakao(Long id);

	/* Member selectMemberByPhone(String phone); */

	Member selectMemberByNaver(String id);

	String insertNaverIdkey(String setNaverIdkey);

	int updateKakaoIdkey(HashMap<String, String> map);

	int updateNaverIdkey(HashMap<String, String> map);

	String findIdClick(String phone);

	int insertNaverMember(Member member);

	String findPwdClick(String userId, String phone);

	int updatePwd(Member member);

	Member selectOneMemberByEmail(String email);

	

}
