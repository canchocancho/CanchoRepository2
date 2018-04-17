package lets.eat.cancho.comment.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lets.eat.cancho.comment.dao.CommentDAO;
import lets.eat.cancho.comment.vo.Comment;

@Controller
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

}
