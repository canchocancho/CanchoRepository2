package lets.eat.cancho.editor.util;

import java.io.File;

public class test {
	
	public static int findFileNum(String path) {
		File file = new File(path);
		File[] files = file.listFiles();
		return files.length;
	}
	
	public static int findFilelength(String path) {
		File file = new File(path);
		File[] files = file.listFiles();
		int fileLength = files[0].toString().length();
		return fileLength;
	}

}