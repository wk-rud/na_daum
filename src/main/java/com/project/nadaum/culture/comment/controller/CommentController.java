package com.project.nadaum.culture.comment.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.nadaum.culture.comment.model.service.CommentService;
import com.project.nadaum.culture.comment.model.vo.Comment;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class CommentController {
	
	@Autowired
	private CommentService commentService;
	
	@GetMapping("/culture/commentList.do")
	public void CultureCommentList(@RequestParam String apiCode, Model model) {
		List<Comment> commentList = commentService.selectCultureCommentList(apiCode);
		log.debug("cComment = {}", commentList);
		model.addAttribute("commentList", commentList);
	}
	
	
}
