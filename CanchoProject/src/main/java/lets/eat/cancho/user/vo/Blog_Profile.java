package lets.eat.cancho.user.vo;

public class Blog_Profile {
	
	private String user_id;
	private String user_email;
	private String p_birthDate;
	private String p_sex;
	private String p_city;
	private String p_country;
	private String p_company;
	private String p_school;
	private String p_introduce;
	private String p_originalfile;
	private String p_savedfile;
	
	public Blog_Profile() {
		super();
	}

	public Blog_Profile(String user_id, String user_email, String p_birthDate, String p_sex, String p_city,
			String p_country, String p_company, String p_school, String p_introduce, String p_originalfile,
			String p_savedfile) {
		super();
		this.user_id = user_id;
		this.user_email = user_email;
		this.p_birthDate = p_birthDate;
		this.p_sex = p_sex;
		this.p_city = p_city;
		this.p_country = p_country;
		this.p_company = p_company;
		this.p_school = p_school;
		this.p_introduce = p_introduce;
		this.p_originalfile = p_originalfile;
		this.p_savedfile = p_savedfile;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getUser_email() {
		return user_email;
	}

	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}

	public String getP_birthDate() {
		return p_birthDate;
	}

	public void setP_birthDate(String p_birthDate) {
		this.p_birthDate = p_birthDate;
	}

	public String getP_sex() {
		return p_sex;
	}

	public void setP_sex(String p_sex) {
		this.p_sex = p_sex;
	}

	public String getP_city() {
		return p_city;
	}

	public void setP_city(String p_city) {
		this.p_city = p_city;
	}

	public String getP_country() {
		return p_country;
	}

	public void setP_country(String p_country) {
		this.p_country = p_country;
	}

	public String getP_company() {
		return p_company;
	}

	public void setP_company(String p_company) {
		this.p_company = p_company;
	}

	public String getP_school() {
		return p_school;
	}

	public void setP_school(String p_school) {
		this.p_school = p_school;
	}

	public String getP_introduce() {
		return p_introduce;
	}

	public void setP_introduce(String p_introduce) {
		this.p_introduce = p_introduce;
	}

	public String getP_originalfile() {
		return p_originalfile;
	}

	public void setP_originalfile(String p_originalfile) {
		this.p_originalfile = p_originalfile;
	}

	public String getP_savedfile() {
		return p_savedfile;
	}

	public void setP_savedfile(String p_savedfile) {
		this.p_savedfile = p_savedfile;
	}

	@Override
	public String toString() {
		return "Blog_Profile [user_id=" + user_id + ", user_email=" + user_email + ", p_birthDate=" + p_birthDate
				+ ", p_sex=" + p_sex + ", p_city=" + p_city + ", p_country=" + p_country + ", p_company=" + p_company
				+ ", p_school=" + p_school + ", p_introduce=" + p_introduce + ", p_originalfile=" + p_originalfile
				+ ", p_savedfile=" + p_savedfile + "]";
	}
	
	
	

	
	
	
	
	
	
	
	
}
