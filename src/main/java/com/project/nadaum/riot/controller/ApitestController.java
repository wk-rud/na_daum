package com.project.nadaum.riot.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.project.nadaum.riot.model.service.RiotService;
import com.project.nadaum.riot.model.vo.Summoner;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/riot")
@Slf4j
public class ApitestController {

	final static String API_KEY = "RGAPI-d57b20b5-c168-4726-ad45-1ec37692fd1d";
	
	@Autowired
	private RiotService riotService;
	

	@RequestMapping("/riotheader.do")
	public void riotheader() {
		
	}

	@RequestMapping(value = "/riot1.do", method = RequestMethod.GET)
	public String searchSummoner(Model model, HttpServletRequest httpServletRequest,Summoner summoner) {
		BufferedReader br = null;
		String SummonerName = httpServletRequest.getParameter("nickname").replaceAll(" ", "%20");
		log.info("SummonerName = {}", SummonerName);
		
		Gson gson = new GsonBuilder().create();
		try {
			String urlstr = "https://kr.api.riotgames.com/lol/summoner/v4/summoners/by-name/" + SummonerName
					+ "?api_key=" + API_KEY;
			URL url = new URL(urlstr);
			HttpURLConnection urlconnection = (HttpURLConnection) url.openConnection();
			urlconnection.setRequestMethod("GET");
			br = new BufferedReader(new InputStreamReader(urlconnection.getInputStream(), "UTF-8"));
			String result = "";
			String line;
			while ((line = br.readLine()) != null) {
				result = result + line;
			}

			log.info("summoner = {}", result);
			JsonElement element = JsonParser.parseString(result);

			JsonObject object = element.getAsJsonObject();

			int profileIconId = object.get("profileIconId").getAsInt();
			String name = object.get("name").getAsString();
			String puuid = object.get("puuid").getAsString();
			int summonerLevel = object.get("summonerLevel").getAsInt();
			int revisionDate = object.get("revisionDate").getAsInt();
			String id = object.get("id").getAsString();
			String accountId = object.get("accountId").getAsString();
			summoner = new Summoner(0, accountId, profileIconId, revisionDate, name, id, puuid, summonerLevel);
			log.info("summoner = {}", summoner);
			int summonerrecord = riotService.insertSummoner(summoner);
			
			String msg = summonerrecord > 0 ? "summoner 등록 성공!" : "summoner 등록 실패!";
			log.info("msg = {}", msg);

		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		
		
		
		model.addAttribute("summoner", summoner);
		model.addAttribute("imgURL",
				"http://ddragon.leagueoflegends.com/cdn/12.1.1/img/profileicon/" + summoner.getProfileIconId() + ".png");
		
		
		return "riot/riotheader";

	}
	

	
	
	

}
