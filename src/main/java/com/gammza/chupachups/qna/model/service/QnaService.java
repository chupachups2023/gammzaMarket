package com.gammza.chupachups.qna.model.service;

import java.util.List;

import org.apache.ibatis.session.RowBounds;

import com.gammza.chupachups.qna.model.vo.Qna;

public interface QnaService {

	int selectTotalRecord();

	List<Qna> selectQuestionList(RowBounds rowBounds);

	Qna selectOneQna(int qnaNo);

	Qna selectOneQAns(int qnaNo);

	int insertQAnswer(Qna qna);

	List<Qna> selectMyQuestionList(String userId, RowBounds rowBounds);

	int updateMyQuestion(Qna qna);

	int updateReplyMark(Qna qnaOrigin);

	int selectMyQnaTotalRecord(String userId);

	int insertQuestion(Qna qna);

	int deleteQuestion(int ref);

}
