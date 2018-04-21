package lets.eat.cancho.user.controller;

import java.util.ArrayList;

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

import lets.eat.cancho.friend.dao.FriendDAO;
import lets.eat.cancho.friend.vo.Friend;
import lets.eat.cancho.user.dao.UserDAO;
import lets.eat.cancho.user.vo.Blog_User;

@Controller
@RequestMapping(value="user")
@SessionAttributes("user")
public class MyPageController {
	
	@Autowired
	UserDAO dao;
	
	@Autowired
	FriendDAO dao1;
	
	private static final Logger logger = LoggerFactory.getLogger(MyPageController.class);
	
	@RequestMapping(value="myPage", method = RequestMethod.GET)
	public String myPage(HttpSession session){
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
	public String update(@ModelAttribute("user")Blog_User user, Model model, HttpSession session){
		logger.info("회원정보 수정 시작");
		
		int result = dao.updateUser(user);
		
		if (result != 1) {
			model.addAttribute("errorMsg", "이미 가입된 이메일입니다.");
			logger.info("회원정보 수정 실패");
			return "user/updateInfo";
		}
		
		logger.info("회원정보 수정 종료");
		session.setAttribute("loginName", user.getUser_name());
		session.setAttribute("loginEmail", user.getUser_email());
		return "redirect:updateInfo";
	}
	
/*	@RequestMapping(value="updateComplete", method = RequestMethod.GET)
	public String update(SessionStatus status, @ModelAttribute("user")Blog_User user, Model model, HttpSession session){
		logger.info("회원정보 수정 성공 후 홈으로 돌아가기 시작");
		
		session.setAttribute("loginName", user.getUser_name());
		
		status.setComplete();
		
		logger.info("회원정보 수정 성공 후 홈으로 돌아가기 종료");
		
		return "redirect:/";
	}*/
	
	@RequestMapping(value="friendList", method = RequestMethod.GET)
	public String friendList(HttpSession session, Model model){
		logger.info("친구리스트 페이지 이동 시작");
		
		String user_id = (String)session.getAttribute("loginId");
		
		ArrayList<Friend> fList = dao1.selectFriendList(user_id);
		
		model.addAttribute("fList", fList);
		
		logger.info("친구리스트 페이지 이동 종료");
		return "friend/friendPage";
	}
	
	@RequestMapping(value="searchFriendId", method = RequestMethod.POST)
	public String searchFriendId(String user_id, Model model, HttpSession session){
		logger.info("친구id 조회 시작");
		
		ArrayList<Blog_User> list = dao1.searchFriendId(user_id);
		model.addAttribute("list", list);
		
		String user_id1 = (String)session.getAttribute("loginId");
		ArrayList<Friend> fList = dao1.selectFriendList(user_id1);
		model.addAttribute("fList", fList);
		
		logger.info("친구id 조회 종료");
		
		return "friend/friendPage";
	}
	
	@RequestMapping(value="insertFriend", method = RequestMethod.GET)
	public String insertFriend(String user_id, HttpSession session, Model model){
		logger.info("친구 추가 시작");
		
		String myId = (String)session.getAttribute("loginId");
		System.out.println(myId);
		
		Friend friend = new Friend();
		friend.setUser_id(myId);
		friend.setFriend_id(user_id);
		
		int result = dao1.insertFriendId(friend);
		
		if (result != 1) {
			logger.info("친구 추가 실패");
			model.addAttribute("errorMsg", "친구 추가 실패");
			return "friend/friendPage";
		}
		logger.info("친구 추가 종료");
		
		return "redirect:friendList";
	}
	
	@RequestMapping(value="message", method=RequestMethod.GET)
	public String message(){
		logger.info("쪽지함 페이지 이동");
		
		return "friend/message";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
