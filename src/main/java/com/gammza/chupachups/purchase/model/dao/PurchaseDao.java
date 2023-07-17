package com.gammza.chupachups.purchase.model.dao;


import com.gammza.chupachups.purchase.model.vo.PointPurRec;

public interface PurchaseDao {

	int updatePoint(PointPurRec pointPR);

	int insertPointPurRec(PointPurRec pointPR);

	int selectPointOrderNum(String pointOrderNum);

}
