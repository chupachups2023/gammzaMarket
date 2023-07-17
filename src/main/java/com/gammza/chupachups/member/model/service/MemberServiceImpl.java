package com.gammza.chupachups.member.model.service;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.gammza.chupachups.member.model.dao.MemberDao;
import com.gammza.chupachups.member.model.vo.Member;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;

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

	@Override
	public Member selectMemberByKakao(Long id) {
		return memberDao.selectMemberByKakao(id);
	}

	@Override
	public Member selectMemberByNaver(String id) {
		return memberDao.selectMemberByNaver(id);
	}

	@Override
	public String insertNaverIdkey(String naverIdkey) {
		return memberDao.insertNaverIdkey(naverIdkey);
	}

	@Override
	public int updateKakaoIdkey(HashMap<String, String> map) {
		return memberDao.updateKakaoIdkey(map);
	}

	@Override
	public int updateNaverIdkey(HashMap<String, String> map) {
		return memberDao.updateNaverIdkey(map);
	}
	
	@Override
	public String findIdClick(String phone) {
		return memberDao.findIdClick(phone);
	}

	@Override
	public int insertNaverMember(Member member) {
		return memberDao.insertNaverMember(member);
	}

	@Override
	public String findPwdClick(String userId, String phone) {
		return memberDao.findPwdClick(userId, phone);
	}

	@Override
	public Member selectOneMemberByEmail(String email) {
		return memberDao.selectOneMemberByEmail(email);
	}

	@Override
	public int updatePwd(Member tempMember) {
		return memberDao.updatePwd(tempMember);
	}

  @Override
	public int changeStatus(String userId) {
		return memberDao.changeStatus(userId);
	}

	@Override
	public int selectProceedingGonggu(String userId) {
		return memberDao.selectProceedingGonggu(userId);
	}

	@Override
	public int selectTotalRecord() {
		return memberDao.selectTotalRecord();
	}

	@Override
	public List<Member> selectMemberList(RowBounds rowBounds) {
		return memberDao.selectMemberList(rowBounds);
	}

	@Override
	public int updateMember_Ad(Member member) {
		return memberDao.updateMember_Ad(member);
	}

}
