package com.project.nadaum.kakaopay.result.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.nadaum.kakaopay.result.model.vo.PayMemberInfo;
import com.project.nadaum.kakaopay.result.model.vo.PayResult;

@Repository
public class PayResultDaoImpl implements PayResultDao {

	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public int insertPayResult(PayResult payResult) {
		return sqlSession.insert("payResult.insertPayResult", payResult);
	}
	
	@Override
	public int deletePayResult(int no) {
		return sqlSession.insert("payResult.insertPayResult", no);
	}
	
	@Override
	public int updatePayResult(PayResult payResult) {
		return sqlSession.insert("payResult.updatePayResult", payResult);
	}
	

	@Override
	public List<Map<String, Object>> selectOnePayResult(String partnerOrderId) {
		return sqlSession.selectOne("payResult.selectOnepayResultList", partnerOrderId);
	}

	
	@Override
	public List<Map<String, Object>> selectListPayResult(String partnerUserId) {
		return sqlSession.selectList("payResult.selectListPayResult", partnerUserId);
	}

	@Override
	public PayMemberInfo selectOnePayMemberInfo(String partnerUserId) {
		return sqlSession.selectOne("payResult.selectOnePayMemberInfo",partnerUserId);
	}

}
