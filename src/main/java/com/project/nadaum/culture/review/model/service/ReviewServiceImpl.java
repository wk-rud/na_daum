package com.project.nadaum.culture.review.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.nadaum.culture.review.model.dao.ReviewDao;
import com.project.nadaum.culture.review.model.vo.Review;
import com.project.nadaum.culture.show.model.service.CultureServiceImpl;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class ReviewServiceImpl implements ReviewService {

	@Autowired
	private ReviewDao reviewDao;

	@Override
	public List<Review> selectReviewList() {
		return reviewDao.selectReviewList();
	}

	@Override
	public Review selectOneReview(String code) {
		Review review = reviewDao.selectOneReview(code);
		return review;
	}
}
