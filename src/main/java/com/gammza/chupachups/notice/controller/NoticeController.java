package com.gammza.chupachups.notice.controller;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gammza.chupachups.notice.model.service.noticeService;
import com.gammza.chupachups.notice.model.vo.notice;
import com.kh.spring.common.model.vo.PageInfo;
import com.kh.spring.common.template.Pagination;

@Controller
@RequestMapping("/notice")
public class NoticeController {
	
	@Autowired
	private noticeService noticeService;
	
	@GetMapping("/noticeList.bo")
	public void noticeList(@RequestParam(defaultValue="1") int nowPage, Model model) {
		int totalRecord = noticeService.selectTotalRecord();
		int limit = 5;
		int offset = (nowPage -1 ) * limit;
		RowBounds rowBounds = new RowNounds(offset, limit);
		
		PageInfo pi = Pagination.getPageInfo(totalRecord, nowPage, limit, 3);
		
		List<notice> noticeList = noticeService.selectBoardList(rowBounds);
		model.addAttribute("noticeList", noticeList);
		model.addAttribute("pi", pi);
	}
	
//	@GetMapping("/writeNotice.do")
	

}
