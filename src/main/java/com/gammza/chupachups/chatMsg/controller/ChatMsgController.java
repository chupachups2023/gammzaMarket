package com.gammza.chupachups.chatMsg.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gammza.chupachups.chatMsg.model.service.ChatMsgService;
import com.gammza.chupachups.chatMsg.model.vo.ChatMsg;

@Controller
public class ChatMsgController {

	@Autowired
	private ChatMsgService chatMsgService;

	/*
	@ResponseBody
	@GetMapping(value="msg.do", produces="application/json; chatset=utf=8")
	public String selectChatMsg(String chatMsg) throws IOException {		
		List<ChatMsg> MsgList = chatMsgService.selectChatMsg();
		BufferedReader br = new BufferedReader(new InputStreamReader((InputStream) MsgList));
		
		String msgText = "";
		String line;
		while((line = br.readLine()) != null) {
			msgText += line;
		}
		return msgText;
		
	}
	
	*/
}
