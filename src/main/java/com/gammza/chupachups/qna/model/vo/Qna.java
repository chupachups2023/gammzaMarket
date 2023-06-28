package com.gammza.chupachups.qna.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Qna {
	private int qnaNo;
	private int qnaCategory;
	private String qnaWriter;
	private String qnaTitle;
	private String qnaContent; 
	private Date createAt;
	private int ref;
	private int depth;
}