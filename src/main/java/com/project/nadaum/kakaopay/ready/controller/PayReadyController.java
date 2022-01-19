package com.project.nadaum.kakaopay.ready.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.nadaum.kakaopay.ready.model.service.PayReadyService;
import com.project.nadaum.kakaopay.ready.model.vo.PayAuth;
import com.project.nadaum.kakaopay.ready.model.vo.PayReady;
import com.project.nadaum.kakaopay.result.model.vo.PayResult;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/payready")
public class PayReadyController {

	@Autowired
	private PayReadyService payReadyService;

	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;

	// 서블릿용 페이 url : payready/api/payIndex
	@GetMapping("api/payIndex")
	public String payIndex(RedirectAttributes redirectAttr) {
		redirectAttr.addFlashAttribute("msg", "요청확인");
		return "/pay/api/payApiIndex";
	}

	@GetMapping("api/payEnroll")
	public String payEnroll() {
		return "pay/api/payEnroll";
	}

	@PostMapping("api/payEnroll")
	public String payEnroll(PayReady payReady, RedirectAttributes redirectAttr, Model model) {
		String pgToken = bcryptPasswordEncoder.encode(payReady.getCid() + payReady.getMemberId());
		String tid = String.valueOf(System.currentTimeMillis());
		PayAuth payAuth = new PayAuth(0, tid,payReady.getOrderCode(), pgToken, new Date());
		log.info("payReady={}",payReady);
//		model.addAttribute("payReady", payReady);
//		model.addAttribute("payAuth", payAuth);
//		model.addAttribute("msg", "토큰발행완료!");
//		return "pay/api/payRequest";

		int resultAuth = payReadyService.insertPayAuth(payAuth);
		int resultPayReady = payReadyService.insertPayReady(payReady);
		if ((resultAuth ==1) && (resultPayReady==1)) {
			model.addAttribute("payReady", payReady);
			model.addAttribute("payAuth", payAuth);
			model.addAttribute("msg", "토큰발행완료!");
			return "pay/api/payRequest";
		} else {
			redirectAttr.addFlashAttribute("msg","토큰발행오류");
			return "redirect:/pay/api/payApiIndex";
		}
	}
	// 여기까지 결제준비 완료.이후 결제요청 과정은 PayResultController에서 진행

	// RESP API요청 처리
	@GetMapping("/rest")
	public String payReady() {
		return "pay/rest/payReadyRequest";
	}

	@ResponseBody
	@PostMapping("/rest")
	public ResponseEntity<?> payReady(@RequestBody PayReady payReady) {
		log.info("payReady={}", payReady);

		String pgToken = bcryptPasswordEncoder.encode(payReady.getCid() + payReady.getMemberId() + payReady.getSid());
		String tid = String.valueOf(System.currentTimeMillis());
		PayAuth payAuth = new PayAuth(0, payReady.getMemberId(), tid, pgToken, new Date());

		// api설명용
//		Map<String, Object> map = new HashMap<>();
//		map.put("payReady", payReady);
//		map.put("payAuth", payAuth);
//		log.info("map={}", map);
//		return ResponseEntity.ok(map);

		int resultAuth = payReadyService.insertPayAuth(payAuth);
		int resultPayReady = payReadyService.insertPayReady(payReady);
		if ((resultAuth == 1) && (resultPayReady == 1)) {
			Map<String, Object> map = new HashMap<>();
			map.put("payReady", payReady);
			map.put("payAuth", payAuth);
			log.info("map={}", map);
			return ResponseEntity.ok(map);
		} else
			return ResponseEntity.badRequest().build();

	}

//	@PostMapping("/payRequest")
//	@ResponseBody
//	public ResponseEntity<?> payRequest(@RequestParam String cid, @RequestParam String partner_order_id) {
//		//log.debug("payReady = {}",payReady);
//		log.debug(partner_order_id);
//		
//		//int result = payReadyService.insertPayReady(payReady);
//		int result =1; //테스트용
//		
//		//tid, pg_token생성 
//		String pgToken = bcryptPasswordEncoder.encode(cid+partner_order_id);
//		String tid =String.valueOf(System.currentTimeMillis()); // 난수대신 사용.
//		
//		//인증 요소 저장
//		//int resultAuth = payReadyService.insertPayAuth(new PayAuth(tid, pgToken));
//		int resultAuth=1; //테스트용
//		
//		Map<String,Object> map = new HashMap<>();
//		
//		//결제 승인에 필요한 자료형 반환
//		if(result !=0 && resultAuth!=0) {
////			map.put("cid",payReady.getCid());
////			map.put("partner_order_id", payReady.getPartnerOrderId());
////			map.put("partner_user_id", payReady.getPartnerUserId());
//			map.put("pg_token",pgToken);
//			map.put("tid", tid);
//			map.put("msg", "다음단계를 진행합니다.");
//			return ResponseEntity.ok(map);
//		} else {
//			map.put("msg", "잘못된 요청입니다!");
//			return ResponseEntity.ok(map);    //.ok(map).badRequest().build();
//		}		
//	}

	@PostMapping("/payRequestSample")
	@ResponseBody
	public String payRequest(@RequestParam String cid, @RequestParam String partner_order_id,
			RedirectAttributes redirectAttr) {

		log.debug(partner_order_id);

		// int result = payReadyService.insertPayReady(payReady);
		int result = 1; // 테스트용

		// tid, pg_token생성
		String pgToken = bcryptPasswordEncoder.encode(cid + partner_order_id);
		String tid = String.valueOf(System.currentTimeMillis()); // 난수대신 사용.

		// 인증 요소 저장
		// int resultAuth = payReadyService.insertPayAuth(new PayAuth(tid, pgToken));
		int resultAuth = 1; // 테스트용

		Map<String, Object> map = new HashMap<>();

		// 결제 승인에 필요한 자료형 반환
		if (result != 0 && resultAuth != 0) {
//			model.addAttribute("cid",payReady.getCid());
//			model.addAttribute("partner_order_id", payReady.getPartnerOrderId());
//			model.addAttribute("partner_user_id", payReady.getPartnerUserId());
			map.put("pg_token", pgToken);
			map.put("tid", tid);
			map.put("msg", "다음단계를 진행합니다.");
			map.put("map", map);
			// return map;
		} else {
			map.put("msg", "잘못된 요청입니다!");
			// return map;
		}
		redirectAttr.addFlashAttribute("msg", result > 0 ? "회원 가입 성공!" : "회원 가입 실패!");

		return "redirect:/";
	}

}
