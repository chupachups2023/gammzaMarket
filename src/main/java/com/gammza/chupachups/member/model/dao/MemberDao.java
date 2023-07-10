package com.gammza.chupachups.member.model.dao;

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

	Member selectMemberByPhone(String phone);
}
