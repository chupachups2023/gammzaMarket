package com.gammza.chupachups.chatRoom.model.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;

import com.gammza.chupachups.chatRoom.model.vo.ChatRoom;
import com.gammza.chupachups.gonggu.model.vo.Gonggu;

public interface ChatRoomDao {

	List<ChatRoom> chatRoomList(RowBounds rowBounds, String roomOwner);

	int selectTotalRecord();

	int insertChatRoom(Gonggu newGonggu);

	int updateSendDate(int gongguNo);

}


