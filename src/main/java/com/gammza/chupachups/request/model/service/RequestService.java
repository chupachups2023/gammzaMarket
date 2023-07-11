package com.gammza.chupachups.request.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import okhttp3.Request;

public interface RequestService {

	ArrayList<Request> selectAllRequestList(HashMap<String, String> map);

}
