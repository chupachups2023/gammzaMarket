package com.gammza.chupachups.gonggu.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gammza.chupachups.gonggu.model.service.GongguService;
import com.gammza.chupachups.gonggu.model.service.PartiService;
import com.gammza.chupachups.gonggu.model.vo.Gonggu;
import com.gammza.chupachups.gonggu.model.vo.Parti;
import com.gammza.chupachups.location.model.service.LocationService;
import com.gammza.chupachups.location.model.vo.Location;
import com.gammza.chupachups.member.model.service.MemberService;
import com.gammza.chupachups.member.model.vo.Member;


@Controller
@RequestMapping("/gonggu")
@SessionAttributes({"loginMember"})
public class PartiController {
	@Autowired
	private PartiService partiService;
	@Autowired
	private GongguService gongguService;
	@Autowired
	private LocationService locationService;
	@Autowired
	private MemberService memberService;
	
	@GetMapping("/partiEnroll.pa")
	public String partiEnroll(@RequestParam int gongguNo, Model model) {
		Gonggu gonggu=gongguService.selectOneGonggu(gongguNo);
		model.addAttribute("gonggu", gonggu);
		Location location=locationService.selectLocationByNo(gonggu.getLocationNo());
		model.addAttribute("location", location);
		
		return "/gonggu/ggPartiEnroll";
	}
	
	@PostMapping("/partiEnroll.pa")
	public String partiEnrollFrm(Parti parti,RedirectAttributes redirectAttr,Model model) {
		int result=partiService.insertParti(parti);
		
		if(result>0) {
			int totalPrice=gongguService.selectOneGonggu(parti.getGongguNo()).getPrice()*parti.getNum();
			HashMap<String,String> updatePoint=new HashMap<String,String>();
			updatePoint.put("totalPoint", String.valueOf(totalPrice));
			updatePoint.put("userId", parti.getPartiMember());
			int pointResult=partiService.updateMemberPoint(updatePoint);
			if(pointResult>0) {
				Member member=memberService.selectOneMember(parti.getPartiMember());
				model.addAttribute("loginMember", member);
			}
			return "/gonggu/ggPartiList";
		}else {
			redirectAttr.addFlashAttribute("msg","참여가 정상적으로 이루어지지 않았습니다.");
			return "/home";
		}
		
	}
	
}
