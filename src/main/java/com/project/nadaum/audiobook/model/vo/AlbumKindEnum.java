package com.project.nadaum.audiobook.model.vo;

public enum AlbumKindEnum {

	ASMR("asmr"),
	MCOVER("뮤직커버"),
	NEWAGE("뉴에이지"),
	CLASSIC("클래식"),
	JAZZ("재즈"),
	LIVE("라이브"),
	INDIE("인디"),
	FAIRYTALE("동화책"),
	POEM("시"),
	NOVEL("소설"),
	ENG("영어");
	
	
	private String kind;
	
	AlbumKindEnum(String kind){
		this.kind = kind;
	}
	
	public String getKind() {
		return kind;
	}
}
