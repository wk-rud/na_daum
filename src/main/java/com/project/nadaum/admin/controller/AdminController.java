package com.project.nadaum.admin.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.collections.MapUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.authority.SimpleGrantedAuthority;

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
import com.project.nadaum.admin.model.service.AdminService;
import com.project.nadaum.admin.model.vo.Announcement;
import com.project.nadaum.admin.model.vo.Help;
import com.project.nadaum.common.NadaumUtils;
import com.project.nadaum.common.vo.CategoryEnum;
import com.project.nadaum.member.model.service.MemberService;
import com.project.nadaum.member.model.vo.Member;
import com.project.nadaum.member.model.vo.MemberRole;

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
	
	@PostMapping("/adminDeleteMember.do")
	public String adminDeleteMember(Member member) {
		log.debug("member = {}", member);
		int result = memberService.deleteMember(member);
		return "redirect:/member/admin/adminManagingUser.do";
	}
	
	@PostMapping("/changeMemberRole.do")
	public String changeMemberRole(@RequestParam Map<String, Object> map) {
		String role = (String) map.get("role");
		if(role.equals("user")) {
			int result = adminService.insertRole(map);
		}else {
			int result = adminService.deleteRole(map);
		}
		return "redirect:/member/admin/adminManagingUser.do";
	}
	
	@PostMapping("/changeMemberEnabled.do")
	public String changeMemberEnabled(@RequestParam Map<String, Object> map) {
		log.debug("map = {}", map);
		int result = adminService.updateEnabled(map);
		return "redirect:/member/admin/adminManagingUser.do";
	}
	
	@PostMapping("/delete.do")
	public String delete(@RequestParam Map<String, Object> map, RedirectAttributes redirectAttr) {
		log.debug("map = {}", map);
		String category = (CategoryEnum._valueOf((String) map.get("category"))).toString();
		log.debug("category = {}", category);
		if("질문".equals(category)) {
			int result = adminService.deleteHelp(map);	
			return "redirect:/member/admin/adminAllHelp.do";
		}else if("공지사항".equals(category)) {
			int result = adminService.deleteAnnouncement(map);
			return "redirect:/member/admin/adminManagingAnnouncement.do";
		}
		redirectAttr.addFlashAttribute("msg", "삭제실패");
		return "redirect:/member/admin/adminMain.do";
	}
	
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
	public void adminManagingUser(@RequestParam(defaultValue = "1") int cPage, HttpServletRequest request, Model model, @AuthenticationPrincipal Member member) {
		int limit = 5;
		int offset = (cPage - 1) * limit;
		Map<String, Object> param = new HashMap<>();
		param.put("limit", limit);
		param.put("offset", offset);
		param.put("member", member);
		List<Member> list = adminService.selectAllMember(param);
		log.debug("member = {}", list);
		param.put("id", member.getId());
		int totalContent = adminService.countAllMember(param);

		String url = request.getRequestURI();
		String pagebar = NadaumUtils.getPagebar(cPage, limit, totalContent, url);
		model.addAttribute("pagebar", pagebar);
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
	
	@GetMapping("/adminEnrollFrm.do")
	public void adminHelpAnswer(@RequestParam Map<String, Object> map, Model model) {
		try {
			Announcement announce = new Announcement();
			log.debug("map = {}", map);
			String check = (String) map.get("check");
			if("help".equals(check)) {
				Help help = adminService.selectOneHelp(map);
				model.addAttribute("help", help);				
			}else if("announcement".equals(check)) {
				String code = (String)map.get("code");
				if(!"".equals(code)) {
					announce = memberService.selectOneAnnouncement(map);
				}
			}
			model.addAttribute("announce", announce);
			model.addAttribute("check", check);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			throw e;
		}
	}
	
	@PostMapping("/adminEnrollFrm.do")
	public String adminHelpAnswer(@RequestParam Map<String, Object> map, @AuthenticationPrincipal Member member, RedirectAttributes redirectAttr) {
		try {
			log.debug("map = {}", map);
			String check = (String) map.get("check");
			int result = 0;
			if("help".equals(check)) {				
				Help help = new Help();
				help.setCode((String)map.get("code"));
				help.setATitle((String)map.get("aTitle"));
				help.setAContent((String)map.get("aContent"));
				log.debug("help = {}", help);
				result = adminService.updateHelpAnswer(help);	
				redirectAttr.addFlashAttribute("msg", "성공");
				return "redirect:/member/admin/adminAllHelp.do";
			}else if("announcement".equals(check)) {
				String code = (String)map.get("code");
				map.put("id", member.getId());
				if(!"".equals(code)) {
					result = adminService.updateAnnouncement(map);
				}else {
					result = adminService.insertAnnouncement(map);					
				}
			}
			
			redirectAttr.addFlashAttribute("msg", "성공");
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			throw e;
		}
		return "redirect:/member/admin/adminManagingAnnouncement.do";
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
