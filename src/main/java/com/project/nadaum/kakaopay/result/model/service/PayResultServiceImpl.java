package com.project.nadaum.kakaopay.result.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.nadaum.kakaopay.result.model.dao.PayResultDao;
import com.project.nadaum.kakaopay.result.model.vo.PayMemberInfo;
import com.project.nadaum.kakaopay.result.model.vo.PayResult;

@Service
public class PayResultServiceImpl implements PayResultService{

	@Autowired
	private PayResultDao payResultDao;
	
	@Override
	public int insertPayResult(PayResult payResult) {
		int result = payResultDao.insertPayResult(payResult);
		return result;
	}

	@Override
	public PayMemberInfo selectOnePayMemberInfo(String memberId) {
		PayMemberInfo payMemberInfo = payResultDao.selectOnePayMemberInfo(memberId);
		return payMemberInfo;
	}

}
