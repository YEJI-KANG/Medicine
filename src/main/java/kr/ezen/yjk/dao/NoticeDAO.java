package kr.ezen.yjk.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.ezen.yjk.vo.NoticeVO;

@Repository
public class NoticeDAO {

	@Autowired
	private SqlSession sqlSession;
	
	public int selectCount() {
		return sqlSession.selectOne("mybatis.notice.selectCount");
	}
	
	public List<NoticeVO> selectList(HashMap<String, Integer> map){
		return sqlSession.selectList("mybatis.notice.selectList", map);
	}
	
	
	public NoticeVO findNoticeByIdx(int idx) {
		return sqlSession.selectOne("mybatis.notice.findNoticeByIdx", idx);
	}
	
	public void updateNotice(NoticeVO noticeVO) {
		sqlSession.update("mybatis.notice.updateNotice", noticeVO);
	}
	public void updateNoticeCnt(int idx) {
		sqlSession.update("mybatis.notice.updateNoticeCnt", idx);
	}
	
	
	
	public void insertNotice(HashMap<String, String> map) {
		sqlSession.insert("mybatis.notice.insertNotice", map);
	}
	
	public void deleteNotice(int idx) {
		sqlSession.delete("mybatis.notice.deleteNotice", idx);
	}
}
