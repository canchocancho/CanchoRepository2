package lets.eat.cancho.user.dao;

import lets.eat.cancho.user.vo.Blog_Profile;
import lets.eat.cancho.user.vo.Blog_User;

public interface UserMapper {
	
	//특정 회원 조회
	public Blog_User searchUserOne(String user_id);
	
	//회원등록
	public int joinUser(Blog_User user);
	
	//이메일 인증
	public int verifyUser(String user_id);
	
	//회원정보 수정
	public int updateUser(Blog_User user);

	//휴면 계정 전환
	public int deleteUser(String user_id);
	
	//계정 활성화
	public int activateUser(String user_id);
	
	//프로필 정보 등록
	public int writeProfile(Blog_Profile profile);
	
	//프로필 정보 조회
	public Blog_Profile readProfile(String user_id);
	
	//프로필 정보 수정
	public int updateProfile(Blog_Profile profile);
}
