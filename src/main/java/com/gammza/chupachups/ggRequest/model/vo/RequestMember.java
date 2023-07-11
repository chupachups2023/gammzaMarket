package com.gammza.chupachups.ggRequest.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class RequestMember {
	private int requestNo;
	private String requestMember;
	private int localCode;
	private String latitude;	
	private String longitude;
	private String regAt;
}
