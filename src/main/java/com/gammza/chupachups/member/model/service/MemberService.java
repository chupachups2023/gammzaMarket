package com.gammza.chupachups.member.model.service;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;

import com.gammza.chupachups.member.model.vo.Member;

public interface MemberService {
	
	int insertMember(Member member);
	
	Member selectOneMember(String userId);
	
	int updateMember(Member member);

	Member checkIdFunc(String userId);

	int insertKakaoMember(Member member);

	Member selectMemberByKakao(Long id);

	Member selectMemberByNaver(String id);

	String insertNaverIdkey(String setNaverIdkey);

	int updateKakaoIdkey(HashMap<String, String> map);

	int updateNaverIdkey(HashMap<String, String> map);

	String findIdClick(String phone);

	int insertNaverMember(Member member);

	String findPwdClick(String userId, String phone);

	Member selectOneMemberByEmail(String email);


	int updatePwd(Member tempMember);

	int selectProceedingGonggu(String userId);

	int changeStatus(String userId);

	int selectTotalRecord();

	List<Member> selectMemberList(RowBounds rowBounds);

	int updateMember_Ad(Member member);

}
