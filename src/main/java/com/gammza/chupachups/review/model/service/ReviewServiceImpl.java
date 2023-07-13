package com.gammza.chupachups.review.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gammza.chupachups.gonggu.model.vo.Gonggu;
import com.gammza.chupachups.review.model.dao.ReviewDao;
import com.gammza.chupachups.review.model.vo.Review;

@Service
public class ReviewServiceImpl implements ReviewService {
	
	@Autowired
	private ReviewDao reviewDao;

	@Override
	public ArrayList<Review> selectRecievedReview(String userId) {
		return reviewDao.selectRecievedReview(userId);
	}

	@Override
	public ArrayList<Review> selectWroteReview(String userId) {
		return reviewDao.selectWroteReview(userId);
	}

	@Override
	public ArrayList<Gonggu> selectAllMyGonggu(String userId) {
		return reviewDao.selectAllMyGonggu(userId);
	}

	@Override
	public Review selectOneReview(int reviewNo) {
		return reviewDao.selectOneReview(reviewNo);
	}

}
