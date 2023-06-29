package com.gammza.chupachups.gonggu.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gammza.chupachups.gonggu.model.dao.GongguDao;
import com.gammza.chupachups.gonggu.model.vo.Gonggu;

import com.gammza.chupachups.gonggu.model.vo.Parti_Tb;

@Service
public class GongguServiceImpl implements GongguService {

	@Autowired
	private GongguDao gongguDao;

	@Override
	public int insertGonggu(Gonggu gonggu) {
		return gongguDao.insertGonggu(gonggu);
	}

	@Override
	public Gonggu selectOneGonggu(Gonggu gonggu) {
		return gongguDao.selectOneGonggu(gonggu);
	}

	@Override
	public Gonggu selectOneHomeList() {
		return gongguDao.selectOneHomeList();
	}
}
