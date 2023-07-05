package com.gammza.chupachups.chatRoom.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor 
@ToString
public class Parti_Tb {
	private int gongguNo;
	private String partiMember;
	private int num; //구매 수량
	private String regAt;
	private String locationCode;
}
