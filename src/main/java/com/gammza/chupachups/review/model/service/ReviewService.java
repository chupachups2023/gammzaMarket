package com.gammza.chupachups.review.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.gammza.chupachups.gonggu.model.vo.Gonggu;
import com.gammza.chupachups.review.model.vo.Review;

public interface ReviewService {

	ArrayList<Review> selectRecievedReview(String userId);

	ArrayList<Review> selectWroteReview(String userId);

	ArrayList<Gonggu> selectAllMyGonggu(String userId);

	Review selectOneReview(int reviewNo);

	int selectWroteReviewCheck(HashMap<String, String> map);

	int insertReview(Review review);

	int updateTemperature(HashMap<String, String> updateTemp);
}
