package com.project.nadaum.culture.comment.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.nadaum.culture.comment.model.service.CommentService;
import com.project.nadaum.culture.comment.model.vo.Comment;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/culture")
public class CommentController {
	
	@Autowired
	private CommentService commentService;
	
	
	@GetMapping("/commentList")
	public void CultureCommentList(@RequestParam String apiCode, Model model) {
		
		log.debug("apiCode = {}", apiCode);
		List<Comment> commentList = commentService.selectCultureCommentList(apiCode);
		log.debug("commentList = {}", commentList);
		model.addAttribute("commentList", commentList);
	}
//	@PostMapping("/comment")
//	public Map<String, Object> insertCultureComment(@RequestBody Comment comment) {
//		log.debug("comment = {}", comment);
//		int result = commentService.insertCultureComment(comment);
//		
//		Map<String, Object> map = new HashMap<>();
//		
//		map.put("msg", "댓글 등록성공!");
//		map.put("result", result);
//		return map;
//	}
}
