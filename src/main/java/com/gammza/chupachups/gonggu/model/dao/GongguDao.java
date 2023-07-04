package com.gammza.chupachups.gonggu.model.dao;

import java.util.ArrayList;

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

}
