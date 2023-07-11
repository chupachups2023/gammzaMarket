package com.gammza.chupachups.gonggu.model.service;


import java.util.ArrayList;
import java.util.List;
import java.util.HashMap;

import com.gammza.chupachups.gonggu.model.vo.Gonggu;


public interface GongguService {
	
	ArrayList<Gonggu> selectHomeList();
	
	ArrayList<Gonggu> selectggListView(HashMap<String,String> locationMap);

	int insertGonggu(Gonggu gonggu);

	Gonggu selectOneGonggu(int gongguNo);

	int selectLastNum();

	int selectTotalRecored();

	int updateGongguCount(int gongguNo);

	int updateEndStatus(int gongguNo);

	int updateGonggu(Gonggu gonggu);

	ArrayList<Gonggu> selectLeadGongguList(String userId);

	ArrayList<Gonggu> searchGonggu(String gongguName);
	
	int selectGongguTotalRecored();

	ArrayList<Gonggu> selectOneCategory(int category);

}
