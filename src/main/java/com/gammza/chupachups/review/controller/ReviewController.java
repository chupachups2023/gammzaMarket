package com.gammza.chupachups.review.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.gammza.chupachups.gonggu.model.service.GongguService;
import com.gammza.chupachups.gonggu.model.service.PartiService;
import com.gammza.chupachups.gonggu.model.vo.Gonggu;
import com.gammza.chupachups.gonggu.model.vo.Parti;
import com.gammza.chupachups.member.model.vo.Member;
import com.gammza.chupachups.review.model.service.ReviewService;
import com.gammza.chupachups.review.model.vo.Review;

@RequestMapping("/review")
@Controller
@SessionAttributes({"review"})
public class ReviewController {
	
	@Autowired
	private ReviewService reviewService; 
	@Autowired
	private PartiService partiService;
	@Autowired
	private GongguService gongguService;
	
	@GetMapping("/reviewList.re")
	public String reviewList(HttpSession session, Model model) {
		Member member=(Member) session.getAttribute("loginMember");
		ArrayList<Review> recieved=reviewService.selectRecievedReview(member.getUserId());
		ArrayList<Gonggu> leadedGonggu=reviewService.selectAllMyGonggu(member.getUserId());
		
		ArrayList<Review> leaderReview=new ArrayList<Review>();
		for(int i=0;i<recieved.size();i++) {
			for(int j=0;j<leadedGonggu.size();j++) {
				if(recieved.get(i).getGongguNo()==leadedGonggu.get(j).getGongguNo()) {
					leaderReview.add(recieved.get(i));
					recieved.remove(i);
					i--;
					break;
				}
			}
		}
		model.addAttribute("partiReview", recieved);
		model.addAttribute("leaderReview", leaderReview);
		return "/mypage/reviewList";
	}
	
	@GetMapping("/getReview.re")
	public String getReview(@RequestParam int reviewNo, Model model) {
		Review review=reviewService.selectOneReview(reviewNo);
		model.addAttribute("review", review);
		return "jsonView";
	}
	
	@GetMapping("/reviewWriteCheck.re")
	public String reviewWriteCheck(@RequestParam String userId, HttpSession session, Model model, @RequestParam int gongguNo) {
		Member loginMember=(Member) session.getAttribute("loginMember");
		HashMap<String,String> map=new HashMap<String,String>();
		
		map.put("loginMemberId", loginMember.getUserId());
		map.put("userId", userId);
		map.put("gongguNo", String.valueOf(gongguNo));
		
		int result=reviewService.selectWroteReviewCheck(map);
		
		Parti parti=partiService.selectOneParti(map);
		Gonggu gonggu=gongguService.selectOneGonggu(gongguNo);
		
		model.addAttribute("parti", parti);
		model.addAttribute("result", result);
		model.addAttribute("gonggu", gonggu);
		return "jsonView";
	}
	
	@PostMapping("/writeReview.re")
	public String writeReview(HttpServletRequest request, HttpSession session, Model model) {
		String receiverId=request.getParameter("receiverId");
		int rate=Integer.parseInt(request.getParameter("rate"));
		String reviewContent=request.getParameter("reviewContent");
		int gongguNo=Integer.parseInt(request.getParameter("gongguNo"));
		
		String userId=((Member)session.getAttribute("loginMember")).getUserId();
		
		Review review=new Review();
		review.setGongguNo(gongguNo);
		review.setRate(rate);
		review.setReviewContent(reviewContent);
		review.setReceiverId(receiverId);
		review.setReviewWriter(userId);
		
		
		
		int result=reviewService.insertReview(review);
		if(result>0) {
			double tempAdjust=0;
			switch(rate) {
				case 5: tempAdjust=0.2; break;
				case 4: tempAdjust=0.1; break;
				case 3: tempAdjust=0; break;
				case 2: tempAdjust=-0.1; break;
				case 1: tempAdjust=-0.2; break;
			}
			HashMap<String,String> updateTemp=new HashMap<String,String>();
			updateTemp.put("rate", String.valueOf(tempAdjust));
			updateTemp.put("userId", receiverId);
			int update=reviewService.updateTemperature(updateTemp);
			
			model.addAttribute("result", result);
		}
		
		return "jsonView";
	}
}
