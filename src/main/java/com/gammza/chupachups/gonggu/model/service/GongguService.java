package com.gammza.chupachups.gonggu.model.service;


import java.util.ArrayList;
import java.util.List;
import java.util.HashMap;

import com.gammza.chupachups.gonggu.model.vo.Gonggu;


public interface GongguService {
	
	ArrayList<Gonggu> searchGonggu(String gongguName);
	
	ArrayList<Gonggu> selectggListView(HashMap<String,String> locationMap);
	
	ArrayList<Gonggu> selectHomeList();
	
	ArrayList<Gonggu> selectLeadGongguList(String userId);
	
	ArrayList<Gonggu> selectOneCategory(int category);
	
	Gonggu selectOneGonggu(int gongguNo);
	
	int insertGonggu(Gonggu gonggu);
	
	int selectGongguTotalRecored();
	
	int selectLastNum();
	
	int selectTotalRecored();
	
	int updateEndStatus(int gongguNo);
	
	int updateGonggu(Gonggu gonggu);
	
	int updateGongguCount(int gongguNo);


}
