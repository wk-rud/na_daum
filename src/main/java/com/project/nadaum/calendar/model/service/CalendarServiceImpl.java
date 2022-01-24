package com.project.nadaum.calendar.model.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.nadaum.calendar.model.dao.CalendarDao;
import com.project.nadaum.calendar.model.vo.Calendar;

@Service
public class CalendarServiceImpl implements CalendarService {
	
	@Autowired
	private CalendarDao calendarDao;

	@Override
	public List<Calendar> calendarList(String id) {
		return calendarDao.calendarList(id);
	}

	@Override
	public int addCalendar(Map<String, Object> map) {
		return calendarDao.addCalendar(map);
	}

	@Override
	public int changeDate(Map<String, Object> map) {
		return calendarDao.changeDate(map);
	}

	@Override
	public int updateCalendar(Map<String, Object> map) {
		return calendarDao.updateCalendar(map);
	}

	@Override
	public int deleteCalendar(Map<String, Object> map) {
		return calendarDao.deleteCalendar(map);
	}

}
