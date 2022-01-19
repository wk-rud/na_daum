package com.project.nadaum.kakaopay.ready.model.vo;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PayReady implements Serializable{
	
	
	private static final long serialVersionUID = -7879450914568709197L;
	
	private String cid;
	private String partnerOrderId;
	private String partnerUserId;
	private String itemName;
	private int quantity;
	private int totalAmount;
	private String sid;
	private String CARDS;
	
	enum CARDS{
		TOSS, KAKAO, SHINHAN, KB, HANA, NH, HYUNDAI, SAMSUNG, CITI  
	}
	

}
