package com.project.nadaum.culture.review.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.nadaum.culture.review.model.service.ReviewService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/review")
public class ReviewController {

	@Autowired
	private ReviewService reviewService;
}
