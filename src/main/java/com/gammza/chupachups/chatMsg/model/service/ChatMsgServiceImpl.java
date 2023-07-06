package com.gammza.chupachups.chatMsg.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gammza.chupachups.chatMsg.model.dao.ChatMsgDao;
import com.gammza.chupachups.chatMsg.model.vo.ChatMsg;

@Service
public class ChatMsgServiceImpl implements ChatMsgService {
	
	@Autowired
	private ChatMsgDao chatMsgDao;
/*
	@Override
	public List<ChatMsg> selectChatMsg() {
		return chatMsgDao.selectChatMsg();
	}
	
	*/
}
