package com.gammza.chupachups.likeList.controller;

import java.util.HashMap;
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
import org.springframework.web.bind.annotation.ResponseBody;

import com.gammza.chupachups.common.model.vo.PageInfo;
import com.gammza.chupachups.common.template.Pagination;
import com.gammza.chupachups.gonggu.model.service.GongguService;
import com.gammza.chupachups.likeList.model.service.LikeListService;
import com.gammza.chupachups.likeList.model.vo.Zzim;
import com.gammza.chupachups.location.controller.LocationController;
import com.gammza.chupachups.location.model.vo.Location;
import com.gammza.chupachups.member.model.vo.Member;

@Controller
@RequestMapping("/mypage")
public class LikeListController {
	@Autowired
	private LikeListService likeListService;
	@Autowired
	private GongguService gongguService;
	@Autowired
	private LocationController locationController;
	
	@GetMapping("/likeList.do")
	public void likeList(@RequestParam(defaultValue="1") int nowPage, Model model, HttpSession session) {
		Member loginMember = (Member) session.getAttribute("loginMember");
		String userId = loginMember.getUserId();
		
		int totalRecord = likeListService.selectTotalRecord(userId);
		int limit = 9;
		int offset = (nowPage -1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		PageInfo pi = Pagination.getPageInfo(totalRecord, nowPage, limit, 5);
		
		List<Zzim> myLikelist = likeListService.selectLikeList(userId, rowBounds);
		for(int i=0;i<myLikelist.size();i++) {
			int locationNo=gongguService.selectOneGonggu(myLikelist.get(i).getGongguNo()).getLocationNo();
			Location likeLocation=locationController.selectLocationByNo(locationNo);
			String locationName=locationController.SelectLocationName(likeLocation);
			myLikelist.get(i).setLocationName(locationName);
		}
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

	public Zzim selectMyZzim(int gongguNo, String userId) {
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("gongguNo", String.valueOf(gongguNo));
		map.put("userId", userId);
		
		return likeListService.selectMyZzim(map);
	}
	
	@ResponseBody
	@GetMapping("/addZzim.zz")
	public int addZzim(@RequestParam int gongguNo, HttpSession session, Model model) {
		Member loginMember=(Member)session.getAttribute("loginMember");
		HashMap<String,String> map=new HashMap<String,String>();
		map.put("gongguNo", String.valueOf(gongguNo));
		map.put("userId", loginMember.getUserId());
		likeListService.insertLikeList(map);
		int zzimNo=likeListService.selectZzimNo();
		Zzim zzim= new Zzim();
		zzim.setGongguNo(gongguNo);
		zzim.setZzimMember(loginMember.getUserId());
		zzim.setZzimNo(zzimNo);
		
		model.addAttribute("zzim", zzim);
		
		return zzimNo;
	}
	
	@ResponseBody
	@GetMapping("/deleteZzim.zz")
	public String deleteZzim(@RequestParam int zzimNo, Model model) {
		likeListService.deleteZzim(String.valueOf(zzimNo));
		model.addAttribute("zzim", null);
		return "성공";
	}
}
