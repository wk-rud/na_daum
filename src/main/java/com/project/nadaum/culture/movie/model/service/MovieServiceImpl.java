package com.project.nadaum.culture.movie.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.nadaum.culture.movie.model.dao.MovieDao;
import com.project.nadaum.culture.movie.model.vo.Movie;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
//@Transactional(rollbackFor = Exception.class)
public class MovieServiceImpl implements MovieService {

	@Autowired
	private MovieDao movieDao;
	


	@Override
	public List<Movie> selectMovieList() {
		// TODO Auto-generated method stub
		return movieDao.selectMovieList();
	}

	@Override
	public Movie selectOneMovie(String code) {
		// TODO Auto-generated method stub
		return movieDao.selectOneMovie(code);
	}

//	@Override
//	public List<Movie> selectMovieList(Map<String, Object> param) {
//		return movieDao.selectMovieList(param);
//	}
	
	@Override
	public int selectTotalContent() {
		return movieDao.selectTotalContent();
	}
	
	@Override
	public Movie selectOneMovieCollection(String code) {		
		return movieDao.selectOneMovieCollection(code);
	}
}