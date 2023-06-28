package com.gammza.chupachups.notice.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gammza.chupachups.notice.model.vo.Notice;




@Mapper
public interface NoticeDao {
	List<Notice> selectnoticeList(RowBounds rowBounds);
	
	int selectTotalRecord();

	int writeNotice(Notice notice, RedirectAttributes rd);

	int deleteNotice(int noticeNo, RedirectAttributes rd);

	Object selectOneNotice(int noticeNo);

	int updateNotice(Notice notice);
}
