package lets.eat.cancho.friend.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lets.eat.cancho.friend.vo.Friend;
import lets.eat.cancho.user.vo.Blog_User;

@Repository
public class FriendDAO {
	
private static final Logger logger = LoggerFactory.getLogger(FriendDAO.class);
	
	@Autowired
	SqlSession sqlSession;
	
	//친구 ID 조회
	public ArrayList<Blog_User> searchFriendId(String user_id){
		
		logger.info("친구ID 조회 시작 - 다오");
		
		ArrayList<Blog_User> list = null;
		FriendMapper mapper = sqlSession.getMapper(FriendMapper.class);
			
		try{
			list = mapper.searchFriendId(user_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
			
		logger.info("친구ID 조회 종료 - 다오");
		
		System.out.println(list);
		
		return list;
	}
	
	//친구 ID 추가
	public int insertFriendId(Friend friend){
		logger.info("친구 추가 시작 - 다오");
		
		int result = 0;
		FriendMapper mapper = sqlSession.getMapper(FriendMapper.class);
			
		try{
			result = mapper.insertFriendId(friend);
		} catch (Exception e) {
			e.printStackTrace();
		}
			
		logger.info("친구 추가 종료 - 다오");
		
		return result;
	}
	
	//전체 친구 목록 불러오기
	public ArrayList<Friend> selectFriendList(String user_id){
		logger.info("전체 친구 목록 불러오기 시작 - 다오");
		
		ArrayList<Friend> list = null;
		FriendMapper mapper = sqlSession.getMapper(FriendMapper.class);
			
		try{
			list = mapper.selectFriendList(user_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
			
		logger.info("전체 친구 목록 불러오기 종료 - 다오");
		
		return list;
	}
	
	//친구 삭제
	public int deleteFriend(String friend_id){
		logger.info("친구 삭제 시작 - 다오");
			
		int result = 0;
		FriendMapper mapper = sqlSession.getMapper(FriendMapper.class);
				
		try{
			result = mapper.deleteFriend(friend_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
				
		logger.info("친구 삭제 종료 - 다오");
			
		return result;
	}
	
	//팔로워 수 조회
	public int myFollower(String user_id){
		logger.info("팔로워 조회 시작");
		
		int result = 0;
		FriendMapper mapper = sqlSession.getMapper(FriendMapper.class);
		
		try{
			result = mapper.myFollower(user_id);
		} catch(Exception e){
			e.printStackTrace();
		}
		
		logger.info("팔로워 조회 종료");
		
		return result;
	}
	
}
