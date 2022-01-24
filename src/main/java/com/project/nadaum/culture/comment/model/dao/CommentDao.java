package com.project.nadaum.culture.comment.model.dao;

import java.util.List;

import com.project.nadaum.culture.comment.model.vo.Comment;

public interface CommentDao {

	List<Comment> selectCultureCommentList(String apiCode);

}
