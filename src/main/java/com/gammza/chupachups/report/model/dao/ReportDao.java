package com.gammza.chupachups.report.model.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;

import com.gammza.chupachups.report.model.vo.Report;

public interface ReportDao {

	int insertReport(Report report);

	List<Report> selectreportList(RowBounds rowBounds);

	int selectTotalRecord();

	
}
