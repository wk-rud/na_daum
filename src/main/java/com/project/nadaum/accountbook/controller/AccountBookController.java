package com.project.nadaum.accountbook.controller;

import java.io.IOException;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
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
import com.project.nadaum.common.NadaumUtils;
import com.project.nadaum.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

	
@Slf4j
@Controller
@RequestMapping("/accountbook")
public class AccountBookController {
	
	@Autowired
	private AccountBookService accountBookService;

	//가계부 첫 화면에 보여질 값들
	@RequestMapping(value="/accountbook.do")
	public void accountbook(@RequestParam(defaultValue = "1") int cPage, 
				@AuthenticationPrincipal Member member, Model model, HttpServletRequest request) {
		int limit = 4;
		int offset = (cPage-1) * limit;
		String id = member.getId(); 
		
		Map<String, Object> param = new HashMap<>();
		param.put("offset", offset);
		param.put("limit", limit);
		param.put("id", id);
		//로그인한 아이디로 등록된 가계부 전체 목록
		List<AccountBook> accountList = accountBookService.selectAllAccountList(param);
		
		//전체리스트 개수
		int totalAccountList = accountBookService.countAccountList(param);
		
		String category = "all";
		String url = request.getRequestURI();
		String pagebar = NadaumUtils.getPagebar(cPage, limit, totalAccountList, url, category);
			
		model.addAttribute("pagebar", pagebar);
		
		//수입, 지출 계산한 값
		List<Map<String, Object>> incomeList = accountBookService.monthlyTotalIncome(id);
		log.debug("incomeList={}",incomeList);
			//필요한 값만 맵 객체로 변환
			Map<String, Object> incomeExpenseList = new HashMap<>();
			
			if(incomeList.size() == 0) {
				incomeExpenseList.put("income", 0);
				incomeExpenseList.put("expense", 0);
			} else if(incomeList.size() == 1) {
				if((incomeList.get(0).get("incomeExpense")).equals("I")) {
					incomeExpenseList.put("income", incomeList.get(0).get("total"));
					incomeExpenseList.put("expense", 0);
				} else {
					incomeExpenseList.put("income", 0);
					incomeExpenseList.put("expense", incomeList.get(0).get("total"));
				}
			} else {
				incomeExpenseList.put("income", incomeList.get(1).get("total"));
				incomeExpenseList.put("expense", incomeList.get(0).get("total"));
			}
			
			log.info("incomeExpenseList={}", incomeExpenseList);
		
		//월간 총 합계 금액
		String monthlyAccount = accountBookService.monthlyAccount(id);
			//만약 사용자 입력값이 없어서 monthlyAccount합계가 null값이 넘어온다면 해당 변수에 0 대입
			if (monthlyAccount == null) {
				monthlyAccount = "0";
			}
			log.info("monthlyAccount={}", monthlyAccount);

		model.addAttribute("accountList",accountList);
		model.addAttribute("incomeExpenseList", incomeExpenseList);
		model.addAttribute("monthlyAccount", monthlyAccount);
		model.addAttribute("totalAccountList", totalAccountList);
	}
	
	//차트 더보기 페이지
	@RequestMapping(value="/detailChart.do")
	public void detailChart(@RequestParam(defaultValue="0") int monthly, @AuthenticationPrincipal Member member, Model model) {
		
		Map<String, Object> param = new HashMap<>();
		param.put("monthly", monthly);
		param.put("id", member.getId());
		param.put("incomeExpense", "I");
		log.debug("param={}",param);
		List<Map<String, Object>> list_I = accountBookService.categoryChart(param);
		log.debug("list_I={}", list_I);
		
		Map<String, Object> param2 = new HashMap<>();
		param2.put("monthly", monthly);
		param2.put("id", member.getId());
		param2.put("incomeExpense", "E");
		log.debug("param2={}",param2);
		List<Map<String, Object>> list_E = accountBookService.categoryChart(param2);
		log.debug("list_E={}", list_E);
		
		model.addAttribute("list_I", list_I);
		model.addAttribute("list_E", list_E);	
	}
	
	 //전체 리스트 출력
	 @RequestMapping(value="/selectAllAccountList.do") public String selectAllAccountList (@RequestParam(defaultValue = "1") int cPage,
		  @AuthenticationPrincipal Member member, Model model, HttpServletRequest request) {
		 int limit = 4; 
		 int offset = (cPage-1) * limit; 
		 String id = member.getId();
		 
		  Map<String, Object> param = new HashMap<>(); 
		  param.put("offset", offset);
		  param.put("limit", limit); 
		  param.put("id", id); 
		 
		  //로그인한 아이디로 등록된 가계부 전체 목록
		 List<AccountBook> accountList = accountBookService.selectAllAccountList(param);
		  
		 //전체리스트 개수 
		 int totalAccountList = accountBookService.countAccountList(param);
		  
		  String category = "all"; 
		  String url = request.getRequestURI(); 
		  String pagebar = NadaumUtils.getPagebar(cPage, limit, totalAccountList, url, category);
		  
		 model.addAttribute("pagebar", pagebar);
		 model.addAttribute("accountList",accountList);
		 
		 return "redirect:/accountbook/accountbook.do"; }
		 
	
	 // 가계부 추가
	@RequestMapping(value="/accountInsert.do", method=RequestMethod.POST)
	public String insertAccount(AccountBook account) {
		 int result = accountBookService.insertAccount(account); 
		 
		return "redirect:/accountbook/accountbook.do";
	}
	
	// 가계부 삭제
	@ResponseBody
	@RequestMapping(value="/accountDelete.do", method=RequestMethod.POST)
	public Map<String, Object> deleteAccount(@RequestBody Map <String, Object> code) {		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("code", code.get("code"));	
		int result = accountBookService.deleteAccount(map);
		return map;
	}
	
	// 수입, 지출별 정렬
	 @PostMapping(value="/incomeExpenseFilter.do") 
	 public String incomeExpenseFilter(@RequestBody Map<String, Object> param,  Model model) {
		 Map<String, Object> map = new HashMap<>();
		 map.put("id", param.get("id"));
		 map.put("incomeExpense", param.get("incomeExpense"));
		 log.debug("map= {}",map);
		 
		 List<AccountBook> accountList = accountBookService.incomeExpenseFilter(map); 
		 model.addAttribute("accountList", accountList);	  
		 
		 return "/accountbook/accountList";
	  }
	
	 
	//검색
	 @GetMapping(value="/searchList.do")
	 public void searchList(@RequestParam(defaultValue = "1") int cPage, @AuthenticationPrincipal Member member, 
			 @RequestParam Map<String, Object> param, Model model, HttpServletRequest request) {
		 int limit = 4;
		 int offset = (cPage-1) * limit;
		 String id = member.getId(); 
		 
		 Map<String, Object> map = new HashMap<>();
		 map.put("incomeExpense", param.get("incomeExpense"));
		 map.put("category", param.get("category"));
		 map.put("detail", param.get("detail"));
		 map.put("id", param.get("id"));
		 map.put("limit", limit);
		 map.put("offset", offset);
		 log.info("map={}", map);
			
		 List<AccountBook> accountList = accountBookService.searchList(map);
		 log.info("list={}", accountList);
		 
		//전체리스트 개수
		int totalAccountList = accountBookService.countAccountList(map);
		
		String category = (String) param.get("category");
		String url = request.getRequestURI();
		String pagebar = NadaumUtils.getPagebar(cPage, limit, totalAccountList, url, category);
			
		model.addAttribute("pagebar", pagebar);
		 
		//수입, 지출 계산한 값
		List<Map<String, Object>> incomeList = accountBookService.monthlyTotalIncome(id);
			//필요한 값만 맵 객체로 변환
			Map<String, Object> incomeExpenseList = new HashMap<>();
			if(incomeList.size() == 0) {
				incomeExpenseList.put("income", 0);
				incomeExpenseList.put("expense", 0);
			} else if(incomeList.size() == 1) {
				if((incomeList.get(0).get("incomeExpense")).equals("I")) {
					incomeExpenseList.put("income", incomeList.get(0).get("total"));
					incomeExpenseList.put("expense", 0);
				} else {
					incomeExpenseList.put("income", 0);
					incomeExpenseList.put("expense", incomeList.get(0).get("total"));
				}
			} else {
				incomeExpenseList.put("income", incomeList.get(1).get("total"));
				incomeExpenseList.put("expense", incomeList.get(0).get("total"));
			}
			log.info("incomeExpenseList={}", incomeExpenseList);
				
			//월간 총 합계 금액
			String monthlyAccount = accountBookService.monthlyAccount(id);
			log.info("monthlyAccount={}", monthlyAccount);
			//만약 사용자 입력값이 없어서 monthlyAccount합계가 null값이 넘어온다면 해당 변수에 0 대입
			if (monthlyAccount == null) {
				monthlyAccount = "0";
			}
				
			model.addAttribute("incomeExpenseList", incomeExpenseList);
			model.addAttribute("monthlyAccount", monthlyAccount);
			model.addAttribute("accountList", accountList); 
		 }
	 	
	 	//차트
		@ResponseBody
		@PostMapping(value="/incomeChart.do", produces="application/json; charset=UTF-8") 
		public List<Map<String, Object>> chartValue (@RequestBody Map<String, Object> param, Model model) {
		Map<String, Object> map = new HashMap<>(); 
		map.put("id", param.get("id"));
		map.put("incomeExpense", param.get("incomeExpense")); 
		List<Map<String, Object>> chartValue = accountBookService.chartValue(map);
		log.debug("chartValue={}", chartValue);
			  
		return chartValue ;
	}
		
		//detailChart
		@ResponseBody
		@PostMapping(value="/detailMonthlyChart.do", produces="application/json; charset=UTF-8")
		public List<Map<String, Object>> detailMonthlyChart(@AuthenticationPrincipal Member member, Model model) {
			Map<String, Object> map = new HashMap<>(); 
			map.put("id", member.getId());		
			List<Map<String, Object>> list = accountBookService.detailMonthlyChart(map);
			log.debug("list={}", list);
			return list;
		}
		
		//categoryChart
		@ResponseBody
		@PostMapping(value="/categoryChart.do", produces="application/json; charset=UTF-8")
		public List<Map<String, Object>> categoryChart(@RequestParam(defaultValue="0") int monthly, @AuthenticationPrincipal Member member, @RequestBody Map<String, Object> param, Model model) {
			Map<String, Object> map = new HashMap<>(); 
			map.put("monthly", monthly);
			map.put("id", member.getId());		
			map.put("incomeExpense", param.get("incomeExpense"));
			
			List<Map<String, Object>> list = accountBookService.categoryChart(map);
			log.debug("list={}", list);
			
			model.addAttribute("list", list);
			return list;
		}
			  
		//엑셀
		@GetMapping("/excel")
		public void downloadExcel(HttpServletResponse resp, @AuthenticationPrincipal Member member) throws IOException{
			Map<String, Object> map = new HashMap<>();
			//엑셀에 담을 리스트 조회
			String id = member.getId();
			map.put("id", id);
			List<AccountBook> list = accountBookService.selectAllAccountList(map);
			log.debug("list={}",list);
			
				//엑셀 파일 생성
				Workbook workbook = new XSSFWorkbook();
				//엑셀 제목
				String fileName = "나다움-" + member.getName()+"님의 가계부 내역";
				//엑셀 내부의 시트 생성
				Sheet sheet = workbook.createSheet("나다움-" + member.getName()+"님의 가계부 내역");
				//rowNum 카운팅 변수
				int rowNo = 0;
				
				//엑셀 헤더 컬러/폰트
				CellStyle headStyle = workbook.createCellStyle();
				headStyle.setFillForegroundColor(HSSFColor.HSSFColorPredefined.LIGHT_BLUE.getIndex());
				headStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
				Font font = workbook.createFont();
				font.setColor(HSSFColor.HSSFColorPredefined.WHITE.getIndex());
				font.setFontHeightInPoints((short) 13);
				headStyle.setFont(font);
				
				//헤더 내용
				Row headerRow = sheet.createRow(rowNo++);
				headerRow.createCell(0).setCellValue("날짜");
				headerRow.createCell(1).setCellValue("결제수단");			
				headerRow.createCell(2).setCellValue("대분류");
				headerRow.createCell(3).setCellValue("소분류");
				headerRow.createCell(4).setCellValue("내역");
				headerRow.createCell(5).setCellValue("금액");
					
				//헤더에 스타일 입히기
				for(int i = 0; i <= 5; i++) {
					headerRow.getCell(i).setCellStyle(headStyle);
				}
				
				//엑셀에 담을 내용 포맷 변환용 코드
				SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
				DecimalFormat df = new DecimalFormat("#,###");

				//엑셀에 담을 리스트 for문으로 한 줄씩 담아주기
				for(AccountBook accountbook : list) {
					Row row = sheet.createRow(rowNo++);
					row.createCell(0).setCellValue(format.format(accountbook.getRegDate()));
					row.createCell(1).setCellValue(accountbook.getPayment().equals("card") ? "카드" : "현금");
					row.createCell(2).setCellValue(accountbook.getIncomeExpense().equals("I") ? "수입" : "지출");
					row.createCell(3).setCellValue(accountbook.getCategory());
					row.createCell(4).setCellValue(accountbook.getDetail());
					row.createCell(5).setCellValue(df.format(accountbook.getPrice()));
			}
			
			//셀 크기 설정
			sheet.setColumnWidth(0, 3000);
			sheet.setColumnWidth(1, 3000);
			sheet.setColumnWidth(2, 2000);
			sheet.setColumnWidth(3, 3000);
			sheet.setColumnWidth(4, 8000);
			sheet.setColumnWidth(5, 3000);
			
			//타입 지정
			resp.setContentType("application/vnd.ms-excel");
			//파일 저장명 -> 이게 지금 안 먹음 ㅠㅠ
			resp.setHeader("content-Disposition", "attachment; filename="+fileName);
			
			try {
				workbook.write(resp.getOutputStream());
			} catch(Exception e) {
				e.printStackTrace();
			
			}
		
		}
	

}
	 

	


