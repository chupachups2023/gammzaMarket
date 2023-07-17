package com.gammza.chupachups.purchase.model.service;

import com.gammza.chupachups.purchase.model.vo.PointPurRec;

public interface PurchaseService {

	int updatePoint(PointPurRec pointPR);

	int insertPointPurRec(PointPurRec pointPR);

	int selectPointOrderNum(String pointOrderNum);

}
