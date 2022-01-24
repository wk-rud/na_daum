package com.project.nadaum.culture.comment.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.nadaum.culture.comment.model.dao.CommentDao;
import com.project.nadaum.culture.comment.model.vo.Comment;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class CommentServiceImpl implements CommentService {

	@Autowired
	private CommentDao commentDao;
	
	@Override 
	public List<Comment> selectCultureCommentList(String apiCode) {
		return commentDao.selectCultureCommentList(apiCode);
	}
}
