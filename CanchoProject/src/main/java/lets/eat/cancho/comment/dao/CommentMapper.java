package lets.eat.cancho.comment.dao;

import java.util.ArrayList;

import lets.eat.cancho.comment.vo.Comment;

public interface CommentMapper {
	
	public int insertComment(Comment comment);
	
	public ArrayList<Comment> readComment(int post_num);
	
	public int deleteComment(int comment_num);
	
	public int updateComment(Comment comment);

	public ArrayList<Comment> commentList();
	
	public void deleteAllComment(int post_num);
	
}
