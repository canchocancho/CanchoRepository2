package lets.eat.cancho.post.controller;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.inject.Inject;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;

import lets.eat.cancho.HomeController;
import lets.eat.cancho.comment.dao.CommentDAO;
import lets.eat.cancho.comment.vo.Comment;
import lets.eat.cancho.common.util.FileService;
import lets.eat.cancho.post.dao.PostDAO;
import lets.eat.cancho.post.vo.Post;
import lets.eat.cancho.user.dao.UserDAO;
import lets.eat.cancho.user.vo.Blog_Profile;

@Controller
@RequestMapping(value="post")
@SessionAttributes("post")
public class PostController {
	
	@Inject
	private JavaMailSender mailSender;
	
	@Autowired
	PostDAO dao;
	
	@Autowired
	CommentDAO commentDAO;
	
	@Autowired
	UserDAO userDAO;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	final String uploadPath = "/postfile";
	final String uploadPath2 = "/profilePicture";
	
	@RequestMapping(value="writePost", method=RequestMethod.GET)
	public String writePost(HttpSession session){
		logger.info("POST");
		
		return "post/postForm";
	}
	
	@RequestMapping(value="write", method=RequestMethod.POST)
	public String saveData(String post_title, String hidden_data, String user_id,
			HttpSession session, Model model, MultipartFile upload){
		
		logger.info("WRITE");
		
        Date date = new Date(); 
        SimpleDateFormat simpleDate = new SimpleDateFormat("_yyMMdd_hhmmss_");
        String finalDate = simpleDate.format(date);

		//String loginId = (String)session.getAttribute("loginId");	
        String loginId = user_id;
        String randomName = loginId+finalDate+Math.random();
        String fileName = "C:\\canchocancho\\"+randomName+".txt";
        
        Post post = new Post();
        post.setPost_title(post_title);
        post.setPost_file(fileName);
        post.setUser_id(loginId);

        if(!upload.isEmpty()){
			//첨부파일이 있는 경우
			//Post 객체에 originalFileName과 savedfileName을 저장
			String savedfile = FileService.saveFile(upload, uploadPath); //저장된 파일명
			post.setSavedfile(savedfile);
			post.setOriginalfile(upload.getOriginalFilename());
		}
        
        try{
            //BufferedWriter 와 FileWriter를 조합하여 사용 (속도 향상)
            BufferedWriter fw = new BufferedWriter(new FileWriter(fileName, true));
             
            //파일 안에 문자열 쓰기
            fw.write(hidden_data);
            fw.flush();
 
            //객체 닫기
            fw.close();
            
        }catch(Exception e){
            e.printStackTrace();
        }
        
		int result = dao.writePost(post);
		
		if(result != 1){
			//등록실패
			model.addAttribute("errorMsg", "오류가 발생했습니다.");
			logger.info("포스팅 실패");
			
			return "post/postForm";
		}
		
		logger.info("포스팅 종료");
		
		ArrayList<Post> postList = dao.postList(loginId);
		session.setAttribute("postList", postList);

		return "redirect:/";
	}
	
	//마이페이지 가기(내 글만 조회)
	@RequestMapping(value="postList", method=RequestMethod.GET)
	public String postList(HttpSession session, Model model){
		logger.info("POST LIST");
		
		String user_id = (String) session.getAttribute("loginId");
		
		ArrayList<Post> mypostList = dao.postListId(user_id);
		
		model.addAttribute("mypostList", mypostList); //포스트 리스트 담기
		
		return "post/postList";
	}
	
	@RequestMapping(value="readOnePost", method=RequestMethod.GET)
	public String readOnePost(HttpSession session, int post_num, Model model){
		logger.info("READ POST");
		
		//포스트 번호에 해당하는 파일명 가져오기(파일명을 직접 가져와도 되긴 하는데 그럼 너무 길어짐)
		String post_file = dao.readPost(post_num);
		String result = null;
		
		Post post = dao.bringPost(post_num);
		ArrayList<Comment> commentList = commentDAO.readComment(post_num);
		
		try {
			//파일에서 스트림을 통해 주르륵 읽어들인다
			BufferedReader fr = new BufferedReader(new FileReader(post_file));
			
			String line;

			while ((line = fr.readLine()) != null) {
				result = line;
			      }
			
			      fr.close();
			      } catch(Exception e) {
			    	  e.printStackTrace();
			      }
		
		model.addAttribute("postText", result);
		model.addAttribute("post", post);
		model.addAttribute("commentList", commentList);
		
		return "post/readPost";
	}
	
	/*표지 만들기*/
	@RequestMapping(value="makeCoverForm", method=RequestMethod.GET)
	public String makeCoverForm(Model model){
		
		logger.info("표지 만들기");

		return "post/coverForm";
	}
	
	/*이미지 다운로드*/
	@RequestMapping(value="download", method=RequestMethod.GET)
	   public void fileDownload(int post_num, HttpServletResponse response){
		
	      Post post = dao.bringPost(post_num);
	 
	      String originalfile = post.getOriginalfile();
	      
	      try{
	         response.setHeader("Content-Disposition", "attachment;filename="
	               + URLEncoder.encode(originalfile, "UTF-8"));
	      } catch (UnsupportedEncodingException e) {
	         e.printStackTrace();
	      }
	      
	      String fullPath = uploadPath + "/" + post.getSavedfile();
	      
	      FileInputStream fis = null; 
	      ServletOutputStream sos = null;
	      
	      try{
	         fis = new FileInputStream(fullPath);
	         sos = response.getOutputStream(); 
	         
	         FileCopyUtils.copy(fis, sos); 
	         
	         fis.close();
	         sos.close();
	      } catch (IOException e) {
	         e.printStackTrace();
	      }
	   }
	
	/*프사 다운로드*/
	@RequestMapping(value="downloadPic", method=RequestMethod.GET)
	   public void downloadPic(String user_id, HttpServletResponse response){
		
		  Blog_Profile profile = userDAO.readProfile(user_id);
	 
	      String originalfile = profile.getP_originalfile();
	      
	      try{
	         response.setHeader("Content-Disposition", "attachment;filename="
	               + URLEncoder.encode(originalfile, "UTF-8"));
	      } catch (UnsupportedEncodingException e) {
	         e.printStackTrace();
	      }
	      
	      String fullPath = uploadPath2 + "/" + profile.getP_savedfile();
	      
	      FileInputStream fis = null; 
	      ServletOutputStream sos = null;
	      
	      try{
	         fis = new FileInputStream(fullPath);
	         sos = response.getOutputStream(); 
	         
	         FileCopyUtils.copy(fis, sos); 
	         
	         fis.close();
	         sos.close();
	      } catch (IOException e) {
	         e.printStackTrace();
	      }
	   }
	
	//좋아요
	@RequestMapping(value="postLike", method=RequestMethod.GET)
	public String postLike(Post post, Model model, HttpSession session){
		
		logger.info("포스트 좋아요");
		System.out.println(post.getUser_id());
		System.out.println(post.getPost_num());
		
		dao.updateLike(post);
		
		ArrayList<Post> postList = dao.postList(post.getUser_id());
		session.setAttribute("postList", postList);
		model.addAttribute("postList", postList);
		
		return "redirect:/";
		
	}
	
	//싫어요
	@RequestMapping(value="postDislike", method=RequestMethod.GET)
	public String postDislike(Post post, Model model, HttpSession session){
			
		logger.info("포스트 좋아요");
		System.out.println(post.getUser_id());
		System.out.println(post.getPost_num());
			
		dao.updateDislike(post);
			
		ArrayList<Post> postList = dao.postList(post.getUser_id());
		session.setAttribute("postList", postList);
		model.addAttribute("postList", postList);
			
		return "redirect:/";
			
	}
	
	//초대하기
	@RequestMapping(value="invite", method=RequestMethod.POST)
	public String invite(String user_id, String url, String friend_id, Model model) throws
	MessagingException, UnsupportedEncodingException {
		
		logger.info("초대 시작");
		
		String email = userDAO.searchUserOne(friend_id).getUser_email(); //초대받을 사람 이메일
		
				//관리자 계정
				String admin = "canchoad@gmail.com";

				//인증을 위한 E-mail을 보내는 부분		
				MimeMessage message = mailSender.createMimeMessage();
				MimeMessageHelper messageHelper 
				                      = new MimeMessageHelper(message, true, "UTF-8");
				 
				    messageHelper.setFrom(admin);  					//보내는 사람 (생략 시 정상작동 안 함)
				    messageHelper.setTo(email);     	//받는 사람 이메일
				    messageHelper.setSubject("[포스팅 초대]"); 			//메일 제목(생략 가능)
				    messageHelper.setText(							//메일 내용
				    		  new StringBuffer().append("포스팅 초대가 도착했어요! \n")
								.append(user_id+"님으로부터 포스팅 초대를 받았습니다. \n"
										+ url)
								.append("\n지금 당장 해당 주소로 들어오세요.").toString());	
					 try {
						 //메일 보내기
					      mailSender.send(message);
					 }
					 catch(MailException e){
					      e.printStackTrace();
					 }

		model.addAttribute("errorMsg", "친구에게 초대 메일을 발송하였습니다.");
					 
		return "post/postForm";
	}
	
	@RequestMapping(value="deletePost", method=RequestMethod.GET)
	public String deletePost(int post_num, HttpSession session){
		
		logger.info("포스트 삭제 시작");
		
		//글을 삭제하기 전에 딸린 댓글들을 다 지워야 함
		commentDAO.deleteAllComment(post_num);
		dao.deletePost(post_num);
		
		ArrayList<Post> postList = dao.postList((String)session.getAttribute("loginId"));
		session.setAttribute("postList", postList);
		
		logger.info("포스트 삭제 완료");
		
		return "redirect:../";
	}
	
	
	@RequestMapping(value="write2", method=RequestMethod.POST)
	public String write2(HttpSession session, Model model, MultipartFile upload){
		
		logger.info("WRITE VIDEO");

		String loginId = (String)session.getAttribute("loginId");	
        
        Post post = new Post();
        post.setUser_id(loginId);
			//첨부파일이 있는 경우
			//Post 객체에 originalFileName과 savedfileName을 저장
			String savedfile = FileService.saveFile(upload, uploadPath); //저장된 파일명
			post.setSavedfile(savedfile);
			post.setOriginalfile(upload.getOriginalFilename());
        
		int result = dao.writePost2(post);
		
		if(result != 1){
			//등록실패
			model.addAttribute("errorMsg", "오류가 발생했습니다.");
			logger.info("포스팅 실패");
			
			return "editor";
		}
		
		logger.info("포스팅 종료");
		
		ArrayList<Post> postList = dao.postList(loginId);
		session.setAttribute("postList", postList);

		return "redirect:/";
	}
	

}
