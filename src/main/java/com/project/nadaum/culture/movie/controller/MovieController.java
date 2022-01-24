package com.project.nadaum.culture.movie.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.JsonObject;
import com.project.nadaum.culture.movie.model.service.MovieService;
import com.project.nadaum.culture.movie.model.vo.Movie;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/movie")
public class MovieController {
	
	//네이버 api 키값
//	private final String CLIENT_ID = "WH5aVPOr1A2Izr2MHbez";
//	private final String CLIENT_SECRET = "pMaufGCz0_";
//	private final String OpenNaverMovieUrl_getMovies = "https://openapi.naver.com/v1/search/movie.json?query={keyword}";

	@Autowired
	private MovieService movieService;
		
	
//	@GetMapping("/movieList.do")
//	public void MovieList(Model model) {
//		List<Movie> list = movieService.selectMovieList();
//		model.addAttribute("list", list);
//	}

//	@GetMapping("/movieDetail.do?code={movieCd}")
//	public void movieDetail(@PathVariable String movieCd) {
//		
//		String url = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.xml"
//				+ "?key=2707c14a032dacdea9d8b690c3f99d19" 
//				+ "&movieCd=" + movieCd;
//		
//		Map<String, Object> map = new HashMap<>();	
//	}





}

