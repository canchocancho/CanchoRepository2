package lets.eat.cancho.user.controller;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;

import javax.inject.Inject;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import lets.eat.cancho.common.util.FileService;
import lets.eat.cancho.friend.dao.FriendDAO;
import lets.eat.cancho.post.dao.PostDAO;
import lets.eat.cancho.post.vo.Post;
import lets.eat.cancho.user.dao.UserDAO;
import lets.eat.cancho.user.vo.Blog_Profile;
import lets.eat.cancho.user.vo.Blog_User;

@Controller
@RequestMapping(value="user")
public class UserController {
	private static final Logger logger = LoggerFactory.getLogger(UserController.class);
	
	@Inject
	private JavaMailSender mailSender;
	
	@Autowired
	UserDAO dao;
	
	@Autowired
	PostDAO postDAO;
	
	@Autowired
	FriendDAO friendDAO;
	
	final String uploadPath = "/profilePicture";
	
	@RequestMapping(value="loginPage", method = RequestMethod.GET)
	public String loginPage(){
		logger.info("로그인 페이지 이동 시작");
		logger.info("로그인 페이지 이동 종료");
		return "user/loginPage";
	}
	
	@RequestMapping(value="login", method=RequestMethod.POST)
	public String login(HttpSession session, Blog_User user, Model model){
		
		logger.info("로그인 시작");
		Blog_User vo = dao.searchUserOne(user.getUser_id());
		
	    if(vo == null) {
		    //아이디가 없는 경우
	    	model.addAttribute("errorMsg", "존재하지 않는 아이디입니다.");
	    	logger.info("로그인 실패");
	    	return "user/loginPage";  
		 }
	    else if (!vo.getUser_password().equals(user.getUser_password())) {
			 //비밀번호가 틀린 경우
			 model.addAttribute("errorMsg", "비밀번호가 잘못되었습니다.");
			 logger.info("로그인 실패");
			 return "user/loginPage";
		}
	    else if (vo.getUser_deleted().equals("Y")){
	    	//탈퇴한 회원일 경우
	    	model.addAttribute("errorMsg", "휴면 계정입니다. 메인 페이지에서 계정을 복구해주세요.");
	    	logger.info("탈퇴한 회원");
	    	return "user/loginPage";  
	    }

	    String userVerified = (user != null) ? vo.getUser_verify() : "N";
	    
	    if(vo != null && userVerified.equals("Y")) {
				    	//E-mail 인증까지 모두 마친 로그인
						logger.info("User Login Success");
						session.setAttribute("loginId", vo.getUser_id());	// 로그인 성공시 User ID를 Session에 저장
						session.setAttribute("loginName", vo.getUser_name());
						session.setAttribute("loginEmail", vo.getUser_email());
						
						//로그인에 성공하면 그 즉시 자동으로 프로필을(있는 경우에) 불러온다
						logger.info("프로필 불러오기 시작");
						Blog_Profile user_profile = null;
						user_profile = dao.readProfile(vo.getUser_id());
						
						//프로필을 등록한 유저일 경우 세션으로 들고 다니기
						if(user_profile != null){
							session.setAttribute("profile", user_profile);
						}
						
						//타임라인에 표시할 자기랑 자기 친구들 포스팅들
						ArrayList<Post> postList = postDAO.postList(vo.getUser_id());
						session.setAttribute("postList", postList);
						model.addAttribute("postList", postList);
						
						//팔로워 수 불러오기
						logger.info("팔로워 수 불러오기");
						int follower = friendDAO.myFollower(vo.getUser_id());
						session.setAttribute("myFollower", follower);
						
				    	return "redirect:/";
				    	 
				      } else {
				    	//E-mail 인증이 되지 않은 로그인
					    model.addAttribute("errorMsg", "이메일 인증을 완료해주세요.");
					    logger.info("이메일 인증 미완료");
					    return "user/loginPage";
				      }
		}
	
	@RequestMapping(value="logout", method=RequestMethod.GET)
	public String logout(HttpSession session){
		logger.info("로그아웃 시작");
		
		session.invalidate();
		
		logger.info("로그아웃 종료");
		return "redirect:/";
	}
	
	@RequestMapping(value="joinForm", method= RequestMethod.GET)
	public String joinForm(Model model){
		logger.info("회원 가입 폼 시작");
		
		Blog_User user = new Blog_User();
		model.addAttribute("user", user);
		
		logger.info("회원 가입 폼 종료");
		return "user/joinForm"; 
	}
	
	@ResponseBody
	@RequestMapping(value="idCheck", method=RequestMethod.GET)
	public boolean idCheck(String user_id){
		
		logger.info("아이디 중복 검사 시작");
		boolean flag = false;
		
		Blog_User user = dao.searchUserOne(user_id);
		
		logger.info("아이디 중복 검사 종료");

		if(user != null){
			return flag; 
		}else{
			flag = true;
			return flag;
		}
	}
	
	@RequestMapping(value="join", method=RequestMethod.POST)
	public String join(Blog_User user, Model model) throws
		MessagingException, UnsupportedEncodingException {
		logger.info("회원 가입 시작");
		
		//관리자 계정
		String admin = "canchoad@gmail.com";
		
		//Server Address
		String serverAddress = "http://10.10.15.149:8888/cancho/";
		
		logger.info(user.toString());
		int result = dao.joinUser(user);
		
		if (result == 1) {
			//인증을 위한 E-mail을 보내는 부분		
		    MimeMessage message = mailSender.createMimeMessage();
		    MimeMessageHelper messageHelper 
		                      = new MimeMessageHelper(message, true, "UTF-8");
		 
		    messageHelper.setFrom(admin);  					//보내는 사람 (생략 시 정상작동 안 함)
		    messageHelper.setTo(user.getUser_email());     	//받는 사람 이메일
		    messageHelper.setSubject("[이메일 인증]"); 			//메일 제목(생략 가능)
		    messageHelper.setText(							//메일 내용
		    		  new StringBuffer().append("메일인증 \n")
						.append("Cancho에 가입해주셔서 감사합니다. \n"
								+ serverAddress + "user/verify?user_id="
								+ user.getUser_id())
						.append("\n이메일 인증 확인").toString());	
			 try {
				 //메일 보내기
			      mailSender.send(message);
			 }
			 catch(MailException e){
			      e.printStackTrace();
			 }
		 
			logger.info("User Join Success");
		} 
		else {
			logger.info("User Join Fail");
			model.addAttribute("errorMsg", "알 수 없는 에러가 발생하였습니다.");
			return "redirect:/";
		}
		
		return "redirect:joinComplete";
	}
	
	/*
	 * @comment			: 인증 받은 회원의 EmailVerify 속성을 'Y'로 변경한다.
	 * @param	userid	: E-mail 인증을 받은 회원의 ID
	 * @author			: 
	 */
	@RequestMapping(value = "verify", method = RequestMethod.GET)
	public String verifySuccess(@RequestParam String user_id) {
		
		logger.info("E-mail Verify");
		logger.debug("userID : {}", user_id);
		
		int result = dao.verifyUser(user_id);
		
		if(result == 1) {
			logger.info("E-mail Verify Success");
		}
		else {
			logger.info("E-mail Verify Fail");
		}
		return "redirect:/";
	}
	
	@RequestMapping(value="joinComplete", method=RequestMethod.GET)
	public String joinComplete(){

		return "user/joinComplete";
	}
	
	@RequestMapping(value="deletePage", method=RequestMethod.GET)
	public String deletePage(HttpSession session){
		
		return "user/deleteForm";
	}
	
	@RequestMapping(value="deleteAccount", method=RequestMethod.POST)
	public String deleteAccount(HttpSession session, String password, Model model){
		
		String user_id = (String) session.getAttribute("loginId");
		
		Blog_User user = dao.searchUserOne(user_id);

		//입력한 비밀번호가 틀렸을 경우
		if(!password.equals(user.getUser_password())){
			model.addAttribute("errorMsg", "비밀번호를 잘못 입력하셨습니다.");
			return "user/deleteForm";
		}
		
		int result = dao.deleteUser(user_id);
		
		//비밀번호는 제대로 입력했는데 오류가 일어나 탈퇴 실패
		if(result != 1){
			model.addAttribute("errorMsg", "알 수 없는 오류가 발생하였습니다.");
			return "user/deleteForm";
		}
		
		//탈퇴했으니 세션 끊기
		session.invalidate();
		
		return "redirect:deleteComplete";
	}
	
	@RequestMapping(value="deleteComplete", method=RequestMethod.GET)
	public String deleteComplete(){
		
		return "user/deleteComplete";
	}
	
	@RequestMapping(value="activateForm", method=RequestMethod.GET)
	public String activateForm(){
		
		return "user/activateForm";
	}
	
	@RequestMapping(value="activate", method=RequestMethod.POST)
	public String activate(Blog_User user, Model model){
		
		Blog_User deleted_user = dao.searchUserOne(user.getUser_id());
		
		//아예 가입된 회원이 아닐 경우
		if(deleted_user == null){
			model.addAttribute("errorMsg", "해당 아이디로 가입된 이력이 없습니다.");
			return "user/activateForm";
		}
		
		//가입은 되어 있는데 휴면계정이 아닐 경우
		else if(!deleted_user.getUser_deleted().equals("Y")){
			model.addAttribute("errorMsg", "휴면 계정이 아닙니다.");
			return "user/activateForm";
		}
		
		//휴면계정인데 비밀번호가 틀렸을 경우
		else if(!user.getUser_password().equals(deleted_user.getUser_password())){
			model.addAttribute("errorMsg", "비밀번호가 틀렸습니다.");
			return "user/activateForm";
		}
		
		//activate 성공
		else {
			int result = dao.activateUser(user.getUser_id());
			
			if(result == 1) {
				logger.info("계정 활성화 성공");
			}
			else {
				model.addAttribute("errorMsg", "알 수 없는 오류가 발생하였습니다.");
				return "user/activateForm";
			}
			
			return "user/activated";
		}
	}
	
	@RequestMapping(value="editProfile", method=RequestMethod.GET)
	public String editProfile(HttpSession session, Model model){
		String id = (String)session.getAttribute("loginId");
		Blog_User user = dao.searchUserOne(id);
		
		model.addAttribute("user", user);
		return "user/editProfile";
	}
	
	//save profile
	@RequestMapping(value="saveProfile", method=RequestMethod.POST)
	public String saveData(Blog_Profile profile,HttpSession session, Model model, MultipartFile upload){
		
		//최초저장인지 수정인지 판별해야 함
		Blog_Profile searchProfile = dao.readProfile(profile.getUser_id());
		
		//최초저장일 경우
		if(searchProfile == null){
			logger.info("saveProfile");

	        if(!upload.isEmpty()){
				//첨부파일이 있는 경우
				//Post 객체에 originalFileName과 savedfileName을 저장
				String savedfile = FileService.saveFile(upload, uploadPath); //저장된 파일명
				profile.setP_savedfile(savedfile);
				profile.setP_originalfile(upload.getOriginalFilename());
			}
	        
			int result = dao.writeProfile(profile);
			
			if(result != 1){
				//등록실패
				model.addAttribute("errorMsg", "필수정보는 모두 기입해주세요.");
				logger.info("프로필 저장 실패");
				
				return "user/editProfile";
			}
			
			logger.info("프로필 저장 종료");
			session.setAttribute("profile", profile);

			return "redirect:/user/myPage";
		}
		
		//수정일 경우
		else {
			logger.info("updateProfile");
			
	        if(!upload.isEmpty()){
				//새 첨부파일이 있는 경우
				//Post 객체에 originalFileName과 savedfileName을 저장
				String savedfile = FileService.saveFile(upload, uploadPath); //저장된 파일명
				profile.setP_savedfile(savedfile);
				profile.setP_originalfile(upload.getOriginalFilename());
			}
	        
	        //첨부파일이 없는 경우(프사 그대로)
	        else{
	        	Blog_Profile fProfile = dao.readProfile(profile.getUser_id()); //원래 프로필 불러오기
	        	profile.setP_savedfile(fProfile.getP_savedfile()); //원래 프로필에서 원래 프사 정보 불러와서 받아온 form에 넣어주기
	        	profile.setP_originalfile(fProfile.getP_originalfile()); //같은 사진을 update와 같음
	        }
	        
	        int result = dao.updateProfile(profile);
	        
	        if(result != 1){
	        	model.addAttribute("errorMsg", "필수정보는 모두 기입해주세요.");
	        	logger.info("프로필 업데이트 실패");
	        	
	        	return "user/editProfile";
	        }
	        
	        Blog_Profile newProfile = dao.readProfile(profile.getUser_id());
	        
	        logger.info("프로필 수정 종료");
	        session.setAttribute("profile", newProfile);
	        
	        return "redirect:/user/myPage";
		}
	}
	
	//contact 페이지로 이동
	@RequestMapping(value="contact", method = RequestMethod.GET)
	public String contact(HttpSession session){

		return "user/contact";
	}
	
	
}
