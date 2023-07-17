package com.gammza.chupachups.mypage;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.gammza.chupachups.member.model.service.MemberService;
import com.gammza.chupachups.member.model.vo.Member;

@Controller
@SessionAttributes({"loginMember"})
@RequestMapping("/mypage")
public class MypageController {
	@Autowired
	private MemberService memberSerivce;
	
	@GetMapping("/mypageMain.me")
	public String mypageMain(Model model, HttpSession session) {
		Member member=(Member)session.getAttribute("loginMember");
		member=memberSerivce.selectOneMember(member.getUserId());
		model.addAttribute("loginMember", member);
		
		return "/mypage/mypageMain";
	}
}
