package com.project.nadaum.culture.review.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.nadaum.culture.review.model.service.ReviewService;
import com.project.nadaum.culture.review.model.vo.Review;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/review")
public class ReviewController {

	@Autowired
	private ReviewService reviewService;
	@GetMapping("/reviewBoardList.do")
	public void reviewBoardList(Model model) {
		List<Review> list = reviewService.selectReviewList();
		model.addAttribute("list", list);
		log.debug("list={}", list);
	}
	
	@GetMapping("/reviewDetail.do")
	public void cultureDetail(@RequestParam String code, Model model) {
		
		Review review = reviewService.selectOneReview(code);
		log.debug("review = {}", review);
		model.addAttribute("review", review);
	}
	
}
