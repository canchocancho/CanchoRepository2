package lets.eat.cancho.editor.vo;

public class FrameVO implements Comparable<FrameVO>{
	
	private String startFrame;
	private String endFrame;
	private int folderNum;
	private String fileName;
	private int frame;
	



	public FrameVO(){}



	public FrameVO(String startFrame, String endFrame, int folderNum, String fileName, int frame) {
		super();
		this.startFrame = startFrame;
		this.endFrame = endFrame;
		this.folderNum = folderNum;
		this.fileName = fileName;
		this.frame = frame;
	}










	public int getFrame() {
		return frame;
	}



	public void setFrame(int frame) {
		this.frame = frame;
	}



	public String getStartFrame() {
		return startFrame;
	}

	public void setStartFrame(String startFrame) {
		this.startFrame = startFrame;
	}

	public String getEndFrame() {
		return endFrame;
	}

	public void setEndFrame(String endFrame) {
		this.endFrame = endFrame;
	}



	public int getFolderNum() {
		return folderNum;
	}



	public void setFolderNum(int folderNum) {
		this.folderNum = folderNum;
	}
	
	
	
	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	@Override
	public int compareTo(FrameVO f) {
		if(this.frame < f.getFrame()){
			return -1;
		}else if(this.frame > f.getFrame()){
			return 1;
		}
		return 0;
	}



	@Override
	public String toString() {
		return "FrameVO [startFrame=" + startFrame + ", endFrame=" + endFrame + ", folderNum=" + folderNum
				+ ", fileName=" + fileName + ", frame=" + frame + "]";
	}

	



}
