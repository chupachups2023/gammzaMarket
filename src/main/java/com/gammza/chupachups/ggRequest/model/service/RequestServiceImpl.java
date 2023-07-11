package com.gammza.chupachups.ggRequest.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gammza.chupachups.ggRequest.model.dao.RequestDao;
import com.gammza.chupachups.ggRequest.model.vo.Request;
import com.gammza.chupachups.ggRequest.model.vo.RequestMember;

@Service
public class RequestServiceImpl implements RequestService {

	@Autowired
	private RequestDao requestDao;

	@Override
	public ArrayList<Request> selectAllRequestList(HashMap<String, String> map) {
		return requestDao.selectAllRequestList(map);
	}

	@Override
	public int updateRequestCount(int requestNo) {
		return requestDao.updateRequestCount(requestNo);
	}

	@Override
	public Request selectRequest(int requestNo) {
		return requestDao.selectRequest(requestNo);
	}

	@Override
	public ArrayList<RequestMember> selectRequestMember(int requestNo) {
		return requestDao.selectRequestMember(requestNo);
	}

	@Override
	public int insertRequest(Request request) {
		return requestDao.insertRequest(request);
	}

	@Override
	public int selectLastNum() {
		return requestDao.selectLastNum();
	}

}
