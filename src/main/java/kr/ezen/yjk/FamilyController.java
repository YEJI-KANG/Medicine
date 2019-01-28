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

import kr.ezen.yjk.service.FamilyService;
import kr.ezen.yjk.vo.FamilyVO;
import kr.ezen.yjk.vo.Paging;

@Controller
public class FamilyController {

	@Autowired
	private FamilyService familyService;
	
	
	
	// Account ======================================================================================
	@RequestMapping(value="/account")
	public String account(Model model, HttpServletRequest request, HttpSession session,
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
		
		//세션얻기
		String id=(String)session.getAttribute("id");
		if(id==null || id.equals("")) return "redirect:/";
		//관리자세션
		if(id.equals("admin")) {
			Paging<FamilyVO> paging=familyService.selectList(currentPage, pageSize, blockSize);
			model.addAttribute("paging", paging);
			return "adminUser";
		}
		//일반유저세션
		else {
			FamilyVO vo=familyService.findAccountInfo(id);
			model.addAttribute("vo", vo);	
			return "userAccount";
		}
	}
	
	
	
	
	// 수정 ================================================================================
	@RequestMapping(value="/account/update")
	public String update(Model model,HttpSession session) {
		//세션얻기
		String id=(String)session.getAttribute("id");
		if(id==null || id.equals("")) return "redirect:/";
		FamilyVO vo=familyService.findAccountInfo(id);
		model.addAttribute("vo", vo);
		//관리자세션
		if(id.equals("admin")) {return "adminUserUpdate";}
		//일반유저세션
		else {return "userAccountUpdate";}	
	}
	@RequestMapping(value="/account/updateOk", method=RequestMethod.POST)
	public String updateOk(HttpSession session,
			@RequestParam(required=false) String password,@RequestParam(required=false) String phone) {
		//세션얻기
		String id=(String)session.getAttribute("id");
		if(id==null || id.equals("")) return "redirect:/";
		//관리자세션
		if(id.equals("admin")) {
			familyService.updateFamilyByAdmin(password);
			return "redirect:/account";
		}
		//일반유저세션
		else {
			familyService.updateFamilyByUser(id, password, phone);
			return "redirect:/account";
		}	
	}
	@RequestMapping(value="/account/updateOk", method=RequestMethod.GET)
	public String updateOk() {return "redirect:/account";}

	
	
	// 포인트사용 ================================================================================
	@RequestMapping(value="pointCheck", method=RequestMethod.POST)
	@ResponseBody
	public String pointCheck(HttpSession session,
			@RequestParam int idx, @RequestParam int point) {
		//세션얻기
		String id=(String)session.getAttribute("id");
		if(id==null || !id.equals("admin")) return "redirect:/";
		
		familyService.updatePersonPointMinus500(idx,point);
		return "check";
	}
	
	
	
	
	
	
}
