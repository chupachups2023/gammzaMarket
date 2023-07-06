package com.gammza.chupachups.purchase.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gammza.chupachups.member.model.service.MemberService;
import com.gammza.chupachups.member.model.vo.Member;

@Controller
@RequestMapping("/member")
public class PurchaseController {
	
	@Autowired
	private MemberService memberService;
	
	@GetMapping("/pointPurchase.do")
	public void pointPurchase(HttpSession session, Model model) {
		Member loginMember = (Member) session.getAttribute("loginMember");
		String userId = loginMember.getUserId();
		
		Member member = memberService.selectOneMember(userId);
		model.addAttribute(member);
		
		
	}
}
