package lets.eat.cancho.comment.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;

import lets.eat.cancho.comment.dao.CommentDAO;
import lets.eat.cancho.comment.vo.Comment;

@Controller
@RequestMapping(value="post")
@SessionAttributes("post")
public class CommentController {
	
	@Autowired
	CommentDAO dao;
	
	@RequestMapping(value="insertComment", method=RequestMethod.POST)
	public String insertComment(HttpSession session, Comment comment){
		
		String user_id = (String) session.getAttribute("loginId");
		comment.setUser_id(user_id);
		
		dao.insertComment(comment);
		
		return "redirect:readOnePost?post_num="+comment.getPost_num();
	}
	
	@RequestMapping(value="deleteComment", method=RequestMethod.GET)
	public String deleteComment(int comment_num, int post_num, HttpSession session){
		
		dao.deleteComment(comment_num);		
		
		return "redirect:readOnePost?post_num="+post_num;
	}
	
	@RequestMapping(value="updateComment", method=RequestMethod.POST)
	public String updateComment(int comment_num, String comment_text, int post_num, HttpSession session){
		
		Comment comment = null;
		comment.setComment_num(comment_num);
		comment.setComment_text(comment_text);
		
		dao.updateComment(comment);
		
		return "redirect:readOnePost?post_num="+post_num;
	}

}
