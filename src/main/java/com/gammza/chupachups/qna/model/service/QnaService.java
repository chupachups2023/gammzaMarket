package com.gammza.chupachups.qna.model.service;

import java.util.List;

import org.apache.ibatis.session.RowBounds;

import com.gammza.chupachups.qna.model.vo.Qna;

public interface QnaService {

	int selectTotalRecord();

	List<Qna> selectQuestionList(RowBounds rowBounds);

	Qna selectOneQna(int qnaNo);

}
