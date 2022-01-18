package com.project.nadaum.websocket.model.dao;

import com.project.nadaum.member.model.vo.Member;

public interface WebsocketDao {

	int selectAlarmCount(Member member);

	int updateAlarm(Member member);

}
