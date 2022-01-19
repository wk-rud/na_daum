package com.project.nadaum.kakaopay.ready.model.service;

import java.util.Map;

import com.project.nadaum.kakaopay.ready.model.vo.PayAuth;
import com.project.nadaum.kakaopay.ready.model.vo.PayReady;

public interface PayReadyService {

	int insertPayReady(PayReady payReady);

	int insertPayAuth(PayAuth payAuth);

	int insertOneAuth(PayAuth payAuth);
}
