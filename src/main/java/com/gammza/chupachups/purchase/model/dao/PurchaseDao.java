package com.gammza.chupachups.purchase.model.dao;

import org.apache.ibatis.annotations.Mapper;

import com.gammza.chupachups.purchase.model.vo.PointPurRec;

@Mapper
public interface PurchaseDao {

	int updatePoint(PointPurRec pointPR);

	int insertPointPurRec(PointPurRec pointPR);

}
