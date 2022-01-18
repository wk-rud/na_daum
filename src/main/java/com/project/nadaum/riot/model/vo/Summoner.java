package com.project.nadaum.riot.model.vo;

import java.io.Serializable;
import java.util.Date;



import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Summoner implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private int no;
	private String accountId;
	private int profileIconId;
	private int revisionDate;
	private String name;
	private String id;
	private String puuid;
	private int summonerLevel;
	
	



}
