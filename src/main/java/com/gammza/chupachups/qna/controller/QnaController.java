package com.gammza.chupachups.qna.controller;

import java.util.List;

import javax.servlet.ServletContext;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ResourceLoader;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gammza.chupachups.common.model.vo.PageInfo;
import com.gammza.chupachups.common.template.Pagination;
import com.gammza.chupachups.qna.model.service.QnaService;
import com.gammza.chupachups.qna.model.vo.Qna;

@Controller
@RequestMapping("/adminpage")
public class QnaController {
	@Autowired
	private QnaService qnaService;
	
	@Autowired
	private ServletContext application;
	
	@Autowired
	private ResourceLoader resourceLoader;
	
	@GetMapping("/questionList.do")
	public void qnaList(@RequestParam(defaultValue="1") int nowPage, Model model) {
		int totalRecord = qnaService.selectTotalRecord();
		int limit = 5;
		int offset = (nowPage -1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		PageInfo pi = Pagination.getPageInfo(totalRecord, nowPage, limit, 3);
		
		List<Qna> questionList = qnaService.selectQuestionList(rowBounds);
		model.addAttribute("questionList", questionList);
		model.addAttribute("pi", pi);
	}
	
	@GetMapping("/questionAnswer.do")
	public void questionAnswer(@RequestParam int qnaNo, Model model) {
		Qna qna = qnaService.selectOneQna(qnaNo);
		model.addAttribute("qna", qna);
	}
	@GetMapping("/QAnswerInsert.do")
	public void QAnswerInsert() {
		
	}
}
