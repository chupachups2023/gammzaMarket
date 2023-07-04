package com.gammza.chupachups.chatRoom.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.gammza.chupachups.chatRoom.model.service.ChatRoomService;
import com.gammza.chupachups.chatRoom.model.vo.ChatRoom;

@Controller
public class ChatRoomController {

	@Autowired
	private ChatRoomService chatRoomService;
	
	@GetMapping("/myChatList.bo")
	public String chatRoomList(ChatRoom chatRoom, Model model) {
		List<ChatRoom> chatRoomList = chatRoomService.chatRoomList();
		model.addAttribute("chatList", chatRoomList);
		return "mypage/chatList";
	}
	
}
