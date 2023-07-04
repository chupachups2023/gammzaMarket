package com.gammza.chupachups.chatRoom.model.service;

import java.util.List;

import org.apache.ibatis.session.RowBounds;

import com.gammza.chupachups.chatRoom.model.vo.ChatRoom;

public interface ChatRoomService {

	List<ChatRoom> chatRoomList(RowBounds rowBounds);

	int selectTotalRecord();

}
