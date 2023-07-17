package com.gammza.chupachups.gonggu.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gammza.chupachups.gonggu.model.dao.PartiDao;
import com.gammza.chupachups.gonggu.model.vo.Gonggu;
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
	public int updateMemberPointMinus(HashMap<String,String> updatePoint) {
		return partiDao.updateMemberPointMinus(updatePoint);
	}
	
	@Override
	public int updateMemberPointPlus(HashMap<String,String> updatePoint) {
		return partiDao.updateMemberPointPlus(updatePoint);
	}

	@Override
	public ArrayList<Gonggu> selectAllPartiList(HashMap<String, String> listMap) {
		return partiDao.selectAllPartiList(listMap);
	}

	@Override
	public Parti selectOneParti(HashMap<String, String> selectParti) {
		return partiDao.selectOneParti(selectParti);
	}

	@Override
	public int updatePartiStatusSelf(HashMap<String, String> map) {
		return partiDao.updatePartiStatusSelf(map);
	}

	@Override
	public ArrayList<Parti> selectPartiListForLeader(HashMap<String, String> map) {
		return partiDao.selectPartiListForLeader(map);
	}

	@Override
	public int updatePartiStatusByLeader(HashMap<String, String> map) {
		return partiDao.updatePartiStatusByLeader(map);
	}
}
