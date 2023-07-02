package com.gammza.chupachups.gonggu.model.service;


import java.util.ArrayList;

import com.gammza.chupachups.gonggu.model.vo.Gonggu;


public interface GongguService {

	int insertGonggu(Gonggu gonggu);

	Gonggu selectOneGonggu(int gongguNo);


	Gonggu selectOneHomeList();

	ArrayList<Gonggu> selectHomeList();

	int selectLastNum();

	int selectTotalRecored();

	ArrayList<Gonggu> selectggListView();

}
