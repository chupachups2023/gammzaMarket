package com.gammza.chupachups.qna.model.service;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gammza.chupachups.qna.model.dao.QnaDao;
import com.gammza.chupachups.qna.model.vo.Qna;

@Service
public class QnaServiceImpl implements QnaService {

	@Autowired
	private QnaDao qnaDao;
	
	@Override
	public int selectTotalRecord() {
		return qnaDao.selectTotalRecord();
	}

	@Override
	public List<Qna> selectQuestionList(RowBounds rowBounds) {
		return qnaDao.selectQuestionList(rowBounds);
	}

	@Override
	public Qna selectOneQna(int qnaNo) {
		return qnaDao.selectOneQna(qnaNo);
	}

	@Override
	public Qna selectOneQAns(int qnaNo) {
		return qnaDao.selectOneQAns(qnaNo);
	}

	@Override
	public int insertQAnswer(Qna qna) {
		return qnaDao.insertQAnswer(qna);
	}

	@Override
	public List<Qna> selectMyQuestionList(String userId, RowBounds rowBounds) {
		return qnaDao.selectMyQuestionList(userId, rowBounds);
	}

	@Override
	public int updateMyQuestion(Qna qna) {
		return qnaDao.updateMyQuestion(qna);
	}

	@Override
	public int updateReplyMark(Qna qnaOrigin) {
		return qnaDao.updateReplyMark(qnaOrigin);
		
	}

	@Override
	public int selectMyQnaTotalRecord(String userId) {
		return qnaDao.selectMyQnaTotalRecord(userId);
	}

	@Override
	public int insertQuestion(Qna qna) {
		return qnaDao.insertQuestion(qna);
	}

	@Override
	public int deleteQuestion(int ref) {
		return qnaDao.deleteQuestion(ref);
	}

}
