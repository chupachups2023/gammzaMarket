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
@RequestMapping("/mypage")
@SessionAttributes({"loginMember"})
public class MyQnaController {
	@Autowired
	private QnaService qnaService;

	@GetMapping("/myQuestionList.do")
	public void myQnaList(@RequestParam(defaultValue="1") int nowPage, Model model, @ModelAttribute("loginMember") Member member) {
		String userId = member.getUserId();
		int totalRecord = qnaService.selectMyQnaTotalRecord(userId);
		int limit = 10;
		int offset = (nowPage -1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		PageInfo pi = Pagination.getPageInfo(totalRecord, nowPage, limit, 5);
		
		List<Qna> myQuestionList = qnaService.selectMyQuestionList(userId, rowBounds);
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
		Qna qna2 = qnaService.selectOneQna(qnaNo);
		qna2.setQnaContent(qna.getQnaContent());
		qna2.setQnaTitle(qna.getQnaTitle());
		
		int result = qnaService.updateMyQuestion(qna2);

		if(result > 0) {
			redirectAttr.addFlashAttribute("msg", "수정완료");
		}else {
			redirectAttr.addFlashAttribute("msg", "수정실패");
		}
		
		return "redirect:/mypage/myQuestionAnswer.do?nowPage="+nowPage+"&qnaNo="+qnaNo;
	}
	
	@GetMapping("/questionForm.do")
	public void questionForm() {}
	
	@PostMapping("/insertQuestion.do")
	public String insertQuestion(Qna qna, @ModelAttribute("loginMember") Member member, RedirectAttributes redirectAttr) {
		
		//category 0이 나오면 돌려보내기 만들기
		String userId = member.getUserId();
		
		qna.setQnaWriter(userId);

		int result = qnaService.insertQuestion(qna);
		//잘 되었다는 alert창 
		if(result > 0) {
			redirectAttr.addFlashAttribute("msg", "문의완료");
		}else {
			redirectAttr.addFlashAttribute("msg", "문의실패");
		}
		return "redirect:/mypage/myQuestionList.do";
	}
	
}
