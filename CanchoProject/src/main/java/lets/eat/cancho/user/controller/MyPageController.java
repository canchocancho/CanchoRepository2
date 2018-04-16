package lets.eat.cancho.user.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;

@Controller
@RequestMapping(value="user")
@SessionAttributes("user")
public class MyPageController {
	
	private static final Logger logger = LoggerFactory.getLogger(MyPageController.class);
	
	@RequestMapping(value="myPage", method = RequestMethod.GET)
	public String loginPage(){
		logger.info("마이페이지 이동 시작");
		logger.info("마이페이지 이동 종료");
		return "user/myPage";
	}
}
