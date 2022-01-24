package com.project.nadaum.websocket.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.nadaum.member.model.vo.Member;
import com.project.nadaum.websocket.model.dao.WebsocketDao;

@Service
public class WebsocketServiceImpl implements WebsocketService {
	
	@Autowired
	private WebsocketDao websocketDao;

	@Override
	public List<Map<String, Object>> selectAlarmCount(Member member) {
		return websocketDao.selectAlarmCount(member);
	}

	@Override
	public int updateAlarm(Member member) {
		return websocketDao.updateAlarm(member);
	}

	
	
}
