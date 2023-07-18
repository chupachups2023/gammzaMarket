package com.gammza.chupachups.chatRoom.model.service;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gammza.chupachups.chatRoom.model.dao.ChatRoomDao;
import com.gammza.chupachups.chatRoom.model.vo.ChatRoom;
import com.gammza.chupachups.gonggu.model.vo.Gonggu;

@Service
public class ChatRoomServiceImpl implements ChatRoomService {

	@Autowired
	private ChatRoomDao chatRoomDao;
	
	@Override
	public List<ChatRoom> chatRoomList(RowBounds rowBounds, String roomOwner) {
		return chatRoomDao.chatRoomList(rowBounds, roomOwner);
	}

	@Override
	public int selectTotalRecord() {
		return chatRoomDao.selectTotalRecord();
	}

	@Override
	public int insertChatRoom(Gonggu newGonggu ) {
		return chatRoomDao.insertChatRoom(newGonggu);
	}

	@Override
	public int updateSendDate(int gongguNo) {
		return chatRoomDao.updateSendDate(gongguNo);
	}

}
