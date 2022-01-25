package com.project.nadaum.common;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.project.nadaum.member.model.service.MemberService;
import com.project.nadaum.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class EchoHandler extends TextWebSocketHandler {
	
	private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
	
	Map<String, WebSocketSession> userMap = new HashMap<>();
	
	@Autowired
	private MemberService memberService;
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		
		try {
			log.info("#ChattingHandler, afterConnectionEstablished");
			sessionList.add(session);
			
			userMap.put(session.getPrincipal().getName(), session);			
			
			log.debug("userMap = {}", userMap);
			log.debug("session = {}", session.getPrincipal());
			log.info(session.getPrincipal().getName() + "접속");
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			throw e;
		}
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		
		log.info("#ChattingHandler, handleMessage");
		log.info(session.getId() + ": " + message);
		
		for(WebSocketSession s : sessionList) {
			s.sendMessage(new TextMessage(session.getPrincipal().getName() + ":" + message.getPayload()));
		}
		
		String msg = message.getPayload();
		if(StringUtils.isNotEmpty(msg)) {
			String[] strs = msg.split(",");
			
			// 친구관련
			if(strs != null && strs.length == 3) {
				String cmd = strs[0];
				String caller = strs[1];
				String receiver = strs[2];
				String receiverId = "";
				String senderNickname = "";
				log.debug("cmd = {}", cmd);
				log.debug("caller = {}", caller);
				log.debug("receiver = {}", receiver);
				
				
				if(cmd != null && (cmd.equals("following")) || (cmd.equals("follower")) || (cmd.equals("free")) || (cmd.equals("friend"))) {
					Map<String, Object> id = new HashMap<>();
					id.put("id", caller);
					Member member = memberService.selectOneMemberNickname(receiver);
					Member senderInfo = memberService.selectOneMember(id);
					senderNickname = senderInfo.getNickname();
					receiverId = member.getId();
				}					
				
				log.debug("receiverId = {}", receiverId);
				WebSocketSession friendSession = friendSession = userMap.get(receiverId);
				if(("free".equals(cmd) || "follower".equals(cmd)) && friendSession != null) {
					TextMessage tMsg = new TextMessage(senderNickname + "님이 " + receiver + "님을 친구추가 했습니다.");
					friendSession.sendMessage(tMsg);				
				}else if("friend".equals(cmd) && friendSession != null) {
					TextMessage tMsg = new TextMessage(senderNickname + "님이 " + receiver + "님을 친구삭제했습니다.");
					friendSession.sendMessage(tMsg);
				}else if("following".equals(cmd) && friendSession != null) {
					TextMessage tMsg = new TextMessage(senderNickname + "님이 팔로잉을 그만두었습니다.");
					friendSession.sendMessage(tMsg);
				}
			}
				
		}
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		
		log.info("#ChattingHandler, afterConnectionClosed");

		sessionList.remove(session);
		
		log.info(session.getPrincipal().getName() + "연결종료");
	}
	
		
}
