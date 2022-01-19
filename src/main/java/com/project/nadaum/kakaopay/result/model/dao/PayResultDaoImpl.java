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
	public List<Map<String, Object>> selectOnePayResult(String memberId) {
		return sqlSession.selectOne("payResult.selectOnepayResultList", memberId);
	}

	
	@Override
	public List<Map<String, Object>> selectListPayResult(String memberId) {
		return sqlSession.selectList("payResult.selectListPayResult", memberId);
	}
	
	@Override
	public PayMemberInfo selectOnePayMemberInfo(String memberId) {
		return sqlSession.selectOne("payMemberInfo.selectOnePayMemberInfo",memberId);
	}

}
