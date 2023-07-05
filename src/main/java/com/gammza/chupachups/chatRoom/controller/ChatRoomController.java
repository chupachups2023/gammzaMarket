package com.gammza.chupachups.chatRoom.controller;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gammza.chupachups.chatRoom.model.service.ChatRoomService;
import com.gammza.chupachups.chatRoom.model.vo.ChatRoom;
import com.gammza.chupachups.common.model.vo.PageInfo;
import com.gammza.chupachups.common.template.Pagination;


@Controller
public class ChatRoomController {

	@Autowired
	private ChatRoomService chatRoomService;
	
	@GetMapping("/chatRoom/myChatList.bo")
	public String chatRoomList(@RequestParam(defaultValue="1") int nowPage, @RequestParam(required = false) String roomOwner, Model model) {
		int totalRecord = chatRoomService.selectTotalRecord();
		System.out.println("total : " + totalRecord);
		int limit = 50000;
		int offset = (nowPage -1 ) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		PageInfo pi = Pagination.getPageInfo(totalRecord, nowPage, limit, 3);
		List<ChatRoom> chatRoomList = chatRoomService.chatRoomList(rowBounds, roomOwner);
		if(!chatRoomList.isEmpty()) {
		System.out.println("나옴");
		System.out.println(chatRoomList);
		}
		else {
		System.out.println("안나옴");
		System.out.println(chatRoomList);
		}
		model.addAttribute("chatRoomList", chatRoomList);
		model.addAttribute("pi", pi);
		
		return "mypage/chatting";
	}
	
}
