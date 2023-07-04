package com.gammza.chupachups.likeList.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gammza.chupachups.likeList.model.service.LikeListService;
import com.gammza.chupachups.likeList.model.vo.Zzim;
import com.gammza.chupachups.member.model.vo.Member;

@Controller
@RequestMapping("/mypage")
public class LikeListController {
	@Autowired
	private LikeListService likeListService;
	
	@GetMapping("/likeList.do")
	public void likeList(@RequestParam(defaultValue="1") int nowPage, Model model, HttpSession session) {
		Member loginMember = (Member) session.getAttribute("loginMember");
		String userId = loginMember.getUserId();
		
//		int totalRecord = likeListService.selectTotalRecord(userId);
//		int limit = 10;
//		int offset = (nowPage -1) * limit;
//		RowBounds rowBounds = new RowBounds(offset, limit);
//		
//		PageInfo pi = Pagination.getPageInfo(totalRecord, nowPage, limit, 5);
		
		List<Zzim> myLikelist = likeListService.selectLikeList(userId);
		model.addAttribute("myLikelist", myLikelist);
		
	}
	
	public List<Zzim> selectZzim(int gongguNo) {
		return likeListService.selectZzim(gongguNo);
	}
}
