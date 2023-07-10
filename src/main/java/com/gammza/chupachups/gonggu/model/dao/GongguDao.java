package com.gammza.chupachups.gonggu.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.gammza.chupachups.gonggu.model.vo.Gonggu;

@Mapper
public interface GongguDao {

	int insertGonggu(Gonggu gonggu);

	Gonggu selectOneGonggu(int gongguNo);

	ArrayList<Gonggu> selectHomeList();

	int selectLastNum();

	ArrayList<Gonggu> selectggListView();

	int selectTotalRecored();

	int updateGongguCount(int gongguNo);

	int updateEndStatus(int gongguNo);

	int updateGonggu(Gonggu gonggu);

	ArrayList<Gonggu> searchGonggu(String gongguName);
	
	int selectGongguTotalRecored();

	ArrayList<Gonggu> selectOneCategory(int category);


}
