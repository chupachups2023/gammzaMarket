package com.gammza.chupachups.chatMsg.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.gammza.chupachups.chatMsg.model.service.ChatMsgService;

@Controller
public class ChatMsgController {

	@Autowired
	private ChatMsgService chatMsgService;
}
