package lets.eat.cancho.editor.util;

import java.awt.Dimension;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.awt.image.PixelGrabber;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;


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