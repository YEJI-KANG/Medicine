package kr.ezen.yjk.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.ezen.yjk.dao.FamilyDAO;
import kr.ezen.yjk.dao.LoginDAO;
import kr.ezen.yjk.dao.PrelistDAO;
import kr.ezen.yjk.vo.FamilyVO;
import kr.ezen.yjk.vo.Paging;
import kr.ezen.yjk.vo.PersonVO;

@Service
public class FamilyService {

	@Autowired
	private FamilyDAO familyDAO;
	@Autowired
	private PrelistDAO prelistDAO;
	@Autowired
	private LoginDAO loginDAO;
	
	
	public int selectCount() {
		return familyDAO.selectCount();
	}
	
	public Paging<FamilyVO> selectList(int currentPage,int pageSize,int blockSize){
		Paging<FamilyVO> paging=null;
		int totalCount=familyDAO.selectCount();
		paging=new Paging<FamilyVO>(totalCount, currentPage, pageSize, blockSize);
		
		if(totalCount>0) {
			HashMap<String, Integer> map=new HashMap<String, Integer>();
			map.put("endNo", paging.getEndNo());
			map.put("startNo", paging.getStartNo());
			List<FamilyVO> list=familyDAO.selectList(map);
			
			for(FamilyVO vo:list) {
				PersonVO personVO=prelistDAO.findPersonByFK(vo.getPersonidx());
				String name=personVO.getName();
				String idnum1=personVO.getIdnum1();
				String idnum2=personVO.getIdnum2();
				String temp1=personVO.getTemp1();
				int point=personVO.getPoint();
				
				vo.setName(name);
				vo.setIdnum1(idnum1);
				vo.setIdnum2(idnum2);
				vo.setTemp1(temp1);;
				vo.setPoint(point);
				
				}
			
			paging.setLists(list);	
		}
			
		return paging;
	}
	
	@Transactional
	public void updateFamilyByAdmin(String password) {
		HashMap<String, String> map=new HashMap<String, String>();
		map.put("password", password);
		familyDAO.updateFamilyByAdmin(map);
	}
	
	
	
	
	// User ---------------------------------------------------------------------------------
	
	@Transactional
	public FamilyVO findAccountInfo(String id) {
		FamilyVO vo=null;
		
		HashMap<String, String> map=new HashMap<String, String>();
		map.put("id", id);
		vo=loginDAO.findFamilyById(map);
		//부족한정보추가(personVO에 있음)
		PersonVO personVO=prelistDAO.findPersonByFK(vo.getPersonidx());
		String name=personVO.getName();
		String idnum1=personVO.getIdnum1();
		String idnum2=personVO.getIdnum2();
		int point=personVO.getPoint();
		vo.setName(name);
		vo.setIdnum1(idnum1);
		vo.setIdnum2(idnum2);
		vo.setPoint(point);
		return vo;
	
	}
	
	@Transactional
	public void updateFamilyByUser(String id,String password,String phone) {
		HashMap<String, String> map=new HashMap<String, String>();
		map.put("id", id);
		map.put("password", password);
		map.put("phone", phone);
		familyDAO.updateFamilyByUser(map);
	}
	
	
	@Transactional
	public void updatePersonPointMinus500(int idx,int point) {
		HashMap<String, Integer> map=new HashMap<String, Integer>();
		map.put("idx", idx);
		map.put("point",point);
		familyDAO.updatePersonPointMinus500(map);
	}
	
	
	
	
	
	
	
}
