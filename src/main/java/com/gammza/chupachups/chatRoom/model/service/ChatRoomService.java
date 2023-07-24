package com.gammza.chupachups.chatRoom.model.service;

import java.util.List;

import org.apache.ibatis.session.RowBounds;

import com.gammza.chupachups.chatRoom.model.vo.ChatRoom;
import com.gammza.chupachups.gonggu.model.vo.Gonggu;

public interface ChatRoomService {

	//List<ChatRoom> chatRoomList(RowBounds rowBounds);
	List<ChatRoom> chatRoomList(RowBounds rowBounds, String roomOwner);

	int selectTotalRecord();

	int insertChatRoom(Gonggu newGonggu);

	int updateSendDate(int gongguNo);

}
