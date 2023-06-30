package com.gammza.chupachups.gonggu.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gammza.chupachups.gonggu.model.dao.GongguDao;
import com.gammza.chupachups.gonggu.model.vo.Gonggu;

@Service
public class GongguServiceImpl implements GongguService {

	@Autowired
	private GongguDao gongguDao;

	@Override
	public int insertGonggu(Gonggu gonggu) {
		return gongguDao.insertGonggu(gonggu);
	}

	@Override
	public Gonggu selectOneGonggu(int gongguNo) {
		return gongguDao.selectOneGonggu(gongguNo);
	}

	@Override
	public Gonggu selectOneHomeList() {
		return gongguDao.selectOneHomeList();
	}

	@Override
	public int selectLastNum() {
		return gongguDao.selectLastNum();
	}
}
