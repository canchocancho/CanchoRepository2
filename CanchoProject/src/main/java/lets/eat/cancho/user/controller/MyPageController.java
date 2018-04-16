package lets.eat.cancho.user.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import lets.eat.cancho.user.dao.UserDAO;
import lets.eat.cancho.user.vo.Blog_User;

@Controller
@RequestMapping(value="user")
@SessionAttributes("user")
public class MyPageController {
	
	@Autowired
	UserDAO dao;
	
	private static final Logger logger = LoggerFactory.getLogger(MyPageController.class);
	
	@RequestMapping(value="myPage", method = RequestMethod.GET)
	public String loginPage(){
		logger.info("마이페이지 이동 시작");
		logger.info("마이페이지 이동 종료");
		return "user/myPage";
	}
	
	@RequestMapping(value="updateInfo", method = RequestMethod.GET)
	public String updateInfo(Model model, HttpSession session){
		logger.info("회원정보 수정 폼 이동 시작");
		
		String userId = (String)session.getAttribute("loginId");
		
		Blog_User user = dao.searchUserOne(userId);
		model.addAttribute("user", user);
		
		logger.info("회원정보 수정 폼 이동 종료");
		return "user/updateInfo";
	}
	
	@RequestMapping(value="update", method = RequestMethod.POST)
	public String update(@ModelAttribute("user")Blog_User user, Model model){
		logger.info("회원정보 수정 시작");
		
		int result = dao.updateUser(user);
		
		if (result != 1) {
			model.addAttribute("errorMsg", "회원정보 수정 실패");
			logger.info("회원정보 수정 실패");
			return "user/updateInfo";
		}
		
		logger.info("회원정보 수정 종료");
		
		return "redirect:updateComplete";
	}
	
	@RequestMapping(value="updateComplete", method = RequestMethod.GET)
	public String update(SessionStatus status, @ModelAttribute("user")Blog_User user, Model model, HttpSession session){
		logger.info("회원정보 수정 성공 후 홈으로 돌아가기 시작");
		
		session.setAttribute("loginName", user.getUser_name());
		
		status.setComplete();
		
		logger.info("회원정보 수정 성공 후 홈으로 돌아가기 종료");
		
		return "redirect:/";
	}
	
	
	
	
	
	
	
	
	
}
