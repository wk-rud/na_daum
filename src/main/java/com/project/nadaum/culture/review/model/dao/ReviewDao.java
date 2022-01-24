package com.project.nadaum.culture.review.model.dao;

import java.util.List;

import com.project.nadaum.culture.review.model.vo.Review;

public interface ReviewDao {

	List<Review> selectReviewList();

	Review selectOneReview(String code);

}
