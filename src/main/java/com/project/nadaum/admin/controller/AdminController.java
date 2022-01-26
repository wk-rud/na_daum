package com.project.nadaum.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
	
	@GetMapping("/adminMain.do")
	public void adminMain() {
		List<Member> list = adminService.selectAllMember();
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

}
