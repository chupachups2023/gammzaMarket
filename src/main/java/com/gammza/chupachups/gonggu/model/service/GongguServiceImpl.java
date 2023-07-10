package com.gammza.chupachups.gonggu.model.service;

import java.util.ArrayList;
import java.util.List;

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

	@Override
	public int updateGongguCount(int gongguNo) {
		return gongguDao.updateGongguCount(gongguNo);
	}

	@Override
	public int updateEndStatus(int gongguNo) {
		return gongguDao.updateEndStatus(gongguNo);
	}

	@Override
	public int updateGonggu(Gonggu gonggu) {
		return gongguDao.updateGonggu(gonggu);
	}

	@Override
	public ArrayList<Gonggu> searchGonggu(String gongguName) {
		return gongguDao.searchGonggu(gongguName);
	}

	@Override
	public int selectGongguTotalRecored() {
		return gongguDao.selectGongguTotalRecored();
	}

	@Override
	public ArrayList<Gonggu> selectOneCategory(int category) {
		return gongguDao.selectOneCategory(category);
	}

}
