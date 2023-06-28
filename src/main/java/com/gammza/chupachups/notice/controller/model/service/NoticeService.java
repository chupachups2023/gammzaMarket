package com.gammza.chupachups.notice.controller.model.service;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gammza.chupachups.notice.controller.model.vo.Notice;



public interface NoticeService {
	
	List<Notice> selectnoticeList(RowBounds rowBounds);
	
	int selectTotalRecord();

	int writeNotice(Notice notice, RedirectAttributes rd);

	int deleteNotice(int noticeNo, RedirectAttributes rd);

	Object selectOneNotice(int noticeNo);

	int updateNotice(Notice notice);
}
