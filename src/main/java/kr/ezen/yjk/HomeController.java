package kr.ezen.yjk;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;



@Controller
public class HomeController {
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	
	//첫페이지 ======================================================================================
	@RequestMapping(value = "/")
	public String home(HttpSession session) {
		logger.info("===================서버 접속됨===================");
		
		//세션값읽음
		Object id=session.getAttribute("id");
		
		if(id!=null) {
			//관리자세션
			if(((String)id).equals("admin")) {
				session.setAttribute("id",id);
				return "adminHome";
			}
			//일반회원세션
			else {	
				session.setAttribute("id",id);
				return "userHome";
			}
		}
		//세션정보없음
		else {
			return "redirect:/login";
		}
	}

	
	
	
	
}
