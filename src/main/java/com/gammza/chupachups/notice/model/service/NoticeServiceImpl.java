package com.gammza.chupachups.notice.model.service;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gammza.chupachups.notice.model.dao.NoticeDao;
import com.gammza.chupachups.notice.model.vo.Notice;


@Service
public class NoticeServiceImpl implements NoticeService {

	@Autowired
	private NoticeDao noticeDao;

	@Override
	public List<Notice> selectnoticeList(RowBounds rowBounds) {
		return noticeDao.selectnoticeList(rowBounds);
	}

	@Override
	public int selectTotalRecord() {
		return noticeDao.selectTotalRecord();
	}

	@Override
	public int insertNotice(Notice notice) {
		System.out.println(notice);
		return noticeDao.insertNotice(notice);

	}

	@Override
	public int deleteNotice(int noticeNo) {
		return noticeDao.deleteNotice(noticeNo);
	}

	@Override
	public Object selectOneNotice(int noticeNo) {
		return noticeDao.selectOneNotice(noticeNo);
	}

	@Override
	public int updateNotice(Notice notice) {
		System.out.println(notice);
		return noticeDao.updateNotice(notice);
	}

	@Override
	public int updateCountNotice(int noticeNo) {
		return noticeDao.updateCountNotice(noticeNo);
	}

}
