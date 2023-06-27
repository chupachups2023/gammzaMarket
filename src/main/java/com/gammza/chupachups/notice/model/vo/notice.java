package com.gammza.chupachups.notice.model.vo;

import java.sql.Date;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.Setter;

@Data
@NoArgsConstructor
@AllArgsConstructor 
public class notice {
	@NonNull
	private int noticeNo;
	@NonNull
	private String noticeWriter;
	@NonNull
	private String noticeTitle;
	@NonNull
	private String noticeContent;
	private String count;
	private String noticeCreate;
	
}
