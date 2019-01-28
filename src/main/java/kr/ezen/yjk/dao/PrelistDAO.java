package kr.ezen.yjk.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.ezen.yjk.vo.DrugVO;
import kr.ezen.yjk.vo.PersonVO;
import kr.ezen.yjk.vo.PrelistVO;

@Repository
public class PrelistDAO {

	@Autowired
	private SqlSession sqlSession;
	
	public int selectCount() {
		return sqlSession.selectOne("mybatis.prelist.selectCount");
	}
	public List<PrelistVO> selectList(HashMap<String, Integer> map){ //endno, startno 담겨있어야함
		return sqlSession.selectList("mybatis.prelist.selectList", map);
	}
	
	public List<PrelistVO> searchList1(HashMap<String, String> map){
		return sqlSession.selectList("mybatis.prelist.searchList1", map);
	}
	public List<PrelistVO> searchList2(HashMap<String, String> map){
		return sqlSession.selectList("mybatis.prelist.searchList2", map);
	}
	public List<PrelistVO> searchList3(HashMap<String, String> map){
		return sqlSession.selectList("mybatis.prelist.searchList3", map);
	}

	
	public PersonVO findPersonByFK(int personidx) {
		return sqlSession.selectOne("mybatis.prelist.findPersonByFK", personidx);
	}
	public PersonVO findPersonByNameId(PersonVO personVO) {
		return sqlSession.selectOne("mybatis.prelist.findPersonByNameId", personVO);
	}
	
	
	
	public List<DrugVO> findDrugListByFK(int idx){
		return sqlSession.selectList("mybatis.prelist.findDrugListByFK", idx);
	}
	public DrugVO findDrugByNameHow(DrugVO drugVO){
		return sqlSession.selectOne("mybatis.prelist.findDrugByNameHow", drugVO);
	}
	
	public PrelistVO findPrelistByDateHos(PrelistVO prelistVO) {
		return sqlSession.selectOne("mybatis.prelist.findPrelistByDateHos", prelistVO);
	}
	public PrelistVO findPrelistByIdx(int idx) {
		return sqlSession.selectOne("mybatis.prelist.findPrelistByIdx", idx);
	}
	
	
	public void insertPerson(PersonVO personVO) {
		sqlSession.insert("mybatis.prelist.insertPerson", personVO);
	}
	public void insertPrelist(PrelistVO prelistVO) {
		sqlSession.insert("mybatis.prelist.insertPrelist", prelistVO);
	}
	public void insertDrug(DrugVO drugVO) {
		sqlSession.insert("mybatis.prelist.insertDrug", drugVO);
	}
	
	//update
	public void updatePersonTempCount(int personidx) {
		sqlSession.update("mybatis.prelist.updatePersonTempCount", personidx);
	}
	public void updatePersonTempCountMinus(int personidx) {
		sqlSession.update("mybatis.prelist.updatePersonTempCountMinus", personidx);
	}
	
	public void updatePersonPointPlus(int idx) {
		sqlSession.update("mybatis.prelist.updatePersonPointPlus", idx);
	}
	
	public void updatePersonPointMinus(int idx) {
		sqlSession.update("mybatis.prelist.updatePersonPointMinus", idx);
	}
	
	
	
	
	public void updatePrelist(PrelistVO prelistVO) {
		sqlSession.update("mybatis.prelist.updatePrelist", prelistVO);
	}
	public void updatePerson(PersonVO personVO) {
		sqlSession.update("mybatis.prelist.updatePerson", personVO);
	}
	public void updateDrug(DrugVO drugVO) {
		sqlSession.update("mybatis.prelist.updateDrug", drugVO);
	}

	public int countPersonByNameId(PersonVO personVO) {
		return sqlSession.selectOne("mybatis.prelist.countPersonByNameId", personVO);
	}
	public int countDrugByNameHow(DrugVO drugVO) {
		return sqlSession.selectOne("mybatis.prelist.countDrugByNameHow", drugVO);
	}
	
	
	//Delete
	public void deletePerson(int idx) {
		sqlSession.delete("mybatis.prelist.deletePerson", idx);
	}
	public void deleteDrug(int idx) {
		sqlSession.delete("mybatis.prelist.deleteDrug", idx);
	}
	public void deleteDrugByListidx(int listidx) {
		sqlSession.delete("mybatis.prelist.deleteDrugByListidx", listidx);
	}
	public void deletePrelist(int idx) {
		sqlSession.delete("mybatis.prelist.deletePrelist", idx);
	}
	
	
	
	
	//user
	public int selectMyCount(int personidx) {
		return sqlSession.selectOne("mybatis.prelist.selectMyCount", personidx);
	}
	
	public List<PrelistVO> selectMyList(HashMap<String, Integer> map){
		return sqlSession.selectList("mybatis.prelist.selectMyList", map);
	}

}
