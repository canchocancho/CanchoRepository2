package lets.eat.cancho.post.dao;

import java.util.ArrayList;

import lets.eat.cancho.post.vo.Post;

public interface PostMapper {

	public int writePost(Post post);
	public int writePost2(Post post);
	public ArrayList<Post> postList(String user_id);
	public ArrayList<Post> postListId(String user_id);
	public String readPost(int post_num);
	public Post bringPost(int post_num);
	public int updateLike(Post post);
	public int updateDislike(Post post);
	public int deletePost(int post_num);
	
}
