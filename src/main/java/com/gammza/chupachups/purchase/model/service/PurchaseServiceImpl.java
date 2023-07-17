package com.gammza.chupachups.purchase.model.service;

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

}
