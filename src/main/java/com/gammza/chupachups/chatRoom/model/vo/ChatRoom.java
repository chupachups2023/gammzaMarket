package com.gammza.chupachups.chatRoom.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor 
public class ChatRoom {
	private int roomNo;
	private int gonnguNo;
	private String roomOwner;
	private String createAt;
	private String lastChat;	
}
