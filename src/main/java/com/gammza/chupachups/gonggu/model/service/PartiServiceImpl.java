package com.gammza.chupachups.gonggu.model.service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gammza.chupachups.gonggu.model.dao.PartiDao;
import com.gammza.chupachups.gonggu.model.vo.Parti;

@Service
public class PartiServiceImpl implements PartiService {
	@Autowired
	private PartiDao partiDao;

	@Override
	public int insertParti(Parti parti) {
		return partiDao.insertParti(parti);
	}

	@Override
	public int updateMemberPoint(HashMap<String,String> updatePoint) {
		return partiDao.updateMemberPoint(updatePoint);
	}
}
