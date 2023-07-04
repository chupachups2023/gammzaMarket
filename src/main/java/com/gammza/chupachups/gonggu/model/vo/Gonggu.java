package com.gammza.chupachups.gonggu.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor 
@ToString
public class Gonggu {
	private int gongguNo;
	private String gongguName;
	private String gongguWriter;
	private int price;
	private int type;
	private int num;
	private int category;
	private String content;
	private String photo1;
	private String photo2;
	private String photo3;
	private String link;
	private String createAt;
	private String sendTime;
	private String openTime;
	private String endTime;
	private String latitude;
	private String longitude;
	private int count;
	private int status;
	private String updateAt;
	private String pullupAt;
	private int locationNo;
	private String locationName;
	private int endStatus;
}
