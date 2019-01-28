package kr.ezen.yjk;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.ezen.yjk.service.LoginService;
import kr.ezen.yjk.vo.FamilyVO;
import kr.ezen.yjk.vo.PersonVO;

@Controller
public class LoginController {

	@Autowired
	private LoginService loginService;
	
	
	
	// 로그인 ======================================================================================
	@RequestMapping(value="/login")
	public String login(Model model,@RequestParam(required=false) String id, 
			@RequestParam(required=false) String password, HttpSession session) {
			
		//첫페이지
		if(id==null || id.trim().length()==0) {
			return "login";
		}
		
		//로그인시도
		int result=loginService.loginCheck(id,password);
		//관리자로그인
		if(result==0) {
			session.setAttribute("id",id);
			return "redirect:/";
		}
		//일반회원로그인
		else if(result==3) {	
			session.setAttribute("id",id);
			return "redirect:/";
		}
		//회원탈퇴자 로그인
		else if(result==4) {	
			model.addAttribute("result", result);
			return "login";
		}
		//로그인실패
		model.addAttribute("result", result);
		return "login";
	}

	
	
	
	
	// 회원가입 ======================================================================================
	@RequestMapping(value="/join")
	public String join(HttpServletRequest request,Model model,
			@RequestParam(required=false) String name, @RequestParam(required=false) String idnum1,
			@RequestParam(required=false) String idnum2, @RequestParam(required=false) String id, 
			@RequestParam(required=false) String password, @RequestParam(required=false) String phone) {

		//첫페이지
		if(name==null || name.trim().length()==0) {
			return "join";
		}
		
		//회원가입시도
		FamilyVO familyVO=new FamilyVO();
		familyVO.setName(name); familyVO.setIdnum1(idnum1); familyVO.setIdnum2(idnum2);
		familyVO.setId(id); familyVO.setPassword(password); familyVO.setPhone(phone);
		PersonVO personVO=new PersonVO();
		personVO.setName(name); personVO.setIdnum1(idnum1); personVO.setIdnum2(idnum2);
		int result=loginService.familyCheck(familyVO, personVO);
		//회원가입성공
		if(result==3) {
			loginService.insert(familyVO, personVO);
			return "redirect:/login";
		}
		//회원가입실패
		model.addAttribute("result", result);
		return "join";
	}
	
	
	
	
	// 회원가입:아이디 중복확인 ======================================================================
	@RequestMapping(value="/idCheck", produces={"text/html;charset=utf-8"})
	@ResponseBody
	public String idCheck(@RequestParam String id) {
		return loginService.countFamilyById(id)+"";
	}

		
		

		
	
	//로그아웃 ======================================================================================
	@RequestMapping(value="/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
	
	
	
	
	
	// 아이디&비밀번호 찾기 ==========================================================================
	@RequestMapping(value="/find")
	public String find(Model model,@RequestParam(required=false) String IDname,
			@RequestParam(required=false) String IDidnum1, @RequestParam(required=false) String IDidnum2,
			@RequestParam(required=false) String PSid, @RequestParam(required=false) String PSname, 
			@RequestParam(required=false) String PSidnum1, @RequestParam(required=false) String PSidnum2){
		
		//첫페이지
		if(IDname==null || IDname.trim().length()==0) {
			if(PSname==null || PSname.trim().length()==0) {
				return "find";
			}
		}
	
		PersonVO personVO=new PersonVO();
		
		//아이디찾기
		if(IDname!=null && IDname.trim().length()!=0) {
			personVO.setName(IDname);
			personVO.setIdnum1(IDidnum1);
			personVO.setIdnum2(IDidnum2);
			
			String result=loginService.findId(personVO);
			model.addAttribute("result", result);
			//약국 이용도 안함
			if(result.equals("1")) {return "find";}
			//회원가입만 안함 (혹은 탈퇴함)
			else if(result.equals("2")) {return "find";}
			//회원임(아이디 찾음)
			else {	return "findIdInfo";}
		}
		
		//비밀번호찾기
		else if(PSname!=null && PSname.trim().length()!=0) {
			personVO.setName(PSname);
			personVO.setIdnum1(PSidnum1);
			personVO.setIdnum2(PSidnum2);
			
			String result=loginService.findPassword(PSid, personVO);
			model.addAttribute("result", result);
			//약국 이용도 안함
			if(result.equals("1")) {return "find";}
			//회원가입만 안함 (혹은 탈퇴함)
			else if(result.equals("2")) {return "find";}
			//아이디가 틀림
			else if(result.equals("3")) {return "find";}
			//회원임(비번 찾음)
			else {	return "findPasswordInfo";}
		}
		//그외
		return "find";
	}
	
	
	
	
	
	
	
}
