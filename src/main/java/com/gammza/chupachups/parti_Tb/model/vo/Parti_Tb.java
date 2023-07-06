package com.gammza.chupachups.parti_Tb.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Parti_Tb {
	private int gongguNo;
	private String partiMember;
	private int num;
	private Date regAt;
	private int status;
}
