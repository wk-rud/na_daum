package com.project.nadaum.culture.movie.model.dao;

import java.util.List;
import java.util.Map;

import com.project.nadaum.culture.movie.model.vo.*;

public interface MovieDao {

	List<Movie> selectMovieList();

	Movie selectOneMovie(String code);

//	List<Movie> selectMovieList(Map<String, Object> param);
	
	int selectTotalContent();

	Movie selectOneMovieCollection(String code);
}
