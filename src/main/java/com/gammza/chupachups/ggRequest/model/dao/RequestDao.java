package com.gammza.chupachups.ggRequest.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

import com.gammza.chupachups.ggRequest.model.vo.Request;
import com.gammza.chupachups.ggRequest.model.vo.RequestMember;

@Mapper
public interface RequestDao {

	ArrayList<Request> selectAllRequestList(HashMap<String, String> map);

	int updateRequestCount(int requestNo);

	Request selectRequest(int requestNo);
	
	ArrayList<RequestMember> selectRequestMember(int requestNo);

	int insertRequest(Request request);

	int selectLastNum();

	int insertRequestMember(RequestMember reqMem);

	int selectRequestMemberByNo(HashMap<String, String> map);

	int updateRequestNum(int requestNo);

	int updateRequestStatus(int requestNo);

	int updateRequestReqStatus(int requestNo);


}
