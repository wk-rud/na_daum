package com.project.nadaum.culture.show.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.nadaum.culture.show.model.service.CultureService;
import com.project.nadaum.culture.show.model.vo.Culture;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/culture")
public class CultureController {

	@Autowired
	private CultureService cultureService;
	
//	@GetMapping("/culture.do")
//	public void culture(Model model) {
//		List<Culture> list = cultureService.selectCultureList();
//		model.addAttribute("list", list);
//	}
	
//	@GetMapping("/cultureDetail.do")
//	public void cultureDetail(@RequestParam String code, Model model) {
//		Culture culture = cultureService.selectOneCulture(code);
//		log.debug("culture = {}", culture);
//		model.addAttribute("culture", culture);
//	}
	
	
}
