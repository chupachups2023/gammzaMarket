package com.gammza.chupachups.gonggu.model.service;


import java.util.ArrayList;
import java.util.List;

import com.gammza.chupachups.gonggu.model.vo.Gonggu;


public interface GongguService {

	int insertGonggu(Gonggu gonggu);

	Gonggu selectOneGonggu(int gongguNo);

	ArrayList<Gonggu> selectHomeList();

	int selectLastNum();

	int selectTotalRecored();

	ArrayList<Gonggu> selectggListView();

	int updateGongguCount(int gongguNo);

	int updateEndStatus(int gongguNo);

	int updateGonggu(Gonggu gonggu);

	ArrayList<Gonggu> searchGonggu(String gongguName);
	
	int selectGongguTotalRecored();

	ArrayList<Gonggu> selectOneCategory(int category);

}
