package com.gammza.chupachups.purchase.model.service;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gammza.chupachups.purchase.model.dao.PurchaseDao;
import com.gammza.chupachups.purchase.model.vo.PointPurRec;

@Service
public class PurchaseServiceImpl implements PurchaseService {

	@Autowired
	private PurchaseDao purchaseDao;
	
	@Override
	public int updatePoint(PointPurRec pointPR) {
		return purchaseDao.updatePoint(pointPR);
	}

	@Override
	public int insertPointPurRec(PointPurRec pointPR) {
		return purchaseDao.insertPointPurRec(pointPR);
	}

	@Override
	public int selectPointOrderNum(String pointOrderNum) {
		return purchaseDao.selectPointOrderNum(pointOrderNum);
	}

	@Override
	public List<PointPurRec> selectPaymentRecord(String userId, RowBounds rowBounds) {
		return purchaseDao.selectPaymentRecord(userId, rowBounds);
	}

	@Override
	public List<PointPurRec> selectPaymentRecord_Ad(RowBounds rowBounds) {
		return purchaseDao.selectPaymentRecord_Ad(rowBounds);
	}

	@Override
	public int selectTotalRecord() {
		return purchaseDao.selectTotalRecord();
	}

	@Override
	public int selectTotalRecord_M(String userId) {
		return purchaseDao.selectTotalRecord_M(userId);
	}

}
