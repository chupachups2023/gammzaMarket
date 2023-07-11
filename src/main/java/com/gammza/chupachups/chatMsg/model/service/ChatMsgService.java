package com.gammza.chupachups.chatMsg.model.service;

import java.util.List;

import com.gammza.chupachups.chatMsg.model.vo.ChatMsg;

public interface ChatMsgService {

	List<ChatMsg> selectChatMsg(String roomNo);

	int insertMsg(ChatMsg chatMsg);

}
