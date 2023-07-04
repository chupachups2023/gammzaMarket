package com.gammza.chupachups.chatRoom.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gammza.chupachups.chatRoom.model.dao.ChatRoomDao;
import com.gammza.chupachups.chatRoom.model.vo.ChatRoom;

@Service
public class ChatRoomServiceImpl implements ChatRoomService {

	@Autowired
	private ChatRoomDao chatRoomDao;
	
	@Override
	public List<ChatRoom> chatRoomList() {
		return chatRoomDao.chatRoomList();
	}

}
