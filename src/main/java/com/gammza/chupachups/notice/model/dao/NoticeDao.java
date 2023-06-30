package com.gammza.chupachups.notice.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;
import org.springframework.transaction.annotation.Transactional;

import com.gammza.chupachups.notice.model.vo.Notice;


@Mapper
public interface NoticeDao {	

	List<Notice> selectnoticeList(RowBounds rowBounds);
	
	int selectTotalRecord();

	int insertNotice(Notice notice);

	int deleteNotice(int noticeNo);

	Object selectOneNotice(int noticeNo);

	int updateNotice(Notice notice);

	int updateCountNotice(int noticeNo);

}
