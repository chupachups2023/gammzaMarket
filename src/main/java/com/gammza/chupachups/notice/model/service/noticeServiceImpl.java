package com.gammza.chupachups.notice.model.service;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gammza.chupachups.notice.model.dao.NoticeDao;
import com.gammza.chupachups.notice.model.vo.Notice;

@Service
public class NoticeServiceImpl implements NoticeService {
	@Autowired
	NoticeDao noticeDao;

	@Override
	public int selectTotalRecord() {
		
		return noticeDao.selectTotalRecord();
	}

	@Override
	public List<Notice> selectnoticeList(RowBounds rowBounds) {
		return noticeDao.selectnoticeList();
	}
}
