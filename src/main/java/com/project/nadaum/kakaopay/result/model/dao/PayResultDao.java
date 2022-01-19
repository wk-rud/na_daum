package com.project.nadaum.kakaopay.result.model.dao;

import java.util.List;
import java.util.Map;

import com.project.nadaum.kakaopay.result.model.vo.PayMemberInfo;
import com.project.nadaum.kakaopay.result.model.vo.PayResult;

public interface PayResultDao {

	int insertPayResult(PayResult payResult);

	int updatePayResult(PayResult payResult);

	int deletePayResult(int no);

	List<Map<String, Object>> selectOnePayResult(String partnerOrderId);

	List<Map<String, Object>> selectListPayResult(String partnerUserId);

	PayMemberInfo selectOnePayMemberInfo(String partnerUserId);

}
