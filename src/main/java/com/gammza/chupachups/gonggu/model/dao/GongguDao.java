package com.gammza.chupachups.gonggu.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.gammza.chupachups.gonggu.model.vo.Gonggu;

import com.gammza.chupachups.gonggu.model.vo.Parti_Tb;

@Mapper
public interface GongguDao {

	int insertGonggu(Gonggu gonggu);

	Gonggu selectOneGonggu(Gonggu gonggu);

	Gonggu selectOneHomeList();
}
