package com.project.nadaum.culture.review.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.nadaum.culture.review.model.vo.Review;
import com.project.nadaum.culture.show.model.dao.CultureDaoImpl;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class ReviewDaoImpl implements ReviewDao {

	@Autowired
	private SqlSessionTemplate session;

	@Override
	public List<Review> selectReviewList() {
		return session.selectList("review.selectReviewList");
	}

	@Override
	public Review selectOneReview(String code) {
		return session.selectOne("review.selectOneReview", code);
	}
	
}
