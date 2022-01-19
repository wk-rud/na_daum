package com.project.nadaum.kakaopay.result.model.vo;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PayMemberInfo implements Serializable{/**
	 * 
	 */
	private static final long serialVersionUID = -3139595241770719114L;

	private int no;
	private String memberId;
	private String CARDS;
	private String payPw;
	
	enum CARDS{
		TOSS, KAKAO, SHINHAN, KB, HANA, NH, HYUNDAI, SAMSUNG, CITI  
	}
	
}
