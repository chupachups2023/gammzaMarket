package com.gammza.chupachups.gonggu.model.vo;

import java.util.Date;

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
    private int num;
    private Date regAt;
    private int locationCode;
}
