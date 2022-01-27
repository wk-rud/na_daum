package com.project.nadaum.diary.model.vo;

import java.io.Serializable;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Diary implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private String code;
	private String id;
	private String content;
	private Date regDate;
	private int emotionNo;
	private String isPublic;

}
