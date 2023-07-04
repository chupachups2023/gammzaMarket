package com.gammza.chupachups.likeList.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gammza.chupachups.common.model.vo.PageInfo;
import com.gammza.chupachups.common.template.Pagination;
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
		
		int totalRecord = likeListService.selectTotalRecord(userId);
		int limit = 10;
		int offset = (nowPage -1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		PageInfo pi = Pagination.getPageInfo(totalRecord, nowPage, limit, 5);
		
		List<Zzim> myLikelist = likeListService.selectLikeList(userId, rowBounds);
		model.addAttribute("myLikelist", myLikelist);
		model.addAttribute("pi", pi);
	}
	
	@PostMapping("/deleteZzim.do")
	public String deleteZzim(@RequestParam String[] delZzim) {
		for(int i=0; i<delZzim.length; i++) {
			int result = likeListService.deleteZzim(delZzim[i]);
		}
		return "redirect:/mypage/likeList.do";
	}
	
	public List<Zzim> selectZzim(int gongguNo) {
		return likeListService.selectZzim(gongguNo);
	}
}
