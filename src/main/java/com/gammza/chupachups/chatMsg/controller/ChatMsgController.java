package com.gammza.chupachups.chatMsg.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.gammza.chupachups.chatMsg.model.service.ChatMsgService;
import com.gammza.chupachups.chatMsg.model.vo.ChatMsg;

@Controller
public class ChatMsgController {

	@Autowired
	private ChatMsgService chatMsgService;

	@GetMapping("/chatMsg/msgList.do")
	public void selectChatMsg(HttpServletRequest request, String[] param, int num, Model model) {
		ChatMsg chatMsg = new ChatMsg();
		List<ChatMsg> MsgList = chatMsgService.selectChatMsg(chatMsg);
		model.addAttribute("MsgList", MsgList);	
	}
	
}
