package com.gph.saviorframework.util;

import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.text.DecimalFormat;

import javax.imageio.ImageIO;

public class FileCutUtil {
	public static byte[] UsercardCutUtil(byte[] ext) {
		try{
			ByteArrayOutputStream baos = new ByteArrayOutputStream();
			InputStream is = new ByteArrayInputStream(ext);
			BufferedImage sourceImage = ImageIO.read(is);
			
			int width = sourceImage.getWidth();  //原文件宽度
			int height = sourceImage.getHeight(); //原文件高度
			
			if(width > 400 || height > 400){
				DecimalFormat df = new DecimalFormat("0.000");
				double bili = 0.000;
				
				if(width > height){
					bili = Double.parseDouble(df.format(width/200.0));
				}else{
					bili = Double.parseDouble(df.format(height/200.0));
				}
				width = (int) (width / bili);
				height = (int) (height / bili);
			}
			
			BufferedImage src = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
			src.getGraphics().drawImage(sourceImage.getScaledInstance(width, height, Image.SCALE_SMOOTH), 0, 0, null);

			
			ImageIO.write(src, "jpeg", baos);
			is.close();
			return baos.toByteArray();
		}catch(Exception e){
			e.printStackTrace();
			return null;
		}
	}
}
