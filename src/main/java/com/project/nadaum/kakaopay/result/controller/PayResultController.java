package com.project.nadaum.kakaopay.result.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.nadaum.kakaopay.ready.model.vo.PayAuth;
import com.project.nadaum.kakaopay.ready.model.vo.PayReady;
import com.project.nadaum.kakaopay.result.model.service.PayResultService;
import com.project.nadaum.kakaopay.result.model.vo.PayMemberInfo;
import com.project.nadaum.kakaopay.result.model.vo.PayResult;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/payRequest")
public class PayResultController {

	@Autowired
	PayResultService payResultService;

	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;

	// 서블릿용 페이 url : payRequest/api/payRequest

	@PostMapping("api/payRequest")
	//PayReady payReady, PayAuth payAuth,
	public String payRequest(PayResult payResult, 
			@RequestParam("payPw") String payPw,
			RedirectAttributes redirectAttr, Model model) {
		//PayResult payResult = new PayResult();
		log.info("payResult={}",payResult);
		log.info("payPw={}",payPw);
		try {
//			payResult.setCid(payReady.getCid());
//			payResult.setTid(payAuth.getTid());
//			payResult.setPgToken(payAuth.getPgToken());
//			payResult.setPartnerOrderId(payReady.getPartnerOrderId());
//			payResult.setPartnerUserId(payReady.getPartnerUserId());
//			payResult.setItemName(payReady.getItemName());
//			payResult.setQuantity(payReady.getQuantity());
//			payResult.setTotalAmount(payReady.getTotalAmount());
//			payResult.setCARDS(payReady.getCARDS());
			log.info("payResult={}",payResult);
			if(payResult!=null) {
				redirectAttr.addFlashAttribute("msg","결제완료");
				return "redirect:/payready/api/payIndex";
			}
			//PayMemberInfo memberPayInfo = payResultService.selectOnePayMemberInfo(payReady.getPartnerUserId());
			//log.debug("payMemberInfo ={}", memberPayInfo);

			//Boolean bool = bcryptPasswordEncoder.matches(payPw, memberPayInfo.getPayPw());
			
//			if (!bool) {
//				model.addAttribute("msg","비밀번호가다릅니다!");
//				return "pay/api/payRequest";
//			}
			int result = payResultService.insertPayResult(payResult);
			
			if(result!=1) {
				
			}
		} catch (Exception e) {
			model.addAttribute("msg","오류");
			e.printStackTrace();
			throw e;
		}	
		model.addAttribute("payReady",payResult);
		model.addAttribute("payAuth","payAuth");
		
		return "pay/api/payRequestResult";
	}

}
