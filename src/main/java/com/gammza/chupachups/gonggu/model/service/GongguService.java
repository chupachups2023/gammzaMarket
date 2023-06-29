package com.gammza.chupachups.gonggu.model.service;

import java.util.List;

import com.gammza.chupachups.gonggu.model.vo.Gonggu;
import com.gammza.chupachups.gonggu.model.vo.Parti_Tb;

public interface GongguService {

	int insertGonggu(Gonggu gonggu);

	Parti_Tb selectOneParti_Tb(int gongguNo);
}
