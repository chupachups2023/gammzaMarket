package com.gammza.chupachups.gonggu.model.dao;

import org.apache.ibatis.annotations.Mapper;

import com.gammza.chupachups.gonggu.model.vo.Gonggu;

@Mapper
public interface GongguDao {

	int insertGonggu(Gonggu gonggu);

}
