package com.project.nadaum.accountbook.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.nadaum.accountbook.model.service.AccountBookService;
import com.project.nadaum.accountbook.model.vo.AccountBook;

import lombok.extern.slf4j.Slf4j;

	
@Slf4j
@Controller
@RequestMapping("/accountbook")
public class AccountBookController {
	
	@Autowired
	private AccountBookService accountBookService;

	@RequestMapping(value="/accountbook.do")
	public void accountbook() { }
	
	@RequestMapping(value="/accountList.do")
	public void accountList() { }
	
	
	//전체 리스트 출력
	@ResponseBody
	@RequestMapping(value="/selectAllAccountList.do") 
	 public List<AccountBook> selectAllAccountList (String id, Model model) { 
		 log.info("id={}", id);
		 List<AccountBook> accountList = accountBookService.selectAllAccountList(id);
		 log.info("accountList={}",accountList);
		 model.addAttribute("accountList",accountList);
	 
	 return accountList; 
	 }
	
	 // 가계부 추가
	@RequestMapping(value="/accountInsert.do", method=RequestMethod.POST)
	public String insertAccount(AccountBook account) {
		 int result = accountBookService.insertAccount(account); 
		 
		return "redirect:/accountbook/accountbook.do";
	}
	
	// 가계부 삭제
	@ResponseBody
	@RequestMapping(value="/accountDelete.do", method=RequestMethod.POST)
	public String deleteAccount(@RequestParam("code") String code) {
		int result = accountBookService.deleteAccount(code);
		
		return "redirect:/accountbook/accountbook.do";
	}
	
	//월간 수입, 지출 금액
	@ResponseBody
	@GetMapping(value="/monthlyTotalIncome.do")
	public List<AccountBook> monthlyTotalIncome(String id, Model model) {
		List<AccountBook> incomeList = accountBookService.monthlyTotalIncome(id);
		model.addAttribute(incomeList);
		
		return incomeList;
	}
	
	//월간 총 합계 금액
	@ResponseBody
	@GetMapping(value="/monthlyAccount.do")
	public String monthlyAccount(String id, Model model) {
		String monthlyAccount = accountBookService.monthlyAccount(id);
		model.addAttribute(monthlyAccount);
		
		return monthlyAccount;
	}
	
	// 수입, 지출별 정렬
	 @ResponseBody 
	 @PostMapping(value="/incomeExpenseFilter.do") 
	 public List<AccountBook> incomeExpenseFilter(@RequestBody Map<String, Object> param, Model model) {
		 Map<String, Object> map = new HashMap<>();
		 map.put("id", param.get("id"));
		 map.put("income_expense", param.get("income_expense"));
		 log.info("map={}", map);
		 
		 List<AccountBook> incomeList = accountBookService.incomeExpenseFilter(map); 
		 log.info("incomeList={}",incomeList); 
		 model.addAttribute(incomeList);
	  
	  return incomeList; }
	 
	

}

	


