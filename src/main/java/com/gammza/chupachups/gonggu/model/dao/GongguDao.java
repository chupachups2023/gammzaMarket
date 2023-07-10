package com.gammza.chupachups.gonggu.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

import com.gammza.chupachups.gonggu.model.vo.Gonggu;

@Mapper
public interface GongguDao {
	
	ArrayList<Gonggu> selectHomeList();
	
	ArrayList<Gonggu> selectggListView(HashMap<String, String> locationMap);

	int insertGonggu(Gonggu gonggu);
	
	int selectLastNum();

	Gonggu selectOneGonggu(int gongguNo);

	int selectTotalRecored();

	int updateGongguCount(int gongguNo);

	int updateGonggu(Gonggu gonggu);

	ArrayList<Gonggu> selectLeadGongguList(String userId);

	int updateEndStatus(int gongguNo);

	ArrayList<Gonggu> searchGonggu(HashMap<String, String> map);
	
	int selectGongguTotalRecored();

	ArrayList<Gonggu> selectOneCategory(HashMap<String, String> map);


}
