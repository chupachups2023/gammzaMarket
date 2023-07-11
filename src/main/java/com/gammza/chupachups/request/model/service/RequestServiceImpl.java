package com.gammza.chupachups.request.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gammza.chupachups.request.model.dao.RequestDao;

import okhttp3.Request;

@Service
public class RequestServiceImpl implements RequestService {

	@Autowired
	private RequestDao requestDao;

	@Override
	public ArrayList<Request> selectAllRequestList(HashMap<String, String> map) {
		return requestDao.selectAllRequestList(map);
	}
}
