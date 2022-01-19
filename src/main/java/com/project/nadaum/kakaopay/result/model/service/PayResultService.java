package com.project.nadaum.kakaopay.result.model.service;

import com.project.nadaum.kakaopay.result.model.vo.PayMemberInfo;
import com.project.nadaum.kakaopay.result.model.vo.PayResult;

public interface PayResultService {

	int insertPayResult(PayResult payResult);

	PayMemberInfo selectOnePayMemberInfo(String memberId);

}
