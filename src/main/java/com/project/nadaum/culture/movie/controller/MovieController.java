package com.project.nadaum.culture.movie.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import com.project.nadaum.culture.movie.model.service.MovieService;
import com.project.nadaum.culture.movie.model.vo.Movie;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/movie")
public class MovieController {

//	private final RestTemplate restTemplate = new RestTemplate();
//	private final String CLIENT_ID = "WH5aVPOr1A2Izr2MHbez";
//	private final String CLIENT_SECRET = "pMaufGCz0_";
//	private final String OpenNaverMovieUrl_getMovies = "https://openapi.naver.com/v1/search/movie.json?query={keyword}";

	
	@Autowired
	private MovieService movieService;

	@GetMapping("/movieList.do")
	public void MovieList(Model model) {
		List<Movie> list = movieService.selectMovieList();
		model.addAttribute("list", list);
	}

	@GetMapping("/movieDetail.do")
	public void movieDetail(@RequestParam String code, Model model) {

		Movie movie = movieService.selectOneMovie(code);
//		Movie movie = movieService.selectOneMovieCollection(code);
		log.debug("movie = {}", movie);
		model.addAttribute("movie", movie);
	}


	private String get(String apiURL, Map<String, String> requestHeaders) {
		// TODO Auto-generated method stub
		return null;
	}

	//
//	@GetMapping("/movie.do")
//	public void Movie(Model model) {
//		List<Movie> list = movieService.selectMovieList();
//		model.addAttribute("list", list);
//	}

	@GetMapping("/moviesc.do")
	public String MovieMain() {
		return "/movie/moviesc";
	}

}

