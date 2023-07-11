package com.gammza.chupachups.request.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

import okhttp3.Request;

@Mapper
public interface RequestDao {

	ArrayList<Request> selectAllRequestList(HashMap<String, String> map);

}
