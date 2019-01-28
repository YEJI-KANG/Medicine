package kr.ezen.yjk.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.ezen.yjk.vo.AnswerVO;
import kr.ezen.yjk.vo.FamilyVO;
import kr.ezen.yjk.vo.QuestionVO;

@Repository
public class QnaDAO {

	@Autowired
	SqlSession sqlSession;
	
	
	public int selectQCount() {
		return sqlSession.selectOne("mybatis.qna.selectQCount");
	}
	
	public List<QuestionVO> selectQList(HashMap<String, Integer> map) {
		return sqlSession.selectList("mybatis.qna.selectQList",map);
	}
	
	
	public int countQuestion(int pidx) {
		return sqlSession.selectOne("mybatis.qna.countQuestion", pidx);
	}
	
	public int countAnswer(int qidx) {
		return sqlSession.selectOne("mybatis.qna.countAnswer", qidx);
	}
	
	
	public List<QuestionVO> selectQuestion(HashMap<String, Integer> map){
		return sqlSession.selectList("mybatis.qna.selectQuestion", map);
	}
	public AnswerVO selectAnswer(int qidx){
		return sqlSession.selectOne("mybatis.qna.selectAnswer", qidx);
	}
	
	
	public void insertQuestion(QuestionVO questionVO) {
		sqlSession.insert("mybatis.qna.insertQuestion", questionVO);
	}
	public void insertAnswer(AnswerVO answerVO) {
		sqlSession.insert("mybatis.qna.insertAnswer", answerVO);
	}
	
	
	
	public void updateQuestion(QuestionVO questionVO) {
		sqlSession.update("mybatis.qna.updateQuestion", questionVO);
	}
	public void updateAnswer(AnswerVO answerVO) {
		sqlSession.update("mybatis.qna.updateAnswer", answerVO);
	}
	
	
	
	public void deleteQuestion(int idx) {
		sqlSession.delete("mybatis.qna.deleteQuestion", idx);
	}
	public void deleteAnswer(int idx) {
		sqlSession.delete("mybatis.qna.deleteAnswer", idx);
	}
	
	public FamilyVO findFamilyByIdx(int idx) {
		return sqlSession.selectOne("mybatis.qna.findFamilyByIdx", idx);
	}
	
}
