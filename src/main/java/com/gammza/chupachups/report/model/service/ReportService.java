package com.gammza.chupachups.report.model.service;

import java.util.List;

import org.apache.ibatis.session.RowBounds;

import com.gammza.chupachups.report.model.vo.Report;

public interface ReportService {

	int insertReport(Report report);

	int selectTotalRecord();

	List<Report> selectreportList(RowBounds rowBounds);
 
}
