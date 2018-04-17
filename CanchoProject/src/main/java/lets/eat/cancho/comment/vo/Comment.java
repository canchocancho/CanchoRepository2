package lets.eat.cancho.comment.vo;

public class Comment {
	
    private int comment_num;
    private int post_num;
    private String comment_text;
    private String user_id;
    private String comment_date;
    
	public Comment() {
		super();
	}
	
	public Comment(int comment_num, int post_num, String comment_text, String user_id, String comment_date) {
		super();
		this.comment_num = comment_num;
		this.post_num = post_num;
		this.comment_text = comment_text;
		this.user_id = user_id;
		this.comment_date = comment_date;
	}
	
	public int getComment_num() {
		return comment_num;
	}
	public void setComment_num(int comment_num) {
		this.comment_num = comment_num;
	}
	public int getPost_num() {
		return post_num;
	}
	public void setPost_num(int post_num) {
		this.post_num = post_num;
	}
	public String getComment_text() {
		return comment_text;
	}
	public void setComment_text(String comment_text) {
		this.comment_text = comment_text;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getComment_date() {
		return comment_date;
	}
	public void setComment_date(String comment_date) {
		this.comment_date = comment_date;
	}
	
	@Override
	public String toString() {
		return "Comment [comment_num=" + comment_num + ", post_num=" + post_num + ", comment_text=" + comment_text
				+ ", user_id=" + user_id + ", comment_date=" + comment_date + "]";
	}

}
