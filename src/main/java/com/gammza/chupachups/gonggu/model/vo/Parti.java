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
	
	//----DB에는 없는데 필요에 의해 추가
	private String userId;
	private double temperature;
	private String gongguName;
	
}
