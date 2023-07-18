package com.gammza.chupachups.chatMsg.controller;


import java.util.List;

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

import com.gammza.chupachups.chatMsg.model.service.ChatMsgService;
import com.gammza.chupachups.chatMsg.model.vo.ChatMsg;

@Controller
@SessionAttributes({"MsgList"})
public class ChatMsgController {

	@Autowired
	private ChatMsgService chatMsgService;

	@GetMapping("/chatRoom/msgList.do")
	public String selectChatMsg(HttpServletRequest request, @RequestParam(required = false) String roomNo, ChatMsg chatMsg, Model model) {
		
		Object userId = request.getAttribute("userId");
		
		List<ChatMsg> MsgList = chatMsgService.selectChatMsg(roomNo);
		/* System.out.println("msgList : " + roomNo); */
		model.addAttribute("MsgList", MsgList);
		model.addAttribute("userId", userId);
		return "jsonView";
	}
	
	@PostMapping("/mypage/insertMsg.do")
	public String insertMsg(HttpServletRequest request, @RequestParam(required = false) ChatMsg chatMsg, @RequestParam(required = false) int roomNo, Model model) {
	    String chatContent = request.getParameter("chatContent");
	    String chatWriter = request.getParameter("chatWriter");
	    
	    ChatMsg chatMsg1 = new ChatMsg();
	    
	    chatMsg1.setChatContent(chatContent);
	    chatMsg1.setChatWriter(chatWriter);
	    chatMsg1.setRoomNo(roomNo);
	    chatMsgService.insertMsg(chatMsg1);
	    
	    model.addAttribute("chatWriter", chatWriter);
	    model.addAttribute("chatContent", chatContent);
	    model.addAttribute("chatMsg", chatMsg);
	    model.addAttribute("roomNo", roomNo);
	    System.out.println("chatMsg" + roomNo + "   :     chatContent" + chatContent + "         : chatWriter" + chatWriter);
	    return "redirect:/";
	}


}
