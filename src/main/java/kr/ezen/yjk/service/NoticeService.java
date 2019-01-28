package kr.ezen.yjk.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.ezen.yjk.dao.NoticeDAO;
import kr.ezen.yjk.vo.NoticeVO;
import kr.ezen.yjk.vo.Paging;

@Service
public class NoticeService {

	@Autowired
	private NoticeDAO noticeDAO;
	
	public int selectCount() {
		return noticeDAO.selectCount();
	}
	
	
	public Paging<NoticeVO> selectList(int currentPage,int pageSize,int blockSize){
		Paging<NoticeVO> paging=new Paging<NoticeVO>();
		int totalCount=selectCount();
		paging=new Paging<NoticeVO>(totalCount, currentPage, pageSize, blockSize);
		
		if(totalCount>0) {
			HashMap<String, Integer> map=new HashMap<String, Integer>();
			map.put("startNo", paging.getStartNo());
			map.put("endNo", paging.getEndNo());
			List<NoticeVO> lists=noticeDAO.selectList(map);
			paging.setLists(lists);
		}
		return paging;
	}
	
	
	public NoticeVO findNoticeByIdx(int idx) {
		return noticeDAO.findNoticeByIdx(idx);
	}
	
	
	
	public void updateNotice(NoticeVO noticeVO) {
		noticeDAO.updateNotice(noticeVO);
	}
	public void updateNoticeCnt(int idx) {
		noticeDAO.updateNoticeCnt(idx);
	}

	
	
	
	public void insertNotice(String title, String context) {
		HashMap<String, String> map=new HashMap<String, String>();
		map.put("title", title);
		map.put("context", context);
		noticeDAO.insertNotice(map);
	}
	
	public void deleteNotice(int idx) {
		noticeDAO.deleteNotice(idx);
	}
	
	
}
