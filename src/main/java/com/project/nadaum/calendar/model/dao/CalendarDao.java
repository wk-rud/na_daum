package com.project.nadaum.calendar.model.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.project.nadaum.calendar.model.vo.Calendar;

public interface CalendarDao {

	List<Calendar> calendarList(String id);

	int addCalendar(Map<String, Object> map);

	int changeDate(Map<String, Object> map);

	int updateCalendar(Map<String, Object> map);


}
