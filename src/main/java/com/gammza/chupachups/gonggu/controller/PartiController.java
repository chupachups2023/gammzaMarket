package com.gammza.chupachups.gonggu.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.view.RedirectView;

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
	public ModelAndView partiEnroll(@RequestParam int gongguNo, Model model,RedirectAttributes redirectAttr) {
		Member loginMember=(Member)model.getAttribute("loginMember");
		
		HashMap<String, String> map=new HashMap<String,String>();
		map.put("gongguNo", String.valueOf(gongguNo));
		map.put("userId", loginMember.getUserId());
		Parti parti=partiService.selectOneParti(map); //이미 참여한 이력이 있는지 검색
		
		Gonggu gonggu=gongguService.selectOneGonggu(gongguNo);
		model.addAttribute("gonggu", gonggu);
		Location location=locationService.selectLocationByNo(gonggu.getLocationNo());
		model.addAttribute("location", location);
		
		if(parti!=null) {
			redirectAttr.addFlashAttribute("msg","이미 참여한 공구입니다.");
			ModelAndView mav=new ModelAndView();
			mav.setView(new RedirectView("ggPartiList.pa"));
			
			return mav;
		}else {
			return new ModelAndView("/gonggu/ggPartiEnroll");
			
		}
		
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
			String str=partiList(model);
			return "/mypage/ggList_Parti";
		}else {
			redirectAttr.addFlashAttribute("msg","참여가 정상적으로 이루어지지 않았습니다.");
			return "redirect:/";
		}
	}
	
	@GetMapping("/ggPartiList.pa")
	public String partiList(Model model) {
		//최신신청 순서로 가져오기
		Member loginMember=(Member)model.getAttribute("loginMember");
		
		ArrayList<Gonggu> partiGongguList=new ArrayList<>();
		partiGongguList=partiService.selectAllPartiList(loginMember.getUserId());
		for(int i=0;i<partiGongguList.size();i++) {
			
			int gongguNo=partiGongguList.get(i).getGongguNo();
			HashMap<String, String> map=new HashMap<String,String>();
			map.put("gongguNo", String.valueOf(gongguNo));
			map.put("userId", loginMember.getUserId());
			Parti oneParti=partiService.selectOneParti(map);
			partiGongguList.get(i).setCreateAt(oneParti.getRegAt()); //공구 생성날짜를 참여일로 바꾸기 jsp에서 뿌려줄 때 공구 생성날짜는 필요 없는데 참여일 날짜는 필요하니까
			partiGongguList.get(i).setStatus(oneParti.getStatus());
		}
		
		//리뷰 갯수 가져와야됨
		
		model.addAttribute("partiList", partiGongguList);
		
		return "/mypage/ggList_Parti";
	}
	
	@GetMapping("/partiStatusUpdate.pa")
	public String partiStatusUpdate(@RequestParam int gongguNo, Model model) {
		String userId=((Member)model.getAttribute("loginMember")).getUserId();
		HashMap<String, String> map=new HashMap<String,String>();
		map.put("gongguNo", String.valueOf(gongguNo));
		map.put("userId", userId);
		Parti parti=partiService.selectOneParti(map);
		partiService.updatePartiStatus(map);
		Gonggu gonggu=gongguService.selectOneGonggu(gongguNo);
		gonggu.setPrice(gonggu.getPrice()*parti.getNum());
		int result=partiService.updateLeaderPoint(gonggu);
		
		partiList(model);
		return "/mypage/ggList_Parti";
	}
	
}
