package com.project.nadaum.audiobook.controller;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.nadaum.audiobook.model.service.AudioBookService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class AudioBookController {

	@Autowired
	private AudioBookService audioBookService;
	
	//사용자가 크롤링할 url을 post나 get으로 받아서 html요소를 받아오기
	//public String urlGetter(@RequestBody UrlParser url) {}
	
//	@GetMapping("/parser/parsedata")
//	public String urlGetter() {
//		log.info("/parser/parsedata가 호출됨");
//		try {		
//			String url= "https://www.welaaa.com/audio/list?ccode=058";
//			Document doc =  Jsoup.connect(url).get();
//			String title = doc.title();
//			 		
//			System.out.println(doc.html());					
//		} catch (IOException e) {
//			log.error(e.getMessage(), e);
//		}
//		
//		return "audiobook/api_test";
//	}
	
	
	
}
