package lets.eat.cancho.comment.dao;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lets.eat.cancho.comment.vo.Comment;

@Repository
public class CommentDAO {

	private static final Logger logger = LoggerFactory.getLogger(CommentDAO.class);
	
	@Autowired
	SqlSession session;
	
	public void insertComment(Comment comment){
		
		logger.info("댓글 달기 시작");
		
		CommentMapper mapper = session.getMapper(CommentMapper.class);
		
		try{
			mapper.insertComment(comment);
			
		} catch(Exception e){
			e.printStackTrace();
		}
		
		logger.info("댓글 달기 종료");
	}
	
	
}
