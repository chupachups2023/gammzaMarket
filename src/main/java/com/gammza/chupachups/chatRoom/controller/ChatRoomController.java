package com.gammza.chupachups.chatRoom.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gammza.chupachups.chatRoom.model.service.ChatRoomService;
import com.gammza.chupachups.chatRoom.model.vo.ChatRoom;
import com.gammza.chupachups.common.model.vo.PageInfo;
import com.gammza.chupachups.common.template.Pagination;
import com.gammza.chupachups.gonggu.model.service.GongguService;
import com.gammza.chupachups.gonggu.model.vo.Gonggu;
import com.gammza.chupachups.location.controller.LocationController;
import com.gammza.chupachups.location.model.service.LocationService;
import com.gammza.chupachups.location.model.vo.Location;
import com.gammza.chupachups.member.model.vo.Member;


@Controller
public class ChatRoomController {
	@Autowired
	private GongguService gongguService;
	@Autowired
	private ChatRoomService chatRoomService;	
	@Autowired
	private LocationService locationService;
	@Autowired
	private LocationController locationController;
	
	@GetMapping("/chatRoom/myChatList.bo")
	public String chatRoomList(@RequestParam(defaultValue="1") int nowPage, @RequestParam(required = false) String roomOwner, HttpSession hs, Model model) {
		String id=((Member)hs.getAttribute("loginMember")).getUserId();
		int totalRecord = chatRoomService.selectTotalRecord();
		String leader = (String) hs.getAttribute("loginmember");
//		System.out.println("total : " + totalRecord);
		int limit = 50000;
		int offset = (nowPage -1 ) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		PageInfo pi = Pagination.getPageInfo(totalRecord, nowPage, limit, 3);
		List<ChatRoom> chatRoomList = chatRoomService.chatRoomList(rowBounds, id);
		for(int i=0;i<chatRoomList.size();i++) {
			int gongguNo=chatRoomList.get(i).getGongguNo();
			chatRoomList.get(i).setGongguName(gongguService.selectOneGonggu(gongguNo).getGongguName());
			chatRoomList.get(i).setPhoto1(gongguService.selectOneGonggu(gongguNo).getPhoto1());
		}
/*
		if(!chatRoomList.isEmpty()) {
		System.out.println("나옴");
		System.out.println(chatRoomList);
		}
		else {
		System.out.println("안나옴");
		System.out.println(chatRoomList);
		}
*/
		ArrayList<Gonggu> mainList = gongguService.selectMainList();
		for(int i=0;i<mainList.size();i++) {
			Location tempLocal=locationService.selectLocationByNo(mainList.get(i).getLocationNo());
			String locationName=locationController.SelectLocationName(tempLocal);
			mainList.get(i).setLocationName(locationName);
		}
		
		
		model.addAttribute("chatRoomList", chatRoomList);
		model.addAttribute("pi", pi);
		model.addAttribute("leader", leader);
		model.addAttribute("mainList", mainList);
		
		return "mypage/chatting";
	}
	
}
