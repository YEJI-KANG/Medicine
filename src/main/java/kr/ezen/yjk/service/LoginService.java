package kr.ezen.yjk.service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.ezen.yjk.dao.LoginDAO;
import kr.ezen.yjk.dao.PrelistDAO;
import kr.ezen.yjk.vo.FamilyVO;
import kr.ezen.yjk.vo.PersonVO;

@Service
public class LoginService {

	@Autowired
	private LoginDAO loginDAO;
	@Autowired
	private PrelistDAO prelistDAO;
	
	
	public int familyCheck(FamilyVO familyVO,PersonVO personVO) {
		
		int result=0;

		//약국이용한적있음
		if(prelistDAO.findPersonByNameId(personVO)!=null) {
			
			//이전회원가입여부없음=회원가입가능
			int idx=prelistDAO.findPersonByNameId(personVO).getIdx();
			if(loginDAO.countFamilyByPersonidx(idx)==0) {
				result=3;
			}
			//이전가입한적있음(아이디 이미존재)
			else{result=2;}
		}
		//약국이용한적없음
		else {result=1;}
		
		
		return result;
	}
	
	public int countFamilyById(String id) {
		HashMap<String, String> map=new HashMap<String, String>();
		map.put("id", id);
		
		return loginDAO.countFamilyById(map);
	}
	
	@Transactional
	public void insert(FamilyVO familyVO, PersonVO personVO) {
		
		int personidx=prelistDAO.findPersonByNameId(personVO).getIdx();
		familyVO.setPersonidx(personidx);
		
		loginDAO.insert(familyVO);
		
	}
	
	
	@Transactional
	public int loginCheck(String id, String password) {
		
		int result;
		HashMap<String, String> map=new HashMap<String, String>();
		map.put("id", id);
		

		//아이디가 db에 존재함
		if(loginDAO.countFamilyById(map)==1) {
			
			//temp1값이 '1': 로그인가능자
			if((loginDAO.findFamilyById(map)).getTemp1().equals("1")) {
				
				//비번 일치함
				if((loginDAO.findFamilyById(map).getPassword()).equals(password)) {
				
					//Admin계정
					if(loginDAO.findFamilyById(map).getIdx()==1) {
						result=0;
					}
					//일반유저계정
					else {result=3;}
			}
				//비번 틀림
				else {result=2;}
			}
			
			//temp1값이 '0': 회원탈퇴자
			else {result=4;}
			
		}
		
		//아이디가 db에 없음
		else {result=1;}
		
		return result;
	}
	
	
	//아이디 찾기
	@Transactional
	public String findId(PersonVO personVO) {
		
		String result="";
		
		//적어도 약국이용자
		if(prelistDAO.countPersonByNameId(personVO)>0) {
			PersonVO vo=prelistDAO.findPersonByNameId(personVO);
			int personidx=vo.getIdx();
			
			//회원가입도 함(아이디 찾아줄수있음)
			if(loginDAO.countFamilyByPersonidx(personidx)>0) {
				FamilyVO familyVO=loginDAO.findFamilyByPersonIdx(personidx);
				String id=familyVO.getId();
				result=id;
			}
			//회원가입은 안함(혹은 탈퇴)
			else {
				result="2";
			}
		}
		//약국이용한적 X
		else {
			result="1";
		}

		return result;
	}
		
	
	
	//비밀번호 찾기
	@Transactional
	public String findPassword(String id, PersonVO personVO) {
		String result="";
	
		//적어도 약국이용자
		if(prelistDAO.countPersonByNameId(personVO)>0) {
			PersonVO vo=prelistDAO.findPersonByNameId(personVO);
			int personidx=vo.getIdx();
			//회원가입도 함(아이디 찾아줄수있음)
			if(loginDAO.countFamilyByPersonidx(personidx)>0) {
				FamilyVO familyVO=loginDAO.findFamilyByPersonIdx(personidx);
				String dbId=familyVO.getId();
				//DB저장된 아이디와 입력한 아이디 비교(일치)
				if(dbId.equals(id)) {
					//비번초기화해주기
					loginDAO.resetFamilyPassword(familyVO.getIdx());
					result="0000";
				}
				//아이디가 일치안함
				else {
					result="3";
				}
			}
			//회원가입은 안함 (혹은 탈퇴함)
			else {
				result="2";
			}
				}
		//약국이용한적 X
		else {
			result="1";
		}
		
		return result;
	}
	
	
	
	
}
