package kr.ezen.yjk.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.ezen.yjk.dao.LoginDAO;
import kr.ezen.yjk.dao.QnaDAO;
import kr.ezen.yjk.vo.AnswerVO;
import kr.ezen.yjk.vo.Paging;
import kr.ezen.yjk.vo.QuestionVO;

@Service
public class QnaService {

	@Autowired
	QnaDAO qnaDAO;
	@Autowired
	LoginDAO loginDAO;
	
	
	public Paging<QuestionVO> selectList(int currentPage,int pageSize,int blockSize) {
		Paging<QuestionVO> paging=new Paging<QuestionVO>();
		int totalCount=qnaDAO.selectQCount();
		paging=new Paging<QuestionVO>(totalCount, currentPage, pageSize, blockSize);
		//질문존재
		if(totalCount>0) {
			HashMap<String, Integer> map=new HashMap<String, Integer>();
			map.put("startNo", paging.getStartNo());
			map.put("endNo", paging.getEndNo());
			List<QuestionVO> lists=qnaDAO.selectQList(map);
			for(QuestionVO qvo:lists) {
				//한질문에 답변있는경우
				if(qnaDAO.countAnswer(qvo.getIdx())>0) {
					AnswerVO avo=qnaDAO.selectAnswer(qvo.getIdx());
					qvo.setAdate(avo.getAdate());
					qvo.setAmemo(avo.getAmemo());
					qvo.setAidx(avo.getIdx());
				}
				String userid=qnaDAO.findFamilyByIdx(qvo.getFidx()).getId();
				qvo.setId(userid);
			}
			paging.setLists(lists);
		}
		
		return paging;
	}
	
	
	public Paging<QuestionVO> selectMyList(String id,int currentPage,int pageSize,int blockSize) {
		Paging<QuestionVO> paging=new Paging<QuestionVO>();
		HashMap<String, String> map=new HashMap<String, String>();
		map.put("id", id);
		int fidx=loginDAO.findFamilyById(map).getIdx();
		//질문존재
		if(qnaDAO.countQuestion(fidx)>0) {
			int totalCount=qnaDAO.countQuestion(fidx);
			paging=new Paging<QuestionVO>(totalCount, currentPage, pageSize, blockSize);
			HashMap<String, Integer> map2=new HashMap<String, Integer>();
			map2.put("fidx", fidx);
			map2.put("startNo", paging.getStartNo());
			map2.put("endNo", paging.getEndNo());
			List<QuestionVO> lists=qnaDAO.selectQuestion(map2);
			for(QuestionVO qvo:lists) {
				//한질문에 답변있는경우
				if(qnaDAO.countAnswer(qvo.getIdx())>0) {
					AnswerVO avo=qnaDAO.selectAnswer(qvo.getIdx());
					qvo.setAdate(avo.getAdate());
					qvo.setAmemo(avo.getAmemo());
					qvo.setAidx(avo.getIdx());
				}
			}
			paging.setLists(lists);
		}
		return paging;
	}
	
	@Transactional
	public void insertQuestion(String id,String qmemo) {
		QuestionVO questionVO=new QuestionVO();
		HashMap<String, String> map=new HashMap<String, String>();
		map.put("id", id);
		int fidx=loginDAO.findFamilyById(map).getIdx();
		questionVO.setFidx(fidx);
		questionVO.setQmemo(qmemo);
		qnaDAO.insertQuestion(questionVO);
	}
	
	@Transactional
	public void insertAnswer(int qidx,String amemo) {
		AnswerVO answerVO=new AnswerVO();
		answerVO.setQidx(qidx);
		answerVO.setAmemo(amemo);
		qnaDAO.insertAnswer(answerVO);
	}
	
	
	
	
	public void updateQuestion(int idx,String qmemo) {
		QuestionVO questionVO=new QuestionVO();
		questionVO.setIdx(idx);
		questionVO.setQmemo(qmemo);
		qnaDAO.updateQuestion(questionVO);
	}
	public void updateAnswer(int idx,String amemo) {
		AnswerVO answerVO=new AnswerVO();
		answerVO.setIdx(idx);
		answerVO.setAmemo(amemo);
		qnaDAO.updateAnswer(answerVO);
	}
	
	
	
	
	
	public void deleteQuestion(int idx) {
		qnaDAO.deleteQuestion(idx);
	}
	public void deleteAnswer(int idx) {
		qnaDAO.deleteAnswer(idx);
	}
	
	
	
}
