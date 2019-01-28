package kr.ezen.yjk.service;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.ezen.yjk.dao.LoginDAO;
import kr.ezen.yjk.dao.PrelistDAO;
import kr.ezen.yjk.vo.ApiVO;
import kr.ezen.yjk.vo.DrugVO;
import kr.ezen.yjk.vo.DruglistVO;
import kr.ezen.yjk.vo.FamilyVO;
import kr.ezen.yjk.vo.Paging;
import kr.ezen.yjk.vo.PersonVO;
import kr.ezen.yjk.vo.PrelistVO;

@Service
public class PrelistService {

	@Autowired
	private PrelistDAO prelistDAO;
	@Autowired
	private LoginDAO loginDAO;
	
	public int selectCount() {
		return prelistDAO.selectCount();
	}
	
	
	public Paging<PrelistVO> selectList(int currentPage, int pageSize, int blockSize,String option, String search){
		Paging<PrelistVO> paging = null;
		int totalCount = prelistDAO.selectCount();
		paging = new Paging<PrelistVO>(totalCount, currentPage, pageSize, blockSize);
		
		if(totalCount>0) {
			
			List<PrelistVO> list =null;
			
			if(option!=null && search!=null) {
				HashMap<String, String> map = new HashMap<String, String>();
				if(option.equals("1")) {
					map.put("search", "%"+search+"%");
					map.put("startNo", Integer.toString(paging.getStartNo()));
					map.put("endNo", Integer.toString(paging.getEndNo()));
					list = prelistDAO.searchList1(map);
				}
				else if(option.equals("2"))	{
					map.put("search", "%"+search+"%");
					map.put("startNo", Integer.toString(paging.getStartNo()));
					map.put("endNo", Integer.toString(paging.getEndNo()));
					list = prelistDAO.searchList2(map);
				}
				else if(option.equals("3"))	{
					map.put("search", "%"+search+"%");
					map.put("startNo", Integer.toString(paging.getStartNo()));
					map.put("endNo", Integer.toString(paging.getEndNo()));
					list = prelistDAO.searchList3(map);
				}
			}
			else {
				HashMap<String, Integer> map = new HashMap<String, Integer>();
				map.put("startNo",paging.getStartNo());
				map.put("endNo", paging.getEndNo());
				list = prelistDAO.selectList(map);
			}
			
			for(PrelistVO vo:list) {
				//Foreign key 이용, VO에만 있는 name idnum1,idnum2 추가
				PersonVO personVO=prelistDAO.findPersonByFK(vo.getPersonidx());
				vo.setName(personVO.getName());
				vo.setIdnum1(personVO.getIdnum1());
				vo.setIdnum2(personVO.getIdnum2());
				
				//VO에만 있는 druglist 추가
				List<DrugVO> druglist=prelistDAO.findDrugListByFK(vo.getIdx());
				vo.setDruglist(druglist);
			}	
			paging.setLists(list);
		}
		return paging;
	}
	
	
	@Transactional
	public void insert(PersonVO personVO,PrelistVO prelistVO,DruglistVO druglistVO) {
		
		int idx=0;
		
		if(prelistDAO.countPersonByNameId(personVO)==0) { 
			//같은사람없음
			prelistDAO.insertPerson(personVO);
			idx=prelistDAO.findPersonByNameId(personVO).getIdx();	
		}	
		//이미 약처방기록존재 :카운트+1
		else {
			idx=prelistDAO.findPersonByNameId(personVO).getIdx();
			prelistDAO.updatePersonTempCount(idx);
			prelistDAO.updatePersonPointPlus(idx);
		}
		
		
		personVO.setIdx(idx);

		prelistVO.setPersonidx(personVO.getIdx());
		prelistDAO.insertPrelist(prelistVO);
		int idx2=prelistDAO.findPrelistByDateHos(prelistVO).getIdx();
		prelistVO.setIdx(idx2);
		
		for(DrugVO vo:druglistVO.getDlist()) {
		vo.setListidx(prelistVO.getIdx());
		prelistDAO.insertDrug(vo);
		}
	}
	
	

	
	@Transactional
	public void update(int idx,PrelistVO prelistVO) {
		//prelistVO:고친후의 VO (새로운값)
		//기존db에서 값을 꺼내 비교해야함
		PrelistVO preVO=prelistDAO.findPrelistByIdx(idx);
		preVO.setName(prelistDAO.findPersonByFK(preVO.getPersonidx()).getName());
		preVO.setIdnum1(prelistDAO.findPersonByFK(preVO.getPersonidx()).getIdnum1());
		preVO.setIdnum2(prelistDAO.findPersonByFK(preVO.getPersonidx()).getIdnum2());
		preVO.setDruglist(prelistDAO.findDrugListByFK(preVO.getIdx()));
		preVO.setTemp1(prelistDAO.findPersonByFK(preVO.getPersonidx()).getTemp1());
		
		prelistVO.setIdx(idx);
		
		//민번값일치
		if(preVO.getIdnum1().equals(prelistVO.getIdnum1()) && preVO.getIdnum2().equals(prelistVO.getIdnum2())) {
			//System.out.println("여기로 와야함!!!!!민번값같음!!!!");
			prelistVO.setPersonidx(preVO.getPersonidx());
			prelistVO.setIdx(idx);
			prelistDAO.updatePrelist(prelistVO);
			
			//Druglist update
			List<DrugVO> list=prelistVO.getDruglist();
			//System.out.println("이전존재한값preVO: " + preVO.toString());
			//System.out.println("들어온값prelistVO: " + prelistVO.toString());	
			updateDruglist(idx, preVO, list);
	
		}
		
		//민번값다름
		else {
			//System.out.println("민번값 달라짐!!!!!!!");
			updateMethod(idx, prelistVO, preVO);
			
			//Druglist update
			List<DrugVO> list=prelistVO.getDruglist();
			//System.out.println("이전존재한값preVO: " + preVO.toString());
			//System.out.println("들어온값prelistVO: " + prelistVO.toString());
			updateDruglist(idx, preVO, list);
		}
		
		
	}

	@Transactional
	public void updateDruglist(int idx, PrelistVO preVO, List<DrugVO> list) {
		prelistDAO.deleteDrugByListidx(idx);				
		for(DrugVO vo:list) {
			vo.setListidx(idx);
			prelistDAO.insertDrug(vo);
			//System.out.println(vo.toString());
		}		
	}
	
	
	@Transactional
	public void updateMethod(int idx, PrelistVO prelistVO, PrelistVO preVO) {
	
		//idx처방전글번호 preVO이전정보 prelistVO들어온정보
		//새로운사람 처리===========================================================	
		int idx3=0; //사람테이블의 idx 이자 prelist의 personidx가되어야함
		PersonVO personVO=new PersonVO();
		personVO.setName(prelistVO.getName());
		personVO.setIdnum1(prelistVO.getIdnum1());
		personVO.setIdnum2(prelistVO.getIdnum2());
		if(prelistDAO.countPersonByNameId(personVO)==0) { 
			//System.out.println("같은사람 없음!!!");
			//같은사람없음
			prelistDAO.insertPerson(personVO);
			idx3=prelistDAO.findPersonByNameId(personVO).getIdx();	
		}	
		//이미 약처방기록존재 :카운트+1
		else {
			//System.out.println("이미있는사람!!!");
			idx3=prelistDAO.findPersonByNameId(personVO).getIdx();
			prelistDAO.updatePersonTempCount(idx3);
			prelistDAO.updatePersonPointPlus(idx3);
		}
		
		personVO.setIdx(idx3);

		prelistVO.setPersonidx(personVO.getIdx());
		prelistVO.setIdx(idx);
		prelistDAO.updatePrelist(prelistVO);
		
		
		//이전정보사람 처리===========================================================
		//한번만 왔던사람->기록에서 삭제
		if(preVO.getTemp1().equals("1")) {
			//System.out.println("한번만왔음!!!");
			prelistDAO.deletePerson(preVO.getPersonidx());		
		}
		//여러번 왔던사람->기록에 지장없음 (카운트 낮춰주기)
		else {
			//System.out.println("여러번 왔음!!!");
			prelistDAO.updatePersonTempCountMinus(preVO.getPersonidx());
			prelistDAO.updatePersonPointMinus(preVO.getPersonidx());
		}	
		

		
	}
	
	@Transactional
	public PrelistVO findPrelistByIdx(int idx) {
		PrelistVO prelistVO=new PrelistVO();
		prelistVO=prelistDAO.findPrelistByIdx(idx);
		
		PersonVO personVO=prelistDAO.findPersonByFK(prelistVO.getPersonidx());
		prelistVO.setName(personVO.getName());
		prelistVO.setIdnum1(personVO.getIdnum1());
		prelistVO.setIdnum2(personVO.getIdnum2());
		
		List<DrugVO> druglist=null;
		druglist=prelistDAO.findDrugListByFK(idx);
		prelistVO.setDruglist(druglist);
		
		return prelistVO;
	}
	
	
	
	//Delete (삭제)
	@Transactional
	public void delete(int idx) {
		
		PrelistVO prelistVO=prelistDAO.findPrelistByIdx(idx);
		int personidx=prelistVO.getPersonidx();
		PersonVO personVO=prelistDAO.findPersonByFK(personidx);
		
		prelistDAO.deleteDrugByListidx(prelistVO.getIdx());
		prelistDAO.deletePrelist(prelistVO.getIdx());
		
		
		//한번만 왔던사람->기록에서 삭제
		if(personVO.getTemp1().equals("1")) {
			prelistDAO.deletePerson(personVO.getIdx());		
		}
				
		//여러번 왔던사람->기록에 지장없음 (카운트 낮춰주기)
		else {
			prelistDAO.updatePersonTempCountMinus(personVO.getIdx());
			prelistDAO.updatePersonPointMinus(personVO.getIdx());
		}
		


	}
	
	
	
	//USER-----------------------------------------------------------------------------------------------------
	
	//계정만의 prelist 가져오기
	public int findFamilyById(String id) {
		HashMap<String, String> map=new HashMap<String, String>();
		map.put("id", id);
		FamilyVO vo=loginDAO.findFamilyById(map);
		int personidx=vo.getPersonidx();
		return personidx;
	}
	
	public int selectMyCount(int personidx) {
		return prelistDAO.selectMyCount(personidx);
	}

	public Paging<PrelistVO> selectMyList(int personidx,int currentPage, int pageSize, int blockSize){
		Paging<PrelistVO> paging=null;
		int totalCount=prelistDAO.selectMyCount(personidx);
		paging=new Paging<PrelistVO>(totalCount, currentPage, pageSize, blockSize);
		
		if(totalCount>0) {
			HashMap<String, Integer> map = new HashMap<String, Integer>();
			map.put("personidx", personidx);
			map.put("startNo", paging.getStartNo());
			map.put("endNo", paging.getEndNo());
			List<PrelistVO> list = prelistDAO.selectMyList(map);
			
			for(PrelistVO vo:list) {
				List<DrugVO> druglist=null;
				int listidx=vo.getIdx();
				druglist=prelistDAO.findDrugListByFK(listidx);
				
				vo.setDruglist(druglist);
			}
			paging.setLists(list);
		}
		
		
		return paging;
	}

	
	public ApiVO drugInfo(String drugname) {
		ApiVO apiVO=new ApiVO();
		apiVO.setItem_name(drugname); //약이름
		//api로 drug정보넣기
		drugInfoAPI(apiVO, drugname);
		
		return apiVO;
	}
	

	public void drugInfoAPI(ApiVO apiVO, String drugname) {
		String url="http://apis.data.go.kr/1470000/MdcinGrnIdntfcInfoService/getMdcinGrnIdntfcInfoList?ServiceKey=jCzKvytIICvWIZFTlKCmLtCc5KQyMOavD92RVF75UK%2Fn2QaTW7Ju%2BZk3DMvRZE8ks1OLNNTX%2BMJUbiYGGUD58w%3D%3D&numOfRows=100&pageNo=1";
		try {
			Document document=Jsoup.connect(url).get();
			Elements elements=document.select("item");
			for(Element element:elements) {
				if(element.select("ITEM_NAME").get(0).text().equals(drugname)) {
					apiVO.setChart(element.select("CHART").get(0).text()); //생김새 서술
					apiVO.setItem_image(element.select("ITEM_IMAGE").get(0).text()); //이미지 링크
					apiVO.setClass_name(element.select("CLASS_NAME").get(0).text()); //용도
				}
			}
		}
		catch (IOException e) {
			e.printStackTrace();
			}
		
	}
	
	//
	
}
