package com.gammza.chupachups.report.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor 
public class Report {
	private int reportNo;
	private String reportWriter;
	private String reportContent;
	private int gongguNo;
	private Date createAt;
	
}