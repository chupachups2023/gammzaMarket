package com.gammza.chupachups.chatMsg.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor 
public class ChatMsg {
	private int msgNo;
	private int roomNo;
	private String chatWriter;
	private String chatContent;
	private String sendDate;
}
