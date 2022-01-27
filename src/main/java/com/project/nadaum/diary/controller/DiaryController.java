package com.project.nadaum.diary.controller;

import java.io.File;
import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.JsonObject;
import com.project.nadaum.common.NadaumUtils;
import com.project.nadaum.diary.model.service.DiaryService;
import com.project.nadaum.diary.model.vo.Diary;
import com.project.nadaum.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/diary")
public class DiaryController {
	
	@Autowired
	private DiaryService diaryService;
	
	@Autowired
	private ServletContext application;
	
	@GetMapping("/diaryMain.do")
	public void DiaryMain() {}
	
	@GetMapping("/diaryEnroll.do")
	public void DiaryEnroll() {}
	
	@PostMapping("/diaryEnroll.do")
	public String diaryEnroll(@AuthenticationPrincipal Member member, @RequestParam Map<String, Object> map) {
		String emotion = (String)map.get("emotion");
		int emotionNo = diaryService.emotionNo(emotion);	
		
		map.put("emotionNo", emotionNo);
		map.put("id", member.getId());
		log.debug("map = {}", map);
		
		int result = diaryService.insertDiary(map);
		return "redirect:/diary/diaryMain.do";
	}
	
	@RequestMapping(value="/uploadSummernoteImageFile.do", produces = "application/json; charset=utf8")
	@ResponseBody
	public String uploadSummernoteImageFile(
			@RequestParam("file") MultipartFile file, 
			HttpServletRequest request)  {
		JsonObject jsonObject = new JsonObject();
		
		String fileRoot = application.getRealPath("/resources/upload/diary/img/");
		log.debug("fileRoot = {}", fileRoot);
		String originalFileName = file.getOriginalFilename();
		String renamedFileName = NadaumUtils.rename(originalFileName);
		
		File targetFile = new File(fileRoot, renamedFileName);	
		try {
			file.transferTo(targetFile);
		} catch (IllegalStateException | IOException e) {
			log.error(e.getMessage(), e);
		}
		
		jsonObject.addProperty("url", "/nadaum/resources/upload/diary/img/" + renamedFileName);
		jsonObject.addProperty("responseCode", "success");
		log.debug("root = {}", jsonObject.toString());
		
		return jsonObject.toString();
	}
	
	@PostMapping(value="/deleteSummernoteImageFile.do")
	public ResponseEntity<?> deleteImageFile(@RequestParam Map<String, Object> map)  {
		log.debug("map = {}", map);
		
		String fileRoot = application.getRealPath("/resources/upload/diary/img/");
		String url = (String) map.get("val");
		String[] strs = url.split("/");
		String filename = strs[strs.length - 1];
		
		String lastDest = url.substring(url.length() - 26, url.length());		
		String allDest = fileRoot + lastDest;
		
		File img = new File(allDest);	
		img.delete();
		
		return ResponseEntity.ok(1);
	}
}
