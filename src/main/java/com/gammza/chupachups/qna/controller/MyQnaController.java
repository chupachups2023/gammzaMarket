package com.gammza.chupachups.qna.controller;

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
import com.gammza.chupachups.qna.model.service.QnaService;
import com.gammza.chupachups.qna.model.vo.Qna;

@Controller
@RequestMapping("/mypage")
public class MyQnaController {
	@Autowired
	private QnaService qnaService;

	@GetMapping("/myQuestionList.do")
	public void myQnaList(@RequestParam(defaultValue="1") int nowPage, Model model) {
		int totalRecord = qnaService.selectTotalRecord();
		int limit = 5;
		int offset = (nowPage -1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		PageInfo pi = Pagination.getPageInfo(totalRecord, nowPage, limit, 3);
		
		List<Qna> myQuestionList = qnaService.selectMyQuestionList(rowBounds);
		model.addAttribute("myQuestionList", myQuestionList);
		model.addAttribute("pi", pi);
	}
	
	@GetMapping("/myQuestionAnswer.do")
	public void myQuestionAnswer(@RequestParam int qnaNo, @RequestParam int nowPage, Model model) {
		Qna qna = qnaService.selectOneQna(qnaNo);
		Qna qAns = qnaService.selectOneQAns(qnaNo);
		
		model.addAttribute("qna", qna);
		model.addAttribute("qAns", qAns);
		model.addAttribute("nowPage", nowPage);
	}
	
	@PostMapping("/myQuestionUpdate.do")
	public String myQuestionUpdate(@RequestParam int qnaNo, Qna qna, @RequestParam int nowPage, Model model, RedirectAttributes redirectAttr) {
		qna.setQnaContent(qna.getQnaContent());
		
		int result = qnaService.updateMyQuestion(qna);

		if(result > 0) {
			redirectAttr.addFlashAttribute("msg", "수정완료");
		}else {
			redirectAttr.addFlashAttribute("msg", "수정실패");
		}
		
		return "redirect:/mypage/myQuestionAnswer.do?nowPage="+nowPage+"&qnaNo="+qnaNo;
	}
}
