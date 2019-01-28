package kr.ezen.yjk;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.support.RequestContextUtils;

import kr.ezen.yjk.service.NoticeService;
//import kr.ezen.yjk.service.PrelistService;
import kr.ezen.yjk.vo.NoticeVO;
import kr.ezen.yjk.vo.Paging;

@Controller
public class NoticeController {

	@Autowired
	private NoticeService noticeService;

	
	
	
	//공지사항 ======================================================================================
	@RequestMapping(value="/notice")
	public String notice(HttpSession session, Model model, HttpServletRequest request,
			@RequestParam(required=false) Integer p, @RequestParam(required=false) Integer s,
			@RequestParam(required=false) Integer b, @RequestParam(required=false,defaultValue="0") int idx) {
		//Session얻기
		String id=(String)session.getAttribute("id");
		if(id==null || id.equals("")) return "redirect:/";
		
		//글선택함
		if(idx!=0) {
			NoticeVO vo=noticeService.findNoticeByIdx(idx);
			model.addAttribute("vo", vo);
			//관리자
			if(id.equals("admin")) {
				model.addAttribute("flag",1);
				return "notice";
			}
			//일반유저
			else {
				noticeService.updateNoticeCnt(idx);
				model.addAttribute("flag",0);
				return "notice";
			}
		}
		
		//처음방문
		//Paging기본
		int currentPage=1;
		int pageSize=10;
		int blockSize=10;	
		Map<String, ?> map = RequestContextUtils.getInputFlashMap(request);
		if (map != null) {
			@SuppressWarnings("unchecked")
			Map<String, Object> m = (Map<String, Object>) map.get("map");
			p = (Integer) m.get("p");
			b = (Integer) m.get("b");
			s = (Integer) m.get("s");
		}
		if(p!=null) currentPage=p;
		if(s!=null) pageSize=s;
		if(b!=null) blockSize=b;
		
		Paging<NoticeVO> paging=noticeService.selectList(currentPage, pageSize, blockSize);
		model.addAttribute("paging", paging);
		
		
		//관리자세션
		if(id.equals("admin")) {
			return "adminNotice";
		}
		//일반회원세션
		else {
			return "userNotice";
		}
	}
	

	
	
	// ADMIN:입력 ======================================================================================
	@RequestMapping(value="/notice/insert")
	public String insert(HttpSession session) {
		//일반회원 접근차단
		
		String id=(String)session.getAttribute("id");
		if(id==null || id.equals("")) return "redirect:/";
		if(!((String)session.getAttribute("id")).equals("admin")) {
			return "redirect:/notice";
		}
		return "adminNoticeInsert";
	}
	@RequestMapping(value="/notice/insertOk", method=RequestMethod.POST)
	public String insertOk (HttpSession session,@RequestParam String title, @RequestParam String context) {
		String id=(String)session.getAttribute("id");
		if(id==null || id.equals("")) return "redirect:/";
		noticeService.insertNotice(title, context);
		return "redirect:/notice";
	}
	@RequestMapping(value="/notice/insertOk", method=RequestMethod.GET)
	public String insertOk() {return "redirect:/notice";}

		
		
		
		
	// ADMIN:수정 ======================================================================================
	@RequestMapping(value="/notice/update")
	public String update(Model model, HttpServletRequest request,HttpSession session) {
		//일반회원 접근차단
		
		String id=(String)session.getAttribute("id");
		if(id==null || id.equals("")) return "redirect:/";
		if(!((String)session.getAttribute("id")).equals("admin")) {
			return "redirect:/notice";
		}
		String getIdx=request.getParameter("idx");
		int idx=Integer.parseInt(getIdx);
		NoticeVO vo=noticeService.findNoticeByIdx(idx);
		model.addAttribute("vo", vo);
		return "adminNoticeUpdate";
	}
	@RequestMapping(value="/notice/updateOk", method=RequestMethod.POST)
	public String updateOk(HttpServletRequest request,HttpSession session,
			@RequestParam String title, @RequestParam String context) {
		String id=(String)session.getAttribute("id");
		if(id==null || id.equals("")) return "redirect:/";
		
		String getidx=request.getParameter("idx");
		int idx=Integer.parseInt(getidx);
		NoticeVO noticeVO=new NoticeVO();
		noticeVO.setIdx(idx); noticeVO.setTitle(title); noticeVO.setContext(context);
		noticeService.updateNotice(noticeVO);
		return "redirect:/notice";
	}
	@RequestMapping(value="/notice/updateOk", method=RequestMethod.GET)
	public String updateOk() {return "redirect:/notice";}
	
	
	
	
	
	
	// ADMIN:삭제 ======================================================================================
	@RequestMapping(value="/notice/delete")
	public String delete(HttpServletRequest request,HttpSession session) {
		//일반회원 접근차단
		String id=(String)session.getAttribute("id");
		if(id==null || id.equals("")) return "redirect:/";
		if(!((String)session.getAttribute("id")).equals("admin")) {
			return "redirect:/notice";
		}
		String getIdx=request.getParameter("idx");
		int idx=Integer.parseInt(getIdx);
		noticeService.deleteNotice(idx);
		return "redirect:/notice";
	}	

	
	
	
	
}
