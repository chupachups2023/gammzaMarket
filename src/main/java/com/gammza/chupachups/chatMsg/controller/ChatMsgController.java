package com.gammza.chupachups.chatMsg.controller;


import java.security.Provider.Service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;


import com.gammza.chupachups.chatMsg.model.service.ChatMsgService;
import com.gammza.chupachups.chatMsg.model.vo.ChatMsg;

@Controller
public class ChatMsgController {

	@Autowired
	private ChatMsgService chatMsgService;

	@GetMapping("/chatRoom/msgList.do")
	public String selectChatMsg(HttpServletRequest request, @RequestParam(required = false) String roomNo, ChatMsg chatMsg, Model model) {
		List<ChatMsg> MsgList = chatMsgService.selectChatMsg(roomNo);
		System.out.println("msgList : " + MsgList);
		model.addAttribute("MsgList", MsgList);
		return "jsonView";
	}
	
	@PostMapping("/mypage/insertMsg.do")
	public String insertMsg(HttpServletRequest request, HttpSession session, Model model) {
	    String chatContent = request.getParameter("chatContent");
	    String chatWriter = (String) session.getAttribute("loginMember.userId");

	    ChatMsg chatMsg = new ChatMsg();
	    chatMsg.setChatContent(chatContent);
	    chatMsg.setChatWriter(chatWriter);

	    chatMsgService.insertMsg(chatMsg);
	    System.out.println("chatMsg" + chatMsg);
	    return "mypage/chatting";
	}


}
