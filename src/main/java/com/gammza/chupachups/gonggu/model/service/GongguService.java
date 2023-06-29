package com.gammza.chupachups.gonggu.model.service;


import com.gammza.chupachups.gonggu.model.vo.Gonggu;


public interface GongguService {

	int insertGonggu(Gonggu gonggu);

	Gonggu selectOneGonggu(int gongguNo);

	Gonggu selectOneHomeList();

	int selectLastNum();
}
