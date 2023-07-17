package com.gammza.chupachups.chatRoom.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.gammza.chupachups.chatRoom.model.service.ChatRoomService;
import com.gammza.chupachups.chatRoom.model.vo.ChatRoom;
import com.gammza.chupachups.common.model.vo.PageInfo;
import com.gammza.chupachups.common.template.Pagination;
import com.gammza.chupachups.gonggu.model.service.GongguService;
import com.gammza.chupachups.gonggu.model.service.PartiService;
import com.gammza.chupachups.gonggu.model.vo.Gonggu;
import com.gammza.chupachups.gonggu.model.vo.Parti;
import com.gammza.chupachups.location.controller.LocationController;
import com.gammza.chupachups.location.model.service.LocationService;
import com.gammza.chupachups.location.model.vo.Location;


@Controller
@SessionAttributes({"chatRoomList"})
public class ChatRoomController {
	@Autowired
	private GongguService gongguService;
	@Autowired
	private ChatRoomService chatRoomService;	
	@Autowired
	private LocationService locationService;
	@Autowired
	private LocationController locationController;
	@Autowired
	private PartiService partiService;
	
	@GetMapping("/chatRoom/myChatList.bo")
	public String chatRoomList(@RequestParam(defaultValue="1") int nowPage, @RequestParam(required = false) String roomOwner, HttpSession hs, Model model) {
		int totalRecord = chatRoomService.selectTotalRecord();
		String leader = (String) hs.getAttribute("loginmember");
		System.out.println("total : " + totalRecord);
		int limit = 50000;
		int offset = (nowPage -1 ) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		PageInfo pi = Pagination.getPageInfo(totalRecord, nowPage, limit, 3);
		List<ChatRoom> chatRoomList = chatRoomService.chatRoomList(rowBounds, roomOwner);
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
		HashMap<String, String> map=new HashMap<String,String>();
		
		Parti parti=partiService.selectOneParti(map);
		
		model.addAttribute("chatRoomList", chatRoomList);
		model.addAttribute("pi", pi);
		model.addAttribute("leader", leader);
		model.addAttribute("mainList", mainList);
		model.addAttribute("parti", parti);
		
		return "mypage/chatting";
	}
	
}
