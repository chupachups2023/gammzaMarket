package com.gammza.chupachups.purchase.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PointPurRec {
	private int pointNo;
	private String pointOrderNum;
    private String userId;
	private String pointName;
	private int pointPrice;
	private String paymentMethod;
    private Date purchasedTime;
}
