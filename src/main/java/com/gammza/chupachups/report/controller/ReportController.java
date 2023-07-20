package com.gammza.chupachups.report.controller;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gammza.chupachups.common.model.vo.PageInfo;
import com.gammza.chupachups.common.template.Pagination;
import com.gammza.chupachups.report.model.service.ReportService;
import com.gammza.chupachups.report.model.vo.Report;

@Controller
//@SessionAttributes
public class ReportController {
	
	@Autowired
	private ReportService reportService;
	
	@PostMapping("/report/insertReport.do")
	public String insertReport(Report report, Model model, RedirectAttributes rd) {
		int result = reportService.insertReport(report);
		
//		System.out.println(report);
		
		rd.addFlashAttribute("msg", "신고가 완료되었습니다.");
		return "redirect:/";
	}
	@GetMapping("/report/reportList.bo")
	public String reportList(@RequestParam(defaultValue="1") int nowPage, Model model) {
		int totalRecord = reportService.selectTotalRecord();
		int limit = 50000000;
		int offset = (nowPage - 1) * limit;
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		PageInfo pi = Pagination.getPageInfo(totalRecord, nowPage, limit, 3);
		
		List<Report> reportList = reportService.selectreportList(rowBounds);
		model.addAttribute("reportList", reportList);
		model.addAttribute("pi", pi);
		return "adminpage/reportList";
	}
}
