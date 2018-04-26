package lets.eat.cancho.comment.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;

import lets.eat.cancho.comment.dao.CommentDAO;
import lets.eat.cancho.comment.vo.Comment;
import lets.eat.cancho.user.controller.UserController;

@Controller
@RequestMapping(value="post")
@SessionAttributes("post")
public class CommentController {
	
	private static final Logger logger = LoggerFactory.getLogger(UserController.class);
	
	@Autowired
	CommentDAO dao;
	
	@RequestMapping(value="insertComment", method=RequestMethod.POST)
	public String insertComment(HttpSession session, Comment comment){
		
		logger.info("댓글 작성 시작");

		String user_id = (String) session.getAttribute("loginId");
		comment.setUser_id(user_id);
		int post_num = comment.getPost_num();
		
		dao.insertComment(comment);

		logger.info("댓글 작성 종료");
		
		return "redirect:readOnePost?post_num="+post_num;
	}
	
	@RequestMapping(value="deleteComment", method=RequestMethod.GET)
	public String deleteComment(int comment_num, int post_num, HttpSession session){
		
		logger.info("댓글 삭제 시작");
		
		dao.deleteComment(comment_num);
		
		logger.info("댓글 삭제 종료");
		
		return "redirect:readOnePost?post_num="+post_num;
	}
	
	@RequestMapping(value="updateComment", method=RequestMethod.POST)
	public String updateComment(Comment comment, HttpSession session){

		dao.updateComment(comment);
		
		return "redirect:readOnePost?post_num="+comment.getPost_num();
	}
	
}
