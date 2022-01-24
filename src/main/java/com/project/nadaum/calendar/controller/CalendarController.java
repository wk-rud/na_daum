package com.project.nadaum.calendar.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.tomcat.util.json.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.nadaum.calendar.model.service.CalendarService;
import com.project.nadaum.calendar.model.vo.Calendar;

import lombok.extern.slf4j.Slf4j;
import net.sf.json.JSONObject;

@Controller
@Slf4j
@RequestMapping("/calendar")
public class CalendarController {
	
	@Autowired(required = false)
	private CalendarService calendarService;

	@GetMapping("/calendarView.do")
	public void calendarView() {}
	
	// 달력데이터 조회 
	@ResponseBody
	@GetMapping("/calendarList.do")
	public List<Calendar> calendarList(
			Model model, 
			String id) {
		List<Calendar> list = calendarService.calendarList(id);
		log.debug("id = " + id);
		log.debug("list = {}", list);

		model.addAttribute("list", list);
		return list;
	}

	// 달력데이터 추가
	@ResponseBody
	@PostMapping("/addCalendar.do")
	public Map<String, Object> addCalendar(@RequestBody Map<String, Object> eventData) {
		Map<String, Object> map = new HashMap<String, Object>();
		log.debug("eventData = " + eventData);
		map.put("id", eventData.get("id"));
		map.put("title", eventData.get("title"));
		map.put("startDate", eventData.get("start"));
		map.put("endDate", eventData.get("end"));
		map.put("content", eventData.get("description"));
		map.put("type", eventData.get("type"));
		map.put("backgroundColor", eventData.get("backgroundColor"));
		map.put("textColor", eventData.get("textColor"));
		map.put("allDay", eventData.get("allDay"));
		int result = calendarService.addCalendar(map);
		return map;
		
	}
	
	// 드랍시 날짜 변경
	@ResponseBody
	@PostMapping("/changeDate.do")
	public Map<String, Object> changeDate(@RequestBody Map<String, Object> changeDate) {

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("startDate", changeDate.get("startDate"));
		map.put("endDate", changeDate.get("endDate"));
		map.put("no", changeDate.get("no"));
		
		int result = calendarService.changeDate(map);
		return map;
		
	}
	
	// 캘린더 상세 수정
	@ResponseBody
	@PostMapping("/updateCalendar.do")
	public Map<String, Object> updateCalendar(@RequestBody Map<String, Object> updateCalendar) {

		System.out.println("updateCalendar = " + updateCalendar);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("no", updateCalendar.get("no"));
		map.put("title", updateCalendar.get("title"));
		map.put("startDate", updateCalendar.get("startDate"));
		map.put("endDate", updateCalendar.get("endDate"));
		map.put("content", updateCalendar.get("content"));
		map.put("type", updateCalendar.get("type"));
		map.put("backgroundColor", updateCalendar.get("backgroundColor"));
		map.put("allDay", updateCalendar.get("allDay"));
		
		System.out.println(map);
		
		int result = calendarService.updateCalendar(map);
		return map;
		
	}
}
