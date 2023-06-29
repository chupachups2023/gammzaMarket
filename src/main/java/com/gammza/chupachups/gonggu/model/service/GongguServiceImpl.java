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
	public Parti_Tb selectOneParti_Tb(int gongguNo) {
		return gongguDao.selectOneParti_Tb(gongguNo);
	}
}
