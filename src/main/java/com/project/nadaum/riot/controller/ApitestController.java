package com.project.nadaum.riot.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.servlet.http.HttpServletRequest;

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
import com.project.nadaum.riot.model.Summoner;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/riot")
@Slf4j
public class ApitestController {

	final static String API_KEY = "RGAPI-dd3554e4-31d1-48dd-9398-821873ca80c8";

	@RequestMapping("/riotheader.do")
	public String riotheader() {
		return "riot/riotheader";
	}

	@RequestMapping(value = "/riot1.do", method = RequestMethod.GET)
	public String searchSummoner(Model model, HttpServletRequest httpServletRequest) {
		BufferedReader br = null;
		String SummonerName = httpServletRequest.getParameter("nickname").replaceAll(" ", "%20");
		log.info("dev = {}", SummonerName);
		Summoner temp = null;
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

			log.info("dev = {}", result);
			JsonElement element = JsonParser.parseString(result);

			JsonObject object = element.getAsJsonObject();

			int profileIconId = object.get("profileIconId").getAsInt();
			String name = object.get("name").getAsString();
			String puuid = object.get("puuid").getAsString();
			long summonerLevel = object.get("summonerLevel").getAsLong();
			long revisionDate = object.get("revisionDate").getAsLong();
			String id = object.get("id").getAsString();
			String accountId = object.get("accountId").getAsString();
			temp = new Summoner(profileIconId, name, puuid, summonerLevel, revisionDate, id, accountId);

			log.info("dev = {}", temp);

		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		log.info("dev = {}", temp);
		model.addAttribute("summoner", temp);
		model.addAttribute("imgURL",
				"http://ddragon.leagueoflegends.com/cdn/12.1.1/img/profileicon/" + temp.getProfileIconId() + ".png");
		return "riot/riotheader";

	}

}
