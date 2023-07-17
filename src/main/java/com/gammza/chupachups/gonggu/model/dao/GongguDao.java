package com.gammza.chupachups.gonggu.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

import com.gammza.chupachups.gonggu.model.vo.Gonggu;

@Mapper
public interface GongguDao {
	
	ArrayList<Gonggu> selectMainList();
	
	ArrayList<Gonggu> selectggListView(HashMap<String, String> locationMap);

	int insertGonggu(Gonggu gonggu);
	
	int selectLastNum();

	Gonggu selectOneGonggu(int gongguNo);

	int selectTotalRecord();

	int updateGongguCount(int gongguNo);

	int updateGonggu(Gonggu gonggu);

	ArrayList<Gonggu> selectLeadGongguList(HashMap<String, String> listMap);

	int updateEndStatus(int gongguNo);

	ArrayList<Gonggu> searchGonggu(HashMap<String, String> map);
	
	int selectGongguTotalRecord();

	ArrayList<Gonggu> selectOneCategory(HashMap<String, String> map);

	int updateGongguStatus(int gongguNo);

	int updatepullUpAt(int gongguNo);

	ArrayList<Gonggu> selectAllGongguList();

}
