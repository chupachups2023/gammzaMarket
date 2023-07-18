package com.gammza.chupachups.chatRoom.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor 
@ToString
public class ChatRoom {
	private int roomNo;
	private int gongguNo;
	private String roomOwner;
	private String createAt;
	private String lastChat;
	private String gongguName;
	private String photo1;
}
