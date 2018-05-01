package lets.eat.cancho.editor.vo;

public class editorVO {
	private String vid;
	private String frames;
	private String trim;
	private String vFname;
	private String type;
	private String frame;
	private String count;
	private String length;
	private String urls;
	private String imgPath;
	private String imgFrame;
	
	
	public String getImgPath() {
		return imgPath;
	}
	public void setImgPath(String imgPath) {
		this.imgPath = imgPath;
	}
	public String getImgFrame() {
		return imgFrame;
	}
	public void setImgFrame(String imgFrame) {
		this.imgFrame = imgFrame;
	}
	public String getUrls() {
		return urls;
	}
	public void setUrls(String urls) {
		this.urls = urls;
	}
	public String getLength() {
		return length;
	}
	public void setLength(String length) {
		this.length = length;
	}
	public String getFrame() {
		return frame;
	}
	public void setFrame(String frame) {
		this.frame = frame;
	}
	public String getVid() {
		return vid;
	}
	public void setVid(String vid) {
		this.vid = vid;
	}
	public String getFrames() {
		return frames;
	}
	public void setFrames(String frames) {
		this.frames = frames;
	}
	public String getTrim() {
		return trim;
	}
	public void setTrim(String trim) {
		this.trim = trim;
	}
	public String getvFname() {
		return vFname;
	}
	public void setvFname(String vFname) {
		this.vFname = vFname;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}	
	public String getCount() {
		return count;
	}
	public void setCount(String count) {
		this.count = count;
	}
	
	public editorVO(){
	}
	
	public editorVO(String vid, String frames, String trim, String vFname, String type, String frame, String count,
			String length, String urls, String imgPath, String imgFrame) {
		super();
		this.vid = vid;
		this.frames = frames;
		this.trim = trim;
		this.vFname = vFname;
		this.type = type;
		this.frame = frame;
		this.count = count;
		this.length = length;
		this.urls = urls;
		this.imgPath = imgPath;
		this.imgFrame = imgFrame;
	}
	@Override
	public String toString() {
		return "editorVO [vid=" + vid + ", frames=" + frames + ", trim=" + trim + ", vFname=" + vFname + ", type="
				+ type + ", frame=" + frame + ", count=" + count + "]";
	}
}
