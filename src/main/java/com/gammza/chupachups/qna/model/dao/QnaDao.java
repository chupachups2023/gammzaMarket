package com.gammza.chupachups.qna.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import com.gammza.chupachups.qna.model.vo.Qna;

@Mapper
public interface QnaDao {

	int selectTotalRecord();

	List<Qna> selectQuestionList(RowBounds rowBounds);

	Qna selectOneQna(int qnoNo);

	Qna selectOneQAns(int qnaNo);

	int insertQAnswer(Qna qna);

	List<Qna> selectMyQuestionList(String userId, RowBounds rowBounds);

	int updateMyQuestion(Qna qna);

	int updateReplyMark(Qna qnaOrigin);

	int selectMyQnaTotalRecord(String userId);

	int insertQuestion(Qna qna);

	int deleteQuestion(int ref);

}
