package com.gammza.chupachups.ggRequest.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Request {
	private int requestNo;
	private String requestWriter;
	private String requestName;
	private String price;
	private int categoryNo;
	private String photo1;
	private String photo2;
	private String photo3;
	private int num;
	private int reqStatus;
	private int status;
	private String latitude;
	private String longitude;
	private String link;
	private int count;
	private String recentDate;
	
}
