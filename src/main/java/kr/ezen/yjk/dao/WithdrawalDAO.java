package kr.ezen.yjk.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.ezen.yjk.vo.WithdrawalVO;

@Repository
public class WithdrawalDAO {

	
	@Autowired
	private SqlSession sqlSession;
	
	
	public void insertWithdrawal(WithdrawalVO withdrawalVO) {
		sqlSession.insert("mybatis.withdrawal.insertWithdrawal", withdrawalVO);
	}
	
	public void withdrawFamily(String id) {
		sqlSession.delete("mybatis.withdrawal.withdrawFamily", id);
	}
	
	
}
