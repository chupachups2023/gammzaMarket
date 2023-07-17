package com.gammza.chupachups.adminPage.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gammza.chupachups.gonggu.model.service.GongguService;
import com.gammza.chupachups.gonggu.model.vo.Gonggu;
import com.gammza.chupachups.member.model.vo.Member;

@Controller
@RequestMapping("/adminpage")
public class AdminPageController {
	
	@Autowired
	private GongguService gongguService;

	@GetMapping("/allGGList.do")
	public String allGGList (Model model) {
		Member member=(Member)model.getAttribute("loginMember");
		ArrayList<Gonggu>allList = gongguService.selectAllGongguList();
		model.addAttribute("allList", allList);
		return "/adminpage/allGGList";
	}
}
