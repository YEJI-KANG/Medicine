package kr.ezen.yjk;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.support.RequestContextUtils;

import kr.ezen.yjk.service.PrelistService;
import kr.ezen.yjk.vo.ApiVO;
import kr.ezen.yjk.vo.DruglistVO;
import kr.ezen.yjk.vo.Paging;
import kr.ezen.yjk.vo.PersonVO;
import kr.ezen.yjk.vo.PrelistVO;

@Controller
public class PrelistController {
	
	
	@Autowired
	private PrelistService prelistService;
	
	
	
	
	// Prelist ======================================================================================
	@RequestMapping(value="/prelist")
	public String prelist(Model model,HttpServletRequest request, HttpSession session,
			@RequestParam(required=false) Integer p,
			@RequestParam(required=false) Integer s,
			@RequestParam(required=false) Integer b) {

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
		
		String option=request.getParameter("option");
		String search=request.getParameter("search");
		model.addAttribute("option", option);
		model.addAttribute("search", search);
		
		
		//Session얻기
		String id=(String)session.getAttribute("id");
		if(id==null || id.equals("")) return "redirect:/";
		int personidx=prelistService.findFamilyById(id);
		//관리자세션
		if(id.equals("admin")) {
			Paging<PrelistVO> paging=prelistService.selectList(currentPage, pageSize, blockSize,option,search);
			model.addAttribute("paging", paging);
			return "adminPrelist";
		}
		//일반회원세션
		else {
			Paging<PrelistVO> paging=prelistService.selectMyList(personidx, currentPage, pageSize, blockSize);
			model.addAttribute("paging", paging);
			return "userPrelist";
		}
	}
	
	
	
	
	// USER:약정보팝업 ================================================================================
	@RequestMapping(value="/prelist/drugInfo")
	public String drugInfo(Model model,HttpServletRequest request) {
		String drugname="";
		drugname=request.getParameter("drugname");
		ApiVO apiVO=new ApiVO();
		apiVO=prelistService.drugInfo(drugname);
		model.addAttribute("apiVO", apiVO);
		return "userPrelistDrugInfo";
	}
	
	
	
	
	// ADMIN:입력 ======================================================================================
	@RequestMapping(value="/prelist/insert")
	public String insert(HttpSession session) {
		//일반회원 접근차단
		String id=(String)session.getAttribute("id");
		if(id==null || id.equals("")) return "redirect:/";
		if(!((String)session.getAttribute("id")).equals("admin")) {
			return "redirect:/prelist";
		}
		return "adminPrelistInsert";
	}
	@RequestMapping(value="/prelist/insertOk", method=RequestMethod.POST)
	public String insertOk (HttpSession session,@ModelAttribute PersonVO personVO,
			@ModelAttribute PrelistVO prelistVO,@ModelAttribute DruglistVO druglistVO) {
		String id=(String)session.getAttribute("id");
		if(id==null || id.equals("")) return "redirect:/";
		
		prelistService.insert(personVO, prelistVO, druglistVO);
		return "redirect:/prelist";
	}
	@RequestMapping(value="/prelist/insertOk", method=RequestMethod.GET)
	public String insertOk() {return "redirect:/prelist";}


	
	
	
	// ADMIN:수정 ======================================================================================
	@RequestMapping(value="/prelist/update")
	public String update(Model model, HttpServletRequest request,HttpSession session) {
		//일반회원 접근차단
		String id=(String)session.getAttribute("id");
		if(id==null || id.equals("")) return "redirect:/";
		if(!((String)session.getAttribute("id")).equals("admin")) {
			return "redirect:/prelist";
		}
		String getIdx=request.getParameter("idx");
		int idx=Integer.parseInt(getIdx);
		PrelistVO vo=prelistService.findPrelistByIdx(idx);
		model.addAttribute("vo", vo);
		return "adminPrelistUpdate";
	}
	@RequestMapping(value="/prelist/updateOk", method=RequestMethod.POST)
	public String updateOk(HttpServletRequest request,HttpSession session,
			@ModelAttribute PrelistVO prelistVO,@ModelAttribute DruglistVO druglistVO) {
		String id=(String)session.getAttribute("id");
		if(id==null || id.equals("")) return "redirect:/";
		
		String getidx=request.getParameter("idx");
		int idx=Integer.parseInt(getidx);
		PrelistVO vo=new PrelistVO();
		vo=prelistVO;
		vo.setDruglist(druglistVO.getDlist());
		prelistService.update(idx,vo);
		return "redirect:/prelist";
	}
	@RequestMapping(value="/prelist/updateOk", method=RequestMethod.GET)
	public String updateOk() {return "redirect:/prelist";}
	
	
	
	
	
	// ADMIN:삭제 ======================================================================================
	@RequestMapping(value="/prelist/delete")
	public String delete(HttpServletRequest request,HttpSession session) {
		//일반회원 접근차단
		String id=(String)session.getAttribute("id");
		if(id==null || id.equals("")) return "redirect:/";
		if(!((String)session.getAttribute("id")).equals("admin")) {
			return "redirect:/prelist";
		}
		String getIdx=request.getParameter("idx");
		int idx=Integer.parseInt(getIdx);
		prelistService.delete(idx);
		return "redirect:/prelist";
	}



	
}
