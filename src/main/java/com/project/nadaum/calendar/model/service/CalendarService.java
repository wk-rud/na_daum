package com.project.nadaum.calendar.model.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.project.nadaum.calendar.model.vo.Calendar;

public interface CalendarService {

	List<Calendar> calendarList(String id);

	int addCalendar(Calendar calendar);

	
}