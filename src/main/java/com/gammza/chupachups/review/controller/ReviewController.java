package com.gammza.chupachups.review.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gammza.chupachups.gonggu.model.service.PartiService;
import com.gammza.chupachups.gonggu.model.vo.Gonggu;
import com.gammza.chupachups.gonggu.model.vo.Parti;
import com.gammza.chupachups.member.model.vo.Member;
import com.gammza.chupachups.review.model.service.ReviewService;
import com.gammza.chupachups.review.model.vo.Review;

@RequestMapping("/review")
@Controller
public class ReviewController {
	
	@Autowired
	private ReviewService reviewService; 
	@Autowired
	private PartiService partiService;
	
	@GetMapping("/reviewList.re")
	public String reviewList(HttpSession session, Model model) {
		Member member=(Member) session.getAttribute("loginMember");
		ArrayList<Review> recieved=reviewService.selectRecievedReview(member.getUserId());
		ArrayList<Gonggu> leadedGonggu=reviewService.selectAllMyGonggu(member.getUserId());
		
		ArrayList<Review> partiReview=new ArrayList<Review>();
		ArrayList<Review> leaderReview=new ArrayList<Review>();
		int count=0;
		for(int i=0;i<recieved.size();i++) {
			for(int j=0;j<leadedGonggu.size();j++) {
				if(recieved.get(i).getGongguNo()==leadedGonggu.get(j).getGongguNo()) {
					leaderReview.add(recieved.get(i));
					count=-1;
				}else {	count=i;}
			}
			if(count==i) {
				partiReview.add(recieved.get(i));
			}
		}
		
		model.addAttribute("partiReview", partiReview);
		model.addAttribute("leaderReview", leaderReview);
		
		int[] partiStar=new int[partiReview.size()];
		int[] leaderStar=new int[leaderReview.size()];
		
		for(int i=0;i<partiStar.length;i++) {
			partiStar[i]=partiReview.get(i).getRate();
		}
		for(int i=0;i<leaderStar.length;i++) {
			leaderStar[i]=leaderReview.get(i).getRate();
		}
		model.addAttribute("partiStar", partiStar.toString());
		model.addAttribute("leaderStar", leaderStar.toString());
		
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
		
		model.addAttribute("parti", parti);
		model.addAttribute("result", result);
		return "jsonView";
	}
}
