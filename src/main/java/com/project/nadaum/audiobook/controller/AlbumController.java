package com.project.nadaum.audiobook.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.nadaum.audiobook.model.service.AlbumService;
import com.project.nadaum.audiobook.model.vo.Album;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/audiobook")
public class AlbumController {

	@Autowired
	private AlbumService albumService;
	
	@GetMapping("/")
	@RequestMapping
	public String audiobookMain(Model model) {
		return "audiobook/main";
	}
	
	@GetMapping
	@RequestMapping("/detail") // 
	public String albumPage(
							//@RequestParam Album album,
							Model model
							){
		//log.debug("albumSearch={},{}",creator, albumNo);
		
		//Album album = albumService.selectOneAlbum(creator,albumNo);
		//model.addAttribute("album",album);
		return "/audiobook/album/albumDetail"; 
	}
	
	@GetMapping
	@RequestMapping("/search/list")
	public String albumSearch(
			Model model) {
		return "/audiobook/search/searchList";
	}
	
	@GetMapping
	@RequestMapping("/detail/sample/collections") // 
	public String albumSamplePage(
							//@RequestParam Album album,
							Model model
							){
		//log.debug("albumSearch={},{}",creator, albumNo);
		
		//Album album = albumService.selectOneAlbum(creator,albumNo);
		//model.addAttribute("album",album);
		return "/audiobook/sample/detailCollections"; 
	}
	
	//관리자 권한
	@PostMapping
	public String albumPage(@RequestParam Album album){
		
		
		return "";
	}
	
}