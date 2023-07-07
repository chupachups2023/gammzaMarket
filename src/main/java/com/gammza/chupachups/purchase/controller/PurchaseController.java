package com.gammza.chupachups.purchase.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gammza.chupachups.member.model.service.MemberService;
import com.gammza.chupachups.member.model.vo.Member;
import com.gammza.chupachups.purchase.model.service.PurchaseService;
import com.gammza.chupachups.purchase.model.vo.PointPurRec;

@Controller
@RequestMapping("/member")
public class PurchaseController {
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private PurchaseService purchaseService;
	
	@GetMapping("/pointPurchase.do")
	public void pointPurchase(HttpSession session, Model model) {
		Member loginMember = (Member) session.getAttribute("loginMember");
		String userId = loginMember.getUserId();
		
		Member member = memberService.selectOneMember(userId);
		model.addAttribute(member);
	}
	
	@PostMapping("/updatePoint.do")
	public String updatePoint(PointPurRec pointPR, Model model) {
		int result1 = purchaseService.updatePoint(pointPR);
		int result2 = purchaseService.insertPointPurRec(pointPR);
		Member member = memberService.selectOneMember(pointPR.getUserId());
		model.addAttribute(member);
		model.addAttribute(pointPR);
		return "redirect:/member/pointPurChk.do?pointOrderNum="+pointPR.getPointOrderNum();
	}
}
