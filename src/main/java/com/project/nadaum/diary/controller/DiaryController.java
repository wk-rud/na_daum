package com.project.nadaum.diary.controller;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
	
	@PostMapping(value="/deleteImageFile.do")
	public ResponseEntity<?> deleteImageFile(@RequestParam Map<String, Object> map)  {
		log.debug("map = {}", map);
		
		String fileRoot = application.getRealPath("/resources/upload/diary/img/");
		String url = (String) map.get("val");
		log.debug("url = {}", url);
		
		String[] strs = url.split("/");
		String filename = strs[strs.length - 1];
		
		String lastDest = url.substring(url.length() - 26, url.length());		
		String allDest = fileRoot + lastDest;
		
		File img = new File(allDest);	
		img.delete();
		
		return ResponseEntity.ok(1);
	}
	
	@GetMapping("/diaryMain.do")
	public void recentlyDiary(@AuthenticationPrincipal Member member, Model model, @RequestParam Map<String, Object> map, @RequestParam String date) {
		String id = member.getId();	
		map.put("date", date);
		map.put("id", id);	
		
		List<Diary> diaryList = diaryService.recentlyDiary(map);
		log.debug("diaryList = {}", diaryList);
		model.addAttribute("diaryList", diaryList);
		
	}
	
	@GetMapping("/diaryDetail.do")
	public void diaryDetail(Model model, @RequestParam String code) {		
		Diary diary = diaryService.diaryDetail(code);
		int emotionNo = diary.getEmotionNo();		
		Map<String, Object> emotion = diaryService.emotionNo(emotionNo);

		log.debug("diary = {}", diary);
		model.addAttribute("emotion", emotion);
		model.addAttribute("diary", diary);
	}
	
	@PostMapping("/diaryDetail.do")
	public String updateDiary(@AuthenticationPrincipal Member member, @RequestParam Map<String, Object> map, @RequestParam String regDate) {
		map.put("id", member.getId());
		log.debug("map = {}", map);
		log.debug("regDate = {}", regDate);
		
		int result = diaryService.updateDiary(map);
		return "redirect:/diary/diaryMain.do?date=" + regDate;
	}
	
	@GetMapping("/deleteDiary.do")
	public String deleteDiary(@RequestParam String code, @RequestParam String date) {
		log.debug("date = {}", date);
		int result = diaryService.deleteDiary(code);
		return "redirect:/diary/diaryMain.do?date=" + date;
	}
	
	@GetMapping("/monthChange.do")
	public String monthChange(@AuthenticationPrincipal Member member, Model model, @RequestParam Map<String, Object> map, @RequestParam String date) {
		log.debug("date = {}", date);
		String id = member.getId();	
		map.put("date", date);
		map.put("id", id);
		
		List<Diary> diaryList = diaryService.monthChange(map);
		log.debug("diaryList = {}", diaryList);
		model.addAttribute("diaryList", diaryList);
		
		return "redirect:/diary/diaryMain.do";
	}
	
	@GetMapping("/diarySearch.do")
	public void diarySearch(@AuthenticationPrincipal Member member, Model model, @RequestParam Map<String, Object> map, @RequestParam String content) {
		String id = member.getId();	
		map.put("content", content);
		map.put("id", id);	
		
		List<Diary> searchList = diaryService.diarySearch(map);
		log.debug("searchList = {}", searchList);
		model.addAttribute("searchList", searchList);
	}
	
}
