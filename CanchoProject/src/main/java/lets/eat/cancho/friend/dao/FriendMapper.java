package lets.eat.cancho.friend.dao;

import java.util.ArrayList;

import lets.eat.cancho.friend.vo.Friend;
import lets.eat.cancho.user.vo.Blog_User;

public interface FriendMapper {
	
	//친구 id 검색
	public ArrayList<Blog_User> searchFriendId(String user_id);
	
	//친구 추가
	public int insertFriendId(Friend friend);
	
	//전체 친구 목록 불러오기
	public ArrayList<Friend> selectFriendList(String user_id);
	
	//친구 삭제
	public int deleteFriend(String friend_id);
	
	//팔로워 수 조회
	public int myFollower(String user_id);
}
