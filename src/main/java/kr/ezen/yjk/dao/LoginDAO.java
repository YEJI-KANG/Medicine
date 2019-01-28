package kr.ezen.yjk.dao;

import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.ezen.yjk.vo.FamilyVO;

@Repository
public class LoginDAO {

	@Autowired
	private SqlSession sqlSession;
	
	public int countFamilyByPersonidx(int idx) {
		return sqlSession.selectOne("mybatis.login.countFamilyByPersonidx", idx);
	}
	
	public int countFamilyById(HashMap<String, String> map) {
		return sqlSession.selectOne("mybatis.login.countFamilyById", map);
	}
	
	public FamilyVO findFamilyById(HashMap<String, String> map) {
		return sqlSession.selectOne("mybatis.login.findFamilyById", map);
	}
	
	public FamilyVO findFamilyByPersonIdx(int personidx) {
		return sqlSession.selectOne("mybatis.login.findFamilyByPersonIdx", personidx);
	}

	public void resetFamilyPassword(int idx) {
		sqlSession.update("mybatis.login.resetFamilyPassword", idx);
	}
	
	public void insert(FamilyVO familyVO) {
		sqlSession.insert("mybatis.login.insertFamily", familyVO);
	}
	
	
}
