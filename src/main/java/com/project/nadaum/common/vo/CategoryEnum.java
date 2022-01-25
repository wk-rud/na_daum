package com.project.nadaum.common.vo;

public enum CategoryEnum {
	
	질문("he"), 답변("ah"), 공지사항("an"), 친구("fr"), 친구요청("rf"), 다이어리("dy"), 가계부("ab"), 메모("me")
	,문화("cu");
	private String category;
	
	CategoryEnum(String category) {
		this.category = category;
	}
	
	public static CategoryEnum _valueOf(String category) {
		switch(category) {
		case "he": return 질문;
		case "ah": return 답변;
		case "an": return 공지사항;
		case "fr": return 친구;
		case "rf": return 친구요청;
		case "dy": return 다이어리;
		case "ab": return 가계부;
		case "me": return 메모;
		case "cu": return 문화;
		default: throw new AssertionError("Unknow Type Error: " + category);
		}
	}

}
