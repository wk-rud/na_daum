package com.project.nadaum.kakaopay.ready.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.nadaum.kakaopay.ready.model.vo.PayAuth;
import com.project.nadaum.kakaopay.ready.model.vo.PayReady;

@Repository
public class PayReadyDaoImpl implements PayReadyDao {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public int insertPayReady(PayReady payReady) {
		return sqlSession.insert("payReady.insertPayReady", payReady);
	}

	@Override
	public int insertPayAuth(PayAuth payAuth) {
		return sqlSession.insert("payAuth.insertPayAuth", payAuth);
	}

}
