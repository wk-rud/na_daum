package com.project.nadaum.culture.comment.model.service;

import java.util.List;
import java.util.Map;

import com.project.nadaum.culture.comment.model.vo.Comment;

public interface CommentService {

	List<Comment> selectCultureCommentList(String apiCode);

	int insertCultureComment(Map<String, Object> map);

	int deleteCultureComment(String code);

	int updateCultureComment(Map<String, Object> map);

}
