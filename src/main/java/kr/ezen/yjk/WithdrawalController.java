package kr.ezen.yjk;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.ezen.yjk.service.WithdrawalService;

@Controller
public class WithdrawalController {

	@Autowired
	private WithdrawalService withdrawalService;
	
	@RequestMapping(value="withdrawal", method=RequestMethod.POST)
	@ResponseBody
	public String withdrawal(HttpSession session, @RequestParam(required=true) String id) {

		//세션체크
		if(id==null || id.equals("") || id.equals("admin")) return "redirect:/";
		
		withdrawalService.insertWithdrawal(id);
		withdrawalService.withdrawFamily(id);
		session.invalidate();
		return "withdrawal";
	}
	
	
}
