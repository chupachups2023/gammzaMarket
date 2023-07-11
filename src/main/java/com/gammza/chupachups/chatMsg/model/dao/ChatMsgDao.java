package com.gammza.chupachups.chatMsg.model.dao;

import java.util.List;

import com.gammza.chupachups.chatMsg.model.vo.ChatMsg;

public interface ChatMsgDao {
	
	 List<ChatMsg> selectChatMsg(String roomNo);

	int insertMsg(ChatMsg chatMsg);
	 
}
