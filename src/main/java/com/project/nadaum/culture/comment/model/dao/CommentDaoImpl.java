package com.project.nadaum.culture.comment.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.nadaum.culture.comment.model.vo.Comment;
import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class CommentDaoImpl implements CommentDao {

	@Autowired
	private SqlSessionTemplate session;

	
	@Override
	public List<Comment> selectCultureCommentList(String apiCode) {
		return session.selectOne("comment.selectCultureCommentList", apiCode);
	}

}
