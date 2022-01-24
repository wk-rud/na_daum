package com.project.nadaum.member.model.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class KakaoService {

	public String getAccessToken(String authorize_code) {
		String access_Token = "";
		String refresh_Token = "";
		String reqURL = "https://kauth.kakao.com/oauth/token";
		log.debug("reqURL={}",reqURL);
		try {
			URL url = new URL(reqURL);
			log.debug("reqURL={}",reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			
			conn.setRequestMethod("POST");
			conn.setDoOutput(true);
			
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
			StringBuilder sb = new StringBuilder();
			sb.append("grant_type=authorization_code");
			sb.append("&client_id=c80d58b59fb1195ccc3d03f74e607831");
			sb.append("&redirect_uri=http://localhost:9090/nadaum/member/memberKakaoLogin.do");
			sb.append("&code=" + authorize_code);
			bw.write(sb.toString());
			bw.flush();
			
			int responseCode = conn.getResponseCode();
			log.debug("responseCode = {}", responseCode);
			
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String line = "";
			String result = "";
			
			while((line = br.readLine()) != null) {
				result += line;
			}
			log.debug("response body = {}", result);
			
			JsonElement element = JsonParser.parseString(result);
			
			access_Token = element.getAsJsonObject().get("access_token").getAsString();
			refresh_Token = element.getAsJsonObject().get("refresh_token").getAsString();
			
			log.debug("access_token = {} refresh_token = {}", access_Token, refresh_Token);
			
			br.close();
			bw.close();
		}catch(IOException e) {
			log.error(e.getMessage(), e);
		}
		
		return access_Token;
	}
	
	public Map<String, Object> getUserInfo(String access_Token){
		Map<String, Object> userInfo = new HashMap<>();
		String reqURL = "https://kapi.kakao.com/v2/user/me";
		
		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("POST");
			conn.setDoOutput(true);
			conn.setRequestProperty("Authorization", "Bearer " + access_Token);
			
			log.debug("access_Token = {}", access_Token);
			int responseCode = conn.getResponseCode();
			log.debug("responseCode = {}", responseCode);
			
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			
			String line = "";
			String result = "";
			
			while((line = br.readLine()) != null) {
				result += line;
			}
			log.debug("response body = {}", result);
			
			JsonElement element = JsonParser.parseString(result);
			
			JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
			JsonObject kakao_account = element.getAsJsonObject().get("kakao_account").getAsJsonObject();
			
			String id = element.getAsJsonObject().get("id").getAsString();
			String name = properties.getAsJsonObject().get("nickname").getAsString();
			String profile_image = "";
			
//			String getImage = properties.getAsJsonObject().get("thumbnail_image").getAsString();
//			if(getImage != null && !getImage.isEmpty())
//				profile_image = getImage;
			
			String updateImage = updateUserInfo(access_Token);
			if(updateImage != null && !updateImage.isEmpty())
				profile_image = updateImage;
			else
				profile_image = "https://file.mk.co.kr/meet/neds/2021/02/image_readbot_2021_144269_16137158354538199.jpeg";
			log.debug("profile_image = {}", profile_image);
			
			SimpleDateFormat sdf = new SimpleDateFormat("dd");
			String sysDay = sdf.format(new Date());
			String nickname = Math.random() * 999 + sysDay + "임시닉네임";
			
			userInfo.put("id", id);
			userInfo.put("name", name);
			userInfo.put("nickname", nickname);
			userInfo.put("profile_image", profile_image);
			
		}catch(IOException e) {
			log.error(e.getMessage(), e);
		}
		
		return userInfo;
	}
	
	public String updateUserInfo(String access_Token) {
		String thumbnail = "";
		String reqURL = "https://kapi.kakao.com/v1/api/talk/profile";
		
		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			conn.setDoOutput(true);
			conn.setRequestProperty("Authorization", "Bearer " + access_Token);
			
			log.debug("access_Token = {}", access_Token);
			int responseCode = conn.getResponseCode();
			log.debug("responseCode = {}", responseCode);
			
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			
			String line = "";
			String result = "";
			
			while((line = br.readLine()) != null) {
				result += line;
			}
			log.debug("responseBody = {}", result);
			
			JsonElement element = JsonParser.parseString(result);
			
			thumbnail = element.getAsJsonObject().get("thumbnailURL").getAsString();
			log.debug("thumbnail = {}", thumbnail);
		} catch (IOException e) {
			log.error(e.getMessage(), e);
		}
		
		return thumbnail;		
	}
	
}
