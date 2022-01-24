package com.project.nadaum.member.model.service;

import java.util.Random;
import java.util.UUID;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.stereotype.Service;

import com.project.nadaum.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class MailSendService {

	@Autowired
	private JavaMailSenderImpl mailSender;
	
	private int size;
	
	private String getKey(int size) {
		this.size = size;
		return getAuthCode();
	}
	
	private String getAuthCode() {
		Random random = new Random();
		StringBuffer buffer = new StringBuffer();
		int num = 0;
		
		while(buffer.length() < size) {
			num = random.nextInt(10);
			buffer.append(num);
		}
		
		return buffer.toString();
	}
	
	public String sendAuthMail(String email) throws MessagingException {
		String authKey = getKey(6);
		
		MimeMessage mimeMessage = mailSender.createMimeMessage();
		String mailContent = "<h1>회원가입 이메일 인증</h1><br/><p>아래 링크를 클릭하시면 이메일 인증이 완료됩니다.</p>"
						   + "<a href='http://localhost:9090/nadaum/member/memberConfirm.do?email=" + email
						   + "&authKey=" + authKey + "'>이메일 인증 확인하고 로그인하기</a>";
		
		try {
			mimeMessage.setSubject("회원가입 이메일 인증 ", "utf-8");
			mimeMessage.setText(mailContent, "utf-8", "html");
			mimeMessage.addRecipient(Message.RecipientType.TO, new InternetAddress(email));
			mailSender.send(mimeMessage);
		} catch (MessagingException e) {
			log.error(e.getMessage(), e);
			throw e;
		}
				
		return authKey;
	}

	public void sendIdByEmail(Member member) throws MessagingException {
		
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
		
		MimeMessage mimeMessage = mailSender.createMimeMessage();
		String mailContent = "<h1>나:다움 아이디 찾기(이메일로 찾기)</h1><br/><span>아이디 : " + id + "</span><br />"
						   + "<p><a href='http://localhost:9090/nadaum/member/memberLogin.do'>나:다움 로그인하기</a> "
						   + "링크를 통해 로그인 하실 수 있습니다.</p>";
		try {
			mimeMessage.setSubject("아이디 찾기 이메일 ", "utf-8");
			mimeMessage.setText(mailContent, "utf-8", "html");
			mimeMessage.addRecipient(Message.RecipientType.TO, new InternetAddress(member.getEmail()));
			mailSender.send(mimeMessage);
		}catch(MessagingException e) {
			log.error(e.getMessage(), e);
			throw e;
		}
	}

	public void sendTemporaryPassword(Member member) throws MessagingException {
		
		String temporaryPw = getTemporaryPassword();

		MimeMessage mimeMessage = mailSender.createMimeMessage();
		String mailContent = "<h1>나:다움 임시 비밀번호 발급</h1><br/><span>임시 비밀번호 : " + temporaryPw + "</span><br />"
						   + "<a href='http://localhost:9090/nadaum/member/memberTemporaryPassword.do?email=" + member.getEmail()
						   + "&tempPw=" + temporaryPw + "'>나:다움 로그인하기</a><br /><p>링크를 클릭하여 로그인하시고 비밀번호를 수정시기 바랍니다.</p>";
		
		try {
			mimeMessage.setSubject("임시 비밀번호 이메일 ", "utf-8");
			mimeMessage.setText(mailContent, "utf-8", "html");
			mimeMessage.addRecipient(Message.RecipientType.TO, new InternetAddress(member.getEmail()));
			mailSender.send(mimeMessage);
		} catch (MessagingException e) {
			log.error(e.getMessage(), e);
			throw e;
		}
		
	}
	
	public String getTemporaryPassword() {
		
		String temporaryPassword = "";
		try {
			temporaryPassword = UUID.randomUUID().toString().replaceAll("-", "");
			temporaryPassword = temporaryPassword.substring(0, 10);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			throw e;
		}
		return temporaryPassword;
		
	}
	
}
