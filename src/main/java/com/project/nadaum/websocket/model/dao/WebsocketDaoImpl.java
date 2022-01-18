package com.project.nadaum.websocket.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.nadaum.member.model.vo.Member;

@Repository
public class WebsocketDaoImpl implements WebsocketDao {
	
	@Autowired
	private SqlSessionTemplate session;

	@Override
	public int selectAlarmCount(Member member) {
		return session.selectOne("ws.selectAlarmCount", member);
	}

	@Override
	public int updateAlarm(Member member) {
		return session.update("ws.updateAlarm", member);
	}

}
