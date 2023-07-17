package com.gammza.chupachups.gonggu.model.service;


import java.util.ArrayList;
import java.util.HashMap;

import com.gammza.chupachups.gonggu.model.vo.Gonggu;


public interface GongguService {
	
	ArrayList<Gonggu> searchGonggu(HashMap<String, String> map);
	
	ArrayList<Gonggu> selectggListView(HashMap<String,String> locationMap);
	
	ArrayList<Gonggu> selectMainList();
	
	ArrayList<Gonggu> selectLeadGongguList(HashMap<String, String> listMap);
	
	ArrayList<Gonggu> selectOneCategory(HashMap<String, String> map);
	
	Gonggu selectOneGonggu(int gongguNo);
	
	int insertGonggu(Gonggu gonggu);
	
	int selectGongguTotalRecord();
	
	int selectLastNum();
	
	int selectTotalRecord();

	int updateEndStatus(int gongguNo);

	int updateGonggu(Gonggu gonggu);

	ArrayList<Gonggu> selectAllGongguList();

	int updateGongguCount(int gongguNo);

	int updateGongguStatus(int gongguNo);

	int updatepullUpAt(int gongguNo);

}
