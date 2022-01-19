package com.project.nadaum.culture.movie.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.nadaum.culture.movie.model.vo.Movie;


@Repository
public class MovieDaoImpl implements MovieDao {

	@Autowired
	private SqlSessionTemplate session;

	@Override
	public List<Movie> selectMovieList() {
		return session.selectList("movie.selectMovieList");
	}

	@Override
	public Movie selectOneMovie(String code) {
		// TODO Auto-generated method stub
		return session.selectOne("movie.selectOneMovie", code);
	}

//	@Override
//	public List<Movie> selectMovieList(Map<String, Object> param) {
//		int offset = (int) param.get("offset");
//		int limit = (int) param.get("limit");
//		RowBounds rowBounds = new RowBounds(offset, limit);
//		return session.selectList("board.selectMovieList", null, rowBounds);
//	}
	
	
	@Override
	public int selectTotalContent() {
		return session.selectOne("movie.selectTotalContent");
	}

	@Override
	public Movie selectOneMovieCollection(String code) {
		return session.selectOne("movie.selectOneMovieCollection", code);
	}


	
}
