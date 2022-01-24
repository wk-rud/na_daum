package com.project.nadaum.calendar.model.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.nadaum.calendar.model.vo.Calendar;

@Repository
public class CalendarDaoImpl implements CalendarDao {
	
	@Autowired
	private SqlSessionTemplate session;

	@Override
	public List<Calendar> calendarList(String id) {
		return session.selectList("calendar.calendarList", id);
	}

	@Override
	public int addCalendar(Map<String, Object> map) {
		return session.insert("calendar.addCalendar", map);
	}

	@Override
	public int changeDate(Map<String, Object> map) {
		return session.update("calendar.changeDate", map);
	}

	@Override
	public int updateCalendar(Map<String, Object> map) {
		return session.update("calendar.updateCalendar", map);
	}

	@Override
	public int deleteCalendar(Map<String, Object> map) {
		return session.delete("calendar.deleteCalendar", map);
	}
	
}
