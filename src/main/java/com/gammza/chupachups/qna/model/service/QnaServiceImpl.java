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

}
