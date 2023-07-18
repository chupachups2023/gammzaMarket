package com.gammza.chupachups.purchase.model.service;

import java.util.List;

import com.gammza.chupachups.purchase.model.vo.PointPurRec;

public interface PurchaseService {

	int updatePoint(PointPurRec pointPR);

	int insertPointPurRec(PointPurRec pointPR);

	int selectPointOrderNum(String pointOrderNum);

	List<PointPurRec> selectPaymentRecord(String userId);

}
