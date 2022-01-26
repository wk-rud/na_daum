package com.project.nadaum.admin.model.vo;

import java.io.Serializable;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Help implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String code;
	private String id;
	private String category;
	private String title;
	private String content;
	private String count;
	private Date regDate;
	private String status;
	private String aCode;
	private String aTitle;
	private String aContent;
	private String aCount;
	private Date aRegDate;
	
	
}
