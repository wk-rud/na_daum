package com.project.nadaum.culture.review.model.service;

import java.util.List;

import com.project.nadaum.culture.review.model.vo.Review;

public interface ReviewService {

	List<Review> selectReviewList();

	Review selectOneReview(String code);

}
