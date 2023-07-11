package com.gammza.chupachups.request.model.vo;

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
	private int price;
	private int categoryNo;
	private String photo1;
	private String photo2;
	private String photo3;
	private int num;
}
 