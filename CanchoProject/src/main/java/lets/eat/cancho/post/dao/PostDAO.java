package lets.eat.cancho.post.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lets.eat.cancho.post.vo.Post;

@Repository
public class PostDAO {
	
	private static final Logger logger = LoggerFactory.getLogger(PostDAO.class);
	
	@Autowired
	SqlSession session;
	
	//포스트 작성
	public int writePost(Post post){
		
		logger.info("포스트 작성 시작");
		
		PostMapper mapper = session.getMapper(PostMapper.class);
		
		int result = 0;
		
		try{
			result = mapper.writePost(post);
			
		} catch(Exception e){
			e.printStackTrace();
		}

		return result;
	}
	
	//브이로그 작성
	public int writePost2(Post post){
		
		logger.info("브이로그 작성 시작");
		
		PostMapper mapper = session.getMapper(PostMapper.class);
		
		int result = 0;
		
		try{
			result = mapper.writePost2(post);
			
		} catch(Exception e){
			e.printStackTrace();
		}

		return result;
	}
	
	//포스트 목록
	public ArrayList<Post> postList(String user_id){
		
		logger.info("포스트 목록 불러오기");
		
		ArrayList<Post> list = new ArrayList<Post>();
		PostMapper mapper = session.getMapper(PostMapper.class);

		try{
			list = mapper.postList(user_id);
			
		} catch(Exception e){
			e.printStackTrace();
		}
		
		return list;
	}
	
	public ArrayList<Post> postListId(String user_id){
		
		logger.info("내 글 목록 불러오기");
		
		ArrayList<Post> list = new ArrayList<Post>();
		PostMapper mapper = session.getMapper(PostMapper.class);

		try{
			list = mapper.postListId(user_id);
			
		} catch(Exception e){
			e.printStackTrace();
		}
		
		return list;
	}
	
	//포스트 파일명 가져오기
	public String readPost(int post_num){
		
		logger.info("포스트 파일명 가져오기");
		
		PostMapper mapper = session.getMapper(PostMapper.class);
		
		String post_file = null;

		try{
			post_file = mapper.readPost(post_num);
			
		} catch(Exception e){
			e.printStackTrace();
		}
		
		return post_file;
	}
	
	//포스트 전체를 가져오기
	public Post bringPost(int post_num){
		
		logger.info("포스트 전체 가져오기");
		
		PostMapper mapper = session.getMapper(PostMapper.class);
		
		Post post = null;
		
		try{
			post = mapper.bringPost(post_num);
			
		} catch(Exception e){
			e.printStackTrace();
		}
		
		return post;
	}
	
	//포스트 좋아요
	public int updateLike(Post post){
		logger.info("좋아요 업데이트");
		
		int result = 0;
		PostMapper mapper = session.getMapper(PostMapper.class);

		try{
			result = mapper.updateLike(post);
			
		} catch(Exception e){
			e.printStackTrace();
		}
		
		return result;
	}
	
	//포스트 싫어요
		public int updateDislike(Post post){
			logger.info("싫어요 업데이트");
			
			int result = 0;
			PostMapper mapper = session.getMapper(PostMapper.class);

			try{
				result = mapper.updateDislike(post);
				
			} catch(Exception e){
				e.printStackTrace();
			}
			
			return result;
		}
		
	//포스트 삭제
	public int deletePost(int post_num){
			
		logger.info("포스트 삭제 시작");
			
		PostMapper mapper = session.getMapper(PostMapper.class);
			
		int result = 0;
			
		try{
				result = mapper.deletePost(post_num);
				
		} catch(Exception e){
			e.printStackTrace();
		}

		return result;
	}

}
