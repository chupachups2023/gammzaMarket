package com.gammza.chupachups.likeList.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Zzim {
	private int zzimNo;
	private String zzimMember;
	private int gongguNo;
	private Date createAt;
	
	private String gongguName;
	private int price;
	private String photo1;
	private String locationName;
}
