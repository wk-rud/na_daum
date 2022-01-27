package com.project.nadaum.admin.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.JsonObject;
import com.project.nadaum.admin.model.service.AdminService;
import com.project.nadaum.admin.model.vo.Help;
import com.project.nadaum.common.NadaumUtils;
import com.project.nadaum.member.model.service.MemberService;
import com.project.nadaum.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/member/admin")
public class AdminController {
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private AdminService adminService;
	
	@Autowired
	private ServletContext application;
	
	@GetMapping("/adminMain.do")
	public void adminMain() {}
	
	@GetMapping("/adminManagingAnnouncement.do")
	public void adminManagingAnnouncement(@RequestParam(defaultValue = "1") int cPage, Model model, HttpServletRequest request) {
		int limit = 10;
		int offset = (cPage - 1) * limit;
		Map<String, Object> param = new HashMap<>();
		param.put("limit", limit);
		param.put("offset", offset);
		List<Map<String, Object>> announceList = memberService.selectAllAnnouncement(param);
		log.debug("announceList = {}", announceList);

		int totalContent = memberService.countAllAnnouncementList();
		log.debug("totalContent = {}", totalContent);
		
		String url = request.getRequestURI();
		String pagebar = NadaumUtils.getPagebar(cPage, limit, totalContent, url);
			
		model.addAttribute("pagebar", pagebar);
		model.addAttribute("announceList", announceList);
	}
	
	@GetMapping("/adminManagingUser.do")
	public void adminManagingUser(Model model) {
		List<Member> list = adminService.selectAllMember();
		model.addAttribute("list", list);
	}
	
	@GetMapping("/adminAllHelp.do")
	public void adminAllHelp(@RequestParam(defaultValue = "1") int cPage, HttpServletRequest request, Model model) {
		try {
			int limit = 5;
			int offset = (cPage - 1) * limit;
			Map<String, Object> param = new HashMap<>();
			param.put("limit", limit);
			param.put("offset", offset);
			List<Help> listMap = adminService.selectAllHelp(param);
			int totalContent = adminService.countAllHelp();
			
			String url = request.getRequestURI();
			String pagebar = NadaumUtils.getPagebar(cPage, limit, totalContent, url);
			log.debug("listMap = {}", listMap);
			model.addAttribute("listMap", listMap);
			model.addAttribute("pagebar", pagebar);
		} catch (Exception e) {
			log.error(e.getMessage(),e);
			throw e;
		}
	}
	
	@GetMapping("/adminHelpAnswer.do")
	public void adminHelpAnswer(@RequestParam Map<String, Object> map, Model model) {
		try {
			log.debug("map = {}", map);
			Help help = adminService.selectOneHelp(map);
			model.addAttribute("help", help);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			throw e;
		}
	}
	
	@PostMapping("/adminHelpAnswer.do")
	public String adminHelpAnswer(Help help) {
		try {
			log.debug("help = {}", help);
			int result = 0;
			if(help.getACode() != null) {
				result = adminService.updateHelpAnswer(help);
			}else {
				result = adminService.insertHelpAnswer(help);
			}
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			throw e;
		}
		return "redirect:/member/admin/adminAllHelp.do";
	}
	
	@RequestMapping(value="/uploadSummernoteImageFile.do", produces = "application/json; charset=utf8")
	@ResponseBody
	public String uploadSummernoteImageFile(@RequestParam("file") MultipartFile file, HttpServletRequest request )  {
		JsonObject jsonObject;
		try {
			jsonObject = new JsonObject();
			
			String fileRoot = application.getRealPath("/resources/upload/member/admin/");
			log.debug("fileRoot = {}", fileRoot);
			String originalFileName = file.getOriginalFilename();
			String renamedFileName = NadaumUtils.rename(originalFileName);
			
			File targetFile = new File(fileRoot, renamedFileName);	
			try {
				file.transferTo(targetFile);
			} catch (IllegalStateException | IOException e) {
				log.error(e.getMessage(), e);
			}
			jsonObject.addProperty("url", "/nadaum/resources/upload/member/admin/" + renamedFileName);
			jsonObject.addProperty("responseCode", "success");
			log.debug("root = {}", jsonObject.toString());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			throw e;
		}
		return jsonObject.toString();
	}
	
	@PostMapping(value="/deleteSummernoteImageFile.do")
	public ResponseEntity<?> deleteSummernoteImageFile(@RequestParam Map<String, Object> map)  {

		try {
			String fileRoot = application.getRealPath("/resources/upload/member/admin/");
			String url = (String) map.get("val");
			String[] strs = url.split("/");
			String filename = strs[strs.length - 1];
			String lastDest = url.substring(url.length() - 26, url.length());
			String allDest = fileRoot + lastDest;
			File img = new File(allDest);
			img.delete();
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			throw e;
		}
		return ResponseEntity.ok(1);
	}

}
