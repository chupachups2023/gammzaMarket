package com.gammza.chupachups.chatMsg.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gammza.chupachups.chatMsg.model.dao.ChatMsgDao;

@Service
public class ChatMsgServiceImpl implements ChatMsgService {
	
	@Autowired
	private ChatMsgDao chatMsgDao;
}
