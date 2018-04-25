package lets.eat.cancho.post.vo;

public class Post {

	private int post_num;
	private String post_title;
	private String post_title_clean;
	private String post_file;
	private String user_id;
	private String originalfile;
	private String savedfile;
	private String post_date;
	private String post_like;
	private String post_dislike;
	
	public Post() {
		super();
	}

	public Post(int post_num, String post_title, String post_title_clean, String post_file, String user_id,
			String originalfile, String savedfile, String post_date, String post_like, String post_dislike) {
		super();
		this.post_num = post_num;
		this.post_title = post_title;
		this.post_title_clean = post_title_clean;
		this.post_file = post_file;
		this.user_id = user_id;
		this.originalfile = originalfile;
		this.savedfile = savedfile;
		this.post_date = post_date;
		this.post_like = post_like;
		this.post_dislike = post_dislike;
	}

	public int getPost_num() {
		return post_num;
	}

	public void setPost_num(int post_num) {
		this.post_num = post_num;
	}

	public String getPost_title() {
		return post_title;
	}

	public void setPost_title(String post_title) {
		this.post_title = post_title;
	}

	public String getPost_title_clean() {
		return post_title_clean;
	}

	public void setPost_title_clean(String post_title_clean) {
		this.post_title_clean = post_title_clean;
	}

	public String getPost_file() {
		return post_file;
	}

	public void setPost_file(String post_file) {
		this.post_file = post_file;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getOriginalfile() {
		return originalfile;
	}

	public void setOriginalfile(String originalfile) {
		this.originalfile = originalfile;
	}

	public String getSavedfile() {
		return savedfile;
	}

	public void setSavedfile(String savedfile) {
		this.savedfile = savedfile;
	}

	public String getPost_date() {
		return post_date;
	}

	public void setPost_date(String post_date) {
		this.post_date = post_date;
	}

	public String getPost_like() {
		return post_like;
	}

	public void setPost_like(String post_like) {
		this.post_like = post_like;
	}

	public String getPost_dislike() {
		return post_dislike;
	}

	public void setPost_dislike(String post_dislike) {
		this.post_dislike = post_dislike;
	}

	@Override
	public String toString() {
		return "Post [post_num=" + post_num + ", post_title=" + post_title + ", post_title_clean=" + post_title_clean
				+ ", post_file=" + post_file + ", user_id=" + user_id + ", originalfile=" + originalfile
				+ ", savedfile=" + savedfile + ", post_date=" + post_date + ", post_like=" + post_like
				+ ", post_dislike=" + post_dislike + "]";
	}

	

}
