package lets.eat.cancho.friend.vo;

public class Friend {
	
	private String user_id;
	private String friend_id;
	
	public Friend() {
		super();
	}

	public Friend(String user_id, String friend_id) {
		super();
		this.user_id = user_id;
		this.friend_id = friend_id;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getFriend_id() {
		return friend_id;
	}

	public void setFriend_id(String friend_id) {
		this.friend_id = friend_id;
	}

	@Override
	public String toString() {
		return "Friend [user_id=" + user_id + ", friend_id=" + friend_id + "]";
	}
	
	
	
	
	
	

}
