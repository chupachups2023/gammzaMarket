package com.gammza.chupachups.member.model.service;

import com.gammza.chupachups.member.model.vo.Member;

public interface MemberService {
	
	int insertMember(Member member);
	
	Member selectOneMember(String userId);
	
	int updateMember(Member member);

	Member checkIdFunc(String userId);

	int insertKakaoMember(Member member);

	Member selectMemberByKakao(Long id);

	Member selectMemberByPhone(String phone);

	Member selectMemberByNaver(String id);

	String insertNaverIdkey(String setNaverIdkey);

	

}
