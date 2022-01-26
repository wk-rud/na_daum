package com.project.nadaum.member.model.service;

import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.PostMapping;

import com.project.nadaum.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;
import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.request.SingleMessageSendingRequest;
import net.nurigo.sdk.message.response.SingleMessageSentResponse;
import net.nurigo.sdk.message.service.DefaultMessageService;

@Slf4j
@Service
@PropertySource("classpath:smssource.properties")
public class MessageService {
	
	private DefaultMessageService messageService;
	
	private Properties prop = new Properties();
		
	public MessageService() throws IOException {
		File filepath = new File(MessageService.class.getResource("/smssource.properties").getPath());
		try {
			prop.load(new FileReader(filepath));
		} catch (IOException e) {
			log.error(e.getMessage(), e);
			throw e;
		}
		this.messageService = NurigoApp.INSTANCE.initialize(prop.getProperty("apiKey"), prop.getProperty("apiKeySecret"), prop.getProperty("url"));
	}
	
	@PostMapping("/send-one")
	public SingleMessageSentResponse sendMessage(Map<String, String> param) {
		Message message = new Message();
		message.setFrom(param.get("from"));
		message.setTo(param.get("to"));
		message.setText(param.get("text"));
		
		SingleMessageSentResponse response = this.messageService.sendOne(new SingleMessageSendingRequest(message));
		log.debug("response = {}", response);
		
		return response;
	}
	
	public void sendId(Member member){
		Map<String, String> map = new HashMap<>();
		
		String AllId = member.getId();
		String id = "";
		if(AllId.length() >= 8) {
			id = AllId.substring(0, AllId.length() - 4);
			id += "****";			
		}
		else {
			id = AllId.substring(0, AllId.length() - 3);
			id += "***";
		}
		String text = "[나:다움] 아이디 찾기 문자입니다. 회원님의 아이디는 " + id + "입니다.";
		
		map.put("to", member.getPhone());
		map.put("from", "");
		map.put("text", text);
		
		sendMessage(map);
	}
	
	public void sendPw(Member member) {
		Map<String, String> map = new HashMap<>();
		
		String password = member.getPassword();
		String text = "[나:다움] 비밀번호 찾기 문자입니다. 임시 비밀번호 : " + password;
		
		map.put("to", member.getPhone());
		map.put("from", "");
		map.put("text", text);
		
		sendMessage(map);
	}

	public void sendAuthenticationNum(Map<String, Object> map) {
		Map<String, String> sendMap = new HashMap<>();
		String text = "[나:다움] 인증번호입니다. [" + (String)map.get("num") + "]";
		String sender = prop.getProperty("from");
		sendMap.put("to", (String)map.get("phone"));
		sendMap.put("from", sender);
		sendMap.put("text", text);
		
		sendMessage(sendMap);
	}
	

}
