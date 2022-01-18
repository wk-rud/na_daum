package com.project.nadaum.riot.model;

import java.io.Serializable;
import java.util.Date;



import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Summoner implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private int profileIconId;
	private String name;
	private String puuid;
	private long summonerLevel;
	private long revisionDate;
	private String id;
	private String accountId;
	
	






}
