package com.gammza.chupachups.notice.model.service;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gammza.chupachups.notice.model.vo.Notice;


public interface NoticeService {
	
	List<Notice> selectnoticeList(RowBounds rowBounds);
	
	int selectTotalRecord();

	int insertNotice(Notice notice);

	int deleteNotice(int noticeNo);

	Object selectOneNotice(int noticeNo);

	int updateNotice(Notice notice);

	int updateCountNotice(int noticeNo);


}
