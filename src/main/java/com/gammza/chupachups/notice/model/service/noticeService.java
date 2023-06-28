package com.gammza.chupachups.notice.model.service;

import java.util.List;

import org.apache.ibatis.session.RowBounds;

import com.gammza.chupachups.notice.model.vo.Notice;

public interface NoticeService {

	int selectTotalRecord();

	List<Notice> selectnoticeList(RowBounds rowBounds);

}
