package com.gammza.chupachups.notice.model.dao;

import java.util.List;

import com.gammza.chupachups.notice.model.vo.Notice;

public interface NoticeDao {

	List<Notice> selectnoticeList();

	int selectTotalRecord();

}
