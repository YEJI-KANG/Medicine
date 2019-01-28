package kr.ezen.yjk.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.ezen.yjk.vo.FamilyVO;

@Repository
public class FamilyDAO {

	@Autowired
	private SqlSession sqlSession;
	
	public int selectCount() {
		return sqlSession.selectOne("mybatis.family.selectCount");
	}
	
	public List<FamilyVO> selectList(HashMap<String, Integer> map){
		return sqlSession.selectList("mybatis.family.selectList", map);
	}
	
	
	
	
	public void updateFamilyByAdmin(HashMap<String, String> map) {
		sqlSession.update("mybatis.family.updateFamilyByAdmin", map);
	}
	
	public void updateFamilyByUser(HashMap<String, String> map) {
		sqlSession.update("mybatis.family.updateFamilyByUser", map);
	}
	
	public void updatePersonPointMinus500(HashMap<String, Integer> map) {
		sqlSession.update("mybatis.family.updatePersonPointMinus500", map);
	}
	
	
}
