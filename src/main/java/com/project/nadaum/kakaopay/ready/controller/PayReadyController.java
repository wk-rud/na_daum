package com.project.nadaum.kakaopay.ready.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.nadaum.kakaopay.ready.model.service.PayReadyService;
import com.project.nadaum.kakaopay.ready.model.vo.PayAuth;
import com.project.nadaum.kakaopay.ready.model.vo.PayReady;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/payready")
public class PayReadyController {

	@Autowired
	private PayReadyService payReadyService;
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	@PostMapping("/payRequest")
	@ResponseBody
	public ResponseEntity<?> payRequest(@RequestBody PayReady payReady) {
		log.debug("payReady = {}",payReady);
		
		int result = payReadyService.insertPayReady(payReady);
		
		//tid, pg_token생성 
		String pgToken = bcryptPasswordEncoder.encode(payReady.getCid()+payReady.getPartnerUserId());
		String tid =String.valueOf(System.currentTimeMillis()); // 난수대신 사용.
		
		//인증 요소 저장
		int resultAuth = payReadyService.insertPayAuth(new PayAuth(tid, pgToken));
		
		Map<String,Object> map = new HashMap<>();
		if(result !=0) {
			map.put("pgToken",pgToken);
			map.put("tid", tid);
			map.put("msg", "다음단계를 진행합니다.");
			return ResponseEntity.ok(map);
		} else {
			return ResponseEntity.badRequest().build();
		}	
	}
}
