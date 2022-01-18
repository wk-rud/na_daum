package com.project.nadaum.kakaopay.ready.model.vo;

import java.io.Serializable;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PayAuth implements Serializable{/**
	 * 
	 */
	private static final long serialVersionUID = -7802689701998289246L;
	
	private String partnerOrderId;
	private String tid;
	private String pgToken;
	private Date createdAt;
}
