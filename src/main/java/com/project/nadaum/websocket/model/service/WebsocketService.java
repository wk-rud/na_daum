package com.project.nadaum.websocket.model.service;

import com.project.nadaum.member.model.vo.Member;

public interface WebsocketService {

	int selectAlarmCount(Member member);

	int updateAlarm(Member member);

}
