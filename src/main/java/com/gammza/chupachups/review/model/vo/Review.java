package com.gammza.chupachups.review.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Review {
	private int reviewNo;
	private int gongguNo;
	private String reviewWriter;
	private String reviewContent;
	private String receiverId;
	private double rate;
	private String reviewDate;
	private String gongguName;
}

