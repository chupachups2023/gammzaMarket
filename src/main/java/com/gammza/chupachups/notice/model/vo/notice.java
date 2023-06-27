package com.gammza.chupachups.notice.model.vo;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

public class notice {
	
	@Getter
	@Setter
	@NoArgsConstructor
	@AllArgsConstructor
	@ToString
	
	private int noticeNo;
	private String noticeWriter;
	private String noticeTitle;
	private String noticeContent;
	private String count;
	private String noticeCreate;
	
}
