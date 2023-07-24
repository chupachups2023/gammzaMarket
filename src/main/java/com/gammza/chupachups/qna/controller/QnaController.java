package com.gammza.chupachups.qna.controller;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gammza.chupachups.common.model.vo.PageInfo;
import com.gammza.chupachups.common.template.Pagination;
import com.gammza.chupachups.member.model.vo.Member;
import com.gammza.chupachups.qna.model.service.QnaService;
import com.gammza.chupachups.qna.model.vo.Qna;

@Controller
@RequestMapping("/adminpage")
@SessionAttributes({"loginMember"})
public class QnaController {
	@Autowired
	private QnaService qnaService;
	
	@GetMapping("/questionList.do")
	public void qnaList(@RequestParam(defaultValue="1") int nowPage, Model model) {
		int totalRecord = qnaService.selectTotalRecord();
		int limit = 10;
		int offset = (nowPage -1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		PageInfo pi = Pagination.getPageInfo(totalRecord, nowPage, limit, 5);
		
		List<Qna> questionList = qnaService.selectQuestionList(rowBounds);
		model.addAttribute("questionList", questionList);
		model.addAttribute("pi", pi);
	}
	
	@GetMapping("/questionAnswer.do")
	public void questionAnswer(@RequestParam int qnaNo, @RequestParam int nowPage, Model model) {
		Qna qna = qnaService.selectOneQna(qnaNo);
		Qna qAns = qnaService.selectOneQAns(qnaNo);
		
		model.addAttribute("qna", qna);
		model.addAttribute("qAns", qAns);
		model.addAttribute("nowPage", nowPage);
	}
	
	
	@PostMapping("/QAnswerInsert.do")
	public String QAnswerInsert(Qna qna, @RequestParam int nowPage, @RequestParam String qAnswer,  RedirectAttributes redirectAttr, @ModelAttribute("loginMember") Member member) {
		qna = qnaService.selectOneQna(qna.getQnaNo());
		Qna qnaOrigin = new Qna();
		qnaOrigin.setQnaTitle(qna.getQnaTitle() + " (답변완료)");
		qnaOrigin.setQnaNo(qna.getQnaNo());
		
		String userId = member.getUserId();
		
		qna.setQnaWriter(userId);
		qna.setQnaContent(qAnswer);
		qna.setQnaTitle("re: " + qna.getQnaTitle());
		
		
		int result = qnaService.insertQAnswer(qna);
		int result2 = qnaService.updateReplyMark(qnaOrigin);
		//잘 되었다는 alert창 
		if(result > 0) {
			redirectAttr.addFlashAttribute("msg", "답변완료");
		}else {
			redirectAttr.addFlashAttribute("msg", "답변실패");
		}
		return "redirect:/adminpage/questionAnswer.do?nowPage="+nowPage+"&qnaNo="+qna.getQnaNo();
	}
	
	@GetMapping("/deleteQuestion.do")
	public String deleteQuestion(@RequestParam int ref) {
		int result = qnaService.deleteQuestion(ref);
		return "redirect:/adminpage/questionList.do";
	}
}
