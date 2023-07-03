package com.gammza.chupachups.gonggu.model.service;

import java.util.ArrayList;

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
	public ArrayList<Gonggu> selectHomeList() {
		return gongguDao.selectHomeList();
	}

	@Override
	public int selectLastNum() {
		return gongguDao.selectLastNum();
	}

	@Override
	public int selectTotalRecored() {
		return gongguDao.selectTotalRecored();
	}

	@Override
	public ArrayList<Gonggu> selectggListView() {
		return gongguDao.selectggListView();
	}
}
