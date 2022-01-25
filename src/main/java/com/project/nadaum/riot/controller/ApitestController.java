package com.project.nadaum.riot.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.google.gson.JsonPrimitive;
import com.project.nadaum.riot.model.service.RiotService;
import com.project.nadaum.riot.model.vo.LeagueEntries;
import com.project.nadaum.riot.model.vo.LeagueEntry;
import com.project.nadaum.riot.model.vo.Match;
import com.project.nadaum.riot.model.vo.Summoner;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/riot")
@Slf4j
public class ApitestController {

	final static String API_KEY = "RGAPI-0523f4d9-f29a-4f58-8f97-72b8a158a55f";

	@Autowired
	private RiotService riotService;

	@RequestMapping("/riotheader.do")
	public void riotheader() {

	}

	@RequestMapping(value = "/riot1.do", method = RequestMethod.GET)
	public String searchSummoner(Model model, HttpServletRequest httpServletRequest, 
			Summoner summoner,LeagueEntry leagueentry,LeagueEntries leagueentries, Match match) {
		BufferedReader br = null;
		String SummonerName = httpServletRequest.getParameter("nickname").replaceAll(" ", "%20");
	
		log.info("SummonerName = {}", SummonerName);

		Gson gson = new GsonBuilder().create();
		// 소환사이름으로 검색 - 소환사 정보 가져오기
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

			Summoner dbsummoner = riotService.selectOneSummoner(puuid);
			log.info("dbsummoner = {}", dbsummoner);

			if (dbsummoner == null) {
				int summonerrecord = riotService.insertSummoner(summoner);

				String msg = summonerrecord > 0 ? "summoner 등록 성공!" : "summoner 등록 실패!";
				log.info("msg = {}", msg);
			} else {
				String msg = "이미 db에 저장되어있는 summoner입니다";
				log.info("msg = {}", msg);
			}

		} catch (Exception e) {
			System.out.println(e.getMessage());
		}

		// 가져온 소환사id로 검색 - 소환사 개인랭크/ 자유랭크 정보 가져오기
		try {
			String urlstr = "https://kr.api.riotgames.com/lol/league/v4/entries/by-summoner/" + summoner.getId()
					+ "?api_key=" + API_KEY;
			URL url = new URL(urlstr);
			HttpURLConnection urlconnection = (HttpURLConnection) url.openConnection();
			urlconnection.setRequestMethod("GET");
			br = new BufferedReader(new InputStreamReader(urlconnection.getInputStream(), "UTF-8")); 
			String resulttier = "";
			String line;
			while ((line = br.readLine()) != null) { 
				resulttier =resulttier + line;
			}
			log.info("resulttier = {}", resulttier);
			JsonArray element = (JsonArray) JsonParser.parseString(resulttier);
			JsonObject object = (JsonObject) element.get(0);
			
			int wins = object.get("wins").getAsInt();
			int losses = object.get("losses").getAsInt();
			String rank = object.get("rank").getAsString();
			String tier = object.get("tier").getAsString();
			String queueType = object.get("queueType").getAsString();
			int leaguePoints = object.get("leaguePoints").getAsInt();
			String leagueId = object.get("leagueId").getAsString();
			leagueentry = new LeagueEntry(0,leagueId,queueType,tier,rank,leaguePoints,wins,losses);
			log.info("leagueentry = {}", leagueentry);
			
			if(element.get(1) != null)
			{
				JsonObject object2 = (JsonObject) element.get(1);
				int wins2 = object2.get("wins").getAsInt();
				int losses2 = object2.get("losses").getAsInt();
				String rank2 = object2.get("rank").getAsString();
				String tier2 = object2.get("tier").getAsString();
				String queueType2 = object2.get("queueType").getAsString();
				int leaguePoints2 = object2.get("leaguePoints").getAsInt();
				String leagueId2 = object2.get("leagueId").getAsString();
				leagueentries = new LeagueEntries(0,leagueId2,queueType2,tier2,rank2,leaguePoints2,wins2,losses2);
				log.info("leagueentries = {}", leagueentries);
				
			}
			
	
		
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}

		// 가져온 소환사puuid로 검색 - 소환사 매치 정보 가져오기
		try {
			String urlstr = "https://asia.api.riotgames.com/lol/match/v5/matches/by-puuid/" + summoner.getPuuid()
					+ "/ids?start=0&count=20&api_key=" + API_KEY;
			URL url = new URL(urlstr);
			HttpURLConnection urlconnection = (HttpURLConnection) url.openConnection();
			urlconnection.setRequestMethod("GET");
			br = new BufferedReader(new InputStreamReader(urlconnection.getInputStream(), "UTF-8")); 
			String resulttier = "";
			String line;
			while ((line = br.readLine()) != null) { 
				resulttier =resulttier + line;
			}
			log.info("resulttier = {}", resulttier);
			JsonElement element = JsonParser.parseString(resulttier);
			JsonArray array = element.getAsJsonArray();
			log.info("array = {}", array);
			
			List<Match> list = new ArrayList<Match>();
			
			
			for(int i=0; i<20; i++)
			{
				list.add(new Match(array.get(i).getAsString()));
			}
			
			log.info("list = {}", list);
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		
		
		
		try {
			String urlstr = "https://asia.api.riotgames.com/lol/match/v5/matches/by-puuid/" + match.getMatchId()
					+ "/ids?start=0&count=20&api_key=" + API_KEY;
			URL url = new URL(urlstr);
			HttpURLConnection urlconnection = (HttpURLConnection) url.openConnection();
			urlconnection.setRequestMethod("GET");
			br = new BufferedReader(new InputStreamReader(urlconnection.getInputStream(), "UTF-8")); 
			String resulttier = "";
			String line;
			while ((line = br.readLine()) != null) { 
				resulttier =resulttier + line;
			}
			log.info("resulttier = {}", resulttier);
			JsonElement element = JsonParser.parseString(resulttier);
			JsonArray array = element.getAsJsonArray();
			log.info("array = {}", array);
			
			List<Match> list = new ArrayList<Match>();
			
			
			for(int i=0; i<20; i++)
			{
				list.add(new Match(array.get(i).getAsString()));
			}
			
			log.info("list = {}", list);
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}

		model.addAttribute("summoner", summoner);
		model.addAttribute("img", "http://ddragon.leagueoflegends.com/cdn/12.1.1/img/profileicon/"
				+ summoner.getProfileIconId() + ".png");
		model.addAttribute("leagueentry", leagueentry);
		model.addAttribute("leagueentries", leagueentries);
		model.addAttribute("tierImg", "/resources/image/riot/"+leagueentry.getTier()+".png");
		model.addAttribute("tierImg", "/resources/image/riot/"+leagueentries.getTier()+".png");
		
		

		return "riot/riotmain";

	}

	@RequestMapping("/riotmain.do")
	public void riotmain() {

	}
}
