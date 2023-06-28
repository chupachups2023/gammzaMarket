package com.gammza.chupachups.notice.model.service;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
	public int writeNotice(Notice notice, RedirectAttributes rd) {
		return noticeDao.writeNotice(notice, rd);
	}

	@Override
	public int deleteNotice(int noticeNo, RedirectAttributes rd) {
		return noticeDao.deleteNotice(noticeNo, rd);
	}

	@Override
	public Object selectOneNotice(int noticeNo) {
		return noticeDao.selectOneNotice(noticeNo);
	}

	@Override
	public int updateNotice(Notice notice) {
		return noticeDao.updateNotice(notice);
	}
}
