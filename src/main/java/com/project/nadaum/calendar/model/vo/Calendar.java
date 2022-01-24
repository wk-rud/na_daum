package com.project.nadaum.calendar.model.vo;

import java.io.Serializable;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class Calendar implements Serializable {

	private static final long serialVersionUID = 1L;

	private String no; 
	private String code; 
	private String groupId; 
	private String id; 
	private String title; 
	private String content;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date startDate; 
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date endDate; 
	
	private String type;
	private boolean allDay = false; 
	private String textColor; 
	private String backgroundColor; 
	private String borderColor;
}
