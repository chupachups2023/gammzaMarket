package com.gammza.chupachups.notice.controller;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gammza.chupachups.common.model.vo.PageInfo;
import com.gammza.chupachups.common.template.Pagination;
import com.gammza.chupachups.notice.model.service.NoticeService;
import com.gammza.chupachups.notice.model.vo.Notice;


@Controller
@RequestMapping("/adminpage")
//@SessionAttributes
public class NoticeController {
	
	@Autowired
	private NoticeService noticeService;
	
	@GetMapping("/noticeList.bo")
	public String noticeList(@RequestParam(defaultValue="1") int nowPage, Model model) {
		int totalRecord = noticeService.selectTotalRecord();
		int limit = 5;
		int offset = (nowPage -1 ) * limit;

		RowBounds rowBounds = new RowBounds(offset, limit);
		
		PageInfo pi = Pagination.getPageInfo(totalRecord, nowPage, limit, 3);
		
		List<Notice> noticeList = noticeService.selectnoticeList(rowBounds);
		model.addAttribute("noticeList", noticeList);
		model.addAttribute("pi", pi);
		return "adminpage/notice";
	}
	

	@GetMapping("/noticeDetail.bo")
	public void noticeDetail(@RequestParam int noticeNo, Model model) {
		
		Object notice = noticeService.selectOneNotice(noticeNo);
	
		model.addAttribute("notice", notice);
	}
	
	@GetMapping("/insertNotice.do")
	public void insertNotice() {}
	
	@PostMapping("/insertNotice.do")
	public String insertNotice(Notice notice, RedirectAttributes rd) {
		int result = noticeService.insertNotice(notice, rd);
		return "adminpage/insertNotice.do";	
	}
	
	
	@PostMapping("/deleteNotice.do")
	public String deleteNotice(int noticeNo, RedirectAttributes rd) {
		int result = noticeService.deleteNotice(noticeNo, rd);
		return "adminpage/deleteNotice";

	}
	
	@GetMapping("/updateNotice.do")
	public String updateNotice(@RequestParam int noticeNo, Model model) {
		model.addAttribute("notice", noticeService.selectOneNotice(noticeNo));
		return "adminpage/noticeUpdateFrom";
	}
	
	@PostMapping("/updateNotice.do")
	public String updateNotice(Notice notice, RedirectAttributes rd) {
		int result = noticeService.updateNotice(notice);
		rd.addFlashAttribute("msg", "공지사항 수정완료");
		return "adminpage/notice";
	}
	

}
