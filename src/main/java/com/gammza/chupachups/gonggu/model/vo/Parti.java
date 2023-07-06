package com.gammza.chupachups.gonggu.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class Parti {
	private int gongguNo;
	private String partiMember;
	private int num; //구매수량
	private String regAt;
	private int status;
	
}
