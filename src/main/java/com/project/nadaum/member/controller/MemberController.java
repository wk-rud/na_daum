package com.project.nadaum.member.controller;

import java.beans.PropertyEditor;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.JsonObject;
import com.project.nadaum.admin.model.vo.Announcement;
import com.project.nadaum.common.NadaumUtils;
import com.project.nadaum.common.vo.Attachment;
import com.project.nadaum.common.vo.CategoryEnum;
import com.project.nadaum.member.model.service.KakaoService;
import com.project.nadaum.member.model.service.MailSendService;
import com.project.nadaum.member.model.service.MemberService;
import com.project.nadaum.member.model.service.MessageService;
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
	private ServletContext application;
	
	@Autowired
	private MailSendService mailSendService;
	
	@Autowired
	private KakaoService kakaoService;
	
	@Autowired
	private MessageService messageService;
			
	@GetMapping("/memberLogin.do")
	public void memberLogin() {}
	
	@GetMapping("/mypage/memberHelpEnroll.do")
	public void memberHelpEnroll() {}
	
	@GetMapping("/memberFindId.do")
	public void memberFindId() {}
	
	@GetMapping("/memberFindPassword.do")
	public void memberFindPassword() {}
		
	@GetMapping("/memberEnroll.do")
	public void memberEnroll(@RequestParam String agree) {}
	
	@GetMapping("/memberEnrollAgreement.do")
	public void memberEnrollAgreement() {}	
	
	@GetMapping("/mypage/changePassword.do")
	public void changePassword() {}
	
	@GetMapping("/mypage/announcementDetail.do")
	public String announcementDetail(@RequestParam String board, Model model, @CookieValue(value="announceCount", required=false, defaultValue="0") String value, HttpServletRequest request, HttpServletResponse response) {
		try {
			// 쿠키로 조회수 관리
			log.debug(value);
			if("0".equals(value)) {
				int result = memberService.updateAnnounceReadCount(board);
				value = board;
				Cookie cookie = new Cookie("announceCount", value);
				cookie.setMaxAge(60 * 60 * 24 * 30);
				cookie.setPath(request.getContextPath() + "/member/mypage/announcementDetail.do");
				response.addCookie(cookie);
				log.debug("쿠키 배포 완료 = {}", cookie);			
			}
			Map<String, Object> param = new HashMap<>();
			param.put("code", board);
			Announcement announce = memberService.selectOneAnnouncement(param);
			log.debug("announcement = {}", announce);
			model.addAttribute("announce", announce);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			throw e;
		}
		return "member/mypage/announcementDetail";
	}
	
	@GetMapping("/mypage/membershipWithdrawal.do")
	public void membershipWithdrawal(@AuthenticationPrincipal Member member, Model model) {
		try {
			Calendar getToday = Calendar.getInstance();
			getToday.setTime(new Date()); 
						
			Calendar cmpDate = Calendar.getInstance();
			cmpDate.setTime(member.getRegDate()); 
			
			long diffSec = (getToday.getTimeInMillis() - cmpDate.getTimeInMillis()) / 1000;
			long diffDays = diffSec / (24 * 60 * 60); //일자수 차이
			String msg = member.getNickname() + " 나는 정말 탈퇴한다";
			model.addAttribute("write", msg);
			model.addAttribute("date", diffDays);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			throw e;
		}
	}
	
	@PostMapping("/mypage/membershipWithdrawal.do")
	public String membershipWithdrawal(Member member, RedirectAttributes redirectAttr, HttpServletRequest request, HttpServletResponse response) {
		int result = memberService.deleteMember(member);
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		new SecurityContextLogoutHandler().logout(request, response, auth);
		redirectAttr.addFlashAttribute("msg", "회원 탈퇴 성공");
		return "redirect:/";
	}
	
	@GetMapping("/mypage/enrollPhone.do")
	public String enrollPhone(@RequestParam String ePhone, Model model, RedirectAttributes redirectAttr) {
		Map<String, Object> map = new HashMap<>();
		String num =  RandomStringUtils.randomNumeric(6);
		map.put("phone", ePhone);
		map.put("num", num);
		log.debug("map", map);
		Member member = memberService.selectOneMemberByPhone(map);
		if(member != null) {
			redirectAttr.addFlashAttribute("msg", "이미 등록된 번호입니다.");
			return "redirect:/member/mypage/memberDetail.do?tPage=myPage";
		}
		messageService.sendAuthenticationNum(map);
		model.addAttribute("map", map);	
		return "member/mypage/enrollPhone";			
	}
	
	@PostMapping("/mypage/enrollPhone.do")
	public String enrollPhone(@RequestParam Map<String, Object> map, @AuthenticationPrincipal Member member, RedirectAttributes redirectAttr) {
		map.put("id", member.getId());
		int result = memberService.updateMemberPhone(map);
		
		member.setPhone((String)map.get("phone"));
		Authentication newAuthentication = new UsernamePasswordAuthenticationToken(member, member.getPassword(), member.getAuthorities());		
		SecurityContextHolder.getContext().setAuthentication(newAuthentication);
		redirectAttr.addFlashAttribute("msg", "핸드폰 등록 성공");
		return "redirect:/member/mypage/memberDetail.do?tPage=myPage";
	}
	
	@PostMapping("/mypage/changePassword.do")
	public String changePassword(@RequestParam Map<String, Object> map, @AuthenticationPrincipal Member member, RedirectAttributes redirectAttr, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> checkMap = new HashMap<>();
		Map<String, Object> cpMap = new HashMap<>();
		String cPassword = (String) map.get("currentPassword");
		checkMap.put("id", member.getId());		
		Member checkPassword = memberService.selectOneMember(checkMap);
	
		if(checkPassword != null && bcryptPasswordEncoder.matches(cPassword, checkPassword.getPassword())) {	
			String changePassword = bcryptPasswordEncoder.encode((String)map.get("password"));							
			cpMap.put("id", member.getId());
			cpMap.put("password", changePassword);
			int result = memberService.updateMemberPassword(cpMap);
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			new SecurityContextLogoutHandler().logout(request, response, auth);
			redirectAttr.addFlashAttribute("msg", "비밀번호 변경 성공 다시 로그인하세요");	
			return "redirect:/";
		}
		redirectAttr.addFlashAttribute("msg", "비밀번호가 틀렸습니다.");
		return "redirect:/member/mypage/memberDetail.do?tPage=myPage";
	}
	
	@GetMapping("/mypage/memberInfo.do")
	public void memberInfo(Model model) {
		List<Map<String, Object>> list = memberService.selectMostHelp();
		List<Map<String, Object>> helps = memberService.selectAllMembersQuestions();
		log.debug("list = {}", list);
		List<Map<String, Object>> mostHelps = new ArrayList<>();
		for(int i = 0; i < helps.size(); i++) {
			for(int j = 0; j < list.size(); j++) {
				if(helps.get(i).get("code").equals(list.get(j).get("CODE"))) {
					mostHelps.add(helps.get(i));
				}
			}
		}
		log.debug("mostHelps = {}", mostHelps);
		model.addAttribute("mostHelps", mostHelps);
	}
	
	@GetMapping("/mypage/memberHelpOneCategory.do")
	public void memberHelpOneCategory(@RequestParam String category, @RequestParam(defaultValue="1") int cPage, Model model, HttpServletRequest request) {
					
		int limit = 10;
		int offset = (cPage - 1) * limit;
		Map<String, Object> param = new HashMap<>();
		param.put("limit", limit);
		param.put("offset", offset);
		param.put("category", category);
		List<Map<String, Object>> help = memberService.selectHelpOneCategory(param);
		
		int totalContent = memberService.countHelpOneCategoryCount(category);
		log.debug("totalContent = {}", totalContent);
		String url = request.getRequestURI();
		String pagebar = NadaumUtils.getPagebar(cPage, limit, totalContent, url);
		String check = CategoryEnum._valueOf(category).toString();
		
		model.addAttribute("check", check);
		model.addAttribute("pagebar", pagebar);
		model.addAttribute("help", help);
		
	}
	
	@PostMapping("/mypage/memberHelpEnroll.do")
	public String memberHelpEnroll(@AuthenticationPrincipal Member member, @RequestParam Map<String, Object> map) {
		log.debug("map = {}", map);
		map.put("id", member.getId());
		int result = memberService.insertMemberHelp(map);
		return "redirect:/member/mypage/memberHelp.do";
	}
	
	@RequestMapping(value="/mypage/uploadSummernoteImageFile.do", produces = "application/json; charset=utf8")
	@ResponseBody
	public String uploadSummernoteImageFile(@RequestParam("file") MultipartFile file, HttpServletRequest request )  {
		JsonObject jsonObject;
		try {
			jsonObject = new JsonObject();
			
			String fileRoot = application.getRealPath("/resources/upload/member/img/");
			log.debug("fileRoot = {}", fileRoot);
			String originalFileName = file.getOriginalFilename();
			String renamedFileName = NadaumUtils.rename(originalFileName);
			
			File targetFile = new File(fileRoot, renamedFileName);	
			try {
				file.transferTo(targetFile);
			} catch (IllegalStateException | IOException e) {
				log.error(e.getMessage(), e);
			}
			jsonObject.addProperty("url", "/nadaum/resources/upload/member/img/" + renamedFileName);
			jsonObject.addProperty("responseCode", "success");
			log.debug("root = {}", jsonObject.toString());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			throw e;
		}
		return jsonObject.toString();
	}
	
	@PostMapping(value="/mypage/deleteSummernoteImageFile.do")
	public ResponseEntity<?> deleteSummernoteImageFile(@RequestParam Map<String, Object> map)  {

		try {
			String fileRoot = application.getRealPath("/resources/upload/member/img/");
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
		
	@PostMapping("/memberFindId.do")
	public String memberFindId(@RequestParam Map<String, Object> map) throws Exception {
		try {
			if("on".equals(map.get("methodEmail"))) {
				Member member = memberService.selectOneMemberByEmail(map);
				mailSendService.sendIdByEmail(member);
			}else if("on".equals(map.get("methodPhone"))) {
				Member member = memberService.selectOneMemberByPhone(map);
				if(member.getPhone() != null && !member.getPhone().isEmpty()) {
					log.debug("성공");
					messageService.sendId(member);
				}
			}
			return "redirect:/member/memberLogin.do";
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			throw e;
		}		
	}
	
	@PostMapping("/memberFindPassword.do")
	public String memberFindPassword(@RequestParam Map<String, Object> map) throws Exception {
		try {
			log.debug("map = {}", map);
			if("on".equals(map.get("methodEmail"))) {
				Member member = memberService.selectOneMemberByIdEmail(map);
				mailSendService.sendTemporaryPassword(member);
			}else if("on".equals(map.get("methodPhone"))) {
				Member member = memberService.selectOneMemberByIdPhone(map);
				Map<String, Object> param = new HashMap<>();
				String rawPassword = mailSendService.getTemporaryPassword();
				String encodedPassword = bcryptPasswordEncoder.encode(rawPassword);
				member.setPassword(rawPassword);
				param.put("email", member.getEmail());
				param.put("password", encodedPassword);
				int result = memberService.updateMemberPassword(param);
				messageService.sendPw(member);
				return "redirect:/member/memberLogin.do";
			}
			return "redirect:/";
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			throw e;
		}		
	}
	
	@GetMapping("/memberTemporaryPassword.do")
	public String memberTemporaryPassword(@RequestParam Map<String, Object> map) {
		try {
			String rawPassword = (String) map.get("tempPw");
			String encodedPassword = bcryptPasswordEncoder.encode(rawPassword);
			map.put("password", encodedPassword);
			int result = memberService.updateMemberPassword(map);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			throw e;
		}
		return "redirect:/member/memberLogin.do";
	}
	
	@PostMapping("/memberAgreementCheck.do")
	public ResponseEntity<?> memberAgreementCheck(@RequestParam String agree){
		try {
			log.debug("agree = {}", agree);
			Map<String, Object> map = new HashMap<>();
			Date date = new Date();
			map.put("agree", date);
			return ResponseEntity.ok(map);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			throw e;
		}
	}
	
	@GetMapping("/checkIdDuplicate.do")
	public ResponseEntity<Map<String, Object>> checkIdDuplicate(@RequestParam Map<String, Object> map){
		try {
			Member member = memberService.selectOneMember(map);
			boolean available = member == null;		
			map.put("available", available);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			throw e;
		}	
		return ResponseEntity.ok(map);
	}
	
	@GetMapping("/checkEmailDuplicate.do")
	public ResponseEntity<Map<String, Object>> checkEmailDuplicate(@RequestParam String email){
		Map<String, Object> map = new HashMap<>();
		try {
			map.put("email", email);
			Member member = memberService.selectOneMemberByEmail(map);
			boolean available = member == null;
			map.put("available", available);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			throw e;
		}	
		return ResponseEntity.ok(map);
	}
	
	@GetMapping("/checkNicknameDuplicate.do")
	public ResponseEntity<Map<String, Object>> checkNicknameDuplicate(@RequestParam String nickname){
		Map<String, Object> map = new HashMap<>();
		try {
			Member member = memberService.selectOneMemberNickname(nickname);
			boolean available = member == null;		
			map.put("nickname", nickname);
			map.put("available", available);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			throw e;
		}				
		return ResponseEntity.ok(map);
	}
	
	@PostMapping("/memberEnroll.do")
	public String memberEnroll(Member member, RedirectAttributes redirectAttr) {
		
		try {
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
		} catch (Exception e) {
			log.error(e.getMessage(), e);
		}
		return "redirect:/member/memberLogin.do";
	}
	
	@RequestMapping("/memberKakaoLogin.do")
	public String memberKakaoLogin(@RequestParam(value = "code", required = false) String code, RedirectAttributes redirectAttr) {

		try {
			Map<String, Object> idMap = new HashMap<>();
			log.debug("code = {}", code);
			String access_Token = kakaoService.getAccessToken(code);
			Map<String, Object> map = kakaoService.getUserInfo(access_Token);
			log.debug("map = {}", map);
			String id = (String) map.get("id");
			idMap.put("id", id);
			Member member = memberService.selectOneMember(idMap);
			if(member == null) {
				String rawPassword = id;
				String encodedPassword = bcryptPasswordEncoder.encode(rawPassword);
				map.put("password", encodedPassword);
				map.put("loginType", "K");
				int result = memberService.insertKakaoMember(map);				
				member = memberService.selectOneMember(idMap);
				result = memberService.insertRole(member);
			}
			// 프사 변경시 동기화
			if(!member.getProfile().equals((String)map.get("profile_image"))) {
				member.setProfile((String)map.get("profile_image"));
				int result = memberService.updateMemberProfile(member);
				log.debug("프사변경 = {}", result);
			}
			redirectAttr.addFlashAttribute("member", member);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			throw e;
		}
		return "redirect:/member/memberLogin.do";
	}
	
	@GetMapping("/memberConfirm.do")
	public String memberConfirm(@RequestParam Map<String, String> map) {
		try {
			int result = memberService.confirmMember(map);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			throw e;
		}		
		return "member/memberLogin";
	}
	
	@GetMapping("/mypage/memberModifyNickname.do")
	public void memberModifyNickname() {}	
		
	@GetMapping("/mypage/memberDetail.do")
	public void memberDetail(@AuthenticationPrincipal Member member, @RequestParam String tPage, Model model, RedirectAttributes redirectAttr) {
		try {
			log.debug("tPage = {}", tPage);
			Attachment attach = memberService.selectMemberProfile(member);
			List<Map<String, Object>> alarm = memberService.selectAllAlarm(member);
			log.debug("alarm = {}", alarm);
			log.debug("attach = {}", attach);
			model.addAttribute("attach", attach);
			model.addAttribute("alarmList", alarm);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			throw e;
		}
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
	public void memberHelpDetail(@RequestParam String code, Model model, @AuthenticationPrincipal Member member) {
		Map<String, Object> param = new HashMap<>();
		log.debug("code = {}", code);
		Map<String, Object> helpDetail = memberService.selectOneSelectedHelp(code);
		if("T".equals(helpDetail.get("status")))
			param.put("aCode", helpDetail.get("aCode"));
		param.put("code", code);
		param.put("id", member.getId());
		List<Map<String, Object>> checkLikes = memberService.selectLikesCheck(param);
		
		log.debug("checkLikes = {}", checkLikes);
		log.debug("helpDetail = {}", helpDetail);
		model.addAttribute("checkLikes", checkLikes);
		model.addAttribute("helpDetail", helpDetail);
	}
	
	@PostMapping("/mypage/updateFriend.do")
	public ResponseEntity<?> updateFriend(@AuthenticationPrincipal Member member, @RequestParam String check, @RequestParam String friendNickname){
		try {
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
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			throw e;
		}
		return ResponseEntity.ok(0);
	}
	
	@GetMapping("/mypage/searchStartFriend.do")
	public ResponseEntity<?> searchStartFriend(@AuthenticationPrincipal Member member, @RequestParam String friend){
		Map<String, Object> resultMap = new HashMap<>();
		try {
			log.debug("friend = {}", friend);
			Map<String, Object> param = new HashMap<>();
			resultMap.put("nickname", friend);
			param.put("id", member.getId());
			param.put("friendNickname", friend);
			Member friendInfo = memberService.selectOneMemberNicknameNotMe(param);
			log.debug("param = {}", param);
			if(friendInfo == null) {			
				return ResponseEntity.ok(0);
			}else {
				param.put("friendId", friendInfo.getId());
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
			}
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			throw e;
		}
		return ResponseEntity.ok(resultMap);
	}
	
	@GetMapping("/mypage/searchFriendsByNickname.do")
	public ResponseEntity<?> searchFriendsByNickname(@RequestParam String value){		
		List<Map<String, Object>> searchNickname;
		try {
			searchNickname = memberService.selectSearchMemberNickname(value);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			throw e;
		}	
		return ResponseEntity.ok(searchNickname);
	}
	
	@GetMapping("/mypage/memberFriends.do")
	public void memberFriends(@AuthenticationPrincipal Member member, Model model) {
		try {
			List<Map<String, Object>> friends = memberService.selectAllFriend(member);
			List<Map<String, Object>> follower = memberService.selectAllRequestFriend(member);
			List<Member> memberList = memberService.selectAllNotInMe(member);
			log.debug("friends = {}", friends);
			log.debug("follower = {}", follower);
			
			model.addAttribute("memberList", memberList);
			model.addAttribute("friends", friends);
			model.addAttribute("follower", follower);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			throw e;
		}
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
		try {
			log.debug("member = {}", member);
			int result = memberService.updateMemberNickname(member);
			
			oldMember.setNickname(member.getNickname());		
			Authentication newAuthentication = new UsernamePasswordAuthenticationToken(oldMember, oldMember.getPassword(), oldMember.getAuthorities());		
			SecurityContextHolder.getContext().setAuthentication(newAuthentication);
			
			redirectAttr.addFlashAttribute("msg", "별명 수정 성공!!");
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			throw e;
		}
		return "redirect:/member/mypage/memberDetail.do?tPage=myPage";
	}
	
	@PostMapping("/memberUpdate.do")
	public ResponseEntity<?> memberUpdate(Member member, @AuthenticationPrincipal Member oldMember){
		int result = 0;
		try {
			log.debug("member = {}", member);
			log.debug("oldMember = {}", oldMember);
			
			result = memberService.updateMember(member);
			
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
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			throw e;
		}		
		return ResponseEntity.ok(result);
		
	}
	
	@PostMapping("/memberChangeLike.do")
	public ResponseEntity<?> memberChangeLike(@RequestParam Map<String, Object> map, @AuthenticationPrincipal Member member){
		map.put("id", member.getId());
		log.debug("map = {}", map);
		int result = 0;
		if("t".equals(map.get("flag"))) {
			result = memberService.insertHelpLike(map);
		}else {
			result = memberService.deleteHelpLike(map);
		}
		map.put("result", result);
		return ResponseEntity.ok(map);
	}
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");		
			PropertyEditor editor = new CustomDateEditor(sdf, true);		
			binder.registerCustomEditor(Date.class, editor);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			throw e;
		}
	}
	
}
