package kr.ezen.yjk.service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.ezen.yjk.dao.LoginDAO;
import kr.ezen.yjk.dao.WithdrawalDAO;
import kr.ezen.yjk.vo.FamilyVO;
import kr.ezen.yjk.vo.WithdrawalVO;

@Service
public class WithdrawalService {

	@Autowired
	private WithdrawalDAO withdrawalDAO;
	@Autowired
	private LoginDAO loginDAO;
	
	
	@Transactional
	public void insertWithdrawal(String id) {
		HashMap<String, String> map=new HashMap<String, String>();
		map.put("id", id);
		FamilyVO familyVO=loginDAO.findFamilyById(map);
		
		WithdrawalVO withdrawalVO=new WithdrawalVO();
		withdrawalVO.setFidx(familyVO.getIdx());
		withdrawalVO.setPersonidx(familyVO.getPersonidx());
		withdrawalVO.setPassword(familyVO.getPassword());
		withdrawalVO.setPhone(familyVO.getPhone());

		withdrawalDAO.insertWithdrawal(withdrawalVO);
	}
	
	
	@Transactional
	public void withdrawFamily(String id) {
		withdrawalDAO.withdrawFamily(id);
	}
	
}
