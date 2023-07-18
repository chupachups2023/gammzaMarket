package com.gammza.chupachups.purchase.model.dao;


import java.util.List;

import org.apache.ibatis.session.RowBounds;

import com.gammza.chupachups.purchase.model.vo.PointPurRec;

public interface PurchaseDao {

	int updatePoint(PointPurRec pointPR);

	int insertPointPurRec(PointPurRec pointPR);

	int selectPointOrderNum(String pointOrderNum);

	List<PointPurRec> selectPaymentRecord(String userId, RowBounds rowBounds);

	List<PointPurRec> selectPaymentRecord_Ad(RowBounds rowBounds);

	int selectTotalRecord();

	int selectTotalRecord_M(String userId);

}
