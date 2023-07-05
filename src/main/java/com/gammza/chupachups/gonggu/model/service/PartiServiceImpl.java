package com.gammza.chupachups.gonggu.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gammza.chupachups.gonggu.model.dao.PartiDao;

@Service
public class PartiServiceImpl implements PartiService {
	@Autowired
	private PartiDao partiDao;
}
