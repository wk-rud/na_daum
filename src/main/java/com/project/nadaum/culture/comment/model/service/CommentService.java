package com.project.nadaum.culture.comment.model.service;

import java.util.List;

import com.project.nadaum.culture.comment.model.vo.Comment;

public interface CommentService {

	List<Comment> selectCultureCommentList(String apiCode);

}
