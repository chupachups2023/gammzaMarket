package com.gammza.chupachups.report.model.service;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gammza.chupachups.report.model.dao.ReportDao;
import com.gammza.chupachups.report.model.vo.Report;

@Service
public class ReportServiceImpl implements ReportService {
	
	@Autowired
	private ReportDao reportDao;
		
	@Override
	public int insertReport(Report report) {
		return reportDao.insertReport(report);
	}

	@Override
	public int selectTotalRecord() {
		return reportDao.selectTotalRecord();
	}

	@Override
	public List<Report> selectreportList(RowBounds rowBounds) {
		return reportDao.selectreportList(rowBounds);
	}
	
}
