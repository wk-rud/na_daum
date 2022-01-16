package com.project.nadaum.member.controller;

import java.beans.PropertyEditor;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.nadaum.member.model.service.KakaoService;
import com.project.nadaum.member.model.service.MailSendService;
import com.project.nadaum.member.model.service.MemberService;
import com.project.nadaum.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/member")
@Slf4j
public class MemberController {
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	@Autowired
	private MailSendService mailSendService;
	
	@Autowired
	private KakaoService kakaoService;
			
	@GetMapping("/memberLogin.do")
	public void memberLogin() {}
		
	@GetMapping("/memberEnroll.do")
	public void memberEnroll() {}
	
	@GetMapping("/checkIdDuplicate.do")
	public ResponseEntity<Map<String, Object>> checkIdDuplicate(@RequestParam String id){
		Member member = memberService.selectOneMember(id);
		boolean available = member == null;
		
		Map<String, Object> map = new HashMap<>();
		map.put("id", id);
		map.put("available", available);		
		
		return ResponseEntity.ok(map);
	}
	
	@PostMapping("/memberEnroll.do")
	public String memberEnroll(Member member, RedirectAttributes redirectAttr) {
		log.debug("member = {}", member);
		String rawPassword = member.getPassword();
		String encodedPassword = bcryptPasswordEncoder.encode(rawPassword);
		member.setPassword(encodedPassword);
		
		String authKey = mailSendService.sendAuthMail(member.getEmail());
		member.setAuthKey(authKey);
		log.debug("authKey = {}", authKey);
		int result = memberService.insertMember(member);
		result = memberService.insertRole(member);
		
		redirectAttr.addFlashAttribute("result", result);
		return "redirect:/";
	}
	
	@GetMapping("/memberKakaoLogin.do")
	public String memberKakaoLogin(@RequestParam(value = "code", required = false) String code, RedirectAttributes redirectAttr) {
		log.debug("code = {}", code);
		String access_Token = kakaoService.getAccessToken(code);
		Map<String, Object> map = kakaoService.getUserInfo(access_Token);
		log.debug("map = {}", map);
		String id = (String) map.get("id");
		Member member = memberService.selectOneMember(id);
		if(member == null) {
			String rawPassword = id;
			String encodedPassword = bcryptPasswordEncoder.encode(rawPassword);
			map.put("password", encodedPassword);
			map.put("loginType", "K");
			int result = memberService.insertKakaoMember(map);
			member = memberService.selectOneMember(id);
			result = memberService.insertRole(member);
		}
		redirectAttr.addFlashAttribute("member", member);
		return "redirect:/member/memberLogin.do";
	}
	
	@GetMapping("/memberConfirm.do")
	public String memberConfirm(@RequestParam Map<String, String> map) {
		int result = memberService.confirmMember(map);
		
		if(result > 0) {
			return "member/memberLogin";
		}
		
		return "redirect:/";
	}
	
	@GetMapping("/mypage/memberDetail.do")
	public void memberDetail(@AuthenticationPrincipal Member member, @RequestParam String tPage, Model model, RedirectAttributes redirectAttr) {
		log.debug("tPage = {}", tPage);
		
		List<Map<String, Object>> alarm = memberService.selectAllAlarm(member);
		log.debug("alarm = {}", alarm);
		
		model.addAttribute("alarmList", alarm);
	}
	
	
	@GetMapping("/mypage/memberMyHelp.do")
	public void memberMyHelp(@AuthenticationPrincipal Member member, Model model){
		List<Map<String, Object>> qMap = memberService.selectAllMyQuestions(member);
		log.debug("qMap = {}", qMap);
		
		model.addAttribute("qMap", qMap);
	}
	
	@GetMapping("/mypage/memberHelp.do")
	public void memberHelp(Model model){
		List<Map<String, Object>> allList = memberService.selectAllMembersQuestions();
		log.debug("allList = {}", allList);
		
		model.addAttribute("allList", allList);		
	}
	
	@GetMapping("/mypage/memberFriends.do")
	public void memberFriends() {
		
	}
	
	@GetMapping("/mypage/memberAnnouncement.do")
	public void memberAnnouncement() {
		
	}
	
	@PostMapping("/memberUpdate.do")
	public ResponseEntity<?> memberUpdate(Member member, @AuthenticationPrincipal Member oldMember){
		log.debug("member = {}", member);
		log.debug("oldMember = {}", oldMember);
		
		int result = memberService.updateMember(member);
		
		oldMember.setName(member.getName());
		oldMember.setEmail(member.getEmail());
		oldMember.setAddress(member.getAddress());
		oldMember.setPhone(member.getPhone());
		oldMember.setNickname(member.getNickname());
		oldMember.setHobby(member.getHobby());
		oldMember.setSearch(member.getSearch());
		oldMember.setIntroduce(member.getIntroduce());
		oldMember.setBirthday(member.getBirthday());
		
		Authentication newAuthentication = new UsernamePasswordAuthenticationToken(oldMember, oldMember.getPassword(), oldMember.getAuthorities());
		
		SecurityContextHolder.getContext().setAuthentication(newAuthentication);
		
		return ResponseEntity.ok(result);
		
	}
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");		
		PropertyEditor editor = new CustomDateEditor(sdf, true);		
		binder.registerCustomEditor(Date.class, editor);
	}
	
}
