package com.project.nadaum.member.controller;

import java.beans.PropertyEditor;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.nadaum.common.NadaumUtils;
import com.project.nadaum.common.vo.Attachment;
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
	
	@Autowired
	private ServletContext application;
			
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
	
	@GetMapping("/checkNicknameDuplicate.do")
	public ResponseEntity<Map<String, Object>> checkNicknameDuplicate(@RequestParam String nickname){
		Member member = memberService.selectOneMemberNickname(nickname);
		boolean available = member == null;
		
		Map<String, Object> map = new HashMap<>();
		map.put("nickname", nickname);
		map.put("available", available);		
		
		return ResponseEntity.ok(map);
	}
	
	@PostMapping("/memberEnroll.do")
	public String memberEnroll(Member member, RedirectAttributes redirectAttr) {
		log.debug("member = {}", member);
		
		try {
			String rawPassword = member.getPassword();
			String encodedPassword = bcryptPasswordEncoder.encode(rawPassword);
			member.setPassword(encodedPassword);
			
			String authKey = mailSendService.sendAuthMail(member.getEmail());
			member.setAuthKey(authKey);
			log.debug("authKey = {}", authKey);
			int result = memberService.insertMember(member);
			result = memberService.insertRole(member);
			
			redirectAttr.addFlashAttribute("result", result);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
		}
		return "redirect:/";
	}
	
	@RequestMapping("/memberKakaoLogin.do")
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
		// 프사 변경시 동기화
		if(!member.getProfile().equals((String)map.get("profile_image"))) {
			member.setProfile((String)map.get("profile_image"));
			int result = memberService.updateMemberProfile(member);
			log.debug("프사변경 = {}", result);
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
	
	@GetMapping("/mypage/memberModifyNickname.do")
	public void memberModifyNickname() {}	
	
	
	@GetMapping("/mypage/memberDetail.do")
	public void memberDetail(@AuthenticationPrincipal Member member, @RequestParam String tPage, Model model, RedirectAttributes redirectAttr) {
		log.debug("tPage = {}", tPage);
		Attachment attach = memberService.selectMemberProfile(member);
		List<Map<String, Object>> alarm = memberService.selectAllAlarm(member);
		log.debug("alarm = {}", alarm);
		log.debug("attach = {}", attach);
		model.addAttribute("attach", attach);
		model.addAttribute("alarmList", alarm);
	}
	
	
	@GetMapping("/mypage/memberMyHelp.do")
	public void memberMyHelp(@AuthenticationPrincipal Member member, Model model){
		List<Map<String, Object>> myHelpList = memberService.selectAllMyQuestions(member);
		log.debug("myHelpList = {}", myHelpList);
		
		model.addAttribute("myHelpList", myHelpList);
	}
	
	@GetMapping("/mypage/memberHelp.do")
	public void memberHelp(Model model){
		List<Map<String, Object>> helpList = memberService.selectAllMembersQuestions();
		log.debug("helpList = {}", helpList);
		
		model.addAttribute("helpList", helpList);		
	}
	
	@GetMapping("/mypage/searchHelpTitle.do")
	public ResponseEntity<?> searchHelpTitle(@RequestParam String value){
		List<Map<String, Object>> titles = memberService.selectAllHelpTitle(value);		
		return ResponseEntity.ok(titles);
	}
	
	@GetMapping("/mypage/searchStart.do")
	public ResponseEntity<?> searchStart(@RequestParam String title) {
		log.debug("title = {}", title);
		List<Map<String, Object>> searchResult = memberService.selectHelpByInput(title);
		if(searchResult != null && !searchResult.isEmpty())
			return ResponseEntity.ok(searchResult);
		else
			return ResponseEntity.ok(0);
	}
	
	@GetMapping("/mypage/memberHelpDetail.do")
	public void memberHelpDetail(@RequestParam String code, Model model) {
		log.debug("code = {}", code);
		Map<String, Object> helpDetail = memberService.selectOneSelectedHelp(code);
		log.debug("helpDetail = {}", helpDetail);
		model.addAttribute("helpDetail", helpDetail);
	}
	
	@PostMapping("/mypage/updateFriend.do")
	public ResponseEntity<?> updateFriend(@AuthenticationPrincipal Member member, @RequestParam String check, @RequestParam String friendNickname){
		log.debug("check = {}, friendNickname = {}", check, friendNickname);
		int result = 0;
		Member friendInfo = memberService.selectOneMemberNickname(friendNickname);
		Map<String, Object> param = new HashMap<>();
		Map<String, Object> reverse = new HashMap<>();
		Map<String, Object> alarm = new HashMap<>();
		
		param.put("friendId", friendInfo.getId());
		param.put("friendNickname", friendNickname);
		param.put("id", member.getId());
		param.put("myNickname", member.getNickname());
		reverse.put("friendNickname", member.getNickname());
		reverse.put("myNickname", friendNickname);
		reverse.put("id", friendInfo.getId());
		reverse.put("friendId", member.getId());
		
		alarm.put("id", friendInfo.getId());
		
		if("follower".equals(check)) {
			// -> friend
			Map<String, Object> isFollower = memberService.selectFollower(param);
			if(isFollower != null) {
				alarm.put("content", member.getNickname() + "님과 친구가 되었습니다.");
				result = memberService.updateRequestFriend(param);
				result = memberService.insertFriend(param);
				result = memberService.insertFriend(reverse);
				result = memberService.insertAlarm(alarm);
				return ResponseEntity.ok(1);
			}
			return ResponseEntity.ok(0);
			
		}else if("following".equals(check)) {
			// -> free
			Map<String, Object> isFollowing = memberService.selectFollowing(param);
			if(isFollowing != null) {
				alarm.put("content", member.getNickname() + "님이 친구신청을 끊었습니다.");
				result = memberService.deleteRequestFriend(reverse);
				result = memberService.insertAlarm(alarm);
				return ResponseEntity.ok(1);
			}
			return ResponseEntity.ok(0);
		}else if("friend".equals(check)) {
			// -> free
			Map<String, Object> isFriend = memberService.selectFriend(param);
			if(isFriend != null) {
				alarm.put("content", member.getNickname() + "님과 더이상 친구가 아니에요");
				result = memberService.deleteRequestFriend(param);
				result = memberService.deleteRequestFriend(reverse);
				result = memberService.deleteFriend(param);
				result = memberService.deleteFriend(reverse);	
				result = memberService.insertAlarm(alarm);
				return ResponseEntity.ok(1);
			}
			return ResponseEntity.ok(0);
		}else if("free".equals(check)) {
			// -> following
			Map<String, Object> isFollower = memberService.selectFollower(reverse);
			log.debug("isFollower = {}", isFollower);
			if(isFollower == null) {
				alarm.put("content", member.getNickname() + "님이 회원님을 팔로우하기 시작했습니다.");
				result = memberService.insertRequestFriend(param);
				result = memberService.insertAlarm(alarm);
				return ResponseEntity.ok(1);
			}
			return ResponseEntity.ok(0);
		}
		return ResponseEntity.ok(0);
	}
	
	@GetMapping("/mypage/searchStartFriend.do")
	public ResponseEntity<?> searchStartFriend(@AuthenticationPrincipal Member member, @RequestParam String friend){
		log.debug("friend = {}", friend);
		Map<String, Object> param = new HashMap<>();
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("nickname", friend);
		param.put("id", member.getId());
		param.put("friendNickname", friend);
		Member friendInfo = memberService.selectOneMemberNicknameNotMe(param);
		param.put("friendId", friendInfo.getId());
		log.debug("param = {}", param);
		if(friendInfo != null) {
			Map<String, Object> isFollower = memberService.selectFollower(param);
			Map<String, Object> isFollowing = memberService.selectFollowing(param);
			Map<String, Object> isFriend = memberService.selectFriend(param);
			if(isFollower != null) {
				resultMap.put("check", "follower");				
			}else if(isFollowing != null) {
				resultMap.put("check", "following");
			}else if(isFriend != null) {
				resultMap.put("check", "friend");
			}else {
				resultMap.put("check", "free");
			}
			log.debug("resultMap = {}", resultMap);
			return ResponseEntity.ok(resultMap);
		}else
			return ResponseEntity.ok(0);
	}
	
	@GetMapping("/mypage/searchFriendsByNickname.do")
	public ResponseEntity<?> searchFriendsByNickname(@RequestParam String value){		
		List<Map<String, Object>> searchNickname = memberService.selectSearchMemberNickname(value);	
		return ResponseEntity.ok(searchNickname);
	}
	
	@GetMapping("/mypage/memberFriends.do")
	public void memberFriends(@AuthenticationPrincipal Member member, Model model) {
		List<Map<String, Object>> friends = memberService.selectAllFriend(member);
		List<Map<String, Object>> follower = memberService.selectAllRequestFriend(member);
		List<Member> memberList = memberService.selectAllNotInMe(member);
		log.debug("friends = {}", friends);
		log.debug("follower = {}", follower);
		
		model.addAttribute("memberList", memberList);
		model.addAttribute("friends", friends);
		model.addAttribute("follower", follower);
	}

	@GetMapping("/mypage/memberFindFriend.do")
	public void memberFindFriend() {}
	
	@GetMapping("/mypage/memberAnnouncement.do")
	public void memberAnnouncement(@RequestParam(defaultValue = "1") int cPage, Model model, HttpServletRequest request) {
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
	
	@PostMapping("/memberModifyNickname.do")
	public String memberModifyNickname(Member member, RedirectAttributes redirectAttr, @AuthenticationPrincipal Member oldMember) {
		log.debug("member = {}", member);
		int result = memberService.updateMemberNickname(member);
		
		oldMember.setNickname(member.getNickname());		
		Authentication newAuthentication = new UsernamePasswordAuthenticationToken(oldMember, oldMember.getPassword(), oldMember.getAuthorities());		
		SecurityContextHolder.getContext().setAuthentication(newAuthentication);
		
		redirectAttr.addFlashAttribute("msg", "별명 수정 성공!!");
		return "redirect:/member/mypage/memberDetail.do?tPage=myPage";
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
