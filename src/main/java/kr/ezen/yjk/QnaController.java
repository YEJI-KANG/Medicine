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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.support.RequestContextUtils;

import kr.ezen.yjk.service.QnaService;
import kr.ezen.yjk.vo.Paging;
import kr.ezen.yjk.vo.QuestionVO;

@Controller
public class QnaController {

	@Autowired
	QnaService qnaService;
	
	
	//QnA ======================================================================================
	@RequestMapping(value="/qna")
	public String qna(HttpSession session,Model model, HttpServletRequest request,
			@RequestParam(required=false, defaultValue="1") Integer p, 
			@RequestParam(required=false, defaultValue="1") Integer s, 
			@RequestParam(required=false, defaultValue="10") Integer b, 
			@RequestParam(required=false, defaultValue="0") int idx
			) {

		//Paging Default
		int currentPage = p;
		int pageSize = s;
		int blockSize = b;
		
		//세션체크
		String id=(String) session.getAttribute("id");
		if(id==null || id.equals("")) return "redirect:/";
		//Paging 들어옴	
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
				
		//관리자세션
		if(id.equals("admin")) {
			Paging<QuestionVO> paging=qnaService.selectList(currentPage,pageSize,blockSize);
			model.addAttribute("paging", paging);
			return "adminQna";
		}
		//일반회원세션
		else {
			Paging<QuestionVO> paging=qnaService.selectMyList(id,currentPage,pageSize,blockSize);
			model.addAttribute("paging", paging);
			return "userQna";
		}	
	}
	
	
	
	
	//답변생성 Ajax ======================================================================================
	@RequestMapping(value="qnaInsert", method=RequestMethod.POST)
	@ResponseBody
	public String insertOk(
			@RequestParam(required=false, defaultValue="1") Integer p, 
			@RequestParam(required=false, defaultValue="0") int idx,
			@RequestParam(required=false, defaultValue="0") String id,
			@RequestParam(required=false, defaultValue="0") String amemo) {
		//세션체크
		if(id==null || id.equals("")) return "redirect:/";
		
		if(id.equals("admin")) {
			qnaService.insertAnswer(idx, amemo);
		}
		else{
			qnaService.insertQuestion(id, amemo);
		}
		return amemo;
	}
	
	
	
	
	
	//답변수정 Ajax ======================================================================================
	@RequestMapping(value="qnaUpdate", method=RequestMethod.POST)
	@ResponseBody
	public String updateOk(
			@RequestParam(required=false, defaultValue="1") Integer p, 
			@RequestParam(required=false, defaultValue="0") int idx,
			@RequestParam(required=false, defaultValue="0") String id,
			@RequestParam(required=false, defaultValue="0") String amemo
			) {
		//세션체크
		if(id==null || id.equals("")) return "redirect:/";
				
		if(id.equals("admin")) {
			qnaService.updateAnswer(idx, amemo);
		}
		else{
			qnaService.updateQuestion(idx, amemo);
		}
		return amemo;
	}
	
	
	
	//답변삭제 Ajax ======================================================================================
	@RequestMapping(value="qnaDelete", method=RequestMethod.POST)
	@ResponseBody
	public String deleteOk(
			@RequestParam(required=false, defaultValue="1") Integer p, 
			@RequestParam(required=false, defaultValue="0") int idx,
			@RequestParam(required=false, defaultValue="0") String id
			) {
		//세션체크
		if(id==null || id.equals("")) return "redirect:/";
		
		if(id.equals("admin")) {
			qnaService.deleteAnswer(idx);
		}
		else {
			qnaService.deleteQuestion(idx);
		}
		return p+"";
	}
}
