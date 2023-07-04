package com.gammza.chupachups.chatRoom.model.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;

import com.gammza.chupachups.chatRoom.model.vo.ChatRoom;

public interface ChatRoomDao {

	List<ChatRoom> chatRoomList(RowBounds rowBounds);

	int selectTotalRecord();

}
