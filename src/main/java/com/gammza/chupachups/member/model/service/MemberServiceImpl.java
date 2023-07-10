package com.gammza.chupachups.member.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gammza.chupachups.member.model.dao.MemberDao;
import com.gammza.chupachups.member.model.vo.Member;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	private MemberDao memberDao;

	@Override
	public int insertMember(Member member) {
		return memberDao.insertMember(member);
	}

	@Override
	public Member selectOneMember(String userId) {
		return memberDao.selectOneMember(userId);
	}

	@Override
	public int updateMember(Member member) {
		return memberDao.updateMember(member);
	}

	@Override
	public Member checkIdFunc(String userId) {
		return memberDao.checkIdFunc(userId);
	}

	@Override
	public int insertKakaoMember(Member member) {
		return memberDao.insertKakaoMember(member);
	}


}
