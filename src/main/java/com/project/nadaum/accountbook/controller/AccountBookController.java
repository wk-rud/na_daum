package com.project.nadaum.accountbook.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

	
@Slf4j
@Controller
@RequestMapping("/accountbook")
public class AccountBookController {
	
	@GetMapping("/accountbook.do")
	public void accountbook() {}
	}


