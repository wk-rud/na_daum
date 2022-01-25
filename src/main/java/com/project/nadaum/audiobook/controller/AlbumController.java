package com.project.nadaum.audiobook.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.nadaum.audiobook.model.service.AlbumService;
import com.project.nadaum.audiobook.model.vo.Album;
import com.project.nadaum.audiobook.model.vo.AlbumAttachment;
import com.project.nadaum.common.NadaumUtils;
import com.project.nadaum.common.vo.Attachment;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/audiobook")
public class AlbumController {

	@Autowired
	private AlbumService albumService;
	
	
	@Autowired
	private ServletContext application;
	
	
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
	@PostMapping("/albumEnroll")
	public String albumEnroll(
			Album album,
			@RequestParam(name="upFile",required=false) MultipartFile[] upFiles,
			RedirectAttributes redirectAttr) throws IllegalStateException, IOException{
		String saveDirectory = application.getRealPath("/resource/upload/audiobook");
		
		List<AlbumAttachment> attachments = new ArrayList<>();
		
		for(int i=0; i< upFiles.length; i++ ) {
			MultipartFile upFile =upFiles[i];
			if(!upFile.isEmpty()) {
				String originalFilename = upFile.getOriginalFilename();
				String renamedFilename = NadaumUtils.rename(originalFilename);
				File dest = new File(saveDirectory,renamedFilename);
				upFile.transferTo(dest);
				
				AlbumAttachment attach = new AlbumAttachment();
				attach.setOriginalFilename(originalFilename);
				attach.setRenamedFilename(renamedFilename);
				attachments.add(attach);
			}
		}
		
		if(!attachments.isEmpty())
			album.setAttachments(attachments);
		log.info("album = {}",album);
		int result = albumService.insertAlbum(album);
		String msg ="앨범 등록 성공!";
		redirectAttr.addFlashAttribute("msg", msg);
		return "redirect:/album/albumList";
	}
	
	@GetMapping("/albumEnrollList")
	public void albumList(
			@RequestParam(defaultValue= "1" )int cPage,
			HttpServletRequest request,
			Model model) {
		int limit = 10;
		int offset = (cPage -1)* limit;
		
		Map<String, Object> param = new HashMap<>();
		param.put("offset", offset);
		param.put("limit", limit);
		
		List<Album> list = albumService.selectAlbumList(param);
		log.debug("list ={}", list);
		
		int totalContent = albumService.selectTotalContent();
		String url = request.getRequestURI();
		String pagebar =NadaumUtils.getPagebar(offset, limit, totalContent, url);
		
		model.addAttribute("list",list);
		model.addAttribute("pagebar",pagebar);
	}
	
}